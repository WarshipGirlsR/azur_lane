useNlog = true
init(2)
require 'console'
require 'table-polyfill'
mSleep(6000)

keepScreen(false)
keepScreen(true)
local sideLength = 1080
local list = {
  { 1691, 414, 0x001029 },
  { 1692, 438, 0x001029 },
  { 1692, 443, 0xa4f342 },
  { 1700, 438, 0xadf74a },
  { 1695, 423, 0xadf74a },
  { 1699, 413, 0xadf74a },
  { 1683, 418, 0xa4f34a },
  { 1687, 432, 0x9cf34a },
  { 1684, 440, 0xadf74a },
  { 1690, 439, 0xa4ef42 },
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