useNlog = true
init(2)
require 'console'
require 'javascript-polyfill'
mSleep(6000)

keepScreen(false)
keepScreen(true)
local sideLength = 1080
local list = {
  { 554, 287, 0x68686b }, { 590, 290, 0x69686e }, { 647, 287, 0x6b686b }, { 691, 287, 0x6b696b },
  { 750, 286, 0x68686e }, { 821, 285, 0x6a696b }, { 892, 288, 0x6b676f }, { 969, 286, 0x6b696b },
  { 1026, 286, 0x67676f }, { 1088, 286, 0x686868 },
}

local resultStr = ''

for key, value in ipairs(list) do
  local color = getColor(value[1], value[2])
  local oldColor = value[3]
  local colorStr = string.format('0x%06x', color)
  local oldColorStr = string.format('0x%06x', oldColor)
  value[3] = oldColorStr
  if (color == oldColor) then
    resultStr = resultStr .. '\n' .. console.getJsStr(value)
  else
    value[3] = colorStr
    resultStr = resultStr .. '\n' .. console.getJsStr(value) .. '  old Color: ' .. oldColorStr
  end
end

console.log(resultStr)
mSleep(6000)
keepScreen(false)