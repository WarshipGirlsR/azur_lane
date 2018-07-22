local co = require '../lib/co'
local c = coroutine
local stepLabel = require '../utils/step-label'
local makeAction = (require './utils').makeAction
local sleepPromise = require '../utils/sleep-promise'
local moBattle = require '../meta-operation/battle'
local moExercise = require '../meta-operation/exercise'
local moHome = require '../meta-operation/home'
local moMap = require '../meta-operation/maps-options/index'
local setScreenListeners = (require './utils').setScreenListeners
local store = require '../store'
local vibratorPromise = require '../utils/vibrator-promise'

store.exercise = store.exercise or {
  nextCheckExerciseTime = os.time(),
}

local o = {
  home = moHome,
  battle = moBattle,
  exercise = moExercise,
  map = moMap,
}
local exerciseListenerList = {
  { '', o.home.isHome, 2000 },
  { 'EXERCISE_EXERCISE_PAGE_BACK_TO_HOME', o.battle.isBattleChapterPage, 2000 },
  { 'EXERCISE_EXERCISE_PAGE_START_EXERCISE', o.battle.isReadyBattlePage, 2000 },
  { 'EXERCISE_EXERCISE_PAGE_ENEMY_INFO_PAGE', o.exercise.isEnemyInfoPage, 2000 },
  { 'EXERCISE_EXERCISE_PAGE_START_EXERCISE', o.exercise.isExercisePage, 2000 },
  { 'EXERCISE_IN_BATTLE_PAGE', o.exercise.isInBattlePage, 2000 },
  { 'EXERCISE_VICTORY_PAGE', o.battle.isVictoryPanel, 2000 },
  { 'EXERCISE_GET_PROPS_PANEL', o.battle.isGetPropsPanel, 2000 },
  { 'EXERCISE_GET_NEW_SHIP_PANEL', o.battle.isGetNewShipPanel, 2000 },
  { 'EXERCISE_GET_EXP_PANEL', o.battle.isGetExpPanel, 2000 },
}

local exercise = function(action)
  local settings = store.settings;
  local mapProxy = o.map['map' .. settings.battleChapter.name]
  return co(c.create(function()

    if action.type == 'EXERCISE_INIT' then

      if store.exercise.nextCheckExerciseTime and store.exercise.nextCheckExerciseTime > os.time() then
        stepLabel.setStepLabelContent('5.1.下次演习时间：' .. os.date("%Y-%m-%d %H:%M:%S", store.exercise.nextCheckExerciseTime))
        local newstateTypes = c.yield(setScreenListeners(exerciseListenerList, {
          { '', o.home.isHome },
          { 'EXERCISE_EXERCISE_PAGE_BACK_TO_HOME', o.battle.isBattleChapterPage },
          { 'EXERCISE_EXERCISE_PAGE_BACK_TO_HOME', o.battle.isReadyBattlePage },
          { 'EXERCISE_EXERCISE_PAGE_BACK_TO_HOME', o.exercise.isEnemyInfoPage },
        }))
        return makeAction(newstateTypes)
      end

      local newstateTypes = c.yield(setScreenListeners(exerciseListenerList, {
        { 'EXERCISE_START', o.home.isHome },
      }))
      return makeAction(newstateTypes)

    elseif action.type == 'EXERCISE_START' then

      stepLabel.setStepLabelContent('5.1.等待桌面')
      local newstateTypes = c.yield(setScreenListeners(exerciseListenerList, {
        { 'EXERCISE_HOME_CLICK_BATTLE', o.home.isHome, 2000 },
      }))
      return makeAction(newstateTypes)

    elseif action.type == 'EXERCISE_HOME_CLICK_BATTLE' then

      stepLabel.setStepLabelContent('5.2.点击出击')
      o.battle.clickBattleBtn()
      local newstateTypes = c.yield(setScreenListeners(exerciseListenerList, {
        { 'EXERCISE_HOME_CLICK_BATTLE', o.home.isHome, 2000 },
        { 'EXERCISE_BATTLE_CHAPTER_CLICK_EXERCISE', o.battle.isBattleChapterPage },
      }))
      return makeAction(newstateTypes)

    elseif action.type == 'EXERCISE_BATTLE_CHAPTER_CLICK_EXERCISE' then

      stepLabel.setStepLabelContent('5.2.点击演习')
      o.exercise.clickExerciseBtn()
      local newstateTypes = c.yield(setScreenListeners(exerciseListenerList, {
        { 'EXERCISE_HOME_CLICK_BATTLE', o.home.isHome, 2000 },
        { 'EXERCISE_BATTLE_CHAPTER_CLICK_EXERCISE', o.battle.isBattleChapterPage, 1000 },
        { 'EXERCISE_EXERCISE_PAGE_START_EXERCISE', o.exercise.isExercisePage },
        { 'EXERCISE_EXERCISE_PAGE_ENEMY_INFO_PAGE', o.exercise.isEnemyInfoPage },
      }))
      return makeAction(newstateTypes)

    elseif action.type == 'EXERCISE_EXERCISE_PAGE_START_EXERCISE' then

      c.yield(sleepPromise(1000))
      if not o.exercise.isExercisePageExerciseNumZero() then
        if settings.exerciseSelectEnemy ~= 'manual' and settings.exerciseSelectEnemy > 0 then
          stepLabel.setStepLabelContent('5.10.选择敌人')
          o.exercise.clickEnemyFleet(settings.exerciseSelectEnemy)
          local newstateTypes = c.yield(setScreenListeners(exerciseListenerList, {
            { 'EXERCISE_BATTLE_CHAPTER_CLICK_EXERCISE', o.battle.isBattleChapterPage, 1000 },
            { 'EXERCISE_EXERCISE_PAGE_START_EXERCISE', o.exercise.isExercisePage, 2000 },
            { 'EXERCISE_EXERCISE_PAGE_ENEMY_INFO_PAGE', o.exercise.isEnemyInfoPage, 2000 },
            { 'EXERCISE_READY_PAGE_CLICK_BATTLE', o.battle.isReadyBattlePage },
          }))
          return makeAction(newstateTypes)
        else
          stepLabel.setStepLabelContent('5.10.等待用户选择敌人')
          if settings.exerciseAlertWhenManualSelectEnemy then
            vibratorPromise(3)
          end
          local newstateTypes = c.yield(setScreenListeners(exerciseListenerList, {
            { 'EXERCISE_BATTLE_CHAPTER_CLICK_EXERCISE', o.battle.isBattleChapterPage, 1000 },
            { 'EXERCISE_EXERCISE_PAGE_START_EXERCISE', o.exercise.isExercisePage, 15000 },
            { 'EXERCISE_EXERCISE_PAGE_ENEMY_INFO_PAGE', o.exercise.isEnemyInfoPage },
            { 'EXERCISE_READY_PAGE_CLICK_BATTLE', o.battle.isReadyBattlePage },
          }))
          return makeAction(newstateTypes)
        end
      end
      local newstateTypes = c.yield(setScreenListeners(exerciseListenerList, {
        { 'EXERCISE_EXERCISE_PAGE_BACK_TO_HOME', o.battle.isBattleChapterPage },
        { 'EXERCISE_EXERCISE_PAGE_BACK_TO_HOME', o.battle.isReadyBattlePage, },
        { 'EXERCISE_EXERCISE_PAGE_BACK_TO_HOME', o.exercise.isExercisePage },
        { 'EXERCISE_EXERCISE_PAGE_BACK_TO_HOME', o.exercise.isEnemyInfoPage },
      }))
      return makeAction(newstateTypes)

    elseif action.type == 'EXERCISE_EXERCISE_PAGE_ENEMY_INFO_PAGE' then

      stepLabel.setStepLabelContent('5.16.准备战斗')
      o.exercise.clickcStartExerciseBtn()
      local newstateTypes = c.yield(setScreenListeners(exerciseListenerList, {
        { 'EXERCISE_READY_PAGE_CLICK_BATTLE', o.battle.isReadyBattlePage, 2000 },
      }))
      return makeAction(newstateTypes)

    elseif action.type == 'EXERCISE_READY_PAGE_CLICK_BATTLE' then

      stepLabel.setStepLabelContent('5.16.准备战斗')
      c.yield(sleepPromise(1000))
      o.battle.readyBattlePageClickBattle()
      local newstateTypes = c.yield(setScreenListeners(exerciseListenerList, {
        { 'EXERCISE_READY_PAGE_CLICK_BATTLE', o.battle.isReadyBattlePage, 2000 },
        { 'EXERCISE_IN_BATTLE_PAGE', o.exercise.isInBattlePage },
      }))
      return makeAction(newstateTypes)

    elseif action.type == 'EXERCISE_IN_BATTLE_PAGE' then

      stepLabel.setStepLabelContent('5.16.战斗中，检测血量')
      local remainHp = o.exercise.checkMyHPRemain()
      stepLabel.setStepLabelContent('5.16.剩余血量' .. string.format("%0.2f", remainHp * 100))
      if remainHp < settings.exerciseLowerHPRestart then
        stepLabel.setStepLabelContent('5.16.当前血量为' .. string.format("%0.2f", remainHp * 100) .. ',小于' .. (settings.exerciseLowerHPRestart * 100) .. ',退出')
        local newstateTypes = c.yield(setScreenListeners(exerciseListenerList, {
          { 'EXERCISE_READY_PAGE_CLICK_BATTLE', o.battle.isReadyBattlePage, 2000 },
          { 'EXERCISE_IN_BATTLE_CLICK_PAUSE_BTN', o.exercise.isInBattlePage },
        }))
        return makeAction(newstateTypes)
      end
      local newstateTypes = c.yield(setScreenListeners(exerciseListenerList, {
        { 'EXERCISE_READY_PAGE_CLICK_BATTLE', o.battle.isReadyBattlePage, 2000 },
        { 'EXERCISE_IN_BATTLE_PAGE', o.exercise.isInBattlePage, 500 },
      }))
      return makeAction(newstateTypes)

    elseif action.type == 'EXERCISE_IN_BATTLE_CLICK_PAUSE_BTN' then

      stepLabel.setStepLabelContent('5.16.点击暂停')
      o.exercise.clickcPauseBtn()
      local newstateTypes = c.yield(setScreenListeners(exerciseListenerList, {
        { 'EXERCISE_IN_BATTLE_CLICK_PAUSE_BTN', o.exercise.isInBattlePage, 1000 },
        { 'EXERCISE_PAUSE_PANEL_FOR_EXIT', o.exercise.isPausePanel },
      }))
      return makeAction(newstateTypes)

    elseif action.type == 'EXERCISE_PAUSE_PANEL_FOR_EXIT' then

      stepLabel.setStepLabelContent('5.16.暂停战斗，点击退出')
      o.exercise.clickcPausePanelExitBtn()
      local newstateTypes = c.yield(setScreenListeners(exerciseListenerList, {
        { 'EXERCISE_READY_PAGE_CLICK_BATTLE', o.battle.isReadyBattlePage, 2000 },
        { 'EXERCISE_IN_BATTLE_CLICK_PAUSE_BTN', o.exercise.isInBattlePage, 1000 },
        { 'EXERCISE_EXIT_BATTLE_INFO_PANEL_FOR_EXIT', o.exercise.isExitBattleInfoPanel },
        { 'EXERCISE_BATTLE_CHAPTER_CLICK_EXERCISE', o.battle.isBattleChapterPage, 1000 },
        { 'EXERCISE_EXERCISE_PAGE_START_EXERCISE', o.exercise.isExercisePage, 2000 },
        { 'EXERCISE_EXERCISE_PAGE_ENEMY_INFO_PAGE', o.exercise.isEnemyInfoPage, 2000 },
        { 'EXERCISE_READY_PAGE_CLICK_BATTLE', o.battle.isReadyBattlePage },
      }))
      return makeAction(newstateTypes)

    elseif action.type == 'EXERCISE_EXIT_BATTLE_INFO_PANEL_FOR_EXIT' then

      stepLabel.setStepLabelContent('5.16.暂停战斗，点击退出')
      o.exercise.clickcExitBattleInfoPanelExitBtn()
      local newstateTypes = c.yield(setScreenListeners(exerciseListenerList, {
        { 'EXERCISE_READY_PAGE_CLICK_BATTLE', o.battle.isReadyBattlePage, 2000 },
        { 'EXERCISE_IN_BATTLE_CLICK_PAUSE_BTN', o.exercise.isInBattlePage, 1000 },
        { 'EXERCISE_EXIT_BATTLE_INFO_PANEL_FOR_EXIT', o.exercise.isExitBattleInfoPanel, 1000 },
        { 'EXERCISE_BATTLE_CHAPTER_CLICK_EXERCISE', o.battle.isBattleChapterPage, 1000 },
        { 'EXERCISE_EXERCISE_PAGE_START_EXERCISE', o.exercise.isExercisePage, 2000 },
        { 'EXERCISE_EXERCISE_PAGE_ENEMY_INFO_PAGE', o.exercise.isEnemyInfoPage, 2000 },
        { 'EXERCISE_READY_PAGE_CLICK_BATTLE', o.battle.isReadyBattlePage },
      }))
      return makeAction(newstateTypes)

    elseif action.type == 'EXERCISE_VICTORY_PAGE' then

      stepLabel.setStepLabelContent('5.21.胜利面板点击继续')
      o.battle.victoryPanelClickNext()
      local newstateTypes = c.yield(setScreenListeners(exerciseListenerList, {
        { 'EXERCISE_VICTORY_PAGE', o.battle.isGetPropsPanel, 2000 },
        { 'EXERCISE_GET_EXP_PANEL', o.battle.isGetExpPanel, 2000 },
        { 'EXERCISE_GET_PROPS_PANEL', o.battle.isGetPropsPanel },
      }))
      return makeAction(newstateTypes)

    elseif action.type == 'EXERCISE_GET_PROPS_PANEL' then

      stepLabel.setStepLabelContent('5.22.获得道具面板点击继续')
      o.battle.getPropsPanelClickNext()
      local newstateTypes = c.yield(setScreenListeners(exerciseListenerList, {
        { 'EXERCISE_GET_PROPS_PANEL', o.battle.isGetPropsPanel, 2000 },
        { 'EXERCISE_GET_EXP_PANEL', o.battle.isGetExpPanel, 2000 },
        { 'EXERCISE_GET_NEW_SHIP_PANEL', o.battle.isGetNewShipPanel },
      }))
      return makeAction(newstateTypes)

    elseif action.type == 'EXERCISE_GET_NEW_SHIP_PANEL' then

      stepLabel.setStepLabelContent('5.23.获得新船面板点击继续')
      o.battle.getNewShipPanelClickNext()
      local newstateTypes = c.yield(setScreenListeners(exerciseListenerList, {
        { 'EXERCISE_GET_NEW_SHIP_PANEL', o.battle.isGetNewShipPanel, 2000 },
        { 'EXERCISE_GET_EXP_PANEL', o.battle.isGetExpPanel, 1000 },
        { 'EXERCISE_LOCK_NEW_SHIP_PANEL', o.battle.isLockNewShipPanel, 1000 },
      }))
      return makeAction(newstateTypes)

    elseif action.type == 'EXERCISE_LOCK_NEW_SHIP_PANEL' then

      stepLabel.setStepLabelContent('5.23.锁定新船面板点击继续')
      o.battle.lockNewShipPanelClickNext()
      local newstateTypes = c.yield(setScreenListeners(exerciseListenerList, {
        { 'EXERCISE_GET_NEW_SHIP_PANEL', o.battle.isGetNewShipPanel, 2000 },
        { 'EXERCISE_GET_EXP_PANEL', o.battle.isGetExpPanel, 2000 },
        { 'EXERCISE_LOCK_NEW_SHIP_PANEL', o.battle.isLockNewShipPanel, 2000 },
      }))
      return makeAction(newstateTypes)

    elseif action.type == 'EXERCISE_GET_EXP_PANEL' then

      stepLabel.setStepLabelContent('5.24.获得经验面板点击继续')
      o.battle.getExpPanelClickNext()
      local newstateTypes = c.yield(setScreenListeners(exerciseListenerList, {
        { 'EXERCISE_GET_EXP_PANEL', o.battle.isGetExpPanel, 2000 },
        { '', o.home.isHome, 2000 },
      }))
      return makeAction(newstateTypes)

    elseif action.type == 'EXERCISE_EXERCISE_PAGE_BACK_TO_HOME' then

      o.exercise.clickBackBtn()
      local newstateTypes = c.yield(setScreenListeners(exerciseListenerList, {
        { 'EXERCISE_EXERCISE_PAGE_BACK_TO_HOME', o.battle.isBattleChapterPage, 2000 },
        { 'EXERCISE_EXERCISE_PAGE_BACK_TO_HOME', o.exercise.isExercisePage, 2000 },
        { 'EXERCISE_EXERCISE_PAGE_BACK_TO_HOME', o.battle.isReadyBattlePage, 2000 },
        { 'EXERCISE_EXERCISE_PAGE_BACK_TO_HOME', o.exercise.isEnemyInfoPage, 2000 },
        { '', o.home.isHome, 2000 },
      }))
      return makeAction(newstateTypes)
    end
  end))
end

return exercise
