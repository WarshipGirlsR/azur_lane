useNlog = true
init(2)
require 'console'
require 'table-polyfill'
mSleep(6000)

keepScreen(false)
keepScreen(true)
local sideLength = 1080
local list = {
  { 476, 271, 0xe6efe6 }, { 833, 280, 0xefefef },
  { 1404, 282, 0xeff3f7 }, { 1561, 283, 0xadaaad },
  { 1522, 755, 0xffae10 }, { 1273, 691, 0xffdb52 },
  { 1271, 747, 0xffa619 }, { 1391, 713, 0xffffff },
  { 854, 339, 0x4a4d4a },
  { 896, 342, 0xdedfde }, { 1376, 349, 0xdedbde },
  { 1319, 708, 0xffffff }, { 1322, 720, 0xffca3a },
  { 1342, 729, 0xf7b219 }, { 1355, 718, 0xffffff },
  { 1383, 717, 0xffffff }, { 1397, 713, 0xbd9629 },
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