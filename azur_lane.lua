require 'console'
-- 载入 lua-require
require('lua-require')({
  osExit = function()
    lua_exit()
    mSleep(10)
    mSleep(10)
    mSleep(10)
  end,
})
----------------------------------
-- 退出时的 flag
luaExisted = false
function beforeUserExit()
  luaExisted = true
end

if luaExisted then
  lua_exit()
  mSleep(10)
  mSleep(10)
  mSleep(10)
end

-- 解锁手机屏幕
if (deviceIsLock() ~= 0) then
  unlockDevice()
end

-- 开启日志
initLog('azur_lane', 1)
--require './lib/console'
require 'TSLib'
require './lib/javascript-polyfill'
require './utils/keep-screen-hock'
require './utils/multi-color-hock'
require './utils/device-orient-hock'
require './utils/clear-log'

RTap = require './lib/norma-distribution-tap'
EventQuery = require './lib/event-query'
Promise = require './lib/promise'

local co = require './lib/co'
local optionsLabel = require './options-label'
local socket = require 'socket'
local createChain = require('./lib/mission-chain').createChain
local missionsList = require './missions/index'
local sleepPromise = require './utils/sleep-promise'
local store = require './store'

local stepLabel = require './utils/step-label'
stepLabel.init('stopbtn')

local c = coroutine
console.log('version 20180718-0201')
stepLabel.setStepLabelContent('开始')

function closeStepLabel()
  fwCloseView('steplabel', 'text1')
end

stepLabel.setStepLabelContent('等待音量面板收起')
mSleep(500)

closeStepLabel()
local ret, settings = optionsLabel()
stepLabel.setStepLabelContent('正在载入...')
if (ret ~= 1) then
  stepLabel.setStepLabelContent('取消运行')
  mSleep(100000)
  lua_exit()
end

store.settings = settings


-- 注册按钮事件，目前只有暂停按钮
EventQuery.setButotnListener('stopbtn', function()
  if (isPause) then
    --    stepLabel.setPrefix('')
    --    isPause = false
  else
    stepLabel.setPrefix('即将暂停 ')
    isPause = true
  end
end)



co(c.create(function()
  if (settings.battleEnable or settings.exerciseEnable or settings.missionEnable or settings.dailyChallengesEnable) then

    local theMissionsQuery = {}
    -- 是否运行出征
    if (settings.battleEnable) then
      table.insert(theMissionsQuery, { isBase = true, type = 'BATTLE_INIT' })
    end
    -- 是否运行任务
    if (settings.missionEnable) then
      table.insert(theMissionsQuery, { isBase = true, type = 'MISSION_INIT' })
    end
    -- 是否运行演习
    if (settings.exerciseEnable) then
      table.insert(theMissionsQuery, { isBase = true, type = 'EXERCISE_INIT' })
    end
    -- 是否运行每日挑战
    if (settings.dailyChallengesEnable) then
      table.insert(theMissionsQuery, { isBase = true, type = 'DAILY_CHALLENGES_INIT' })
    end

    local theChain = createChain(missionsList)

    -- 启动任务链
    c.yield(theChain.runMission({
      missionsQuery = theMissionsQuery,
      -- 在每次循环执行过 action 之后调用
      afterAction = function(res)
        local action = res.action
        local nextAction = res.nextAction
        local missionsQuery = res.missionsQuery
        local runStartTime = res.runStartTime

        return co(c.create(function()
          if (action.isEnd) then
            local diffTime = (socket.gettime() * 1000) - runStartTime
            if (diffTime < (settings.missionsInterval * 1000)) then
              local remainTime = (settings.missionsInterval * 1000) - diffTime
              stepLabel.setStepLabelContent('休息剩余时间' .. math.ceil(remainTime / 1000) .. '秒')
              while (remainTime > 0) do
                stepLabel.setStepLabelContent('休息剩余时间' .. math.ceil(remainTime / 1000) .. '秒', true)
                c.yield(sleepPromise(1000))
                remainTime = remainTime - 1000
              end
            end
          end
        end))
      end,
    }))
  end
end)).catch(function(err)
  wLog('azur_lane', '[DATE] ' .. err);
  nLog(err)
  EventQuery.setImmediate(function() error(err) end)
  --  error(err)
end)

EventQuery.run()
