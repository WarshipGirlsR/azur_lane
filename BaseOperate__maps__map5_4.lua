local mapBase = require 'BaseOperate__maps__map'
local img5_4 = require 'BaseOperate__maps__img5_4'
local map5_4 = {}

-- 获取地图采样位置。由于地图可能超出一屏，所以这里可以定义多个采样位置。每次扫描都会对每个采样位置进行扫描
-- 标志位为地图四个角。每个采样位置只需定义一个角的坐标即可。
-- 还需要定义每个采样位置的地图矩阵与屏幕坐标的映射关系
map5_4.getCheckpositionList = function()
  local list = {
    {
      leftTop = { 335, 475 },
      rightTop = nil,
      leftBotton = nil,
      rightBotton = nil,
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的
      positionMap = {
        { { 335, 475, 0x294152 }, { 509, 475, 0x29414a }, { 685, 475, 0x29414a }, { 861, 475, 0x29414a }, { 1037, 475, 0x29414a }, { 1214, 475, 0x293542 }, { 1390, 475, 0x213542 }, { 1566, 475, 0x213142 }, { 1744, 475, 0x213042 }, },
        { { 308, 601, 0x000000 }, { 490, 601, 0x117994 }, { 674, 601, 0x427d63 }, { 857, 601, 0x218194 }, { 1041, 601, 0x217994 }, { 1224, 601, 0x19758c }, { 1408, 601, 0x19798c }, { 1591, 601, 0x218194 }, { 1777, 601, 0x000000 }, },
        { { 279, 739, 0x000000 }, { 470, 739, 0x19798c }, { 661, 739, 0x19818c }, { 853, 739, 0x198194 }, { 1044, 739, 0x109ebd }, { 1236, 739, 0x105d84 }, { 1428, 739, 0x195d84 }, { 1619, 739, 0x217194 }, { 1813, 739, 0x000000 }, },
        { { 248, 890, 0x000000 }, { 447, 890, 0x297594 }, { 648, 890, 0x317594 }, { 848, 890, 0x196184 }, { 1048, 890, 0xada6a4 }, { 1249, 890, 0x8cebad }, { 1449, 890, 0x214d7b }, { 1650, 890, 0x315584 }, { 1852, 890, 0x000000 }, },
      },
      pointMap = {},
    },
    {
      leftTop = nil,
      rightTop = nil,
      leftBotton = { 365, 885 },
      rightBotton = nil,
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的
      positionMap = {
        false, false, false,
        { { 420, 568, 0x000000 }, { 619, 568, 0x29758c }, { 820, 568, 0x31759c }, { 1020, 568, 0x21618c }, { 1221, 568, 0xada6a4 }, },
        { { 394, 718, 0x000000 }, { 603, 718, 0x19658c }, { 813, 718, 0x216d8c }, { 1023, 718, 0x115984 }, { 1233, 718, 0x003d73 }, },
        { { 365, 885, 0x000000 }, { 585, 885, 0x000000 }, { 806, 885, 0x000000 }, { 1026, 885, 0x000000 }, { 1247, 885, 0x000000 }, },
      },
      pointMap = {},
    },
    {
      leftTop = nil,
      rightTop = nil,
      leftBotton = nil,
      rightBotton = { 1738, 885 },
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的
      positionMap = {
        false, false, false,
        { false, false, false, false, { 862, 568, 0xb5aaad }, { 1064, 568, 0x73c68c }, { 1263, 568, 0x214d73 }, { 1463, 568, 0x215184 }, { 1666, 568, 0x000000 }, },
        { false, false, false, false, { 858, 718, 0x19417b }, { 1068, 718, 0x214584 }, { 1277, 718, 0x214d7b }, { 1488, 718, 0x31518c }, { 1700, 718, 0x000000 }, },
        { false, false, false, false, { 852, 885, 0x000000 }, { 1073, 885, 0x000000 }, { 1294, 885, 0x000000 }, { 1515, 885, 0x000000 }, { 1738, 885, 0x000000 }, },
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
map5_4.getMapChessboard = function()
  return {
    width = 8,
    height = 5,
    obstacle = {
      { 1, 1 }, { 1, 2 }, { 1, 3 }, { 1, 4 },
      { 3, 4 }, { 3, 5 }, { 4, 5 },
      { 5, 1 }, { 5, 2 },
    },
    waitForBossPosition = { { 4, 6 }, },
    bossPosition = {},
    myFleetList = {},
    enemyPositionList1 = {},
    enemyPositionList2 = {},
    enemyPositionList3 = {},
    inBattleList = {},
    selectedArrowList = {},
    rewardBoxList = {},
  }
end



map5_4.getMapPosition = function(currentPosition)
  return mapBase.getMapPosition(img5_4, currentPosition)
end

map5_4.getMoveVector = function(currentPosition, targetPosition)
  return mapBase.getMoveVector(img5_4, currentPosition, targetPosition)
end

map5_4.moveMapToCheckPosition = function(moveVector)
  return mapBase.moveMapToCheckPosition(img5_4, moveVector)
end

map5_4.scanMap = function(targetPosition, mapChessboard)
  return mapBase.scanMap(img5_4, targetPosition, mapChessboard)
end

map5_4.moveToPoint = function(targetPosition, point)
  return mapBase.moveToPoint(img5_4, targetPosition, point)
end

map5_4.checkMoveToPointPath = function(mapChessboard, start, target)
  return mapBase.checkMoveToPointPath(map5_4, mapChessboard, start, target)
end

map5_4.findClosestEnemy = function(mapChessboard)
  return mapBase.findClosestEnemy(img5_4, mapChessboard)
end

map5_4.getRandomMoveAStep = function(mapChessboard)
  return mapBase.getRandomMoveAStep(img5_4, mapChessboard)
end

return map5_4