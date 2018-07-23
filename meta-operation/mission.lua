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

local function toPoint(tab)
  -- 由于这里的tab可能很长，所以使用一些特殊方法防止内存耗尽
  local newTab = {}
  local tabLength = #tab
  for key = 1, tabLength do
    newTab[key] = { tab[key].x, tab[key].y }
    tab[key] = nil
  end
  return newTab
end


local mission = {}

-- 检查是否有任务
mission.checkHasMission = function()
  local __keepScreenState = keepScreenState
  if not __keepScreenState then keepScreen(true) end
  local list = {
    { 1390, 1007, 0xe60821 }, { 1407, 1004, 0xde1831 },
    { 1409, 1016, 0xde0821 }, { 1391, 1017, 0xde0019 },
  }
  local result = multiColorS(list)
  if (not __keepScreenState) then keepScreen(false) end
  return result
end

-- 点击进入任务页
mission.clickIntoMissionPage = function()
  RTap({ 1305, 1032 }, 100)
end

-- 检查是否在任务页
mission.isMissionPage = function()
  local __keepScreenState = keepScreenState
  if not __keepScreenState then keepScreen(true) end
  local list = {
    { 9, 10, 0xdee7ef }, { 872, 4, 0xeff3f7 }, { 832, 60, 0xdedfe6 }, { 13, 52, 0xcecece },
    { 132, 14, 0x313131 }, { 318, 11, 0x424542 }, { 166, 63, 0x313131 }, { 444, 43, 0x000000 },
    { 160, 35, 0x292d29 }, { 568, 18, 0xeff3f7 }, { 38, 32, 0xffd74a }, { 65, 32, 0xffd742 },
    { 52, 24, 0xffd74a }, { 52, 44, 0xffdf4a }, { 184, 26, 0xffe7a4 }, { 195, 28, 0x292d29 },
    { 194, 47, 0x313131 }, { 204, 44, 0xffc229 }, { 210, 25, 0xf7e7b5 }, { 225, 29, 0x3a393a },
    { 246, 20, 0xfffbe6 }, { 258, 24, 0x211c19 }, { 256, 50, 0x424142 }, { 257, 37, 0x101010 },
    { 270, 34, 0xefce5a }, { 275, 29, 0x101410 }, { 287, 54, 0x424142 }, { 226, 60, 0x3a393a },
    { 225, 47, 0x3a393a }, { 185, 51, 0x191810 }, { 299, 40, 0x000000 }, { 308, 43, 0xefefff },
    { 346, 46, 0xf7f3ff }, { 358, 46, 0x000000 },
  }
  local result = multiColorS(list)
  if (not __keepScreenState) then keepScreen(false) end
  return result
end

-- 点击全部任务
mission.clickAllMissionTag = function()
  RTap({ 86, 153 }, 100)
end

-- 查找任务
mission.findMission = function()
  local __keepScreenState = keepScreenState
  if not __keepScreenState then keepScreen(true) end
  local leftTop = { 1569, 120 }
  local rightBottom = { 1832, 454 }
  local basePoint, posandcolor = transRelativePoint({
    { 1694, 190, 0xd6a229 }, { 1646, 165, 0xf7db4a }, { 1685, 163, 0xffdb52 }, { 1735, 163, 0xffdf52 },
    { 1781, 186, 0xf7c231 }, { 1783, 212, 0xffae10 }, { 1701, 215, 0xffb221 }, { 1649, 214, 0xffb219 },
    { 1602, 212, 0xffae19 }, { 1623, 191, 0xf7b621 }, { 1634, 189, 0xf7c231 }, { 1658, 188, 0xa47d29 },
    { 1693, 188, 0x9c7921 }, { 1715, 188, 0xdee3d6 }, { 1697, 181, 0xb5a684 }, { 1681, 181, 0xffffff },
    { 1680, 202, 0xffffff }, { 1723, 202, 0xefe3d6 }, { 1707, 196, 0xffffff }, { 1720, 181, 0xffffff },
  })
  local result = toPoint(findMultiColorInRegionFuzzyExt(basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBottom[1], rightBottom[2]))
  if (not __keepScreenState) then keepScreen(false) end
  return result
end

-- 点击任务
mission.clickMissionBtn = function(point)
  RTap(point, 100)
end

-- 获得道具页面
mission.isGetPropsPanel = function()
  local __keepScreenState = keepScreenState
  if not __keepScreenState then keepScreen(true) end
  local list = {
    { 13, 9, 0x31353a }, { 19, 42, 0x312d31 }, { 47, 32, 0x312d10 }, { 97, 39, 0x313131 },
    { 147, 55, 0x080808 }, { 117, 21, 0x191819 }, { 164, 15, 0x080808 }, { 191, 36, 0x312810 },
    { 256, 33, 0x312d10 }, { 200, 58, 0x191010 }, { 555, 10, 0x313531 }, { 728, 29, 0x313531 },
    { 844, 17, 0x313531 }, { 815, 57, 0x3a3531 }, { 716, 59, 0x292d29 }, { 1075, 47, 0x100c10 },
    { 1515, 69, 0x080810 }, { 1731, 45, 0x000408 }, { 20, 241, 0x101410 }, { 20, 412, 0x292029 },
  }
  local result = multiColorS(list)
  if (not __keepScreenState) then keepScreen(false) end
  return result
end

-- 点击获得道具继续
mission.clickGetPropsPanelNext = function(point)
  RTap({ 944, 815 }, 100)
end

-- 获得新船界面
mission.isGetShipPage = function()
  local __keepScreenState = keepScreenState
  if not __keepScreenState then keepScreen(true) end
  local list = {
    { 64, 55, 0x736d8c }, { 1404, 33, 0x524984 },
    { 1829, 91, 0x6b617b }, { 1866, 451, 0x634d84 },
    { 1849, 818, 0x423d5a }, { 1610, 966, 0x846da4 },
    { 1180, 1036, 0x8c75ad }, { 901, 1036, 0xad9ece },
    { 309, 1023, 0x52516b }, { 1539, 687, 0x292d31 },
  }
  local result = multiColorS(list)
  if (not __keepScreenState) then keepScreen(false) end
  return result
end

-- 点击获得道具继续
mission.clickGetNewShipNext = function(point)
  RTap({ 887, 539 }, 100)
end

-- 点击返回
mission.getPropsPanelBack = function()
  RTap({ 57, 29 }, 100)
end

return mission
