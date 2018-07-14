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

store.dalyChallenges = store.dalyChallenges or {
  intervalTime = os.time()
}

local o = {
  home = moHome,
  battle = moBattle,
  dailyChallenges = moDailyChallenges,
}
local battle = function(action)
  local settings = store.settings;
  return co(c.create(function()
    if action.type == 'DAILY_CHALLENGES_INIT' then

      stepLabel.setStepLabelContent('4.1.等待桌面')
      local newstateTypes = c.yield(setScreenListeners({
        { 'DAILY_CHALLENGES_START', o.home.isHome, 2000 },
      }))
      return makeAction(newstateTypes)

    elseif action.type == 'DAILY_CHALLENGES_START' then

      stepLabel.setStepLabelContent('4.2.点击进入战斗页面')
      o.dailyChallenges.clickIntoBattlePage()

      local newstateTypes = c.yield(setScreenListeners({
        { 'DAILY_CHALLENGES_START', o.home.isHome, 2000 },
        { 'DAILY_CHALLENGES_DAILY_CHALLENGES_PAGE', o.dailyChallenges.clickIntoDailyChallengesPage, 2000 },
      }))
      return makeAction(newstateTypes)

    elseif action.type == 'DAILY_CHALLENGES_DAILY_CHALLENGES_PAGE' then
    end
    return nil
  end))
end