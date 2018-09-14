useNlog = true
init(2)
require 'console'
require 'javascript-polyfill'
mSleep(6000)

keepScreen(false)
keepScreen(true)
local sideLength = 1080
local list = {
  { 155, 123, 0x292429 }, { 833, 127, 0xeff3f7 },
  { 1604, 118, 0xeff3f7 }, { 1671, 120, 0x9caa9c },
  { 1753, 121, 0xadaaad }, { 1699, 132, 0xf7db42 },
  { 1720, 157, 0xf7ce42 }, { 1727, 143, 0xadaaad },
  { 1708, 161, 0xadaaad }, { 1709, 145, 0xffd742 },
  { 170, 150, 0xffc642 }, { 187, 154, 0xa47d10 },
  { 212, 154, 0xe6b631 }, { 215, 154, 0x080c08 },
  { 278, 144, 0x3a413a }, { 257, 168, 0x292d29 },
  { 251, 163, 0xffba00 }, { 318, 148, 0xc5a63a },
  { 295, 139, 0x292429 }, { 329, 179, 0x3a3d3a },

  { 1533, 299, 0x6b2400 }, { 1544, 300, 0x633910 },
  { 1551, 300, 0x633510 }, { 1564, 302, 0xffd24a },
  { 1533, 316, 0x6b2d08 }, { 1547, 321, 0xffca42 },
  { 1559, 314, 0xffc642 }, { 1580, 304, 0xffb242 },
  { 1570, 307, 0xffc242 }, { 1592, 308, 0x6b3d21 },
  { 1600, 307, 0xffaa29 }, { 1584, 293, 0xffc64a },
  { 1598, 299, 0x633110 }, { 1590, 307, 0x733110 },
  { 1591, 323, 0x632d10 }, { 1580, 321, 0xf7a229 },
  { 1598, 321, 0xde8e29 }, { 1580, 331, 0xf7a229 },
  { 1570, 324, 0xffaa3a }, { 1591, 316, 0x6b2800 },}

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