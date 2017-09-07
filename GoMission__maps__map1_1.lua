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


local map1_1 = function(action, state)
  local map = allOptions.map
  local settings = allOptions.settings

  return co(c.create(function()
    if action.type == 'MAPS_MAP1_1_START' then
      state.map1_1.checkpositionList = {}

      local newstateTypes = c.yield(setScreenListeners({
        { 'MAPS_MAP1_1_MOVE_TO_CHECKPOSITION', 'missionsGroup', map.battle.isMapPage },
      }))
      return makeAction(newstateTypes), state

    elseif action.type == 'MAPS_MAP1_1_MOVE_TO_CHECKPOSITION' then

    elseif action.type == 'MAPS_MAP1_1_SCAN_MAP' then
    end

    return nil, state
  end))
end

return function(state)
  state.map1_1 = {}
  return battleOnce
end