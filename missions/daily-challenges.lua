local co = require '../lib/co'
local c = coroutine
local stepLabel = require '../utils/step-label'
local makeAction = (require './utils').makeAction
local sleepPromise = require '../utils/sleep-promise'
local moDailyChallenges = require '../meta-operation/daily-challenges'
local moHome = require '../meta-operation/home'
local moBattle = require '../meta-operation/battle'
local setScreenListeners = (require './utils').setScreenListeners
local store = require '../store'
local vibratorPromise = require '../utils/vibrator-promise'

store.dalyChallenges = store.dalyChallenges or {
  intervalTime = os.time()
}

local o = {
  home = moHome,
  battle = moBattle,
  dailyChallenges = moDailyChallenges,
}

local dailyChallengesListenerList = {
  { '', o.home.isHome, 2000 },
  { 'DAILY_CHALLENGES_IN_BATTLE_PAGE', o.battle.isInBattlePage, 2000 },
  { 'DAILY_CHALLENGES_IN_BATTLE_PAGE_AUTO_BATTLE_CONFIRM_PANEL', o.battle.isAutoBattleConfirmPanel, 2000 },
  { 'DAILY_CHALLENGES_IN_BATTLE_PAGE', o.battle.isInBattlePage, 2000 },
  { 'DAILY_CHALLENGES_VICTORY_PAGE', o.battle.isGetPropsPanel, 2000 },
  { 'DAILY_CHALLENGES_GET_EXP_PANEL', o.battle.isGetExpPanel, 2000 },
  { 'DAILY_CHALLENGES_GET_PROPS_PANEL', o.battle.isGetPropsPanel, 2000 },
  { 'DAILY_CHALLENGES_GET_NEW_SHIP_PANEL', o.battle.isGetNewShipPanel, 2000 },
  { 'DAILY_CHALLENGES_GET_EXP_PANEL', o.battle.isGetExpPanel, 2000 },
  { 'DAILY_CHALLENGES_BATTLE_CHAPTER_PAGE_BACK_TO_HOME', o.battle.isBattleChapterPage, 2000 },
  { 'DAILY_CHALLENGES_FLEET_PAGE_BACK', o.dailyChallenges.isDailyChallengesPage, 2000 },
  { 'DAILY_CHALLENGES_BATTLE_CHAPTER_PAGE_BACK_TO_HOME', o.dailyChallenges.isSelectChapterPage, 2000 },
}

local dailyChallenges = function(action)
  local settings = store.settings;
  return co(c.create(function()
    if action.type == 'DAILY_CHALLENGES_INIT' then

      stepLabel.setStepLabelContent('4.1.等待桌面')
      local newstateTypes = c.yield(setScreenListeners(dailyChallengesListenerList, {
        { 'DAILY_CHALLENGES_START', o.home.isHome, 2000 },
      }))
      return makeAction(newstateTypes)

    elseif action.type == 'DAILY_CHALLENGES_START' then

      stepLabel.setStepLabelContent('4.2.点击进入战斗页面')
      o.dailyChallenges.clickIntoBattlePage()

      local newstateTypes = c.yield(setScreenListeners(dailyChallengesListenerList, {
        { 'DAILY_CHALLENGES_START', o.home.isHome, 2000 },
        { 'DAILY_CHALLENGES_BATTLE_CHAPTER_PAGE', o.battle.isBattleChapterPage },
      }))
      return makeAction(newstateTypes)

    elseif action.type == 'DAILY_CHALLENGES_BATTLE_CHAPTER_PAGE' then

      stepLabel.setStepLabelContent('4.3.点击进入每日挑战')
      o.dailyChallenges.clickIntoDailyChallengesPage()
      local newstateTypes = c.yield(setScreenListeners(dailyChallengesListenerList, {
        { 'DAILY_CHALLENGES_START', o.home.isHome, 2000 },
        { 'DAILY_CHALLENGES_BATTLE_CHAPTER_PAGE', o.battle.isBattleChapterPage, 2000 },
        { 'DAILY_CHALLENGES_DAILY_CHALLENGES_PAGE_SELECT_TACTICAL_TRAINING_CARD', o.dailyChallenges.isDailyChallengesPage },
      }))
      return makeAction(newstateTypes)

    elseif action.type == 'DAILY_CHALLENGES_DAILY_CHALLENGES_PAGE_SELECT_TACTICAL_TRAINING_CARD' then

      c.yield(sleepPromise(500))
      if not o.dailyChallenges.isTacticalTrainingCard() then
        stepLabel.setStepLabelContent('4.4.寻找战术研修')
        o.dailyChallenges.clickChangeCard()
        local newstateTypes = c.yield(setScreenListeners(dailyChallengesListenerList, {
          { 'DAILY_CHALLENGES_START', o.home.isHome, 2000 },
          { 'DAILY_CHALLENGES_DAILY_CHALLENGES_PAGE_SELECT_TACTICAL_TRAINING_CARD', o.dailyChallenges.isDailyChallengesPage },
        }))
        return makeAction(newstateTypes)
      end
      if not o.dailyChallenges.isDailyChallengesPageDailyChallengesEmpty() then
        stepLabel.setStepLabelContent('4.5.选择战术研修')
        o.dailyChallenges.clickIntoCard()
        local newstateTypes = c.yield(setScreenListeners(dailyChallengesListenerList, {
          { 'DAILY_CHALLENGES_DAILY_CHALLENGES_PAGE_SELECT_TACTICAL_TRAINING_CARD', o.dailyChallenges.isDailyChallengesPage, 2000 },
          { 'DAILY_CHALLENGES_CHAPTER_PAGE_PAGE_SELECT_CHAPTER', o.dailyChallenges.isSelectChapterPage },
        }))
        return makeAction(newstateTypes)
      end

    elseif action.type == 'DAILY_CHALLENGES_CHAPTER_PAGE_PAGE_SELECT_CHAPTER' then

      if not o.dailyChallenges.isSelectChapterPageChallengeEmpty() then
        stepLabel.setStepLabelContent('4.6.选择关卡' .. settings.tacticalTrainingChapter)
        o.dailyChallenges.selectChapter(settings.tacticalTrainingChapter)
        local newstateTypes = c.yield(setScreenListeners(dailyChallengesListenerList, {
          { 'DAILY_CHALLENGES_DAILY_CHALLENGES_PAGE_SELECT_TACTICAL_TRAINING_CARD', o.dailyChallenges.isDailyChallengesPage, 2000 },
          { 'DAILY_CHALLENGES_CHAPTER_PAGE_PAGE_SELECT_CHAPTER', o.dailyChallenges.isSelectChapterPage, 2000 },
          { 'DAILY_CHALLENGES_FLEET_PAGE_PAGE_CLEAR_FLEET', o.dailyChallenges.isSelectFleetPage },
        }))
        return makeAction(newstateTypes)
      end

      stepLabel.setStepLabelContent('4.6.返回上一页')
      local newstateTypes = c.yield(setScreenListeners(dailyChallengesListenerList, {
        { 'DAILY_CHALLENGES_BATTLE_CHAPTER_PAGE_BACK_TO_HOME', o.battle.isBattleChapterPage },
      }))
      return makeAction(newstateTypes)

    elseif action.type == 'DAILY_CHALLENGES_FLEET_PAGE_PAGE_CLEAR_FLEET' then

      stepLabel.setStepLabelContent('4.6.选择舰队' .. settings.tacticalTrainingFleet)
      o.dailyChallenges.clickChangeFirstFleet()
      local newstateTypes = c.yield(setScreenListeners(dailyChallengesListenerList, {
        { 'DAILY_CHALLENGES_DAILY_CHALLENGES_PAGE_SELECT_TACTICAL_TRAINING_CARD', o.dailyChallenges.isDailyChallengesPage, 2000 },
        { 'DAILY_CHALLENGES_CHAPTER_PAGE_PAGE_SELECT_CHAPTER', o.dailyChallenges.isSelectChapterPage, 2000 },
        { 'DAILY_CHALLENGES_FLEET_PAGE_PAGE_SELECT_FLEET', o.dailyChallenges.isSelectFleetPage },
      }))
      return makeAction(newstateTypes)

    elseif action.type == 'DAILY_CHALLENGES_FLEET_PAGE_PAGE_SELECT_FLEET' then

      if o.dailyChallenges.getFleet() ~= settings.tacticalTrainingFleet then
        o.dailyChallenges.clickChangeNextFleet()
        local newstateTypes = c.yield(setScreenListeners(dailyChallengesListenerList, {
          { 'DAILY_CHALLENGES_DAILY_CHALLENGES_PAGE_SELECT_TACTICAL_TRAINING_CARD', o.dailyChallenges.isDailyChallengesPage, 2000 },
          { 'DAILY_CHALLENGES_CHAPTER_PAGE_PAGE_SELECT_CHAPTER', o.dailyChallenges.isSelectChapterPage, 2000 },
          { 'DAILY_CHALLENGES_FLEET_PAGE_PAGE_SELECT_FLEET', o.dailyChallenges.isSelectFleetPage, 2000 },
        }))
        return makeAction(newstateTypes)
      end

      local newstateTypes = c.yield(setScreenListeners(dailyChallengesListenerList, {
        { 'DAILY_CHALLENGES_DAILY_CHALLENGES_PAGE_SELECT_TACTICAL_TRAINING_CARD', o.dailyChallenges.isDailyChallengesPage, 2000 },
        { 'DAILY_CHALLENGES_CHAPTER_PAGE_PAGE_SELECT_CHAPTER', o.dailyChallenges.isSelectChapterPage, 2000 },
        { 'DAILY_CHALLENGES_FLEET_PAGE_CLICK_BATTLE_BTN', o.dailyChallenges.isSelectFleetPage },
      }))
      return makeAction(newstateTypes)

    elseif action.type == 'DAILY_CHALLENGES_FLEET_PAGE_CLICK_BATTLE_BTN' then

      stepLabel.setStepLabelContent('4.8.出击')
      o.dailyChallenges.clickBattleBtn()
      local newstateTypes = c.yield(setScreenListeners(dailyChallengesListenerList, {
        { 'DAILY_CHALLENGES_DAILY_CHALLENGES_PAGE_SELECT_TACTICAL_TRAINING_CARD', o.dailyChallenges.isDailyChallengesPage, 2000 },
        { 'DAILY_CHALLENGES_CHAPTER_PAGE_PAGE_SELECT_CHAPTER', o.dailyChallenges.isSelectChapterPage, 2000 },
        { 'DAILY_CHALLENGES_IN_BATTLE_PAGE', o.battle.isInBattlePage },
      }))
      return makeAction(newstateTypes)

    elseif action.type == 'DAILY_CHALLENGES_IN_BATTLE_PAGE' then

      stepLabel.setStepLabelContent('2.17.战斗中检测是否自动战斗')
      local newstateTypes = c.yield(setScreenListeners(dailyChallengesListenerList, {
        { 'DAILY_CHALLENGES_IN_BATTLE_PAGE', o.battle.isInBattlePage, 86400000 },
        { 'DAILY_CHALLENGES_IN_BATTLE_PAGE_CLICK_AUTO_BATTLE', o.battle.isNotAutoBattle, 2000 },
        { 'DAILY_CHALLENGES_IN_BATTLE_PAGE_AUTO_BATTLE_CONFIRM_PANEL', o.battle.isAutoBattleConfirmPanel },
      }))
      return makeAction(newstateTypes)

    elseif action.type == 'DAILY_CHALLENGES_IN_BATTLE_PAGE_CLICK_AUTO_BATTLE' then

      stepLabel.setStepLabelContent('2.18.点击自动战斗')
      c.yield(sleepPromise(500))
      o.battle.inBattlePageClickAutoBattle()
      local newstateTypes = c.yield(setScreenListeners(dailyChallengesListenerList, {
        { 'DAILY_CHALLENGES_IN_BATTLE_PAGE', o.battle.isInBattlePage, 2000 },
        { 'DAILY_CHALLENGES_IN_BATTLE_PAGE_AUTO_BATTLE_CONFIRM_PANEL', o.battle.isAutoBattleConfirmPanel },
      }))
      return makeAction(newstateTypes)

    elseif action.type == 'DAILY_CHALLENGES_IN_BATTLE_PAGE_AUTO_BATTLE_CONFIRM_PANEL' then

      stepLabel.setStepLabelContent('2.19.自动战斗面板点击确认')
      o.battle.autoBattleConfirmPanelClickOk()
      local newstateTypes = c.yield(setScreenListeners(dailyChallengesListenerList, {
        { 'DAILY_CHALLENGES_IN_BATTLE_PAGE', o.battle.isInBattlePage, 2000 },
        { 'DAILY_CHALLENGES_IN_BATTLE_PAGE_AUTO_BATTLE_CONFIRM_PANEL', o.battle.isAutoBattleConfirmPanel, 2000 },
      }))
      return makeAction(newstateTypes)

    elseif action.type == 'DAILY_CHALLENGES_VICTORY_PAGE' then

      stepLabel.setStepLabelContent('2.20.胜利面板点击继续')
      o.battle.victoryPanelClickNext()
      local newstateTypes = c.yield(setScreenListeners(dailyChallengesListenerList, {
        { 'DAILY_CHALLENGES_IN_BATTLE_PAGE', o.battle.isInBattlePage, 2000 },
      }))
      return makeAction(newstateTypes)

    elseif action.type == 'DAILY_CHALLENGES_VICTORY_PAGE' then

      stepLabel.setStepLabelContent('2.21.胜利面板点击继续')
      o.battle.victoryPanelClickNext()
      local newstateTypes = c.yield(setScreenListeners(dailyChallengesListenerList, {
        { 'DAILY_CHALLENGES_VICTORY_PAGE', o.battle.isGetPropsPanel, 2000 },
        { 'DAILY_CHALLENGES_GET_EXP_PANEL', o.battle.isGetExpPanel, 2000 },
        { 'DAILY_CHALLENGES_GET_PROPS_PANEL', o.battle.isGetPropsPanel },
      }))
      return makeAction(newstateTypes)

    elseif action.type == 'DAILY_CHALLENGES_GET_PROPS_PANEL' then

      stepLabel.setStepLabelContent('2.22.获得道具面板点击继续')
      o.battle.getPropsPanelClickNext()
      local newstateTypes = c.yield(setScreenListeners(dailyChallengesListenerList, {
        { 'DAILY_CHALLENGES_GET_PROPS_PANEL', o.battle.isGetPropsPanel, 2000 },
        { 'DAILY_CHALLENGES_GET_EXP_PANEL', o.battle.isGetExpPanel, 2000 },
        { 'DAILY_CHALLENGES_GET_NEW_SHIP_PANEL', o.battle.isGetNewShipPanel },
      }))
      return makeAction(newstateTypes)

    elseif action.type == 'DAILY_CHALLENGES_GET_NEW_SHIP_PANEL' then

      stepLabel.setStepLabelContent('2.23.获得新船面板点击继续')
      o.battle.getNewShipPanelClickNext()
      local newstateTypes = c.yield(setScreenListeners(dailyChallengesListenerList, {
        { 'DAILY_CHALLENGES_GET_NEW_SHIP_PANEL', o.battle.isGetNewShipPanel, 2000 },
        { 'DAILY_CHALLENGES_GET_EXP_PANEL', o.battle.isGetExpPanel, 2000 },
      }))
      return makeAction(newstateTypes)

    elseif action.type == 'DAILY_CHALLENGES_GET_EXP_PANEL' then

      stepLabel.setStepLabelContent('2.24.获得经验面板点击继续')
      o.battle.getExpPanelClickNext()
      local newstateTypes = c.yield(setScreenListeners(dailyChallengesListenerList, {
        { 'DAILY_CHALLENGES_GET_EXP_PANEL', o.battle.isGetExpPanel, 2000 },
        { 'DAILY_CHALLENGES_CHAPTER_PAGE_PAGE_SELECT_CHAPTER', o.dailyChallenges.isSelectChapterPage, 2000 },
        { '', o.home.isHome, 2000 },
      }))
      return makeAction(newstateTypes)

    elseif action.type == 'DAILY_CHALLENGES_FLEET_PAGE_BACK' then

      o.dailyChallenges.clickBackBtn()
      local newstateTypes = c.yield(setScreenListeners(dailyChallengesListenerList, {
        { 'DAILY_CHALLENGES_BATTLE_CHAPTER_PAGE_BACK_TO_HOME', o.dailyChallenges.isSelectChapterPage },
        { 'DAILY_CHALLENGES_FLEET_PAGE_BACK', o.dailyChallenges.isDailyChallengesPage },
      }))
      return makeAction(newstateTypes)

    elseif action.type == 'DAILY_CHALLENGES_FLEET_PAGE_BACK' then

      o.dailyChallenges.clickBackBtn()
      local newstateTypes = c.yield(setScreenListeners(dailyChallengesListenerList, {
        { 'DAILY_CHALLENGES_BATTLE_CHAPTER_PAGE_BACK_TO_HOME', o.dailyChallenges.isSelectChapterPage },
        { 'DAILY_CHALLENGES_FLEET_PAGE_BACK', o.dailyChallenges.isDailyChallengesPage },
      }))
      return makeAction(newstateTypes)

    elseif action.type == 'DAILY_CHALLENGES_BATTLE_CHAPTER_PAGE_BACK_TO_HOME' then

      o.dailyChallenges.clickBackBtn()
      return makeAction('')
    end
    return nil
  end))
end

return dailyChallenges
