local co = require '../lib/co'
local c = coroutine
local sleepPromise = require '../utils/sleep-promise'

local toPoint = function(tab)
  -- 由于这里的tab可能很长，所以使用一些特殊方法防止内存耗尽
  local newTab = {}
  local tabLength = #tab
  for key = 1, tabLength do
    newTab[key] = { tab[key].x, tab[key].y }
    tab[key] = nil
  end
  return newTab
end

local exercise = {}

-- 点击演习按钮
exercise.clickExerciseBtn = function()
  RTap({ 1797, 1013 }, 100)
end

-- 是否演习界面
exercise.isExercisePage = function()
  local __keepScreenState = keepScreenState
  if not __keepScreenState then keepScreen(true) end
  local list = {
    { 15, 15, 0xe6ebef }, { 11, 59, 0xcecece }, { 865, 12, 0xeff3f7 }, { 830, 52, 0xdedfde },
    { 359, 5, 0xeff3f7 }, { 315, 14, 0x424542 }, { 142, 13, 0x292829 }, { 302, 42, 0x000000 },
    { 163, 21, 0x292d29 }, { 235, 37, 0x3a393a }, { 41, 620, 0x080c08 }, { 878, 1011, 0x000419 },
    { 1187, 660, 0x002063 }, { 1605, 534, 0x00aad6 }, { 1831, 548, 0x00aad6 }, { 1651, 112, 0x000410 },
    { 1720, 227, 0x000410 }, { 1707, 302, 0x081029 },

    { 209, 23, 0x080808 }, { 264, 26, 0x293131 }, { 272, 39, 0x313531 }, { 280, 32, 0xffd763 },
    { 282, 18, 0xffffde }, { 249, 32, 0xf7ce6b }, { 232, 49, 0x313531 }, { 240, 55, 0xffdb73 },
    { 238, 59, 0x080808 }, { 203, 65, 0x313531 },
  }
  local result = multiColorS(list)
  if not __keepScreenState then keepScreen(false) end
  return result
end

-- 是否演习次数为0
exercise.isExercisePageExerciseNumZero = function()
  local __keepScreenState = keepScreenState
  if not __keepScreenState then keepScreen(true) end
  local list = {
    { 1691, 414, 0x001029 }, { 1692, 438, 0x001029 },
    { 1692, 443, 0xa4f342 }, { 1700, 438, 0xadf74a },
    { 1695, 423, 0xadf74a }, { 1699, 413, 0xadf74a },
    { 1683, 418, 0xa4f34a }, { 1687, 432, 0x9cf34a },
    { 1684, 440, 0xadf74a }, { 1690, 439, 0xa4ef42 },
  }
  local result = multiColorS(list)
  if not __keepScreenState then keepScreen(false) end
  return result
end

-- 选择敌人舰队
exercise.clickEnemyFleet = function(n)
  n = n or 1
  if n == 1 then
    RTap({ 243, 379 }, 100)
  elseif n == 2 then
    RTap({ 610, 394 }, 100)
  elseif n == 3 then
    RTap({ 989, 405 }, 100)
  elseif n == 4 then
    RTap({ 1363, 400 }, 100)
  end
end

-- 是否敌人信息页面
exercise.isEnemyInfoPage = function()
  local __keepScreenState = keepScreenState
  if not __keepScreenState then keepScreen(true) end
  local list = {
    { 784, 242, 0xfff7d6 }, { 795, 259, 0xffca42 }, { 809, 266, 0xffbe19 }, { 818, 274, 0xffbe00 },
    { 857, 257, 0xf7d25a }, { 912, 258, 0xffd252 }, { 947, 260, 0xffc642 }, { 997, 256, 0xffce5a },
    { 1061, 241, 0xfff7de }, { 1132, 261, 0xffc231 }, { 1432, 928, 0xffdb52 }, { 1476, 948, 0xffffff },
    { 1517, 976, 0xffae19 }, { 1555, 960, 0xffffff }, { 1646, 966, 0xffc642 }, { 1662, 958, 0xffffff },
  }
  local result = multiColorS(list)
  if not __keepScreenState then keepScreen(false) end
  return result
end

-- 点击开始演习按钮
exercise.clickcStartExerciseBtn = function()
  RTap({ 1566, 958 }, 100)
end

-- 是否敌战斗中
exercise.isInBattlePage = function()
  local __keepScreenState = keepScreenState
  if not __keepScreenState then keepScreen(true) end
  local list = {
    { 619, 31, 0x313131 }, { 698, 30, 0x313531 },
    { 812, 35, 0x4a718c }, { 1028, 35, 0x42718c },
    { 1117, 33, 0x313131 }, { 1259, 33, 0x313131 },
    { 1303, 25, 0x52555a }, { 1816, 36, 0xe6e7e6 },
  }
  local result = multiColorS(list)
  if not __keepScreenState then keepScreen(false) end
  return result
end

-- 检查我方生命剩余多少
exercise.checkMyHPRemain = function()
  local __keepScreenState = keepScreenState
  if not __keepScreenState then keepScreen(true) end
  local leftPoint = { 71, 65, 0x4a4d4a }
  local rightPoint = { 782, 62, 0x5a3d42 }
  local pointList = toPoint(findMultiColorInRegionFuzzyExt('0xf74942', '', 90, 70, 42, 791, 65))
  local percentPoint = math.minTable(pointList, function(item) return item[2] end)
  console.log(pointList)
  local result = math.abs(rightPoint[1] - percentPoint[1]) / math.abs(rightPoint[1] - leftPoint[1])
  if not __keepScreenState then keepScreen(false) end
  return result
end

-- 点击返回按钮
exercise.clickBackBtn = function()
  RTap({ 59, 35 }, 100)
end

return exercise
