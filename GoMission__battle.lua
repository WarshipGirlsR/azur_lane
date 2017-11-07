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

  local battleListenerList = {
    { 'BATTLE_HOME_CHECK_IS_EVENT', map.home.isHome, 2000 },
    { 'BATTLE_MAP_PAGE_READY_BATTLE_PAGE', map.battle.isReadyBattlePage, 1000 },
    { 'BATTLE_IN_BATTLE_PAGE', map.battle.isInBattlePage, 2000 },
    { 'BATTLE_VICTORY_PANEL', map.battle.isVictoryPanel, 2000 },
    { 'BATTLE_GET_PROPS_PANEL', map.battle.isGetPropsPanel, 2000 },
    { 'BATTLE_GET_NEW_SHIP_PANEL', map.battle.isGetNewShipPanel, 2000 },
    { 'BATTLE_GET_EXP_PANEL', map.battle.isGetExpPanel, 2000 },
    { 'BATTLE_MAP_PAGE_CHECK_ASSISTANT_MODE', map.battle.isMapPage, 2000 },
    { { type = 'BATTLE_MAP_PAGE_FORMATION_PANEL', addToStart = true }, map.battle.isFormationPanel },
    { { type = 'BATTLE_URGENT_ENTRUSTMENT_PANEL', addToStart = true }, map.battle.isUrgentEntrustmentPanel, 2000 },
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
        return nil, state
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
          { 'BATTLE_MAP_PAGE_CHECK_ASSISTANT_MODE', map.battle.isMapPage, 2000 },
        }))
        return makeAction(newstateTypes), state
      end

      local newstateTypes = c.yield(setScreenListeners(battleListenerList, {
        { 'BATTLE_HOME_CHECK_IS_EVENT', map.home.isHome },
        { 'BATTLE_MAP_PAGE_CHECK_ASSISTANT_MODE', map.battle.isMapPage, 2000 },
      }))
      return makeAction(newstateTypes), state

    elseif (action.type == 'BATTLE_HOME_CHECK_IS_EVENT') then

      stepLabel.setStepLabelContent('2-3.检查是否活动章节')
      if string.sub(settings.battleChapter, 1, 5) == 'event' then
        stepLabel.setStepLabelContent('2-3.等待HOME')
        local newstateTypes = c.yield(setScreenListeners(battleListenerList, {
          { 'BATTLE_HOME_CLICK_EVENT_BATTLE', map.home.isHome },
          { 'BATTLE_MAP_PAGE_CHECK_ASSISTANT_MODE', map.battle.isMapPage, 2000 },
        }))
        return makeAction(newstateTypes), state
      end

      stepLabel.setStepLabelContent('2-4.等待HOME')
      local newstateTypes = c.yield(setScreenListeners(battleListenerList, {
        { 'BATTLE_HOME_CLICK_BATTLE', map.home.isHome },
        { 'BATTLE_MAP_PAGE_CHECK_ASSISTANT_MODE', map.battle.isMapPage, 2000 },
      }))
      return makeAction(newstateTypes), state

    elseif (action.type == 'BATTLE_HOME_CLICK_BATTLE') then


      stepLabel.setStepLabelContent('2-5.点击出征')
      map.home.clickBattleBtn()
      stepLabel.setStepLabelContent('2-6.等待出征页面')

      local newstateTypes = c.yield(setScreenListeners(battleListenerList, {
        { 'BATTLE_HOME_CHECK_IS_EVENT', map.home.isHome, 2000 },
        { 'BATTLE_BATTLE_PAGE_CHANGE_HARD_MODE', map.battle.isBattlePage },
        { 'BATTLE_MAP_PAGE_CHECK_ASSISTANT_MODE', map.battle.isMapPage, 2000 },
      }))
      return makeAction(newstateTypes), state

    elseif (action.type == 'BATTLE_HOME_CLICK_EVENT_BATTLE') then

      stepLabel.setStepLabelContent('2-7.点击活动')
      map.home.clickEventBtn()
      stepLabel.setStepLabelContent('2-8.等待出征页面')

      local newstateTypes = c.yield(setScreenListeners(battleListenerList, {
        { 'BATTLE_HOME_CLICK_EVENT_BATTLE', map.home.isHome, 2000 },
        { 'BATTLE_BATTLE_PAGE', map.battle.isBattlePage },
        { 'BATTLE_MAP_PAGE_CHECK_ASSISTANT_MODE', map.battle.isMapPage, 2000 },
      }))
      return makeAction(newstateTypes), state

    elseif (action.type == 'BATTLE_BATTLE_PAGE_CHANGE_HARD_MODE') then

      if settings.battleMode == 'normal' then
        stepLabel.setStepLabelContent('2-9.检查是否是普通模式')
        if map.battle.isHardMode() then
          stepLabel.setStepLabelContent('2-6.在困难模式，切换到普通模式')
          map.battle.clickSwitchHardModeBtn()
          local newstateTypes = c.yield(setScreenListeners(battleListenerList, {
            { 'BATTLE_HOME_CHECK_IS_EVENT', map.home.isHome, 2000 },
            { 'BATTLE_BATTLE_PAGE_CHANGE_HARD_MODE', map.battle.isBattlePage, 1000 },
            { 'BATTLE_MAP_PAGE_CHECK_ASSISTANT_MODE', map.battle.isMapPage, 2000 },
          }))
          return makeAction(newstateTypes), state
        end
      else
        stepLabel.setStepLabelContent('2-10.检查是否是困难模式')
        if map.battle.isNormalMode() then
          stepLabel.setStepLabelContent('2-11.在普通模式，切换到困难模式')
          map.battle.clickSwitchHardModeBtn()
          local newstateTypes = c.yield(setScreenListeners(battleListenerList, {
            { 'BATTLE_HOME_CHECK_IS_EVENT', map.home.isHome, 2000 },
            { 'BATTLE_BATTLE_PAGE_CHANGE_HARD_MODE', map.battle.isBattlePage, 1000 },
            { 'BATTLE_MAP_PAGE_CHECK_ASSISTANT_MODE', map.battle.isMapPage, 2000 },
          }))
          return makeAction(newstateTypes), state
        end
      end

      stepLabel.setStepLabelContent('2-12.准备移动章节')
      local newstateTypes = c.yield(setScreenListeners(battleListenerList, {
        { 'BATTLE_HOME_CHECK_IS_EVENT', map.home.isHome, 2000 },
        { 'BATTLE_BATTLE_PAGE', map.battle.isBattlePage },
        { 'BATTLE_MAP_PAGE_CHECK_ASSISTANT_MODE', map.battle.isMapPage, 2000 },
      }))
      return makeAction(newstateTypes), state

    elseif (action.type == 'BATTLE_BATTLE_PAGE') then

      if settings.battleChapter == '0' then
        local newstateTypes = c.yield(setScreenListeners(battleListenerList, {
          { 'BATTLE_BATTLE_PAGE', map.battle.isBattlePage, 3600 },
        }))
        return makeAction(newstateTypes), state
      end

      stepLabel.setStepLabelContent('2-13.移动到章节' .. settings.battleChapter)
      map.battle.moveToChapter(settings.battleChapter)
      c.yield(sleepPromise(1000))

      local newstateTypes = c.yield(setScreenListeners(battleListenerList, {
        { 'BATTLE_BATTLE_PAGE', map.battle.isBattlePage, 2000 },
        { 'BATTLE_CHAPTER_INFO_PANEL', map.battle.isChapterInfoPanel },
        { 'BATTLE_SELECT_FLEET_PANEL', map.battle.isSelectFleetPanel },
        { 'BATTLE_HARD_SELECT_FLEET_PANEL_CHECKE_SELECTED_FLEET', map.battle.isHardSelectFleetPanel },
      }))
      return makeAction(newstateTypes), state

    elseif (action.type == 'BATTLE_CHAPTER_INFO_PANEL') then

      stepLabel.setStepLabelContent('2-14.章节信息面板')
      stepLabel.setStepLabelContent('2-15.进入章节')
      map.battle.clickGotoSelectFleedPanelBtn()

      local newstateTypes = c.yield(setScreenListeners(battleListenerList, {
        { 'BATTLE_CHAPTER_INFO_PANEL', map.battle.isChapterInfoPanel, 2000 },
        { 'BATTLE_SELECT_FLEET_PANEL_CHECKE_SELECTED_FLEET', map.battle.isSelectFleetPanel },
        { 'BATTLE_HARD_SELECT_FLEET_PANEL_CHECKE_SELECTED_FLEET', map.battle.isHardSelectFleetPanel },
      }))
      return makeAction(newstateTypes), state

    elseif (action.type == 'BATTLE_SELECT_FLEET_PANEL_CHECKE_SELECTED_FLEET') then

      state.battle.selectFleedCount = state.battle.selectFleedCount + 1

      stepLabel.setStepLabelContent('2-16.检测已经选择的舰队')
      local res, selectList, unselectList = map.battle.checkSelectedFleet(settings.battleFleet)
      if not res then
        stepLabel.setStepLabelContent('2-17.选择舰队 ' .. table.concat(settings.battleFleet, ','))
        map.battle.clickFleet(selectList)
        map.battle.clickFleet(unselectList)
        local newstateTypes = c.yield(setScreenListeners(battleListenerList, {
          { 'BATTLE_SELECT_FLEET_PANEL_CHECKE_SELECTED_FLEET', map.battle.isSelectFleetPanel, 500 },
          { 'BATTLE_HARD_SELECT_FLEET_PANEL_CHECKE_SELECTED_FLEET', map.battle.isHardSelectFleetPanel },
        }))
        return makeAction(newstateTypes), state
      end

      stepLabel.setStepLabelContent('2-18.已选择舰队' .. table.concat(settings.battleFleet, ','))
      map.battle.clickGotoMapBtn()

      -- 清空棋盘信息。到了这个步骤说明这是一局新的关卡
      state.map.mapChessboard = nil

      local newstateTypes = c.yield(setScreenListeners(battleListenerList, {
        { 'BATTLE_BATTLE_PAGE', map.battle.isBattlePage, 2000 },
        { 'BATTLE_CHAPTER_INFO_PANEL', map.battle.isChapterInfoPanel, 2000 },
        { 'BATTLE_SELECT_FLEET_PANEL_CHECKE_SELECTED_FLEET', map.battle.isSelectFleetPanel, 2000 },
        { 'BATTLE_HARD_SELECT_FLEET_PANEL_CHECKE_SELECTED_FLEET', map.battle.isHardSelectFleetPanel, 2000 },
        { 'BATTLE_MAP_PAGE_CHECK_ASSISTANT_MODE', map.battle.isMapPage },
      }))
      return makeAction(newstateTypes), state

    elseif (action.type == 'BATTLE_HARD_SELECT_FLEET_PANEL_CHECKE_SELECTED_FLEET') then

      stepLabel.setStepLabelContent('2-18.困难面板，点击出征')
      map.battle.clickHardGotoSelectFleedPanelBtn()

      -- 清空棋盘信息。到了这个步骤说明这是一局新的关卡
      state.map.mapChessboard = nil

      local newstateTypes = c.yield(setScreenListeners(battleListenerList, {
        { 'BATTLE_BATTLE_PAGE', map.battle.isBattlePage, 2000 },
        { 'BATTLE_CHAPTER_INFO_PANEL', map.battle.isChapterInfoPanel, 2000 },
        { 'BATTLE_SELECT_FLEET_PANEL_CHECKE_SELECTED_FLEET', map.battle.isSelectFleetPanel, 2000 },
        { 'BATTLE_HARD_SELECT_FLEET_PANEL_CHECKE_SELECTED_FLEET', map.battle.isHardSelectFleetPanel, 2000 },
        { 'BATTLE_MAP_PAGE_CHECK_ASSISTANT_MODE', map.battle.isMapPage },
        { 'BATTLE_MAP_PAGE_AMBUSHED_PANEL', map.battle.isAmbushedPanel },
        { 'BATTLE_MAP_PAGE_READY_BATTLE_PAGE', map.battle.isReadyBattlePage, 2000 },
        { 'BATTLE_IS_AUTO_BATTLE_CONFIRM_PANEL', map.battle.isAutoBattleConfirmPanel },
      }))
      return makeAction(newstateTypes), state


    elseif (action.type == 'BATTLE_MAP_PAGE_FORMATION_PANEL') then

      stepLabel.setStepLabelContent('2-23.阵型面板关闭')
      map.battle.closeFormationPanel()
      local newstateTypes = c.yield(setScreenListeners(battleListenerList, {
        { 'BATTLE_BATTLE_PAGE', map.battle.isBattlePage, 2000 },
        { 'BATTLE_MAP_PAGE_CHECK_ASSISTANT_MODE', map.battle.isMapPage },
      }))
      return makeAction(newstateTypes), state

    elseif (action.type == 'BATTLE_MAP_PAGE_CHECK_ASSISTANT_MODE') then

      stepLabel.setStepLabelContent('2-19.检测是自动模式还是辅助模式')
      if state.battle.battleAssistantMode == 'auto' then
        local newstateTypes = c.yield(setScreenListeners(battleListenerList, {
          { 'BATTLE_CHAPTER_BACK_TO_HOME', map.battle.isBattlePage, 2000 },
          { 'BATTLE_MAP_PAGE_AMBUSHED_PANEL', map.battle.isAmbushedPanel, 1000 },
          { 'MAPS_MAP_START', map.battle.isMapPage, 2000 },
        }))
        return makeAction(newstateTypes), state
      end
      local newstateTypes = c.yield(setScreenListeners(battleListenerList, {
        { 'BATTLE_CHAPTER_BACK_TO_HOME', map.battle.isBattlePage, 2000 },
        { 'BATTLE_MAP_PAGE_AMBUSHED_PANEL', map.battle.isAmbushedPanel, 1000 },
        { 'BATTLE_MAP_PAGE_WAIT_FOR_MOVE', map.battle.isMapPage, 2000 },
      }))
      return makeAction(newstateTypes), state

    elseif (action.type == 'BATTLE_MAP_PAGE_SELECT_FLEET') then

      if settings.battleFleet[2] then
        stepLabel.setStepLabelContent('2-20.检查舰队')
        if state.battle.moveState == 'moveToWaitBoss' or state.battle.moveState == 'moveToBoss' then
          local res = map.battle.isSelectedFleed(settings.battleFleet[1])
          if (not res) and (state.battle.changeFleetNum < 2) then
            state.battle.changeFleetNum = state.battle.changeFleetNum + 1
            stepLabel.setStepLabelContent('2-21.选择boss舰队')
            map.battle.clickSwitchFleetBtn()
            c.yield(sleepPromise(100))
            map.battle.clickAttackBtn()
            local newstateTypes = c.yield(setScreenListeners(battleListenerList, {
              { 'BATTLE_MAP_PAGE_SELECT_FLEET', map.battle.isMapPage },
            }))
            return makeAction(newstateTypes), state
          end
        elseif state.battle.moveState == 'moveToClosestEnemy' then
          local res = map.battle.isSelectedFleed(settings.battleFleet[2])
          if (not res) and (state.battle.changeFleetNum < 2) then
            state.battle.changeFleetNum = state.battle.changeFleetNum + 1
            stepLabel.setStepLabelContent('2-22.选择道中舰队')
            map.battle.clickSwitchFleetBtn()
            c.yield(sleepPromise(100))
            map.battle.clickAttackBtn()
            local newstateTypes = c.yield(setScreenListeners(battleListenerList, {
              { 'BATTLE_MAP_PAGE_SELECT_FLEET', map.battle.isMapPage, 2000 },
            }))
            return makeAction(newstateTypes), state
          end
        end
      end

      state.battle.changeFleetNum = 0
      local newstateTypes = c.yield(setScreenListeners(battleListenerList, {
        { 'BATTLE_BATTLE_PAGE', map.battle.isBattlePage, 2000 },
        { 'MAPS_MAP_GET_MAP_POSITION_FOR_A_STEP', map.battle.isMapPage },
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
        { 'BATTLE_BATTLE_PAGE', map.battle.isBattlePage, 2000 },
        { 'BATTLE_CHAPTER_INFO_PANEL', map.battle.isChapterInfoPanel, 2000 },
        { 'BATTLE_SELECT_FLEET_PANEL_CHECKE_SELECTED_FLEET', map.battle.isSelectFleetPanel, 2000 },
        { 'BATTLE_HARD_SELECT_FLEET_PANEL_CHECKE_SELECTED_FLEET', map.battle.isHardSelectFleetPanel, 2000 },
        { 'BATTLE_MAP_PAGE_WAIT_FOR_MOVE', map.battle.isMapPage },
        { 'BATTLE_MAP_PAGE_AMBUSHED_PANEL', map.battle.isAmbushedPanel },
        { 'BATTLE_MAP_PAGE_READY_BATTLE_PAGE', map.battle.isReadyBattlePage, 1000 },
        { 'BATTLE_IS_AUTO_BATTLE_CONFIRM_PANEL', map.battle.isAutoBattleConfirmPanel },
        { 'BATTLE_IN_BATTLE_PAGE', map.battle.isInBattlePage },
        { 'BATTLE_AUTO_BATTLE_PANEL', map.battle.isNotAutoBattle, 2000 },
        { 'BATTLE_CHAPTER_BACK_TO_HOME', map.battle.isBattlePage, 2000 },
      }))
      return makeAction(newstateTypes), state

    elseif (action.type == 'BATTLE_MAP_PAGE_AMBUSHED_PANEL') then

      state.battle.battleFromState = 'BATTLE_MAP_PAGE_AMBUSHED_PANEL'
      stepLabel.setStepLabelContent('2-24.伏击面板')
      map.battle.ambushedPanelClickAvoidBtn()
      local newstateTypes = c.yield(setScreenListeners(battleListenerList, {
        { 'BATTLE_MAP_PAGE_AMBUSHED_PANEL', map.battle.isAmbushedPanel, 2000 },
        { 'BATTLE_MAP_PAGE_CHECK_ASSISTANT_MODE', map.battle.isMapPage, 2000 },
        { 'BATTLE_MAP_PAGE_READY_BATTLE_PAGE', map.battle.isReadyBattlePage, 2000 },
        { 'BATTLE_CHAPTER_BACK_TO_HOME', map.battle.isBattlePage, 2000 },
      }))
      return makeAction(newstateTypes), state

    elseif (action.type == 'BATTLE_MAP_PAGE_READY_BATTLE_PAGE') then

      if state.battle.battleFromState ~= 'BATTLE_MAP_PAGE_AMBUSHED_PANEL' then
        state.battle.battleFromState = ''
        state.battle.battleWithConvoyNum = state.battle.battleWithConvoyNum + 1
      end
      state.battle.battleNum = state.battle.battleNum + 1
      stepLabel.setStepLabelContent('2-25.准备战斗页面')
      map.battle.readyBattlePageClickBattle()
      local newstateTypes = c.yield(setScreenListeners(battleListenerList, {
        { 'BATTLE_MAP_PAGE_READY_BATTLE_PAGE', map.battle.isReadyBattlePage, 2000 },
        { 'BATTLE_MAP_PAGE_AMBUSHED_PANEL', map.battle.isAmbushedPanel, 2000 },
        { 'BATTLE_MAP_PAGE_CHECK_ASSISTANT_MODE', map.battle.isMapPage, 2000 },
        { 'BATTLE_IN_BATTLE_PAGE', map.battle.isInBattlePage, 2000 },
        { 'BATTLE_IN_BATTLE_PAGE_SWITCH_TO_AUTO_BATTLE', map.battle.isNotAutoBattle, 2000 },
        { 'BATTLE_CHAPTER_BACK_TO_HOME', map.battle.isBattlePage, 2000 },
      }))
      return makeAction(newstateTypes), state

    elseif (action.type == 'BATTLE_IN_BATTLE_PAGE') then

      stepLabel.setStepLabelContent('2-26.进入战斗页面')
      stepLabel.setStepLabelContent('2-27.检测是否自动战斗')
      stepLabel.setStepLabelContent('2-28.等待胜利界面')
      local newstateTypes = c.yield(setScreenListeners(battleListenerList, {
        { 'BATTLE_IN_BATTLE_PAGE', map.battle.isInBattlePage, 180000 },
        { 'BATTLE_CHAPTER_BACK_TO_HOME', map.battle.isBattlePage, 2000 },
        { 'BATTLE_IN_BATTLE_PAGE_SWITCH_TO_AUTO_BATTLE', map.battle.isNotAutoBattle, 1000 },
        { 'BATTLE_IS_AUTO_BATTLE_CONFIRM_PANEL', map.battle.isAutoBattleConfirmPanel },
        { 'BATTLE_VICTORY_PANEL', map.battle.isVictoryPanel },
      }))
      return makeAction(newstateTypes), state

    elseif (action.type == 'BATTLE_IN_BATTLE_PAGE_SWITCH_TO_AUTO_BATTLE') then

      stepLabel.setStepLabelContent('2-29.切换自动战斗')
      map.battle.inBattlePageClickAutoBattle()
      return makeAction('BATTLE_IN_BATTLE_PAGE'), state

    elseif (action.type == 'BATTLE_IS_AUTO_BATTLE_CONFIRM_PANEL') then

      stepLabel.setStepLabelContent('2-30.自动战斗确认面板点击确定')
      map.battle.isAutoBattleConfirmPanelClickOk()
      local newstateTypes = c.yield(setScreenListeners(battleListenerList, {
        { 'BATTLE_IS_AUTO_BATTLE_CONFIRM_PANEL', map.battle.isAutoBattleConfirmPanel },
        { 'BATTLE_MAP_PAGE_CHECK_ASSISTANT_MODE', map.battle.isMapPage, 2000 },
        { 'BATTLE_CHAPTER_BACK_TO_HOME', map.battle.isBattlePage, 2000 },
      }))
      return makeAction(newstateTypes), state

    elseif (action.type == 'BATTLE_VICTORY_PANEL') then

      stepLabel.setStepLabelContent('2-31.胜利面板点击继续')
      map.battle.victoryPanelClickNext()
      local newstateTypes = c.yield(setScreenListeners(battleListenerList, {
        { 'BATTLE_MAP_PAGE_CHECK_ASSISTANT_MODE', map.battle.isMapPage, 2000 },
        { 'BATTLE_CHAPTER_BACK_TO_HOME', map.battle.isBattlePage, 4000 },
      }))
      return makeAction(newstateTypes), state

    elseif (action.type == 'BATTLE_GET_PROPS_PANEL') then

      stepLabel.setStepLabelContent('2-32.获得道具面板')
      map.battle.getNewShipPanelClickNext()
      local newstateTypes = c.yield(setScreenListeners(battleListenerList, {
        { 'BATTLE_GET_NEW_SHIP_PANEL', map.battle.isGetNewShipPanel },
        { 'BATTLE_GET_EXP_PANEL', map.battle.isGetExpPanel },
        { 'BATTLE_MAP_PAGE_CHECK_ASSISTANT_MODE', map.battle.isMapPage, 2000 },
        { 'BATTLE_CHAPTER_BACK_TO_HOME', map.battle.isBattlePage, 4000 },
      }))
      return makeAction(newstateTypes), state

    elseif (action.type == 'BATTLE_GET_NEW_SHIP_PANEL') then

      stepLabel.setStepLabelContent('2-33.获得新船面板')
      map.battle.getNewShipPanelClickNext()
      local newstateTypes = c.yield(setScreenListeners(battleListenerList, {
        { 'BATTLE_GET_NEW_SHIP_PANEL', map.battle.isGetNewShipPanel, 1000 },
        { 'BATTLE_MAP_PAGE_CHECK_ASSISTANT_MODE', map.battle.isMapPage, 2000 },
        { 'BATTLE_CHAPTER_BACK_TO_HOME', map.battle.isBattlePage, 4000 },
      }))
      return makeAction(newstateTypes), state

    elseif (action.type == 'BATTLE_GET_EXP_PANEL') then

      stepLabel.setStepLabelContent('2-34.获得经验面板')
      map.battle.getExpPanelClickNext()
      local newstateTypes = c.yield(setScreenListeners(battleListenerList, {
        { 'BATTLE_GET_NEW_SHIP_PANEL', map.battle.isGetNewShipPanel },
        { 'BATTLE_MAP_PAGE_CHECK_ASSISTANT_MODE', map.battle.isMapPage, 2000 },
        { 'BATTLE_CHAPTER_BACK_TO_HOME', map.battle.isBattlePage, 4000 },
        { '', map.home.isHome },
      }))

      return makeAction(newstateTypes), state

    elseif (action.type == 'BATTLE_URGENT_ENTRUSTMENT_PANEL') then

      stepLabel.setStepLabelContent('2-35.紧急委托通知')
      map.battle.urgentEntrustmentPanelClickOk()
      local newstateTypes = c.yield(setScreenListeners(battleListenerList, {
        { 'BATTLE_URGENT_ENTRUSTMENT_PANEL', map.battle.isUrgentEntrustmentPanel, 2000 },
        { 'BATTLE_MAP_PAGE_CHECK_ASSISTANT_MODE', map.battle.isMapPage, 2000 },
        { 'BATTLE_CHAPTER_BACK_TO_HOME', map.battle.isBattlePage },
        { '', map.home.isHome },
      }))
      return makeAction(newstateTypes), state

    elseif (action.type == 'BATTLE_CHAPTER_BACK_TO_HOME') then

      stepLabel.setStepLabelContent('2-36.返回HOME')
      map.battle.battlePageClickBackToHome()
      local newstateTypes = c.yield(setScreenListeners(battleListenerList, {
        { 'BATTLE_CHAPTER_BACK_TO_HOME', map.battle.isBattlePage, 2000 },
        { '', map.home.isHome },
      }))
      return makeAction(newstateTypes), state
    end

    return nil, state
  end))
end

return function(state)
  state.battle = {}
  return battleOnce
end