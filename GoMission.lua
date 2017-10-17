local co = require 'Co'
local pauseFactory = require 'GoMission__pause'
local homeFactory = require 'GoMission__home'
local battleFactory = require 'GoMission__battle'
local mapFactory = require 'GoMission__maps__map'

-- 运行时的变量，全局共享
local stateTree = require 'GoMission__stateTree'
-- 保存整个GoMission共享的参数
local allOptions = require 'GoMission__options'

local c = coroutine






-- 将分散在各个文件的任务集合到一起
local missions = {
  home = homeFactory(stateTree),
  battle = battleFactory(stateTree),
  map = mapFactory(stateTree),
}

return {
  init = function(map, settings)
    -- 定义需要全局监听状态
    allOptions.map = map
    allOptions.settings = settings

    return missions
  end,
  next = function(action, state)
    state = table.assign(stateTree, state)
    return co(c.create(function()
      if action.type and action.type ~= '' then
        for key, item in pairs(missions) do
          local newAction, newState = c.yield(item(action, state))
          if (newAction) then
            return newAction, newState
          end
        end
        error('Action "' .. action.type .. '" not found')
      end
    end))
  end
}