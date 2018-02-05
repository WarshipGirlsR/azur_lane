local co = require '../lib/co'
local c = coroutine
local stepLabel = require '../utils/step-label'
local makeAction = (require './utils').makeAction
local sleepPromise = require '../utils/sleep-promise'
local moBattle = require '../meta-operation/battle'
local moHome = require '../meta-operation/home'
local setScreenListeners = (require './utils').setScreenListeners
local store = require '../store'

store.battle = store.battle or {}

local o = {
  home = moHome,
  battle = moBattle,
}


local battleListenerList = {
  { '', o.home.isHome, 2000 },
  { 'BATTLE_BATTLE_CHAPTER_PAGE_BACK_TO_HOME', o.home.isBattleChapterPage, 2000 },
}

local battle = function(action)
  local settings = store.settings;
  return co(c.create(function()
    if action.type == 'BATTLE_INIT' then

      return makeAction('BATTLE_START')

    elseif action.type == 'BATTLE_START' then

      stepLabel.setStepLabelContent('2.1.等待桌面')

      local newstateTypes = c.yield(setScreenListeners(battleListenerList, {
        { 'BATTLE_HOME_CLICK_BATTLE', o.home.isHome, 2000 },
      }))
      return makeAction(newstateTypes)

    elseif action.type == 'BATTLE_HOME_CLICK_BATTLE' then

      stepLabel.setStepLabelContent('2.1.点击出击')
      o.battle.clickBattleBtn()
      local newstateTypes = c.yield(setScreenListeners(battleListenerList, {
        { 'BATTLE_HOME_CLICK_BATTLE', o.home.isHome, 2000 },
        { 'BATTLE_BATTLE_CHAPTER_PAGE_SELECT_MODE', o.battle.isBattleChapterPage },
      }))
      return makeAction(newstateTypes)

    elseif action.type == 'BATTLE_BATTLE_CHAPTER_PAGE_SELECT_MODE' then

      stepLabel.setStepLabelContent('2.2.选择章节界面')
      if settings.battleMode == 'normal' and not o.battle.isNormalMode() then
        stepLabel.setStepLabelContent('2.3.切换为普通模式')
      elseif settings.battleMode == 'hard' and not o.battle.isHardMode() then
        stepLabel.setStepLabelContent('2.4.切换为普通模式')
      end

      if (settings.battleMode == 'normal' and not o.battle.isNormalMode())
        or (settings.battleMode == 'hard' and not o.battle.isHardMode()) then
        o.battle.clickSwitchHardModeBtn()

        local newstateTypes = c.yield(setScreenListeners(battleListenerList, {
          { 'BATTLE_BATTLE_CHAPTER_PAGE_SELECT_MODE', o.battle.isBattleChapterPage },
        }))
        return makeAction(newstateTypes)
      end

      local newstateTypes = c.yield(setScreenListeners(battleListenerList, {
        { 'BATTLE_BATTLE_CHAPTER_PAGE_MOVE_TO_CHAPTER', o.battle.isBattleChapterPage },
      }))
      return makeAction(newstateTypes)

    elseif action.type == 'BATTLE_BATTLE_CHAPTER_PAGE_MOVE_TO_CHAPTER' then

      stepLabel.setStepLabelContent('2.2.移动到第' .. settings.battleChapter .. '章')
      o.battle.moveToChapter(settings.battleChapter)

      local newstateTypes = c.yield(setScreenListeners(battleListenerList, {
        { 'BATTLE_BATTLE_CHAPTER_PAGE_MOVE_TO_CHAPTER', o.battle.isBattleChapterPage, 2000 },
        { 'BATTLE_BATTLE_CHAPTER_PAGE_INFO_PANEL_CLICK_INTO', o.battle.isChapterInfoPanel },
      }))
      return makeAction(newstateTypes)

    elseif action.type == 'BATTLE_BATTLE_CHAPTER_PAGE_INFO_PANEL_CLICK_INTO' then

      stepLabel.setStepLabelContent('2.6.章节信息面板')
      stepLabel.setStepLabelContent('2.6.点击继续')
      o.battle.clickGotoSelectFleedPanelBtn()

      local newstateTypes = c.yield(setScreenListeners(battleListenerList, {
        { 'BATTLE_BATTLE_CHAPTER_PAGE_INFO_PANEL_CLICK_INTO', o.battle.isChapterInfoPanel, 2000 },
        { 'BATTLE_BATTLE_CHAPTER_PAGE_SELECT_FLEET_PANEL_SELECT_FLEET', o.battle.isSelectFleetPanel },
        { 'BATTLE_BATTLE_CHAPTER_PAGE_HARD_SELECT_FLEET_PANEL_CLICK_INTO', o.battle.isHardSelectFleetPanel },
      }))
      return makeAction(newstateTypes)

    elseif action.type == 'BATTLE_BATTLE_CHAPTER_PAGE_SELECT_FLEET_PANEL_SELECT_FLEET' then

      stepLabel.setStepLabelContent('2.6.选择舰队面板')
      stepLabel.setStepLabelContent('2.6.检查已选择的舰队')
      local res, selectList, unselectList, selectedFeeldList = o.battle.checkSelectedFleet(settings.battleFleet)
      if not res then
        stepLabel.setStepLabelContent('2-17.选择舰队 ' .. table.concat(settings.battleFleet, ','))
        if #selectedFeeldList <= 1 then
          o.battle.clickFleet(selectList)
        else
          o.battle.clickFleet(unselectList)
        end
        local newstateTypes = c.yield(setScreenListeners(battleListenerList, {
          { 'BATTLE_BATTLE_CHAPTER_PAGE_SELECT_FLEET_PANEL_SELECT_FLEET', o.battle.isSelectFleetPanel, 500 },
          { 'BATTLE_BATTLE_CHAPTER_PAGE_HARD_SELECT_FLEET_PANEL_CLICK_INTO', o.battle.isHardSelectFleetPanel, 500 }
        }))
        return makeAction(newstateTypes)
      end

      stepLabel.setStepLabelContent('2.6.点击进入章节')
      o.battle.clickGotoMapBtn()
      local newstateTypes = c.yield(setScreenListeners(battleListenerList, {
        { 'BATTLE_BATTLE_CHAPTER_PAGE_SELECT_FLEET_PANEL_SELECT_FLEET', o.battle.isSelectFleetPanel, 2000 },
        { 'BATTLE_BATTLE_CHAPTER_PAGE_HARD_SELECT_FLEET_PANEL_CLICK_INTO', o.battle.isHardSelectFleetPanel, 500 },
        { 'BATTLE_MAP_PAGE', o.battle.isMapPage },
      }))
      return makeAction(newstateTypes)

    elseif action.type == 'BATTLE_BATTLE_CHAPTER_PAGE_HARD_SELECT_FLEET_PANEL_CLICK_INTO' then

      stepLabel.setStepLabelContent('2.6.困难选择舰队面板')
      stepLabel.setStepLabelContent('2.6.点击立刻前往')
      o.battle.clickHardGotoSelectFleedPanelBtn()
      local newstateTypes = c.yield(setScreenListeners(battleListenerList, {
        { 'BATTLE_MAP_PAGE', o.battle.isChapterInfoPanel },
      }))
      return makeAction(newstateTypes)

    elseif action.type == 'BATTLE_MAP_PAGE' then

      if settings.battleFleet == '' then
      else
        local newstateTypes = c.yield(setScreenListeners(battleListenerList, {
          { 'BATTLE_MAP_PAGE', o.battle.isChapterInfoPanel },
        }))
        return makeAction(newstateTypes)
      end

    elseif action.type == 'BATTLE_BATTLE_CHAPTER_PAGE_BACK_TO_HOME' then

      o.battle.battlePageClickBackToHome();
    end

    return nil
  end))
end

return battle