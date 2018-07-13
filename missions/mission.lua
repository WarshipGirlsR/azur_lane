local co = require '../lib/co'
local c = coroutine
local stepLabel = require '../utils/step-label'
local makeAction = (require './utils').makeAction
local sleepPromise = require '../utils/sleep-promise'
local moMission = require '../meta-operation/mission'
local moHome = require '../meta-operation/home'
local moMap = require '../meta-operation/maps-options/index'
local setScreenListeners = (require './utils').setScreenListeners
local store = require '../store'
local vibratorPromise = require '../utils/vibrator-promise'

store.battle = store.battle or {}

local o = {
  home = moHome,
  mission = moMission,
  map = moMap,
}

local mission = function(action)
  local settings = store.settings;
  local mapProxy = o.map['map' .. settings.battleChapter]

  return co(c.create(function()

    if action.type == 'MISSION_INIT' then
      return makeAction('MISSION_START')
    elseif action.type == 'MISSION_START' then
    end

    return nil
  end))
end

return mission
