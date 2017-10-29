local mapBase = require 'BaseOperate__maps__map'
local imgevent6_1_sp2 = require 'BaseOperate__maps__imgevent6_1_sp2'
local mapevent6_1_sp2 = {}

-- 获取地图采样位置。由于地图可能超出一屏，所以这里可以定义多个采样位置。每次扫描都会对每个采样位置进行扫描
-- 标志位为地图四个角。每个采样位置只需定义一个角的坐标即可。
-- 还需要定义每个采样位置的地图矩阵与屏幕坐标的映射关系
mapevent6_1_sp2.getCheckpositionList = function()
  local list = {
    {
      leftTop = { 532, 486 },
      rightTop = nil,
      leftBotton = nil,
      rightBotton = nil,
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的
      positionMap = {
        { { 532, 486, 0x9cc6ff }, { 709, 486, 0x193142 }, { 885, 486, 0x193542 }, { 1061, 486, 0x193542 }, { 1237, 486, 0x213542 }, { 1413, 486, 0x193542 }, },
        { { 516, 613, 0x000000 }, { 698, 613, 0x116984 }, { 882, 613, 0x197184 }, { 1065, 613, 0x218194 }, { 1249, 613, 0x21698c }, { 1432, 613, 0x19698c }, },
        { { 496, 752, 0xe6aa00 }, { 687, 752, 0x21798c }, { 878, 752, 0x21818c }, { 1070, 752, 0x217d8c }, { 1262, 752, 0x318694 }, { 1453, 752, 0x10597b }, },
        { { 475, 904, 0x000000 }, { 674, 904, 0x296d9c }, { 874, 904, 0x317594 }, { 1075, 904, 0x196584 }, { 1277, 904, 0xd68a42 }, { 1476, 904, 0x194984 }, },
      },
      pointMap = {},
    },
    {
      leftTop = nil,
      rightTop = { 1664, 484 },
      leftBotton = nil,
      rightBotton = nil,
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的
      positionMap = {
        { false, false, false, false, false, { 957, 484, 0x193542 }, { 1134, 484, 0x21394a }, { 1310, 484, 0x21394a }, { 1486, 484, 0x21394a }, { 1664, 484, 0x213852 }, },
        { false, false, false, false, false, { 957, 611, 0x19718c }, { 1141, 611, 0x197594 }, { 1325, 611, 0x298194 }, { 1508, 611, 0x197984 }, { 1694, 611, 0x000000 }, },
        { false, false, false, false, false, { 957, 750, 0x08597b }, { 1149, 750, 0x196584 }, { 1341, 750, 0x196984 }, { 1533, 750, 0x196d8c }, { 1726, 750, 0x000000 }, },
        { false, false, false, false, false, { 957, 901, 0x21497b }, { 1157, 901, 0x734129 }, { 1358, 901, 0x195d84 }, { 1558, 901, 0x215984 }, { 1761, 901, 0x000000 }, },
      },
      pointMap = {},
    },
    {
      leftTop = nil,
      rightTop = nil,
      leftBotton = { 349, 897 },
      rightBotton = nil,
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的
      positionMap = {
        false, false, false,
        { { 406, 579, 0x000000 }, { 605, 579, 0x216d94 }, { 805, 579, 0x317594 }, { 1005, 579, 0x216d8c }, { 1206, 579, 0xbd7131 }, { 1407, 579, 0x21497b }, },
        { { 379, 729, 0x000000 }, { 587, 729, 0x19618c }, { 797, 729, 0x215d8c }, { 1008, 729, 0x085984 }, { 1218, 729, 0x00416b }, { 1428, 729, 0x003d6b }, },
        { { 349, 897, 0x000000 }, { 568, 897, 0x000000 }, { 789, 897, 0x000000 }, { 1010, 897, 0x000000 }, { 1231, 897, 0x000000 }, { 1452, 897, 0x000000 }, },
      },
      pointMap = {},
    },
    {
      leftTop = nil,
      rightTop = nil,
      leftBotton = nil,
      rightBotton = { 1851, 894 },
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的
      positionMap = {
        false, false, false,
        { false, false, false, false, false, { 964, 576, 0x194984 }, { 1164, 576, 0x291c21 }, { 1365, 576, 0x215d84 }, { 1566, 576, 0x316194 }, { 1769, 576, 0x000000 }, },
        { false, false, false, false, false, { 964, 726, 0x19417b }, { 1174, 726, 0x214584 }, { 1385, 726, 0x104573 }, { 1595, 726, 0x9ccaef }, { 1808, 726, 0x000000 }, },
        { false, false, false, false, false, { 966, 894, 0x193d63 }, { 1186, 894, 0x000000 }, { 1407, 894, 0x000000 }, { 1628, 894, 0x000000 }, { 1851, 894, 0x000000 }, },
      },
      pointMap = {},
    },
  }

  for key, value in ipairs(list) do
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
mapevent6_1_sp2.getMapChessboard = function()
  return {
    width = 9,
    height = 7,
    obstacle = {},
    waitForBossPosition = {},
    bossPosition = {},
    myFleetList = {},
    enemyPositionList = {},
    inBattleList = {},
    selectedArrowList = {},
  }
end

mapevent6_1_sp2.getMapPosition = function(currentPosition)
  return mapBase.getMapPosition(imgevent6_1_sp2, currentPosition)
end

mapevent6_1_sp2.getMoveVector = function(currentPosition, targetPosition)
  return mapBase.getMoveVector(imgevent6_1_sp2, currentPosition, targetPosition)
end

mapevent6_1_sp2.moveMapToCheckPosition = function(moveVector)
  return mapBase.moveMapToCheckPosition(imgevent6_1_sp2, moveVector)
end

mapevent6_1_sp2.scanMap = function(targetPosition, mapChessboard)
  return mapBase.scanMap(imgevent6_1_sp2, targetPosition, mapChessboard)
end

mapevent6_1_sp2.moveToPoint = function(targetPosition, point)
  return mapBase.moveToPoint(imgevent6_1_sp2, targetPosition, point)
end

mapevent6_1_sp2.checkMoveToPointPath = function(mapChessboard, start, target)
  return mapBase.checkMoveToPointPath(mapevent6_1_sp2, mapChessboard, start, target)
end

mapevent6_1_sp2.findClosestEnemy = function(mapChessboard)
  return mapBase.findClosestEnemy(imgevent6_1_sp2, mapChessboard)
end

return mapevent6_1_sp2