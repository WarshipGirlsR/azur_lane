local co = require '../lib/co'
local c = coroutine
local sleepPromise = require '../utils/sleep-promise'

-- 存储图像信息，用于界面找色、找图。取代图片搜索，因为找色搜索的像素点更少
local function transRelativePoint(tab, base)
  if not base then
    base = tab[1]
    table.remove(tab, 1)
  end
  local newTab = {}
  for key = 1, #tab do
    local value = tab[key]
    newTab[key] = string.format('%d|%d|0x%06X', value[1] - base[1], value[2] - base[2], value[3])
  end
  return base, table.concat(newTab, ',')
end

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
    { 1681, 413, 0x000c29 }, { 1680, 421, 0x080c29 }, { 1680, 428, 0x081031 }, { 1680, 432, 0x081029 },
    { 1683, 441, 0x314931 }, { 1691, 437, 0x000c29 }, { 1691, 431, 0x000c29 }, { 1691, 424, 0x000c21 },
    { 1691, 418, 0x081029 }, { 1692, 414, 0x081429 }, { 1703, 414, 0x000c29 }, { 1703, 420, 0x000821 },
    { 1703, 428, 0x000c21 }, { 1703, 436, 0x000821 }, { 1700, 441, 0x426131 }, { 1685, 415, 0xadf74a },
    { 1685, 421, 0xadf74a }, { 1685, 428, 0xa4f34a }, { 1685, 433, 0xadf74a }, { 1685, 438, 0x9cf34a },
    { 1696, 414, 0xadf74a }, { 1696, 419, 0xa4f342 }, { 1696, 425, 0xa4f342 }, { 1696, 430, 0xadf74a },
    { 1696, 438, 0xadf74a },
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
  local list2 = {
    { 343, 29, 0x52555a }, { 534, 21, 0x525152 },
    { 682, 34, 0x313531 }, { 770, 26, 0x636973 },
    { 1067, 32, 0x5a656b }, { 921, 76, 0x5a656b },
    { 1110, 35, 0x313131 }, { 1307, 26, 0x52555a },
    { 1500, 28, 0x5a555a },
  }
  local result = multiColorS(list) or multiColorS(list2)
  if not __keepScreenState then keepScreen(false) end
  return result
end

-- 检查我方生命剩余多少
exercise.checkMyHPRemain = function()
  local __keepScreenState = keepScreenState
  if not __keepScreenState then keepScreen(true) end
  local leftPoint = { 71, 65, 0x4a4d4a }
  local rightPoint = { 782, 62, 0x5a3d42 }
  local baseColor, posandcolor = transRelativePoint({
    { 143, 46, 0xef753a },
    { 144, 46, 0xf77d3a },
  })
  local baseColor2, posandcolor2 = transRelativePoint({
    { 630, 47, 0xe64d3a },
    { 631, 47, 0xf74d42 },
  })
  local pointList1 = toPoint(findMultiColorInRegionFuzzyExt(baseColor[3], posandcolor, 90, 70, 42, 791, 65))
  local pointList2 = toPoint(findMultiColorInRegionFuzzyExt(baseColor2[3], posandcolor2, 90, 70, 42, 791, 65))
  local pointList = table.merge({}, pointList1, pointList2)
  local percentPoint = math.minTable(pointList, function(item) return item[1] end)
  local result = 1
  if percentPoint and #percentPoint > 0 then
    result = math.abs(rightPoint[1] - percentPoint[1]) / math.abs(rightPoint[1] - leftPoint[1])
  end
  if not __keepScreenState then keepScreen(false) end
  return result
end

-- 点击开始演习按钮
exercise.clickcPauseBtn = function()
  RTap({ 1845, 66 }, 100)
end

-- 是否暂停面板
exercise.isPausePanel = function()
  local __keepScreenState = keepScreenState
  if not __keepScreenState then keepScreen(true) end
  local list = {
    { 522, 284, 0x101010 }, { 537, 285, 0x211c21 }, { 538, 299, 0x313131 }, { 506, 306, 0x7b6529 },
    { 505, 299, 0x211808 }, { 498, 284, 0xffd76b }, { 530, 282, 0xffdb6b }, { 557, 283, 0x080c08 },
    { 562, 284, 0xffd76b }, { 578, 281, 0x211c10 }, { 462, 250, 0xeff3f7 }, { 688, 253, 0xeff3f7 },
    { 1293, 255, 0xeff3f7 }, { 1438, 258, 0xadaaad }, { 469, 260, 0x292829 }, { 863, 317, 0x9c9e9c },
    { 1390, 279, 0xf7d242 }, { 614, 734, 0xe6e3e6 }, { 851, 779, 0xc5c2c5 }, { 1065, 731, 0xffd74a },
  }
  local result = multiColorS(list)
  if not __keepScreenState then keepScreen(false) end
  return result
end

-- 暂停面板点击退出按钮
exercise.clickcPausePanelExitBtn = function()
  RTap({ 726, 748 }, 100)
end

-- 是否退出确认面板
exercise.isExitBattleInfoPanel = function()
  local __keepScreenState = keepScreenState
  if not __keepScreenState then keepScreen(true) end
  local list = {
    { 516, 277, 0x212019 }, { 493, 278, 0xffe79c }, { 496, 297, 0x080c08 }, { 515, 303, 0x080808 },
    { 516, 308, 0xffdf8c }, { 542, 286, 0x313531 }, { 550, 290, 0xffce42 }, { 573, 288, 0x524521 },
    { 560, 301, 0xf7b608 }, { 579, 297, 0x080c08 }, { 472, 259, 0x212421 }, { 661, 262, 0x4a5152 },
    { 696, 255, 0xe6f3f7 }, { 1433, 264, 0xadaaad }, { 1395, 284, 0xefc652 }, { 628, 735, 0xf7c63a },
    { 818, 746, 0xf7b621 }, { 1097, 724, 0xdedfde }, { 1284, 764, 0xc5c2c5 }, { 743, 299, 0x000000 },
    { 695, 473, 0xfffff7 }, { 746, 475, 0xfffff7 }, { 620, 521, 0xa4f342 }, { 664, 527, 0x9cf342 },
    { 765, 544, 0xa4f34a }, { 825, 534, 0x9cf34a }, { 892, 536, 0xadf74a }, { 933, 539, 0xadf74a },
    { 1043, 528, 0xfffff7 }, { 1229, 480, 0xfffff7 },
  }
  local result = multiColorS(list)
  if not __keepScreenState then keepScreen(false) end
  return result
end

-- 暂停面板点击退出按钮
exercise.clickcExitBattleInfoPanelExitBtn = function()
  RTap({ 1185, 739 }, 100)
end

-- 点击返回按钮
exercise.clickBackBtn = function()
  RTap({ 59, 35 }, 100)
end

return exercise
