

do

do
local _ENV = _ENV
package.preload[ "BaseOperate" ] = function( ... ) local arg = _G.arg;
local home = require 'BaseOperate__home'
local battle = require 'BaseOperate__battle'


-- 原子操作列表

local map = {
  home = home, -- 主页
  battle = battle, -- 出征
}


return function()
  return map
end
end
end

do
local _ENV = _ENV
package.preload[ "BaseOperate__ImgInfo" ] = function( ... ) local arg = _G.arg;
-- 存储图像信息，用于界面找色、找图。取代图片搜索，因为找色搜索的像素点更少

require 'TableLib'

local function transRelativePoint(tab, base)
  local newTab = {}
  for key, value in ipairs(tab) do
    newTab[key] = table.assign(value, { value[1] - base[1], value[2] - base[2] })
  end
  return newTab
end

local function transColorListToString(tab)
  local tmp = {}
  for key, value in ipairs(tab) do
    value[3] = string.format('0x%06X', value[3])
    table.insert(tmp, table.concat(value, '|'))
  end
  return table.concat(tmp, ',')
end

return {
  -- 基本方法
  toPoint = function(tab)
    -- 由于这里的tab可能很长，所以使用一些特殊方法防止内存耗尽
    local newTab = {}
    local tabLength = #tab
    for key = 1, tabLength do
      newTab[key] = { tab[key].x, tab[key].y }
      tab[key] = nil
    end
    return newTab
  end,
  -- 检测点是否在两个点围围成的区域里
  inArea = function(point, areaPoint1, areaPoint2)
    local leftTop = {}
    local rightBotton = {}
    leftTop[1] = math.min(areaPoint1[1], areaPoint2[1])
    leftTop[2] = math.min(areaPoint1[2], areaPoint2[2])
    rightBotton[1] = math.max(areaPoint1[1], areaPoint2[1])
    rightBotton[2] = math.max(areaPoint1[2], areaPoint2[2])
    if ((point[1] < leftTop[1]) or (point[1] > rightBotton[1])) then
      return false
    end
    if ((point[2] < leftTop[2]) or (point[2] > rightBotton[2])) then
      return false
    end
    return true
  end,
  -- 寻找最近的两个点
  findNearestPoint = function(pointList1, pointList2)
    local nearPoint1
    local nearPoint2
    local distance = 0

    function getDistance(point1, point2)
      return math.sqrt(math.pow((point1[1] - point2[1]), 2) + math.pow((point1[1] - point2[1]), 2))
    end

    for _, value in ipairs(pointList1) do
      for _, value2 in ipairs(pointList2) do
        local newDistance = getDistance(value, value2)
        if ((distance == 0) or (newDistance < distance)) then
          nearPoint1 = value
          nearPoint2 = value2
          distance = newDistance
        end
      end
    end
    return nearPoint1, nearPoint2, distance
  end,
  -- 图片数据
  battle = {
    -- 地图扫描
    map = {
      -- 地图上边界
      topLine = (function()
        local leftTop = { 185, 155, }
        local rightBotton = { 1899, 1022, }
        local basePoint = { 567, 237, 0x314152 }
        local posandcolor = transColorListToString(transRelativePoint({
          { 572, 237, 0x293942 },
          { 577, 237, 0x314152 },
          { 582, 237, 0x213942 },
          { 587, 237, 0x294152 },
          { 589, 238, 0x31aede },
          { 584, 238, 0x31aede },
          { 579, 238, 0x31aede },
          { 574, 238, 0x31aede },
          { 569, 238, 0x31aede },
        }, basePoint))
        return {
          leftTop = leftTop,
          rightBotton = rightBotton,
          basePoint = basePoint,
          posandcolor = posandcolor,
          findColorParam = { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] },
        }
      end)(),
      -- 地图下边界
      bottonLine = (function()
        local leftTop = { 185, 155, }
        local rightBotton = { 1899, 1022, }
        local basePoint = { 695, 890, 0x000000 }
        local posandcolor = transColorListToString(transRelativePoint({
          { 695, 890, 0x000000 },
          { 698, 890, 0x000000 },
          { 701, 890, 0x000000 },
          { 704, 890, 0x000000 },
          { 707, 890, 0x000000 },
          { 707, 889, 0x1971b5 },
          { 704, 889, 0x196db5 },
          { 701, 889, 0x2171b5 },
          { 698, 889, 0x196db5 },
          { 695, 889, 0x1971bd },
        }, basePoint))
        return {
          leftTop = leftTop,
          rightBotton = rightBotton,
          basePoint = basePoint,
          posandcolor = posandcolor,
          findColorParam = { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] },
        }
      end)(),
      -- 地图左边界
      leftLine = (function()
        local leftTop = { 185, 155, }
        local rightBotton = { 1020, 1022, }
        local basePoint = { 285, 362, 0x000000 }
        local posandcolor = transColorListToString(transRelativePoint({
          { 286, 362, 0x31b6de },
          { 285, 363, 0x000000 },
          { 286, 363, 0x31b2d6 },
          { 284, 364, 0x000000 },
          { 285, 364, 0x31b2de },
          { 284, 365, 0x000000 },
          { 285, 365, 0x31b6de },
        }, basePoint))
        return {
          leftTop = leftTop,
          rightBotton = rightBotton,
          basePoint = basePoint,
          posandcolor = posandcolor,
          findColorParam = { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] },
        }
      end)(),
      -- 地图右边界
      rightLine = (function()
        local leftTop = { 950, 155, }
        local rightBotton = { 1899, 1022, }
        local basePoint = { 1800, 297, 0x299ade }
        local posandcolor = transColorListToString(transRelativePoint({
          { 1801, 297, 0x000000 },
          { 1800, 298, 0x299ee6 },
          { 1801, 298, 0x000000 },
          { 1801, 299, 0x299ae6 },
          { 1802, 299, 0x000000 },
          { 1801, 300, 0x299ae6 },
          { 1802, 300, 0x000408 },
        }, basePoint))
        return {
          leftTop = leftTop,
          rightBotton = rightBotton,
          basePoint = basePoint,
          posandcolor = posandcolor,
          findColorParam = { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] },
        }
      end)(),
      -- 我方舰队位置
      myFleet = (function()
        local leftTop = { 185, 156, }
        local rightBotton = { 1898, 791, }
        local basePoint = { 818, 370, 0xe68e4a }
        local posandcolor = transColorListToString(transRelativePoint({
          { 829, 362, 0xde8a42 },
          { 841, 352, 0xde8e4a },
          { 853, 329, 0xd67573 },
        }, basePoint))
        return {
          leftTop = leftTop,
          rightBotton = rightBotton,
          basePoint = basePoint,
          posandcolor = posandcolor,
          findColorParam = { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] },
        }
      end)(),
      -- 敌方舰队位置(1星)
      enemyList1 = (function()
        local leftTop = { 185, 156 }
        local rightBotton = { 1898, 855 }
        local basePoint = { 849, 393, 0xe6b200 }
        local posandcolor = transColorListToString(transRelativePoint({
          { 858, 402, 0xd6c219 },
          { 869, 402, 0xcebe19 },
          { 877, 402, 0xcebe19 },
        }, basePoint))
        return {
          leftTop = leftTop,
          rightBotton = rightBotton,
          basePoint = basePoint,
          posandcolor = posandcolor,
          findColorParam = { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] },
        }
      end)(),
      -- 敌方舰队位置(2星)
      enemyList2 = (function()
        local leftTop = { 185, 156 }
        local rightBotton = { 1898, 855 }
        local basePoint = { 1248, 673, 0xe6a208 }
        local posandcolor = transColorListToString(transRelativePoint({
          { 1256, 679, 0xd6aa00 },
          { 1271, 679, 0xe6a610 },
          { 1288, 679, 0xdea208 },
        }, basePoint))
        return {
          leftTop = leftTop,
          rightBotton = rightBotton,
          basePoint = basePoint,
          posandcolor = posandcolor,
          findColorParam = { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] },
        }
      end)(),
      -- 敌方舰队位置(3星)
      enemyList3 = (function()
        local leftTop = { 185, 156 }
        local rightBotton = { 1898, 855 }
        local basePoint = { 834, 837, 0xbd3500 }
        local posandcolor = transColorListToString(transRelativePoint({
          { 841, 849, 0xb54110 },
          { 853, 849, 0xbd3900 },
          { 863, 849, 0xbd3900 },
        }, basePoint))
        return {
          leftTop = leftTop,
          rightBotton = rightBotton,
          basePoint = basePoint,
          posandcolor = posandcolor,
          findColorParam = { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] },
        }
      end)(),
      -- boss位置
      bossPoint = (function()
        local leftTop = { 281, 370 }
        local rightBotton = { 1885, 925 }
        local basePoint = { 1744, 872, 0xff4d52 }
        local posandcolor = transColorListToString(transRelativePoint({
          { 1803, 875, 0xff4d52 },
          { 1769, 833, 0x313531 },
          { 1775, 898, 0x6b0810 },
          { 1807, 842, 0x292429 },
          { 1743, 840, 0x313531 },
        }, basePoint))
        return {
          leftTop = leftTop,
          rightBotton = rightBotton,
          basePoint = basePoint,
          posandcolor = posandcolor,
          findColorParam = { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] },
        }
      end)(),
    },
  },
}
end
end

do
local _ENV = _ENV
package.preload[ "BaseOperate__battle" ] = function( ... ) local arg = _G.arg;
local ImgInfo = require 'BaseOperate__ImgInfo'

local battle = {}


--  是否在出击界面
battle.isBattlePage = function()
  local __keepScreenState = keepScreenState
  if not __keepScreenState then keepScreen(true) end
  local list = {
    { 8, 10, 0xe6e7ef }, { 201, 21, 0xffefc5 },
    { 307, 12, 0x424542 }, { 1024, 38, 0x313131 },
    { 1333, 40, 0xffef63 }, { 1645, 37, 0xff4573 },
    { 21, 144, 0xf7f7f7 }, { 31, 162, 0xf7fbf7 },
    { 114, 151, 0xf7f7f7 }, { 1185, 1022, 0xf7f3f7 },
    { 1493, 1017, 0xf7f7f7 }, { 1797, 1017, 0xf7f3f7 },
    { 182, 20, 0xfff3c5 }, { 178, 35, 0xffc642 },
    { 210, 28, 0x3a393a }, { 219, 32, 0xffd25a },
    { 255, 30, 0xffdb73 }, { 244, 42, 0x3a393a },
    { 267, 42, 0x3a393a }, { 273, 51, 0xf7c652 },
    { 259, 17, 0xfff7de }, { 266, 25, 0x101010 },
  }
  local result = multiColorS(list)
  if not __keepScreenState then keepScreen(false) end
  return result
end

-- 点击回港
battle.clickBackToHomeBtn = function()
  tap(98, 1016, 100)
end

-- 移动到m章节
battle.moveToChapter = function(chapter)
  local chapterArr = strSplit(chapter, "-")
  local m = tonumber(chapterArr[1]) or 1
  local n = tonumber(chapterArr[2]) or 1

  local leftButton = {
    { 97, 526, 0xe6e7e6 },
    { 86, 539, 0xd6d7d6 },
    { 109, 577, 0xdedbde },
  }
  -- 先移到第一章
  for i = 1, 8 do
    tap(90, 540, 100)
    mSleep(200)
    if not multiColorS(leftButton) then
      break
    end
  end
  -- 再移到第m章
  for i = 2, m do
    tap(1826, 540, 100)
    mSleep(200)
  end

  if (chapter == '1-1') then
    tap(227, 687, 100)
  elseif (chapter == '1-2') then
    tap(685, 409, 100)
  elseif (chapter == '1-3') then
    tap(984, 789, 100)
  elseif (chapter == '1-4') then
    tap(1366, 317, 100)
  elseif (chapter == '2-1') then
    tap(1221, 685, 100)
  elseif (chapter == '2-2') then
    tap(1121, 277, 100)
  elseif (chapter == '2-3') then
    tap(429, 406, 100)
  elseif (chapter == '2-4') then
    tap(572, 821, 100)
  elseif (chapter == '3-1') then
    tap(603, 320, 100)
  elseif (chapter == '3-2') then
    tap(344, 750, 100)
  elseif (chapter == '3-3') then
    tap(1364, 279, 100)
  elseif (chapter == '3-4') then
    tap(923, 540, 100)
  elseif (chapter == '4-1') then
    tap(356, 454, 100)
  elseif (chapter == '4-2') then
    tap(632, 705, 100)
  elseif (chapter == '4-3') then
    tap(1235, 822, 100)
  end
end

--  是否在章节信息面板
battle.isChapterInfoPanel = function()
  local __keepScreenState = keepScreenState
  if not __keepScreenState then keepScreen(true) end
  local list = {
    { 468, 283, 0x292d29 }, { 829, 281, 0xeff3f7 },
    { 1559, 277, 0xadaaad }, { 369, 786, 0x4a494a },
    { 1553, 782, 0x3a3d42 }, { 1267, 715, 0xffca42 },
    { 1310, 717, 0xffffff }, { 1344, 716, 0xffce3a },
    { 1363, 716, 0xb5aa84 }, { 1389, 721, 0xffffff },
    { 1406, 704, 0xf7f7ef }, { 1434, 718, 0xc5ae84 },
    { 1464, 724, 0xf7f3ef }, { 1480, 721, 0xffffff },
    { 1506, 719, 0xf7c231 }, { 1518, 725, 0xf7be29 },
    { 1268, 624, 0x3a3d42 }, { 1286, 623, 0xf7f7f7 },
    { 1327, 627, 0x424142 }, { 1526, 499, 0x292d29 },
  }
  local result = multiColorS(list)
  if not __keepScreenState then keepScreen(false) end
  return result
end

-- 前往选择舰队面板
battle.clickGotoSelectFleedPanelBtn = function()
  tap(1388, 720, 100)
end

--  是否在选择舰队面板
battle.isSelectFleetPanel = function()
  local __keepScreenState = keepScreenState
  if not __keepScreenState then keepScreen(true) end
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
  local result = multiColorS(list)
  if not __keepScreenState then keepScreen(false) end
  return result
end

-- 检查已经选择的舰队
battle.checkSelectedFleet = function(needFleetList)
  local __keepScreenState = keepScreenState
  if not __keepScreenState then keepScreen(true) end
  -- 需要选中的舰队，转换成索引
  local needFleet = { false, false, false, false }
  for _, v in ipairs(needFleetList) do
    needFleet[v] = true
  end

  local list1 = { { 553, 835, 0xf7a23a } }
  local list2 = { { 760, 838, 0xf7a242 } }
  local list3 = { { 987, 839, 0xf7a242 } }
  local list4 = { { 1203, 840, 0xefa23a } }
  -- 已经选中的舰队索引
  local nowSelectedFeeld = {
    multiColorS(list1) and true or false,
    multiColorS(list2) and true or false,
    multiColorS(list3) and true or false,
    multiColorS(list4) and true or false,
  }
  -- 已经选中的舰队
  local nowSelectedFeeldList = {}
  for key, _ in ipairs(nowSelectedFeeld) do
    table.insert(nowSelectedFeeldList, key)
  end
  -- 需要改变的舰队索引
  local needChange = { false, false, false, false }
  for key = 1, 4 do
    if needFleet[key] ~= nowSelectedFeeld[key] then
      if needFleet[key] then
        needChange[key] = 'select'
      else
        needChange[key] = 'unselect'
      end
    end
  end

  -- 需要选中的舰队
  local selectChangeList = {}
  -- 需要取消的舰队
  local unSelectChangeList = {}
  -- 需要改变的舰队
  local needChangeList = {}
  for key, _ in ipairs(needChange) do
    if (needChange[key]) then
      table.insert(needChangeList, key)
    end
    if needChange[key] == 'select' then
      table.insert(selectChangeList, key)
    elseif needChange[key] == 'unselect' then
      table.insert(unSelectChangeList, key)
    end
  end

  if not __keepScreenState then keepScreen(false) end
  return #needChangeList == 0, selectChangeList, unSelectChangeList
end

-- 点击舰队
battle.clickFleet = function(clickFleetList)
  if type(clickFleetList) ~= 'table' then
    clickFleetList = { clickFleetList }
  end
  for _, fleet in ipairs(clickFleetList) do
    if fleet == 1 then
      tap(479, 842)
    elseif fleet == 2 then
      tap(689, 844)
    elseif fleet == 3 then
      tap(901, 843)
    elseif fleet == 4 then
      tap(1119, 845)
    end
    mSleep(50)
  end
end


-- 前往地图
battle.clickGotoMapBtn = function()
  tap(1398, 845, 100)
end

--  是否在地图页面
battle.isMapPage = function()
  local __keepScreenState = keepScreenState
  if not __keepScreenState then keepScreen(true) end
  local list = {
    { 98, 48, 0xd6d7d6 }, { 748, 12, 0xeff3f7 },
    { 1025, 49, 0x8c868c }, { 1342, 48, 0xefb64a },
    { 1654, 45, 0xd62452 }, { 1058, 995, 0xbd0810 },
    { 1184, 1032, 0x6b1019 }, { 1294, 990, 0x4a454a },
    { 1683, 972, 0xde7910 }, { 1344, 989, 0xf7fbf7 },
  }
  local result = multiColorS(list)
  if not __keepScreenState then keepScreen(false) end
  return result
end

-- 将地图移动到中心
battle.moveMapToCenter = function()
  local __keepScreenState = keepScreenState
  if not __keepScreenState then keepScreen(true) end

  local isCenter = false
  -- 扫描边界
  keepScreen(true)
  local topLinePoint = { findMultiColorInRegionFuzzy(table.unpack(ImgInfo.battle.map.topLine.findColorParam)) }
  local bottonLinePoint = { findMultiColorInRegionFuzzy(table.unpack(ImgInfo.battle.map.bottonLine.findColorParam)) }
  local leftLinePointList = ImgInfo.toPoint(findMultiColorInRegionFuzzyExt(table.unpack(ImgInfo.battle.map.leftLine.findColorParam)))
  local rightLinePointList = ImgInfo.toPoint(findMultiColorInRegionFuzzyExt(table.unpack(ImgInfo.battle.map.rightLine.findColorParam)))

  function getCenterPoint(topLinePoint, bottonLinePoint, pointList)
    -- 获取左右边界的中间点
    local Y = (topLinePoint[2] + bottonLinePoint[2]) / 2
    Y = math.floor(Y)
    local point1 = pointList[1] or { -1, -1 }
    local point2 = pointList[#pointList] or { -1, -1 }
    local X = (Y - point1[2]) / (point2[2] - point1[2]) * (point2[1] - point1[1]) + point1[1] or -1
    X = math.trueNumber(X) or -1
    X = math.floor(X)
    return { X, Y }
  end

  local leftLinePoint = getCenterPoint(topLinePoint, bottonLinePoint, leftLinePointList)
  local rightLinePoint = getCenterPoint(topLinePoint, bottonLinePoint, rightLinePointList)

  -- 计算偏差
  local moveVector = { 0, 0 }
  if (topLinePoint[2] ~= -1) then
    moveVector[2] = 379 - topLinePoint[2]
  elseif (bottonLinePoint[2] ~= -1) then
    moveVector[2] = 979 - bottonLinePoint[2]
  end
  if (leftLinePoint[1] ~= -1) then
    moveVector[1] = 228 - leftLinePoint[1]
  elseif (rightLinePoint[1] ~= -1) then
    moveVector[1] = 1846 - rightLinePoint[1]
  end

  -- 将地图移动到中心
  if ((math.abs(moveVector[1]) > 10) or (math.abs(moveVector[2]) > 10)) then
    local moveMax = math.min(40, math.abs(moveVector[1]), math.abs(moveVector[2]))
    moveMax = math.abs(moveMax)
    moveMax = math.max(1, moveMax)
    moveTo(540, 960, 540 + moveVector[1], 960 + moveVector[2], moveMax, 100)
  else
    isCenter = true
  end
  if not __keepScreenState then keepScreen(false) end
  return isCenter
end

-- 扫描我方舰队
battle.scanMapScanMyFleet = function()
  local __keepScreenState = keepScreenState
  if not __keepScreenState then keepScreen(true) end

  local myFleetList = ImgInfo.toPoint(findMultiColorInRegionFuzzyExt(table.unpack(ImgInfo.battle.map.myFleet.findColorParam)))

  if not __keepScreenState then keepScreen(false) end
end

-- 扫描终点
battle.scanMapScanEndPoint = function()
  local __keepScreenState = keepScreenState
  if not __keepScreenState then keepScreen(true) end

  local myFleetList = ImgInfo.toPoint(findMultiColorInRegionFuzzyExt(table.unpack(ImgInfo.battle.map.myFleet.findColorParam)))

  if not __keepScreenState then keepScreen(false) end
end

-- 检测是第几队
battle.scanMapCheckFleetNum = function()
  local __keepScreenState = keepScreenState
  if not __keepScreenState then keepScreen(true) end
  local list = {
    { 304, 141, 0x4a5d52 },
    { 319, 148, 0xefaa10 },
    { 335, 138, 0x5a695a },
    { 322, 96, 0xffefb5 },
    { 305, 104, 0xffe7a4 },
    { 335, 114, 0x637163 },
  }
  local result1 = multiColorS(list)
  if not __keepScreenState then keepScreen(false) end
  if (result1) then
    return 1
  end
  return 2
end

-- 点击到boss出现区域
battle.clickToMapBossArea = function()
  tap(1777, 741, 100)
end

-- 检查是否在右下角位置
battle.isFleetOnBossArea = function()
  local __keepScreenState = keepScreenState
  if not __keepScreenState then keepScreen(true) end

  local myFleetList = ImgInfo.toPoint(findMultiColorInRegionFuzzyExt(table.unpack(ImgInfo.battle.map.myFleet.findColorParam)))

  local result = false
  for _, value in ipairs(myFleetList) do
    if (ImgInfo.inArea(value, { 1746, 430 }, { 1897, 686 })) then
      result = true
      break
    end
  end
  if not __keepScreenState then keepScreen(false) end
  return result
end

battle.isSelectedFleed = function(fleet)
  local __keepScreenState = keepScreenState
  if not __keepScreenState then keepScreen(true) end
  local list
  if fleet == 1 then
    list = {
      { 301, 101, 0x424542 }, { 322, 96, 0xffefbd },
      { 311, 119, 0x424142 }, { 321, 132, 0xf7be21 },
      { 328, 145, 0x5a4d3a }, { 310, 144, 0x4a494a },
      { 320, 146, 0xf7ba08 }, { 321, 125, 0xf7c642 },
    }
  elseif fleet == 2 then
    list = {
      { 305, 108, 0xffe39c }, { 320, 103, 0x635142 },
      { 331, 108, 0xf7df9c }, { 338, 108, 0x424142 },
      { 318, 126, 0xefce4a }, { 323, 137, 0x6b5131 },
      { 307, 147, 0xf7b608 }, { 330, 147, 0xf7b600 },
    }
  elseif fleet == 3 then
    list = {
      { 306, 107, 0xf7e39c }, { 309, 133, 0xf7be21 },
      { 318, 119, 0xefc663 }, { 313, 117, 0x525142 },
      { 302, 113, 0x524131 }, { 303, 127, 0x52514a },
      { 331, 146, 0xefba00 }, { 335, 103, 0xf7e7a4 },
    }
  elseif fleet == 4 then
    list = {
      { 321, 98, 0xf7e7ad }, { 333, 135, 0xffba10 },
      { 327, 147, 0xefba21 }, { 303, 136, 0xffba10 },
      { 314, 126, 0x4a453a }, { 298, 130, 0x524529 },
      { 338, 135, 0x42413a }, { 322, 90, 0x424142 },
    }
  end
  local result = multiColorS(list)
  if not __keepScreenState then keepScreen(false) end
  return result
end

battle.clickSwitchFleetBtn = function()
  tap(1426, 1003, 100)
end

-- 寻找最近的敌人
battle.findNearEnemyPointList = function()
  local __keepScreenState = keepScreenState
  if not __keepScreenState then keepScreen(true) end
  local enemyPoint
  local myFleetList = ImgInfo.toPoint(findMultiColorInRegionFuzzyExt(table.unpack(ImgInfo.battle.map.myFleet.findColorParam)))
  local enemyList1 = ImgInfo.toPoint(findMultiColorInRegionFuzzyExt(table.unpack(ImgInfo.battle.map.enemyList1.findColorParam)))
  local enemyList2 = ImgInfo.toPoint(findMultiColorInRegionFuzzyExt(table.unpack(ImgInfo.battle.map.enemyList2.findColorParam)))
  local enemyList3 = ImgInfo.toPoint(findMultiColorInRegionFuzzyExt(table.unpack(ImgInfo.battle.map.enemyList3.findColorParam)))
  local enemyList = table.merge(enemyList1, enemyList2, enemyList3)
  local myFleetListFirstPoint = myFleetList[#myFleetList] or {}
  local myFleetPointX = (math.trueNumber(myFleetListFirstPoint[1]) or 0) - 60
  local myFleetPointY = (math.trueNumber(myFleetListFirstPoint[2]) or 0) + 230
  local myFleetPoint = { myFleetPointX, myFleetPointY }
  local _, e = ImgInfo.findNearestPoint({ myFleetPoint }, enemyList)
  if e then
    enemyPoint = { (math.trueNumber(e[1]) or 0) + 100, (math.trueNumber(e[2]) or 0) + 30 }
  end

  if not __keepScreenState then keepScreen(false) end
  return enemyPoint
end

-- 检测boss是否在地图上
battle.isBossOnMap = function()
  local bossPointList = { findMultiColorInRegionFuzzy(table.unpack(ImgInfo.battle.map.bossPoint.findColorParam)) }
  if (bossPointList[1] > -1) and (bossPointList[2] > -1) then
    return true
  end
  return false
end

-- 检测boss位置
battle.findBossPoint = function()
  local bossPointList = { findMultiColorInRegionFuzzy(table.unpack(ImgInfo.battle.map.bossPoint.findColorParam)) }
  if (bossPointList[1] > -1) and (bossPointList[2] > -1) then
    return bossPointList
  end
  return nil
end

-- 检测敌方伏击面板
battle.isAmbushedPanel = function()
  local __keepScreenState = keepScreenState
  if not __keepScreenState then keepScreen(true) end
  local list = {
    { 369, 678, 0x527119 }, { 399, 671, 0x527521 },
    { 428, 680, 0xfffbf7 }, { 803, 562, 0xf7ca3a },
    { 955, 565, 0xffffff }, { 1055, 597, 0xffa619 },
    { 1237, 540, 0xe6e7e6 }, { 1349, 568, 0xffffff },
    { 1485, 593, 0xc5bebd }, { 1200, 685, 0x5a595a },
  }
  local result = multiColorS(list)
  if not __keepScreenState then keepScreen(false) end
  return result
end

battle.ambushedPanelClickAvoidBtn = function()
  tap(1351, 564)
end

battle.moveToEnemy = function(point)
  tap(point[1], point[2])
end

-- 检测敌方伏击面板
battle.isReadyBattlePage = function()
  local __keepScreenState = keepScreenState
  if not __keepScreenState then keepScreen(true) end
  local list = {
    { 49, 103, 0x3a4552 }, { 1395, 198, 0xf7f3f7 },
    { 1369, 523, 0xe6e7e6 }, { 1389, 901, 0xd6f3f7 },
    { 1781, 998, 0x8ccece }, { 1613, 935, 0xffefbd },
    { 1272, 361, 0x212429 }, { 135, 844, 0xefefef },
  }
  local result = multiColorS(list)
  if not __keepScreenState then keepScreen(false) end
  return result
end

battle.readyBattlePageClickBattle = function()
  tap(1592, 952)
end

-- 检测是否在战斗中
battle.isInBattlePage = function()
  local __keepScreenState = keepScreenState
  if not __keepScreenState then keepScreen(true) end
  local list = {
    { 91, 78, 0x313942 }, { 131, 51, 0x4a5963 },
    { 307, 61, 0x4a5963 }, { 344, 47, 0xbdced6 },
    { 312, 109, 0x313d42 }, { 1818, 40, 0xdedfde },
    { 1835, 66, 0x3a353a }, { 1875, 92, 0xdedfd6 },
    { 1860, 56, 0x292d29 },
  }
  local result = multiColorS(list)
  if not __keepScreenState then keepScreen(false) end
  return result
end

-- 检测是否自动战斗
battle.isAutoBattle = function()
  local __keepScreenState = keepScreenState
  if not __keepScreenState then keepScreen(true) end
  local list = {
    { 139, 70, 0x4a5963 }, { 146, 72, 0x424952 },
    { 146, 79, 0x212d31 }, { 152, 87, 0x313d42 },
    { 164, 92, 0xefebef }, { 167, 76, 0xf7f7f7 },
    { 163, 67, 0xffffff }, { 158, 65, 0x4a555a },
    { 155, 81, 0x314142 }, { 155, 83, 0xe6ebe6 },
  }
  local result = multiColorS(list)
  if not __keepScreenState then keepScreen(false) end
  return not result
end

-- 检测是否自动战斗确认面板
battle.isAutoBattleConfirmPanel = function()
  local __keepScreenState = keepScreenState
  if not __keepScreenState then keepScreen(true) end
  local list = {
    { 492, 239, 0xffe7ad }, { 542, 247, 0x212821 },
    { 548, 249, 0xefc652 }, { 585, 265, 0xf7b208 },
    { 600, 262, 0x424142 }, { 1164, 226, 0xeff3f7 },
    { 849, 760, 0xffd24a }, { 946, 795, 0xffffff },
    { 1004, 778, 0xffca3a }, { 1021, 775, 0xffffff },
  }
  local result = multiColorS(list)
  if not __keepScreenState then keepScreen(false) end
  return result
end

-- 自动战斗确认面板点击知道了
battle.isAutoBattleConfirmPanelClickOk = function()
  tap(949, 779)
end

-- 战斗页面点击自动战斗
battle.inBattlePageClickAutoBattle = function()
  tap(208, 75)
end

-- 检测是否胜利界面
battle.isVictoryPanel = function()
  local __keepScreenState = keepScreenState
  if not __keepScreenState then keepScreen(true) end
  local list = {
    { 538, 403, 0xf7eb94 }, { 555, 445, 0xffdb52 },
    { 679, 450, 0xf7df52 }, { 598, 468, 0x84818c },
    { 592, 553, 0xe67d31 }, { 680, 540, 0xf79e42 },
    { 901, 430, 0xf7c64a }, { 1082, 478, 0xffff5a },
    { 1350, 533, 0xef9e3a }, { 926, 864, 0xd6ced6 },
  }
  local list2 = {
    { 618, 434, 0xf7ce52 }, { 543, 550, 0xef813a },
    { 629, 522, 0xf7c64a }, { 859, 484, 0xfffb5a },
    { 1238, 552, 0xef813a }, { 1395, 548, 0xef813a },
    { 1390, 480, 0xffff5a }, { 1424, 427, 0xf7be4a },
    { 271, 719, 0x424142 }, { 1651, 728, 0x424142 },
  }
  local list3 = {
    { 559, 447, 0xe6a273 }, { 674, 451, 0xe6ae84 },
    { 848, 469, 0xe6965a }, { 1092, 448, 0x6b2819 },
    { 1179, 451, 0xefcaad }, { 1356, 467, 0x521c08 },
    { 1430, 492, 0xe69e6b }, { 1423, 541, 0xe69e6b },
  }
  local result = false
  if (multiColorS(list) or multiColorS(list2) or multiColorS(list3)) then
    result = true
  end
  if not __keepScreenState then keepScreen(false) end
  return result
end

-- 胜利面板点击继续
battle.victoryPanelClickNext = function()
  tap(952, 840)
end

-- 检测是否获得道具面板
battle.isGetPropsPanel = function()
  local __keepScreenState = keepScreenState
  if not __keepScreenState then keepScreen(true) end
  local list = {
    { 763, 212, 0xf7ae63 }, { 854, 168, 0xffffff },
    { 958, 174, 0x845131 }, { 1054, 167, 0xf7f384 },
    { 764, 242, 0xffaa42 }, { 861, 232, 0x7b2408 },
    { 944, 240, 0xffffff }, { 1006, 268, 0xffdf3a },
    { 1098, 277, 0xf7b629 }, { 969, 809, 0xffffff },
  }
  local result = multiColorS(list)
  if not __keepScreenState then keepScreen(false) end
  return result
end

-- 获得道具面板点击继续
battle.getPropsPanelClickNext = function()
  tap(952, 840)
end

-- 检测是否获得船面板
battle.isGetNewShipPanel = function()
  local __keepScreenState = keepScreenState
  if not __keepScreenState then keepScreen(true) end
  local list = {
    { 64, 504, 0xefefff }, { 108, 539, 0x7b7d8c },
    { 86, 658, 0xe6c2c5 }, { 91, 787, 0xe6d7ce },
    { 83, 906, 0x3acee6 }, { 88, 948, 0xcecece },
    { 1496, 852, 0xefefef }, { 1572, 909, 0xc5c2bd },
    { 1543, 938, 0xeff3ef },
  }
  local result = multiColorS(list)
  if not __keepScreenState then keepScreen(false) end
  return result
end

-- 获得船面板点击继续
battle.getNewShipPanelClickNext = function()
  tap(952, 840)
end

-- 检测是否获得经验面板
battle.isGetExpPanel = function()
  local __keepScreenState = keepScreenState
  if not __keepScreenState then keepScreen(true) end
  local list = {
    { 548, 297, 0x63656b }, { 658, 277, 0x63656b },
    { 984, 274, 0x6b696b }, { 1260, 278, 0x6b696b },
    { 1374, 289, 0x636563 }, { 248, 734, 0x424142 },
    { 1294, 922, 0xbdbabd }, { 1363, 911, 0x4a494a },
    { 1533, 912, 0xd6d2d6 }, { 1681, 926, 0xbdbab5 },
    { 1587, 884, 0xe6ebe6 }, { 1599, 916, 0xffffff },
  }
  local result = multiColorS(list)
  if not __keepScreenState then keepScreen(false) end
  return result
end

-- 获得道具面板点击继续
battle.getExpPanelClickNext = function()
  tap(1671, 914)
end

-- 点击返回主页
battle.battlePageClickBackToHome = function()
  tap(46, 37)
end

-- 检测是否紧急委托面板
battle.isUrgentEntrustmentPanel = function()
  local __keepScreenState = keepScreenState
  if not __keepScreenState then keepScreen(true) end
  local list = {
    { 482, 289, 0x212821 }, { 493, 288, 0xffce3a },
    { 534, 293, 0x080808 }, { 567, 292, 0xf7c23a },
    { 752, 302, 0x000000 }, { 1047, 301, 0xdedfde },
    { 835, 737, 0xffca3a }, { 919, 740, 0xffffff },
    { 977, 745, 0xefb231 }, { 1002, 736, 0xfff7f7 },
  }
  local result = multiColorS(list)
  if not __keepScreenState then keepScreen(false) end
  return result
end

-- 获得道具面板点击继续
battle.urgentEntrustmentPanelClickOk = function()
  tap(957, 739)
end

return battle
end
end

do
local _ENV = _ENV
package.preload[ "BaseOperate__home" ] = function( ... ) local arg = _G.arg;
local home = {}

-- 检测主页
home.isHome = function()
  local __keepScreenState = keepScreenState
  if (not __keepScreenState) then keepScreen(true) end
  local list = {
    { 139, 30, 0x101010 }, { 625, 24, 0x212021 },
    { 963, 16, 0x292d3a }, { 1033, 67, 0x3a3d3a },
    { 1058, 31, 0xe6efef }, { 1339, 47, 0xefba42 },
    { 1369, 32, 0xefebef }, { 1652, 39, 0xf74163 },
    { 1675, 65, 0xefefef }, { 1775, 184, 0xa4cede },
    { 1162, 179, 0xa4cade }, { 1276, 189, 0xa4cade },
    { 1201, 582, 0x109eef }, { 1383, 582, 0x199ae6 },
    { 1290, 571, 0xffffff }, { 1498, 585, 0xdeae10 },
    { 1744, 597, 0xe6aa10 }, { 1591, 580, 0xffffff },
    { 112, 990, 0xffffff }, { 190, 974, 0xe6e7e6 },
  }
  local result = multiColorS(list)
  if (not __keepScreenState) then keepScreen(false) end
  return result
end

-- 点击出征
home.clickBattleBtn = function()
  tap(1628, 599, 100)
end

return home
end
end

do
local _ENV = _ENV
package.preload[ "BaseOperate__maps3-4" ] = function( ... ) local arg = _G.arg;
-- -1 = 障碍物
-- 0 = 空格
-- 1 = 玩家舰队
-- 2 = 玩家舰队
-- 11 ~ 20 = 敌方舰队
-- 21 ~ 30 = 奖励

local baseMap = {
  { -1, -1, -1, -1, -1, -1, -1, -1, -1, -1 },
  { -1, 0, 0, 0, 0, 0, -1, -1, -1, -1 },
  { -1, 0, 0, 0, 0, 0, 21, -1, -1, -1 },
  { -1, -1, 0, 0, 0, 0, 0, 0, 0, -1 },
  { -1, 0, 0, 0, 0, 0, 0, 0, 0, -1 },
  { -1, -1, -1, -1, -1, -1, -1, -1, -1, -1 },
}

function scanMap()

end

return {
  height = 4,
  width = 8,
  baseMap = baseMap,
}
end
end

do
local _ENV = _ENV
package.preload[ "Co" ] = function( ... ) local arg = _G.arg;
-----------------------------------------------------------------------------
-- ES6 co lib in lua 5.1
-- Author: fgfg163@163.com
-- Copyright (c) 2015.11
--
-- This is a lib porting from Co v4 in JavaScript
-- It has some different before.
-- to see https://github.com/tj/co
-- Useage:
-- co(coroutine.create(function()
-- local v1 = coroutine.yield(Promise.resolve(123))
-- local v2 = coroutine.yield({
-- a = Promise.resolve(234),
-- b = Promise.resolve(456),
-- })
-- console.log(v1)
-- console.log(v2)
-- end)):catch(function(err)
-- print(err)
-- end)

-----------------------------------------------------------------------------


local Promise = Promise or require 'Promise'

local unpack = unpack or table.unpack
local isArray = table.isArray or function(tab)
  if (type(tab) ~= "table") then
    return false
  end
  local length = #tab
  for k, v in pairs(tab) do
    if ((type(k) ~= "number") or (k > length)) then
      return false
    end
  end
  return true
end
function tryCatch(cb)
  return xpcall(cb, function(e)
    return setStackTraceback and
      (e .. '\n' .. debug.traceback())
      or (e)
  end)
end

----------------------------------------------------------------------
function new(gen, ...)
  return Promise.new(function(resolve, reject)
    if (type(gen) == 'function') then gen = coroutine.create(gen) end
    if (type(gen) ~= 'thread') then return resolve(gen) end

    local onResolved, onRejected, next

    onResolved = function(res)
      local done, ret
      local coStatus = true
      local xpcallRes, xpcallErr = tryCatch(function()
        coStatus, ret = coroutine.resume(gen, res)
      end)
      if (not xpcallRes) then
        return reject(xpcallErr)
      end
      if (not coStatus) then
        return reject(ret)
      end
      done = (coroutine.status(gen) == 'dead')
      next(done, ret)
    end

    onRejected = function(err)
      local done, ret
      local coStatus = true
      local xpcallRes, xpcallErr = tryCatch(function()
        coStatus, ret = coroutine.resume(gen, error(tostring(err)))
      end)
      if (not xpcallRes) then
        return reject(xpcallErr)
      end
      if (not coStatus) then
        return reject(xpcallErr)
      end
      done = (coroutine.status(gen) == 'dead')
      next(done, ret)
    end

    next = function(done, ret)
      if (done) then
        return resolve(ret)
      end
      local value = toPromise(ret)
      if (value and (isPromise(value))) then
        return value.andThen(onResolved, onRejected)
      end
      return onResolved(value)
      --       onRejected(error('You may only yield a function, promise, generator, array, or object, '
      --          .. 'but the following object was passed: "' .. type(ret) .. '"'))
    end

    onResolved();
  end)
end


-- Convert a `yield`ed value into a promise.
--
-- @param {Mixed} obj
-- @return {Promise}
-- @api private
function toPromise(obj)
  if (not obj) then return obj end

  if (isPromise(obj)) then return obj end
  if (isCoroutine(obj)) then return new(obj) end
  if (type(obj) == 'function') then return thunkToPromise(obj) end

  if (isArray(obj)) then
    return arrayToPromise(obj)
  elseif (type(obj) == 'table') then
    return objectToPromise(obj)
  end

  return obj
end

-- Check if `obj` is a promise.
--
-- @param {Object} obj
-- @return {Boolean}
-- @api private
function isPromise(obj)
  if ((type(obj) == 'table') and (type(obj.andThen) == 'function')) then
    return true
  end
  return false
end

-- Check if `obj` is a generator.
--
-- @param {Mixed} obj
-- @return {Boolean}
-- @api private
function isCoroutine(obj)
  if (type(obj) == 'thread') then
    return true
  end
  return false
end


-- Convert a thunk to a promise.
--
-- @param {Function}
-- @return {Promise}
-- @api private
function thunkToPromise(fn)
  return Promise.new(function(resolve, reject)
    fn(function(err, res)
      if (err) then return reject(err) end
      if (#res > 2) then
        res = { res[2] }
      end
      resolve(res)
    end)
  end)
end

-- Convert an array of "yieldables" to a promise.
-- Uses `Promise.all()` internally.
--
-- @param {Array} obj
-- @return {Promise}
-- @api private
function arrayToPromise(obj)
  local newArr = {}
  for k, v in ipairs(obj) do
    table.insert(newArr, toPromise(v))
  end
  return Promise.all(newArr);
end

-- Convert an object of "yieldables" to a promise.
-- Uses `Promise.all()` internally.
--
-- @param {Object} obj
-- @return {Promise}
-- @api private
function objectToPromise(obj)
  local results = {}
  local promises = {}

  local function defer(promise, key)
    results[key] = nil
    table.insert(promises, promise.andThen(function(res)
      results[key] = res
    end))
  end

  for key, value in pairs(obj) do
    local promise = toPromise(value)
    if (promise and isPromise(promise)) then
      defer(promise, key)
    else
      results[key] = obj[key]
    end
  end

  return Promise.all(promises).andThen(function()
    return results
  end)
end



return setmetatable({
  new = new,
  Promise = Promise,
}, {
  __call = function(_, ...)
    return new(...)
  end
})

end
end

do
local _ENV = _ENV
package.preload[ "DeviceOrientHock" ] = function( ... ) local arg = _G.arg;
require "TSLib"

local __init = init

-- 0=竖屏，1=右旋（home键在右边），2=左旋（home键在左边），3=倒立
__init(0)
local w, h = getScreenSize()
local m = math.max(w, h)
local sideLength = math.min(w, h)
local orient = 0;
local nextUpdateTime = 0

-- 计算方向辅助界面，一像素宽度的白色边界，一像素宽的黑色边界，用于检测方向
fwShowWnd("orientwid1", 0, 0, 2, m, 0)
fwShowTextView("orientwid1", "text1", "", "center", "000000", "FEFEFE", 15, 0, 0, 0, 1, m, 1)
fwShowTextView("orientwid1", "text2", "", "center", "000000", "010101", 15, 0, 1, 0, 2, m, 1)
mSleep(100)

-- 计算当前方向
function calOrient(_orient)
  local result = _orient
  -- 寻找白色边界
  __init(_orient)

  local checkOrder = { 0, 1, 2 }
  if (_orient == 0) then
    checkOrder = { 1, 2 }
  elseif (_orient == 1) then
    checkOrder = { 0, 2 }
  elseif (_orient == 2) then
    checkOrder = { 0, 1 }
  end

  local checkPointList = {
    { 0, math.floor(0.333 * sideLength), 0xfefefe },
    { 0, math.floor(0.5 * sideLength), 0xfefefe },
    { 0, math.floor(0.667 * sideLength), 0xfefefe },
    { 0, math.floor(0.833 * sideLength), 0xfefefe },
    { 1, math.floor(0.333 * sideLength), 0x010101 },
    { 1, math.floor(0.5 * sideLength), 0x010101 },
    { 1, math.floor(0.667 * sideLength), 0x010101 },
    { 1, math.floor(0.833 * sideLength), 0x010101 },
  }

  -- 如果方向没变则不旋转
  if (multiColorS(checkPointList)) then
    return _orient
  end
  -- 如果方向变了则旋转
  for k, v in ipairs(checkOrder) do
    __init(v)
    if (multiColorS(checkPointList)) then
      return v
    end
  end
  __init(_orient)
  return _orient
end

local _orient = calOrient(orient)
orient = _orient

-- 获取当前方向
getDeviceOrient = function()
  local newOrient = orient
  if (os.time() > nextUpdateTime) then
    local _keepScreenState = keepScreenState
    if (not _keepScreenState) then keepScreen(true) end
    newOrient = calOrient(orient)
    nextUpdateTime = os.time() + 1
    if (not _keepScreenState) then keepScreen(false) end
  end
  return newOrient
end


-- 设置当前方向，当然只能设置init的方向
setDeviceOrient = function(n)
  orient = n
  __init(n)
  nextUpdateTime = os.time() + 1
end
init = setDeviceOrient
end
end

do
local _ENV = _ENV
package.preload[ "EventQuery" ] = function( ... ) local arg = _G.arg;
local sz
local socket

-- get the time
local gettimeFunc = function()
  return os.time() * 1000
end
-- sleep
local mSleep = mSleep

-- for touchsprite socket
local _ = (function()
  local pcallRes = pcall(function()
    sz = require 'sz'
    socket = require 'szocket.core'
    gettimeFunc = function()
      return socket.gettime() * 1000
    end
    mSleep = mSleep or function(n)
      socket.select(nil, nil, n / 1000)
    end
  end)
  if (pcallRes) then return end
  local pcallRes2 = pcall(function()
    socket = require 'socket'
    gettimeFunc = function()
      return socket.gettime() * 1000
    end
    mSleep = mSleep or function(n)
      socket.select(nil, nil, n / 1000)
    end
  end)
end)()


-- fwGetPressedButton
-- keepScreen(true);

local function isEmpty(tab)
  for _, v in pairs(tab) do
    return false
  end
  return true
end







local function tryCatch(cb)
  return xpcall(cb, function(e)
    return stackTraceback and
      (e .. '\n' .. debug.traceback())
      or (e)
  end)
end

local function bindSelf(func, self)
  return function(...) return func(self, ...) end
end

local getEventId = (function()
  local id = 0
  return function()
    id = id + 1
    return id
  end
end)()

-- main query
local eventQuery = {}
-- sub query
local screenListenerQuery = {}
local screenListenerQueryIndex = {}
local screenListenerQueryGroup = {}
local buttonListenerQuery = {}
local buttonListenerQueryIndex = {}
local timerQuery = {}
local timerQueryIndex = {}


function getEventObj(func, time, isInterval, ms)
  return {
    id = getEventId() or 0,
    time = time or 0,
    func = func,
    isInterval = isInterval or false,
    ms = ms or 0,
    drop = false,
  }
end

function getScreenEventObj(tags, checker, func)
  return {
    id = getEventId() or 0,
    tags = tags,
    checker = checker,
    func = func,
    drop = false,
  }
end

function getButtonEventObj(btnId, func)
  return {
    id = getEventId() or 0,
    btnId = btnId,
    func = func,
    drop = false,
  }
end




function setImmediate(func)
  if (type(func) ~= 'function') then return 0 end
  local eventObj = getEventObj(func)
  table.insert(eventQuery, eventObj)
  return eventObj.id
end

function setTimeout(func, ms)
  if (type(func) ~= 'function') then return 0 end
  if ((type(ms) ~= 'number') or (ms < 4)) then ms = 4 end
  local time = gettimeFunc() + ms
  local eventObj = getEventObj(func, time)
  table.insert(timerQuery, eventObj)
  timerQueryIndex[eventObj.id] = eventObj
  return eventObj.id
end

function clearTimeout(id)
  local theEventObj = timerQueryIndex[id]
  if (theEventObj) then
    theEventObj.drop = true
    timerQueryIndex[id] = nil
  end
end

function setInterval(func, ms)
  if (type(func) ~= 'function') then return 0 end
  if ((type(ms) ~= 'number') or (ms < 4)) then ms = 4 end
  local time = gettimeFunc() + ms
  local eventObj = getEventObj(func, time, true, ms)
  table.insert(timerQuery, eventObj)
  timerQueryIndex[eventObj.id] = eventObj
  return eventObj.id
end

-- param: tags, checker, func
function setScreenListener(...)
  local args = { ... }
  local tags = {}
  if (type(args[1]) == 'table') then
    tags = table.remove(args, 1)
  elseif (type(args[1]) == 'string') then
    tags = { table.remove(args, 1) }
  end
  local checker = table.remove(args, 1)
  local func = table.remove(args, 1)


  if (type(checker) ~= 'function') then return 0 end
  if (type(func) ~= 'function') then return 0 end
  local screenEventObj = getScreenEventObj(tags, checker, func)
  table.insert(screenListenerQuery, screenEventObj)
  screenListenerQueryIndex[screenEventObj.id] = screenEventObj
  for _, tag in ipairs(tags) do
    screenListenerQueryGroup[tag] = screenListenerQueryGroup[tag] or {}
    screenListenerQueryGroup[tag][screenEventObj.id] = screenEventObj
  end
  return screenEventObj.id
end

function clearScreenListener(id)
  local theEventObj = screenListenerQueryIndex[id]
  if (theEventObj) then
    theEventObj.drop = true
    screenListenerQueryIndex[id] = nil
    for _, tag in ipairs(theEventObj.tags) do
      if (type(screenListenerQueryGroup[tag]) == 'table') then
        screenListenerQueryGroup[tag][theEventObj.id] = nil
        if (isEmpty(screenListenerQueryGroup[tag])) then
          screenListenerQueryGroup[tag] = nil
        end
      end
    end
  end
end

function clearScreenListenerByTags(tags)
  if (type(tags) ~= 'table') then
    tags = { tags }
  end
  for _, tag in pairs(tags) do
    local tagsEventObj = screenListenerQueryGroup[tag]
    if (type(tagsEventObj) == 'table') then
      for _, eventObj in pairs(tagsEventObj) do
        eventObj.drop = true
        screenListenerQueryIndex[eventObj.id] = nil
      end
    end
    screenListenerQueryGroup[tag] = nil
  end
end

function setButotnListener(btnId, func)
  if (type(func) ~= 'function') then return 0 end
  local btnEventObj = getButtonEventObj(btnId, func)
  table.insert(buttonListenerQuery, btnEventObj)
  buttonListenerQueryIndex[btnEventObj.id] = btnEventObj
  return btnEventObj.id
end

function clearButotnListener(id)
  local theEventObj = buttonListenerQueryIndex[id]
  if (theEventObj) then
    theEventObj.drop = true
    buttonListenerQueryIndex[id] = nil
  end
end

function clearListenersOnButton(btnId)
  for key, value in ipairs(buttonListenerQuery) do
    if (value.btnId ~= btnId) then
      value.drop = true
      buttonListenerQueryIndex[value.id] = nil
    end
  end
end

function run()
  local continue = 0
  local thisTime = 0
  local sleepTime = 3600000


  repeat
    continue = 0
    sleepTime = 3600000

    -- run eventQuery
    for key, value in ipairs(eventQuery) do
      value.func()
      -- setInterval event
    end
    eventQuery = {}


    -- read event from other Query
    thisTime = gettimeFunc()

    -- timeQuery
    if (#timerQuery > 0) then
      continue = continue + 1
      local newTimeQuery = {}
      for key, value in ipairs(timerQuery) do
        if (not value.drop) then
          if (value.time <= thisTime) then
            table.insert(eventQuery, value)

            -- setInterval event
            if (value.isInterval) then
              repeat
                value.time = value.time + value.ms
              until (value.time > thisTime)
              sleepTime = math.min(sleepTime, value.time)
              table.insert(newTimeQuery, value)
            end
          else
            sleepTime = math.min(sleepTime, value.time)
            table.insert(newTimeQuery, value)
          end
        end
      end
      timerQuery = newTimeQuery
      newTimeQuery = nil
    end

    -- screenListenerQuery
    if (#screenListenerQuery > 0) then
      if (type(getDeviceOrient) == 'function') then getDeviceOrient() end
      local hasDropEvent = false
      continue = continue + 1
      sleepTime = math.min(sleepTime, 200)
      keepScreen(true);
      for key, value in ipairs(screenListenerQuery) do
        if (not value.drop) then
          if (value.checker()) then
            table.insert(eventQuery, value)
            if (value.isOnce) then
              value.drop = true
              hasDropEvent = true
            end
          end
        else
          hasDropEvent = true
        end
      end

      if (hasDropEvent) then
        local newScreenListenerQuery = {}
        for key, value in ipairs(screenListenerQuery) do
          if (not value.drop) then
            table.insert(newScreenListenerQuery, value)
          end
        end
        screenListenerQuery = newScreenListenerQuery
      end
      keepScreen(false);
    end

    -- buttonListenerQuery
    if (#buttonListenerQuery > 0) then
      sleepTime = math.min(sleepTime, 200)
      continue = continue + 1
      local btnIdList = {}
      local hasBtnClick = false
      local hasDropEvent = false
      while (true) do
        local btnId = fwGetPressedButton()
        if (type(btnId) ~= 'string') then break end
        btnIdList[btnId] = btnId
        hasBtnClick = true
      end
      if (hasBtnClick) then
        for key, value in ipairs(buttonListenerQuery) do
          if (not value.drop) then
            if (btnIdList[value.btnId] == value.btnId) then
              table.insert(eventQuery, value)
            end
          else
            hasDropEvent = true
          end
        end

        if (hasDropEvent) then
          local newButtonListenerQuery = {}
          for key, value in ipairs(buttonListenerQuery) do
            if (not value.drop) then
              table.insert(newButtonListenerQuery, value)
            end
          end
          buttonListenerQuery = newButtonListenerQuery
        end
      end
    end

    if (luaExisted) then
      break
    end

    if (#eventQuery <= 0) then
      mSleep(sleepTime)
    end
  until (false)
end

return {
  setImmediate = setImmediate,
  setTimeout = setTimeout,
  clearTimeout = clearTimeout,
  setInterval = setInterval,
  clearInterval = clearTimeout,
  setScreenListener = setScreenListener,
  clearScreenListener = clearScreenListener,
  clearScreenListenerByTags = clearScreenListenerByTags,
  setButotnListener = setButotnListener,
  clearListenersOnButton = clearListenersOnButton,
  clearButotnListener = clearButotnListener,
  run = run,
}
end
end

do
local _ENV = _ENV
package.preload[ "GoMission" ] = function( ... ) local arg = _G.arg;
local co = require 'Co'
local pauseFactory = require 'GoMission__pause'
local battleFactory = require 'GoMission__battle'
local homeFactory = require 'GoMission__home'

-- 运行时的变量，全局共享
local stateTree = require 'GoMission__stateTree'
-- 保存整个GoMission共享的参数
local allOptions = require 'GoMission__options'

local c = coroutine






-- 将分散在各个文件的任务集合到一起
local missions = {
  battle = battleFactory(stateTree),
  home = homeFactory(stateTree),
}

return {
  init = function(map, settings)
    -- 定义需要全局监听状态
    allOptions.map = map
    allOptions.settings = settings

    return missions
  end,
  next = function(action, state)
    state = table.assign(stateTree, state)
    return co(c.create(function()
      for key, item in pairs(missions) do
        local newAction, newState = c.yield(item(action, state))
        if (newAction) then
          return newAction, newState
        end
      end
    end))
  end
}
end
end

do
local _ENV = _ENV
package.preload[ "GoMission__battle" ] = function( ... ) local arg = _G.arg;
local co = require 'Co'
local c = coroutine
local stepLabel = require 'StepLabel'
local makeAction = (require 'GoMission__utils').makeAction
local sleepPromise = (require 'GoMission__utils').sleepPromise
local setScreenListeners = (require 'GoMission__utils').setScreenListeners
local allOptions = require 'GoMission__options'
local getHomeListener = (require 'GoMission__commonListener').getHomeListener
local getLoginListener = (require 'GoMission__commonListener').getLoginListener
local getComListener = (require 'GoMission__commonListener').getComListener


local battleOnce = function(action, state)
  local map = allOptions.map
  local settings = allOptions.settings

  return co(c.create(function()
    if (action.type == 'BATTLE_START') then

      state.battle.selectFleedCount = 0
      -- boss舰队是否在boss区域
      state.battle.isBossFleetInBossArea = false
      state.battle.battleNum = 0
      state.battle.battleWithConvoyNum = 0
      state.battle.battleFromState = ''
      -- 切换船的次数，如果超过4次没切换成功表示舰队沉了。
      state.battle.changeFleetNum = 0

      if (#settings.battleChapter < 1) then
        stepLabel.setStepLabelContent('2-1.没有选中章节')
        return nil, state
      end

      stepLabel.setStepLabelContent('2-2.等待HOME')
      local newstateTypes = c.yield(setScreenListeners({
        { 'BATTLE_HOME_CLICK_BATTLE', 'missionsGroup', map.home.isHome },
        { 'BATTLE_IN_BATTLE_PAGE', 'missionsGroup', map.battle.isInBattlePage, 2000 },
        { 'BATTLE_VICTORY_PANEL', 'missionsGroup', map.battle.isVictoryPanel, 2000 },
        { 'BATTLE_GET_PROPS_PANEL', 'missionsGroup', map.battle.isGetPropsPanel, 2000 },
        { 'BATTLE_GET_NEW_SHIP_PANEL', 'missionsGroup', map.battle.isGetNewShipPanel, 2000 },
        { 'BATTLE_GET_EXP_PANEL', 'missionsGroup', map.battle.isGetExpPanel, 2000 },
        { 'BATTLE_MAP_PAGE_MOVE_TO_CENTER', 'missionsGroup', map.battle.isMapPage, 2000 },
        { 'BATTLE_URGENT_ENTRUSTMENT_PANEL', 'missionsGroup', map.battle.isUrgentEntrustmentPanel, 2000 },
      }))
      return makeAction(newstateTypes), state

    elseif (action.type == 'BATTLE_HOME_CLICK_BATTLE') then

      stepLabel.setStepLabelContent('2-3.点击出征')
      map.home.clickBattleBtn()
      stepLabel.setStepLabelContent('2-4.等待出征页面')

      local newstateTypes = c.yield(setScreenListeners({
        { 'BATTLE_HOME_CLICK_BATTLE', 'missionsGroup', map.home.isHome, 2000 },
        { 'BATTLE_BATTLE_PAGE', 'missionsGroup', map.battle.isBattlePage },
        { 'BATTLE_MAP_PAGE_MOVE_TO_CENTER', 'missionsGroup', map.battle.isMapPage, 2000 },
      }))
      return makeAction(newstateTypes), state

    elseif (action.type == 'BATTLE_BATTLE_PAGE') then

      if (#settings.battleChapter > 1) then
        state.battle.battleChapter = table.remove(settings.battleChapter, 1)
        table.insert(settings.battleChapter, state.battle.battleChapter)
      else
        state.battle.battleChapter = settings.battleChapter[1]
      end

      stepLabel.setStepLabelContent('2-5.移动到章节' .. state.battle.battleChapter)
      map.battle.moveToChapter(state.battle.battleChapter)
      c.yield(sleepPromise(1000))

      local newstateTypes = c.yield(setScreenListeners({
        { 'BATTLE_BATTLE_PAGE', 'missionsGroup', map.battle.isBattlePage, 2000 },
        { 'BATTLE_CHAPTER_INFO_PANEL', 'missionsGroup', map.battle.isChapterInfoPanel },
        { 'BATTLE_SELECT_FLEET_PANEL', 'missionsGroup', map.battle.isSelectFleetPanel },
      }))
      return makeAction(newstateTypes), state

    elseif (action.type == 'BATTLE_CHAPTER_INFO_PANEL') then

      stepLabel.setStepLabelContent('2-6.章节信息面板')
      stepLabel.setStepLabelContent('2-7.进入章节')
      map.battle.clickGotoSelectFleedPanelBtn()

      local newstateTypes = c.yield(setScreenListeners({
        { 'BATTLE_BATTLE_PAGE', 'missionsGroup', map.battle.isBattlePage, 2000 },
        { 'BATTLE_CHAPTER_INFO_PANEL', 'missionsGroup', map.battle.isChapterInfoPanel, 2000 },
        { 'BATTLE_SELECT_FLEET_PANEL_CHECKE_SELECTED_FLEET', 'missionsGroup', map.battle.isSelectFleetPanel },
      }))
      return makeAction(newstateTypes), state

    elseif (action.type == 'BATTLE_SELECT_FLEET_PANEL_CHECKE_SELECTED_FLEET') then

      state.battle.selectFleedCount = state.battle.selectFleedCount + 1

      stepLabel.setStepLabelContent('2-8.检测已经选择的舰队')
      local res, selectList, unselectList = map.battle.checkSelectedFleet(settings.battleFleet)
      if not res then
        stepLabel.setStepLabelContent('2-9.选择舰队 ' .. table.concat(settings.battleFleet, ','))
        map.battle.clickFleet(selectList)
        map.battle.clickFleet(unselectList)
        local newstateTypes = c.yield(setScreenListeners({
          { 'BATTLE_BATTLE_PAGE', 'missionsGroup', map.battle.isBattlePage, 2000 },
          { 'BATTLE_CHAPTER_INFO_PANEL', 'missionsGroup', map.battle.isChapterInfoPanel, 2000 },
          { 'BATTLE_SELECT_FLEET_PANEL_CHECKE_SELECTED_FLEET', 'missionsGroup', map.battle.isSelectFleetPanel },
        }))
        return makeAction(newstateTypes), state
      end

      stepLabel.setStepLabelContent('2-10.已选择舰队' .. table.concat(settings.battleFleet, ','))
      map.battle.clickGotoMapBtn()
      local newstateTypes = c.yield(setScreenListeners({
        { 'BATTLE_BATTLE_PAGE', 'missionsGroup', map.battle.isBattlePage, 2000 },
        { 'BATTLE_CHAPTER_INFO_PANEL', 'missionsGroup', map.battle.isChapterInfoPanel, 2000 },
        { 'BATTLE_SELECT_FLEET_PANEL_CHECKE_SELECTED_FLEET', 'missionsGroup', map.battle.isSelectFleetPanel, 2000 },
        { 'BATTLE_MAP_PAGE_MOVE_TO_CENTER', 'missionsGroup', map.battle.isMapPage },
      }))
      return makeAction(newstateTypes), state

    elseif (action.type == 'BATTLE_MAP_PAGE_MOVE_TO_CENTER') then

      c.yield(sleepPromise(500))
      stepLabel.setStepLabelContent('2-11.移动地图到屏幕中心')
      local isCenter = map.battle.moveMapToCenter()
      if (isCenter) then
        local newstateTypes = c.yield(setScreenListeners({
          { 'BATTLE_MAP_PAGE_MOVE_A_STEP', 'missionsGroup', map.battle.isMapPage },
          { 'BATTLE_MAP_PAGE_AMBUSHED_PANEL', 'missionsGroup', map.battle.isAmbushedPanel },
          { 'BATTLE_MAP_PAGE_READY_BATTLE_PAGE', 'missionsGroup', map.battle.isReadyBattlePage },
          { 'BATTLE_IS_AUTO_BATTLE_CONFIRM_PANEL', 'missionsGroup', map.battle.isAutoBattleConfirmPanel },
        }))
        return makeAction(newstateTypes), state
      end

      local newstateTypes = c.yield(setScreenListeners({
        { 'BATTLE_MAP_PAGE_MOVE_TO_CENTER', 'missionsGroup', map.battle.isMapPage },
        { 'BATTLE_MAP_PAGE_AMBUSHED_PANEL', 'missionsGroup', map.battle.isAmbushedPanel },
        { 'BATTLE_MAP_PAGE_READY_BATTLE_PAGE', 'missionsGroup', map.battle.isReadyBattlePage },
        { 'BATTLE_IS_AUTO_BATTLE_CONFIRM_PANEL', 'missionsGroup', map.battle.isAutoBattleConfirmPanel },
      }))
      return makeAction(newstateTypes), state

    elseif (action.type == 'BATTLE_MAP_PAGE_MOVE_A_STEP') then

      if map.battle.isBossOnMap() then
        stepLabel.setStepLabelContent('2-12.移动到Boss')
        local res = map.battle.isSelectedFleed(settings.battleFleet[1])
        if (not res) and (state.battle.changeFleetNum < 4) then
          local newstateTypes = c.yield(setScreenListeners({
            { 'BATTLE_MAP_PAGE_SELECT_BOSS_FLEET', 'missionsGroup', map.battle.isMapPage },
          }))
          return makeAction(newstateTypes), state
        end
        stepLabel.setStepLabelContent('2-13.寻找boss')
        local bossPoint = map.battle.findBossPoint()
        if (bossPoint) then
          stepLabel.setStepLabelContent('2-14.移动到附近的敌人 ' .. table.join(bossPoint, ', ') .. ' ')
          map.battle.moveToEnemy(bossPoint)
          local newstateTypes = c.yield(setScreenListeners({
            { 'BATTLE_MAP_PAGE_MOVE_A_STEP', 'missionsGroup', map.battle.isMapPage, 3000 },
            { 'BATTLE_MAP_PAGE_AMBUSHED_PANEL', 'missionsGroup', map.battle.isAmbushedPanel },
            { 'BATTLE_MAP_PAGE_READY_BATTLE_PAGE', 'missionsGroup', map.battle.isReadyBattlePage },
          }))
          return makeAction(newstateTypes), state
        end

      elseif state.battle.isBossFleetInBossArea or map.battle.isFleetOnBossArea() then

        state.battle.isBossFleetInBossArea = true
        stepLabel.setStepLabelContent('2-15.切换小兵舰队')
        if (settings.battleFleet[2] > 0) and (not map.battle.isSelectedFleed(settings.battleFleet[2])) and (state.battle.changeFleetNum < 4) then
          local newstateTypes = c.yield(setScreenListeners({
            { 'BATTLE_MAP_PAGE_SELECT_SOLDIER_FLEET', 'missionsGroup', map.battle.isMapPage },
            { 'BATTLE_MAP_PAGE_AMBUSHED_PANEL', 'missionsGroup', map.battle.isAmbushedPanel },
            { 'BATTLE_MAP_PAGE_READY_BATTLE_PAGE', 'missionsGroup', map.battle.isReadyBattlePage },
          }))
          return makeAction(newstateTypes), state
        end

        stepLabel.setStepLabelContent('2-16.寻找最近的敌人')
        local enemyPoint = map.battle.findNearEnemyPointList()
        if (enemyPoint) then
          stepLabel.setStepLabelContent('2-17.移动到附近的敌人 ' .. table.join(enemyPoint, ', ') .. ' ')
          map.battle.moveToEnemy(enemyPoint)
          local newstateTypes = c.yield(setScreenListeners({
            { 'BATTLE_MAP_PAGE_MOVE_A_STEP', 'missionsGroup', map.battle.isMapPage, 3000 },
            { 'BATTLE_MAP_PAGE_AMBUSHED_PANEL', 'missionsGroup', map.battle.isAmbushedPanel },
            { 'BATTLE_MAP_PAGE_READY_BATTLE_PAGE', 'missionsGroup', map.battle.isReadyBattlePage },
          }))
          return makeAction(newstateTypes), state
        end

        local newstateTypes = c.yield(setScreenListeners({
          { 'BATTLE_MAP_PAGE_MOVE_A_STEP', 'missionsGroup', map.battle.isMapPage, 2000 },
          { 'BATTLE_MAP_PAGE_AMBUSHED_PANEL', 'missionsGroup', map.battle.isAmbushedPanel },
          { 'BATTLE_MAP_PAGE_READY_BATTLE_PAGE', 'missionsGroup', map.battle.isReadyBattlePage },
        }))
        return makeAction(newstateTypes), state

      else

        stepLabel.setStepLabelContent('2-18.切换boss舰队')
        local res = map.battle.isSelectedFleed(settings.battleFleet[1])
        if (not res) and (state.battle.changeFleetNum < 4) then
          local newstateTypes = c.yield(setScreenListeners({
            { 'BATTLE_MAP_PAGE_SELECT_BOSS_FLEET', 'missionsGroup', map.battle.isMapPage },
            { 'BATTLE_MAP_PAGE_AMBUSHED_PANEL', 'missionsGroup', map.battle.isAmbushedPanel },
            { 'BATTLE_MAP_PAGE_READY_BATTLE_PAGE', 'missionsGroup', map.battle.isReadyBattlePage },
          }))
          return makeAction(newstateTypes), state
        end
        stepLabel.setStepLabelContent('2-19.移动到Boss区域')
        map.battle.clickToMapBossArea()
        local newstateTypes = c.yield(setScreenListeners({
          { 'BATTLE_MAP_PAGE_MOVE_A_STEP', 'missionsGroup', map.battle.isMapPage, 2000 },
          { 'BATTLE_MAP_PAGE_AMBUSHED_PANEL', 'missionsGroup', map.battle.isAmbushedPanel },
          { 'BATTLE_MAP_PAGE_READY_BATTLE_PAGE', 'missionsGroup', map.battle.isReadyBattlePage },
        }))
        return makeAction(newstateTypes), state
      end

    elseif (action.type == 'BATTLE_MAP_PAGE_SELECT_BOSS_FLEET') then

      stepLabel.setStepLabelContent('2-20.选择boss舰队' .. settings.battleFleet[1])
      map.battle.clickSwitchFleetBtn()
      local res = map.battle.isSelectedFleed(settings.battleFleet[1])
      if (not res) and (state.battle.changeFleetNum < 4) then
        state.battle.changeFleetNum = state.battle.changeFleetNum + 1
        stepLabel.setStepLabelContent('2-21.选择boss舰队失败，再来一次')
        local newstateTypes = c.yield(setScreenListeners({
          { 'BATTLE_MAP_PAGE_SELECT_BOSS_FLEET', 'missionsGroup', map.battle.isMapPage },
        }))
        return makeAction(newstateTypes), state
      end
      local newstateTypes = c.yield(setScreenListeners({
        { 'BATTLE_MAP_PAGE_MOVE_TO_CENTER', 'missionsGroup', map.battle.isMapPage },
      }))
      return makeAction(newstateTypes), state

    elseif (action.type == 'BATTLE_MAP_PAGE_SELECT_SOLDIER_FLEET') then

      stepLabel.setStepLabelContent('2-22.选择小兵舰队' .. settings.battleFleet[2])
      map.battle.clickSwitchFleetBtn()
      local res = map.battle.isSelectedFleed(settings.battleFleet[2])
      if (not res) and (state.battle.changeFleetNum < 4) then
        state.battle.changeFleetNum = state.battle.changeFleetNum + 1
        stepLabel.setStepLabelContent('2-23.选择小兵舰队失败，再来一次')
        local newstateTypes = c.yield(setScreenListeners({
          { 'BATTLE_MAP_PAGE_SELECT_SOLDIER_FLEET', 'missionsGroup', map.battle.isMapPage },
        }))
        return makeAction(newstateTypes), state
      end
      local newstateTypes = c.yield(setScreenListeners({
        { 'BATTLE_MAP_PAGE_MOVE_TO_CENTER', 'missionsGroup', map.battle.isMapPage },
      }))
      return makeAction(newstateTypes), state

    elseif (action.type == 'BATTLE_MAP_PAGE_AMBUSHED_PANEL') then

      state.battle.battleFromState = 'BATTLE_MAP_PAGE_AMBUSHED_PANEL'
      stepLabel.setStepLabelContent('2-24.伏击面板')
      map.battle.ambushedPanelClickAvoidBtn()
      local newstateTypes = c.yield(setScreenListeners({
        { 'BATTLE_MAP_PAGE_AMBUSHED_PANEL', 'missionsGroup', map.battle.isAmbushedPanel, 2000 },
        { 'BATTLE_MAP_PAGE_MOVE_A_STEP', 'missionsGroup', map.battle.isMapPage, 2000 },
        { 'BATTLE_MAP_PAGE_READY_BATTLE_PAGE', 'missionsGroup', map.battle.isReadyBattlePage },
      }))
      return makeAction(newstateTypes), state

    elseif (action.type == 'BATTLE_MAP_PAGE_READY_BATTLE_PAGE') then

      if state.battle.battleFromState ~= 'BATTLE_MAP_PAGE_AMBUSHED_PANEL' then
        state.battle.battleFromState = ''
        state.battle.battleWithConvoyNum = state.battle.battleWithConvoyNum + 1
      end
      state.battle.battleNum = state.battle.battleNum + 1
      stepLabel.setStepLabelContent('2-25.准备战斗页面')
      map.battle.readyBattlePageClickBattle()
      local newstateTypes = c.yield(setScreenListeners({
        { 'BATTLE_MAP_PAGE_AMBUSHED_PANEL', 'missionsGroup', map.battle.isAmbushedPanel, 2000 },
        { 'BATTLE_MAP_PAGE_MOVE_A_STEP', 'missionsGroup', map.battle.isMapPage, 2000 },
        { 'BATTLE_IN_BATTLE_PAGE', 'missionsGroup', map.battle.isInBattlePage, 2000 },
        { 'BATTLE_AUTO_BATTLE_PANEL', 'missionsGroup', map.battle.isAutoBattle, 2000 },
        { 'BATTLE_VICTORY_PANEL', 'missionsGroup', map.battle.isVictoryPanel, 2000 },
        { 'BATTLE_GET_PROPS_PANEL', 'missionsGroup', map.battle.isGetPropsPanel, 2000 },
        { 'BATTLE_GET_NEW_SHIP_PANEL', 'missionsGroup', map.battle.isGetNewShipPanel, 2000 },
        { 'BATTLE_GET_EXP_PANEL', 'missionsGroup', map.battle.isGetExpPanel, 2000 },
      }))
      return makeAction(newstateTypes), state

    elseif (action.type == 'BATTLE_AUTO_BATTLE_PANEL') then

      stepLabel.setStepLabelContent('2-26.自动战斗提示面板')
      map.battle.inBattlePageClickAutoBattle()
      local newstateTypes = c.yield(setScreenListeners({
        { 'BATTLE_MAP_PAGE_AMBUSHED_PANEL', 'missionsGroup', map.battle.isAmbushedPanel, 2000 },
        { 'BATTLE_MAP_PAGE_MOVE_A_STEP', 'missionsGroup', map.battle.isMapPage, 2000 },
        { 'BATTLE_IN_BATTLE_PAGE', 'missionsGroup', map.battle.isInBattlePage },
        { 'BATTLE_VICTORY_PANEL', 'missionsGroup', map.battle.isVictoryPanel, 2000 },
        { 'BATTLE_GET_PROPS_PANEL', 'missionsGroup', map.battle.isGetPropsPanel, 2000 },
        { 'BATTLE_GET_NEW_SHIP_PANEL', 'missionsGroup', map.battle.isGetNewShipPanel, 2000 },
        { 'BATTLE_GET_EXP_PANEL', 'missionsGroup', map.battle.isGetExpPanel, 2000 },
      }))
      return makeAction(newstateTypes), state

    elseif (action.type == 'BATTLE_IN_BATTLE_PAGE') then

      stepLabel.setStepLabelContent('2-27.进入战斗页面')
      stepLabel.setStepLabelContent('2-28.检测是否自动战斗')
      local isAutoBattle = map.battle.isAutoBattle()
      if (not isAutoBattle) then
        map.battle.inBattlePageClickAutoBattle()
      end
      stepLabel.setStepLabelContent('2-29.等待胜利界面')
      local newstateTypes = c.yield(setScreenListeners({
        { 'BATTLE_IS_AUTO_BATTLE_CONFIRM_PANEL', 'missionsGroup', map.battle.isAutoBattleConfirmPanel },
        { 'BATTLE_VICTORY_PANEL', 'missionsGroup', map.battle.isVictoryPanel },
        { 'BATTLE_GET_PROPS_PANEL', 'missionsGroup', map.battle.isGetPropsPanel, 2000 },
        { 'BATTLE_GET_NEW_SHIP_PANEL', 'missionsGroup', map.battle.isGetNewShipPanel, 2000 },
        { 'BATTLE_GET_EXP_PANEL', 'missionsGroup', map.battle.isGetExpPanel, 2000 },
        { 'BATTLE_MAP_PAGE_MOVE_TO_CENTER', 'missionsGroup', map.battle.isMapPage, 2000 },
        { 'BATTLE_URGENT_ENTRUSTMENT_PANEL', 'missionsGroup', map.battle.isUrgentEntrustmentPanel, 2000 },
      }))
      return makeAction(newstateTypes), state

    elseif (action.type == 'BATTLE_IS_AUTO_BATTLE_CONFIRM_PANEL') then

      stepLabel.setStepLabelContent('2-30.自动战斗确认面板点击确定')
      map.battle.isAutoBattleConfirmPanelClickOk()
      local newstateTypes = c.yield(setScreenListeners({
        { 'BATTLE_IS_AUTO_BATTLE_CONFIRM_PANEL', 'missionsGroup', map.battle.isAutoBattleConfirmPanel },
        { 'BATTLE_VICTORY_PANEL', 'missionsGroup', map.battle.isVictoryPanel },
        { 'BATTLE_GET_PROPS_PANEL', 'missionsGroup', map.battle.isGetPropsPanel, 2000 },
        { 'BATTLE_GET_NEW_SHIP_PANEL', 'missionsGroup', map.battle.isGetNewShipPanel, 2000 },
        { 'BATTLE_GET_EXP_PANEL', 'missionsGroup', map.battle.isGetExpPanel, 2000 },
        { 'BATTLE_MAP_PAGE_MOVE_TO_CENTER', 'missionsGroup', map.battle.isMapPage, 2000 },
        { 'BATTLE_URGENT_ENTRUSTMENT_PANEL', 'missionsGroup', map.battle.isUrgentEntrustmentPanel, 2000 },
      }))
      return makeAction(newstateTypes), state

    elseif (action.type == 'BATTLE_VICTORY_PANEL') then

      stepLabel.setStepLabelContent('2-31.胜利面板点击继续')
      map.battle.victoryPanelClickNext()
      local newstateTypes = c.yield(setScreenListeners({
        { 'BATTLE_VICTORY_PANEL', 'missionsGroup', map.battle.isVictoryPanel, 2000 },
        { 'BATTLE_GET_PROPS_PANEL', 'missionsGroup', map.battle.isGetPropsPanel },
        { 'BATTLE_GET_NEW_SHIP_PANEL', 'missionsGroup', map.battle.isGetNewShipPanel },
        { 'BATTLE_GET_EXP_PANEL', 'missionsGroup', map.battle.isGetExpPanel },
        { 'BATTLE_MAP_PAGE_MOVE_TO_CENTER', 'missionsGroup', map.battle.isMapPage, 4000 },
        { 'BATTLE_URGENT_ENTRUSTMENT_PANEL', 'missionsGroup', map.battle.isUrgentEntrustmentPanel, 2000 },
        { 'BATTLE_CHAPTER_BACK_TO_HOME', 'missionsGroup', map.battle.isBattlePage, 4000 },
      }))
      return makeAction(newstateTypes), state

    elseif (action.type == 'BATTLE_GET_PROPS_PANEL') then

      stepLabel.setStepLabelContent('2-32.获得道具面板')
      map.battle.getNewShipPanelClickNext()
      local newstateTypes = c.yield(setScreenListeners({
        { 'BATTLE_VICTORY_PANEL', 'missionsGroup', map.battle.isVictoryPanel, 2000 },
        { 'BATTLE_GET_PROPS_PANEL', 'missionsGroup', map.battle.isGetPropsPanel, 2000 },
        { 'BATTLE_GET_NEW_SHIP_PANEL', 'missionsGroup', map.battle.isGetNewShipPanel },
        { 'BATTLE_GET_EXP_PANEL', 'missionsGroup', map.battle.isGetExpPanel },
        { 'BATTLE_MAP_PAGE_MOVE_TO_CENTER', 'missionsGroup', map.battle.isMapPage, 4000 },
        { 'BATTLE_URGENT_ENTRUSTMENT_PANEL', 'missionsGroup', map.battle.isUrgentEntrustmentPanel, 2000 },
        { 'BATTLE_CHAPTER_BACK_TO_HOME', 'missionsGroup', map.battle.isBattlePage, 4000 },
      }))
      return makeAction(newstateTypes), state

    elseif (action.type == 'BATTLE_GET_NEW_SHIP_PANEL') then

      stepLabel.setStepLabelContent('2-33.获得新船面板')
      map.battle.getNewShipPanelClickNext()
      local newstateTypes = c.yield(setScreenListeners({
        { 'BATTLE_VICTORY_PANEL', 'missionsGroup', map.battle.isVictoryPanel, 2000 },
        { 'BATTLE_GET_PROPS_PANEL', 'missionsGroup', map.battle.isGetPropsPanel, 2000 },
        { 'BATTLE_GET_NEW_SHIP_PANEL', 'missionsGroup', map.battle.isGetNewShipPanel, 2000 },
        { 'BATTLE_GET_EXP_PANEL', 'missionsGroup', map.battle.isGetExpPanel },
        { 'BATTLE_MAP_PAGE_MOVE_TO_CENTER', 'missionsGroup', map.battle.isMapPage, 4000 },
        { 'BATTLE_URGENT_ENTRUSTMENT_PANEL', 'missionsGroup', map.battle.isUrgentEntrustmentPanel, 2000 },
        { 'BATTLE_CHAPTER_BACK_TO_HOME', 'missionsGroup', map.battle.isBattlePage, 4000 },
      }))
      return makeAction(newstateTypes), state

    elseif (action.type == 'BATTLE_GET_EXP_PANEL') then

      stepLabel.setStepLabelContent('2-34.获得经验面板')
      map.battle.getExpPanelClickNext()
      local newstateTypes = c.yield(setScreenListeners({
        { 'BATTLE_VICTORY_PANEL', 'missionsGroup', map.battle.isVictoryPanel, 2000 },
        { 'BATTLE_GET_PROPS_PANEL', 'missionsGroup', map.battle.isGetPropsPanel, 2000 },
        { 'BATTLE_GET_NEW_SHIP_PANEL', 'missionsGroup', map.battle.isGetNewShipPanel },
        { 'BATTLE_GET_EXP_PANEL', 'missionsGroup', map.battle.isGetExpPanel, 2000 },
        { 'BATTLE_MAP_PAGE_MOVE_TO_CENTER', 'missionsGroup', map.battle.isMapPage, 4000 },
        { 'BATTLE_URGENT_ENTRUSTMENT_PANEL', 'missionsGroup', map.battle.isUrgentEntrustmentPanel, 2000 },
        { 'BATTLE_CHAPTER_BACK_TO_HOME', 'missionsGroup', map.battle.isBattlePage, 4000 },
        { '', 'missionsGroup', map.home.isHome },
      }))

      return makeAction(newstateTypes), state

    elseif (action.type == 'BATTLE_URGENT_ENTRUSTMENT_PANEL') then

      stepLabel.setStepLabelContent('2-35紧急委托通知')
      map.battle.urgentEntrustmentPanelClickOk()
      local newstateTypes = c.yield(setScreenListeners({
        { 'BATTLE_URGENT_ENTRUSTMENT_PANEL', 'missionsGroup', map.battle.isUrgentEntrustmentPanel, 2000 },
        { 'BATTLE_MAP_PAGE_MOVE_TO_CENTER', 'missionsGroup', map.battle.isMapPage, 4000 },
        { 'BATTLE_CHAPTER_BACK_TO_HOME', 'missionsGroup', map.battle.isBattlePage },
        { '', 'missionsGroup', map.home.isHome },
      }))
      return makeAction(newstateTypes), state

    elseif (action.type == 'BATTLE_CHAPTER_BACK_TO_HOME') then

      stepLabel.setStepLabelContent('2-36.返回HOME')
      map.battle.battlePageClickBackToHome()
      local newstateTypes = c.yield(setScreenListeners({
        { 'BATTLE_CHAPTER_BACK_TO_HOME', 'missionsGroup', map.battle.isBattlePage, 2000 },
        { '', 'missionsGroup', map.home.isHome },
      }))
      return makeAction(newstateTypes), state
    end

    return nil, state
  end))
end

return function(state)
  state.battle = {}
  return battleOnce
end
end
end

do
local _ENV = _ENV
package.preload[ "GoMission__commonListener" ] = function( ... ) local arg = _G.arg;
local allOptions = require 'GoMission__options'

local getComListener = function()
  local map = allOptions.map
  local settings = allOptions.settings

  return {
    { { type = 'NETWORK_NETWORK_FAILURE_MODAL', addToStart = true }, 'homeGroup', map.network.isNetworkFailureModal, 6000 },
    { { type = 'NETWORK_CHECK_NETWORK_MODAL', addToStart = true }, 'homeGroup', map.network.isCheckNetworkModal, 6000 },
    { 'LOGIN_START_APP', 'homeGroup', map.login.isAppNotRun, 20000 },
    -- 5分钟界面不变化则重启游戏
    { 'LOGIN_START_APP', 'homeGroup', function() return true end, settings.restartInterval * 1000 },
    --        { { type = 'PAUSE_PAUSE', addToStart = true }, 'homeGroup', map.home.isPause },
  }
end
local getHomeListener = function()
  local map = allOptions.map
  local settings = allOptions.settings

  return {
    { 'HOME_HOME', 'homeGroup', map.home.isHome, 2000 },
    { { type = 'HOME_MEDAL_MODAL', addToStart = true }, 'homeGroup', map.home.isMedalModal, 6000 },
    { { type = 'HOME_NEWS_MODAL', addToStart = true }, 'homeGroup', map.home.isNewsModal, 6000 },
    { { type = 'HOME_SIGN_MODAL', addToStart = true }, 'homeGroup', map.home.isSignModal, 6000 },
  }
end

local getLoginListener = function()
  local map = allOptions.map
  local settings = allOptions.settings

  return {
    { { type = 'LOGIN_SELECT_SERVER', addToStart = true }, 'loginGroup', map.login.isSelectServerPage, 6000 },
  }
end

return {
  getComListener = getComListener,
  getHomeListener = getHomeListener,
  getLoginListener = getLoginListener,
}
end
end

do
local _ENV = _ENV
package.preload[ "GoMission__home" ] = function( ... ) local arg = _G.arg;
local co = require 'Co'
local c = coroutine
local stepLabel = require 'StepLabel'
local makeAction = (require 'GoMission__utils').makeAction
local sleepPromise = (require 'GoMission__utils').sleepPromise
local setScreenListeners = (require 'GoMission__utils').setScreenListeners
local allOptions = require 'GoMission__options'


local home = function(action, state)
  local map = allOptions.map
  local settings = allOptions.settings

  return co(c.create(function()
    if (action.type == 'HOME_HOME') then

      return nil, state

    elseif (action.type == 'HOME_MEDAL_MODAL') then

      stepLabel.setStepLabelContent('1-2勋章取消')
      map.home.clickMedalModalCancelBtn()
      c.yield(sleepPromise(2000))
      local res = map.home.isMedalModal()
      if (res) then
        return makeAction('HOME_MEDAL_MODAL'), state
      end
      return nil, state

    elseif (action.type == 'HOME_NEWS_MODAL') then

      stepLabel.setStepLabelContent('1-3.关闭新闻')
      map.home.clickMewsModalClose()
      c.yield(sleepPromise(2000))
      local res = map.home.isNewsModal()
      if (res) then
        return makeAction('HOME_NEWS_MODAL'), state
      end
      return nil, state

    elseif (action.type == 'HOME_SIGN_MODAL') then

      stepLabel.setStepLabelContent('1-4.获取签到奖励')
      local res = map.home.isSignModalHasReward()
      if (res) then
        stepLabel.setStepLabelContent('1-5.有奖励，点击获取')
        map.home.clickSignModalGetReward()
        stepLabel.setStepLabelContent('1-6.等待获取确认')
        local newstateTypes = c.yield(setScreenListeners({
          { 'HOME_SIGN_CONFIRM_MODAL', 'missionsGroup', map.home.isSignConfirmModal },
          { 'HOME_SIGN_MODAL', 'missionsGroup', map.home.isSignModal, 2000 },
        }))
        return makeAction(newstateTypes), state
      else
        stepLabel.setStepLabelContent('1-7.没有奖励')
        map.home.clickSignModalClose()
        c.yield(sleepPromise(2000))
        local res = map.home.isSignModal()
        if (res) then
          return makeAction('HOME_SIGN_MODAL'), state
        end
        return nil, state
      end

    elseif (action.type == 'HOME_SIGN_CONFIRM_MODAL') then

      stepLabel.setStepLabelContent('1-8.点击获取确认')
      map.home.clickSignConfirmModalGetReward()
      stepLabel.setStepLabelContent('1-9.等待获取签到奖励面板')
      c.yield(sleepPromise(2000))
      local newstateTypes = c.yield(setScreenListeners({
        { 'HOME_SIGN_CONFIRM_MODAL', 'missionsGroup', map.home.isSignConfirmModal, 2000 },
        { 'HOME_SIGN_MODAL', 'missionsGroup', map.home.isSignModal },
      }))
      return makeAction(newstateTypes), state
    end

    return nil
  end))
end

return function(state)
  state.home = {}

  return home
end
end
end

do
local _ENV = _ENV
package.preload[ "GoMission__options" ] = function( ... ) local arg = _G.arg;
return {
  map = {},
  settings = {},
}
end
end

do
local _ENV = _ENV
package.preload[ "GoMission__pause" ] = function( ... ) local arg = _G.arg;
local co = require 'Co'
local c = coroutine
local stepLabel = require 'StepLabel'
local makeAction = (require 'GoMission__utils').makeAction
local sleepPromise = (require 'GoMission__utils').sleepPromise
local allOptions = require 'GoMission__options'


local pause = function(action, state)
  local map = allOptions.map
  local settings = allOptions.settings

  return co(c.create(function()
    if (action.type == 'PAUSE_PAUSE') then

      state.pause.lasttext = stepLabel.getText()
      stepLabel.setPrefix('')
      stepLabel.setStepLabelContent('暂停')
      c.yield(sleepPromise(500))
      if (map.home.isPause()) then
        return makeAction('PAUSE_PAUSE_CONTINUE'), state
      else
        return nil, state
      end
    elseif (action.type == 'PAUSE_PAUSE_CONTINUE') then
      c.yield(sleepPromise(500))
      if (map.home.isPause()) then
        return makeAction('PAUSE_PAUSE_CONTINUE'), state
      else
        stepLabel.setStepLabelContent(state.pause.lasttext)
        return nil, state
      end
    end

    return nil, state
  end))
end

return function(state)
  state.pause = {}
  return pause
end
end
end

do
local _ENV = _ENV
package.preload[ "GoMission__stateTree" ] = function( ... ) local arg = _G.arg;
return {}
end
end

do
local _ENV = _ENV
package.preload[ "GoMission__utils" ] = function( ... ) local arg = _G.arg;
local eq = require 'EventQuery'
local co = require 'Co'
local Promise = require 'Promise'
local c = coroutine

local combineListener = function(target, ...)
  local sources = { ... }
  if (type(target) ~= 'table') then target = {} end
  for _, source in ipairs(sources) do
    for key, value in ipairs(source) do
      table.insert(target, value)
    end
  end
  local targetReverse = table.reverse(target)
  local resultIndex = {}
  local result = {}
  for key, value in ipairs(targetReverse) do
    if (not resultIndex[value[3]]) then
      resultIndex[value[3]] = value
      table.insert(result, value)
    end
  end

  local resultReverse = table.reverse(result)
  return resultReverse
end

local sleepPromise = function(ms)
  return Promise.new(function(resolve)
    eq.setTimeout(resolve, ms)
  end)
end

local setScreenListenerPromise = function(actionType, tags, checker)
  return Promise.new(function(resolve)
    eq.setScreenListener(tags, checker, function() resolve(actionType) end)
  end)
end

local setScreenListeners = function(theArr, ...)

  if ((type(theArr) ~= 'table') or (#theArr == 0)) then
    return Promise.resolve(nil)
  end

  theArr = table.merge(theArr, ...)

  local theArrUnique = table.uniqueLast(theArr, 3)
  for key, value in ipairs(theArrUnique) do
    value.isOnce = true
  end
  return co(c.create(function()
    local newArr = {}
    local tags = {}
    local done = false
    for key, listenerEvent in ipairs(theArrUnique) do
      if (type(listenerEvent[2]) == 'table') then
        tags = table.merge(tags, listenerEvent[2])
      else
        table.insert(tags, listenerEvent[2])
      end

      if ((type(listenerEvent[4]) == 'number') and (listenerEvent[4] > 0)) then
        table.insert(newArr, co(c.create(function()
          c.yield(sleepPromise(listenerEvent[4]))
          if (not done) then
            return c.yield(setScreenListenerPromise(listenerEvent[1], listenerEvent[2], listenerEvent[3]))
          end
          return
        end)))
      else
        table.insert(newArr, co(c.create(function()
          local res = c.yield(setScreenListenerPromise(listenerEvent[1], listenerEvent[2], listenerEvent[3]))
          done = true
          return res
        end)))
      end
    end
    local res = c.yield(Promise.race(newArr))
    eq.clearScreenListenerByTags(tags)
    return res
  end))
end

local makeAction = function(action)
  if (type(action) == 'table') then return action end
  return { type = action }
end

return {
  combineListener = combineListener,
  sleepPromise = sleepPromise,
  setScreenListenerPromise = setScreenListenerPromise,
  setScreenListeners = setScreenListeners,
  makeAction = makeAction,
}
end
end

do
local _ENV = _ENV
package.preload[ "KeepScreenHock" ] = function( ... ) local arg = _G.arg;
-- 全局函数生成，由于部分计算过程不想暴露所以用了闭包

local __tmp = (function()
  local __keepScreen = keepScreen
  keepScreen = nil
  keepScreenState = false
  keepScreen = function(...)
    keepScreenState = select(1, ...)
    return __keepScreen(...)
  end
end)()

end
end

do
local _ENV = _ENV
package.preload[ "MathLib" ] = function( ... ) local arg = _G.arg;
math.isNan = math.isNan or function(num)
  if (num ~= num) then
    return true
  end
  return false
end

math.isInf = math.isInf or function(num)
  if (num == math.huge) then
    return true
  end
  return false
end

math.trueNumber = math.trueNumber or function(num)
  if (type(num) ~= 'number') then
    return nil
  end
  if (math.isNan(num)) then
    return nil
  end
  if (math.isInf(num)) then
    return nil
  end
  return num
end
end
end

do
local _ENV = _ENV
package.preload[ "Promise" ] = function( ... ) local arg = _G.arg;
--------------------------------------------------------------------------------------
-- es2015 Promise for lua 5.1 and 5.2

--------------------------------------------------------------------------------------

local PENDING = 0
local RESOLVED = 1
local REJECTED = 2

-- 是否需要显示stack traceback里的错误信息
-- stack traceback错误信息很长，所以这个功能作为可选项
local stackTraceback = true
-- 封装了xpcall方法
function tryCatch(cb)
  return xpcall(cb, function(e)
    return stackTraceback and
      (e .. '\n' .. debug.traceback())
      or (e)
  end)
end

-- 绑定self到某个方法
function bindSelf(fn, self)
  return function(...)
    return fn(self, ...)
  end
end

-- 隔离函数，为了防止回调过多导致爆栈需要隔离回调操作
function asap(callback)
  local co = coroutine.wrap(callback)
  co()
end

-- 类
local Promise = {
  setStackTraceback = function(value)
    stackTraceback = value
  end
}

-- 类方法 （静态方法）
function Promise.new(resolver)
  if (type(resolver) ~= 'function') then
    error('Promise resolver ' .. type(resolver) .. ' is not a function')
  end

  local newPromise = {
    PromiseStatus = PENDING,
    PromiseValue = nil,
    deferreds = {},
  }
  -- promise的主要方法，这么写是为了绑定self
  newPromise.andThen = bindSelf(andThen, newPromise)
  newPromise.catch = bindSelf(catch, newPromise)

  -- 执行传入promise的方法
  resolver(bindSelf(resolve, newPromise), bindSelf(reject, newPromise))

  return newPromise
end

function Promise.isPromise(obj)
  return (type(obj) == 'table') and type(obj.andThen) == 'function'
end

--- - Promise.resolve方法相当于实例化一个Promise对象，状态变为RESOLVED
function Promise.resolve(value)
  if (Promise.isPromise(value)) then return value end
  return Promise.new(function(resolve, reject)
    resolve(value)
  end)
end

--- - Promise.reject方法相当于实例化一个Promise对象，状态变为REJECTED
function Promise.reject(value)
  return Promise.new(function(resolve, reject)
    reject(value)
  end)
end

function Promise.all(args)
  if (type(args) ~= 'table') then args = {} end
  return Promise.new(function(resolve, reject)
    if (#args == 0) then return resolve({}) end
    local remaining = #args
    local function getRes(k, value)
      if (Promise.isPromise(value)) then
        value.andThen(function(res)
          getRes(k, res)
        end, function(err)
          reject(err)
        end)
        return
      end

      args[k] = value
      remaining = remaining - 1
      if (remaining == 0) then
        resolve(args)
      end
    end

    for k, value in ipairs(args) do
      getRes(k, value)
    end
  end)
end

function Promise.race(args)
  if (type(args) ~= 'table') then args = {} end
  return Promise.new(function(resolve, reject)
    for k, v in ipairs(args) do
      Promise.resolve(v).andThen(resolve, reject)
    end
  end)
end

-- 对象方法
function resolve(self, value)
  local xpcallRes, xpcallErr = tryCatch(function()
    if (Promise.isPromise(value)) then
      doResolve(self, value.andThen, resolve, reject)
      return
    end
    self.PromiseStatus = RESOLVED
    self.PromiseValue = value
    finale(self)
  end)
  if (not xpcallRes) then
    reject(self, xpcallErr)
  end
end

function reject(self, value)
  value = value or ''
  self.PromiseStatus = REJECTED
  self.PromiseValue = value
  if (stackTraceback and (not string.find(value, '\n'))) then
    self.PromiseValue = value .. '\n' .. debug.traceback()
  end
  finale(self)
end

function Handler(onResolved, onRejected, resolve, reject)
  return {
    -- 当前promise的状态转换事件处理函数
    onResolved = type(onResolved) == 'function' and onResolved or nil,
    -- 当前promise的状态转换事件处理函数
    onRejected = type(onRejected) == 'function' and onRejected or nil,
    resolve = resolve,
    reject = reject,
  }
end

-- promise的主要方法。由于lua中then是关键字，所以用andThen取代
function andThen(self, onResolved, onRejected)
  -- then本身也会返回一个promise，实现promise链
  return Promise.new(function(resolve, reject)
    local deferred = Handler(onResolved, onRejected, resolve, reject)
    handle(self, deferred)
  end)
end


function handle(self, deferred)
  if (self.PromiseStatus == PENDING) then
    table.insert(self.deferreds, deferred)
    return
  end
  asap(function()
    local cb
    if (self.PromiseStatus == RESOLVED) then
      cb = deferred.onResolved
    else
      cb = deferred.onRejected
    end
    if (type(cb) == 'nil') then
      if (self.PromiseStatus == RESOLVED) then
        deferred.resolve(self.PromiseValue)
      else
        deferred.reject(self.PromiseValue)
      end
      return
    end

    local ret
    local xpcallRes, xpcallErr = tryCatch(function()
      -- 执行当前promise的状态转换事件处理函数
      ret = cb(self.PromiseValue)
    end)
    if (not xpcallRes) then
      -- 修改promise链表中下一个promise对象的状态为rejected
      deferred.reject(xpcallErr)
      return
    end
    -- 修改promise链表中下一个promise对象的状态为resolved
    deferred.resolve(ret)
  end)
end

-- 对状态转换事件处理函数进行封装后，再传给执行函数
function doResolve(self, andThenFn, onResolved, onRejected)
  -- done作为开关以防止fn内同时调用resolve和reject方法
  local done = false
  local xpcallRes, xpcallErr = tryCatch(function()
    andThenFn(function(value)
      if (done) then return end
      done = true
      onResolved(self, value)
    end, function(value)
      if (done) then return end
      done = true
      onRejected(self, value)
    end)
  end)
  if (not xpcallRes) then
    if (done) then return end
    done = true
    onRejected(self, xpcallErr)
  end
end

-- 移动到链表的下一个promise
function finale(self)
  local theDef = self.deferreds
  for k, v in ipairs(self.deferreds) do
    handle(self, v);
  end
  self.deferreds = {};
  if ((self.PromiseStatus == REJECTED) and (#theDef == 0)) then
    error('Uncatch error in Promise \n' .. tostring(self.PromiseValue))
  end
end

-- promise的主要方法
function catch(self, onRejected)
  -- then本身也会返回一个promise，实现promise链
  self.andThen(nil, onRejected)
end

return Promise

end
end

do
local _ENV = _ENV
package.preload[ "StepLabel" ] = function( ... ) local arg = _G.arg;
local StepLable = {
  originText = '',
  text = '',
  labelId = '',
  prefix = '',
}

fwShowWnd('steplabel', 350, 50, 300, 100, 0)

StepLable.init = function(labelId)
  StepLable.labelId = labelId
  return StepLable
end

StepLable.setPrefix = function(prefix)
  StepLable.prefix = prefix
  local finalText = StepLable.prefix .. StepLable.text
  fwShowButton('steplabel', StepLable.labelId, finalText, '90333333', '90FFFFFF', '', 7, 0, 0, 300, 100)
  return StepLable
end

StepLable.setStepLabelContent = function(text, noNLog)
  StepLable.originText = text
  if ((type(runCount) == 'number') or (type(runCode) == 'string')) then
    text = tostring(runCount) .. '.. ' .. text
  end
  StepLable.text = text
  local finalText = StepLable.prefix .. text
  fwShowButton('steplabel', StepLable.labelId, finalText, '90333333', '90FFFFFF', '', 7, 0, 0, 300, 100)
  if (not noNLog) then
    local dateStr = os.date('%Y-%m-%d %X')
    wLog('warship-girls-r-script', '[DATE] ' .. finalText);
    nLog(dateStr .. ' ' .. finalText)
  end
end


StepLable.getText = function()
  return StepLable.originText
end

return StepLable
end
end

do
local _ENV = _ENV
package.preload[ "StringLib" ] = function( ... ) local arg = _G.arg;
string.startWith = string.startWith or function(str, pattern)
  if (type(str) ~= 'string') then
    return false
  end
  if (type(pattern) ~= 'string') then
    return false
  end
  if (string.sub(str, 1, string.len(pattern)) == pattern) then
    return true
  end
  return false
end

string.endWith = string.endWith or function(str, pattern)
  if (type(str) ~= 'string') then
    return false
  end
  if (type(pattern) ~= 'string') then
    return false
  end
  if (string.sub(str, 1, (0 - string.len(pattern))) == pattern) then
    return true
  end
  return false
end
end
end

do
local _ENV = _ENV
package.preload[ "TableLib" ] = function( ... ) local arg = _G.arg;
-- table方法添加
local function runTable(tab, space)
  if (type(tab) == 'number') then
    return { tostring(tab) }
  end
  if (type(tab) == 'string') then
    return { '"' .. tab .. '"' }
  end
  if (type(tab) == 'boolean') then
    if (tab) then
      return { 'true' }
    else
      return { 'false' }
    end
  end
  if (type(tab) ~= 'table') then
    return { '(' .. type(tab) .. ')' }
  end
  if (type(space) == 'number') then
    space = string.rep(' ', space)
  end
  if (type(space) ~= 'string') then
    space = ''
  end

  local resultStrList = {}

  local newTabPairs = {}
  local tabIsArray = true
  local tabLength = 0
  local hasSubTab = false

  for k, v in ipairs(tab) do
    tabLength = k
    table.insert(newTabPairs, { k, runTable(v, space) })
    if (type(v) == 'table') then
      hasSubTab = true
    end
  end

  for k, v in pairs(tab) do
    if ((type(k) ~= 'number') or k > tabLength) then
      tabIsArray = false
      table.insert(newTabPairs, { k, runTable(v, space) })
      if (type(v) == 'table') then
        hasSubTab = true
      end
    end
  end

  if (tabIsArray) then
    local newTabArr = newTabPairs

    if (hasSubTab) then
      table.insert(resultStrList, '[')
      for k, v in ipairs(newTabArr) do
        local v2Length = getLength(v[2])
        v[2][v2Length] = v[2][v2Length] .. ','
        for k2, v2 in ipairs(v[2]) do
          table.insert(resultStrList, space .. v2)
        end
      end
      table.insert(resultStrList, ']')
    else
      local theStr = {}
      for k, v in ipairs(newTabPairs) do
        table.insert(theStr, v[2][1])
      end
      local childStr = table.concat(theStr, ', ')
      table.insert(resultStrList, '[' .. childStr .. ']')
    end
  else
    local newTabArr = newTabPairs

    table.insert(resultStrList, '{')
    for k, v in ipairs(newTabArr) do
      v[2][1] = v[1] .. ': ' .. v[2][1]
      local v2Length = getLength(v[2])
      v[2][v2Length] = v[2][v2Length] .. ','
      for k2, v2 in ipairs(v[2]) do
        table.insert(resultStrList, space .. v2 .. '')
      end
    end
    table.insert(resultStrList, '}')
  end
  return resultStrList
end

table.length = table.length or function(target)
  local length = 0
  for k, v in ipairs(target) do
    length = k
  end
  return length
end

table.isArray = table.isArray or function(tab)
  if (type(tab) ~= 'table') then
    return false
  end
  local length = table.length(tab)
  for k, v in pairs(tab) do
    if ((type(k) ~= 'number') or (k > length)) then
      return false
    end
  end
  return true
end

table.unpack = table.unpack or unpack

table.slice = table.slice or function(tab, startIndex, endIndex)
  local length = table.length(tab)
  if ((type(endIndex) == 'nil') or (endIndex == 0)) then
    endIndex = length
  end
  if (endIndex < 0) then
    endIndex = length + 1 + endIndex
  end
  local newTab = {}

  for i = startIndex, endIndex do
    table.insert(newTab, tab[i])
  end

  return newTab
end

table.join = table.join or function(tab, exp)
  if (type(exp) == 'nil') then exp = ',' end
  return table.concat(tab, exp)
end

table.merge = table.merge or function(tab, ...)
  local args = { ... }
  for k, tabelement in ipairs(args) do
    local length = table.length(tabelement)
    for k2, value in ipairs(tabelement) do
      if ((type(k2) == 'number') and (k2 <= length)) then
        table.insert(tab, value)
      end
    end
    for k2, value in pairs(tabelement) do
      if ((type(k2) == 'number') and (k2 <= length)) then
      elseif (type(k2) == 'number') then
        tab[tostring(k2)] = value
      else
        tab[k2] = value
      end
    end
  end
  return tab
end

table.assign = table.assign or function(target, ...)
  local sources = { ... }
  if (type(target) ~= 'table') then target = {} end
  for _, source in ipairs(sources) do
    for key, value in pairs(source) do
      target[key] = value
    end
  end
  return target
end

table.reverse = table.reverse or function(target)
  local result = {}
  local theLength = table.length(target)
  for key, value in ipairs(target) do
    result[theLength - key + 1] = value
  end
  return result
end

table.filter = table.filter or function(target, func)
  local result = {}
  local theLength = table.length(target)
  for key, value in ipairs(target) do
    if (func(value, key, target)) then
      table.insert(result, value)
    end
  end
  return target
end

table.unique = table.unique or function(target, path)
  local theMap = {}
  local result = {}
  local pathType = type(path)
  if (pathType == 'nil') then
    for key, value in ipairs(target) do
      if (type(theMap[value]) == 'nil') then
        theMap[value] = { key = key, value = value }
        table.insert(result, value)
      end
    end
  elseif ((pathType == 'number') or (pathType == 'string')) then
    for key, value in ipairs(target) do
      if (type(theMap[value[path]]) == 'nil') then
        theMap[value[path]] = { key = key, value = value }
        table.insert(result, value)
      end
    end
  elseif (pathType == 'function') then
    for key, value in ipairs(target) do
      if (type(theMap[path(value)]) == 'nil') then
        theMap[path(value)] = { key = key, value = value }
        table.insert(result, value)
      end
    end
  end
  return result
end

-- 后覆盖前的unique
table.uniqueLast = table.uniqueOf or function(target, path)
  local theMap = {}
  local result = {}
  local pathType = type(path)
  local targetLength = table.length(target)
  if (pathType == 'nil') then
    for key, value in ipairs(target) do
      theMap[value] = { key = key, value = value }
    end
    for key, value in ipairs(target) do
      if (key == theMap[value].key) then
        table.insert(result, value)
      end
    end
  elseif ((pathType == 'number') or (pathType == 'string')) then
    for key, value in ipairs(target) do
      theMap[value[path]] = { key = key, value = value }
    end
    for key, value in ipairs(target) do
      if (key == theMap[value[path]].key) then
        table.insert(result, value)
      end
    end
  elseif (pathType == 'function') then
    for key, value in ipairs(target) do
      theMap[path(value)] = { key = key, value = value }
    end
    for key, value in ipairs(target) do
      if (key == theMap[path(value)].key) then
        table.insert(result, value)
      end
    end
  end
  return result
end

table.values = table.values or function(tab)
  local values = {}
  for k, v in pairs(tab) do
    table.insert(values, v)
  end
  return values
end

table.keys = table.keys or function(tab)
  local keys = {}
  for k in pairs(tab) do
    table.insert(keys, k)
  end
  return keys
end

-- 对key排序后放入数组中再返回，结果类似entries
table.sortByKey = table.sortByKey or function(tab, call)
  local keys = table.keys(tab)
  if (type(call) == 'function') then
    table.sort(keys, call)
  else
    table.sort(keys)
  end
  local newTable = {}
  for _, key in ipairs(keys) do
    table.insert(newTable, { key, tab[key] })
  end
  return newTable
end

table.toString = table.toString or function(tab)
  return table.concat(runTable(tab), '')
end

table.from = table.from or function(target)
  if (type(target) ~= 'function') then
    return target
  end
  local result = {}
  for k, v in target do
    result[k] = v
  end
  return result
end

table.toJsString = table.toJsString or function(tab, space)
  space = space or '  '
  return table.concat(runTable(tab, space), '\n')
end
end
end

do
local _ENV = _ENV
package.preload[ "console" ] = function( ... ) local arg = _G.arg;
local nLog = nLog or function() end

local getLength = table.length or function(target)
  local length = 0
  for k, v in ipairs(target) do
    length = k
  end
  return length
end

local isArray = table.isArray or function(tab)
  if (type(tab) ~= "table") then
    return false
  end
  local length = getLength(tab)
  for k, v in pairs(tab) do
    if ((type(k) ~= "number") or (k > length)) then
      return false
    end
  end
  return true
end

local __console = console or {}

local function runTable(tab, space)
  if (type(tab) == 'number') then
    return { tostring(tab) }
  end
  if (type(tab) == 'string') then
    return { '"' .. tab .. '"' }
  end
  if (type(tab) == 'boolean') then
    if (tab) then
      return { 'true' }
    else
      return { 'false' }
    end
  end
  if (type(tab) ~= 'table') then
    return { '(' .. type(tab) .. ')' }
  end
  if (type(space) == 'number') then
    space = string.rep(' ', space)
  end
  if (type(space) ~= 'string') then
    space = ''
  end

  local resultStrList = {}

  local newTabPairs = {}
  local tabIsArray = true
  local tabLength = 0
  local hasSubTab = false

  for k, v in ipairs(tab) do
    tabLength = k
    table.insert(newTabPairs, { k, runTable(v, space) })
    if (type(v) == 'table') then
      hasSubTab = true
    end
  end

  for k, v in pairs(tab) do
    if ((type(k) ~= 'number') or k > tabLength) then
      tabIsArray = false
      table.insert(newTabPairs, { k, runTable(v, space) })
      if (type(v) == 'table') then
        hasSubTab = true
      end
    end
  end

  if (tabIsArray) then
    local newTabArr = newTabPairs

    if (hasSubTab) then
      table.insert(resultStrList, '[')
      for k, v in ipairs(newTabArr) do
        local v2Length = getLength(v[2])
        v[2][v2Length] = v[2][v2Length] .. ','
        for k2, v2 in ipairs(v[2]) do
          table.insert(resultStrList, space .. v2)
        end
      end
      table.insert(resultStrList, ']')
    else
      local theStr = {}
      for k, v in ipairs(newTabPairs) do
        table.insert(theStr, v[2][1])
      end
      local childStr = table.concat(theStr, ', ')
      table.insert(resultStrList, '[' .. childStr .. ']')
    end
  else
    local newTabArr = newTabPairs

    table.insert(resultStrList, '{')
    for k, v in ipairs(newTabArr) do
      v[2][1] = v[1] .. ': ' .. v[2][1]
      local v2Length = getLength(v[2])
      v[2][v2Length] = v[2][v2Length] .. ','
      for k2, v2 in ipairs(v[2]) do
        table.insert(resultStrList, space .. v2 .. '')
      end
    end
    table.insert(resultStrList, '}')
  end
  return resultStrList
end


__console.log = __console.log or function(obj)
  local js = table.concat(runTable(obj, 2), "\n")
  print(js)
  nLog(js)
  return js
end

__console.getJsStr = function(obj)
  return table.concat(runTable(obj, 2), ",\n")
end

__console.color = function(value)
  local resultStr = ''
  local color = getColor(value[1], value[2])
  local oldColor = value[3]
  local colorStr = string.format('0x%06x', color)
  local oldColorStr = string.format('0x%06x', oldColor)
  value[3] = oldColorStr
  if (color == oldColor) then
    resultStr = resultStr .. '\n' .. table.concat(runTable(value), "")
  else
    value[3] = colorStr
    resultStr = resultStr .. '\n' .. table.concat(runTable(value), "") .. '  old Color: ' .. oldColorStr
  end
  __console.log(resultStr)
end

console = __console
end
end

do
local _ENV = _ENV
package.preload[ "lfs" ] = function( ... ) local arg = _G.arg;
local lfs = {}

lfs.dir = function(path)
  local res = io.popen('ls ' .. path);
  local text = {};
  for line in res:lines() do
    table.insert(text, line)
  end
  return text
end

lfs.rm = function(path)
  local res = io.popen('rm ' .. path);
  local text = {};
  for line in res:lines() do
    table.insert(text, line)
  end
  local res = table.concat(text, '\n')
  return res
end

lfs.rmdir = function(path)
  local res = io.popen('rm -rf' .. path);
  local text = {};
  for line in res:lines() do
    table.insert(text, line)
  end
  local res = table.concat(text, '\n')
  return res
end

return lfs
end
end

end

runCount = 1
isPause = false
luaExisted = false
function beforeUserExit()
  luaExisted = true
  vibrator(500)
  mSleep(500)
  vibrator(500)
end

if (deviceIsLock() ~= 0) then
  unlockDevice()
end

initLog('azur_lane', 1)

require 'TableLib'
require 'StringLib'
require 'MathLib'
require 'console'
require 'KeepScreenHock'
require 'DeviceOrientHock'
local eq = require 'EventQuery'
local co = require 'Co'
local Promise = require 'Promise'
local sz = require 'sz'
local json = sz.json
local socket = require 'szocket.core'
local mapMaker = require 'BaseOperate'
local gomission = require 'GoMission'
local stepLabel = (require 'StepLabel').init('stopbtn')


Promise.setStackTraceback(false)

local lfs = require 'lfs'

Promise.setStackTraceback(false)

-- 删除大于7天并且大于50条的log，避免日志过大
local _ = (function()
  local logPath = userPath() .. '/log'
  local dirs = lfs.dir(logPath)
  local sevenDayBeforeTime = os.time() - (7 * 24 * 60 * 60)
  local theTime = os.time()

  local dirsLen = #dirs

  dirs = table.filter(dirs, function(e, index)
    if (string.startWith(e, 'azur_lane_')) then
      local res = string.match(e, 'azur_lane_(%d+)')
      res = tonumber(res) or theTime
      if ((index < (dirsLen - 50)) and (res < sevenDayBeforeTime)) then
        return true
      end
    end
    return false
  end)

  for k, v in ipairs(dirs) do
    lfs.rm(logPath .. '/' .. v)
  end
end)()

local width, height = getScreenSize()

local c = coroutine


local sleepPromise = function(ms)
  return Promise.new(function(resolve)
    eq.setTimeout(resolve, ms)
  end)
end

stepLabel.setStepLabelContent('开始')

function closeStepLabel()
  fwCloseView('steplabel', 'text1')
end

stepLabel.setStepLabelContent('等待音量面板收起')
mSleep(500)



-- 设置
local settingTable = {
  ['style'] = 'default',
  ['width'] = height,
  ['height'] = height,
  ['config'] = 'save_warship-girls-r-script.dat',
  ['timer'] = 5,
  ['orient'] = 1,
  ['pagetype'] = 'multi',
  ['title'] = '选项',
  ['cancelname'] = '取消',
  ['okname'] = '开始',
  ['rettype'] = 'table',
  ['pages'] = {
    {
      {
        ['type'] = 'Label',
        ['text'] = '第一次设置建议在竖屏下设置，设置好后再切换到游戏界面',
        ['size'] = 15,
        ['align'] = 'left',
        ['color'] = '0,0,0',
      },
      {
        ['type'] = 'Label',
        ['text'] = '向左滑动查看其他选项',
        ['size'] = 15,
        ['align'] = 'left',
        ['color'] = '0,0,0',
      },
      {
        ['type'] = 'Label',
        ['text'] = '出击',
        ['size'] = 15,
        ['align'] = 'left',
        ['color'] = '0,0,0',
      },
      {
        ['id'] = 'battleEnable',
        ['type'] = 'RadioGroup',
        ['list'] = '开启,关闭',
        ['select'] = '0',
      },
      {
        ['type'] = 'Label',
        ['text'] = '每一轮的间隔时间(秒)',
        ['size'] = 15,
        ['align'] = 'left',
        ['color'] = '0,0,0',
      },
      {
        ['id'] = 'missionsInterval',
        ['type'] = 'Edit',
        ['prompt'] = '最短间隔时间(秒)',
        ['text'] = '15',
        ['kbtype'] = 'number',
      },
      {
        ['type'] = 'Label',
        ['text'] = '多长时间画面不变则重启游戏(秒)最少60秒',
        ['size'] = 15,
        ['align'] = 'left',
        ['color'] = '0,0,0',
      },
      {
        ['id'] = 'restartInterval',
        ['type'] = 'Edit',
        ['prompt'] = '多长时间画面不变则重启游戏(秒)最少60秒',
        ['text'] = '120',
        ['kbtype'] = 'number',
      },
      {
        ['type'] = 'Label',
        ['text'] = ' \n \n \n \n \n \n \n \n \n \n',
        ['size'] = 50,
        ['align'] = 'left',
        ['color'] = '0,0,0',
      },
    },
    {
      {
        ['type'] = 'Label',
        ['text'] = '出击设置',
        ['size'] = 15,
        ['align'] = 'left',
        ['color'] = '0,0,0',
      },
      {
        ['type'] = 'Label',
        ['text'] = '章节',
        ['size'] = 15,
        ['align'] = 'left',
        ['color'] = '0,0,0',
      },
      {
        ['id'] = 'battleChapter',
        ['type'] = 'CheckBoxGroup',
        --        ['list'] = '1-1,1-2,1-3,1-4,2-1,2-2,2-3,2-4,3-1,3-2,3-3,3-4,4-1,4-2,4-3',
        ['list'] = '3-4',
        ['select'] = '0',
      },
      {
        ['type'] = 'Label',
        ['text'] = 'boss舰队',
        ['size'] = 15,
        ['align'] = 'left',
        ['color'] = '0,0,0',
      },
      {
        ['id'] = 'battleFleetBoss',
        ['type'] = 'RadioGroup',
        ['list'] = '1队,2队,3队,4队',
        ['select'] = '0',
      },
      {
        ['type'] = 'Label',
        ['text'] = '小兵舰队',
        ['size'] = 15,
        ['align'] = 'left',
        ['color'] = '0,0,0',
      },
      {
        ['id'] = 'battleFleetSoldier',
        ['type'] = 'RadioGroup',
        ['list'] = '无,1队,2队,3队,4队',
        ['select'] = '0',
      },
      {
        ['type'] = 'Label',
        ['text'] = '回避',
        ['size'] = 15,
        ['align'] = 'left',
        ['color'] = '0,0,0',
      },
      {
        ['id'] = 'battleRoundabout',
        ['type'] = 'RadioGroup',
        ['list'] = '是,否',
        ['select'] = '0',
      },
      {
        ['type'] = 'Label',
        ['text'] = '不能出征则震动提示',
        ['size'] = 15,
        ['align'] = 'left',
        ['color'] = '0,0,0',
      },
      {
        ['id'] = 'battleAlertWhenNoHp',
        ['type'] = 'RadioGroup',
        ['list'] = '是,否',
        ['select'] = '0',
      },
      {
        ['type'] = 'Label',
        ['text'] = '阵型',
        ['size'] = 15,
        ['align'] = 'left',
        ['color'] = '0,0,0',
      },
      {
        ['id'] = 'battleFormation',
        ['type'] = 'RadioGroup',
        ['list'] = '单纵,复纵,轮型,梯形,单横',
        ['select'] = '1',
      },
      {
        ['type'] = 'Label',
        ['text'] = ' \n \n \n \n \n \n \n \n \n \n',
        ['size'] = 50,
        ['align'] = 'left',
        ['color'] = '0,0,0',
      },
    },
  }
}

local settingTableStr = json.encode(settingTable);
closeStepLabel()
local ret, settings = showUI(settingTableStr);
if (ret ~= 1) then
  stepLabel.setStepLabelContent('取消运行')
  mSleep(100000)
  lua_exit()
end
stepLabel.setStepLabelContent('正在载入...')
-- --转换settings结果
local __tmp = (function(settings)
  function transStrToTable(str)
    local list = {}
    local strArr = {}
    if (type(str) == 'string') then
      strArr = strSplit(str, ',')
    elseif (type(str) == 'table') then
      strArr = str
    end
    for i, v in ipairs(strArr) do
      list['' .. (i - 1)] = v
    end
    return list
  end

  -- 出征
  settings.battleEnable = (function(battleEnable)
    local list = transStrToTable({ true, false, })
    return list[battleEnable] or false
  end)(settings.battleEnable)
  -- 总循环间隔时间
  settings.missionsInterval = tonumber(settings.missionsInterval) or 0
  -- 多长时间界面不变则重启，最少60秒
  settings.restartInterval = tonumber(settings.restartInterval) or 120
  settings.restartInterval = math.max(settings.restartInterval, 60)

  -- 选择关卡
  settings.battleChapter = (function(battleChapter)
    local tempArr = strSplit(battleChapter, '@')
    --    local list = transStrToTable({
    --      '1-1', '1-2', '1-3', '1-4',
    --      '2-1', '2-2', '2-3', '2-4',
    --      '3-1', '3-2', '3-3', '3-4',
    --      '4-1', '4-2', '4-3',
    --    })
    local list = transStrToTable({
      '3-4',
    })
    local result = {}
    for _, v in ipairs(tempArr) do
      if (type(list[v]) == 'string') then
        table.insert(result, list[v])
      end
    end
    return result
  end)(settings.battleChapter)
  -- 选择Boss舰队
  settings.battleFleet = {}
  settings.battleFleetBoss = (function(battleFleetBoss)
    local list = transStrToTable({ 1, 2, 3, 4 })
    return list[battleFleetBoss] or 1
  end)(settings.battleFleetBoss)
  settings.battleFleet = { settings.battleFleetBoss }
  -- 选择小兵舰队
  settings.battleFleetSoldier = (function(battleFleetSoldier)
    local list = transStrToTable({ 0, 1, 2, 3, 4 })
    local result = list[battleFleetSoldier] or 0
    if settings.battleFleetBoss == result then
      result = 0
    end
    return result
  end)(settings.battleFleetSoldier)
  if settings.battleFleetSoldier > 0 then
    settings.battleFleet = { settings.battleFleetBoss, settings.battleFleetSoldier }
  end
  -- 迂回战术
  settings.battleRoundabout = (function(battleRoundabout)
    local list = transStrToTable({ true, false, })
    return list[battleRoundabout] or false
  end)(settings.battleRoundabout)
  -- 当无法出征时是否跳过出征
  settings.battleAlertWhenNoHp = (function(battleAlertWhenNoHp)
    local list = transStrToTable({ true, false, })
    return list[battleAlertWhenNoHp] or false
  end)(settings.battleAlertWhenNoHp)
  -- 阵型
  settings.battleFormation = (function(battleFormation)
    local list = transStrToTable({ 1, 2, 3, 4, 5 })
    return list[battleFormation] or 2
  end)(settings.battleFormation)
end)(settings)

-- --转换settings结果

-- 注册按钮事件，目前只有暂停按钮
eq.setButotnListener('stopbtn', function()
  if (isPause) then
    --    stepLabel.setPrefix('')
    --    isPause = false
  else
    stepLabel.setPrefix('即将暂停 ')
    isPause = true
  end
end)

gomission.init(mapMaker(), settings)

local theMissionsQuery = {}

co(c.create(function()
  if (settings.battleEnable) then

    -- 插入一个特殊的任务表示这是队列的开头
    table.insert(theMissionsQuery, { isBase = true, isStart = true })
    -- 是否运行出征
    if (settings.battleEnable) then
      table.insert(theMissionsQuery, { isBase = true, type = 'BATTLE_START' })
    end
    -- 插入一个特殊任务表示这是队列的结尾
    table.insert(theMissionsQuery, { isBase = true, isEnd = true })

    runCount = 1
    local runStartTime = socket.gettime() * 1000
    while (true) do
      -- 任务队列里没有任务则停止运行
      local action = theMissionsQuery[1]
      if ((#theMissionsQuery == 0) or (not action)) then
        break
      end

      if (action.isStart) then
        runStartTime = socket.gettime() * 1000
      end

      -- 如果是队列原有任务则将其加入队列末尾，以保证能一直循环
      -- 如果是从原有任务衍生的下一步任务，则不加入队列末尾，会被新的下一步任务替换或者删除
      if (action.isBase) then
        table.insert(theMissionsQuery, action)
      end

      -- 执行一个action
      if (action.type) then
        local newAction = c.yield(gomission.next(action))
        if (type(newAction) == 'table') then
          if (newAction.addToStart) then
            table.insert(theMissionsQuery, 1, newAction)
          else
            theMissionsQuery[1] = newAction
          end
        else
          table.remove(theMissionsQuery, 1)
        end
      else
        table.remove(theMissionsQuery, 1)
      end

      -- 如果点了暂停按钮
      if (isPause) then
        stepLabel.setPrefix('')
        local lasttext = stepLabel.getText()
        stepLabel.setStepLabelContent('暂停')
        c.yield(Promise.new(function(resolve)
          local theEid
          theEid = eq.setButotnListener('stopbtn', function()
            isPause = false
            stepLabel.setPrefix('')
            eq.clearButotnListener(theEid)
            resolve()
          end)
        end))
        stepLabel.setStepLabelContent(lasttext)
      end

      if (action.isEnd) then
        local diffTime = (socket.gettime() * 1000) - runStartTime
        if (diffTime < (settings.missionsInterval * 1000)) then
          local remainTime = (settings.missionsInterval * 1000) - diffTime
          stepLabel.setStepLabelContent('休息剩余时间' .. math.ceil(remainTime / 1000) .. '秒')
          while (remainTime > 0) do
            stepLabel.setStepLabelContent('休息剩余时间' .. math.ceil(remainTime / 1000) .. '秒', true)
            c.yield(sleepPromise(1000))
            remainTime = remainTime - 1000
          end
        end

        if (luaExisted) then
          break
        end

        runCount = runCount + 1
      end

      -- 如果是任务队列结尾标志，则count+1
    end
  end
end)).catch(function(err)
  wLog("warship-girls-r-script", "[DATE] " .. err);
  eq.setImmediate(function() error(err) end)
end)

eq.run()
