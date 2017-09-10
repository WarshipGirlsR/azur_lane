init(1)
require 'console'
require 'TableLib'
mSleep(6000)

keepScreen(false)
keepScreen(true)
local sideLength = 1080

local list = {
  { 439, 165, 0x525552 }, { 1556, 174, 0xeff3f7 },
  { 1721, 188, 0xadaaad }, { 1720, 901, 0x3a3531 },
  { 185, 908, 0x312d31 }, { 167, 161, 0x292429 },

  { 1415, 826, 0xf7df4a }, { 1489, 855, 0xffca3a },
  { 1515, 853, 0xc5be9c }, { 1549, 855, 0xffffff },
  { 1604, 860, 0x9c814a }, { 1646, 864, 0xffb221 },
  { 1654, 838, 0xffd74a }, { 1574, 847, 0x947d42 },

  { 199, 178, 0xffdb7b }, { 226, 179, 0xf7db84 },
  { 260, 182, 0x292010 }, { 295, 185, 0x293529 },
  { 340, 190, 0xffc219 }, { 396, 193, 0xffbe10 },
  { 420, 184, 0x525152 },
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