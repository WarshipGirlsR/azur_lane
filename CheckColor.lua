init(1)
require 'console'
mSleep(6000)

keepScreen(false)
keepScreen(true)
local sideLength = 1080

local list = {
  { 49, 103, 0x3a4552 }, { 1395, 198, 0xf7f3f7 },
  { 1369, 523, 0xe6e7e6 }, { 1389, 901, 0xd6f3f7 },
  { 1781, 998, 0x8ccece }, { 1613, 935, 0xffefbd },
  { 1272, 361, 0x212429 }, { 135, 844, 0xefefef },
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