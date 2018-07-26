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
local vibratorPromise = require '../utils/vibrator-promise'

store.battle = store.battle or {}

local o = {
  home = moHome,
  battle = moBattle,
  map = moMap,
}

local battleListenerList = {
  { '', o.home.isHome, 2000 },
  { 'BATTLE_BATTLE_CHAPTER_PAGE_BACK_TO_HOME', o.battle.isBattleChapterPage, 2000 },
  { 'BATTLE_BATTLE_CHAPTER_PAGE_INFO_PANEL_CLICK_INTO', o.battle.isChapterInfoPanel, 2000 },
  { 'BATTLE_BATTLE_CHAPTER_PAGE_SELECT_FLEET_PANEL_SELECT_FLEET', o.battle.isSelectFleetPanel, 2000 },
  { 'BATTLE_BATTLE_CHAPTER_PAGE_HARD_SELECT_FLEET_PANEL_CLICK_INTO', o.battle.isHardSelectFleetPanel, 500 },
  { 'BATTLE_MAP_PAGE_CLOSE_INFOMATION_MODAL', o.battle.isInfomationModal, 2000 },
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
  local mapProxy = o.map['map' .. settings.battleChapter.name]

  return co(c.create(function()
    if action.type == 'BATTLE_INIT' then

      -- 是否自动模式，如果没有相应配置的话会自动从自动切换到手动
      store.battle.battleAssistantMode = settings.battleAssistantMode

      local newListeners = {}
      if settings.mapsType == 'maps-type-2' then
        table.insert(newListeners, makeAction('MAPS_TYPE_2_PRE_INIT'))
      elseif settings.mapsType == 'maps-type-3' then
        table.insert(newListeners, makeAction('MAPS_TYPE_3_PRE_INIT'))
      elseif settings.mapsType == 'maps-type-4' then
        table.insert(newListeners, makeAction('MAPS_TYPE_4_PRE_INIT'))
      end
      table.insert(newListeners, makeAction('SCAN_MAP_TYPE_1_PRE_INIT'))
      table.insert(newListeners, makeAction('BATTLE_START'))

      return newListeners

    elseif action.type == 'BATTLE_START' then

      stepLabel.setStepLabelContent('2.1.等待桌面')
      local newstateTypes = c.yield(setScreenListeners(battleListenerList, {
        { 'BATTLE_HOME_CLICK_BATTLE', o.home.isHome, 2000 },
      }))
      return makeAction(newstateTypes)

    elseif action.type == 'BATTLE_HOME_CLICK_BATTLE' then

      if settings.battleChapter.name ~= '0' then
        stepLabel.setStepLabelContent('2.2.点击出击')
        if settings.battleChapter.type == 'event' then
          o.battle.clickEventBtn()
        else
          o.battle.clickBattleBtn()
        end
      end
      local newstateTypes = c.yield(setScreenListeners(battleListenerList, {
        { 'BATTLE_HOME_CLICK_BATTLE', o.home.isHome, 2000 },
        { 'BATTLE_BATTLE_CHAPTER_PAGE_SELECT_MODE', o.battle.isBattleChapterPage, 1000 },
      }))
      return makeAction(newstateTypes)

    elseif action.type == 'BATTLE_BATTLE_CHAPTER_PAGE_SELECT_MODE' then

      if settings.battleChapter.name ~= '0' then
        stepLabel.setStepLabelContent('2.3.选择章节界面')
        console.log(settings.battleMode)
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
      end

      local newstateTypes = c.yield(setScreenListeners(battleListenerList, {
        { 'BATTLE_BATTLE_CHAPTER_PAGE_MOVE_TO_CHAPTER', o.battle.isBattleChapterPage },
      }))
      return makeAction(newstateTypes)

    elseif action.type == 'BATTLE_BATTLE_CHAPTER_PAGE_MOVE_TO_CHAPTER' then

      if settings.battleChapter.name ~= '0' then
        stepLabel.setStepLabelContent('2.6.移动到第' .. settings.battleChapter.name .. '章')
        o.battle.moveToChapter(settings.battleChapter)
      end
      c.yield(sleepPromise(500))
      -- 检查是否在所需的章节
      if not o.battle.checkChapter(settings.battleChapter) then
        stepLabel.setStepLabelContent('2.7.移动到第' .. settings.battleChapter.name .. '章失败，重新移动')
        local newstateTypes = c.yield(setScreenListeners(battleListenerList, {
          { 'BATTLE_BATTLE_CHAPTER_PAGE_MOVE_TO_CHAPTER', o.battle.isBattleChapterPage },
        }))
        return makeAction(newstateTypes)
      end

      -- 点击章节
      o.battle.clickChapter(settings.battleChapter)
      local newstateTypes = c.yield(setScreenListeners(battleListenerList, {
        { 'BATTLE_BATTLE_CHAPTER_PAGE_MOVE_TO_CHAPTER', o.battle.isBattleChapterPage, 2000 },
        { 'BATTLE_BATTLE_CHAPTER_PAGE_INFO_PANEL_CLICK_INTO', o.battle.isChapterInfoPanel },
      }))
      return makeAction(newstateTypes)

    elseif action.type == 'BATTLE_BATTLE_CHAPTER_PAGE_INFO_PANEL_CLICK_INTO' then

      stepLabel.setStepLabelContent('2.8.章节信息面板')
      stepLabel.setStepLabelContent('2.9.点击继续')
      o.battle.clickGotoSelectFleedPanelBtn()

      local newstateTypes = c.yield(setScreenListeners(battleListenerList, {
        { 'BATTLE_BATTLE_CHAPTER_PAGE_INFO_PANEL_CLICK_INTO', o.battle.isChapterInfoPanel, 2000 },
        { 'BATTLE_BATTLE_CHAPTER_PAGE_SELECT_FLEET_PANEL_CANCEL_2_FLEET', o.battle.isSelectFleetPanel },
        { 'BATTLE_BATTLE_CHAPTER_PAGE_HARD_SELECT_FLEET_PANEL_CLICK_INTO', o.battle.isHardSelectFleetPanel },
      }))
      return makeAction(newstateTypes)

    elseif action.type == 'BATTLE_BATTLE_CHAPTER_PAGE_SELECT_FLEET_PANEL_CANCEL_2_FLEET' then

      stepLabel.setStepLabelContent('2.10.取消第二个舰队')
      o.battle.clickSelectFleetPanelCancel2Fleet()
      local newstateTypes = c.yield(setScreenListeners(battleListenerList, {
        { 'BATTLE_BATTLE_CHAPTER_PAGE_SELECT_FLEET_PANEL_SELECT_1_FLEET', o.battle.isSelectFleetPanel, 500 },
        { 'BATTLE_BATTLE_CHAPTER_PAGE_HARD_SELECT_FLEET_PANEL_CLICK_INTO', o.battle.isHardSelectFleetPanel, 500 },
        { 'BATTLE_MAP_PAGE', o.battle.isMapPage },
      }))
      return makeAction(newstateTypes)

    elseif action.type == 'BATTLE_BATTLE_CHAPTER_PAGE_SELECT_FLEET_PANEL_SELECT_1_FLEET' then

      stepLabel.setStepLabelContent('2.10.选择第一个舰队')
      c.yield(o.battle.clickSelectFleetPanelSelect1Fleet(settings.battleFleet[1]))
      local newstateTypes = c.yield(setScreenListeners(battleListenerList, {
        { 'BATTLE_BATTLE_CHAPTER_PAGE_SELECT_FLEET_PANEL_SELECT_2_FLEET', o.battle.isSelectFleetPanel, 500 },
        { 'BATTLE_BATTLE_CHAPTER_PAGE_HARD_SELECT_FLEET_PANEL_CLICK_INTO', o.battle.isHardSelectFleetPanel, 500 },
        { 'BATTLE_MAP_PAGE', o.battle.isMapPage },
      }))
      return makeAction(newstateTypes)

    elseif action.type == 'BATTLE_BATTLE_CHAPTER_PAGE_SELECT_FLEET_PANEL_SELECT_2_FLEET' then

      stepLabel.setStepLabelContent('2.10.选择第二个舰队')
      if settings.battleFleet[2] then
        c.yield(o.battle.clickSelectFleetPanelSelect2Fleet(settings.battleFleet[2]))
      else
        c.yield(o.battle.clickSelectFleetPanelCancel2Fleet())
      end
      local newstateTypes = c.yield(setScreenListeners(battleListenerList, {
        { 'BATTLE_BATTLE_CHAPTER_PAGE_SELECT_FLEET_PANEL_CLICK_INTO', o.battle.isSelectFleetPanel, 500 },
        { 'BATTLE_BATTLE_CHAPTER_PAGE_HARD_SELECT_FLEET_PANEL_CLICK_INTO', o.battle.isHardSelectFleetPanel, 500 },
        { 'BATTLE_MAP_PAGE', o.battle.isMapPage },
      }))
      return makeAction(newstateTypes)

    elseif action.type == 'BATTLE_BATTLE_CHAPTER_PAGE_SELECT_FLEET_PANEL_CLICK_INTO' then

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

      if store.battle.battleAssistantMode == 'auto' and mapProxy then
        local newstateTypes = c.yield(setScreenListeners(battleListenerList, {
          { 'BATTLE_MAP_PAGE_CHECK_SCAN_MAP_MODE', o.battle.isMapPage },
          { 'BATTLE_MAP_PAGE_CLOSE_FORMAT_PANEL', o.battle.isFormationPanel },
          { 'BATTLE_MAP_PAGE_AMBUSHED_PANEL_AVOID_AMBUSHED', o.battle.isAmbushedPanel },
          { 'BATTLE_READY_BATTLE_PAGE_CLICK_BATTLE', o.battle.isReadyBattlePage },
        }))
        return makeAction(newstateTypes)
      else
        store.battle.battleAssistantMode = 'manual'
      end

      -- 如果选择的关卡没有匹配任何关卡，那么也回到手动模式。
      stepLabel.setStepLabelContent('2-13.等待用户移动')

      if settings.battleAlertWhenManual then
        vibratorPromise(3)
      end

      local newstateTypes = c.yield(setScreenListeners(battleListenerList, {
        { 'BATTLE_MAP_PAGE', o.battle.isMapPage, 10000 },
        { 'BATTLE_MAP_PAGE_CLOSE_FORMAT_PANEL', o.battle.isFormationPanel },
        { 'BATTLE_MAP_PAGE_AMBUSHED_PANEL_AVOID_AMBUSHED', o.battle.isAmbushedPanel },
        { 'BATTLE_READY_BATTLE_PAGE_CLICK_BATTLE', o.battle.isReadyBattlePage },
      }))
      return makeAction(newstateTypes)

    elseif action.type == 'BATTLE_MAP_PAGE_CLOSE_FORMAT_PANEL' then

      stepLabel.setStepLabelContent('2.14.关闭阵型面板')
      o.battle.closeFormationPanel()
      local newstateTypes = c.yield(setScreenListeners(battleListenerList, {
        { 'BATTLE_MAP_PAGE', o.battle.isMapPage, 2000 },
        { 'BATTLE_MAP_PAGE_CLOSE_FORMAT_PANEL', o.battle.isFormationPanel, 2000 },
        { 'BATTLE_MAP_PAGE_AMBUSHED_PANEL_AVOID_AMBUSHED', o.battle.isAmbushedPanel },
      }))
      return makeAction(newstateTypes)

    elseif action.type == 'BATTLE_MAP_PAGE_AMBUSHED_PANEL_AVOID_AMBUSHED' then

      stepLabel.setStepLabelContent('2.15.躲避伏击')
      if settings.battleRoundabout then
        o.battle.ambushedPanelClickAvoidBtn()
      else
        o.battle.ambushedPanelClickInterceptBtn()
      end
      local newstateTypes = c.yield(setScreenListeners(battleListenerList, {
        { 'BATTLE_MAP_PAGE', o.battle.isMapPage, 3000 },
        { 'BATTLE_MAP_PAGE_CLOSE_FORMAT_PANEL', o.battle.isFormationPanel },
        { 'BATTLE_MAP_PAGE_AMBUSHED_PANEL_AVOID_AMBUSHED', o.battle.isAmbushedPanel, 2000 },
      }))
      return makeAction(newstateTypes)

    elseif action.type == 'BATTLE_MAP_PAGE_CLOSE_INFOMATION_MODAL' then

      stepLabel.setStepLabelContent('2.15.关闭信息弹窗')
      o.battle.infomationModalClickClose()
      local newstateTypes = c.yield(setScreenListeners(battleListenerList, {
        { 'BATTLE_MAP_PAGE', o.battle.isMapPage, 3000 },
        { 'BATTLE_MAP_PAGE_CLOSE_FORMAT_PANEL', o.battle.isFormationPanel },
        { 'BATTLE_MAP_PAGE_AMBUSHED_PANEL_AVOID_AMBUSHED', o.battle.isAmbushedPanel, 2000 },
      }))
      return makeAction(newstateTypes)

    elseif (action.type == 'BATTLE_MAP_PAGE_WAIT_FOR_MOVE') then

      stepLabel.setStepLabelContent('2-23.等待用户移动')
      c.yield(sleepPromise(1000))

      vibratorPromise(3)

      local newstateTypes = c.yield(setScreenListeners(battleListenerList, {
        { 'BATTLE_MAP_PAGE_WAIT_FOR_MOVE', o.battle.isMapPage, 10000 },
      }))
      return makeAction(newstateTypes)

    elseif (action.type == 'BATTLE_MAP_PAGE_CHECK_SCAN_MAP_MODE') then

      stepLabel.setStepLabelContent('2-19.检测是自动模式还是辅助模式')
      if store.battle.battleAssistantMode == 'auto' then
        if mapProxy then
          stepLabel.setStepLabelContent('2-19.scan-map-type-1')
          local newstateTypes = c.yield(setScreenListeners(battleListenerList, {
            { 'BATTLE_BATTLE_CHAPTER_PAGE_BACK_TO_HOME', o.battle.isBattleChapterPage, 2000 },
            { 'BATTLE_MAP_PAGE_AMBUSHED_PANEL_AVOID_AMBUSHED', o.battle.isAmbushedPanel, 1000 },
            { 'SCAN_MAP_TYPE_1_INIT', o.battle.isMapPage, 2000 },
          }))
          return makeAction(newstateTypes)
        end
      end
      local newstateTypes = c.yield(setScreenListeners(battleListenerList, {
        { 'BATTLE_BATTLE_CHAPTER_PAGE_BACK_TO_HOME', o.battle.isBattleChapterPage, 2000 },
        { 'BATTLE_MAP_PAGE_AMBUSHED_PANEL_AVOID_AMBUSHED', o.battle.isAmbushedPanel, 1000 },
        { 'BATTLE_MAP_PAGE_WAIT_FOR_MOVE', o.battle.isMapPage, 2000 },
      }))
      return makeAction(newstateTypes)

    elseif action.type == 'BATTLE_MAP_PAGE_CHECK_MAP_MODE' then

      stepLabel.setStepLabelContent('2-19.战斗模式')
      if store.battle.battleAssistantMode == 'auto' then
        if mapProxy then
          if settings.mapsType == 'maps-type-2' then
            stepLabel.setStepLabelContent('2-19.maps-type-2')
            local newstateTypes = c.yield(setScreenListeners(battleListenerList, {
              { 'BATTLE_BATTLE_CHAPTER_PAGE_BACK_TO_HOME', o.battle.isBattleChapterPage, 2000 },
              { 'BATTLE_MAP_PAGE_AMBUSHED_PANEL_AVOID_AMBUSHED', o.battle.isAmbushedPanel, 1000 },
              { 'MAPS_TYPE_2_INIT', o.battle.isMapPage, 2000 },
            }))
            return makeAction(newstateTypes)
          elseif settings.mapsType == 'maps-type-3' then
            stepLabel.setStepLabelContent('2-19.maps-type-3')
            local newstateTypes = c.yield(setScreenListeners(battleListenerList, {
              { 'BATTLE_BATTLE_CHAPTER_PAGE_BACK_TO_HOME', o.battle.isBattleChapterPage, 2000 },
              { 'BATTLE_MAP_PAGE_AMBUSHED_PANEL_AVOID_AMBUSHED', o.battle.isAmbushedPanel, 1000 },
              { 'MAPS_TYPE_3_INIT', o.battle.isMapPage, 2000 },
            }))
            return makeAction(newstateTypes)
          elseif settings.mapsType == 'maps-type-4' then
            stepLabel.setStepLabelContent('2-19.maps-type-4')
            local newstateTypes = c.yield(setScreenListeners(battleListenerList, {
              { 'BATTLE_BATTLE_CHAPTER_PAGE_BACK_TO_HOME', o.battle.isBattleChapterPage, 2000 },
              { 'BATTLE_MAP_PAGE_AMBUSHED_PANEL_AVOID_AMBUSHED', o.battle.isAmbushedPanel, 1000 },
              { 'MAPS_TYPE_4_INIT', o.battle.isMapPage, 2000 },
            }))
            return makeAction(newstateTypes)
          end
        end
      end
      local newstateTypes = c.yield(setScreenListeners(battleListenerList, {
        { 'BATTLE_BATTLE_CHAPTER_PAGE_BACK_TO_HOME', o.battle.isBattleChapterPage, 2000 },
        { 'BATTLE_MAP_PAGE_AMBUSHED_PANEL_AVOID_AMBUSHED', o.battle.isAmbushedPanel, 1000 },
        { 'BATTLE_MAP_PAGE_WAIT_FOR_MOVE', o.battle.isMapPage, 2000 },
      }))
      return makeAction(newstateTypes)

    elseif action.type == 'BATTLE_READY_BATTLE_PAGE_CLICK_BATTLE' then

      stepLabel.setStepLabelContent('2.16.准备战斗')
      c.yield(sleepPromise(1000))
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
        { 'BATTLE_IN_BATTLE_PAGE_CLICK_AUTO_BATTLE', o.battle.isNotAutoBattle, 2000 },
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

      stepLabel.setStepLabelContent('2.21.胜利面板点击继续')
      o.battle.victoryPanelClickNext()
      local newstateTypes = c.yield(setScreenListeners(battleListenerList, {
        { 'BATTLE_VICTORY_PAGE', o.battle.isGetPropsPanel, 2000 },
        { 'BATTLE_GET_EXP_PANEL', o.battle.isGetExpPanel, 2000 },
        { 'BATTLE_GET_PROPS_PANEL', o.battle.isGetPropsPanel },
      }))
      return makeAction(newstateTypes)

    elseif action.type == 'BATTLE_GET_PROPS_PANEL' then

      stepLabel.setStepLabelContent('2.22.获得道具面板点击继续')
      o.battle.getPropsPanelClickNext()
      local newstateTypes = c.yield(setScreenListeners(battleListenerList, {
        { 'BATTLE_GET_PROPS_PANEL', o.battle.isGetPropsPanel, 2000 },
        { 'BATTLE_GET_EXP_PANEL', o.battle.isGetExpPanel, 2000 },
        { 'BATTLE_GET_NEW_SHIP_PANEL', o.battle.isGetNewShipPanel },
      }))
      return makeAction(newstateTypes)

    elseif action.type == 'BATTLE_GET_NEW_SHIP_PANEL' then

      stepLabel.setStepLabelContent('2.23.获得新船面板点击继续')
      o.battle.getNewShipPanelClickNext()
      local newstateTypes = c.yield(setScreenListeners(battleListenerList, {
        { 'BATTLE_GET_NEW_SHIP_PANEL', o.battle.isGetNewShipPanel, 2000 },
        { 'BATTLE_GET_EXP_PANEL', o.battle.isGetExpPanel, 1000 },
        { 'BATTLE_LOCK_NEW_SHIP_PANEL', o.battle.isLockNewShipPanel, 1000 },
      }))
      return makeAction(newstateTypes)

    elseif action.type == 'BATTLE_LOCK_NEW_SHIP_PANEL' then

      stepLabel.setStepLabelContent('2.23.锁定新船面板点击继续')
      o.battle.lockNewShipPanelClickNext()
      local newstateTypes = c.yield(setScreenListeners(battleListenerList, {
        { 'BATTLE_GET_NEW_SHIP_PANEL', o.battle.isGetNewShipPanel, 2000 },
        { 'BATTLE_GET_EXP_PANEL', o.battle.isGetExpPanel, 2000 },
        { 'BATTLE_LOCK_NEW_SHIP_PANEL', o.battle.isLockNewShipPanel, 2000 },
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

      if settings.battleChapter.name ~= '0' then
        o.battle.battlePageClickBackToHome()
        local newstateTypes = c.yield(setScreenListeners(battleListenerList, {
          { '', o.home.isHome, 2000 },
        }))
        return makeAction(newstateTypes)
      else
        stepLabel.setStepLabelContent('2.25.等待用户操作')
        local newstateTypes = c.yield(setScreenListeners(battleListenerList, {
          { 'BATTLE_BATTLE_CHAPTER_PAGE_BACK_TO_HOME', o.battle.isBattleChapterPage, 86400 },
          { '', o.home.isHome, 2000 },
        }))
        return makeAction(newstateTypes)
      end
    end

    return nil
  end))
end

return battle
