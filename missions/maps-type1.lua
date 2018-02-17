local co = require '../lib/co'
local c = coroutine
local stepLabel = require '../utils/step-label'
local makeAction = (require './utils').makeAction
local sleepPromise = require '../utils/sleep-promise'
local moBattle = require '../meta-operation/battle'
local moHome = require '../meta-operation/home'
local setScreenListeners = (require './utils').setScreenListeners
local store = require '../store'

local o = {
  home = moHome,
  battle = moBattle,
}

local comparePoints = function(point1, point2)
  return point1[1] == point2[1] and point1[2] == point2[2]
end


local mapsType1 = function(action)
  local settings = store.settings;
  local mapProxy = map['map' .. string.gsub(settings.battleChapter, '-', '_')]

  local battleMap = {
    { 'BATTLE_BATTLE_PAGE', o.battle.isBattlePage, 2000 },
    { 'BATTLE_CHAPTER_INFO_PANEL', o.battle.isChapterInfoPanel, 2000 },
    { 'BATTLE_MAP_PAGE_AMBUSHED_PANEL', o.battle.isAmbushedPanel, 2000 },
    { 'BATTLE_MAP_PAGE_READY_BATTLE_PAGE', o.battle.isReadyBattlePage, 1000 },
    { 'BATTLE_IN_BATTLE_PAGE', o.battle.isInBattlePage, 2000 },
    { 'BATTLE_AUTO_BATTLE_PANEL', o.battle.isNotAutoBattle, 2000 },
    { 'BATTLE_VICTORY_PANEL', o.battle.isVictoryPanel, 2000 },
    { 'BATTLE_GET_PROPS_PANEL', o.battle.isGetPropsPanel, 2000 },
    { 'BATTLE_GET_NEW_SHIP_PANEL', o.battle.isGetNewShipPanel, 2000 },
    { 'BATTLE_GET_EXP_PANEL', o.battle.isGetExpPanel, 2000 },
    { { type = 'BATTLE_MAP_PAGE_FORMATION_PANEL', addToStart = true }, map.battle.isFormationPanel },
  }

  return co(c.create(function()
    if action.type == 'MAPS_MAP_START' then
      state.map.checkpositionListForCheck = mapProxy.getCheckpositionList(settings.battleChapter)
      state.map.checkpositionListForMove = state.o.checkpositionListForMove or {}
      -- 获取地图信息。如果上次扫描结果还在，就把敌人列表保留下来
      -- 因为敌人容易被我方舰队覆盖住导致扫描不到
      -- 所以敌人列表在关卡中都不清除，其他列表在每次开始扫描棋盘前会清除。
      state.map.oldMapChessboard = state.map.mapChessboard
      state.map.mapChessboard = state.map.mapChessboard or {}
      local newMapChessBoard = mapProxy.getMapChessboard(settings.battleChapter)
      -- newMapChessBoard.enemyPositionList = state.map.mapChessboard.enemyPositionList or newMapChessBoard.enemyPositionList
      newMapChessBoard.bossPosition = state.map.mapChessboard.bossPosition or newMapChessBoard.bossPosition
      state.map.mapChessboard = newMapChessBoard

      state.map.currentPosition = nil
      state.map.nextStepPoint = nil
      state.map.moveVectorForCheck = { -1, -1 }
      state.map.moveVectorForAStep = { -1, -1 }

      -- 检查上次移动舰队时所在的位置，并将其提前。有利于提高扫描速度
      if #state.map.checkpositionListForMove > 0 then
        local cForMove = state.map.checkpositionListForMove[1]
        local index = table.findIndex(state.map.checkpositionListForCheck, function(cForCheck)
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
          local cfm = state.map.checkpositionListForCheck[index]
          table.remove(state.map.checkpositionListForCheck, index)
          table.insert(state.map.checkpositionListForCheck, 1, cfm)
        end
      end

      stepLabel.setStepLabelContent('3-1.开始移动地图')
      local newstateTypes = c.yield(setScreenListeners({
        { 'MAPS_MAP_GET_MAP_POSITION_FOR_CHECK', o.battle.isMapPage },
      }))
      return makeAction(newstateTypes)

    elseif action.type == 'MAPS_MAP_GET_MAP_POSITION_FOR_CHECK' then

      stepLabel.setStepLabelContent('3-2.获取地图位置参数')
      local targetPosition = state.map.checkpositionListForCheck[1]
      state.map.currentPosition = mapProxy.getMapPosition(targetPosition)
      console.log(state.map.currentPosition)
      local newstateTypes = c.yield(setScreenListeners(battleMap, {
        { 'MAPS_MAP_GET_MOVE_VECTOR_FOR_CHECK', o.battle.isMapPage },
      }))
      return makeAction(newstateTypes)

    elseif action.type == 'MAPS_MAP_GET_MOVE_VECTOR_FOR_CHECK' then

      stepLabel.setStepLabelContent('3-3.计算移动向量')
      local targetPosition = state.map.checkpositionListForCheck[1]
      local newMoveVector, effectiveStep = mapProxy.getMoveVector(state.map.currentPosition, targetPosition)
      if effectiveStep and comparePoints(state.map.moveVectorForCheck, newMoveVector) then
        state.map.moveVectorForCheck = newMoveVector
        local newstateTypes = c.yield(setScreenListeners(battleMap, {
          { 'MAPS_MAP_SCAN_MAP', o.battle.isMapPage, 500 },
        }))
        return makeAction(newstateTypes)
      end
      state.map.moveVectorForCheck = newMoveVector
      local newstateTypes = c.yield(setScreenListeners(battleMap, {
        { 'MAPS_MAP_MOVE_TO_CHECK_POSITION_FOR_CHECK', o.battle.isMapPage },
      }))
      return makeAction(newstateTypes)

    elseif action.type == 'MAPS_MAP_MOVE_TO_CHECK_POSITION_FOR_CHECK' then

      stepLabel.setStepLabelContent('3-4.将地图移动到扫描位置')
      local isCenter = mapProxy.moveMapToCheckPosition(state.map.moveVectorForCheck)

      if isCenter then
        local newstateTypes = c.yield(setScreenListeners(battleMap, {
          { 'MAPS_MAP_SCAN_MAP', o.battle.isMapPage, 500 },
        }))
        return makeAction(newstateTypes)
      else
        local newstateTypes = c.yield(setScreenListeners(battleMap, {
          { 'MAPS_MAP_GET_MAP_POSITION_FOR_CHECK', o.battle.isMapPage },
        }))
        return makeAction(newstateTypes)
      end

    elseif action.type == 'MAPS_MAP_SCAN_MAP' then

      stepLabel.setStepLabelContent('3-5.扫描地图')
      local targetPosition = state.map.checkpositionListForCheck[1]
      state.map.mapChessboard = mapProxy.scanMap(targetPosition, state.map.mapChessboard, state.map.oldMapChessboard)
      console.log(state.map.mapChessboard)
      if #state.map.checkpositionListForCheck > 1 then
        table.remove(state.map.checkpositionListForCheck, 1)
        local newstateTypes = c.yield(setScreenListeners(battleMap, {
          { 'MAPS_MAP_GET_MAP_POSITION_FOR_CHECK', o.battle.isMapPage },
        }))
        return makeAction(newstateTypes)
      end
      local newstateTypes = c.yield(setScreenListeners(battleMap, {
        { 'MAPS_MAP_GET_NEXT_STEP', o.battle.isMapPage },
      }))
      return makeAction(newstateTypes)

    elseif action.type == 'MAPS_MAP_GET_NEXT_STEP' then

      stepLabel.setStepLabelContent('3-6.计算下一步往哪走')
      local mapChessboard = state.map.mapChessboard
      local myFleetList = mapChessboard.myFleetList
      local inBattleList = mapChessboard.inBattleList
      local waitForBossPosition = mapChessboard.waitForBossPosition[1]
      if not waitForBossPosition then
        state.battle.moveState = 'moveToClosestEnemy'
      end
      if table.findIndex(inBattleList, function(ele) return comparePoints(ele, myFleetList[1]) end) > -1 then
        stepLabel.setStepLabelContent('3-7.开始战斗')
        o.battle.clickAttackBtn()
      elseif #mapChessboard.bossPosition > 0 then
        stepLabel.setStepLabelContent('3-8.移动到boss位置')
        state.battle.moveState = 'moveToBoss'
        state.map.nextStepPoint = mapProxy.checkMoveToPointPath(mapChessboard, mapChessboard.myFleetList[1], mapChessboard.bossPosition[1])
      elseif state.battle.moveState == 'moveToWaitBoss' and table.findIndex(myFleetList, function(ele) return comparePoints(ele, waitForBossPosition) end) > -1 then
        state.battle.moveState = 'moveToClosestEnemy'
        local newstateTypes = c.yield(setScreenListeners(battleMap, {
          { 'MAPS_MAP_GET_NEXT_STEP', o.battle.isMapPage },
        }))
        return makeAction(newstateTypes)
      elseif state.battle.moveState == 'moveToWaitBoss' then
        stepLabel.setStepLabelContent('3-9.移动待命位置')
        state.map.nextStepPoint = mapProxy.checkMoveToPointPath(mapChessboard, mapChessboard.myFleetList[1], mapChessboard.waitForBossPosition[1])
      else
        stepLabel.setStepLabelContent('3-10.移动到最近的敌人')
        state.battle.moveState = 'moveToClosestEnemy'
        local closestEnemy = mapProxy.findClosestEnemy(mapChessboard)
        state.map.nextStepPoint = closestEnemy
      end
      -- 如果还是没有移动目标，则可能是我方舰队挡住了敌人，此时需要随意移动一步
      -- 尽可能避开敌人
      if not state.map.nextStepPoint then
        stepLabel.setStepLabelContent('3-11.随机移动一步')
        state.map.nextStepPoint = mapProxy.getRandomMoveAStep(mapChessboard)
      end
      console.log(state.map.nextStepPoint)
      -- 如果还是没有移动目标，只好重新扫描
      if not state.map.nextStepPoint then
        local newstateTypes = c.yield(setScreenListeners(battleMap, {
          { 'MAPS_MAP_START', o.battle.isMapPage },
        }))
        return makeAction(newstateTypes)
      end

      -- 查找目标点在哪个界面
      state.map.checkpositionListForMove = mapProxy.getCheckpositionList(settings.battleChapter)
      for _, targetPosition in ipairs(state.map.checkpositionListForMove) do
        local nextRowNum = state.map.nextStepPoint[1]
        local nextColNum = state.map.nextStepPoint[2]
        if targetPosition.pointMap[nextRowNum .. '-' .. nextColNum] then
          state.map.checkpositionListForMove = { targetPosition }
          break;
        end
      end

      local newstateTypes = c.yield(setScreenListeners(battleMap, {
        { 'BATTLE_MAP_PAGE_SELECT_FLEET', o.battle.isMapPage },
      }))
      return makeAction(newstateTypes)

    elseif action.type == 'MAPS_MAP_GET_MAP_POSITION_FOR_A_STEP' then

      stepLabel.setStepLabelContent('3-11.获取地图位置参数')
      local targetPosition = state.map.checkpositionListForMove[1]
      state.map.currentPosition = mapProxy.getMapPosition(targetPosition)
      console.log(state.map.currentPosition)
      local newstateTypes = c.yield(setScreenListeners(battleMap, {
        { 'MAPS_MAP_GET_MOVE_VECTOR_FOR_A_STEP', o.battle.isMapPage },
      }))
      return makeAction(newstateTypes)

    elseif action.type == 'MAPS_MAP_GET_MOVE_VECTOR_FOR_A_STEP' then

      stepLabel.setStepLabelContent('3-12.计算移动向量')
      local targetPosition = state.map.checkpositionListForMove[1]
      local newMoveVector, effectiveStep = mapProxy.getMoveVector(state.map.currentPosition, targetPosition)
      if effectiveStep and comparePoints(state.map.moveVectorForAStep, newMoveVector) then
        state.map.moveVectorForAStep = newMoveVector
        local newstateTypes = c.yield(setScreenListeners(battleMap, {
          { 'MAPS_MAP_MOVE_A_STEP', o.battle.isMapPage, 500 },
        }))
        return makeAction(newstateTypes)
      end
      state.map.moveVectorForAStep = newMoveVector
      local newstateTypes = c.yield(setScreenListeners(battleMap, {
        { 'MAPS_MAP_MOVE_TO_CHECK_POSITION_FOR_A_STEP', o.battle.isMapPage },
      }))
      return makeAction(newstateTypes)

    elseif action.type == 'MAPS_MAP_MOVE_TO_CHECK_POSITION_FOR_A_STEP' then

      stepLabel.setStepLabelContent('3-13.将地图移动到移动位置')
      local isCenter = mapProxy.moveMapToCheckPosition(state.map.moveVectorForAStep)
      if isCenter then
        local newstateTypes = c.yield(setScreenListeners(battleMap, {
          { 'MAPS_MAP_MOVE_A_STEP', o.battle.isMapPage, 500 },
        }))
        return makeAction(newstateTypes)
      else
        local newstateTypes = c.yield(setScreenListeners(battleMap, {
          { 'MAPS_MAP_GET_MAP_POSITION_FOR_A_STEP', o.battle.isMapPage, 1000 },
        }))
        return makeAction(newstateTypes)
      end

    elseif action.type == 'MAPS_MAP_MOVE_A_STEP' then

      stepLabel.setStepLabelContent('3-14.移动舰队位置')
      local targetPosition = state.map.checkpositionListForMove[1]
      local nextRowNum = state.map.nextStepPoint[1]
      local nextColNum = state.map.nextStepPoint[2]
      if targetPosition.pointMap[nextRowNum .. '-' .. nextColNum] then
        mapProxy.moveToPoint(targetPosition, state.map.nextStepPoint)
        o.battle.clickAttackBtn()
      elseif #state.map.checkpositionListForMove > 0 then
        local newstateTypes = c.yield(setScreenListeners(battleMap, {
          { 'MAPS_MAP_GET_MAP_POSITION_FOR_A_STEP', o.battle.isMapPage },
        }))
        return makeAction(newstateTypes)
      end

      state.map.checkpositionListForCheck = mapProxy.getCheckpositionList(settings.battleChapter)
      local newstateTypes = c.yield(setScreenListeners(battleMap, {
        { 'BATTLE_MAP_PAGE_CHECK_ASSISTANT_MODE', o.battle.isMapPage, 3000 }
      }))
      return makeAction(newstateTypes)
    end

    return nil
  end))
end

return mapsType1
