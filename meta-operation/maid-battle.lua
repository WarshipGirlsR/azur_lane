local co = require '../lib/co'
local c = coroutine
local sleepPromise = require '../utils/sleep-promise'
local imgTools = require '../utils/img-tools'


local maidBattle = {}

-- 点击活动
maidBattle.clickEventBtn = function()
  RTap({ 1028, 459 }, 100)
end

-- 点击活动
maidBattle.clickChapterBtn = function(chapter)
  if chapter == 1 then
    RTap({ 331, 559 }, 100)
  elseif chapter == 2 then
    RTap({ 1040, 573 }, 100)
  elseif chapter == 3 then
    RTap({ 1712, 543 }, 100)
  end
end

--  是否在选择关卡页面
maidBattle.isSelectChapterPage = function()
  local __keepScreenState = keepScreenState
  if not __keepScreenState then keepScreen(true) end
  local list = {
    { 13, 14, 0xdee3de }, { 22, 94, 0xffffff }, { 979, 78, 0xefefff }, { 1477, 99, 0xffffff },
    { 1886, 98, 0xf7ebf7 }, { 1834, 128, 0x000000 }, { 60, 318, 0xfff7ef }, { 1516, 225, 0xffffff },
    { 1863, 317, 0xefe7d6 }, { 1855, 456, 0xefe394 }, { 67, 699, 0xefebce }, { 345, 685, 0x8c8ea4 },
    { 696, 717, 0xffffff }, { 1016, 699, 0xd6d2ce }, { 1419, 708, 0xffffff }, { 1774, 662, 0x31355a },
    { 169, 928, 0xfffbff }, { 756, 927, 0xeff3ef }, { 1075, 926, 0xffffff }, { 1254, 1063, 0xffffff },
  }
  local result = multiColorS(list)
  if not __keepScreenState then keepScreen(false) end
  return result
end

return maidBattle