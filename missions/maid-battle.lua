local co = require '../lib/co'
local c = coroutine
local stepLabel = require '../utils/step-label'
local makeAction = (require './utils').makeAction
local sleepPromise = require '../utils/sleep-promise'
local moBattle = require '../meta-operation/battle'
local moMaidBattle = require '../meta-operation/maid-battle'
local moHome = require '../meta-operation/home'
local moMap = require '../meta-operation/maps-options/index'
local setScreenListeners = (require './utils').setScreenListeners
local store = require '../store'
local vibratorPromise = require '../utils/vibrator-promise'

store.battle = store.battle or {}

local o = {
  home = moHome,
  battle = moBattle,
  maidBattle = moMaidBattle,
  map = moMap,
}

local battleListenerList = {
  { '', o.home.isHome, 2000 },
  { 'MAID_BATTLE_BATTLE_CHAPTER_PAGE_BACK_TO_HOME', o.battle.isBattleChapterPage, 2000 },
  { 'MAID_BATTLE_READY_BATTLE_PAGE_CLICK_BATTLE', o.battle.isReadyBattlePage, 2000 },
  { 'MAID_BATTLE_BATTLE_CHAPTER_PAGE_SELECT_MODE', o.maidBattle.isSelectChapterPage, 2000 },
  { 'MAID_BATTLE_IN_BATTLE_PAGE', o.battle.isInBattlePage, 2000 },
  { 'MAID_BATTLE_VICTORY_PAGE', o.battle.isVictoryPanel, 2000 },
  { 'MAID_BATTLE_GET_PROPS_PANEL', o.battle.isGetPropsPanel, 2000 },
  { 'MAID_BATTLE_GET_NEW_SHIP_PANEL', o.battle.isGetNewShipPanel, 2000 },
  { 'MAID_BATTLE_GET_EXP_PANEL', o.battle.isGetExpPanel, 2000 },
}

local maidBattle = function(action)
  local settings = store.settings;

  return co(c.create(function()
    if action.type == 'MAID_BATTLE_INIT' then

      local newstateTypes = c.yield(setScreenListeners(battleListenerList, {
        { 'MAID_BATTLE_START', o.home.isHome, 2000 },
      }))
      return makeAction(newstateTypes)

    elseif action.type == 'MAID_BATTLE_START' then

      stepLabel.setStepLabelContent('6.1.等待桌面')
      local newstateTypes = c.yield(setScreenListeners(battleListenerList, {
        { 'MAID_BATTLE_HOME_CLICK_BATTLE', o.home.isHome, 2000 },
      }))
      return makeAction(newstateTypes)

    elseif action.type == 'MAID_BATTLE_HOME_CLICK_BATTLE' then

      stepLabel.setStepLabelContent('6.2.点击出击')
      o.maidBattle.clickEventBtn()
      local newstateTypes = c.yield(setScreenListeners(battleListenerList, {
        { 'MAID_BATTLE_HOME_CLICK_BATTLE', o.home.isHome, 2000 },
        { 'MAID_BATTLE_BATTLE_CHAPTER_PAGE_SELECT_MODE', o.maidBattle.isSelectChapterPage, 2000 },
      }))
      return makeAction(newstateTypes)

    elseif action.type == 'MAID_BATTLE_BATTLE_CHAPTER_PAGE_SELECT_MODE' then

      stepLabel.setStepLabelContent('6.3.选择章节界面')
      o.maidBattle.clickChapterBtn(settings.maidBattleChapter)
      local newstateTypes = c.yield(setScreenListeners(battleListenerList, {
        { 'MAID_BATTLE_READY_BATTLE_PAGE_CLICK_BATTLE', o.battle.isReadyBattlePage },
      }))
      return makeAction(newstateTypes)

    elseif action.type == 'MAID_BATTLE_READY_BATTLE_PAGE_CLICK_BATTLE' then

      stepLabel.setStepLabelContent('6.16.准备战斗')
      c.yield(sleepPromise(1000))
      o.battle.readyBattlePageClickBattle()
      local newstateTypes = c.yield(setScreenListeners(battleListenerList, {
        { 'MAID_BATTLE_READY_BATTLE_PAGE_CLICK_BATTLE', o.battle.isReadyBattlePage, 2000 },
        { 'MAID_BATTLE_IN_BATTLE_PAGE', o.battle.isInBattlePage },
        { 'MAID_BATTLE_IN_BATTLE_PAGE_CLICK_AUTO_BATTLE', o.battle.isNotAutoBattle },
        { 'MAID_BATTLE_IN_BATTLE_PAGE_AUTO_BATTLE_CONFIRM_PANEL', o.battle.isAutoBattleConfirmPanel },
      }))
      return makeAction(newstateTypes)

    elseif action.type == 'MAID_BATTLE_IN_BATTLE_PAGE' then

      stepLabel.setStepLabelContent('6.17.战斗中检测是否自动战斗')
      local newstateTypes = c.yield(setScreenListeners(battleListenerList, {
        { 'MAID_BATTLE_IN_BATTLE_PAGE', o.battle.isInBattlePage, 86400000 },
        { 'MAID_BATTLE_IN_BATTLE_PAGE_CLICK_AUTO_BATTLE', o.battle.isNotAutoBattle, 2000 },
        { 'MAID_BATTLE_IN_BATTLE_PAGE_AUTO_BATTLE_CONFIRM_PANEL', o.battle.isAutoBattleConfirmPanel },
      }))
      return makeAction(newstateTypes)

    elseif action.type == 'MAID_BATTLE_IN_BATTLE_PAGE_CLICK_AUTO_BATTLE' then

      stepLabel.setStepLabelContent('6.18.点击自动战斗')
      c.yield(sleepPromise(500))
      o.battle.inBattlePageClickAutoBattle()
      local newstateTypes = c.yield(setScreenListeners(battleListenerList, {
        { 'MAID_BATTLE_IN_BATTLE_PAGE', o.battle.isInBattlePage, 2000 },
        { 'MAID_BATTLE_IN_BATTLE_PAGE_AUTO_BATTLE_CONFIRM_PANEL', o.battle.isAutoBattleConfirmPanel },
      }))
      return makeAction(newstateTypes)

    elseif action.type == 'MAID_BATTLE_IN_BATTLE_PAGE_AUTO_BATTLE_CONFIRM_PANEL' then

      stepLabel.setStepLabelContent('6.19.自动战斗面板点击确认')
      o.battle.autoBattleConfirmPanelClickOk()
      local newstateTypes = c.yield(setScreenListeners(battleListenerList, {
        { 'MAID_BATTLE_IN_BATTLE_PAGE', o.battle.isInBattlePage, 2000 },
        { 'MAID_BATTLE_IN_BATTLE_PAGE_AUTO_BATTLE_CONFIRM_PANEL', o.battle.isAutoBattleConfirmPanel, 2000 },
      }))
      return makeAction(newstateTypes)

    elseif action.type == 'MAID_BATTLE_VICTORY_PAGE' then

      stepLabel.setStepLabelContent('6.21.胜利面板点击继续')
      o.battle.victoryPanelClickNext()
      local newstateTypes = c.yield(setScreenListeners(battleListenerList, {
        { 'MAID_BATTLE_VICTORY_PAGE', o.battle.isGetPropsPanel, 2000 },
        { 'MAID_BATTLE_GET_EXP_PANEL', o.battle.isGetExpPanel, 2000 },
        { 'MAID_BATTLE_GET_PROPS_PANEL', o.battle.isGetPropsPanel },
      }))
      return makeAction(newstateTypes)

    elseif action.type == 'MAID_BATTLE_GET_PROPS_PANEL' then

      stepLabel.setStepLabelContent('6.22.获得道具面板点击继续')
      o.battle.getPropsPanelClickNext()
      local newstateTypes = c.yield(setScreenListeners(battleListenerList, {
        { 'MAID_BATTLE_GET_PROPS_PANEL', o.battle.isGetPropsPanel, 2000 },
        { 'MAID_BATTLE_GET_EXP_PANEL', o.battle.isGetExpPanel, 2000 },
        { 'MAID_BATTLE_GET_NEW_SHIP_PANEL', o.battle.isGetNewShipPanel },
      }))
      return makeAction(newstateTypes)

    elseif action.type == 'MAID_BATTLE_GET_NEW_SHIP_PANEL' then

      stepLabel.setStepLabelContent('6.23.获得新船面板点击继续')
      o.battle.getNewShipPanelClickNext()
      local newstateTypes = c.yield(setScreenListeners(battleListenerList, {
        { 'MAID_BATTLE_GET_NEW_SHIP_PANEL', o.battle.isGetNewShipPanel, 2000 },
        { 'MAID_BATTLE_GET_EXP_PANEL', o.battle.isGetExpPanel, 1000 },
        { 'MAID_BATTLE_LOCK_NEW_SHIP_PANEL', o.battle.isLockNewShipPanel, 1000 },
      }))
      return makeAction(newstateTypes)

    elseif action.type == 'MAID_BATTLE_LOCK_NEW_SHIP_PANEL' then

      if settings.battleStopWhenGetNewShip then
        lua_exit()
      end

      stepLabel.setStepLabelContent('6.23.锁定新船面板点击继续')
      o.battle.lockNewShipPanelClickNext()
      local newstateTypes = c.yield(setScreenListeners(battleListenerList, {
        { 'MAID_BATTLE_GET_NEW_SHIP_PANEL', o.battle.isGetNewShipPanel, 2000 },
        { 'MAID_BATTLE_GET_EXP_PANEL', o.battle.isGetExpPanel, 2000 },
        { 'MAID_BATTLE_LOCK_NEW_SHIP_PANEL', o.battle.isLockNewShipPanel, 2000 },
      }))
      return makeAction(newstateTypes)

    elseif action.type == 'MAID_BATTLE_GET_EXP_PANEL' then

      stepLabel.setStepLabelContent('6.24.获得经验面板点击继续')
      o.battle.getExpPanelClickNext()
      local newstateTypes = c.yield(setScreenListeners(battleListenerList, {
        { 'MAID_BATTLE_GET_EXP_PANEL', o.battle.isGetExpPanel, 2000 },
        { '', o.home.isHome, 2000 },
      }))
      return makeAction(newstateTypes)

    elseif action.type == 'MAID_BATTLE_BATTLE_CHAPTER_PAGE_BACK_TO_HOME' then

      if settings.battleChapter.name ~= '0' then
        o.battle.battlePageClickBackToHome()
        local newstateTypes = c.yield(setScreenListeners(battleListenerList, {
          { '', o.home.isHome, 2000 },
        }))
        return makeAction(newstateTypes)
      else
        stepLabel.setStepLabelContent('6.25.等待用户操作')
        local newstateTypes = c.yield(setScreenListeners(battleListenerList, {
          { 'MAID_BATTLE_BATTLE_CHAPTER_PAGE_BACK_TO_HOME', o.battle.isBattleChapterPage, 86400 },
          { '', o.home.isHome, 2000 },
        }))
        return makeAction(newstateTypes)
      end
    end

    return nil
  end))
end

return maidBattle
