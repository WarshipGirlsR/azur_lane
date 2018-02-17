local co = require '../lib/co'
local c = coroutine
local stepLabel = require '../utils/step-label'
local makeAction = (require './utils').makeAction
local sleepPromise = require '../utils/sleep-promise'
local moBattle = require '../meta-operation/battle'
local moHome = require '../meta-operation/home'
local setScreenListeners = (require './utils').setScreenListeners
local store = require '../store'
local vibratorPromise = require '../utils/vibrator-promise'

store.battle = store.battle or {}

local o = {
  home = moHome,
  battle = moBattle,
}

local battleListenerList = {
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

      stepLabel.setStepLabelContent('2.2.点击出击')
      o.battle.clickBattleBtn()
      local newstateTypes = c.yield(setScreenListeners(battleListenerList, {
        { 'BATTLE_HOME_CLICK_BATTLE', o.home.isHome, 2000 },
        { 'BATTLE_BATTLE_CHAPTER_PAGE_SELECT_MODE', o.battle.isBattleChapterPage },
      }))
      return makeAction(newstateTypes)

    elseif action.type == 'BATTLE_BATTLE_CHAPTER_PAGE_SELECT_MODE' then

      stepLabel.setStepLabelContent('2.3.选择章节界面')
      if settings.battleMode == 'normal' and o.battle.isHardMode() then
        stepLabel.setStepLabelContent('2.4.切换为普通模式')
      elseif settings.battleMode == 'hard' and o.battle.isNormalMode() then
        stepLabel.setStepLabelContent('2.5.切换为困难模式')
      end

      if (settings.battleMode == 'normal' and o.battle.isHardMode())
          or (settings.battleMode == 'hard' and o.battle.isNormalMode()) then
        o.battle.clickSwitchHardModeBtn()
        c.yield(sleepPromise(500))
        local newstateTypes = c.yield(setScreenListeners(battleListenerList, {
          { 'BATTLE_BATTLE_CHAPTER_PAGE_SELECT_MODE', o.battle.isBattleChapterPage },
        }))
        return makeAction(newstateTypes)
      end

      local newstateTypes = c.yield(setScreenListeners(battleListenerList, {
        { 'BATTLE_BATTLE_CHAPTER_PAGE_MOVE_TO_CHAPTER', o.battle.isBattleChapterPage },
      }))
      console.log(newstateTypes)
      return makeAction(newstateTypes)

    elseif action.type == 'BATTLE_BATTLE_CHAPTER_PAGE_MOVE_TO_CHAPTER' then

      stepLabel.setStepLabelContent('2.6.移动到第' .. settings.battleChapter .. '章')
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

      stepLabel.setStepLabelContent('2.7.选择舰队面板')
      stepLabel.setStepLabelContent('2.8.检查已选择的舰队')
      local res, selectList, unselectList, selectedFeeldList = o.battle.checkSelectedFleet(settings.battleFleet)
      if not res then
        stepLabel.setStepLabelContent('2-9.选择舰队 ' .. table.concat(settings.battleFleet, ','))
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

      stepLabel.setStepLabelContent('2.10.点击进入章节')
      o.battle.clickGotoMapBtn()
      local newstateTypes = c.yield(setScreenListeners(battleListenerList, {
        { 'BATTLE_BATTLE_CHAPTER_PAGE_SELECT_FLEET_PANEL_SELECT_FLEET', o.battle.isSelectFleetPanel, 2000 },
        { 'BATTLE_BATTLE_CHAPTER_PAGE_HARD_SELECT_FLEET_PANEL_CLICK_INTO', o.battle.isHardSelectFleetPanel, 500 },
        { 'BATTLE_MAP_PAGE', o.battle.isMapPage },
      }))
      return makeAction(newstateTypes)

    elseif action.type == 'BATTLE_BATTLE_CHAPTER_PAGE_HARD_SELECT_FLEET_PANEL_CLICK_INTO' then

      stepLabel.setStepLabelContent('2.11.困难选择舰队面板')
      stepLabel.setStepLabelContent('2.12.点击立刻前往')
      o.battle.clickHardGotoSelectFleedPanelBtn()
      local newstateTypes = c.yield(setScreenListeners(battleListenerList, {
        { 'BATTLE_MAP_PAGE', o.battle.isMapPage },
      }))
      return makeAction(newstateTypes)

    elseif action.type == 'BATTLE_MAP_PAGE' then

      if settings.battleAssistantMode == 'manual' then
        stepLabel.setStepLabelContent('2-13.等待用户移动')

        vibratorPromise(3)

        local newstateTypes = c.yield(setScreenListeners(battleListenerList, {
          { 'BATTLE_MAP_PAGE', o.battle.isMapPage, 10000 },
          { 'BATTLE_MAP_PAGE_CLOSE_FORMAT_PANEL', o.battle.isFormationPanel },
          { 'BATTLE_MAP_PAGE_AMBUSHED_PANEL_AVOID_AMBUSHED', o.battle.isAmbushedPanel },
          { 'BATTLE_MAP_PAGE_CLOSE_FORMAT_PANEL', o.battle.isFormationPanel },
          { 'BATTLE_READY_BATTLE_PAGE_CLICK_BATTLE', o.battle.isReadyBattlePage },
        }))
        return makeAction(newstateTypes)
      end
      local newstateTypes = c.yield(setScreenListeners(battleListenerList, {
        { 'BATTLE_MAP_PAGE', o.battle.isMapPage },
        { 'BATTLE_MAP_PAGE_CLOSE_FORMAT_PANEL', o.battle.isFormationPanel },
        { 'BATTLE_MAP_PAGE_AMBUSHED_PANEL_AVOID_AMBUSHED', o.battle.isAmbushedPanel },
        { 'BATTLE_MAP_PAGE_CLOSE_FORMAT_PANEL', o.battle.isFormationPanel },
        { 'BATTLE_READY_BATTLE_PAGE_CLICK_BATTLE', o.battle.isReadyBattlePage },
      }))
      return makeAction(newstateTypes)

    elseif action.type == 'BATTLE_MAP_PAGE_CLOSE_FORMAT_PANEL' then

      stepLabel.setStepLabelContent('2.14.关闭阵型面板')
      o.battle.closeFormationPanel()
      local newstateTypes = c.yield(setScreenListeners(battleListenerList, {
        { 'BATTLE_MAP_PAGE', o.battle.isMapPage },
        { 'BATTLE_MAP_PAGE_CLOSE_FORMAT_PANEL', o.battle.isFormationPanel, 2000 },
        { 'BATTLE_MAP_PAGE_AMBUSHED_PANEL_AVOID_AMBUSHED', o.battle.isAmbushedPanel },
        { 'BATTLE_MAP_PAGE_CLOSE_FORMAT_PANEL', o.battle.isFormationPanel },
      }))
      return makeAction(newstateTypes)

    elseif action.type == 'BATTLE_MAP_PAGE_AMBUSHED_PANEL_AVOID_AMBUSHED' then

      stepLabel.setStepLabelContent('2.15.躲避伏击')
      o.battle.ambushedPanelClickAvoidBtn()
      local newstateTypes = c.yield(setScreenListeners(battleListenerList, {
        { 'BATTLE_MAP_PAGE', o.battle.isMapPage },
        { 'BATTLE_MAP_PAGE_CLOSE_FORMAT_PANEL', o.battle.isFormationPanel },
        { 'BATTLE_MAP_PAGE_AMBUSHED_PANEL_AVOID_AMBUSHED', o.battle.isAmbushedPanel, 2000 },
        { 'BATTLE_MAP_PAGE_CLOSE_FORMAT_PANEL', o.battle.isFormationPanel },
      }))
      return makeAction(newstateTypes)

    elseif action.type == 'BATTLE_READY_BATTLE_PAGE_CLICK_BATTLE' then

      stepLabel.setStepLabelContent('2.16.准备战斗')
      o.battle.readyBattlePageClickBattle()
      local newstateTypes = c.yield(setScreenListeners(battleListenerList, {
        { 'BATTLE_MAP_PAGE', o.battle.isMapPage },
        { 'BATTLE_READY_BATTLE_PAGE_CLICK_BATTLE', o.battle.isReadyBattlePage, 2000 },
        { 'BATTLE_IN_BATTLE_PAGE', o.battle.isInBattlePage },
      }))
      return makeAction(newstateTypes)

    elseif action.type == 'BATTLE_IN_BATTLE_PAGE' then

      stepLabel.setStepLabelContent('2.17.战斗中检测是否自动战斗')
      local newstateTypes = c.yield(setScreenListeners(battleListenerList, {
        { 'BATTLE_IN_BATTLE_PAGE', o.battle.isInBattlePage, 86400000 },
        { 'BATTLE_IN_BATTLE_PAGE_CLICK_AUTO_BATTLE', o.battle.isNotAutoBattle },
        { 'BATTLE_IN_BATTLE_PAGE_AUTO_BATTLE_CONFIRM_PANEL', o.battle.isAutoBattleConfirmPanel },
      }))
      return makeAction(newstateTypes)

    elseif action.type == 'BATTLE_IN_BATTLE_PAGE_CLICK_AUTO_BATTLE' then

      stepLabel.setStepLabelContent('2.18.点击自动战斗')
      c.yield(sleepPromise(500))
      o.battle.inBattlePageClickAutoBattle()
      local newstateTypes = c.yield(setScreenListeners(battleListenerList, {
        { 'BATTLE_IN_BATTLE_PAGE', o.battle.isInBattlePage, 2000 },
        { 'BATTLE_IN_BATTLE_PAGE_AUTO_BATTLE_CONFIRM_PANEL', o.battle.isAutoBattleConfirmPanel },
      }))
      return makeAction(newstateTypes)

    elseif action.type == 'BATTLE_IN_BATTLE_PAGE_AUTO_BATTLE_CONFIRM_PANEL' then

      stepLabel.setStepLabelContent('2.19.自动战斗面板点击确认')
      o.battle.autoBattleConfirmPanelClickOk()
      local newstateTypes = c.yield(setScreenListeners(battleListenerList, {
        { 'BATTLE_IN_BATTLE_PAGE', o.battle.isInBattlePage, 2000 },
        { 'BATTLE_IN_BATTLE_PAGE_AUTO_BATTLE_CONFIRM_PANEL', o.battle.isAutoBattleConfirmPanel, 2000 },
      }))
      return makeAction(newstateTypes)

    elseif action.type == 'BATTLE_VICTORY_PAGE' then

      stepLabel.setStepLabelContent('2.20.胜利面板点击继续')
      o.battle.victoryPanelClickNext()
      local newstateTypes = c.yield(setScreenListeners(battleListenerList, {
        { 'BATTLE_IN_BATTLE_PAGE', o.battle.isInBattlePage, 2000 },
      }))
      return makeAction(newstateTypes)

    elseif action.type == 'BATTLE_VICTORY_PAGE' then

      stepLabel.setStepLabelContent('2.21.胜利面板点击继续')
      o.battle.victoryPanelClickNext()
      local newstateTypes = c.yield(setScreenListeners(battleListenerList, {
        { 'BATTLE_VICTORY_PAGE', o.battle.isGetPropsPanel, 2000 },
        { 'BATTLE_GET_PROPS_PANEL', o.battle.isGetPropsPanel },
      }))
      return makeAction(newstateTypes)

    elseif action.type == 'BATTLE_GET_PROPS_PANEL' then

      stepLabel.setStepLabelContent('2.22.获得道具面板点击继续')
      o.battle.getPropsPanelClickNext()
      local newstateTypes = c.yield(setScreenListeners(battleListenerList, {
        { 'BATTLE_GET_PROPS_PANEL', o.battle.isGetPropsPanel, 2000 },
        { 'BATTLE_GET_NEW_SHIP_PANEL', o.battle.isGetNewShipPanel },
      }))
      return makeAction(newstateTypes)

    elseif action.type == 'BATTLE_GET_NEW_SHIP_PANEL' then

      stepLabel.setStepLabelContent('2.23.获得新船面板点击继续')
      o.battle.getNewShipPanelClickNext()
      local newstateTypes = c.yield(setScreenListeners(battleListenerList, {
        { 'BATTLE_GET_NEW_SHIP_PANEL', o.battle.isGetNewShipPanel, 2000 },
        { 'BATTLE_GET_EXP_PANEL', o.battle.isGetExpPanel },
      }))
      return makeAction(newstateTypes)


    elseif action.type == 'BATTLE_GET_EXP_PANEL' then

      stepLabel.setStepLabelContent('2.24.获得经验面板点击继续')
      o.battle.getExpPanelClickNext()
      local newstateTypes = c.yield(setScreenListeners(battleListenerList, {
        { 'BATTLE_GET_EXP_PANEL', o.battle.isGetExpPanel, 2000 },
        { '', o.home.isHome, 2000 },
      }))
      return makeAction(newstateTypes)

    elseif action.type == 'BATTLE_BATTLE_CHAPTER_PAGE_BACK_TO_HOME' then

      o.battle.battlePageClickBackToHome()
      return makeAction('')
    end

    return nil
  end))
end

return battle
