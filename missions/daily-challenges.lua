local co = require '../lib/co'
local c = coroutine
local stepLabel = require '../utils/step-label'
local makeAction = (require './utils').makeAction
local sleepPromise = require '../utils/sleep-promise'
local moDailyChallenges = require '../meta-operation/daily-challenges'
local moHome = require '../meta-operation/home'
local setScreenListeners = (require './utils').setScreenListeners
local store = require '../store'
local vibratorPromise = require '../utils/vibrator-promise'

store.battle = store.battle or {}

local o = {
  home = moHome,
  battle = moBattle,
  moDailyChallenges = moDailyChallenges,
}
local battle = function(action)
  local settings = store.settings;
  return co(c.create(function()
    if action.type == 'DAILY_CHALLENGES_INIT' then

      stepLabel.setStepLabelContent('2.1.等待桌面')
      local newstateTypes = c.yield(setScreenListeners(battleListenerList, {
        { 'BATTLE_HOME_CLICK_BATTLE', o.home.isHome, 2000 },
      }))
      return makeAction(newstateTypes)
    elseif action.type == 'DAILY_CHALLENGES_START' then
    end
    return nil
  end))
end