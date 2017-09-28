useNlog = true
init(1)
require 'console'
require 'TableLib'
mSleep(6000)

keepScreen(false)
keepScreen(true)
local sideLength = 1080

local list = {
  { 559, 447, 0xe6a273 }, { 674, 451, 0xe6ae84 },
  { 848, 469, 0xe6965a }, { 1092, 448, 0x6b2819 },
  { 1179, 451, 0xefcaad }, { 1356, 467, 0x521c08 },
  { 1430, 492, 0xe69e6b }, { 1423, 541, 0xe69e6b },
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