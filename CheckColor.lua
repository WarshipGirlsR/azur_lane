useNlog = true
init(2)
require 'console'
require 'javascript-polyfill'
mSleep(6000)

keepScreen(false)
keepScreen(true)
local sideLength = 1080
local list = {
  { 13, 11, 0xdedfe6 }, { 10, 54, 0xcecace },
  { 38, 36, 0xefce42 }, { 68, 31, 0xefce3a },
  { 125, 56, 0xc5c2c5 }, { 892, 51, 0xd6dbde },
  { 930, 7, 0xeff3f7 }, { 248, 23, 0xffe7ad },
  { 257, 24, 0x292829 }, { 276, 22, 0x211c21 },
  { 232, 45, 0x313131 }, { 256, 45, 0x313531 },
  { 264, 47, 0xffba00 }, { 273, 47, 0x3a353a },
  { 284, 47, 0xffba00 }, { 293, 45, 0x313131 },
  { 302, 45, 0xffba00 }, { 308, 45, 0x191819 },
  { 321, 43, 0xffbe10 }, { 332, 44, 0x424142 },
  { 426, 42, 0x000000 }, { 438, 42, 0xefefff },
  { 545, 42, 0xdee7f7 }, { 573, 45, 0x000000 },
  { 559, 45, 0xd6d2de }, { 394, 43, 0x3a393a },
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