local mapBase = require 'BaseOperate__maps__map'
local imgevent6_1_sp3 = require 'BaseOperate__maps__imgevent6_1_sp3'
local mapevent6_1_sp3 = {}

-- 获取地图采样位置。由于地图可能超出一屏，所以这里可以定义多个采样位置。每次扫描都会对每个采样位置进行扫描
-- 标志位为地图四个角。每个采样位置只需定义一个角的坐标即可。
-- 还需要定义每个采样位置的地图矩阵与屏幕坐标的映射关系
mapevent6_1_sp3.getCheckpositionList = function()
  local list = {
    {
      leftTop = { 266, 515 },
      rightTop = nil,
      leftBotton = nil,
      rightBotton = nil,
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的
      positionMap = {
        { { 266, 515, 0x103542 }, { 428, 515, 0x103542 }, { 591, 515, 0x21414a }, { 754, 515, 0x193942 }, { 917, 515, 0x213d4a }, { 1080, 515, 0x193542 }, { 1243, 515, 0x213d4a }, { 1405, 515, 0x19414a }, { 1568, 515, 0x103942 }, { 1733, 515, 0x21414a }, },
        { { 240, 633, 0x000000 }, { 408, 633, 0x19718c }, { 577, 633, 0x217194 }, { 746, 633, 0x217d84 }, { 915, 633, 0x218194 }, { 1084, 633, 0x19758c }, { 1253, 633, 0x217d8c }, { 1423, 633, 0x6ba6bd }, { 1592, 633, 0x19798c }, { 1763, 633, 0x000000 }, },
        { { 210, 761, 0x000000 }, { 385, 761, 0x217d94 }, { 563, 761, 0xdeaa00 }, { 737, 761, 0x217d8c }, { 913, 761, 0x217d94 }, { 1089, 761, 0x21698c }, { 1265, 761, 0x21698c }, { 1441, 761, 0x217194 }, { 1617, 761, 0x218194 }, { 1795, 761, 0x000000 }, },
        { { 179, 900, 0x000000 }, { 361, 900, 0x312819 }, { 544, 900, 0x218194 }, { 728, 900, 0x217594 }, { 911, 900, 0x086d84 }, { 1095, 900, 0x08597b }, { 1278, 900, 0x216184 }, { 1462, 900, 0x216d8c }, { 1645, 900, 0x196d8c }, { 1831, 900, 0x000000 }, },
      },
      pointMap = {},
    },
    {
      leftTop = { 381, 290 },
      rightTop = nil,
      leftBotton = nil,
      rightBotton = nil,
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的
      positionMap = {
        false, false, false,
        { { 308, 648, 0x000000 }, { 490, 648, 0xe6aa00 }, { 673, 648, 0x197d8c }, { 857, 648, 0x19718c }, { 1040, 648, 0x216d8c }, { 1224, 648, 0x215594 }, { 1408, 648, 0x21618c }, { 1591, 648, 0x19698c }, },
        { { 279, 788, 0x000000 }, { 469, 788, 0x216d94 }, { 661, 788, 0x216d94 }, { 853, 788, 0x106d8c }, { 1044, 788, 0x195184 }, { 1236, 788, 0x194d84 }, { 1428, 788, 0x214984 }, { 1619, 788, 0x215d84 }, },
        { { 248, 941, 0x000000 }, { 447, 941, 0x296194 }, { 647, 941, 0x316594 }, { 847, 941, 0x10618c }, { 1048, 941, 0xa44d4a }, { 1248, 941, 0x004173 }, { 1450, 941, 0x292419 }, { 1651, 941, 0x192029 }, },
      },
      pointMap = {},
    },
    {
      leftTop = nil,
      rightTop = nil,
      leftBotton = { 356, 912 },
      rightBotton = nil,
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的
      positionMap = {
        false, false, false, false, false,
        { { 412, 592, 0x000000 }, { 611, 592, 0x21618c }, { 811, 592, 0x21658c }, { 1012, 592, 0x21658c }, { 1213, 592, 0x115173 }, },
        { { 386, 743, 0x000000 }, { 594, 743, 0x19618c }, { 804, 743, 0x08517b }, { 1014, 743, 0x08557b }, { 1225, 743, 0x104d7b }, },
        { { 356, 912, 0x000000 }, { 576, 912, 0x000000 }, { 797, 912, 0x000000 }, { 1018, 912, 0x000000 }, { 1239, 912, 0x000000 }, },
      },
      pointMap = {},
    },
    {
      leftTop = nil,
      rightTop = nil,
      leftBotton = nil,
      rightBotton = { 1708, 915 },
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的
      positionMap = {
        false, false, false, false, false,
        { false, false, false, false, { 633, 594, 0x085173 }, { 834, 594, 0x194d8c }, { 1034, 594, 0x21498c }, { 1235, 594, 0x29497b }, { 1436, 594, 0x3a5184 }, { 1638, 594, 0x000000 }, },
        { false, false, false, false, { 618, 746, 0x194d84 }, { 828, 746, 0x193d73 }, { 1038, 746, 0xa4ceef }, { 1248, 746, 0x214d84 }, { 1459, 746, 0x29497b }, { 1671, 746, 0x000000 }, },
        { false, false, false, false, { 600, 915, 0x000000 }, { 821, 915, 0x000000 }, { 1042, 915, 0x000000 }, { 1263, 915, 0x000000 }, { 1484, 915, 0x080c08 }, { 1708, 915, 0x080c08 }, },
      },
      pointMap = {},
    },
  }
  for key = 1, #list do
    local positionMap = list[key].positionMap
    for rowNum, rol in ipairs(positionMap) do
      if rol and positionMap[rowNum + 1] then
        for colNum, col in ipairs(rol) do
          if col and rol[colNum + 1] then
            list[key].pointMap[rowNum .. '-' .. colNum] = col
          end
        end
      end
    end
  end
  return list
end

-- 获取地图棋盘和相关数据
mapevent6_1_sp3.getMapChessboard = function()
  return {
    width = 9,
    height = 7,
    obstacle = {
      { 1, 4 }, { 1, 5 }, { 1, 8 },
      { 2, 2 }, { 3, 5 }, { 3, 7 },
      { 4, 4 }, { 4, 8 }, { 4, 9 },
      { 5, 1 }, { 5, 8 }, { 5, 9 },
      { 6, 5 }, { 6, 6 },
      { 7, 3 },
    },
    waitForBossPosition = { { 4, 7 } },
    bossPosition = {},
    myFleetList = {},
    enemyPositionList1 = {},
    enemyPositionList2 = {},
    enemyPositionList3 = {},
    inBattleList = {},
    selectedArrowList = {},
  }
end

mapevent6_1_sp3.getMapPosition = function(currentPosition)
  return mapBase.getMapPosition(imgevent6_1_sp3, currentPosition)
end

mapevent6_1_sp3.getMoveVector = function(currentPosition, targetPosition)
  return mapBase.getMoveVector(imgevent6_1_sp3, currentPosition, targetPosition)
end

mapevent6_1_sp3.moveMapToCheckPosition = function(moveVector)
  return mapBase.moveMapToCheckPosition(imgevent6_1_sp3, moveVector)
end

mapevent6_1_sp3.scanMap = function(targetPosition, mapChessboard)
  return mapBase.scanMap(imgevent6_1_sp3, targetPosition, mapChessboard)
end

mapevent6_1_sp3.moveToPoint = function(targetPosition, point)
  return mapBase.moveToPoint(imgevent6_1_sp3, targetPosition, point)
end

mapevent6_1_sp3.checkMoveToPointPath = function(mapChessboard, start, target)
  return mapBase.checkMoveToPointPath(imgevent6_1_sp3, mapChessboard, start, target)
end

mapevent6_1_sp3.findClosestEnemy = function(mapChessboard)
  return mapBase.findClosestEnemy(imgevent6_1_sp3, mapChessboard)
end

return mapevent6_1_sp3