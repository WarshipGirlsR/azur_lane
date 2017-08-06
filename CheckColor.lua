init(1)
require 'console'
mSleep(6000)

keepScreen(false)
keepScreen(true)
local sideLength = 1080

local list = {
  { 538, 403, 0xf7eb94 }, { 555, 445, 0xffdb52 },
  { 679, 450, 0xf7df52 }, { 598, 468, 0x84818c },
  { 592, 553, 0xe67d31 }, { 680, 540, 0xf79e42 },
  { 901, 430, 0xf7c64a }, { 1082, 478, 0xffff5a },
  { 1350, 533, 0xef9e3a }, { 926, 864, 0xd6ced6 },
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