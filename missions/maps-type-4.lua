local co = require '../lib/co'
local c = coroutine
local stepLabel = require '../utils/step-label'
local makeAction = (require './utils').makeAction
local sleepPromise = require '../utils/sleep-promise'
local moBattle = require '../meta-operation/battle'
local moHome = require '../meta-operation/home'
local moMap = require '../meta-operation/maps-options/index'
local setScreenListeners = (require './utils').setScreenListeners
local store = require '../store'

-- type2 的过程：先让道中队走到 boss 点前，再让道中队走到 boss 队前，最后 boss 队打 boss

-- 设置  store 的默认值
store.mapType4 = store.mapType4 or {
  selectFleedCount = 0,
  isBossFleetInBossArea = false,
  battleNum = 0,
  battleWithConvoyNum = 0,
  battleFromState = '',
  checkpositionListForCheck = nil,
  checkpositionListForMove = {},
  oldMapChessboard = nil,
  mapChessboard = {},
  currentPosition = nil,
  nextStepPoint = nil,
  nextStepFleed = nil,
  moveVectorForAStep = { -1, -1 },
  moveFailTimes = 0,
}

-- maps-type2 的行动流程
local missionStepList = {
  'onWayFleetMoveToWaitBoss',
  'onWayFleetMoveToBossFleet',
  'onWayFleetMoveToClosestEnemy',
  'bossFleetMoveToWaitBoss',
  'bossFleetMoveToBoss',
  'randomMoveAStep',
}

local o = {
  home = moHome,
  battle = moBattle,
  map = moMap,
}

local comparePoints = function(point1, point2)
  if type(point1) ~= 'table' or type(point2) ~= 'table' then
    local info = debug.getinfo(2, 'Sl')
    local lineInfo = ''
    if info.currentline then
      lineInfo = info.source .. ': ' .. info.currentline .. ':\n'
    end
    if type(point1) ~= 'table' then
      lineInfo = lineInfo .. '\n bad argument #1 "point1"(table excepted, got ' .. type(point1) .. ')'
    end
    if type(point2) ~= 'table' then
      lineInfo = lineInfo .. '\n bad argument #2 "point2"(table excepted, got ' .. type(point2) .. ')'
    end
    error(lineInfo)
  end
  return point1[1] == point2[1] and point1[2] == point2[2]
end


local battleListenerList = {
  { '', o.home.isHome, 2000 },
  { 'MAPS_TYPE_4_PAGE_AMBUSHED_PANEL_AVOID_AMBUSHED', o.battle.isAmbushedPanel, 2000 },
  { 'BATTLE_BATTLE_CHAPTER_PAGE_BACK_TO_HOME', o.battle.isBattleChapterPage, 2000 },
  { 'BATTLE_BATTLE_CHAPTER_PAGE_INFO_PANEL_CLICK_INTO', o.battle.isChapterInfoPanel, 2000 },
  { 'BATTLE_BATTLE_CHAPTER_PAGE_SELECT_FLEET_PANEL_SELECT_FLEET', o.battle.isSelectFleetPanel, 2000 },
  { 'BATTLE_BATTLE_CHAPTER_PAGE_HARD_SELECT_FLEET_PANEL_CLICK_INTO', o.battle.isHardSelectFleetPanel, 500 },
  { 'BATTLE_MAP_PAGE', o.battle.isMapPage, 2000 },
  { 'BATTLE_MAP_PAGE_CLOSE_FORMAT_PANEL', o.battle.isFormationPanel, 2000 },
  { 'BATTLE_READY_BATTLE_PAGE_CLICK_BATTLE', o.battle.isReadyBattlePage, 2000 },
  { 'BATTLE_IN_BATTLE_PAGE', o.battle.isInBattlePage, 2000 },
  { 'BATTLE_VICTORY_PAGE', o.battle.isVictoryPanel, 2000 },
  { 'BATTLE_GET_PROPS_PANEL', o.battle.isGetPropsPanel, 2000 },
  { 'BATTLE_GET_NEW_SHIP_PANEL', o.battle.isGetNewShipPanel, 2000 },
  { 'BATTLE_GET_EXP_PANEL', o.battle.isGetExpPanel, 2000 },
}

local mapsType2 = function(action)
  local settings = store.settings;
  local mapProxy = o.map['map' .. settings.battleChapter.name]
  return co(c.create(function()
    if action.type == 'MAPS_TYPE_4_PRE_INIT' then

      -- 这部分流程只会在每次开启新的一局时才调用一次，而不是每次寻路就调用一次

      stepLabel.setStepLabelContent('3-1.开局预备变量')
      store.mapType4.selectFleedCount = 0
      -- boss舰队是否在boss区域
      store.mapType4.battleNum = 0
      store.mapType4.battleWithConvoyNum = 0
      store.mapType4.battleFromState = ''
      -- 切换船的次数，如果超过4次没切换成功表示舰队沉了。
      store.mapType4.changeFleetNum = 0
      -- 舰队移动的状态。
      store.mapType4.missionStep = 'onWayFleetMoveToWaitBoss'
      store.mapType4.currentPosition = nil
      -- 下一步行动的目标位置
      store.mapType4.nextStepPoint = nil
      -- 下一步行动的舰队，当前为 nil 'onWay' 或者 'boss'
      store.mapType4.nextStepFleed = nil
      store.mapType4.moveVectorForAStep = { -1, -1 }
      store.mapType4.moveFailTimes = 0

      return makeAction('')

    elseif action.type == 'MAPS_TYPE_4_INIT' then

      -- 每次进入地图页面时就会执行一次
      -- 切换船的次数，如果超过4次没切换成功表示舰队沉了。
      store.mapType3.changeFleetNum = 0
      -- 舰队移动的状态。
      store.mapType3.missionStep = 'onWayFleetMoveToWaitBoss'
      store.mapType3.currentPosition = nil
      -- 下一步行动的目标位置
      store.mapType3.nextStepPoint = nil
      -- 下一步行动的路径
      store.mapType2.nextStepPath = nil
      -- 下一步行动的舰队，当前为 nil 'onWay' 或者 'boss'
      store.mapType3.nextStepFleed = nil
      store.mapType4.moveVectorForAStep = { -1, -1 }
      store.mapType4.moveFailTimes = 0
      return makeAction('MAPS_TYPE_4_START')

    elseif action.type == 'MAPS_TYPE_4_START' then

      local newstateTypes = c.yield(setScreenListeners(battleListenerList, {
        { 'MAPS_TYPE_4_GET_NEXT_STEP', o.battle.isMapPage },
      }))
      return makeAction(newstateTypes)

    elseif action.type == 'MAPS_TYPE_4_GET_NEXT_STEP' then

      stepLabel.setStepLabelContent('3-6.计算下一步往哪走')
      local mapChessboard = store.scanMapType1.mapChessboard
      local inBattleList = mapChessboard.inBattleList

      local _ = (function()

        stepLabel.setStepLabelContent('3-11.随机移动一步')
        store.mapType4.missionStep = 'randomMoveAStep'
        store.mapType4.nextStepFleed = 'onWay'
        store.mapType4.nextStepPoint = mapProxy.getRandomMoveAStep(mapChessboard)
        return
      end)()
      console.log(store.mapType4.nextStepPoint)
      -- 如果还是没有移动目标，则可能是我方舰队挡住了敌人，此时需要随意移动一步
      -- 尽可能避开敌人
      if not store.mapType4.nextStepPoint then
        stepLabel.setStepLabelContent('3-11.随机移动一步')
        store.mapType4.nextStepPoint = mapProxy.getRandomMoveAStep(mapChessboard)
      end
      -- 如果还是没有移动目标，只好重新扫描
      if not store.mapType4.nextStepPoint then
        local newstateTypes = c.yield(setScreenListeners(battleListenerList, {
          { 'MAPS_TYPE_4_START', o.battle.isMapPage },
        }))
        return makeAction(newstateTypes)
      end

      -- 查找目标点在哪个界面
      store.mapType4.checkpositionListForMove = mapProxy.getCheckpositionList(settings.battleChapter)
      for _, targetPosition in ipairs(store.mapType4.checkpositionListForMove) do
        local nextRowNum = store.mapType4.nextStepPoint[1]
        local nextColNum = store.mapType4.nextStepPoint[2]
        if targetPosition.pointMap[nextRowNum .. '-' .. nextColNum] then
          store.mapType4.checkpositionListForMove = { targetPosition }
          break;
        end
      end

      local newstateTypes = c.yield(setScreenListeners(battleListenerList, {
        { 'MAPS_TYPE_4_PAGE_SELECT_FLEET', o.battle.isMapPage },
      }))
      return makeAction(newstateTypes)

    elseif action.type == 'MAPS_TYPE_4_PAGE_SELECT_FLEET' then

      if settings.battleFleet[2] then
        stepLabel.setStepLabelContent('3-20.检查舰队')
        if store.mapType4.nextStepFleed == 'boss' then
          if (not o.battle.getSelectedFleed() == settings.battleFleet[1]) and store.mapType4.changeFleetNum < 2 then
            store.mapType4.changeFleetNum = store.mapType4.changeFleetNum + 1
            stepLabel.setStepLabelContent('3-21.选择boss舰队')
            o.battle.clickSwitchFleetBtn()
            c.yield(sleepPromise(100))
            o.battle.clickAttackBtn()
            c.yield(sleepPromise(500))
            if o.battle.getSelectedFleed() == settings.battleFleet[1] then
              local myFleetList = store.scanMapType1.mapChessboard.myFleetList
              store.scanMapType1.mapChessboard.myFleetList = { myFleetList[2], myFleetList[1] }
            else
              local newstateTypes = c.yield(setScreenListeners(battleListenerList, {
                { 'MAPS_TYPE_4_PAGE_SELECT_FLEET', o.battle.isMapPage, 1000 },
              }))
              return makeAction(newstateTypes)
            end
          end
        elseif store.mapType4.nextStepFleed == 'onWay'
          or store.mapType4.missionStep == nil then
          local res = o.battle.getSelectedFleed() == settings.battleFleet[2]
          if (not res) and (store.mapType4.changeFleetNum < 2) then
            store.mapType4.changeFleetNum = store.mapType4.changeFleetNum + 1
            stepLabel.setStepLabelContent('3-22.选择道中舰队')
            o.battle.clickSwitchFleetBtn()
            c.yield(sleepPromise(100))
            o.battle.clickAttackBtn()
            if o.battle.getSelectedFleed() == settings.battleFleet[2] then
              local myFleetList = store.scanMapType1.mapChessboard.myFleetList
              store.scanMapType1.mapChessboard.myFleetList = { myFleetList[2], myFleetList[1] }
            else
              local newstateTypes = c.yield(setScreenListeners(battleListenerList, {
                { 'MAPS_TYPE_4_PAGE_SELECT_FLEET', o.battle.isMapPage, 1000 },
              }))
              return makeAction(newstateTypes)
            end
          end
        end
      end

      store.mapType4.changeFleetNum = 0
      local newstateTypes = c.yield(setScreenListeners(battleListenerList, {
        { 'MAPS_TYPE_4_GET_MAP_POSITION_FOR_A_STEP', o.battle.isMapPage },
      }))
      return makeAction(newstateTypes)

    elseif action.type == 'MAPS_TYPE_4_GET_MAP_POSITION_FOR_A_STEP' then

      stepLabel.setStepLabelContent('3-11.获取地图位置参数')
      local targetPosition = store.mapType4.checkpositionListForMove[1]
      local currentPosition = mapProxy.getMapPosition(targetPosition)
      console.log(currentPosition)
      stepLabel.setStepLabelContent('3-12.计算移动向量')
      local targetPosition = store.mapType4.checkpositionListForMove[1]
      local newMoveVector, effectiveStep = mapProxy.getMoveVector(currentPosition, targetPosition)
      if effectiveStep and comparePoints(store.mapType4.moveVectorForAStep, newMoveVector) then
        store.mapType4.moveVectorForAStep = newMoveVector
        local newstateTypes = c.yield(setScreenListeners(battleListenerList, {
          { 'MAPS_TYPE_4_MOVE_A_STEP', o.battle.isMapPage, 500 },
        }))
        return makeAction(newstateTypes)
      end
      console.log(newMoveVector)
      store.mapType4.moveVectorForAStep = newMoveVector
      local newstateTypes = c.yield(setScreenListeners(battleListenerList, {
        { 'MAPS_TYPE_4_MOVE_TO_CHECK_POSITION_FOR_A_STEP', o.battle.isMapPage },
      }))
      return makeAction(newstateTypes)

    elseif action.type == 'MAPS_TYPE_4_MOVE_TO_CHECK_POSITION_FOR_A_STEP' then

      stepLabel.setStepLabelContent('3-13.将地图移动到移动位置')
      local isCenter = mapProxy.moveMapToCheckPosition(store.mapType4.moveVectorForAStep)
      if isCenter then
        local newstateTypes = c.yield(setScreenListeners(battleListenerList, {
          { 'MAPS_TYPE_4_MOVE_A_STEP', o.battle.isMapPage, 500 },
        }))
        return makeAction(newstateTypes)
      else
        local newstateTypes = c.yield(setScreenListeners(battleListenerList, {
          { 'MAPS_TYPE_4_GET_MAP_POSITION_FOR_A_STEP', o.battle.isMapPage, 1000 },
        }))
        return makeAction(newstateTypes)
      end

    elseif action.type == 'MAPS_TYPE_4_MOVE_A_STEP' then

      stepLabel.setStepLabelContent('3-14.移动舰队位置')
      local targetPosition = store.mapType4.checkpositionListForMove[1]
      local nextRowNum = store.mapType4.nextStepPoint[1]
      local nextColNum = store.mapType4.nextStepPoint[2]
      console.log(store.mapType4.nextStepPoint)
      if targetPosition.pointMap[nextRowNum .. '-' .. nextColNum] then
        mapProxy.moveToPoint(targetPosition, store.mapType4.nextStepPoint)
        o.battle.clickAttackBtn()
      elseif #store.mapType4.checkpositionListForMove > 0 then
        local newstateTypes = c.yield(setScreenListeners(battleListenerList, {
          { 'MAPS_TYPE_4_GET_MAP_POSITION_FOR_A_STEP', o.battle.isMapPage },
        }))
        return makeAction(newstateTypes)
      end

      store.mapType4.checkpositionListForCheck = mapProxy.getCheckpositionList(settings.battleChapter)

      if store.mapType4.moveFailTimes < 1 then
        store.mapType4.moveFailTimes = store.mapType4.moveFailTimes + 1
        local newstateTypes = c.yield(setScreenListeners(battleListenerList, {
          { 'MAPS_TYPE_4_GET_MAP_POSITION_FOR_A_STEP', o.battle.isMapPage, 3000 } -- 如果移动后还是在地图页面，可能是遇到空隙。再次点击位置
        }))
        return makeAction(newstateTypes)
      end
      store.mapType4.moveFailTimes = 0

      local newstateTypes = c.yield(setScreenListeners(battleListenerList, {
        { 'SCAN_MAP_TYPE_1_INIT', o.battle.isMapPage, 3000 } -- 重新扫描
      }))
      return makeAction(newstateTypes)

    elseif action.type == 'MAPS_TYPE_4_PAGE_AMBUSHED_PANEL_AVOID_AMBUSHED' then

      stepLabel.setStepLabelContent('3.15.躲避伏击')
      if settings.battleRoundabout then
        o.battle.ambushedPanelClickAvoidBtn()
      else
        o.battle.ambushedPanelClickInterceptBtn()
      end
      local newstateTypes = c.yield(setScreenListeners(battleListenerList, {
        { 'MAPS_TYPE_4_MOVE_TO_CHECK_POSITION_FOR_A_STEP', o.battle.isMapPage, 3000 },
      }))
      return makeAction(newstateTypes)
    end

    return nil
  end))
end

return mapsType2

