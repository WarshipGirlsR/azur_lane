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
store.mapType2 = store.mapType2 or {
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
  moveVectorForCheck = { -1, -1 },
  moveVectorForAStep = { -1, -1 },
}

-- maps-type2 的行动流程
local missionStepList = {
  'battle',
  'onWayFleetMoveToWaitBoss',
  'onWayFleetMoveToBossFleet',
  'onWayFleetMoveToClosestEnemy',
  'bossFleetMoveToWaitBoss',
  'bossFleetMoveToBoss',
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
  { 'BATTLE_MAP_PAGE_AMBUSHED_PANEL_AVOID_AMBUSHED', o.battle.isAmbushedPanel, 2000 },
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

local mapsType2 = function(action)
  local settings = store.settings;
  local mapProxy = o.map['map' .. settings.battleChapter]
  return co(c.create(function()
    if action.type == 'MAPS_TYPE2_PRE_INIT' then

      -- 这部分流程只会在每次开启新的一局时才调用一次，而不是每次寻路就调用一次

      stepLabel.setStepLabelContent('3-1.开局预备变量')
      store.mapType2.selectFleedCount = 0
      -- boss舰队是否在boss区域
      store.mapType2.isBossFleetInBossArea = false
      store.mapType2.battleNum = 0
      store.mapType2.battleWithConvoyNum = 0
      store.mapType2.battleFromState = ''
      -- 切换船的次数，如果超过4次没切换成功表示舰队沉了。
      store.mapType2.changeFleetNum = 0
      -- 舰队移动的状态。
      store.mapType2.missionStep = 'onWayFleetMoveToWaitBoss'
      store.mapType2.checkpositionListForCheck = nil
      store.mapType2.checkpositionListForMove = {}
      store.mapType2.mapChessboard = mapProxy and mapProxy.getMapChessboard(settings.battleChapter) or {}
      store.mapType2.newMapChessboard = mapProxy and mapProxy.getMapChessboard(settings.battleChapter) or {}
      store.mapType2.currentPosition = nil
      store.mapType2.nextStepPoint = nil
      store.mapType2.moveVectorForCheck = { -1, -1 }
      store.mapType2.moveVectorForAStep = { -1, -1 }

      return makeAction('')

    elseif action.type == 'MAPS_TYPE2_INIT' then

      -- 每次进入地图页面时就会执行一次

      store.mapType2.checkpositionListForCheck = mapProxy.getCheckpositionList()
      -- 先用 newMapChessboard 完成扫描，然后再与 mapChessboard 合并。这样就可以做新老版本的对比，避免被挡住的问题
      store.mapType2.newMapChessboard = mapProxy.getMapChessboard(settings.battleChapter)
      store.mapType2.currentPosition = nil
      store.mapType2.nextStepPoint = nil
      store.mapType2.moveVectorForCheck = { -1, -1 }
      store.mapType2.moveVectorForAStep = { -1, -1 }
      return makeAction('MAPS_TYPE2_START')

    elseif action.type == 'MAPS_TYPE2_START' then

      -- 检查上次移动舰队时所在的位置，并将其提前。有利于提高扫描速度
      if #store.mapType2.checkpositionListForMove > 0 then
        local cForMove = store.mapType2.checkpositionListForMove[1]
        local index = table.findIndex(store.mapType2.checkpositionListForCheck, function(cForCheck)
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
          local cfm = store.mapType2.checkpositionListForCheck[index]
          table.remove(store.mapType2.checkpositionListForCheck, index)
          table.insert(store.mapType2.checkpositionListForCheck, 1, cfm)
        end
      end
      return makeAction('MAPS_TYPE2_MOVE_TO_CHECK_POSITION_FOR_CHECK')

    elseif action.type == 'MAPS_TYPE2_MOVE_TO_CHECK_POSITION_FOR_CHECK' then

      stepLabel.setStepLabelContent('3-2.获取地图位置参数')
      local targetPosition = store.mapType2.checkpositionListForCheck[1]
      local currentPosition = mapProxy.getMapPosition(targetPosition)

      stepLabel.setStepLabelContent('3-3.计算移动向量')
      local targetPosition = store.mapType2.checkpositionListForCheck[1]
      local newMoveVector, effectiveStep = mapProxy.getMoveVector(currentPosition, targetPosition)
      if effectiveStep and comparePoints(store.mapType2.moveVectorForCheck, newMoveVector) then
        store.mapType2.moveVectorForCheck = newMoveVector
        local newstateTypes = c.yield(setScreenListeners(battleListenerList, {
          { 'MAPS_TYPE2_SCAN_MAP', o.battle.isMapPage, 1000 },
        }))
        return makeAction(newstateTypes)
      end

      stepLabel.setStepLabelContent('3-3.移动地图')
      local isCenter = mapProxy.moveMapToCheckPosition(newMoveVector)
      if isCenter then
        -- 地图已经移动到位
        local newstateTypes = c.yield(setScreenListeners(battleListenerList, {
          { 'MAPS_TYPE2_SCAN_MAP', o.battle.isMapPage, 1000 },
        }))
        return makeAction(newstateTypes)
      else
        -- 地图没有移动到位
        local newstateTypes = c.yield(setScreenListeners(battleListenerList, {
          { 'MAPS_TYPE2_MOVE_TO_CHECK_POSITION_FOR_CHECK', o.battle.isMapPage, 500 },
        }))
        return makeAction(newstateTypes)
      end

      store.mapType2.moveVectorForCheck = newMoveVector
      local newstateTypes = c.yield(setScreenListeners(battleListenerList, {
        { 'MAPS_TYPE2_MOVE_TO_CHECK_POSITION_FOR_CHECK', o.battle.isMapPage, 500 },
      }))
      return makeAction(newstateTypes)

    elseif action.type == 'MAPS_TYPE2_SCAN_MAP' then

      stepLabel.setStepLabelContent('3-5.扫描地图')
      local targetPosition = store.mapType2.checkpositionListForCheck[1]
      store.mapType2.newMapChessboard = mapProxy.scanMap(targetPosition, store.mapType2.newMapChessboard)
      console.log(store.mapType2.newMapChessboard)
      -- 地图没扫描完，继续扫描
      if #store.mapType2.checkpositionListForCheck > 1 then
        table.remove(store.mapType2.checkpositionListForCheck, 1)
        local newstateTypes = c.yield(setScreenListeners(battleListenerList, {
          { 'MAPS_TYPE2_MOVE_TO_CHECK_POSITION_FOR_CHECK', o.battle.isMapPage },
        }))
        return makeAction(newstateTypes)
      end

      -- 扫描完毕，将 newMapChessboard 与 mapChessboard 合并
      store.mapType2.mapChessboard = mapProxy.assignMapChessboard(store.mapType2.mapChessboard, store.mapType2.newMapChessboard)

      -- 将道中队和boss队分位置别标记
      if not store.mapType2.mapChessboard.myFleetList[2] then
        store.mapType2.mapChessboard.bossFleet = store.mapType2.mapChessboard.myFleetList[1]
        store.mapType2.mapChessboard.onWayFleet = store.mapType2.mapChessboard.myFleetList[1]
      elseif o.battle.isSelectedFleed(settings.battleFleet[1]) then
        store.mapType2.mapChessboard.bossFleet = store.mapType2.mapChessboard.myFleetList[1]
        store.mapType2.mapChessboard.onWayFleet = store.mapType2.mapChessboard.myFleetList[2]
      else
        store.mapType2.mapChessboard.bossFleet = store.mapType2.mapChessboard.myFleetList[2]
        store.mapType2.mapChessboard.onWayFleet = store.mapType2.mapChessboard.myFleetList[1]
      end

      console.log(store.mapType2.mapChessboard)
      -- 如果扫描内容是空的，重新扫描
      if #store.mapType2.mapChessboard.myFleetList == 0 then
        local newstateTypes = c.yield(setScreenListeners(battleListenerList, {
          { 'MAPS_TYPE2_INIT', o.battle.isMapPage },
        }))
      end

      -- 进入移动步骤
      local newstateTypes = c.yield(setScreenListeners(battleListenerList, {
        { 'MAPS_TYPE2_GET_NEXT_STEP', o.battle.isMapPage },
      }))
      return makeAction(newstateTypes)

    elseif action.type == 'MAPS_TYPE2_GET_NEXT_STEP' then

      stepLabel.setStepLabelContent('3-6.计算下一步往哪走')
      local mapChessboard = store.mapType2.mapChessboard
      local myFleetList = mapChessboard.myFleetList
      local inBattleList = mapChessboard.inBattleList
      local waitForBossPosition = mapChessboard.waitForBossPosition[1]

      local _ = (function()
        if not waitForBossPosition then
          store.mapType2.missionStep = 'onWayFleetMoveToClosestEnemy'
          store.mapType2.nextStepPoint = mapProxy.findClosestEnemy(mapChessboard, mapChessboard.onWayFleet, mapChessboard.bossFleet)
          return
        end
        if table.findIndex(inBattleList, function(ele) return comparePoints(ele, mapChessboard.bossFleet) end) > -1 then
          stepLabel.setStepLabelContent('3-8.boss队移动到boss位置')
          store.mapType2.missionStep = 'bossFleetMoveToBoss'
          store.mapType2.nextStepPoint = mapChessboard.bossFleet
          return
        end
        if table.findIndex(inBattleList, function(ele) return comparePoints(ele, myFleetList[1]) end) > -1 then
          store.mapType2.missionStep = 'battle'
          stepLabel.setStepLabelContent('3-7.开始战斗')
          o.battle.clickAttackBtn()
          return
        end

        if #mapChessboard.bossPosition > 0 and comparePoints(mapChessboard.bossFleet, mapChessboard.bossPosition[1]) then
        end

        if #mapChessboard.bossPosition > 0 then
          -- 判断boss队到boss中间能否通过
          local bossTo = mapProxy.checkMoveToPointPath(mapChessboard, mapChessboard.bossFleet, mapChessboard.bossPosition[1])
          if not bossTo or comparePoints(bossTo, mapChessboard.bossPosition[1]) then
            stepLabel.setStepLabelContent('3-8.boss队移动到boss位置')
            store.mapType2.missionStep = 'bossFleetMoveToBoss'
            store.mapType2.nextStepPoint = mapProxy.checkMoveToPointPath(mapChessboard, mapChessboard.bossFleet, mapChessboard.bossPosition[1])
            return
          end

          stepLabel.setStepLabelContent('3-8.道中队清理阻拦的敌人')
          store.mapType2.missionStep = 'onWayFleetMoveToClosestEnemy'
          store.mapType2.nextStepPoint = mapProxy.checkMoveToPointPath(mapChessboard, mapChessboard.onWayFleet, bossTo)
          return
        end
        if comparePoints(mapChessboard.onWayFleet, waitForBossPosition) then
          stepLabel.setStepLabelContent('3-8.道中移动到最近的敌人')
          store.mapType2.missionStep = 'onWayFleetMoveToClosestEnemy'
          store.mapType2.nextStepPoint = mapProxy.findClosestEnemy(mapChessboard, mapChessboard.onWayFleet, mapChessboard.bossFleet)
          return
        end

        if not comparePoints(mapChessboard.bossFleet, waitForBossPosition) and mapChessboard.myFleetList[2] then
          local bossTo = mapProxy.checkMoveToPointPath(mapChessboard, mapChessboard.bossFleet, waitForBossPosition)
          if comparePoints(bossTo, waitForBossPosition) then
            stepLabel.setStepLabelContent('3-8.boss队移动到待命位置')
            store.mapType2.missionStep = 'bossFleetMoveToWaitBoss'
            store.mapType2.nextStepPoint = bossTo
            return
          else
            stepLabel.setStepLabelContent('3-8.道中队移动到待命位置')
            store.mapType2.missionStep = 'onWayFleetMoveToWaitBoss'
            store.mapType2.nextStepPoint = mapProxy.findClosestEnemy(mapChessboard, mapChessboard.onWayFleet, waitForBossPosition)
            return
          end
        end

        if not mapChessboard.myFleetList[2] then
          stepLabel.setStepLabelContent('3-8.道中移动到最近的敌人')
          store.mapType2.missionStep = 'onWayFleetMoveToClosestEnemy'
          store.mapType2.nextStepPoint = mapProxy.findClosestEnemy(mapChessboard, mapChessboard.onWayFleet, mapChessboard.bossFleet)
          return
        end

        if store.mapType2.missionStep == 'onWayFleetMoveToClosestEnemy' then
          stepLabel.setStepLabelContent('3-8.道中移动到最近的敌人')
          store.mapType2.nextStepPoint = mapProxy.findClosestEnemy(mapChessboard, mapChessboard.onWayFleet, mapChessboard.bossFleet)
          return
        end

        stepLabel.setStepLabelContent('3-8.道中移动到最近的敌人')
        store.mapType2.missionStep = 'onWayFleetMoveToClosestEnemy'
        store.mapType2.nextStepPoint = mapProxy.findClosestEnemy(mapChessboard, mapChessboard.onWayFleet, mapChessboard.bossFleet)
        return
      end)()

      -- 如果还是没有移动目标，则可能是我方舰队挡住了敌人，此时需要随意移动一步
      -- 尽可能避开敌人
      if not store.mapType2.nextStepPoint then
        stepLabel.setStepLabelContent('3-11.随机移动一步')
        store.mapType2.nextStepPoint = mapProxy.getRandomMoveAStep(mapChessboard)
      end
      -- 如果还是没有移动目标，只好重新扫描
      if not store.mapType2.nextStepPoint then
        local newstateTypes = c.yield(setScreenListeners(battleListenerList, {
          { 'MAPS_TYPE2_START', o.battle.isMapPage },
        }))
        return makeAction(newstateTypes)
      end

      -- 查找目标点在哪个界面
      store.mapType2.checkpositionListForMove = mapProxy.getCheckpositionList(settings.battleChapter)
      for _, targetPosition in ipairs(store.mapType2.checkpositionListForMove) do
        local nextRowNum = store.mapType2.nextStepPoint[1]
        local nextColNum = store.mapType2.nextStepPoint[2]
        if targetPosition.pointMap[nextRowNum .. '-' .. nextColNum] then
          store.mapType2.checkpositionListForMove = { targetPosition }
          break;
        end
      end

      local newstateTypes = c.yield(setScreenListeners(battleListenerList, {
        { 'MAPS_TYPE2_PAGE_SELECT_FLEET', o.battle.isMapPage },
      }))
      return makeAction(newstateTypes)

    elseif action.type == 'MAPS_TYPE2_PAGE_SELECT_FLEET' then

      if settings.battleFleet[2] then
        stepLabel.setStepLabelContent('3-20.检查舰队')
        if store.mapType2.missionStep == 'bossFleetMoveToBoss'
          or store.mapType2.missionStep == 'bossFleetMoveToWaitBoss' then
          if (not o.battle.isSelectedFleed(settings.battleFleet[1])) and store.mapType2.changeFleetNum < 2 then
            store.mapType2.changeFleetNum = store.mapType2.changeFleetNum + 1
            stepLabel.setStepLabelContent('3-21.选择boss舰队')
            o.battle.clickSwitchFleetBtn()
            c.yield(sleepPromise(100))
            o.battle.clickAttackBtn()
            c.yield(sleepPromise(500))
            if o.battle.isSelectedFleed(settings.battleFleet[1]) then
              local myFleetList = store.mapType2.mapChessboard.myFleetList
              store.mapType2.mapChessboard.myFleetList = { myFleetList[2], myFleetList[1] }
            else
              local newstateTypes = c.yield(setScreenListeners(battleListenerList, {
                { 'MAPS_TYPE2_PAGE_SELECT_FLEET', o.battle.isMapPage, 1000 },
              }))
              return makeAction(newstateTypes)
            end
          end
        elseif store.mapType2.missionStep == 'onWayFleetMoveToWaitBoss'
          or store.mapType2.missionStep == 'onWayFleetMoveToBossFleet'
          or store.mapType2.missionStep == 'onWayFleetMoveToClosestEnemy' then
          local res = o.battle.isSelectedFleed(settings.battleFleet[2])
          if (not res) and (store.mapType2.changeFleetNum < 2) then
            store.mapType2.changeFleetNum = store.mapType2.changeFleetNum + 1
            stepLabel.setStepLabelContent('3-22.选择道中舰队')
            o.battle.clickSwitchFleetBtn()
            c.yield(sleepPromise(100))
            o.battle.clickAttackBtn()
            if o.battle.isSelectedFleed(settings.battleFleet[2]) then
              local myFleetList = store.mapType2.mapChessboard.myFleetList
              store.mapType2.mapChessboard.myFleetList = { myFleetList[2], myFleetList[1] }
            else
              local newstateTypes = c.yield(setScreenListeners(battleListenerList, {
                { 'MAPS_TYPE2_PAGE_SELECT_FLEET', o.battle.isMapPage, 1000 },
              }))
              return makeAction(newstateTypes)
            end
          end
        end
      end

      store.mapType2.changeFleetNum = 0
      local newstateTypes = c.yield(setScreenListeners(battleListenerList, {
        { 'MAPS_TYPE2_GET_MAP_POSITION_FOR_A_STEP', o.battle.isMapPage },
      }))
      return makeAction(newstateTypes)

    elseif action.type == 'MAPS_TYPE2_GET_MAP_POSITION_FOR_A_STEP' then

      stepLabel.setStepLabelContent('3-11.获取地图位置参数')
      local targetPosition = store.mapType2.checkpositionListForMove[1]
      local currentPosition = mapProxy.getMapPosition(targetPosition)

      stepLabel.setStepLabelContent('3-12.计算移动向量')
      local targetPosition = store.mapType2.checkpositionListForMove[1]
      local newMoveVector, effectiveStep = mapProxy.getMoveVector(currentPosition, targetPosition)
      if effectiveStep and comparePoints(store.mapType2.moveVectorForAStep, newMoveVector) then
        store.mapType2.moveVectorForAStep = newMoveVector
        local newstateTypes = c.yield(setScreenListeners(battleListenerList, {
          { 'MAPS_TYPE2_MOVE_A_STEP', o.battle.isMapPage, 500 },
        }))
        return makeAction(newstateTypes)
      end
      store.mapType2.moveVectorForAStep = newMoveVector
      local newstateTypes = c.yield(setScreenListeners(battleListenerList, {
        { 'MAPS_TYPE2_MOVE_TO_CHECK_POSITION_FOR_A_STEP', o.battle.isMapPage },
      }))
      return makeAction(newstateTypes)

    elseif action.type == 'MAPS_TYPE2_MOVE_TO_CHECK_POSITION_FOR_A_STEP' then

      stepLabel.setStepLabelContent('3-13.将地图移动到移动位置')
      local isCenter = mapProxy.moveMapToCheckPosition(store.mapType2.moveVectorForAStep)
      if isCenter then
        local newstateTypes = c.yield(setScreenListeners(battleListenerList, {
          { 'MAPS_TYPE2_MOVE_A_STEP', o.battle.isMapPage, 500 },
        }))
        return makeAction(newstateTypes)
      else
        local newstateTypes = c.yield(setScreenListeners(battleListenerList, {
          { 'MAPS_TYPE2_GET_MAP_POSITION_FOR_A_STEP', o.battle.isMapPage, 1000 },
        }))
        return makeAction(newstateTypes)
      end

    elseif action.type == 'MAPS_TYPE2_MOVE_A_STEP' then

      stepLabel.setStepLabelContent('3-14.移动舰队位置')
      local targetPosition = store.mapType2.checkpositionListForMove[1]
      local nextRowNum = store.mapType2.nextStepPoint[1]
      local nextColNum = store.mapType2.nextStepPoint[2]
      if targetPosition.pointMap[nextRowNum .. '-' .. nextColNum] then
        mapProxy.moveToPoint(targetPosition, store.mapType2.nextStepPoint)
        o.battle.clickAttackBtn()
      elseif #store.mapType2.checkpositionListForMove > 0 then
        local newstateTypes = c.yield(setScreenListeners(battleListenerList, {
          { 'MAPS_TYPE2_GET_MAP_POSITION_FOR_A_STEP', o.battle.isMapPage },
        }))
        return makeAction(newstateTypes)
      end

      store.mapType2.checkpositionListForCheck = mapProxy.getCheckpositionList(settings.battleChapter)
      local newstateTypes = c.yield(setScreenListeners(battleListenerList, {
        { 'BATTLE_MAP_PAGE_CHECK_ASSISTANT_MODE', o.battle.isMapPage, 3000 }
      }))
      return makeAction(newstateTypes)
    end

    return nil
  end))
end

return mapsType2

