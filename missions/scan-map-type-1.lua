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
store.scanMapType1 = store.scanMapType1 or {
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
  local mapProxy = o.map['map' .. settings.battleChapter]
  return co(c.create(function()
    if action.type == 'SCAN_MAP_TYPE_1_PRE_INIT' then

      -- 这部分流程只会在每次开启新的一局时才调用一次，而不是每次寻路就调用一次

      stepLabel.setStepLabelContent('3-1.开局预备变量')
      store.scanMapType1.selectFleedCount = 0
      -- boss舰队是否在boss区域
      store.scanMapType1.isBossFleetInBossArea = false
      store.scanMapType1.battleNum = 0
      store.scanMapType1.battleWithConvoyNum = 0
      store.scanMapType1.battleFromState = ''
      -- 切换船的次数，如果超过4次没切换成功表示舰队沉了。
      store.scanMapType1.changeFleetNum = 0
      -- 舰队移动的状态。
      store.scanMapType1.missionStep = 'onWayFleetMoveToWaitBoss'
      store.scanMapType1.checkpositionListForCheck = nil
      store.scanMapType1.checkpositionListForMove = {}
      store.scanMapType1.mapChessboard = mapProxy and mapProxy.getMapChessboard(settings.battleChapter) or {}
      store.scanMapType1.newMapChessboard = mapProxy and mapProxy.getMapChessboard(settings.battleChapter) or {}

      return makeAction('')

    elseif action.type == 'SCAN_MAP_TYPE_1_INIT' then

      -- 每次进入地图页面时就会执行一次

      store.scanMapType1.checkpositionListForCheck = mapProxy.getCheckpositionList()
      -- 先用 newMapChessboard 完成扫描，然后再与 mapChessboard 合并。这样就可以做新老版本的对比，避免被挡住的问题
      store.scanMapType1.newMapChessboard = mapProxy.getMapChessboard(settings.battleChapter)
      return makeAction('SCAN_MAP_TYPE_1_START')

    elseif action.type == 'SCAN_MAP_TYPE_1_START' then

      -- 检查上次移动舰队时所在的位置，并将其提前。有利于提高扫描速度
      if #store.scanMapType1.checkpositionListForMove > 0 then
        local cForMove = store.scanMapType1.checkpositionListForMove[1]
        local index = table.findIndex(store.scanMapType1.checkpositionListForCheck, function(cForCheck)
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
          local cfm = store.scanMapType1.checkpositionListForCheck[index]
          table.remove(store.scanMapType1.checkpositionListForCheck, index)
          table.insert(store.scanMapType1.checkpositionListForCheck, 1, cfm)
        end
      end
      return makeAction('SCAN_MAP_TYPE_1_MOVE_TO_CHECK_POSITION_FOR_CHECK')

    elseif action.type == 'SCAN_MAP_TYPE_1_MOVE_TO_CHECK_POSITION_FOR_CHECK' then

      stepLabel.setStepLabelContent('3-2.获取地图位置参数')
      local targetPosition = store.scanMapType1.checkpositionListForCheck[1]
      local currentPosition = mapProxy.getMapPosition(targetPosition)
      console.log(currentPosition)
      stepLabel.setStepLabelContent('3-3.计算移动向量')
      local targetPosition = store.scanMapType1.checkpositionListForCheck[1]
      local newMoveVector, effectiveStep = mapProxy.getMoveVector(currentPosition, targetPosition)
      console.log(newMoveVector)
      if effectiveStep and comparePoints(store.scanMapType1.moveVectorForCheck, newMoveVector) then
        store.scanMapType1.moveVectorForCheck = newMoveVector
        local newstateTypes = c.yield(setScreenListeners(battleListenerList, {
          { 'SCAN_MAP_TYPE_1_SCAN_MAP', o.battle.isMapPage, 1000 },
        }))
        return makeAction(newstateTypes)
      end

      stepLabel.setStepLabelContent('3-3.移动地图')
      local isCenter = mapProxy.moveMapToCheckPosition(newMoveVector)
      if isCenter then
        -- 地图已经移动到位
        local newstateTypes = c.yield(setScreenListeners(battleListenerList, {
          { 'SCAN_MAP_TYPE_1_SCAN_MAP', o.battle.isMapPage, 1000 },
        }))
        return makeAction(newstateTypes)
      else
        -- 地图没有移动到位
        local newstateTypes = c.yield(setScreenListeners(battleListenerList, {
          { 'SCAN_MAP_TYPE_1_MOVE_TO_CHECK_POSITION_FOR_CHECK', o.battle.isMapPage, 500 },
        }))
        return makeAction(newstateTypes)
      end
      console.log(newMoveVector)
      store.scanMapType1.moveVectorForCheck = newMoveVector
      local newstateTypes = c.yield(setScreenListeners(battleListenerList, {
        { 'SCAN_MAP_TYPE_1_MOVE_TO_CHECK_POSITION_FOR_CHECK', o.battle.isMapPage, 500 },
      }))
      return makeAction(newstateTypes)

    elseif action.type == 'SCAN_MAP_TYPE_1_SCAN_MAP' then

      stepLabel.setStepLabelContent('3-5.扫描地图')
      local targetPosition = store.scanMapType1.checkpositionListForCheck[1]
      store.scanMapType1.newMapChessboard = mapProxy.scanMap(targetPosition, store.scanMapType1.newMapChessboard)
      console.log(store.scanMapType1.newMapChessboard)
      -- 地图没扫描完，继续扫描
      if #store.scanMapType1.checkpositionListForCheck > 1 then
        table.remove(store.scanMapType1.checkpositionListForCheck, 1)
        local newstateTypes = c.yield(setScreenListeners(battleListenerList, {
          { 'SCAN_MAP_TYPE_1_MOVE_TO_CHECK_POSITION_FOR_CHECK', o.battle.isMapPage },
        }))
        return makeAction(newstateTypes)
      end

      -- 扫描完毕，将 newMapChessboard 与 mapChessboard 合并
      store.scanMapType1.mapChessboard = mapProxy.assignMapChessboard(store.scanMapType1.mapChessboard, store.scanMapType1.newMapChessboard)

      -- 将道中队和boss队分位置别标记
      if not store.scanMapType1.mapChessboard.myFleetList[2] then
        store.scanMapType1.mapChessboard.bossFleet = store.scanMapType1.mapChessboard.myFleetList[1]
        store.scanMapType1.mapChessboard.onWayFleet = store.scanMapType1.mapChessboard.myFleetList[1]
      elseif o.battle.isSelectedFleed(settings.battleFleet[1]) then
        store.scanMapType1.mapChessboard.bossFleet = store.scanMapType1.mapChessboard.myFleetList[1]
        store.scanMapType1.mapChessboard.onWayFleet = store.scanMapType1.mapChessboard.myFleetList[2]
      else
        store.scanMapType1.mapChessboard.bossFleet = store.scanMapType1.mapChessboard.myFleetList[2]
        store.scanMapType1.mapChessboard.onWayFleet = store.scanMapType1.mapChessboard.myFleetList[1]
      end

      console.log(store.scanMapType1.mapChessboard)
      -- 如果扫描内容是空的，重新扫描
      if #store.scanMapType1.mapChessboard.myFleetList == 0 then
        local newstateTypes = c.yield(setScreenListeners(battleListenerList, {
          { 'SCAN_MAP_TYPE_1_INIT', o.battle.isMapPage },
        }))
      end

      -- 进入移动步骤
      local newstateTypes = c.yield(setScreenListeners(battleListenerList, {
        { 'BATTLE_MAP_PAGE_CHECK_MAP_MODE', o.battle.isMapPage },
      }))
      return makeAction(newstateTypes)
    end

    return nil
  end))
end

return mapsType2

