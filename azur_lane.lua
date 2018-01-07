-- 载入 lua-require
require('lua-require')()
----------------------------------
-- 退出时的 flag
luaExisted = false
function beforeUserExit()
  luaExisted = true
end

-- 解锁手机屏幕
if (deviceIsLock() ~= 0) then
  unlockDevice()
end

-- 开启日志
initLog('azur_lane', 1)
require './lib/console.lua'
require 'TSLib'
require './lib/string-polyfill.lua'
require 'StringLib'
require 'MathLib'
require 'console'
require 'KeepScreenHock'
require 'MultiColorHock'
require 'DeviceOrientHock'
local eq = require 'EventQuery'
local co = require 'Co'
local Promise = require 'Promise'
local optionsLabel = require 'optionsLabel'
local socket = require 'socket'
local mapMaker = require 'BaseOperate'
local gomission = require 'GoMission'
local stepLabel = (require 'StepLabel').init('stopbtn')


Promise.setStackTraceback(false)


Promise.setStackTraceback(false)


local width, height = getScreenSize()

local c = coroutine


local sleepPromise = function(ms)
  return Promise.new(function(resolve)
    eq.setTimeout(resolve, ms)
  end)
end

stepLabel.setStepLabelContent('开始')

function closeStepLabel()
  fwCloseView('steplabel', 'text1')
end

stepLabel.setStepLabelContent('等待音量面板收起')
mSleep(500)

closeStepLabel()
local ret, settings = optionsLabel()


-- --转换settings结果

-- 注册按钮事件，目前只有暂停按钮
eq.setButotnListener('stopbtn', function()
  if (isPause) then
    --    stepLabel.setPrefix('')
    --    isPause = false
  else
    stepLabel.setPrefix('即将暂停 ')
    isPause = true
  end
end)

gomission.init(mapMaker(), settings)

local theMissionsQuery = {}

co(c.create(function()
  if (settings.battleEnable) then

    -- 插入一个特殊的任务表示这是队列的开头
    table.insert(theMissionsQuery, { isBase = true, isStart = true })
    --    table.insert(theMissionsQuery, { isBase = true, type = 'MAPS_MAP1_1_START' })
    -- 是否运行出征
    if (settings.battleEnable) then
      table.insert(theMissionsQuery, { isBase = true, type = 'BATTLE_START' })
    end
    -- 插入一个特殊任务表示这是队列的结尾
    table.insert(theMissionsQuery, { isBase = true, isEnd = true })
    runCount = 1
    local runStartTime = socket.gettime() * 1000
    -- 任务队列里没有任务则停止运行
    while (#theMissionsQuery > 0) do
      local action = theMissionsQuery[1]

      if (action.isStart) then
        runStartTime = socket.gettime() * 1000
      end

      -- 如果是队列原有任务则将其加入队列末尾，以保证能一直循环
      -- 如果是从原有任务衍生的下一步任务，则不加入队列末尾，会被新的下一步任务替换或者删除
      if (action.isBase) then
        table.insert(theMissionsQuery, action)
      end

      -- 执行一个action
      if (action.type) then
        local newAction = c.yield(gomission.next(action))
        if (type(newAction) == 'table') then
          if (newAction.addToStart) then
            table.insert(theMissionsQuery, 1, newAction)
          else
            theMissionsQuery[1] = newAction
          end
        else
          table.remove(theMissionsQuery, 1)
        end
      else
        table.remove(theMissionsQuery, 1)
      end

      -- 如果点了暂停按钮
      if (isPause) then
        stepLabel.setPrefix('')
        local lasttext = stepLabel.getText()
        stepLabel.setStepLabelContent('暂停')
        c.yield(Promise.new(function(resolve)
          local theEid
          theEid = eq.setButotnListener('stopbtn', function()
            isPause = false
            stepLabel.setPrefix('')
            eq.clearButotnListener(theEid)
            resolve()
          end)
        end))
        stepLabel.setStepLabelContent(lasttext)
      end

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

        if (luaExisted) then
          break
        end

        runCount = runCount + 1
      end

      -- 如果是任务队列结尾标志，则count+1
    end
  end
end)).catch(function(err)
  wLog('azur_lane', '[DATE] ' .. err);
  eq.setImmediate(function() error(err) end)
end)

eq.run()
