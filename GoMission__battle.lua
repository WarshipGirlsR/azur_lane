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
      -- boss舰队是否在boss区域
      state.battle.isBossFleetInBossArea = false
      state.battle.battleNum = 0
      state.battle.battleWithConvoyNum = 0
      state.battle.battleFromState = ''
      -- 切换船的次数，如果超过4次没切换成功表示舰队沉了。
      state.battle.changeFleetNum = 0

      if (#settings.battleChapter < 1) then
        stepLabel.setStepLabelContent('2-1.没有选中章节')
        return nil, state
      end

      stepLabel.setStepLabelContent('2-2.等待HOME')
      local newstateTypes = c.yield(setScreenListeners({
        { 'BATTLE_HOME_CLICK_BATTLE', 'missionsGroup', map.home.isHome },
        { 'BATTLE_IN_BATTLE_PAGE', 'missionsGroup', map.battle.isInBattlePage, 2000 },
        { 'BATTLE_VICTORY_PANEL', 'missionsGroup', map.battle.isVictoryPanel, 2000 },
        { 'BATTLE_GET_PROPS_PANEL', 'missionsGroup', map.battle.isGetPropsPanel, 2000 },
        { 'BATTLE_GET_NEW_SHIP_PANEL', 'missionsGroup', map.battle.isGetNewShipPanel, 2000 },
        { 'BATTLE_GET_EXP_PANEL', 'missionsGroup', map.battle.isGetExpPanel, 2000 },
        { 'BATTLE_MAP_PAGE_MOVE_TO_CENTER', 'missionsGroup', map.battle.isMapPage, 2000 },
        { 'BATTLE_URGENT_ENTRUSTMENT_PANEL', 'missionsGroup', map.battle.isUrgentEntrustmentPanel, 2000 },
      }))
      return makeAction(newstateTypes), state

    elseif (action.type == 'BATTLE_HOME_CLICK_BATTLE') then

      stepLabel.setStepLabelContent('2-3.点击出征')
      map.home.clickBattleBtn()
      stepLabel.setStepLabelContent('2-4.等待出征页面')

      local newstateTypes = c.yield(setScreenListeners({
        { 'BATTLE_HOME_CLICK_BATTLE', 'missionsGroup', map.home.isHome, 2000 },
        { 'BATTLE_BATTLE_PAGE', 'missionsGroup', map.battle.isBattlePage },
        { 'BATTLE_MAP_PAGE_MOVE_TO_CENTER', 'missionsGroup', map.battle.isMapPage, 2000 },
      }))
      return makeAction(newstateTypes), state

    elseif (action.type == 'BATTLE_BATTLE_PAGE') then

      if (#settings.battleChapter > 1) then
        state.battle.battleChapter = table.remove(settings.battleChapter, 1)
        table.insert(settings.battleChapter, state.battle.battleChapter)
      else
        state.battle.battleChapter = settings.battleChapter[1]
      end

      stepLabel.setStepLabelContent('2-5.移动到章节' .. state.battle.battleChapter)
      map.battle.moveToChapter(state.battle.battleChapter)
      c.yield(sleepPromise(1000))

      local newstateTypes = c.yield(setScreenListeners({
        { 'BATTLE_BATTLE_PAGE', 'missionsGroup', map.battle.isBattlePage, 2000 },
        { 'BATTLE_CHAPTER_INFO_PANEL', 'missionsGroup', map.battle.isChapterInfoPanel },
        { 'BATTLE_SELECT_FLEET_PANEL', 'missionsGroup', map.battle.isSelectFleetPanel },
      }))
      return makeAction(newstateTypes), state

    elseif (action.type == 'BATTLE_CHAPTER_INFO_PANEL') then

      stepLabel.setStepLabelContent('2-6.章节信息面板')
      stepLabel.setStepLabelContent('2-7.进入章节')
      map.battle.clickGotoSelectFleedPanelBtn()

      local newstateTypes = c.yield(setScreenListeners({
        { 'BATTLE_BATTLE_PAGE', 'missionsGroup', map.battle.isBattlePage, 2000 },
        { 'BATTLE_CHAPTER_INFO_PANEL', 'missionsGroup', map.battle.isChapterInfoPanel, 2000 },
        { 'BATTLE_SELECT_FLEET_PANEL_CHECKE_SELECTED_FLEET', 'missionsGroup', map.battle.isSelectFleetPanel },
      }))
      return makeAction(newstateTypes), state

    elseif (action.type == 'BATTLE_SELECT_FLEET_PANEL_CHECKE_SELECTED_FLEET') then

      state.battle.selectFleedCount = state.battle.selectFleedCount + 1

      stepLabel.setStepLabelContent('2-8.检测已经选择的舰队')
      local res, selectList, unselectList = map.battle.checkSelectedFleet(settings.battleFleet)
      if not res then
        stepLabel.setStepLabelContent('2-9.选择舰队 ' .. table.concat(settings.battleFleet, ','))
        map.battle.clickFleet(selectList)
        map.battle.clickFleet(unselectList)
        local newstateTypes = c.yield(setScreenListeners({
          { 'BATTLE_BATTLE_PAGE', 'missionsGroup', map.battle.isBattlePage, 2000 },
          { 'BATTLE_CHAPTER_INFO_PANEL', 'missionsGroup', map.battle.isChapterInfoPanel, 2000 },
          { 'BATTLE_SELECT_FLEET_PANEL_CHECKE_SELECTED_FLEET', 'missionsGroup', map.battle.isSelectFleetPanel },
        }))
        return makeAction(newstateTypes), state
      end

      stepLabel.setStepLabelContent('2-10.已选择舰队' .. table.concat(settings.battleFleet, ','))
      map.battle.clickGotoMapBtn()
      local newstateTypes = c.yield(setScreenListeners({
        { 'BATTLE_BATTLE_PAGE', 'missionsGroup', map.battle.isBattlePage, 2000 },
        { 'BATTLE_CHAPTER_INFO_PANEL', 'missionsGroup', map.battle.isChapterInfoPanel, 2000 },
        { 'BATTLE_SELECT_FLEET_PANEL_CHECKE_SELECTED_FLEET', 'missionsGroup', map.battle.isSelectFleetPanel, 2000 },
        { 'BATTLE_MAP_PAGE_MOVE_TO_CENTER', 'missionsGroup', map.battle.isMapPage },
      }))
      return makeAction(newstateTypes), state

    elseif (action.type == 'BATTLE_MAP_PAGE_MOVE_TO_CENTER') then

      c.yield(sleepPromise(500))
      stepLabel.setStepLabelContent('2-11.移动地图到屏幕中心')
      local isCenter = map.battle.moveMapToCenter()
      if (isCenter) then
        local newstateTypes = c.yield(setScreenListeners({
          { 'BATTLE_MAP_PAGE_MOVE_A_STEP', 'missionsGroup', map.battle.isMapPage },
          { 'BATTLE_MAP_PAGE_AMBUSHED_PANEL', 'missionsGroup', map.battle.isAmbushedPanel },
          { 'BATTLE_MAP_PAGE_READY_BATTLE_PAGE', 'missionsGroup', map.battle.isReadyBattlePage },
          { 'BATTLE_IS_AUTO_BATTLE_CONFIRM_PANEL', 'missionsGroup', map.battle.isAutoBattleConfirmPanel },
        }))
        return makeAction(newstateTypes), state
      end

      local newstateTypes = c.yield(setScreenListeners({
        { 'BATTLE_MAP_PAGE_MOVE_TO_CENTER', 'missionsGroup', map.battle.isMapPage },
        { 'BATTLE_MAP_PAGE_AMBUSHED_PANEL', 'missionsGroup', map.battle.isAmbushedPanel },
        { 'BATTLE_MAP_PAGE_READY_BATTLE_PAGE', 'missionsGroup', map.battle.isReadyBattlePage },
        { 'BATTLE_IS_AUTO_BATTLE_CONFIRM_PANEL', 'missionsGroup', map.battle.isAutoBattleConfirmPanel },
      }))
      return makeAction(newstateTypes), state

    elseif (action.type == 'BATTLE_MAP_PAGE_MOVE_A_STEP') then

      if map.battle.isBossOnMap() then
        stepLabel.setStepLabelContent('2-12.移动到Boss')
        local res = map.battle.isSelectedFleed(settings.battleFleet[1])
        if (not res) and (state.battle.changeFleetNum < 4) then
          local newstateTypes = c.yield(setScreenListeners({
            { 'BATTLE_MAP_PAGE_SELECT_BOSS_FLEET', 'missionsGroup', map.battle.isMapPage },
          }))
          return makeAction(newstateTypes), state
        end
        stepLabel.setStepLabelContent('2-13.寻找boss')
        local bossPoint = map.battle.findBossPoint()
        if (bossPoint) then
          stepLabel.setStepLabelContent('2-14.移动到附近的敌人 ' .. table.join(bossPoint, ', ') .. ' ')
          map.battle.moveToEnemy(bossPoint)
          local newstateTypes = c.yield(setScreenListeners({
            { 'BATTLE_MAP_PAGE_MOVE_A_STEP', 'missionsGroup', map.battle.isMapPage, 3000 },
            { 'BATTLE_MAP_PAGE_AMBUSHED_PANEL', 'missionsGroup', map.battle.isAmbushedPanel },
            { 'BATTLE_MAP_PAGE_READY_BATTLE_PAGE', 'missionsGroup', map.battle.isReadyBattlePage },
          }))
          return makeAction(newstateTypes), state
        end

      elseif state.battle.isBossFleetInBossArea or map.battle.isFleetOnBossArea() then

        state.battle.isBossFleetInBossArea = true
        stepLabel.setStepLabelContent('2-15.切换小兵舰队')
        if (settings.battleFleet[2]) and (settings.battleFleet[2] > 0) and (not map.battle.isSelectedFleed(settings.battleFleet[2])) and (state.battle.changeFleetNum < 4) then
          local newstateTypes = c.yield(setScreenListeners({
            { 'BATTLE_MAP_PAGE_SELECT_SOLDIER_FLEET', 'missionsGroup', map.battle.isMapPage },
            { 'BATTLE_MAP_PAGE_AMBUSHED_PANEL', 'missionsGroup', map.battle.isAmbushedPanel },
            { 'BATTLE_MAP_PAGE_READY_BATTLE_PAGE', 'missionsGroup', map.battle.isReadyBattlePage },
          }))
          return makeAction(newstateTypes), state
        end

        stepLabel.setStepLabelContent('2-16.寻找最近的敌人')
        local enemyPoint = map.battle.findNearEnemyPointList()
        if (enemyPoint) then
          stepLabel.setStepLabelContent('2-17.移动到附近的敌人 ' .. table.join(enemyPoint, ', ') .. ' ')
          map.battle.moveToEnemy(enemyPoint)
          local newstateTypes = c.yield(setScreenListeners({
            { 'BATTLE_MAP_PAGE_MOVE_A_STEP', 'missionsGroup', map.battle.isMapPage, 3000 },
            { 'BATTLE_MAP_PAGE_AMBUSHED_PANEL', 'missionsGroup', map.battle.isAmbushedPanel },
            { 'BATTLE_MAP_PAGE_READY_BATTLE_PAGE', 'missionsGroup', map.battle.isReadyBattlePage },
          }))
          return makeAction(newstateTypes), state
        end

        local newstateTypes = c.yield(setScreenListeners({
          { 'BATTLE_MAP_PAGE_MOVE_A_STEP', 'missionsGroup', map.battle.isMapPage, 2000 },
          { 'BATTLE_MAP_PAGE_AMBUSHED_PANEL', 'missionsGroup', map.battle.isAmbushedPanel },
          { 'BATTLE_MAP_PAGE_READY_BATTLE_PAGE', 'missionsGroup', map.battle.isReadyBattlePage },
        }))
        return makeAction(newstateTypes), state

      else

        stepLabel.setStepLabelContent('2-18.切换boss舰队')
        local res = map.battle.isSelectedFleed(settings.battleFleet[1])
        if (not res) and (state.battle.changeFleetNum < 4) then
          local newstateTypes = c.yield(setScreenListeners({
            { 'BATTLE_MAP_PAGE_SELECT_BOSS_FLEET', 'missionsGroup', map.battle.isMapPage },
            { 'BATTLE_MAP_PAGE_AMBUSHED_PANEL', 'missionsGroup', map.battle.isAmbushedPanel },
            { 'BATTLE_MAP_PAGE_READY_BATTLE_PAGE', 'missionsGroup', map.battle.isReadyBattlePage },
          }))
          return makeAction(newstateTypes), state
        end
        stepLabel.setStepLabelContent('2-19.移动到Boss区域')
        map.battle.clickToMapBossArea()
        local newstateTypes = c.yield(setScreenListeners({
          { 'BATTLE_MAP_PAGE_MOVE_A_STEP', 'missionsGroup', map.battle.isMapPage, 2000 },
          { 'BATTLE_MAP_PAGE_AMBUSHED_PANEL', 'missionsGroup', map.battle.isAmbushedPanel },
          { 'BATTLE_MAP_PAGE_READY_BATTLE_PAGE', 'missionsGroup', map.battle.isReadyBattlePage },
        }))
        return makeAction(newstateTypes), state
      end

    elseif (action.type == 'BATTLE_MAP_PAGE_SELECT_BOSS_FLEET') then

      stepLabel.setStepLabelContent('2-20.选择boss舰队' .. settings.battleFleet[1])
      map.battle.clickSwitchFleetBtn()
      local res = map.battle.isSelectedFleed(settings.battleFleet[1])
      if (not res) and (state.battle.changeFleetNum < 4) then
        state.battle.changeFleetNum = state.battle.changeFleetNum + 1
        stepLabel.setStepLabelContent('2-21.选择boss舰队失败，再来一次')
        local newstateTypes = c.yield(setScreenListeners({
          { 'BATTLE_MAP_PAGE_SELECT_BOSS_FLEET', 'missionsGroup', map.battle.isMapPage },
        }))
        return makeAction(newstateTypes), state
      end
      local newstateTypes = c.yield(setScreenListeners({
        { 'BATTLE_MAP_PAGE_MOVE_TO_CENTER', 'missionsGroup', map.battle.isMapPage },
      }))
      return makeAction(newstateTypes), state

    elseif (action.type == 'BATTLE_MAP_PAGE_SELECT_SOLDIER_FLEET') then

      stepLabel.setStepLabelContent('2-22.选择小兵舰队' .. settings.battleFleet[2])
      map.battle.clickSwitchFleetBtn()
      local res = map.battle.isSelectedFleed(settings.battleFleet[2])
      if (not res) and (state.battle.changeFleetNum < 4) then
        state.battle.changeFleetNum = state.battle.changeFleetNum + 1
        stepLabel.setStepLabelContent('2-23.选择小兵舰队失败，再来一次')
        local newstateTypes = c.yield(setScreenListeners({
          { 'BATTLE_MAP_PAGE_SELECT_SOLDIER_FLEET', 'missionsGroup', map.battle.isMapPage },
        }))
        return makeAction(newstateTypes), state
      end
      local newstateTypes = c.yield(setScreenListeners({
        { 'BATTLE_MAP_PAGE_MOVE_TO_CENTER', 'missionsGroup', map.battle.isMapPage },
      }))
      return makeAction(newstateTypes), state

    elseif (action.type == 'BATTLE_MAP_PAGE_AMBUSHED_PANEL') then

      state.battle.battleFromState = 'BATTLE_MAP_PAGE_AMBUSHED_PANEL'
      stepLabel.setStepLabelContent('2-24.伏击面板')
      map.battle.ambushedPanelClickAvoidBtn()
      local newstateTypes = c.yield(setScreenListeners({
        { 'BATTLE_MAP_PAGE_AMBUSHED_PANEL', 'missionsGroup', map.battle.isAmbushedPanel, 2000 },
        { 'BATTLE_MAP_PAGE_MOVE_A_STEP', 'missionsGroup', map.battle.isMapPage, 2000 },
        { 'BATTLE_MAP_PAGE_READY_BATTLE_PAGE', 'missionsGroup', map.battle.isReadyBattlePage },
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
      local newstateTypes = c.yield(setScreenListeners({
        { 'BATTLE_MAP_PAGE_AMBUSHED_PANEL', 'missionsGroup', map.battle.isAmbushedPanel, 2000 },
        { 'BATTLE_MAP_PAGE_MOVE_A_STEP', 'missionsGroup', map.battle.isMapPage, 2000 },
        { 'BATTLE_IN_BATTLE_PAGE', 'missionsGroup', map.battle.isInBattlePage, 2000 },
        { 'BATTLE_AUTO_BATTLE_PANEL', 'missionsGroup', map.battle.isAutoBattle, 2000 },
        { 'BATTLE_VICTORY_PANEL', 'missionsGroup', map.battle.isVictoryPanel, 2000 },
        { 'BATTLE_GET_PROPS_PANEL', 'missionsGroup', map.battle.isGetPropsPanel, 2000 },
        { 'BATTLE_GET_NEW_SHIP_PANEL', 'missionsGroup', map.battle.isGetNewShipPanel, 2000 },
        { 'BATTLE_GET_EXP_PANEL', 'missionsGroup', map.battle.isGetExpPanel, 2000 },
      }))
      return makeAction(newstateTypes), state

    elseif (action.type == 'BATTLE_AUTO_BATTLE_PANEL') then

      stepLabel.setStepLabelContent('2-26.自动战斗提示面板')
      map.battle.inBattlePageClickAutoBattle()
      local newstateTypes = c.yield(setScreenListeners({
        { 'BATTLE_MAP_PAGE_AMBUSHED_PANEL', 'missionsGroup', map.battle.isAmbushedPanel, 2000 },
        { 'BATTLE_MAP_PAGE_MOVE_A_STEP', 'missionsGroup', map.battle.isMapPage, 2000 },
        { 'BATTLE_IN_BATTLE_PAGE', 'missionsGroup', map.battle.isInBattlePage },
        { 'BATTLE_VICTORY_PANEL', 'missionsGroup', map.battle.isVictoryPanel, 2000 },
        { 'BATTLE_GET_PROPS_PANEL', 'missionsGroup', map.battle.isGetPropsPanel, 2000 },
        { 'BATTLE_GET_NEW_SHIP_PANEL', 'missionsGroup', map.battle.isGetNewShipPanel, 2000 },
        { 'BATTLE_GET_EXP_PANEL', 'missionsGroup', map.battle.isGetExpPanel, 2000 },
      }))
      return makeAction(newstateTypes), state

    elseif (action.type == 'BATTLE_IN_BATTLE_PAGE') then

      stepLabel.setStepLabelContent('2-27.进入战斗页面')
      stepLabel.setStepLabelContent('2-28.检测是否自动战斗')
      local isAutoBattle = map.battle.isAutoBattle()
      if (not isAutoBattle) then
        map.battle.inBattlePageClickAutoBattle()
      end
      stepLabel.setStepLabelContent('2-29.等待胜利界面')
      local newstateTypes = c.yield(setScreenListeners({
        { 'BATTLE_IS_AUTO_BATTLE_CONFIRM_PANEL', 'missionsGroup', map.battle.isAutoBattleConfirmPanel },
        { 'BATTLE_VICTORY_PANEL', 'missionsGroup', map.battle.isVictoryPanel },
        { 'BATTLE_GET_PROPS_PANEL', 'missionsGroup', map.battle.isGetPropsPanel, 2000 },
        { 'BATTLE_GET_NEW_SHIP_PANEL', 'missionsGroup', map.battle.isGetNewShipPanel, 2000 },
        { 'BATTLE_GET_EXP_PANEL', 'missionsGroup', map.battle.isGetExpPanel, 2000 },
        { 'BATTLE_MAP_PAGE_MOVE_TO_CENTER', 'missionsGroup', map.battle.isMapPage, 2000 },
        { 'BATTLE_URGENT_ENTRUSTMENT_PANEL', 'missionsGroup', map.battle.isUrgentEntrustmentPanel, 2000 },
      }))
      return makeAction(newstateTypes), state

    elseif (action.type == 'BATTLE_IS_AUTO_BATTLE_CONFIRM_PANEL') then

      stepLabel.setStepLabelContent('2-30.自动战斗确认面板点击确定')
      map.battle.isAutoBattleConfirmPanelClickOk()
      local newstateTypes = c.yield(setScreenListeners({
        { 'BATTLE_IS_AUTO_BATTLE_CONFIRM_PANEL', 'missionsGroup', map.battle.isAutoBattleConfirmPanel },
        { 'BATTLE_VICTORY_PANEL', 'missionsGroup', map.battle.isVictoryPanel },
        { 'BATTLE_GET_PROPS_PANEL', 'missionsGroup', map.battle.isGetPropsPanel, 2000 },
        { 'BATTLE_GET_NEW_SHIP_PANEL', 'missionsGroup', map.battle.isGetNewShipPanel, 2000 },
        { 'BATTLE_GET_EXP_PANEL', 'missionsGroup', map.battle.isGetExpPanel, 2000 },
        { 'BATTLE_MAP_PAGE_MOVE_TO_CENTER', 'missionsGroup', map.battle.isMapPage, 2000 },
        { 'BATTLE_URGENT_ENTRUSTMENT_PANEL', 'missionsGroup', map.battle.isUrgentEntrustmentPanel, 2000 },
      }))
      return makeAction(newstateTypes), state

    elseif (action.type == 'BATTLE_VICTORY_PANEL') then

      stepLabel.setStepLabelContent('2-31.胜利面板点击继续')
      map.battle.victoryPanelClickNext()
      local newstateTypes = c.yield(setScreenListeners({
        { 'BATTLE_VICTORY_PANEL', 'missionsGroup', map.battle.isVictoryPanel, 2000 },
        { 'BATTLE_GET_PROPS_PANEL', 'missionsGroup', map.battle.isGetPropsPanel },
        { 'BATTLE_GET_NEW_SHIP_PANEL', 'missionsGroup', map.battle.isGetNewShipPanel },
        { 'BATTLE_GET_EXP_PANEL', 'missionsGroup', map.battle.isGetExpPanel },
        { 'BATTLE_MAP_PAGE_MOVE_TO_CENTER', 'missionsGroup', map.battle.isMapPage, 4000 },
        { 'BATTLE_URGENT_ENTRUSTMENT_PANEL', 'missionsGroup', map.battle.isUrgentEntrustmentPanel, 2000 },
        { 'BATTLE_CHAPTER_BACK_TO_HOME', 'missionsGroup', map.battle.isBattlePage, 4000 },
      }))
      return makeAction(newstateTypes), state

    elseif (action.type == 'BATTLE_GET_PROPS_PANEL') then

      stepLabel.setStepLabelContent('2-32.获得道具面板')
      map.battle.getNewShipPanelClickNext()
      local newstateTypes = c.yield(setScreenListeners({
        { 'BATTLE_VICTORY_PANEL', 'missionsGroup', map.battle.isVictoryPanel, 2000 },
        { 'BATTLE_GET_PROPS_PANEL', 'missionsGroup', map.battle.isGetPropsPanel, 2000 },
        { 'BATTLE_GET_NEW_SHIP_PANEL', 'missionsGroup', map.battle.isGetNewShipPanel },
        { 'BATTLE_GET_EXP_PANEL', 'missionsGroup', map.battle.isGetExpPanel },
        { 'BATTLE_MAP_PAGE_MOVE_TO_CENTER', 'missionsGroup', map.battle.isMapPage, 4000 },
        { 'BATTLE_URGENT_ENTRUSTMENT_PANEL', 'missionsGroup', map.battle.isUrgentEntrustmentPanel, 2000 },
        { 'BATTLE_CHAPTER_BACK_TO_HOME', 'missionsGroup', map.battle.isBattlePage, 4000 },
      }))
      return makeAction(newstateTypes), state

    elseif (action.type == 'BATTLE_GET_NEW_SHIP_PANEL') then

      stepLabel.setStepLabelContent('2-33.获得新船面板')
      map.battle.getNewShipPanelClickNext()
      local newstateTypes = c.yield(setScreenListeners({
        { 'BATTLE_VICTORY_PANEL', 'missionsGroup', map.battle.isVictoryPanel, 2000 },
        { 'BATTLE_GET_PROPS_PANEL', 'missionsGroup', map.battle.isGetPropsPanel, 2000 },
        { 'BATTLE_GET_NEW_SHIP_PANEL', 'missionsGroup', map.battle.isGetNewShipPanel, 2000 },
        { 'BATTLE_GET_EXP_PANEL', 'missionsGroup', map.battle.isGetExpPanel },
        { 'BATTLE_MAP_PAGE_MOVE_TO_CENTER', 'missionsGroup', map.battle.isMapPage, 4000 },
        { 'BATTLE_URGENT_ENTRUSTMENT_PANEL', 'missionsGroup', map.battle.isUrgentEntrustmentPanel, 2000 },
        { 'BATTLE_CHAPTER_BACK_TO_HOME', 'missionsGroup', map.battle.isBattlePage, 4000 },
      }))
      return makeAction(newstateTypes), state

    elseif (action.type == 'BATTLE_GET_EXP_PANEL') then

      stepLabel.setStepLabelContent('2-34.获得经验面板')
      map.battle.getExpPanelClickNext()
      local newstateTypes = c.yield(setScreenListeners({
        { 'BATTLE_VICTORY_PANEL', 'missionsGroup', map.battle.isVictoryPanel, 2000 },
        { 'BATTLE_GET_PROPS_PANEL', 'missionsGroup', map.battle.isGetPropsPanel, 2000 },
        { 'BATTLE_GET_NEW_SHIP_PANEL', 'missionsGroup', map.battle.isGetNewShipPanel },
        { 'BATTLE_GET_EXP_PANEL', 'missionsGroup', map.battle.isGetExpPanel, 2000 },
        { 'BATTLE_MAP_PAGE_MOVE_TO_CENTER', 'missionsGroup', map.battle.isMapPage, 4000 },
        { 'BATTLE_URGENT_ENTRUSTMENT_PANEL', 'missionsGroup', map.battle.isUrgentEntrustmentPanel, 2000 },
        { 'BATTLE_CHAPTER_BACK_TO_HOME', 'missionsGroup', map.battle.isBattlePage, 4000 },
        { '', 'missionsGroup', map.home.isHome },
      }))

      return makeAction(newstateTypes), state

    elseif (action.type == 'BATTLE_URGENT_ENTRUSTMENT_PANEL') then

      stepLabel.setStepLabelContent('2-35紧急委托通知')
      map.battle.urgentEntrustmentPanelClickOk()
      local newstateTypes = c.yield(setScreenListeners({
        { 'BATTLE_URGENT_ENTRUSTMENT_PANEL', 'missionsGroup', map.battle.isUrgentEntrustmentPanel, 2000 },
        { 'BATTLE_MAP_PAGE_MOVE_TO_CENTER', 'missionsGroup', map.battle.isMapPage, 4000 },
        { 'BATTLE_CHAPTER_BACK_TO_HOME', 'missionsGroup', map.battle.isBattlePage },
        { '', 'missionsGroup', map.home.isHome },
      }))
      return makeAction(newstateTypes), state

    elseif (action.type == 'BATTLE_CHAPTER_BACK_TO_HOME') then

      stepLabel.setStepLabelContent('2-36.返回HOME')
      map.battle.battlePageClickBackToHome()
      local newstateTypes = c.yield(setScreenListeners({
        { 'BATTLE_CHAPTER_BACK_TO_HOME', 'missionsGroup', map.battle.isBattlePage, 2000 },
        { '', 'missionsGroup', map.home.isHome },
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