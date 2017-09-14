local co = require 'Co'
local c = coroutine
local stepLabel = require 'StepLabel'
local makeAction = (require 'GoMission__utils').makeAction
local sleepPromise = (require 'GoMission__utils').sleepPromise
local setScreenListeners = (require 'GoMission__utils').setScreenListeners
local allOptions = require 'GoMission__options'
local getHomeListener = (require 'GoMission__commonListener').getHomeListener
local getLoginListener = (require 'GoMission__commonListener').getLoginListener
local getComListener = (require 'GoMission__commonListener').getComListener

local comparePoints = function(point1, point2)
  return point1[1] == point2[1] and point1[2] == point2[2]
end


local map = function(action, state)
  local map = allOptions.map
  local settings = allOptions.settings
  local chapterArr = strSplit(settings.battleChapter, "-")
  local m = tonumber(chapterArr[1]) or 1
  local n = tonumber(chapterArr[2]) or 1
  local mapProxy = map['map' .. m .. '_' .. n]

  local battleMap = {
    { 'BATTLE_BATTLE_PAGE', 'missionsGroup', map.battle.isBattlePage, 2000 },
    { 'BATTLE_CHAPTER_INFO_PANEL', 'missionsGroup', map.battle.isChapterInfoPanel, 2000 },
    { 'BATTLE_MAP_PAGE_AMBUSHED_PANEL', 'missionsGroup', map.battle.isAmbushedPanel, 2000 },
    { 'BATTLE_MAP_PAGE_READY_BATTLE_PAGE', 'missionsGroup', map.battle.isReadyBattlePage, 1000 },
    { 'BATTLE_IN_BATTLE_PAGE', 'missionsGroup', map.battle.isInBattlePage, 2000 },
    { 'BATTLE_AUTO_BATTLE_PANEL', 'missionsGroup', map.battle.isNotAutoBattle, 2000 },
    { 'BATTLE_VICTORY_PANEL', 'missionsGroup', map.battle.isVictoryPanel, 2000 },
    { 'BATTLE_GET_PROPS_PANEL', 'missionsGroup', map.battle.isGetPropsPanel, 2000 },
    { 'BATTLE_GET_NEW_SHIP_PANEL', 'missionsGroup', map.battle.isGetNewShipPanel, 2000 },
    { 'BATTLE_GET_EXP_PANEL', 'missionsGroup', map.battle.isGetExpPanel, 2000 },
  }

  return co(c.create(function()
    if action.type == 'MAPS_MAP_START' then
      state.map.checkpositionListForCheck = mapProxy.getCheckpositionList(settings.battleChapter)
      state.map.checkpositionListForMove = mapProxy.getCheckpositionList(settings.battleChapter)
      state.map.mapChessboard = mapProxy.getMapChessboard(settings.battleChapter)
      state.map.currentPosition = nil
      -- state.map.isMoveToWaitForBossPosition 在battle里初始化，因为每个关卡才会重置一次这个状态
      state.map.nextStepPoint = nil
      state.map.moveVectorForCheck = { -1, -1 }
      state.map.moveVectorForAStep = { -1, -1 }

      stepLabel.setStepLabelContent('3-1.开始移动地图')
      local newstateTypes = c.yield(setScreenListeners({
        { 'MAPS_MAP_GET_MAP_POSITION_FOR_CHECK', 'missionsGroup', map.battle.isMapPage },
      }))
      return makeAction(newstateTypes), state

    elseif action.type == 'MAPS_MAP_GET_MAP_POSITION_FOR_CHECK' then

      stepLabel.setStepLabelContent('3-2.获取地图位置参数')
      state.map.currentPosition = mapProxy.getMapPosition()
      local newstateTypes = c.yield(setScreenListeners(battleMap, {
        { 'MAPS_MAP_GET_MOVE_VECTOR_FOR_CHECK', 'missionsGroup', map.battle.isMapPage },
      }))
      return makeAction(newstateTypes), state

    elseif action.type == 'MAPS_MAP_GET_MOVE_VECTOR_FOR_CHECK' then

      stepLabel.setStepLabelContent('3-2.计算移动向量')
      local targetPosition = state.map.checkpositionListForCheck[1]
      local newMoveVector = mapProxy.getMoveVector(state.map.currentPosition, targetPosition)
      if comparePoints(state.map.moveVectorForCheck, newMoveVector) then
        local newstateTypes = c.yield(setScreenListeners(battleMap, {
          { 'MAPS_MAP_SCAN_MAP', 'missionsGroup', map.battle.isMapPage },
        }))
        return makeAction(newstateTypes), state
      end
      state.map.moveVectorForCheck = newMoveVector
      local newstateTypes = c.yield(setScreenListeners(battleMap, {
        { 'MAPS_MAP_MOVE_TO_CHECK_POSITION_FOR_CHECK', 'missionsGroup', map.battle.isMapPage },
      }))
      return makeAction(newstateTypes), state

    elseif action.type == 'MAPS_MAP_MOVE_TO_CHECK_POSITION_FOR_CHECK' then

      stepLabel.setStepLabelContent('3-3.将地图移动到扫描位置')
      local isCenter = mapProxy.moveMapToCheckPosition(state.map.moveVectorForCheck)

      if isCenter then
        local newstateTypes = c.yield(setScreenListeners(battleMap, {
          { 'MAPS_MAP_SCAN_MAP', 'missionsGroup', map.battle.isMapPage },
        }))
        return makeAction(newstateTypes), state
      else
        local newstateTypes = c.yield(setScreenListeners(battleMap, {
          { 'MAPS_MAP_GET_MAP_POSITION_FOR_CHECK', 'missionsGroup', map.battle.isMapPage },
        }))
        return makeAction(newstateTypes), state
      end

    elseif action.type == 'MAPS_MAP_SCAN_MAP' then

      stepLabel.setStepLabelContent('3-4.扫描地图')
      local targetPosition = state.map.checkpositionListForCheck[1]
      state.map.mapChessboard = mapProxy.scanMap(targetPosition, state.map.mapChessboard)

      if #state.map.checkpositionListForCheck > 1 then
        table.remove(state.map.checkpositionListForCheck, 1)
        local newstateTypes = c.yield(setScreenListeners(battleMap, {
          { 'MAPS_MAP_GET_MAP_POSITION_FOR_CHECK', 'missionsGroup', map.battle.isMapPage },
        }))
        return makeAction(newstateTypes), state
      end
      local newstateTypes = c.yield(setScreenListeners(battleMap, {
        { 'MAPS_MAP_GET_NEXT_STEP', 'missionsGroup', map.battle.isMapPage },
      }))
      return makeAction(newstateTypes), state

    elseif action.type == 'MAPS_MAP_GET_NEXT_STEP' then

      stepLabel.setStepLabelContent('3-4.计算下一步往哪走')
      local mapChessboard = state.map.mapChessboard
      local myFleetList = mapChessboard.myFleetList
      local waitForBossPosition = mapChessboard.waitForBossPosition[1]
      if not waitForBossPosition then
        state.map.isMoveToWaitForBossPosition = false
      end
      if #mapChessboard.bossPosition > 0 then
        stepLabel.setStepLabelContent('3-4.移动到boss位置')
        state.map.isMoveToWaitForBossPosition = false
        state.map.nextStepPoint = mapChessboard.bossPosition[1]
      elseif state.map.isMoveToWaitForBossPosition and table.findIndex(myFleetList, function(ele) return comparePoints(ele, waitForBossPosition) end) > -1 then
        state.map.isMoveToWaitForBossPosition = false
        local newstateTypes = c.yield(setScreenListeners(battleMap, {
          { 'MAPS_MAP_GET_NEXT_STEP', 'missionsGroup', map.battle.isMapPage },
        }))
        return makeAction(newstateTypes), state
      elseif state.map.isMoveToWaitForBossPosition then
        stepLabel.setStepLabelContent('3-5.移动待命位置')
        state.map.nextStepPoint = mapChessboard.waitForBossPosition[1]
      else
        stepLabel.setStepLabelContent('3-6.移动到最近的敌人')
        state.map.isMoveToWaitForBossPosition = false
        local closestEnemy = mapProxy.findClosestEnemy(mapChessboard)
        state.map.nextStepPoint = closestEnemy
      end

      if not state.map.nextStepPoint then
        local newstateTypes = c.yield(setScreenListeners(battleMap, {
          { 'MAPS_MAP_START', 'missionsGroup', map.battle.isMapPage },
        }))
        return makeAction(newstateTypes), state
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
        { 'MAPS_MAP_GET_MAP_POSITION_FOR_A_STEP', 'missionsGroup', map.battle.isMapPage },
      }))
      return makeAction(newstateTypes), state

    elseif action.type == 'MAPS_MAP_GET_MAP_POSITION_FOR_A_STEP' then

      stepLabel.setStepLabelContent('3-7.获取地图位置参数')
      state.map.currentPosition = mapProxy.getMapPosition()
      local newstateTypes = c.yield(setScreenListeners(battleMap, {
        { 'MAPS_MAP_GET_MOVE_VECTOR_FOR_A_STEP', 'missionsGroup', map.battle.isMapPage },
      }))
      return makeAction(newstateTypes), state

    elseif action.type == 'MAPS_MAP_GET_MOVE_VECTOR_FOR_A_STEP' then

      stepLabel.setStepLabelContent('3-8.计算移动向量')
      local targetPosition = state.map.checkpositionListForMove[1]
      local newMoveVector = mapProxy.getMoveVector(state.map.currentPosition, targetPosition)

      if state.map.moveVectorForAStep[1] == newMoveVector[1] and state.map.moveVectorForAStep[2] == newMoveVector[2] then
        local newstateTypes = c.yield(setScreenListeners(battleMap, {
          { 'MAPS_MAP_MOVE_A_STEP', 'missionsGroup', map.battle.isMapPage },
        }))
        return makeAction(newstateTypes), state
      end
      state.map.moveVectorForAStep = newMoveVector
      local newstateTypes = c.yield(setScreenListeners(battleMap, {
        { 'MAPS_MAP_MOVE_TO_CHECK_POSITION_FOR_A_STEP', 'missionsGroup', map.battle.isMapPage },
      }))
      return makeAction(newstateTypes), state

    elseif action.type == 'MAPS_MAP_MOVE_TO_CHECK_POSITION_FOR_A_STEP' then

      stepLabel.setStepLabelContent('3-8.将地图移动到移动位置')
      local isCenter = mapProxy.moveMapToCheckPosition(state.map.moveVectorForAStep)

      if isCenter then
        local newstateTypes = c.yield(setScreenListeners(battleMap, {
          { 'MAPS_MAP_MOVE_A_STEP', 'missionsGroup', map.battle.isMapPage, 500 },
        }))
        return makeAction(newstateTypes), state
      else
        local newstateTypes = c.yield(setScreenListeners(battleMap, {
          { 'MAPS_MAP_GET_MAP_POSITION_FOR_A_STEP', 'missionsGroup', map.battle.isMapPage, 1000 },
        }))
        return makeAction(newstateTypes), state
      end

    elseif action.type == 'MAPS_MAP_MOVE_A_STEP' then

      stepLabel.setStepLabelContent('3-9.移动地图位置')
      local targetPosition = state.map.checkpositionListForMove[1]
      local nextRowNum = state.map.nextStepPoint[1]
      local nextColNum = state.map.nextStepPoint[2]
      if targetPosition.pointMap[nextRowNum .. '-' .. nextColNum] then
        mapProxy.moveToPoint(targetPosition, state.map.nextStepPoint)
      elseif #state.map.checkpositionListForMove > 0 then
        table.remove(state.map.checkpositionListForMove, 1)
        local newstateTypes = c.yield(setScreenListeners(battleMap, {
          { 'MAPS_MAP_GET_MAP_POSITION_FOR_A_STEP', 'missionsGroup', map.battle.isMapPage },
        }))
        return makeAction(newstateTypes), state
      end

      state.map.checkpositionListForCheck = mapProxy.getCheckpositionList(settings.battleChapter)
      local newstateTypes = c.yield(setScreenListeners(battleMap, {
        { 'MAPS_MAP_START', 'missionsGroup', map.battle.isMapPage, 3000 }
      }))
      return makeAction(newstateTypes), state
    end

    return nil, state
  end))
end

return function(state)
  state.map = {}
  return map
end