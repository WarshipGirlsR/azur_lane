local mapBase = require 'BaseOperate__maps__map'
local img6_2 = require 'BaseOperate__maps__img6_2'
local map6_2 = {}

-- 获取地图采样位置。由于地图可能超出一屏，所以这里可以定义多个采样位置。每次扫描都会对每个采样位置进行扫描
-- 标志位为地图四个角。每个采样位置只需定义一个角的坐标即可。
-- 还需要定义每个采样位置的地图矩阵与屏幕坐标的映射关系
map6_2.getCheckpositionList = function()
  local list = {
    {
      leftTop = nil,
      rightTop = { 1719, 473 },
      leftBotton = nil,
      rightBotton = nil,
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的
      positionMap = {
        { { 365, 473, 0x211c29 }, { 533, 473, 0x211829 }, { 703, 473, 0x191c29 }, { 872, 473, 0x191829 }, { 1041, 473, 0x212031 }, { 1211, 473, 0x21283a }, { 1380, 473, 0x191c29 }, { 1549, 473, 0x212431 }, { 1719, 473, 0x21243a }, },
        { { 341, 594, 0x000000 }, { 516, 594, 0x211c3a }, { 692, 594, 0x212042 }, { 868, 594, 0x212442 }, { 1044, 594, 0x292042 }, { 1220, 594, 0x292442 }, { 1397, 594, 0x212442 }, { 1572, 594, 0x3a3563 }, { 1750, 594, 0x000000 }, },
        { { 314, 726, 0x000000 }, { 498, 726, 0x21203a }, { 681, 726, 0x21203a }, { 865, 726, 0x211c3a }, { 1048, 726, 0x525584 }, { 1231, 726, 0x292042 }, { 1415, 726, 0x211c42 }, { 1598, 726, 0x31244a }, { 1783, 726, 0x000000 }, },
        { { 286, 870, 0x000000 }, { 477, 870, 0x191831 }, { 669, 870, 0x191831 }, { 860, 870, 0x211c3a }, { 1051, 870, 0xe6e7de }, { 1242, 870, 0x424d7b }, { 1434, 870, 0x292042 }, { 1627, 870, 0x29203a }, { 1820, 870, 0x000000 }, },
      },
      pointMap = {},
    },
    {
      leftTop = nil,
      rightTop = nil,
      leftBotton = { 357, 884 },
      rightBotton = nil,
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的
      positionMap = {
        false, false, false,
        { { 437, 430, 0x000000 }, { 628, 430, 0x211c42 }, { 819, 430, 0x191831 }, { 1011, 430, 0x211831 }, { 1203, 430, 0x292431 }, },
        { { 413, 567, 0x000000 }, { 612, 567, 0x191429 }, { 813, 567, 0x19183a }, { 1013, 567, 0x191831 }, { 1214, 567, 0x191831 }, },
        { { 386, 717, 0x000000 }, { 595, 717, 0x19183a }, { 805, 717, 0x211842 }, { 1016, 717, 0x191429 }, { 1226, 717, 0x191429 }, },
        { { 357, 884, 0x000000 }, { 577, 884, 0x000000 }, { 798, 884, 0x000000 }, { 1019, 884, 0x000000 }, { 1240, 884, 0x000000 }, },
      },
      pointMap = {},
    },
    {
      leftTop = nil,
      rightTop = nil,
      leftBotton = nil,
      rightBotton = { 1697, 885 },
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的
      positionMap = {
        false, false, false,
        { false, false, false, false, { 829, 431, 0x212431 }, { 1021, 431, 0x42497b }, { 1214, 431, 0x191831 }, { 1405, 431, 0x29203a }, { 1599, 431, 0x000000 }, },
        { false, false, false, false, { 825, 567, 0x211c3a }, { 1025, 567, 0x191c31 }, { 1226, 567, 0x191831 }, { 1426, 567, 0x211c31 }, { 1628, 567, 0x000000 }, },
        { false, false, false, false, { 818, 717, 0x191429 }, { 1028, 717, 0x191429 }, { 1238, 717, 0x191829 }, { 1448, 717, 0x191831 }, { 1661, 717, 0x000000 }, },
        { false, false, false, false, { 811, 885, 0x000000 }, { 1032, 885, 0x000000 }, { 1253, 885, 0x000000 }, { 1474, 885, 0x000000 }, { 1697, 885, 0x000000 }, },
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
map6_2.getMapChessboard = function()
  return {
    width = 8,
    height = 6,
    obstacle = {
      { 4, 1 },
      { 4, 2 },
      { 5, 1 },
      { 5, 2 },
      { 5, 6 },
    },
    waitForBossPosition = { { 4, 3 } },
    bossPosition = {},
    myFleetList = {},
    enemyPositionList = {},
  }
end

map6_2.getMapPosition = function()
  return mapBase.getMapPosition(img6_2)
end

map6_2.getMoveVector = function(currentPosition, targetPosition)
  return mapBase.getMoveVector(img6_2, currentPosition, targetPosition)
end

map6_2.moveMapToCheckPosition = function(moveVector)
  return mapBase.moveMapToCheckPosition(img6_2, moveVector)
end

map6_2.scanMap = function(targetPosition, mapChessboard)
  return mapBase.scanMap(img6_2, targetPosition, mapChessboard)
end

map6_2.moveToPoint = function(targetPosition, point)
  return mapBase.moveToPoint(img6_2, targetPosition, point)
end

map6_2.findClosestEnemy = function(mapChessboard)
  return mapBase.findClosestEnemy(img6_2, mapChessboard)
end

return map6_2