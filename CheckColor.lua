useNlog = true
init(2)
require 'console'
require 'table-polyfill'
mSleep(6000)

keepScreen(false)
keepScreen(true)
local sideLength = 1080
local readChapter = ocrText(11, 137, 144, 171, 0)
console.log(readChapter)
--local list = {
--  { 97, 526, 0xe6e7e6 },
--  { 86, 539, 0xd6d7d6 },
--  { 109, 577, 0xdedbde },
--}
--
--local resultStr = ''
--
--for key, value in ipairs(list) do
--  local color = getColor(value[1], value[2])
--  local oldColor = value[3]
--  local colorStr = string.format('0x%06x', color)
--  local oldColorStr = string.format('0x%06x', oldColor)
--  value[3] = oldColorStr
--  if (color == oldColor) then
--    resultStr = resultStr .. '\n' .. console.getJsStr(value)
--  else
--    value[3] = colorStr
--    resultStr = resultStr .. '\n' .. console.getJsStr(value) .. '  old Color: ' .. oldColorStr
--  end
--end

console.log(resultStr)
mSleep(6000)
keepScreen(false)