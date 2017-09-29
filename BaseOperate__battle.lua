local battle = {}


--  是否在出击界面
battle.isBattlePage = function()
  local __keepScreenState = keepScreenState
  if not __keepScreenState then keepScreen(true) end
  local list = {
    { 8, 10, 0xe6e7ef }, { 201, 21, 0xffefc5 },
    { 307, 12, 0x424542 }, { 1024, 38, 0x313131 },
    { 1333, 40, 0xffef63 }, { 1645, 37, 0xff4573 },
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

--  是否不在困难模式
battle.isNormalMode = function()
  local __keepScreenState = keepScreenState
  if not __keepScreenState then keepScreen(true) end
  local list = {
    { 170, 1008, 0xc51021 },
    { 281, 1031, 0x631419 },
  }
  local result = multiColorS(list)
  if not __keepScreenState then keepScreen(false) end
  return result
end

--  是否在困难模式
battle.isHardMode = function()
  local __keepScreenState = keepScreenState
  if not __keepScreenState then keepScreen(true) end
  local list = {
    { 182, 1007, 0x083173 },
    { 281, 1010, 0x083173 },
  }
  local result = multiColorS(list)
  if not __keepScreenState then keepScreen(false) end
  return result
end

-- 切换困难模式按钮
battle.clickSwitchHardModeBtn = function()
  tap(202, 1010, 100)
end

-- 移动到m章节
battle.moveToChapter = function(chapter)
  local chapter = chapter
  local __keepScreenState = keepScreenState
  if not __keepScreenState then keepScreen(true) end

  local chapterArr = strSplit(chapter, "-")
  local m = tonumber(chapterArr[1]) or 1

  if string.sub(chapter, 1, 5) == 'event' then
    m = tonumber(chapterArr[2]) or 1
  end

  local chapterArr = strSplit(chapter, "-")
  local m = tonumber(chapterArr[1]) or 1

  local leftButton = {
    { 97, 526, 0xe6e7e6 },
    { 86, 539, 0xd6d7d6 },
    { 109, 577, 0xdedbde },
  }
  -- 先移到第一章
  for i = 1, 9 do
    tap(90, 540, 100)
    mSleep(500)
    keepScreen(true)
    if not multiColorS(leftButton) then
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
  elseif (chapter == '9-1') then
    tap(368, 435, 100)
  elseif (chapter == '9-2') then
    tap(646, 806, 100)
  elseif (chapter == '9-3') then
    tap(1079, 309, 100)
  elseif (chapter == '9-4') then
    tap(1329, 608, 100)
  elseif (chapter == 'event4-1-sp1') then
    tap(834, 312, 100)
  elseif (chapter == 'event4-1-sp2') then
    tap(417, 542, 100)
  elseif (chapter == 'event4-1-sp3') then
    tap(1392, 473, 100)
  elseif (chapter == 'event5-1-a1') then
    tap(655, 268, 100)
  elseif (chapter == 'event5-1-a2') then
    tap(1100, 781, 100)
  elseif (chapter == 'event5-1-a3') then
    tap(1340, 381, 100)
  elseif (chapter == 'event5-2-b1') then
    tap(527, 773, 100)
  elseif (chapter == 'event5-2-b2') then
    tap(527, 773, 100)
  elseif (chapter == 'event5-2-b3') then
    tap(527, 773, 100)
  end
  if not __keepScreenState then keepScreen(false) end
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

--  是否在困难选择舰队面板
battle.isHardSelectFleetPanel = function()
  local __keepScreenState = keepScreenState
  if not __keepScreenState then keepScreen(true) end
  local list = {
    { 165, 159, 0x293129 }, { 1723, 163, 0xadaaad },
    { 170, 179, 0x292829 }, { 198, 183, 0xffca4a },
    { 246, 185, 0xdebe42 }, { 298, 188, 0x3a353a },
    { 343, 188, 0xf7c23a }, { 379, 188, 0x100c08 },
    { 405, 180, 0x211808 }, { 428, 173, 0x4a494a },
    { 1421, 825, 0xffdf52 }, { 1462, 839, 0xd6cab5 },
    { 1494, 856, 0xd6caad }, { 1511, 860, 0x8c793a },
    { 1531, 862, 0xfffbf7 }, { 1549, 864, 0xffffff },
    { 1573, 866, 0xffffff }, { 1584, 864, 0xf7ebe6 },
    { 1618, 864, 0xf7f3ef }, { 1645, 856, 0xffca3a },
  }
  local result = multiColorS(list)
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
  keepScreen(true)
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
    { 16, 19, 0xdee3de }, { 824, 17, 0xeff3f7 },
    { 1021, 35, 0x3a3d3a }, { 1332, 33, 0xffef5a },
    { 1647, 35, 0xff4573 }, { 1074, 1021, 0xeff3ef },
    { 1404, 998, 0xf7f7f7 }, { 1692, 1003, 0xf7fbf7 },
    { 895, 993, 0xdedfde }, { 938, 1020, 0xbdbabd },
    { 420, 47, 0x000000 }, { 447, 47, 0x000000 },
    { 459, 44, 0xefefff }, { 516, 50, 0xefebff },
    { 556, 44, 0xf7f3ff },
  }
  local result = multiColorS(list)
  if not __keepScreenState then keepScreen(false) end
  return result
end

-- 检测是第几队
battle.scanMapCheckFleetNum = function()
  local __keepScreenState = keepScreenState
  keepScreen(true)
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
  if multiColorS(list1) then
    result = 1
  elseif multiColorS(list2) then
    result = 2
  elseif multiColorS(list3) then
    result = 3
  elseif multiColorS(list4) then
    result = 4
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
  local result = multiColorS(list)
  if not __keepScreenState then keepScreen(false) end
  return result
end

battle.clickSwitchFleetBtn = function()
  tap(1426, 1003, 100)
end

-- 地图点击迎击
battle.clickAttackBtn = function()
  tap(1740, 1005, 100)
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
battle.isNotAutoBattle = function()
  local __keepScreenState = keepScreenState
  if not __keepScreenState then keepScreen(true) end
  local list = {
    { 144, 68, 0xffffff }, { 154, 67, 0xffffff },
    { 154, 76, 0xe6e6e6 }, { 161, 84, 0xffffff },
    { 168, 91, 0xffffff }, { 180, 68, 0xffffff },
    { 180, 86, 0xffffff }, { 195, 78, 0xffffff },
    { 207, 88, 0xffffff }, { 205, 71, 0xffffff },
  }
  local result = multiColorS(list)
  if not __keepScreenState then keepScreen(false) end
  return result
end

-- 检测是否自动战斗确认面板
battle.isAutoBattleConfirmPanel = function()
  local __keepScreenState = keepScreenState
  if not __keepScreenState then keepScreen(true) end
  local list = {
    { 477, 232, 0x292829 }, { 1437, 227, 0xadaaad },
    { 688, 329, 0xf7f7f7 }, { 785, 343, 0xe6e7e6 },
    { 904, 346, 0xfffbff }, { 998, 337, 0xdeebde },
    { 1127, 344, 0xeff3ef }, { 1206, 333, 0xeff3ef },
    { 862, 754, 0xffdb4a }, { 928, 775, 0xffffff },
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
    { 1350, 533, 0xef9e3a }, { 357, 699, 0x424142 },
    { 755, 695, 0x424142 }, { 1183, 701, 0x424142 },
    { 1536, 703, 0x3a3d3a },
  }
  local list2 = {
    { 618, 434, 0xf7ce52 }, { 543, 550, 0xef813a },
    { 629, 522, 0xf7c64a }, { 859, 484, 0xfffb5a },
    { 1238, 552, 0xef813a }, { 1395, 548, 0xef813a },
    { 1390, 480, 0xffff5a }, { 1424, 427, 0xf7be4a },
    { 271, 719, 0x424142 }, { 1651, 728, 0x424142 },
    { 357, 699, 0x424142 }, { 755, 695, 0x424142 },
    { 1183, 701, 0x424142 }, { 1536, 703, 0x3a3d3a },
  }
  local list3 = {
    { 554, 439, 0x73cade }, { 678, 442, 0x84d7e6 },
    { 675, 483, 0xb5f7ff }, { 614, 552, 0x31b2c5 },
    { 856, 471, 0xb5efff }, { 949, 431, 0x6bcade },
    { 1022, 438, 0x8cd7e6 }, { 1161, 458, 0xa4ebf7 },
    { 1237, 489, 0xb5f3ff }, { 1410, 434, 0x7bd7e6 },
    { 357, 699, 0x424142 }, { 755, 695, 0x424142 },
    { 1183, 701, 0x424142 }, { 1536, 703, 0x3a3d3a },
  }
  local list4 = {
    { 559, 447, 0xe6a273 }, { 674, 451, 0xe6ae84 },
    { 848, 469, 0xe6965a }, { 1092, 448, 0x6b2819 },
    { 1179, 451, 0xefcaad }, { 1356, 467, 0x521c08 },
    { 1430, 492, 0xe69e6b }, { 1423, 541, 0xe69e6b },
    { 289, 722, 0x3a3d42 }, { 1627, 727, 0x424142 },
    { 357, 699, 0x424142 }, { 755, 695, 0x424142 },
    { 1183, 701, 0x424142 }, { 1536, 703, 0x3a3d3a },
  }
  -- d 全军覆没
  local list5 = {
    { 544, 437, 0xe69a63 }, { 619, 435, 0xefcaad },
    { 695, 496, 0xe6a673 }, { 848, 473, 0xde6931 },
    { 1028, 467, 0xdebe94 }, { 1162, 474, 0xefceb5 },
    { 1265, 473, 0xe6a273 }, { 1414, 494, 0xe6a273 },
    { 1320, 476, 0xefb694 }, { 1316, 536, 0xefb694 },
    { 289, 722, 0x3a3d42 }, { 1627, 727, 0x424142 },
    { 357, 699, 0x424142 }, { 755, 695, 0x424142 },
    { 1183, 701, 0x424142 }, { 1536, 703, 0x3a3d3a },
  }
  local result = false
  console.log('-----------')
  console.log(multiColorS(list))
  console.log(multiColorS(list2))
  console.log(multiColorS(list3))
  console.log(multiColorS(list4))
  console.log(multiColorS(list5))
  if multiColorS(list) or multiColorS(list2) or multiColorS(list3) or multiColorS(list4) or multiColorS(list5) then
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