local co = require '../lib/co'
local c = coroutine
local stepLabel = require '../utils/step-label'
local makeAction = (require './utils').makeAction
local sleepPromise = require '../utils/sleep-promise'
local setScreenListeners = (require './utils').setScreenListeners


local test = function(action)
  return co(c.create(function()
    if (action.type == 'TEST_A') then

      console.log('TEST_A')
      return makeAction('TEST_B')

    elseif (action.type == 'TEST_B') then

      console.log('TEST_B')
      return makeAction('')
    end

    console.log('23333')
    return nil
  end))
end

return test