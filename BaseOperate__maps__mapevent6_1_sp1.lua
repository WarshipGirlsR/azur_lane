local mapBase = require 'BaseOperate__maps__map'
local imgevent6_1_sp1 = require 'BaseOperate__maps__imgevent6_1_sp1'
local mapevent6_1_sp1 = {}

-- 获取地图采样位置。由于地图可能超出一屏，所以这里可以定义多个采样位置。每次扫描都会对每个采样位置进行扫描
-- 标志位为地图四个角。每个采样位置只需定义一个角的坐标即可。
-- 还需要定义每个采样位置的地图矩阵与屏幕坐标的映射关系
mapevent6_1_sp1.getCheckpositionList = function()
  local list = {
    {
      leftTop = { 314, 456 },
      rightTop = nil,
      leftBotton = nil,
      rightBotton = nil,
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的
      positionMap = {
        { { 314, 456, 0x193d4a }, { 489, 456, 0x193d4a }, { 665, 456, 0x193d4a }, { 840, 456, 0x9cc2f7 }, { 1018, 456, 0x8cc2ff }, { 1194, 456, 0x214552 }, { 1370, 456, 0x214552 }, { 1546, 456, 0x214552 }, { 1724, 456, 0x214552 }, },
        { { 287, 582, 0x000000 }, { 469, 582, 0x196d94 }, { 653, 582, 0x19718c }, { 837, 582, 0x217d8c }, { 1020, 582, 0x217994 }, { 1204, 582, 0x21798c }, { 1387, 582, 0x298194 }, { 1571, 582, 0x217d94 }, { 1757, 582, 0x000000 }, },
        { { 258, 719, 0x000000 }, { 448, 719, 0x217984 }, { 641, 719, 0xffffff }, { 831, 719, 0x292429 }, { 1023, 719, 0x21718c }, { 1215, 719, 0x216d94 }, { 1406, 719, 0x19698c }, { 1598, 719, 0x19758c }, { 1792, 719, 0x000000 }, },
        { { 225, 869, 0x000000 }, { 424, 869, 0x19798c }, { 625, 869, 0x317d94 }, { 825, 869, 0x217184 }, { 1025, 869, 0xceefff }, { 1226, 869, 0x194d73 }, { 1427, 869, 0x196184 }, { 1627, 869, 0x19698c }, { 1830, 869, 0x000000 }, },
      },
      pointMap = {},
    },
    {
      leftTop = { 315, 349 },
      rightTop = nil,
      leftBotton = nil,
      rightBotton = nil,
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的
      positionMap = {
        false, false, false,
        { { 226, 747, 0x000000 }, { 425, 747, 0x197d8c }, { 625, 747, 0x298194 }, { 826, 747, 0x086984 }, { 1027, 747, 0xbde3ff }, { 1227, 747, 0x214d84 }, { 1428, 747, 0x195d84 }, { 1628, 747, 0x196184 }, { 1831, 747, 0x000000 }, },
        { { 190, 906, 0x000000 }, { 399, 906, 0x296194 }, { 610, 906, 0x296994 }, { 819, 906, 0x085984 }, { 1029, 906, 0x084973 }, { 1240, 906, 0x214984 }, { 1450, 906, 0x29518c }, { 1660, 906, 0x3a5184 }, { 1873, 906, 0x000000 }, },
      },
      pointMap = {},
    },
    {
      leftTop = nil,
      rightTop = nil,
      leftBotton = { 483, 909 },
      rightBotton = nil,
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的
      positionMap = {
        false, false, false, false,
        { { 529, 574, 0x000000 }, { 738, 574, 0x3a659c }, { 948, 574, 0x296994 }, { 1158, 574, 0x215d8c }, { 1368, 574, 0x195184 }, },
        { { 507, 732, 0xbde3ff }, { 726, 732, 0x216994 }, { 947, 732, 0x105984 }, { 1168, 732, 0x21618c }, { 1389, 732, 0x105984 }, },
        { { 483, 909, 0x000000 }, { 714, 909, 0x082442 }, { 947, 909, 0x000000 }, { 1180, 909, 0x000000 }, { 1413, 909, 0x000000 }, },
      },
      pointMap = {},
    },
    {
      leftTop = nil,
      rightTop = nil,
      leftBotton = nil,
      rightBotton = { 1702, 911 },
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的
      positionMap = {
        false, false, false, false,
        { false, false, false, false, { 787, 576, 0x084973 }, { 996, 576, 0x214984 }, { 1207, 576, 0x214973 }, { 1417, 576, 0x314d84 }, { 1630, 576, 0x000000 }, },
        { false, false, false, false, { 777, 734, 0x10597b }, { 998, 734, 0x21417b }, { 1219, 734, 0x104573 }, { 1441, 734, 0x94c6ef }, { 1664, 734, 0x000000 }, },
        { false, false, false, false, { 769, 911, 0x000000 }, { 1001, 911, 0x000000 }, { 1234, 911, 0x000000 }, { 1467, 911, 0x000000 }, { 1702, 911, 0x000000 }, },
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
mapevent6_1_sp1.getMapChessboard = function()
  return {
    width = 8,
    height = 6,
    obstacle = {
      { 1, 4 },
      { 2, 7 },
      { 3, 1 }, { 3, 2 }, { 3, 3 }, { 3, 4 }, { 3, 5 },
      { 4, 4 }, { 4, 5 },
      { 5, 7 },
      { 6, 1 },
    },
    waitForBossPosition = {},
    bossPosition = {},
    myFleetList = {},
    enemyPositionList1 = {},
    enemyPositionList2 = {},
    enemyPositionList3 = {},
    inBattleList = {},
    selectedArrowList = {},
  }
end

mapevent6_1_sp1.getMapPosition = function(currentPosition)
  return mapBase.getMapPosition(imgevent6_1_sp1, currentPosition)
end

mapevent6_1_sp1.getMoveVector = function(currentPosition, targetPosition)
  return mapBase.getMoveVector(imgevent6_1_sp1, currentPosition, targetPosition)
end

mapevent6_1_sp1.moveMapToCheckPosition = function(moveVector)
  return mapBase.moveMapToCheckPosition(imgevent6_1_sp1, moveVector)
end

mapevent6_1_sp1.scanMap = function(targetPosition, mapChessboard)
  return mapBase.scanMap(imgevent6_1_sp1, targetPosition, mapChessboard)
end

mapevent6_1_sp1.moveToPoint = function(targetPosition, point)
  return mapBase.moveToPoint(imgevent6_1_sp1, targetPosition, point)
end

mapevent6_1_sp1.checkMoveToPointPath = function(mapChessboard, start, target)
  return mapBase.checkMoveToPointPath(mapevent6_1_sp1, mapChessboard, start, target)
end

mapevent6_1_sp1.findClosestEnemy = function(mapChessboard)
  return mapBase.findClosestEnemy(imgevent6_1_sp1, mapChessboard)
end

return mapevent6_1_sp1
