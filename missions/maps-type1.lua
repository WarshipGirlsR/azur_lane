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

-- 设置  store 的默认值
store.mapType1 = store.mapType1 or {
  checkpositionListForCheck = nil,
  checkpositionListForMove = {},
  oldMapChessboard = nil,
  mapChessboard = {},
  currentPosition = nil,
  nextStepPoint = nil,
  moveVectorForCheck = { -1, -1 },
  moveVectorForAStep = { -1, -1 },
}

local o = {
  home = moHome,
  battle = moBattle,
  map = moMap,
}

local comparePoints = function(point1, point2)
  return point1[1] == point2[1] and point1[2] == point2[2]
end


local battleListenerList = {
  { '', o.home.isHome, 2000 },
  { 'BATTLE_BATTLE_CHAPTER_PAGE_BACK_TO_HOME', o.battle.isBattleChapterPage, 2000 },
  { 'BATTLE_BATTLE_CHAPTER_PAGE_INFO_PANEL_CLICK_INTO', o.battle.isChapterInfoPanel, 2000 },
  { 'BATTLE_BATTLE_CHAPTER_PAGE_SELECT_FLEET_PANEL_SELECT_FLEET', o.battle.isSelectFleetPanel, 2000 },
  { 'BATTLE_BATTLE_CHAPTER_PAGE_HARD_SELECT_FLEET_PANEL_CLICK_INTO', o.battle.isHardSelectFleetPanel, 500 },
  { 'BATTLE_MAP_PAGE', o.battle.isMapPage, 2000 },
  { 'BATTLE_READY_BATTLE_PAGE_CLICK_BATTLE', o.battle.isReadyBattlePage, 2000 },
  { 'BATTLE_IN_BATTLE_PAGE', o.battle.isInBattlePage, 2000 },
  { 'BATTLE_VICTORY_PAGE', o.battle.isVictoryPanel, 2000 },
  { 'BATTLE_GET_PROPS_PANEL', o.battle.isGetPropsPanel, 2000 },
  { 'BATTLE_GET_NEW_SHIP_PANEL', o.battle.isGetNewShipPanel, 2000 },
  { 'BATTLE_GET_EXP_PANEL', o.battle.isGetExpPanel, 2000 },
}

local mapsType1 = function(action)
  local settings = store.settings;
  local mapProxy = o.map['map' .. settings.battleChapter]

  return co(c.create(function()
    if action.type == 'MAPS_TYPE1_RE_INIT' then

      -- 这部分流程只会在每次开启新的一局时才调用一次，而不是每次寻路就调用一次
      stepLabel.setStepLabelContent('3-1.开局预备变量')
      store.mapType1.selectFleedCount = 0
      -- boss舰队是否在boss区域
      store.mapType1.isBossFleetInBossArea = false
      store.mapType1.battleNum = 0
      store.mapType1.battleWithConvoyNum = 0
      store.mapType1.battleFromState = ''
      store.mapType1.lastVibratorTime = os.time()
      -- 切换船的次数，如果超过4次没切换成功表示舰队沉了。
      store.mapType1.changeFleetNum = 0
      -- 舰队移动的状态。一次关卡走地图会有3种状态
      -- moveToWaitBoss : 移动到待命区
      -- moveToClosestEnemy : 移动到最近的敌人
      -- moveToBoss : 移动到 boss
      store.mapType1.moveState = 'moveToWaitBoss'
      -- 是否自动模式，如果没有相应配置的话会自动从自动切换到手动
      store.mapType1.battleAssistantMode = settings.battleAssistantMode
      return makeAction('')

    elseif action.type == 'MAPS_TYPE1_INIT' then
      
      store.mapType1.checkpositionListForCheck = mapProxy.getCheckpositionList()
      store.mapType1.checkpositionListForMove = store.mapType1.checkpositionListForMove or {}
      -- 获取地图信息。如果上次扫描结果还在，就把敌人列表保留下来
      -- 因为敌人容易被我方舰队覆盖住导致扫描不到
      -- 所以敌人列表在关卡中都不清除，其他列表在每次开始扫描棋盘前会清除。
      store.mapType1.oldMapChessboard = store.mapType1.mapChessboard
      store.mapType1.mapChessboard = store.mapType1.mapChessboard or {}
      local newMapChessBoard = mapProxy.getMapChessboard(settings.battleChapter)
      -- newMapChessBoard.enemyPositionList = store.mapType1.mapChessboard.enemyPositionList or newMapChessBoard.enemyPositionList
      newMapChessBoard.bossPosition = store.mapType1.mapChessboard.bossPosition or newMapChessBoard.bossPosition
      store.mapType1.mapChessboard = newMapChessBoard

      store.mapType1.currentPosition = nil
      store.mapType1.nextStepPoint = nil
      store.mapType1.moveVectorForCheck = { -1, -1 }
      store.mapType1.moveVectorForAStep = { -1, -1 }
      return makeAction('MAPS_TYPE1_START')

    elseif action.type == 'MAPS_TYPE1_START' then

      -- 检查上次移动舰队时所在的位置，并将其提前。有利于提高扫描速度
      if #store.mapType1.checkpositionListForMove > 0 then
        local cForMove = store.mapType1.checkpositionListForMove[1]
        local index = table.findIndex(store.mapType1.checkpositionListForCheck, function(cForCheck)
          if cForMove.leftTop and cForCheck.leftTop then
            return cForMove.leftTop[1] == cForCheck.leftTop[1] and cForMove.leftTop[2] == cForCheck.leftTop[2]
          elseif cForMove.rightTop and cForCheck.rightTop then
            return cForMove.rightTop[1] == cForCheck.rightTop[1] and cForMove.rightTop[2] == cForCheck.rightTop[2]
          elseif cForMove.leftBotton and cForCheck.leftBotton then
            return cForMove.leftBotton[1] == cForCheck.leftBotton[1] and cForMove.leftBotton[2] == cForCheck.leftBotton[2]
          elseif cForMove.rightBotton and cForCheck.rightBotton then
            return cForMove.rightBotton[1] == cForCheck.rightBotton[1] and cForMove.rightBotton[2] == cForCheck.rightBotton[2]
          end
        end)
        if index > 0 then
          local cfm = store.mapType1.checkpositionListForCheck[index]
          table.remove(store.mapType1.checkpositionListForCheck, index)
          table.insert(store.mapType1.checkpositionListForCheck, 1, cfm)
        end
      end
      return makeAction('MAPS_MAP_MOVE_TO_CHECK_POSITION_FOR_CHECK')

    elseif action.type == 'MAPS_MAP_MOVE_TO_CHECK_POSITION_FOR_CHECK' then

      stepLabel.setStepLabelContent('3-2.获取地图位置参数')
      local targetPosition = store.mapType1.checkpositionListForCheck[1]
      local currentPosition = mapProxy.getMapPosition(targetPosition)

      stepLabel.setStepLabelContent('3-3.计算移动向量')
      local targetPosition = store.mapType1.checkpositionListForCheck[1]
      local newMoveVector, effectiveStep = mapProxy.getMoveVector(currentPosition, targetPosition)
      if effectiveStep and comparePoints(store.mapType1.moveVectorForCheck, newMoveVector) then
        store.mapType1.moveVectorForCheck = newMoveVector
        local newstateTypes = c.yield(setScreenListeners(battleMap, {
          { 'MAPS_MAP_SCAN_MAP', map.battle.isMapPage, 500 },
        }))
        return makeAction(newstateTypes), state
      end
      store.mapType1.moveVectorForCheck = newMoveVector
      local newstateTypes = c.yield(setScreenListeners(battleMap, {
        { 'MAPS_MAP_MOVE_TO_CHECK_POSITION_FOR_CHECK', map.battle.isMapPage },
      }))
      return makeAction(newstateTypes), state

    elseif action.type == 'MAPS_MAP_SCAN_MAP' then

      stepLabel.setStepLabelContent('3-5.扫描地图')
      local targetPosition = store.mapType1.checkpositionListForCheck[1]
      store.mapType1.mapChessboard = mapProxy.scanMap(targetPosition, store.mapType1.mapChessboard, store.mapType1.oldMapChessboard)
      console.log(store.mapType1.mapChessboard)
      if #store.mapType1.checkpositionListForCheck > 1 then
        table.remove(store.mapType1.checkpositionListForCheck, 1)
        local newstateTypes = c.yield(setScreenListeners(battleMap, {
          { 'MAPS_MAP_GET_MAP_POSITION_FOR_CHECK', map.battle.isMapPage },
        }))
        return makeAction(newstateTypes), state
      end
      local newstateTypes = c.yield(setScreenListeners(battleMap, {
        { 'MAPS_MAP_GET_NEXT_STEP', map.battle.isMapPage },
      }))
      return makeAction(newstateTypes), state

    elseif action.type == 'MAPS_MAP_GET_NEXT_STEP' then

      stepLabel.setStepLabelContent('3-6.计算下一步往哪走')
      local mapChessboard = store.mapType1.mapChessboard
      local myFleetList = mapChessboard.myFleetList
      local inBattleList = mapChessboard.inBattleList
      local waitForBossPosition = mapChessboard.waitForBossPosition[1]
      if not waitForBossPosition then
        store.mapType1.moveState = 'moveToClosestEnemy'
      end
      if table.findIndex(inBattleList, function(ele) return comparePoints(ele, myFleetList[1]) end) > -1 then
        stepLabel.setStepLabelContent('3-7.开始战斗')
        map.battle.clickAttackBtn()
      elseif #mapChessboard.bossPosition > 0 then
        stepLabel.setStepLabelContent('3-8.移动到boss位置')
        store.mapType1.moveState = 'moveToBoss'
        store.mapType1.nextStepPoint = mapProxy.checkMoveToPointPath(mapChessboard, mapChessboard.myFleetList[1], mapChessboard.bossPosition[1])
      elseif store.mapType1.moveState == 'moveToWaitBoss' and table.findIndex(myFleetList, function(ele) return comparePoints(ele, waitForBossPosition) end) > -1 then
        store.mapType1.moveState = 'moveToClosestEnemy'
        local newstateTypes = c.yield(setScreenListeners(battleMap, {
          { 'MAPS_MAP_GET_NEXT_STEP', map.battle.isMapPage },
        }))
        return makeAction(newstateTypes), state
      elseif store.mapType1.moveState == 'moveToWaitBoss' then
        stepLabel.setStepLabelContent('3-9.移动待命位置')
        store.mapType1.nextStepPoint = mapProxy.checkMoveToPointPath(mapChessboard, mapChessboard.myFleetList[1], mapChessboard.waitForBossPosition[1])
      else
        stepLabel.setStepLabelContent('3-10.移动到最近的敌人')
        store.mapType1.moveState = 'moveToClosestEnemy'
        local closestEnemy = mapProxy.findClosestEnemy(mapChessboard)
        store.mapType1.nextStepPoint = closestEnemy
      end
      -- 如果还是没有移动目标，则可能是我方舰队挡住了敌人，此时需要随意移动一步
      -- 尽可能避开敌人
      if not store.mapType1.nextStepPoint then
        stepLabel.setStepLabelContent('3-11.随机移动一步')
        store.mapType1.nextStepPoint = mapProxy.getRandomMoveAStep(mapChessboard)
      end
      console.log(store.mapType1.nextStepPoint)
      -- 如果还是没有移动目标，只好重新扫描
      if not store.mapType1.nextStepPoint then
        local newstateTypes = c.yield(setScreenListeners(battleMap, {
          { 'MAPS_MAP_START', map.battle.isMapPage },
        }))
        return makeAction(newstateTypes), state
      end

      -- 查找目标点在哪个界面
      store.mapType1.checkpositionListForMove = mapProxy.getCheckpositionList(settings.battleChapter)
      for _, targetPosition in ipairs(store.mapType1.checkpositionListForMove) do
        local nextRowNum = store.mapType1.nextStepPoint[1]
        local nextColNum = store.mapType1.nextStepPoint[2]
        if targetPosition.pointMap[nextRowNum .. '-' .. nextColNum] then
          store.mapType1.checkpositionListForMove = { targetPosition }
          break;
        end
      end

      local newstateTypes = c.yield(setScreenListeners(battleMap, {
        { 'BATTLE_MAP_PAGE_SELECT_FLEET', map.battle.isMapPage },
      }))
      return makeAction(newstateTypes), state

    elseif action.type == 'MAPS_MAP_GET_MAP_POSITION_FOR_A_STEP' then

      stepLabel.setStepLabelContent('3-11.获取地图位置参数')
      local targetPosition = store.mapType1.checkpositionListForMove[1]
      local currentPosition = mapProxy.getMapPosition(targetPosition)
      console.log(currentPosition)

      stepLabel.setStepLabelContent('3-12.计算移动向量')
      local targetPosition = store.mapType1.checkpositionListForMove[1]
      local newMoveVector, effectiveStep = mapProxy.getMoveVector(currentPosition, targetPosition)
      if effectiveStep and comparePoints(store.mapType1.moveVectorForAStep, newMoveVector) then
        store.mapType1.moveVectorForAStep = newMoveVector
        local newstateTypes = c.yield(setScreenListeners(battleMap, {
          { 'MAPS_MAP_MOVE_A_STEP', map.battle.isMapPage, 500 },
        }))
        return makeAction(newstateTypes), state
      end
      store.mapType1.moveVectorForAStep = newMoveVector
      local newstateTypes = c.yield(setScreenListeners(battleMap, {
        { 'MAPS_MAP_MOVE_TO_CHECK_POSITION_FOR_A_STEP', map.battle.isMapPage },
      }))
      return makeAction(newstateTypes), state

    elseif action.type == 'MAPS_MAP_GET_MOVE_VECTOR_FOR_A_STEP' then



    elseif action.type == 'MAPS_MAP_MOVE_TO_CHECK_POSITION_FOR_A_STEP' then

      stepLabel.setStepLabelContent('3-13.将地图移动到移动位置')
      local isCenter = mapProxy.moveMapToCheckPosition(store.mapType1.moveVectorForAStep)
      if isCenter then
        local newstateTypes = c.yield(setScreenListeners(battleMap, {
          { 'MAPS_MAP_MOVE_A_STEP', map.battle.isMapPage, 500 },
        }))
        return makeAction(newstateTypes), state
      else
        local newstateTypes = c.yield(setScreenListeners(battleMap, {
          { 'MAPS_MAP_GET_MAP_POSITION_FOR_A_STEP', map.battle.isMapPage, 1000 },
        }))
        return makeAction(newstateTypes), state
      end

    elseif action.type == 'MAPS_MAP_MOVE_A_STEP' then

      stepLabel.setStepLabelContent('3-14.移动舰队位置')
      local targetPosition = store.mapType1.checkpositionListForMove[1]
      local nextRowNum = store.mapType1.nextStepPoint[1]
      local nextColNum = store.mapType1.nextStepPoint[2]
      if targetPosition.pointMap[nextRowNum .. '-' .. nextColNum] then
        mapProxy.moveToPoint(targetPosition, store.mapType1.nextStepPoint)
        map.battle.clickAttackBtn()
      elseif #store.mapType1.checkpositionListForMove > 0 then
        local newstateTypes = c.yield(setScreenListeners(battleMap, {
          { 'MAPS_MAP_GET_MAP_POSITION_FOR_A_STEP', map.battle.isMapPage },
        }))
        return makeAction(newstateTypes), state
      end

      store.mapType1.checkpositionListForCheck = mapProxy.getCheckpositionList(settings.battleChapter)
      local newstateTypes = c.yield(setScreenListeners(battleMap, {
        { 'BATTLE_MAP_PAGE_CHECK_ASSISTANT_MODE', map.battle.isMapPage, 3000 }
      }))
      return makeAction(newstateTypes), state
    end
  end

return nil
end))
end

return mapsType1
