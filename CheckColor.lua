useNlog = true
init(2)
require 'console'
require 'table-polyfill'
mSleep(6000)

keepScreen(false)
keepScreen(true)
local sideLength = 1080
local list = {
  { 451, 175, 0x08ebbd }, { 451, 188, 0x08e7b5 },
  { 452, 202, 0x08ebbd }, { 452, 216, 0x08ebbd },
  { 452, 231, 0x00e7b5 }, { 452, 244, 0x08ebbd },
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