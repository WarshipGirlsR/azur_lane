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
    { 114, 151, 0xf7f7f7 },
    { 182, 20, 0xfff3c5 }, { 178, 35, 0xffc642 },
    { 210, 28, 0x3a393a }, { 219, 32, 0xffd25a },
    { 255, 30, 0xffdb73 }, { 244, 42, 0x3a393a },
    { 267, 42, 0x3a393a }, { 273, 51, 0xf7c652 },
    { 259, 17, 0xfff7de }, { 266, 25, 0x101010 },
  }
  local result = multiColor(list)
  if not __keepScreenState then keepScreen(false) end
  return result
end

-- 点击回港
battle.clickBackToHomeBtn = function()
  tap(98, 1016, 100)
end

--  是否不在困难模式
battle.isNotHardMode = function()
  local __keepScreenState = keepScreenState
  if not __keepScreenState then keepScreen(true) end
  local list = {
    { 179, 1004, 0xbd0c10 },
    { 274, 1028, 0x631419 },
  }
  local result = multiColor(list)
  if not __keepScreenState then keepScreen(false) end
  return result
end

--  是否在困难模式
battle.isHardMode = function()
  local __keepScreenState = keepScreenState
  if not __keepScreenState then keepScreen(true) end
  local list = {
    { 182, 1009, 0x082d73 },
    { 277, 1036, 0x102042 },
  }
  local result = multiColor(list)
  if not __keepScreenState then keepScreen(false) end
  return result
end

-- 切换困难模式按钮
battle.clickSwitchHardModeBtn = function()
  tap(202, 1010, 100)
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
  for i = 1, 9 do
    tap(90, 540, 100)
    mSleep(500)
    if not multiColor(leftButton) then
      break
    end
  end
  -- 再移到第m章
  for i = 2, m do
    tap(1826, 540, 100)
    mSleep(200)
  end
  mSleep(200)

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
    tap(355, 451, 100)
  elseif (chapter == '4-2') then
    tap(628, 701, 100)
  elseif (chapter == '4-3') then
    tap(1234, 818, 100)
  elseif (chapter == '4-4') then
    tap(1167, 430, 100)
  elseif (chapter == '5-1') then
    tap(363, 544, 100)
  elseif (chapter == '5-2') then
    tap(1285, 803, 100)
  elseif (chapter == '5-3') then
    tap(1104, 549, 100)
  elseif (chapter == '5-4') then
    tap(884, 318, 100)
  elseif (chapter == '6-1') then
    tap(1373, 746, 100)
  elseif (chapter == '6-2') then
    tap(1055, 515, 100)
  elseif (chapter == '6-3') then
    tap(632, 317, 100)
  elseif (chapter == '6-4') then
    tap(443, 643, 100)
  elseif (chapter == '7-1') then
    tap(308, 725, 100)
  elseif (chapter == '7-2') then
    tap(688, 270, 100)
  elseif (chapter == '7-3') then
    tap(1234, 425, 100)
  elseif (chapter == '7-4') then
    tap(1416, 674, 100)
  elseif (chapter == '8-1') then
    tap(476, 343, 100)
  elseif (chapter == '8-2') then
    tap(309, 604, 100)
  elseif (chapter == '8-3') then
    tap(662, 852, 100)
  elseif (chapter == '8-4') then
    tap(1353, 733, 100)
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
  local result = multiColor(list)
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
  local result = multiColor(list)
  if not __keepScreenState then keepScreen(false) end
  return result
end

--  是否在困难选择舰队面板
battle.isHardSelectFleetPanel = function()
  local __keepScreenState = keepScreenState
  if not __keepScreenState then keepScreen(true) end
  local list = {
    { 439, 165, 0x525552 }, { 1556, 174, 0xeff3f7 },
    { 1721, 188, 0xadaaad }, { 1720, 901, 0x3a3531 },
    { 185, 908, 0x312d31 }, { 167, 161, 0x292429 },

    { 1415, 826, 0xf7df4a }, { 1489, 855, 0xffca3a },
    { 1515, 853, 0xc5be9c }, { 1549, 855, 0xffffff },
    { 1604, 860, 0x9c814a }, { 1646, 864, 0xffb221 },
    { 1654, 838, 0xffd74a }, { 1574, 847, 0x947d42 },

    { 199, 178, 0xffdb7b }, { 226, 179, 0xf7db84 },
    { 260, 182, 0x292010 }, { 295, 185, 0x293529 },
    { 340, 190, 0xffc219 }, { 396, 193, 0xffbe10 },
    { 420, 184, 0x525152 },
  }
  local result = multiColor(list)
  if not __keepScreenState then keepScreen(false) end
  return result
end

-- 困难进入战斗
battle.clickHardGotoSelectFleedPanelBtn = function()
  tap(1535, 860, 100)
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
    multiColor(list1) and true or false,
    multiColor(list2) and true or false,
    multiColor(list3) and true or false,
    multiColor(list4) and true or false,
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
  local result = multiColor(list)
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
  local list1 = {
    { 301, 101, 0x424542 }, { 321, 94, 0xf7efbd },
    { 329, 111, 0x424142 }, { 318, 123, 0xf7c642 },
    { 311, 139, 0x424142 }, { 319, 152, 0x424142 },
    { 329, 137, 0x424131 }, { 324, 148, 0xffba00 },
    { 312, 109, 0xf7e39c },
  }
  local list2 = {
    { 305, 112, 0xefdf9c }, { 319, 105, 0x42453a },
    { 320, 95, 0xf7ebb5 }, { 324, 107, 0xf7df94 },
    { 334, 112, 0xffdf7b }, { 316, 126, 0xf7c24a },
    { 322, 136, 0xdeae21 }, { 301, 146, 0x424142 },
    { 324, 138, 0x424142 }, { 337, 144, 0x424142 },
  }
  local list3 = {
    { 302, 110, 0x524531 }, { 320, 106, 0x424542 },
    { 326, 108, 0xffe39c }, { 312, 118, 0x4a4d4a },
    { 316, 120, 0xffd763 }, { 308, 126, 0x424542 },
    { 306, 130, 0xefc242 }, { 320, 150, 0xffb600 },
    { 320, 140, 0x424542 }, { 338, 139, 0x424142 },
  }
  local list4 = {
    { 315, 93, 0xf7e7b5 }, { 327, 90, 0x424142 },
    { 333, 114, 0x635531 }, { 334, 127, 0x423d31 },
    { 334, 133, 0xf7be21 }, { 326, 147, 0xefba19 },
    { 302, 135, 0xefbe29 }, { 315, 125, 0x424542 },
    { 316, 119, 0x5a513a }, { 325, 151, 0x424142 },
  }
  local result = 1
  if multiColor(list1) then
    result = 1
  elseif multiColor(list2) then
    result = 2
  elseif multiColor(list3) then
    result = 3
  elseif multiColor(list4) then
    result = 4
  end
  if not __keepScreenState then keepScreen(false) end
  return result
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
      { 301, 101, 0x424542 }, { 321, 94, 0xf7efbd },
      { 329, 111, 0x424142 }, { 318, 123, 0xf7c642 },
      { 311, 139, 0x424142 }, { 319, 152, 0x424142 },
      { 329, 137, 0x424131 }, { 324, 148, 0xffba00 },
      { 312, 109, 0xf7e39c },
    }
  elseif fleet == 2 then
    list = {
      { 305, 112, 0xefdf9c }, { 319, 105, 0x42453a },
      { 320, 95, 0xf7ebb5 }, { 324, 107, 0xf7df94 },
      { 334, 112, 0xffdf7b }, { 316, 126, 0xf7c24a },
      { 322, 136, 0xdeae21 }, { 301, 146, 0x424142 },
      { 324, 138, 0x424142 }, { 337, 144, 0x424142 },
    }
  elseif fleet == 3 then
    list = {
      { 302, 110, 0x524531 }, { 320, 106, 0x424542 },
      { 326, 108, 0xffe39c }, { 312, 118, 0x4a4d4a },
      { 316, 120, 0xffd763 }, { 308, 126, 0x424542 },
      { 306, 130, 0xefc242 }, { 320, 150, 0xffb600 },
      { 320, 140, 0x424542 }, { 338, 139, 0x424142 },
    }
  elseif fleet == 4 then
    list = {
      { 315, 93, 0xf7e7b5 }, { 327, 90, 0x424142 },
      { 333, 114, 0x635531 }, { 334, 127, 0x423d31 },
      { 334, 133, 0xf7be21 }, { 326, 147, 0xefba19 },
      { 302, 135, 0xefbe29 }, { 315, 125, 0x424542 },
      { 316, 119, 0x5a513a }, { 325, 151, 0x424142 },
    }
  end
  local result = multiColor(list)
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
  local result = multiColor(list)
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
    { 41, 34, 0xf7d242 }, { 14, 13, 0xdee3de },
    { 169, 27, 0x293129 }, { 204, 29, 0x63593a },
    { 244, 32, 0xb59e52 }, { 292, 39, 0x313531 },
    { 330, 44, 0x94929c }, { 359, 49, 0x191c21 },
    { 527, 13, 0xeff3f7 }, { 738, 16, 0xeff3f7 },
    { 1305, 208, 0x080808 }, { 1269, 209, 0xefefef },
    { 1893, 217, 0xefebef }, { 1267, 509, 0xefefef },
    { 1284, 507, 0xdeebde }, { 1319, 506, 0xd6dbd6 },
    { 1336, 510, 0x100c10 }, { 1389, 889, 0xd6f3f7 },
    { 1752, 903, 0xceeff7 }, { 1589, 929, 0xfff794 },
    { 1025, 31, 0x3a3d3a }, { 1070, 35, 0xd6d7d6 },
    { 1333, 28, 0xfff363 }, { 1393, 30, 0xdedfde },
    { 1644, 30, 0xff4973 }, { 1701, 31, 0xdedbde },
  }
  local result = multiColor(list)
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
  local result = multiColor(list)
  if not __keepScreenState then keepScreen(false) end
  return result
end

-- 检测是否自动战斗
battle.isNotAutoBattle = function()
  local __keepScreenState = keepScreenState
  if not __keepScreenState then keepScreen(true) end
  local list = {
    { 132, 57, 0x5a5142 }, { 146, 76, 0xe6e2e6 },
    { 171, 83, 0x4a3d31 }, { 205, 82, 0xb5b2ad },
    { 244, 84, 0x4a3d31 }, { 264, 78, 0xfffbff },
    { 209, 66, 0x5a5142 }, { 183, 63, 0xcec2bd },
    { 275, 87, 0xefefef }, { 298, 88, 0xd6d2ce },
  }
  local result = multiColor(list)
  if not __keepScreenState then keepScreen(false) end
  return result
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
  local result = multiColor(list)
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
    { 1350, 533, 0xef9e3a },
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
  if (multiColor(list) or multiColor(list2) or multiColor(list3)) then
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
  local result = multiColor(list)
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
  local result = multiColor(list)
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
  local result = multiColor(list)
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
  local result = multiColor(list)
  if not __keepScreenState then keepScreen(false) end
  return result
end

-- 获得道具面板点击继续
battle.urgentEntrustmentPanelClickOk = function()
  tap(957, 739)
end

return battle