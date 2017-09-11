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
    { 'BATTLE_SELECT_FLEET_PANEL_CHECKE_SELECTED_FLEET', 'missionsGroup', map.battle.isSelectFleetPanel, 2000 },
    { 'BATTLE_HARD_SELECT_FLEET_PANEL_CHECKE_SELECTED_FLEET', 'missionsGroup', map.battle.isHardSelectFleetPanel, 2000 },
    { 'MAPS_MAP_GET_MAP_POSITION', 'missionsGroup', map.battle.isMapPage, 3000 },
    { 'BATTLE_MAP_PAGE_AMBUSHED_PANEL', 'missionsGroup', map.battle.isAmbushedPanel },
    { 'BATTLE_MAP_PAGE_READY_BATTLE_PAGE', 'missionsGroup', map.battle.isReadyBattlePage, 1000 },
    { 'BATTLE_IS_AUTO_BATTLE_CONFIRM_PANEL', 'missionsGroup', map.battle.isAutoBattleConfirmPanel },
    { 'BATTLE_IN_BATTLE_PAGE', 'missionsGroup', map.battle.isInBattlePage },
    { 'BATTLE_AUTO_BATTLE_PANEL', 'missionsGroup', map.battle.isNotAutoBattle, 2000 },
    { 'BATTLE_VICTORY_PANEL', 'missionsGroup', map.battle.isVictoryPanel, 2000 },
    { 'BATTLE_GET_PROPS_PANEL', 'missionsGroup', map.battle.isGetPropsPanel, 2000 },
    { 'BATTLE_GET_NEW_SHIP_PANEL', 'missionsGroup', map.battle.isGetNewShipPanel, 2000 },
    { 'BATTLE_GET_EXP_PANEL', 'missionsGroup', map.battle.isGetExpPanel, 2000 },
  }

  return co(c.create(function()
    if action.type == 'MAPS_MAP_START' then
      state.map.checkpositionList = mapProxy.getCheckpositionList(settings.battleChapter)
      state.map.mapChessboard = mapProxy.getMapChessboard(settings.battleChapter)
      state.map.currentPosition = nil
      state.map.isMoveToWaitForBossPosition = true

      stepLabel.setStepLabelContent('3-1.开始移动地图')
      local newstateTypes = c.yield(setScreenListeners({
        { 'MAPS_MAP_GET_MAP_POSITION', 'missionsGroup', map.battle.isMapPage },
      }))
      return makeAction(newstateTypes), state

    elseif action.type == 'MAPS_MAP_GET_MAP_POSITION' then

      stepLabel.setStepLabelContent('3-2.获取地图位置参数')
      state.map.currentPosition = mapProxy.getMapPosition()
      console.log(state.map.currentPosition)
      local newstateTypes = c.yield(setScreenListeners({
        { 'BATTLE_CHAPTER_INFO_PANEL', 'missionsGroup', map.battle.isChapterInfoPanel, 2000 },
        { 'BATTLE_SELECT_FLEET_PANEL_CHECKE_SELECTED_FLEET', 'missionsGroup', map.battle.isSelectFleetPanel, 2000 },
        { 'BATTLE_HARD_SELECT_FLEET_PANEL_CHECKE_SELECTED_FLEET', 'missionsGroup', map.battle.isHardSelectFleetPanel, 2000 },
        { 'MAPS_MAP_GET_MAP_POSITION', 'missionsGroup', map.battle.isMapPage, 3000 },
        { 'BATTLE_MAP_PAGE_AMBUSHED_PANEL', 'missionsGroup', map.battle.isAmbushedPanel },
        { 'BATTLE_MAP_PAGE_READY_BATTLE_PAGE', 'missionsGroup', map.battle.isReadyBattlePage, 1000 },
        { 'BATTLE_IS_AUTO_BATTLE_CONFIRM_PANEL', 'missionsGroup', map.battle.isAutoBattleConfirmPanel },
        { 'BATTLE_IN_BATTLE_PAGE', 'missionsGroup', map.battle.isInBattlePage },
        { 'BATTLE_AUTO_BATTLE_PANEL', 'missionsGroup', map.battle.isNotAutoBattle, 2000 },
        { 'BATTLE_VICTORY_PANEL', 'missionsGroup', map.battle.isVictoryPanel, 2000 },
        { 'BATTLE_GET_PROPS_PANEL', 'missionsGroup', map.battle.isGetPropsPanel, 2000 },
        { 'BATTLE_GET_NEW_SHIP_PANEL', 'missionsGroup', map.battle.isGetNewShipPanel, 2000 },
        { 'BATTLE_GET_EXP_PANEL', 'missionsGroup', map.battle.isGetExpPanel, 2000 },
        { 'MAPS_MAP_MOVE_TO_CHECK_POSITION', 'missionsGroup', map.battle.isMapPage },
      }))
      return makeAction(newstateTypes), state

    elseif action.type == 'MAPS_MAP_MOVE_TO_CHECK_POSITION' then

      stepLabel.setStepLabelContent('3-3.将地图移动到第1个扫面位置')
      local targetPosition = state.map.checkpositionList[1]
      local isCenter = mapProxy.moveMapToCheckPosition(state.map.currentPosition, targetPosition)

      if isCenter then
        local newstateTypes = c.yield(setScreenListeners(battleMap, {
          { 'MAPS_MAP_SCAN_MAP', 'missionsGroup', map.battle.isMapPage, 500 },
        }))
        return makeAction(newstateTypes), state
      else
        local newstateTypes = c.yield(setScreenListeners(battleMap, {
          { 'MAPS_MAP_GET_MAP_POSITION', 'missionsGroup', map.battle.isMapPage, 1000 },
        }))
        return makeAction(newstateTypes), state
      end

    elseif action.type == 'MAPS_MAP_SCAN_MAP' then

      stepLabel.setStepLabelContent('3-4.扫描地图')
      local targetPosition = state.map.checkpositionList[1]
      state.map.mapChessboard = mapProxy.scanMap(targetPosition, state.map.mapChessboard)

      local newstateTypes = c.yield(setScreenListeners(battleMap, {
        { 'MAPS_MAP_MOVE_A_STEP', 'missionsGroup', map.battle.isMapPage, 500 },
      }))
      return makeAction(newstateTypes), state

    elseif action.type == 'MAPS_MAP_MOVE_A_STEP' then

      local targetPosition = state.map.checkpositionList[1]
      local mapChessboard = state.map.mapChessboard
      local myFleetList1 = mapChessboard.myFleetList[1]
      local waitForBossPosition = mapChessboard.waitForBossPosition[1]
      if not waitForBossPosition then
        state.map.isMoveToWaitForBossPosition = false
      end
      if #mapChessboard.bossPosition > 0 then
        state.map.isMoveToWaitForBossPosition = false
        mapProxy.moveToPoint(targetPosition, mapChessboard.bossPosition[1])
      elseif state.map.isMoveToWaitForBossPosition and myFleetList1[1] == waitForBossPosition[1] and myFleetList1[2] == waitForBossPosition[2] then
        state.map.isMoveToWaitForBossPosition = false
      elseif state.map.isMoveToWaitForBossPosition then
        stepLabel.setStepLabelContent('3-4.移动到boss可能出现的位置')
        mapProxy.moveToPoint(targetPosition, mapChessboard.waitForBossPosition[1])
      else
        stepLabel.setStepLabelContent('3-4.移动到最近的敌人')
        local closestEnemy = mapProxy.findClosestEnemy(mapChessboard)
        mapProxy.moveToPoint(targetPosition, closestEnemy)
      end

      local newstateTypes = c.yield(setScreenListeners(battleMap))
      return makeAction(newstateTypes), state
    end

    return nil, state
  end))
end

return function(state)
  state.map = {}
  return map
end