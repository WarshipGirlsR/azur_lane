local mapBase = require 'BaseOperate__maps__map'
local img7_4 = require 'BaseOperate__maps__img7_4'
local map7_4 = {}

-- 获取地图采样位置。由于地图可能超出一屏，所以这里可以定义多个采样位置。每次扫描都会对每个采样位置进行扫描
-- 标志位为地图四个角。每个采样位置只需定义一个角的坐标即可。
-- 还需要定义每个采样位置的地图矩阵与屏幕坐标的映射关系
map7_4.getCheckpositionList = function()
  local list = {
    {
      leftTop = nil,
      rightTop = { 1695, 497 },
      leftBotton = nil,
      rightBotton = nil,
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的
      positionMap = {
        { { 341, 497, 0x101821 }, { 508, 497, 0x081019 }, { 677, 497, 0x212031 }, { 846, 497, 0x081419 }, { 1016, 497, 0x111421 }, { 1185, 497, 0x211c29 }, { 1354, 497, 0x111c21 }, { 1523, 497, 0x192532 }, { 1695, 497, 0x192029 }, },
        { { 314, 620, 0x523d10 }, { 490, 620, 0x211c3a }, { 666, 620, 0x212042 }, { 842, 620, 0x212442 }, { 1018, 620, 0x292042 }, { 1194, 620, 0x31284a }, { 1370, 620, 0x29284a }, { 1546, 620, 0x3a3563 }, { 1724, 620, 0x000000 }, },
        { { 288, 753, 0x000000 }, { 470, 753, 0x191829 }, { 654, 753, 0x4a3d19 }, { 837, 753, 0x211c42 }, { 1021, 753, 0x292042 }, { 1204, 753, 0x211c31 }, { 1387, 753, 0x212042 }, { 1571, 753, 0x31244a }, { 1757, 753, 0x000000 }, },
        { { 258, 898, 0x000000 }, { 448, 898, 0x211c42 }, { 640, 898, 0x212042 }, { 831, 898, 0x211831 }, { 1023, 898, 0x211831 }, { 1215, 898, 0x211831 }, { 1407, 898, 0x291c3a }, { 1598, 898, 0x292042 }, { 1792, 898, 0x000000 }, },
      },
      pointMap = {},
    },
    {
      leftTop = nil,
      rightTop = { 1693, 373 },
      leftBotton = nil,
      rightBotton = nil,
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的
      positionMap = {
        false, false, false,
        { { 256, 756, 0x000000 }, { 446, 756, 0x211c42 }, { 638, 756, 0x212042 }, { 831, 756, 0x3a356b }, { 1021, 756, 0x211831 }, { 1213, 756, 0x211831 }, { 1404, 756, 0x292042 }, { 1596, 756, 0x292442 }, { 1790, 756, 0x000000 }, },
        { { 224, 908, 0x000000 }, { 423, 908, 0x191831 }, { 624, 908, 0x211c42 }, { 818, 908, 0x292831 }, { 1024, 908, 0x42517b }, { 1225, 908, 0x191831 }, { 1425, 908, 0x211831 }, { 1626, 908, 0x292042 }, { 1829, 908, 0x000000 }, },
      },
      pointMap = {},
    },
    {
      leftTop = nil,
      rightTop = nil,
      leftBotton = { 503, 895 },
      rightBotton = nil,
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的
      positionMap = {
        false, false, false, false,
        { { 545, 577, 0x000000 }, { 743, 577, 0x19183a }, { 944, 577, 0x191431 }, { 1142, 577, 0x191c21 }, { 1345, 577, 0x6b819c }, },
        { { 525, 727, 0x000000 }, { 734, 727, 0x191431 }, { 944, 727, 0x191429 }, { 1154, 727, 0x191429 }, { 1364, 727, 0x191429 }, },
        { { 503, 895, 0x000000 }, { 722, 895, 0x000000 }, { 943, 895, 0x000000 }, { 1164, 895, 0x000000 }, { 1385, 895, 0x000000 }, },
      },
      pointMap = {},
    },
    {
      leftTop = nil,
      rightTop = nil,
      leftBotton = nil,
      rightBotton = { 1681, 898 },
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的
      positionMap = {
        false, false, false, false,
        { false, false, false, false, { 808, 580, 0x52598c }, { 1010, 580, 0x211c3a }, { 1211, 580, 0x211831 }, { 1411, 580, 0x21203a }, { 1614, 580, 0x000000 }, },
        { false, false, false, false, { 803, 730, 0x191831 }, { 1013, 730, 0x191829 }, { 1223, 730, 0x191831 }, { 1433, 730, 0x211831 }, { 1646, 730, 0x000000 }, },
        { false, false, false, false, { 794, 898, 0x000000 }, { 1016, 898, 0x000000 }, { 1236, 898, 0x000000 }, { 1457, 898, 0x000000 }, { 1681, 898, 0x000000 }, },
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
map7_4.getMapChessboard = function()
  return {
    width = 8,
    height = 6,
    obstacle = {
      { 1, 5 }, { 1, 6 }, { 1, 7 },
      { 3, 2 },
      { 4, 2 }, { 4, 3 }, { 4, 4 },
      { 5, 4 }, { 5, 6 },
    },
    waitForBossPosition = { { 3, 4 } },
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

map7_4.getMapPosition = function(currentPosition)
  return mapBase.getMapPosition(img7_4, currentPosition)
end

map7_4.getMoveVector = function(currentPosition, targetPosition)
  return mapBase.getMoveVector(img7_4, currentPosition, targetPosition)
end

map7_4.moveMapToCheckPosition = function(moveVector)
  return mapBase.moveMapToCheckPosition(img7_4, moveVector)
end

map7_4.scanMap = function(targetPosition, mapChessboard)
  return mapBase.scanMap(img7_4, targetPosition, mapChessboard)
end

map7_4.moveToPoint = function(targetPosition, point)
  return mapBase.moveToPoint(img7_4, targetPosition, point)
end

map7_4.checkMoveToPointPath = function(mapChessboard, start, target)
  return mapBase.checkMoveToPointPath(map7_4, mapChessboard, start, target)
end

map7_4.findClosestEnemy = function(mapChessboard)
  return mapBase.findClosestEnemy(img7_4, mapChessboard)
end

return map7_4