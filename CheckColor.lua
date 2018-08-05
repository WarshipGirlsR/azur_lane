useNlog = true
init(2)
require 'console'
require 'javascript-polyfill'
mSleep(6000)

keepScreen(false)
keepScreen(true)
local sideLength = 1080
local list = {
  { 93, 9, 0xefaa00 }, { 102, 36, 0xe6ae08 }, { 89, 84, 0xefa600 }, { 23, 105, 0xefaa00 },
  { 1188, 173, 0xffffff }, { 1313, 162, 0xffffff }, { 1426, 192, 0xffffff }, { 1657, 176, 0xfffbf7 },
  { 1768, 177, 0xe6ebe6 }, { 1775, 197, 0xe6ebe6 }, { 1190, 560, 0x10a2ef }, { 1220, 592, 0x2196d6 },
  { 1268, 575, 0xffffff }, { 1361, 585, 0x198ace }, { 1411, 596, 0x10a2ef }, { 1488, 586, 0xe6aa10 },
  { 1611, 602, 0xe69e08 }, { 1589, 578, 0xffffff }, { 1706, 571, 0xffffff }, { 1785, 582, 0xdeb210 },
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