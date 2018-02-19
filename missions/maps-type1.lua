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

local o = {
  home = moHome,
  battle = moBattle,
  map = moMap,
}

local comparePoints = function(point1, point2)
  return point1[1] == point2[1] and point1[2] == point2[2]
end


local mapsType1 = function(action)
  local settings = store.settings;
  local mapProxy = o.map['map' .. settings.battleChapter]
  local state = store
  state.map = state.map or {}

  local battleMap = {
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

  return co(c.create(function()
    if action.type == 'MAPS_TYPE1_INIT' then

      return makeAction('MAPS_TYPE1_START')

    elseif action.type == 'MAPS_TYPE1_START' then


    elseif action.type == 'MAPS_TYPE1_MOVE_A_STEP' then

      stepLabel.setStepLabelContent('3-14.移动舰队位置')
      local targetPosition = state.map.checkpositionListForMove[1]
      local nextRowNum = state.map.nextStepPoint[1]
      local nextColNum = state.map.nextStepPoint[2]
      if targetPosition.pointMap[nextRowNum .. '-' .. nextColNum] then
        mapProxy.moveToPoint(targetPosition, state.map.nextStepPoint)
        o.battle.clickAttackBtn()
      elseif #state.map.checkpositionListForMove > 0 then
        local newstateTypes = c.yield(setScreenListeners(battleMap, {
          { 'MAPS_TYPE1_GET_MAP_POSITION_FOR_A_STEP', o.battle.isMapPage },
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
