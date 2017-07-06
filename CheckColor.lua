init(1)
require 'console'
mSleep(6000)

keepScreen(false)
keepScreen(true)
local sideLength = 1080

local list = {
  { 339, 170, 0x292829 }, { 399, 169, 0xffefce },
  { 437, 175, 0x313131 }, { 479, 173, 0x101010 },
  { 508, 183, 0xf7ce5a }, { 547, 173, 0xefd29c },
  { 565, 195, 0xffba08 }, { 588, 197, 0x424542 },
  { 661, 200, 0x000000 }, { 1086, 198, 0xdedfe6 },
  { 345, 243, 0x42414a }, { 1570, 237, 0x3a414a },
  { 344, 909, 0x31353a }, { 1571, 911, 0x4a494a },
  { 1274, 816, 0xffdb52 }, { 1409, 837, 0xfffbf7 },
  { 1523, 873, 0xffa610 },
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