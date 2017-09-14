require 'TSLib'
nLog(TSVersions())

local _tmp = (function()
  local __keepScreen = keepScreen
  keepScreen = nil
  keepScreenState = false
  keepScreen = function(...)
    local arr = { ... }
    keepScreenState = arr[1] or false
    return __keepScreen(...)
  end
end)()


keepScreen(true)

local list = { ... } -- 很多列表

for key = 1, #list do
  local value = list[key]
  multiColor(value)
  -- 此时 keepScreen 的状态是 false
end

-- 这个循环执行速度会很慢
