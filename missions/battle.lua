local co = require '../lib/co'
local c = coroutine
local stepLabel = require '../utils/step-label'
local makeAction = (require './utils').makeAction
local sleepPromise = require '../utils/sleep-promise'
local moBattle = require '../meta-operation/battle'
local setScreenListeners = (require './utils').setScreenListeners

local state = require '../store'
state.battle = state.battle or {}


local battle = function(action)
  local battleListenerList = {
    { 'BATTLE_HOME_CHECK_IS_EVENT', map.home.isHome, 2000 },
    { 'BATTLE_MAP_PAGE_READY_BATTLE_PAGE', moBattle.isReadyBattlePage, 1000 },
    { 'BATTLE_IN_BATTLE_PAGE', moBattle.isInBattlePage, 2000 },
    { 'BATTLE_VICTORY_PANEL', moBattle.isVictoryPanel, 2000 },
    { 'BATTLE_GET_PROPS_PANEL', moBattle.isGetPropsPanel, 2000 },
    { 'BATTLE_GET_NEW_SHIP_PANEL', moBattle.isGetNewShipPanel, 2000 },
    { 'BATTLE_GET_EXP_PANEL', moBattle.isGetExpPanel, 2000 },
    { 'BATTLE_MAP_PAGE_CHECK_ASSISTANT_MODE', moBattle.isMapPage, 2000 },
    { { type = 'BATTLE_URGENT_ENTRUSTMENT_PANEL', addToStart = true }, moBattle.isUrgentEntrustmentPanel, 2000 },
  }

  return co(c.create(function()
    if (action.type == 'BATTLE_START') then

      state.battle.selectFleedCount = 0
      -- boss舰队是否在boss区域
      state.battle.isBossFleetInBossArea = false
      state.battle.battleNum = 0
      state.battle.battleWithConvoyNum = 0
      state.battle.battleFromState = ''
      state.battle.lastVibratorTime = os.time()
      -- 切换船的次数，如果超过4次没切换成功表示舰队沉了。
      state.battle.changeFleetNum = 0
      -- 舰队移动的状态。一次关卡走地图会有3种状态
      -- moveToWaitBoss : 移动到待命区
      -- moveToClosestEnemy : 移动到最近的敌人
      -- moveToBoss : 移动到 boss
      state.battle.moveState = 'moveToWaitBoss'
      -- 是否自动模式，如果没有相应配置的话会自动从自动切换到手动
      state.battle.battleAssistantMode = settings.battleAssistantMode

      if (settings.battleChapter == '') then
        stepLabel.setStepLabelContent('2-1.没有选中章节')
        return nil
      end

      -- 如果没有相应配置的话会自动从自动切换到手动
      if (not map['map' .. string.gsub(settings.battleChapter, '-', '_')] and settings.battleAssistantMode == 'auto') then
        stepLabel.setStepLabelContent('2-2.没有章节配置，切换为手动')
        state.battle.battleAssistantMode = 'manual'
      end

      -- 对于未知章节，只辅助略过战斗中间步骤，不自动进入章节
      if settings.battleChapter == '0' then
        local newstateTypes = c.yield(setScreenListeners(battleListenerList, {
          { 'BATTLE_START', map.home.isHome, 3600 },
          { 'BATTLE_MAP_PAGE_CHECK_ASSISTANT_MODE', moBattle.isMapPage, 2000 },
        }))
        return makeAction(newstateTypes), state
      end

      local newstateTypes = c.yield(setScreenListeners(battleListenerList, {
        { 'BATTLE_HOME_CHECK_IS_EVENT', map.home.isHome },
        { 'BATTLE_MAP_PAGE_CHECK_ASSISTANT_MODE', moBattle.isMapPage, 2000 },
      }))
      return makeAction(newstateTypes), state

    elseif (action.type == 'BATTLE_HOME_CHECK_IS_EVENT') then

      stepLabel.setStepLabelContent('2-3.检查是否活动章节')
      if string.sub(settings.battleChapter, 1, 5) == 'event' then
        stepLabel.setStepLabelContent('2-3.等待HOME')
        local newstateTypes = c.yield(setScreenListeners(battleListenerList, {
          { 'BATTLE_HOME_CLICK_EVENT_BATTLE', map.home.isHome },
          { 'BATTLE_MAP_PAGE_CHECK_ASSISTANT_MODE', moBattle.isMapPage, 2000 },
        }))
        return makeAction(newstateTypes), state
      end

      stepLabel.setStepLabelContent('2-4.等待HOME')
      local newstateTypes = c.yield(setScreenListeners(battleListenerList, {
        { 'BATTLE_HOME_CLICK_BATTLE', map.home.isHome },
        { 'BATTLE_MAP_PAGE_CHECK_ASSISTANT_MODE', moBattle.isMapPage, 2000 },
      }))
      return makeAction(newstateTypes), state

    elseif (action.type == 'BATTLE_HOME_CLICK_BATTLE') then


      stepLabel.setStepLabelContent('2-5.点击出征')
      map.home.clickBattleBtn()
      stepLabel.setStepLabelContent('2-6.等待出征页面')

      local newstateTypes = c.yield(setScreenListeners(battleListenerList, {
        { 'BATTLE_HOME_CHECK_IS_EVENT', map.home.isHome, 2000 },
        { 'BATTLE_BATTLE_PAGE_CHANGE_HARD_MODE', moBattle.isBattlePage, 1000 },
        { 'BATTLE_MAP_PAGE_CHECK_ASSISTANT_MODE', moBattle.isMapPage, 2000 },
      }))
      return makeAction(newstateTypes), state

    elseif (action.type == 'BATTLE_HOME_CLICK_EVENT_BATTLE') then

      stepLabel.setStepLabelContent('2-7.点击活动')
      map.home.clickEventBtn()
      stepLabel.setStepLabelContent('2-8.等待出征页面')

      local newstateTypes = c.yield(setScreenListeners(battleListenerList, {
        { 'BATTLE_HOME_CLICK_EVENT_BATTLE', map.home.isHome, 2000 },
        { 'BATTLE_BATTLE_PAGE', moBattle.isBattlePage },
        { 'BATTLE_MAP_PAGE_CHECK_ASSISTANT_MODE', moBattle.isMapPage, 2000 },
      }))
      return makeAction(newstateTypes), state

    elseif (action.type == 'BATTLE_BATTLE_PAGE_CHANGE_HARD_MODE') then

      if settings.battleMode == 'normal' then
        stepLabel.setStepLabelContent('2-9.检查是否是普通模式')
        if moBattle.isHardMode() then
          stepLabel.setStepLabelContent('2-6.在困难模式，切换到普通模式')
          moBattle.clickSwitchHardModeBtn()
          local newstateTypes = c.yield(setScreenListeners(battleListenerList, {
            { 'BATTLE_HOME_CHECK_IS_EVENT', map.home.isHome, 2000 },
            { 'BATTLE_BATTLE_PAGE_CHANGE_HARD_MODE', moBattle.isBattlePage, 1000 },
            { 'BATTLE_MAP_PAGE_CHECK_ASSISTANT_MODE', moBattle.isMapPage, 2000 },
          }))
          return makeAction(newstateTypes), state
        end
      else
        stepLabel.setStepLabelContent('2-10.检查是否是困难模式')
        if moBattle.isNormalMode() then
          stepLabel.setStepLabelContent('2-11.在普通模式，切换到困难模式')
          moBattle.clickSwitchHardModeBtn()
          local newstateTypes = c.yield(setScreenListeners(battleListenerList, {
            { 'BATTLE_HOME_CHECK_IS_EVENT', map.home.isHome, 2000 },
            { 'BATTLE_BATTLE_PAGE_CHANGE_HARD_MODE', moBattle.isBattlePage, 1000 },
            { 'BATTLE_MAP_PAGE_CHECK_ASSISTANT_MODE', moBattle.isMapPage, 2000 },
          }))
          return makeAction(newstateTypes), state
        end
      end

      stepLabel.setStepLabelContent('2-12.准备移动章节')
      local newstateTypes = c.yield(setScreenListeners(battleListenerList, {
        { 'BATTLE_HOME_CHECK_IS_EVENT', map.home.isHome, 2000 },
        { 'BATTLE_BATTLE_PAGE', moBattle.isBattlePage },
        { 'BATTLE_MAP_PAGE_CHECK_ASSISTANT_MODE', moBattle.isMapPage, 2000 },
      }))
      return makeAction(newstateTypes), state

    elseif (action.type == 'BATTLE_BATTLE_PAGE') then

      if settings.battleChapter == '0' then
        local newstateTypes = c.yield(setScreenListeners(battleListenerList, {
          { 'BATTLE_BATTLE_PAGE', moBattle.isBattlePage, 3600 },
        }))
        return makeAction(newstateTypes), state
      end

      stepLabel.setStepLabelContent('2-13.移动到章节' .. settings.battleChapter)
      moBattle.moveToChapter(settings.battleChapter)
      c.yield(sleepPromise(1000))

      local newstateTypes = c.yield(setScreenListeners(battleListenerList, {
        { 'BATTLE_BATTLE_PAGE', moBattle.isBattlePage, 2000 },
        { 'BATTLE_CHAPTER_INFO_PANEL', moBattle.isChapterInfoPanel },
        { 'BATTLE_SELECT_FLEET_PANEL', moBattle.isSelectFleetPanel },
        { 'BATTLE_HARD_SELECT_FLEET_PANEL_CHECKE_SELECTED_FLEET', moBattle.isHardSelectFleetPanel },
      }))
      return makeAction(newstateTypes), state

    elseif (action.type == 'BATTLE_CHAPTER_INFO_PANEL') then

      stepLabel.setStepLabelContent('2-14.章节信息面板')
      stepLabel.setStepLabelContent('2-15.进入章节')
      moBattle.clickGotoSelectFleedPanelBtn()

      local newstateTypes = c.yield(setScreenListeners(battleListenerList, {
        { 'BATTLE_CHAPTER_INFO_PANEL', moBattle.isChapterInfoPanel, 2000 },
        { 'BATTLE_SELECT_FLEET_PANEL_CHECKE_SELECTED_FLEET', moBattle.isSelectFleetPanel },
        { 'BATTLE_HARD_SELECT_FLEET_PANEL_CHECKE_SELECTED_FLEET', moBattle.isHardSelectFleetPanel },
      }))
      return makeAction(newstateTypes), state

    elseif (action.type == 'BATTLE_SELECT_FLEET_PANEL_CHECKE_SELECTED_FLEET') then

      state.battle.selectFleedCount = state.battle.selectFleedCount + 1

      stepLabel.setStepLabelContent('2-16.检测已经选择的舰队')
      local res, selectList, unselectList, selectedFeeldList = moBattle.checkSelectedFleet(settings.battleFleet)
      if not res then
        stepLabel.setStepLabelContent('2-17.选择舰队 ' .. table.concat(settings.battleFleet, ','))
        if #selectedFeeldList <= 1 then
          moBattle.clickFleet(selectList)
        else
          moBattle.clickFleet(unselectList)
        end
        local newstateTypes = c.yield(setScreenListeners(battleListenerList, {
          { 'BATTLE_SELECT_FLEET_PANEL_CHECKE_SELECTED_FLEET', moBattle.isSelectFleetPanel, 500 },
          { 'BATTLE_HARD_SELECT_FLEET_PANEL_CHECKE_SELECTED_FLEET', moBattle.isHardSelectFleetPanel },
        }))
        return makeAction(newstateTypes), state
      end

      stepLabel.setStepLabelContent('2-18.已选择舰队' .. table.concat(settings.battleFleet, ','))
      moBattle.clickGotoMapBtn()

      -- 清空棋盘信息。到了这个步骤说明这是一局新的关卡
      state.map.mapChessboard = nil

      local newstateTypes = c.yield(setScreenListeners(battleListenerList, {
        { 'BATTLE_BATTLE_PAGE', moBattle.isBattlePage, 2000 },
        { 'BATTLE_CHAPTER_INFO_PANEL', moBattle.isChapterInfoPanel, 2000 },
        { 'BATTLE_SELECT_FLEET_PANEL_CHECKE_SELECTED_FLEET', moBattle.isSelectFleetPanel, 2000 },
        { 'BATTLE_HARD_SELECT_FLEET_PANEL_CHECKE_SELECTED_FLEET', moBattle.isHardSelectFleetPanel, 2000 },
        { 'BATTLE_MAP_PAGE_CHECK_ASSISTANT_MODE', moBattle.isMapPage },
      }))
      return makeAction(newstateTypes), state

    elseif (action.type == 'BATTLE_HARD_SELECT_FLEET_PANEL_CHECKE_SELECTED_FLEET') then

      stepLabel.setStepLabelContent('2-18.困难面板，点击出征')
      moBattle.clickHardGotoSelectFleedPanelBtn()

      -- 清空棋盘信息。到了这个步骤说明这是一局新的关卡
      state.map.mapChessboard = nil

      local newstateTypes = c.yield(setScreenListeners(battleListenerList, {
        { 'BATTLE_BATTLE_PAGE', moBattle.isBattlePage, 2000 },
        { 'BATTLE_CHAPTER_INFO_PANEL', moBattle.isChapterInfoPanel, 2000 },
        { 'BATTLE_SELECT_FLEET_PANEL_CHECKE_SELECTED_FLEET', moBattle.isSelectFleetPanel, 2000 },
        { 'BATTLE_HARD_SELECT_FLEET_PANEL_CHECKE_SELECTED_FLEET', moBattle.isHardSelectFleetPanel, 2000 },
        { 'BATTLE_MAP_PAGE_CHECK_ASSISTANT_MODE', moBattle.isMapPage },
        { 'BATTLE_MAP_PAGE_AMBUSHED_PANEL', moBattle.isAmbushedPanel },
        { 'BATTLE_MAP_PAGE_READY_BATTLE_PAGE', moBattle.isReadyBattlePage, 2000 },
        { { type = 'BATTLE_MAP_PAGE_FORMATION_PANEL', addToStart = true }, moBattle.isFormationPanel },
        { 'BATTLE_IS_AUTO_BATTLE_CONFIRM_PANEL', moBattle.isAutoBattleConfirmPanel },
      }))
      return makeAction(newstateTypes), state


    elseif (action.type == 'BATTLE_MAP_PAGE_FORMATION_PANEL') then

      stepLabel.setStepLabelContent('2-23.阵型面板关闭')
      moBattle.closeFormationPanel()
      c.yield(sleepPromise(1000))
      if moBattle.isFormationPanel() then
        return makeAction('BATTLE_MAP_PAGE_FORMATION_PANEL'), state
      end
      return makeAction(''), state

    elseif (action.type == 'BATTLE_MAP_PAGE_CHECK_ASSISTANT_MODE') then

      stepLabel.setStepLabelContent('2-19.检测是自动模式还是辅助模式')
      if state.battle.battleAssistantMode == 'auto' then
        local newstateTypes = c.yield(setScreenListeners(battleListenerList, {
          { 'BATTLE_CHAPTER_BACK_TO_HOME', moBattle.isBattlePage, 2000 },
          { 'BATTLE_MAP_PAGE_AMBUSHED_PANEL', moBattle.isAmbushedPanel, 1000 },
          { 'MAPS_MAP_START', moBattle.isMapPage, 2000 },
        }))
        return makeAction(newstateTypes), state
      end
      local newstateTypes = c.yield(setScreenListeners(battleListenerList, {
        { 'BATTLE_CHAPTER_BACK_TO_HOME', moBattle.isBattlePage, 2000 },
        { 'BATTLE_MAP_PAGE_AMBUSHED_PANEL', moBattle.isAmbushedPanel, 1000 },
        { 'BATTLE_MAP_PAGE_WAIT_FOR_MOVE', moBattle.isMapPage, 2000 },
      }))
      return makeAction(newstateTypes), state

    elseif (action.type == 'BATTLE_MAP_PAGE_SELECT_FLEET') then

      if settings.battleFleet[2] then
        stepLabel.setStepLabelContent('2-20.检查舰队')
        if state.battle.moveState == 'moveToWaitBoss' or state.battle.moveState == 'moveToBoss' then
          local res = moBattle.isSelectedFleed(settings.battleFleet[1])
          if (not res) and (state.battle.changeFleetNum < 2) then
            state.battle.changeFleetNum = state.battle.changeFleetNum + 1
            stepLabel.setStepLabelContent('2-21.选择boss舰队')
            moBattle.clickSwitchFleetBtn()
            c.yield(sleepPromise(100))
            moBattle.clickAttackBtn()
            local newstateTypes = c.yield(setScreenListeners(battleListenerList, {
              { 'BATTLE_MAP_PAGE_SELECT_FLEET', moBattle.isMapPage },
            }))
            return makeAction(newstateTypes), state
          end
        elseif state.battle.moveState == 'moveToClosestEnemy' then
          local res = moBattle.isSelectedFleed(settings.battleFleet[2])
          if (not res) and (state.battle.changeFleetNum < 2) then
            state.battle.changeFleetNum = state.battle.changeFleetNum + 1
            stepLabel.setStepLabelContent('2-22.选择道中舰队')
            moBattle.clickSwitchFleetBtn()
            c.yield(sleepPromise(100))
            moBattle.clickAttackBtn()
            local newstateTypes = c.yield(setScreenListeners(battleListenerList, {
              { 'BATTLE_MAP_PAGE_SELECT_FLEET', moBattle.isMapPage, 2000 },
            }))
            return makeAction(newstateTypes), state
          end
        end
      end

      state.battle.changeFleetNum = 0
      local newstateTypes = c.yield(setScreenListeners(battleListenerList, {
        { 'BATTLE_BATTLE_PAGE', moBattle.isBattlePage, 2000 },
        { 'MAPS_MAP_GET_MAP_POSITION_FOR_A_STEP', moBattle.isMapPage },
      }))
      return makeAction(newstateTypes), state

    elseif (action.type == 'BATTLE_MAP_PAGE_WAIT_FOR_MOVE') then

      stepLabel.setStepLabelContent('2-23.等待用户移动')
      c.yield(sleepPromise(1000))
      if state.battle.lastVibratorTime < os.time() then
        state.battle.lastVibratorTime = os.time() + 10
        for var = 1, 2 do
          vibrator();
          c.yield(sleepPromise(500))
        end
      end
      local newstateTypes = c.yield(setScreenListeners(battleListenerList, {
        { 'BATTLE_BATTLE_PAGE', moBattle.isBattlePage, 2000 },
        { 'BATTLE_CHAPTER_INFO_PANEL', moBattle.isChapterInfoPanel, 2000 },
        { 'BATTLE_SELECT_FLEET_PANEL_CHECKE_SELECTED_FLEET', moBattle.isSelectFleetPanel, 2000 },
        { 'BATTLE_HARD_SELECT_FLEET_PANEL_CHECKE_SELECTED_FLEET', moBattle.isHardSelectFleetPanel, 2000 },
        { 'BATTLE_MAP_PAGE_WAIT_FOR_MOVE', moBattle.isMapPage },
        { 'BATTLE_MAP_PAGE_AMBUSHED_PANEL', moBattle.isAmbushedPanel },
        { 'BATTLE_MAP_PAGE_READY_BATTLE_PAGE', moBattle.isReadyBattlePage, 1000 },
        { 'BATTLE_IS_AUTO_BATTLE_CONFIRM_PANEL', moBattle.isAutoBattleConfirmPanel },
        { 'BATTLE_IN_BATTLE_PAGE', moBattle.isInBattlePage },
        { 'BATTLE_AUTO_BATTLE_PANEL', moBattle.isNotAutoBattle, 2000 },
        { 'BATTLE_CHAPTER_BACK_TO_HOME', moBattle.isBattlePage, 2000 },
      }))
      return makeAction(newstateTypes), state

    elseif (action.type == 'BATTLE_MAP_PAGE_AMBUSHED_PANEL') then

      state.battle.battleFromState = 'BATTLE_MAP_PAGE_AMBUSHED_PANEL'
      stepLabel.setStepLabelContent('2-24.伏击面板')
      moBattle.ambushedPanelClickAvoidBtn()
      local newstateTypes = c.yield(setScreenListeners(battleListenerList, {
        { 'BATTLE_MAP_PAGE_AMBUSHED_PANEL', moBattle.isAmbushedPanel, 2000 },
        { 'BATTLE_MAP_PAGE_CHECK_ASSISTANT_MODE', moBattle.isMapPage, 2000 },
        { 'BATTLE_MAP_PAGE_READY_BATTLE_PAGE', moBattle.isReadyBattlePage, 2000 },
        { 'BATTLE_CHAPTER_BACK_TO_HOME', moBattle.isBattlePage, 2000 },
      }))
      return makeAction(newstateTypes), state

    elseif (action.type == 'BATTLE_MAP_PAGE_READY_BATTLE_PAGE') then

      if state.battle.battleFromState ~= 'BATTLE_MAP_PAGE_AMBUSHED_PANEL' then
        state.battle.battleFromState = ''
        state.battle.battleWithConvoyNum = state.battle.battleWithConvoyNum + 1
      end
      state.battle.battleNum = state.battle.battleNum + 1
      stepLabel.setStepLabelContent('2-25.准备战斗页面')
      moBattle.readyBattlePageClickBattle()
      local newstateTypes = c.yield(setScreenListeners(battleListenerList, {
        { 'BATTLE_MAP_PAGE_READY_BATTLE_PAGE', moBattle.isReadyBattlePage, 2000 },
        { 'BATTLE_MAP_PAGE_AMBUSHED_PANEL', moBattle.isAmbushedPanel, 2000 },
        { 'BATTLE_MAP_PAGE_CHECK_ASSISTANT_MODE', moBattle.isMapPage, 2000 },
        { 'BATTLE_IN_BATTLE_PAGE', moBattle.isInBattlePage, 2000 },
        { 'BATTLE_IN_BATTLE_PAGE_SWITCH_TO_AUTO_BATTLE', moBattle.isNotAutoBattle, 2000 },
        { 'BATTLE_CHAPTER_BACK_TO_HOME', moBattle.isBattlePage, 2000 },
      }))
      return makeAction(newstateTypes), state

    elseif (action.type == 'BATTLE_IN_BATTLE_PAGE') then

      stepLabel.setStepLabelContent('2-26.进入战斗页面')
      stepLabel.setStepLabelContent('2-27.检测是否自动战斗')
      stepLabel.setStepLabelContent('2-28.等待胜利界面')
      local newstateTypes = c.yield(setScreenListeners(battleListenerList, {
        { 'BATTLE_IN_BATTLE_PAGE', moBattle.isInBattlePage, 180000 },
        { 'BATTLE_CHAPTER_BACK_TO_HOME', moBattle.isBattlePage, 2000 },
        { 'BATTLE_IN_BATTLE_PAGE_SWITCH_TO_AUTO_BATTLE', moBattle.isNotAutoBattle, 1000 },
        { 'BATTLE_IS_AUTO_BATTLE_CONFIRM_PANEL', moBattle.isAutoBattleConfirmPanel },
        { 'BATTLE_VICTORY_PANEL', moBattle.isVictoryPanel },
      }))
      return makeAction(newstateTypes), state

    elseif (action.type == 'BATTLE_IN_BATTLE_PAGE_SWITCH_TO_AUTO_BATTLE') then

      stepLabel.setStepLabelContent('2-29.切换自动战斗')
      moBattle.inBattlePageClickAutoBattle()
      return makeAction('BATTLE_IN_BATTLE_PAGE'), state

    elseif (action.type == 'BATTLE_IS_AUTO_BATTLE_CONFIRM_PANEL') then

      stepLabel.setStepLabelContent('2-30.自动战斗确认面板点击确定')
      moBattle.isAutoBattleConfirmPanelClickOk()
      local newstateTypes = c.yield(setScreenListeners(battleListenerList, {
        { 'BATTLE_IS_AUTO_BATTLE_CONFIRM_PANEL', moBattle.isAutoBattleConfirmPanel },
        { 'BATTLE_MAP_PAGE_CHECK_ASSISTANT_MODE', moBattle.isMapPage, 2000 },
        { 'BATTLE_CHAPTER_BACK_TO_HOME', moBattle.isBattlePage, 2000 },
      }))
      return makeAction(newstateTypes), state

    elseif (action.type == 'BATTLE_VICTORY_PANEL') then

      stepLabel.setStepLabelContent('2-31.胜利面板点击继续')
      moBattle.victoryPanelClickNext()
      local newstateTypes = c.yield(setScreenListeners(battleListenerList, {
        { 'BATTLE_MAP_PAGE_CHECK_ASSISTANT_MODE', moBattle.isMapPage, 2000 },
        { 'BATTLE_CHAPTER_BACK_TO_HOME', moBattle.isBattlePage, 4000 },
      }))
      return makeAction(newstateTypes), state

    elseif (action.type == 'BATTLE_GET_PROPS_PANEL') then

      stepLabel.setStepLabelContent('2-32.获得道具面板')
      moBattle.getNewShipPanelClickNext()
      local newstateTypes = c.yield(setScreenListeners(battleListenerList, {
        { 'BATTLE_GET_NEW_SHIP_PANEL', moBattle.isGetNewShipPanel },
        { 'BATTLE_GET_EXP_PANEL', moBattle.isGetExpPanel },
        { 'BATTLE_MAP_PAGE_CHECK_ASSISTANT_MODE', moBattle.isMapPage, 2000 },
        { 'BATTLE_CHAPTER_BACK_TO_HOME', moBattle.isBattlePage, 4000 },
      }))
      return makeAction(newstateTypes), state

    elseif (action.type == 'BATTLE_GET_NEW_SHIP_PANEL') then

      stepLabel.setStepLabelContent('2-33.获得新船面板')
      moBattle.getNewShipPanelClickNext()
      local newstateTypes = c.yield(setScreenListeners(battleListenerList, {
        { 'BATTLE_GET_NEW_SHIP_PANEL', moBattle.isGetNewShipPanel, 1000 },
        { 'BATTLE_MAP_PAGE_CHECK_ASSISTANT_MODE', moBattle.isMapPage, 2000 },
        { 'BATTLE_CHAPTER_BACK_TO_HOME', moBattle.isBattlePage, 4000 },
      }))
      return makeAction(newstateTypes), state

    elseif (action.type == 'BATTLE_GET_EXP_PANEL') then

      stepLabel.setStepLabelContent('2-34.获得经验面板')
      moBattle.getExpPanelClickNext()
      local newstateTypes = c.yield(setScreenListeners(battleListenerList, {
        { 'BATTLE_GET_NEW_SHIP_PANEL', moBattle.isGetNewShipPanel },
        { 'BATTLE_MAP_PAGE_CHECK_ASSISTANT_MODE', moBattle.isMapPage, 2000 },
        { 'BATTLE_CHAPTER_BACK_TO_HOME', moBattle.isBattlePage, 4000 },
        { '', map.home.isHome },
      }))

      return makeAction(newstateTypes), state

    elseif (action.type == 'BATTLE_URGENT_ENTRUSTMENT_PANEL') then

      stepLabel.setStepLabelContent('2-35.紧急委托通知')
      moBattle.urgentEntrustmentPanelClickOk()
      local newstateTypes = c.yield(setScreenListeners(battleListenerList, {
        { 'BATTLE_URGENT_ENTRUSTMENT_PANEL', moBattle.isUrgentEntrustmentPanel, 2000 },
        { 'BATTLE_MAP_PAGE_CHECK_ASSISTANT_MODE', moBattle.isMapPage, 2000 },
        { 'BATTLE_CHAPTER_BACK_TO_HOME', moBattle.isBattlePage },
        { '', map.home.isHome },
      }))
      return makeAction(newstateTypes), state

    elseif (action.type == 'BATTLE_CHAPTER_BACK_TO_HOME') then

      stepLabel.setStepLabelContent('2-36.返回HOME')
      moBattle.battlePageClickBackToHome()
      local newstateTypes = c.yield(setScreenListeners(battleListenerList, {
        { 'BATTLE_CHAPTER_BACK_TO_HOME', moBattle.isBattlePage, 2000 },
        { '', map.home.isHome },
      }))
      return makeAction(newstateTypes), state
    end

    return nil, state
  end))
end

return battle