local ImgInfo = require 'BaseOperate__ImgInfo'

local battle = {}


--  是否在出击界面
battle.isBattlePage = function()
  local __keepScreenState = keepScreenState
  if (not __keepScreenState) then keepScreen(true) end
  local list = {
    { 97, 17, 0xe6e3e6 }, { 560, 19, 0xeff3f7 },
    { 772, 14, 0xeff3f7 }, { 1022, 44, 0x3a393a },
    { 1334, 44, 0xffff9c }, { 1643, 46, 0xf792b5 },
    { 180, 1009, 0xd62021 }, { 264, 1038, 0x6b1c21 },
    { 1208, 1020, 0xf7f3f7 }, { 1569, 1037, 0x212431 },
  }
  local result = multiColor(list)
  if (not __keepScreenState) then keepScreen(false) end
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
  -- 先移到第一章
  for i = 1, 8 do
    tap(90, 540, 100)
    mSleep(200)
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
  if (not __keepScreenState) then keepScreen(true) end
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
  if (not __keepScreenState) then keepScreen(false) end
  return result
end

-- 前往选择舰队面板
battle.clickGotoSelectFleedPanelBtn = function()
  tap(1388, 720, 100)
end

--  是否在选择舰队面板
battle.isSelectFleetPanel = function()
  local __keepScreenState = keepScreenState
  if (not __keepScreenState) then keepScreen(true) end
  local list = {
    { 339, 170, 0x292829 }, { 399, 169, 0xffefce },
    { 437, 175, 0x313131 }, { 479, 173, 0x101010 },
    { 508, 183, 0xf7ce5a }, { 547, 173, 0xefd29c },
    { 565, 195, 0xffba08 }, { 588, 197, 0x424542 },
    { 661, 200, 0x000000 }, { 1086, 198, 0xdedfe6 },
    { 345, 243, 0x42414a }, { 1570, 237, 0x3a414a },
    { 344, 909, 0x31353a }, { 1571, 911, 0x4a494a },
    { 1274, 816, 0xffdb52 }, { 1409, 837, 0xfffbf7 },
    { 1523, 873, 0xffa610 },
  }
  local result = multiColor(list)
  if (not __keepScreenState) then keepScreen(false) end
  return result
end

-- 检查已经选择的舰队
battle.checkSelectedFleet = function(selectFleet)
  local __keepScreenState = keepScreenState
  if (not __keepScreenState) then keepScreen(true) end

  local needFleet = {}
  for _, v in ipairs(selectFleet) do
    needFleet[v] = true
  end

  local list1 = {
    { 371, 275, 0xffdf00 },
    { 371, 337, 0xffdf00 },
    { 371, 436, 0xffdf00 },
  }
  local list2 = {
    { 371, 582, 0xffdf00 },
    { 371, 644, 0xffdf00 },
    { 371, 719, 0xffdf00 },
  }
  local result1 = multiColor(list1)
  local result2 = multiColor(list2)

  local needChange = ''
  if (((needFleet[1]) and (not result1)) or ((needFleet[2]) and (not result2))) then
    -- 需要的舰队没选中
    needChange = 'selectedNeed'
  elseif (((not needFleet[1]) and (result1)) or ((not needFleet[2]) and (result2))) then
    -- 不需要的舰队选中了
    needChange = 'unSelectedNoNeed'
  end

  if (not __keepScreenState) then keepScreen(false) end
  return { [1] = result1, [2] = result2 }, needChange
end

-- 选中需要的舰队
battle.selectNeedFleet = function(selectFleet, selectedFleet)
  local needFleet = {}
  for _, v in ipairs(selectFleet) do
    needFleet[v] = true
  end
  if ((needFleet[1]) and (not selectedFleet[1])) then
    tap(965, 405, 100)
  elseif ((needFleet[2]) and (not selectedFleet[2])) then
    tap(959, 671, 100)
  end
end

-- 取消不需要的舰队
battle.unselectNoNeedFleet = function(selectFleet, selectedFleet)
  local needFleet = { false, false }

  for _, v in ipairs(selectFleet) do
    needFleet[v] = true
  end
  if ((not needFleet[1]) and (selectedFleet[1])) then
    tap(965, 405, 100)
  elseif ((not needFleet[2]) and (selectedFleet[2])) then
    tap(959, 671, 100)
  end
end

-- 前往地图
battle.clickGotoMapBtn = function()
  tap(1398, 845, 100)
end

--  是否在地图页面
battle.isMapPage = function()
  local __keepScreenState = keepScreenState
  if (not __keepScreenState) then keepScreen(true) end
  local list = {
    { 98, 48, 0xd6d7d6 }, { 748, 12, 0xeff3f7 },
    { 1025, 49, 0x8c868c }, { 1342, 48, 0xefb64a },
    { 1654, 45, 0xd62452 }, { 1058, 995, 0xbd0810 },
    { 1184, 1032, 0x6b1019 }, { 1294, 990, 0x4a454a },
    { 1683, 972, 0xde7910 }, { 1344, 989, 0xf7fbf7 },
  }
  local result = multiColor(list)
  if (not __keepScreenState) then keepScreen(false) end
  return result
end

-- 将地图移动到中心
battle.moveMapToCenter = function()
  local __keepScreenState = keepScreenState
  if (not __keepScreenState) then keepScreen(true) end

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
    moveTo(540, 960, 540 + moveVector[1], 960 + moveVector[2], moveMax, 100)
  else
    isCenter = true
  end
  if (not __keepScreenState) then keepScreen(false) end
  return isCenter
end

-- 扫描我方舰队
battle.scanMapScanMyFleet = function()
  local __keepScreenState = keepScreenState
  if (not __keepScreenState) then keepScreen(true) end

  local myFleetList = ImgInfo.toPoint(findMultiColorInRegionFuzzyExt(table.unpack(ImgInfo.battle.map.myFleet.findColorParam)))

  if (not __keepScreenState) then keepScreen(false) end
end

-- 扫描终点
battle.scanMapScanEndPoint = function()
  local __keepScreenState = keepScreenState
  if (not __keepScreenState) then keepScreen(true) end

  local myFleetList = ImgInfo.toPoint(findMultiColorInRegionFuzzyExt(table.unpack(ImgInfo.battle.map.myFleet.findColorParam)))

  if (not __keepScreenState) then keepScreen(false) end
end

-- 检测是第几队
battle.scanMapCheckFleetNum = function()
  local __keepScreenState = keepScreenState
  if (not __keepScreenState) then keepScreen(true) end
  local list = {
    { 304, 141, 0x4a5d52 },
    { 319, 148, 0xefaa10 },
    { 335, 138, 0x5a695a },
    { 322, 96, 0xffefb5 },
    { 305, 104, 0xffe7a4 },
    { 335, 114, 0x637163 },
  }
  local result1 = multiColor(list)
  if (not __keepScreenState) then keepScreen(false) end
  if (result1) then
    return 1
  end
  return 2
end

-- 点击到右下角位置（在boss没出现时）
battle.clickToMapRightBotton = function()
  tap(1777, 741, 100)
end

-- 检查是否在右下角位置
battle.isFleetOnRightBotton = function()
  local __keepScreenState = keepScreenState
  if (not __keepScreenState) then keepScreen(true) end

  local myFleetList = ImgInfo.toPoint(findMultiColorInRegionFuzzyExt(table.unpack(ImgInfo.battle.map.myFleet.findColorParam)))

  local result = false
  for _, value in ipairs(myFleetList) do
    if (ImgInfo.inArea(value, { 1746, 430 }, { 1897, 686 })) then
      result = true
      break
    end
  end
  if (not __keepScreenState) then keepScreen(false) end
  return result
end

-- 寻找最近的敌人
battle.findNearEnemyPointList = function()
  local __keepScreenState = keepScreenState
  if (not __keepScreenState) then keepScreen(true) end

  local bossPointList = ImgInfo.toPoint(findMultiColorInRegionFuzzyExt(table.unpack(ImgInfo.battle.map.bossPoint.findColorParam)))
  local enemyPoint = {}

  if (#bossPointList > 0) then
    enemyPoint = bossPointList[1]
  else
    local myFleetList = ImgInfo.toPoint(findMultiColorInRegionFuzzyExt(table.unpack(ImgInfo.battle.map.myFleet.findColorParam)))
    local enemyList1 = ImgInfo.toPoint(findMultiColorInRegionFuzzyExt(table.unpack(ImgInfo.battle.map.enemyList1.findColorParam)))
    local enemyList2 = ImgInfo.toPoint(findMultiColorInRegionFuzzyExt(table.unpack(ImgInfo.battle.map.enemyList2.findColorParam)))
    local enemyList3 = ImgInfo.toPoint(findMultiColorInRegionFuzzyExt(table.unpack(ImgInfo.battle.map.enemyList3.findColorParam)))
    local enemyList = table.merge(enemyList1, enemyList2, enemyList3)
    local myFleetListFirstPoint = myFleetList[1] or {}
    local myFleetPointX = (math.trueNumber(myFleetListFirstPoint[1]) or 0) - 60
    local myFleetPointY = (math.trueNumber(myFleetListFirstPoint[2]) or 0) + 167
    local myFleetPoint = { myFleetPointX, myFleetPointY }
    local _, e = ImgInfo.findNearestPoint({ myFleetPoint }, enemyList)
    enemyPoint = e
  end

  if (not __keepScreenState) then keepScreen(false) end
  return enemyPoint
end

-- 检测敌方伏击面板
battle.isAmbushedPanel = function()
  local __keepScreenState = keepScreenState
  if (not __keepScreenState) then keepScreen(true) end
  local list = {
    { 369, 678, 0x527119 }, { 399, 671, 0x527521 },
    { 428, 680, 0xfffbf7 }, { 803, 562, 0xf7ca3a },
    { 955, 565, 0xffffff }, { 1055, 597, 0xffa619 },
    { 1237, 540, 0xe6e7e6 }, { 1349, 568, 0xffffff },
    { 1485, 593, 0xc5bebd }, { 1200, 685, 0x5a595a },
  }
  local result = multiColor(list)
  if (not __keepScreenState) then keepScreen(false) end
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
  if (not __keepScreenState) then keepScreen(true) end
  local list = {
    { 49, 103, 0x3a4552 }, { 1395, 198, 0xf7f3f7 },
    { 1369, 523, 0xe6e7e6 }, { 1389, 901, 0xd6f3f7 },
    { 1781, 998, 0x8ccece }, { 1613, 935, 0xffefbd },
    { 1272, 361, 0x212429 }, { 135, 844, 0xefefef },
  }
  local result = multiColor(list)
  if (not __keepScreenState) then keepScreen(false) end
  return result
end

battle.readyBattlePageClickBattle = function()
  tap(1592, 952)
end

-- 检测是否在战斗中
battle.isInBattlePage = function()
  local __keepScreenState = keepScreenState
  if (not __keepScreenState) then keepScreen(true) end
  local list = {
    { 91, 78, 0x313942 }, { 131, 51, 0x4a5963 },
    { 307, 61, 0x4a5963 }, { 344, 47, 0xbdced6 },
    { 312, 109, 0x313d42 }, { 1818, 40, 0xdedfde },
    { 1835, 66, 0x3a353a }, { 1875, 92, 0xdedfd6 },
    { 1860, 56, 0x292d29 },
  }
  local result = multiColor(list)
  if (not __keepScreenState) then keepScreen(false) end
  return result
end

-- 检测是否自动战斗
battle.isAutoBattle = function()
  local __keepScreenState = keepScreenState
  if (not __keepScreenState) then keepScreen(true) end
  local list = {
    { 139, 70, 0x4a5963 }, { 146, 72, 0x424952 },
    { 146, 79, 0x212d31 }, { 152, 87, 0x313d42 },
    { 164, 92, 0xefebef }, { 167, 76, 0xf7f7f7 },
    { 163, 67, 0xffffff }, { 158, 65, 0x4a555a },
    { 155, 81, 0x314142 }, { 155, 83, 0xe6ebe6 },
  }
  local result = multiColor(list)
  if (not __keepScreenState) then keepScreen(false) end
  return not result
end

-- 检测是否自动战斗确认面板
battle.isAutoBattleConfirmPanel = function()
  local __keepScreenState = keepScreenState
  if (not __keepScreenState) then keepScreen(true) end
  local list = {
    { 492, 239, 0xffe7ad }, { 542, 247, 0x212821 },
    { 548, 249, 0xefc652 }, { 585, 265, 0xf7b208 },
    { 600, 262, 0x424142 }, { 1164, 226, 0xeff3f7 },
    { 849, 760, 0xffd24a }, { 946, 795, 0xffffff },
    { 1004, 778, 0xffca3a }, { 1021, 775, 0xffffff },
  }
  local result = multiColor(list)
  if (not __keepScreenState) then keepScreen(false) end
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
  if (not __keepScreenState) then keepScreen(true) end
  local list = {
    { 538, 403, 0xf7eb94 }, { 555, 445, 0xffdb52 },
    { 679, 450, 0xf7df52 }, { 598, 468, 0x84818c },
    { 592, 553, 0xe67d31 }, { 680, 540, 0xf79e42 },
    { 901, 430, 0xf7c64a }, { 1082, 478, 0xffff5a },
    { 1350, 533, 0xef9e3a }, { 926, 864, 0xd6ced6 },
  }
  local list2 = {
    { 559, 447, 0xe6a273 }, { 674, 451, 0xe6ae84 },
    { 848, 469, 0xe6965a }, { 1092, 448, 0x6b2819 },
    { 1179, 451, 0xefcaad }, { 1356, 467, 0x521c08 },
    { 1430, 492, 0xe69e6b }, { 1423, 541, 0xe69e6b },
  }
  local result = false
  if (multiColor(list) or multiColor(list2)) then
    result = true
  end
  if (not __keepScreenState) then keepScreen(false) end
  return result
end

-- 胜利面板点击继续
battle.victoryPanelClickNext = function()
  tap(952, 840)
end

-- 检测是否获得道具面板
battle.isGetPropsPanel = function()
  local __keepScreenState = keepScreenState
  if (not __keepScreenState) then keepScreen(true) end
  local list = {
    { 763, 212, 0xf7ae63 }, { 854, 168, 0xffffff },
    { 958, 174, 0x845131 }, { 1054, 167, 0xf7f384 },
    { 764, 242, 0xffaa42 }, { 861, 232, 0x7b2408 },
    { 944, 240, 0xffffff }, { 1006, 268, 0xffdf3a },
    { 1098, 277, 0xf7b629 }, { 969, 809, 0xffffff },
  }
  local result = multiColor(list)
  if (not __keepScreenState) then keepScreen(false) end
  return result
end

-- 获得道具面板点击继续
battle.getPropsPanelClickNext = function()
  tap(952, 840)
end

-- 检测是否获得船面板
battle.isGetNewShipPanel = function()
  local __keepScreenState = keepScreenState
  if (not __keepScreenState) then keepScreen(true) end
  local list = {
    { 64, 504, 0xefefff }, { 108, 539, 0x7b7d8c },
    { 86, 658, 0xe6c2c5 }, { 91, 787, 0xe6d7ce },
    { 83, 906, 0x3acee6 }, { 88, 948, 0xcecece },
    { 1496, 852, 0xefefef }, { 1572, 909, 0xc5c2bd },
    { 1543, 938, 0xeff3ef },
  }
  local result = multiColor(list)
  if (not __keepScreenState) then keepScreen(false) end
  return result
end

-- 获得船面板点击继续
battle.getNewShipPanelClickNext = function()
  tap(952, 840)
end

-- 检测是否获得经验面板
battle.isGetExpPanel = function()
  local __keepScreenState = keepScreenState
  if (not __keepScreenState) then keepScreen(true) end
  local list = {
    { 548, 297, 0x63656b }, { 658, 277, 0x63656b },
    { 984, 274, 0x6b696b }, { 1260, 278, 0x6b696b },
    { 1374, 289, 0x636563 }, { 248, 734, 0x424142 },
    { 1294, 922, 0xbdbabd }, { 1363, 911, 0x4a494a },
    { 1533, 912, 0xd6d2d6 }, { 1681, 926, 0xbdbab5 },
    { 1587, 884, 0xe6ebe6 }, { 1599, 916, 0xffffff },
  }
  local result = multiColor(list)
  if (not __keepScreenState) then keepScreen(false) end
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
return battle