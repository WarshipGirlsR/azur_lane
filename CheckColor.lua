useNlog = true
init(2)
require 'console'
require 'javascript-polyfill'
mSleep(6000)

keepScreen(false)
keepScreen(true)
local sideLength = 1080
local list = {
  { 1015, 33, 0x3a353a }, { 1038, 62, 0x423d42 }, { 1325, 32, 0xfff363 }, { 1350, 53, 0xf7ca5a },
  { 1639, 35, 0xff4573 }, { 1660, 60, 0xef416b }, { 1188, 173, 0xffffff }, { 1203, 584, 0x109eef },
  { 1388, 583, 0x198ece }, { 1479, 589, 0xe6aa10 }, { 46, 949, 0xffffff }, { 190, 984, 0xdedbde },
  { 299, 1004, 0x5a6d8c }, { 557, 1008, 0x3a393a }, { 784, 1007, 0x313131 }, { 1030, 1007, 0x313531 },
  { 1277, 1004, 0x424142 }, { 1523, 1006, 0xbd1010 }, { 1768, 1004, 0x424142 }, { 1776, 603, 0xde9a08 },
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