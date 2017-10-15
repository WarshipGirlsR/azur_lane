useNlog = true
init(1)
require 'console'
require 'TableLib'
mSleep(6000)

keepScreen(false)
keepScreen(true)
local sideLength = 1080

local list = {
  { 611, 440, 0xf7d74a }, { 666, 500, 0xfff35a },
  { 855, 479, 0xffff5a }, { 1110, 432, 0xffce52 },
  { 1218, 529, 0xefa63a }, { 1395, 482, 0xfffb5a },
  { 568, 468, 0x632419 }, { 902, 441, 0x5a2010 },
  { 987, 448, 0x632010 }, { 1234, 442, 0x6b2819 },
  { 537, 429, 0xfff394 }, { 1253, 565, 0x6b2410 },
  { 1295, 426, 0x632010 }, { 1080, 495, 0x632819 },

  { 294, 702, 0x424142 }, { 523, 697, 0x424142 },
  { 967, 698, 0x423d42 }, { 1424, 697, 0x3a3d3a },
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