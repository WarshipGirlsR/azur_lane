useNlog = true
init(2)
require 'console'
require 'table-polyfill'
mSleep(6000)

keepScreen(false)
keepScreen(true)
local sideLength = 1080

local list = {
  { 8, 10, 0xe6e7ef }, { 201, 21, 0xffefc5 },
  { 307, 12, 0x424542 }, { 1024, 38, 0x313131 },
  { 1333, 40, 0xffef63 }, { 1645, 37, 0xff4573 },
  { 182, 20, 0xfff3c5 }, { 178, 35, 0xffc642 },
  { 210, 28, 0x3a393a }, { 219, 32, 0xffd25a },
  { 255, 30, 0xffdb73 }, { 244, 42, 0x3a393a },
  { 267, 42, 0x3a393a }, { 273, 51, 0xf7c652 },
  { 259, 17, 0xfff7de }, { 266, 25, 0x101010 },
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