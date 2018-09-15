useNlog = true
init(2)
require 'console'
require 'javascript-polyfill'
mSleep(6000)

keepScreen(false)
keepScreen(true)
local sideLength = 1080
local list = {
  { 157, 125, 0x292429 }, { 433, 123, 0x525552 }, { 744, 119, 0xeff3f7 }, { 1480, 121, 0xeff3f7 },
  { 1767, 120, 0x9caa9c }, { 1701, 955, 0xf7a210 }, { 1468, 954, 0xffaa19 }, { 1472, 888, 0xe6c252 },
  { 1620, 905, 0xf7db4a }, { 1608, 927, 0xffffff }, { 1534, 285, 0xffdb52 }, { 1577, 309, 0x7b3510 },
  { 1604, 328, 0xffa229 }, { 1654, 285, 0xdee3e6 }, { 1690, 306, 0xdedfe6 }, { 1724, 320, 0x848684 },
  { 1553, 485, 0xffdb5a }, { 1587, 505, 0x733110 }, { 1686, 491, 0xdedfde }, { 1684, 513, 0x313542 },
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