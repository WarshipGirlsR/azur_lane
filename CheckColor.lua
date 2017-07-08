init(1)
require 'console'
mSleep(6000)

keepScreen(false)
keepScreen(true)
local sideLength = 1080

local list = {
  { 342, 163, 0x212421 }, { 773, 161, 0xeff3f7 },
  { 1580, 159, 0x9ca69c }, { 1274, 815, 0xf7db4a },
  { 1522, 879, 0xffae19 }, { 1312, 834, 0xd6caad },
  { 1325, 841, 0xffca42 }, { 1366, 844, 0xffffff },
  { 1412, 842, 0x846921 }, { 1431, 843, 0xffffff },
  { 1469, 840, 0xffca3a }, { 1488, 839, 0xf7c63a },
  { 1488, 856, 0xffb221 }, { 1458, 859, 0xffffff },
  { 1449, 856, 0xffae19 }, { 1413, 857, 0xfff7f7 },
  { 352, 180, 0xffd76b }, { 392, 181, 0x191810 },
  { 405, 188, 0x101010 }, { 426, 177, 0xf7db7b },
  { 418, 194, 0x080808 }, { 451, 194, 0xffba10 },
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