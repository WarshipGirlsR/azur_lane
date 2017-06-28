local ImgInfo = require 'BaseOperate__ImgInfo'

local battle = {}


--  是否在出击界面
battle.isBattlePage = function()
  local __keepScreenState = keepScreenState
  if (not __keepScreenState) then keepScreen(true) end
  local list = {
    { 14, 14, 0xe6e3ef },
    { 184, 21, 0xf7ebbd },
    { 213, 27, 0x292829 },
    { 311, 12, 0x424142 },
    { 797, 15, 0xeff3f7 },
    { 262, 1008, 0xce1021 },
    { 1080, 1018, 0xa4c6ef },
    { 1165, 1009, 0x424552 },
    { 1435, 920, 0x9496b5 },
    { 1569, 1017, 0x292831 },
    { 1722, 935, 0xffebde },
    { 1812, 1022, 0x312d31 },
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
    { 97, 38, 0xd6dbd6 }, { 421, 43, 0x000000 },
    { 428, 47, 0xdeebf7 }, { 458, 44, 0xf7f3ff },
    { 557, 44, 0xefefff }, { 794, 36, 0xdedfde },
    { 1051, 990, 0xc51019 }, { 1178, 1026, 0x631010 },
    { 1088, 1015, 0xf7f7f7 }, { 1279, 997, 0x424142 },
    { 1374, 1009, 0xf7fbf7 }, { 1425, 1011, 0x292829 },
    { 1526, 1013, 0x212829 }, { 1611, 966, 0xc58142 },
    { 1739, 995, 0xe6e7e6 }, { 1843, 1017, 0x6b4110 },
  }
  local result = multiColor(list)
  if (not __keepScreenState) then keepScreen(false) end
  return result
end

battle.scanMap = function()
  local __keepScreenState = keepScreenState
  if (not __keepScreenState) then keepScreen(true) end

  while (true) do
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
      X = math.tureNumber(X) or -1
      X = math.floor(X)
      return { X, Y }
    end

    local leftLinePoint = getCenterPoint(topLinePoint, bottonLinePoint, leftLinePointList)
    local rightLinePoint = getCenterPoint(topLinePoint, bottonLinePoint, rightLinePointList)

    -- 将地图移动到中心
    -- 计算偏差
    local moveVector = { 0, 0 }
    if (topLinePoint[2] ~= -1) then
      moveVector[2] = 379 - topLinePoint[2]
    elseif (bottonLinePoint[2] ~= -1) then
      moveVector[2] = 979 - bottonLinePoint[2]
    end
    if (leftLinePoint[1] ~= -1) then
      moveVector[1] = 208 - leftLinePoint[1]
    elseif (rightLinePoint[1] ~= -1) then
      moveVector[1] = 1826 - rightLinePoint[1]
    end
    -- 移动地图
    if ((math.abs(moveVector[1]) > 10) or (math.abs(moveVector[2]) > 10)) then
      moveTo(540, 960, 540 + moveVector[1], 960 + moveVector[2], 10, 100)
      mSleep(100)
    else
      break
    end
  end



  console.log('ok')
  if (not __keepScreenState) then keepScreen(false) end
end

return battle