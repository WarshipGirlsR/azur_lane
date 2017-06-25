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


local battleOnce = function(action, state)
  local map = allOptions.map
  local settings = allOptions.settings

  return co(c.create(function()
    if (action.type == 'BATTLE_START') then

      state.battle.selectFleedCount = 0

      if (#settings.battleChapter < 1) then
        stepLabel.setStepLabelContent('2-1.没有选中章节')
        return nil, state
      end

      stepLabel.setStepLabelContent('2-1.等待HOME')
      local newstateTypes = c.yield(setScreenListeners({
        { 'BATTLE_HOME_CLICK_BATTLE', 'missionsGroup', map.home.isHome },
      }))
      return makeAction(newstateTypes), state

    elseif (action.type == 'BATTLE_HOME_CLICK_BATTLE') then

      stepLabel.setStepLabelContent('2-2.点击出征')
      map.home.clickBattleBtn()
      stepLabel.setStepLabelContent('2-3.等待出征页面')

      local newstateTypes = c.yield(setScreenListeners(getComListener(), {
        { 'BATTLE_HOME_CLICK_BATTLE', 'missionsGroup', map.home.isHome, 2000 },
        { 'BATTLE_BATTLE_PAGE', 'missionsGroup', map.battle.isBattlePage },
      }))
      return makeAction(newstateTypes), state

    elseif (action.type == 'BATTLE_BATTLE_PAGE') then

      if (#settings.battleChapter > 1) then
        state.battle.battleChapter = table.remove(settings.battleChapter, 1)
        table.insert(settings.battleChapter, state.battle.battleChapter)
      else
        state.battle.battleChapter = settings.battleChapter[1]
      end

      stepLabel.setStepLabelContent('2-6.移动到章节' .. state.battle.battleChapter)
      map.battle.moveToChapter(state.battle.battleChapter)
      c.yield(sleepPromise(1000))
      console.log('asdfg')

      local newstateTypes = c.yield(setScreenListeners({
        { 'BATTLE_BATTLE_PAGE', 'missionsGroup', map.battle.isBattlePage, 2000 },
        { 'BATTLE_CHAPTER_INFO_PANEL', 'missionsGroup', map.battle.isChapterInfoPanel },
        { 'BATTLE_SELECT_FLEET_PANEL', 'missionsGroup', map.battle.isSelectFleetPanel },
      }))
      console.log(newstateTypes)
      return makeAction(newstateTypes), state

    elseif (action.type == 'BATTLE_CHAPTER_INFO_PANEL') then

      stepLabel.setStepLabelContent('2-9.章节信息面板')
      stepLabel.setStepLabelContent('2-9.进入章节')
      map.battle.clickGotoSelectFleedPanelBtn()

      local newstateTypes = c.yield(setScreenListeners({
        { 'BATTLE_BATTLE_PAGE', 'missionsGroup', map.battle.isBattlePage, 2000 },
        { 'BATTLE_CHAPTER_INFO_PANEL', 'missionsGroup', map.battle.isChapterInfoPanel, 2000 },
        { 'BATTLE_SELECT_FLEET_PANEL_CHECKE_SELECTED_FLEET', 'missionsGroup', map.battle.isSelectFleetPanel },
      }))
      return makeAction(newstateTypes), state

    elseif (action.type == 'BATTLE_SELECT_FLEET_PANEL_CHECKE_SELECTED_FLEET') then

      state.battle.selectFleedCount = state.battle.selectFleedCount + 1

      stepLabel.setStepLabelContent('2-9.检测已经选择的舰队')
      local selectedFleet, needChange = map.battle.checkSelectedFleet(settings.battleFleet)
      state.selectedFleet = selectedFleet

      if ((needChange == 'selectedNeed') and (state.battle.selectFleedCount < 3)) then
        local newstateTypes = c.yield(setScreenListeners({
          { 'BATTLE_BATTLE_PAGE', 'missionsGroup', map.battle.isBattlePage, 2000 },
          { 'BATTLE_CHAPTER_INFO_PANEL', 'missionsGroup', map.battle.isChapterInfoPanel, 2000 },
          { 'BATTLE_SELECT_FLEET_PANEL_SELECT_NEED_FLEET', 'missionsGroup', map.battle.isSelectFleetPanel }
        }))
        return makeAction(newstateTypes), state
      elseif ((needChange == 'unSelectedNoNeed') and (state.battle.selectFleedCount < 3)) then
        local newstateTypes = c.yield(setScreenListeners({
          { 'BATTLE_BATTLE_PAGE', 'missionsGroup', map.battle.isBattlePage, 2000 },
          { 'BATTLE_CHAPTER_INFO_PANEL', 'missionsGroup', map.battle.isChapterInfoPanel, 2000 },
          { 'BATTLE_SELECT_FLEET_PANEL_UNSELECT_NONEED_FLEET', 'missionsGroup', map.battle.isSelectFleetPanel }
        }))
        return makeAction(newstateTypes), state
      end

      map.battle.clickGotoMapBtn()
      local newstateTypes = c.yield(setScreenListeners({
        { 'BATTLE_BATTLE_PAGE', 'missionsGroup', map.battle.isBattlePage, 2000 },
        { 'BATTLE_CHAPTER_INFO_PANEL', 'missionsGroup', map.battle.isChapterInfoPanel, 2000 },
        { 'BATTLE_SELECT_FLEET_PANEL_CHECKE_SELECTED_FLEET', 'missionsGroup', map.battle.isSelectFleetPanel, 2000 },
        { 'BATTLE_MAP_PAGE', 'missionsGroup', map.battle.isMapPage },
      }))
      return makeAction(newstateTypes), state

    elseif (action.type == 'BATTLE_SELECT_FLEET_PANEL_SELECT_NEED_FLEET') then

      stepLabel.setStepLabelContent('2-10.选择舰队 ' .. table.concat(settings.battleFleet, ',') .. ' 队')
      map.battle.selectNeedFleet(settings.battleFleet, state.selectedFleet)

      local newstateTypes = c.yield(setScreenListeners({
        { 'BATTLE_BATTLE_PAGE', 'missionsGroup', map.battle.isBattlePage, 2000 },
        { 'BATTLE_CHAPTER_INFO_PANEL', 'missionsGroup', map.battle.isChapterInfoPanel, 2000 },
        { 'BATTLE_SELECT_FLEET_PANEL_CHECKE_SELECTED_FLEET', 'missionsGroup', map.battle.isSelectFleetPanel },
      }))
      return makeAction(newstateTypes), state

    elseif (action.type == 'BATTLE_SELECT_FLEET_PANEL_UNSELECT_NONEED_FLEET') then

      stepLabel.setStepLabelContent('2-10.选择舰队 ' .. table.concat(settings.battleFleet, ',') .. ' 队')
      map.battle.unselectNoNeedFleet(settings.battleFleet, state.selectedFleet)

      local newstateTypes = c.yield(setScreenListeners({
        { 'BATTLE_BATTLE_PAGE', 'missionsGroup', map.battle.isBattlePage, 2000 },
        { 'BATTLE_CHAPTER_INFO_PANEL', 'missionsGroup', map.battle.isChapterInfoPanel, 2000 },
        { 'BATTLE_SELECT_FLEET_PANEL_CHECKE_SELECTED_FLEET', 'missionsGroup', map.battle.isSelectFleetPanel },
      }))
      return makeAction(newstateTypes), state

    elseif (action.type == 'BATTLE_MAP_PAGE') then
      console.log('map page');
    end

    return nil, state
  end))
end

return function(state)
  state.battle = {}
  return battleOnce
end