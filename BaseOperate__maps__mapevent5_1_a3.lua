local mapBase = require 'BaseOperate__maps__map'
local imgevent5_1_a3 = require 'BaseOperate__maps__imgevent5_1_a3'
local mapevent5_1_a3 = {}

-- 获取地图采样位置。由于地图可能超出一屏，所以这里可以定义多个采样位置。每次扫描都会对每个采样位置进行扫描
-- 标志位为地图四个角。每个采样位置只需定义一个角的坐标即可。
-- 还需要定义每个采样位置的地图矩阵与屏幕坐标的映射关系
mapevent5_1_a3.getCheckpositionList = function()
  local list = {
    {
      leftTop = { 365, 512 },
      rightTop = nil,
      leftBotton = nil,
      rightBotton = nil,
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的
      positionMap = {
        { { 365, 512, 0x3a2d29 }, { 527, 512, 0x312821 }, { 691, 512, 0x293142 }, { 855, 512, 0x524131 }, { 1018, 512, 0x8c5d52 }, { 1182, 512, 0x212c42 }, { 1345, 512, 0x212d42 }, { 1509, 512, 0x292d42 }, { 1675, 512, 0x29354a }, },
        { { 339, 631, 0x000000 }, { 509, 631, 0x4a394a }, { 680, 631, 0x635121 }, { 850, 631, 0x6b5152 }, { 1021, 631, 0x6b4d4a }, { 1191, 631, 0x73554a }, { 1362, 631, 0x6b5142 }, { 1532, 631, 0x6b5d52 }, { 1707, 631, 0x84818c }, },
        { { 311, 761, 0x000000 }, { 489, 761, 0x5a4152 }, { 667, 761, 0x63494a }, { 845, 761, 0x6b4d52 }, { 1023, 761, 0x63454a }, { 1202, 761, 0x634942 }, { 1380, 761, 0x6b4d42 }, { 1558, 761, 0x6b5542 }, { 1739, 761, 0x000000 }, },
        { { 280, 904, 0x000000 }, { 466, 904, 0x423552 }, { 651, 904, 0x947d84 }, { 840, 904, 0x634963 }, { 1029, 904, 0x423942 }, { 1213, 904, 0x5a3d42 }, { 1400, 904, 0x845952 }, { 1587, 904, 0x734942 }, { 1776, 904, 0xffce7b }, },
      },
      pointMap = {},
    },
    {
      leftTop = { 337, 285 },
      rightTop = nil,
      leftBotton = nil,
      rightBotton = nil,
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的
      positionMap = {
        false, false, false,
        { { 248, 644, 0x000000 }, { 434, 644, 0x423552 }, { 618, 644, 0x8c7d84 }, { 807, 644, 0x5a4552 }, { 994, 644, 0xc5a29c }, { 1181, 644, 0x5a3d42 }, { 1368, 644, 0x845952 }, { 1555, 644, 0x734942 }, { 1745, 644, 0xffc67b }, },
        { { 213, 788, 0x000000 }, { 408, 788, 0x633d63 }, { 604, 788, 0x7b5163 }, { 800, 788, 0x4a3542 }, { 993, 788, 0xada2ad }, { 1192, 788, 0x6b3d52 }, { 1388, 788, 0x63414a }, { 1585, 788, 0x73514a }, { 1783, 788, 0x000000 }, },
        { { 174, 947, 0x000000 }, { 378, 947, 0x312d52 }, { 585, 947, 0x4a3952 }, { 791, 947, 0x312842 }, { 998, 947, 0x211c31 }, { 1204, 947, 0x291c21 }, { 1411, 947, 0x291c21 }, { 1618, 947, 0x291c19 }, { 1827, 947, 0x100c10 }, },
      },
      pointMap = {},
    },
    {
      leftTop = nil,
      rightTop = nil,
      leftBotton = { 448, 936 },
      rightBotton = nil,
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的
      positionMap = {
        false, false, false, false, false,
        { { 502, 600, 0x000000 }, { 706, 600, 0x423563 }, { 913, 600, 0x423152 }, { 1119, 600, 0x292442 }, { 1326, 600, 0x31243a }, },
        { { 477, 758, 0xffca8c }, { 692, 758, 0x523152 }, { 910, 758, 0x3a2842 }, { 1129, 758, 0x292431 }, { 1346, 758, 0x29203a }, },
        { { 448, 936, 0x000000 }, { 677, 936, 0x000000 }, { 908, 936, 0x000000 }, { 1139, 936, 0x000000 }, { 1370, 936, 0x313131 }, },
      },
      pointMap = {},
    },
    {
      leftTop = nil,
      rightTop = nil,
      leftBotton = nil,
      rightBotton = { 1737, 910 },
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的
      positionMap = {
        false, false, false, false, false,
        { false, false, false, false, { 827, 577, 0x31243a }, { 1033, 577, 0x422031 }, { 1240, 577, 0x4a313a }, { 1446, 577, 0x63413a }, { 1655, 577, 0x000000 }, },
        { false, false, false, false, { 819, 734, 0x291c31 }, { 1037, 734, 0x211829 }, { 1256, 734, 0x3a243a }, { 1473, 734, 0x422831 }, { 1694, 734, 0x000000 }, },
        { false, false, false, false, { 812, 910, 0x000000 }, { 1042, 910, 0x000000 }, { 1273, 910, 0x000000 }, { 1503, 910, 0x000000 }, { 1737, 910, 0x000000 }, },
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
mapevent5_1_a3.getMapChessboard = function()
  return {
    width = 8,
    height = 7,
    obstacle = {},
    waitForBossPosition = { { 3, 7 } },
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

mapevent5_1_a3.getMapPosition = function(currentPosition)
  return mapBase.getMapPosition(imgevent5_1_a3, currentPosition)
end

mapevent5_1_a3.getMoveVector = function(currentPosition, targetPosition)
  return mapBase.getMoveVector(imgevent5_1_a3, currentPosition, targetPosition)
end

mapevent5_1_a3.moveMapToCheckPosition = function(moveVector)
  return mapBase.moveMapToCheckPosition(imgevent5_1_a3, moveVector)
end

mapevent5_1_a3.scanMap = function(targetPosition, mapChessboard)
  return mapBase.scanMap(imgevent5_1_a3, targetPosition, mapChessboard)
end

mapevent5_1_a3.moveToPoint = function(targetPosition, point)
  return mapBase.moveToPoint(imgevent5_1_a3, targetPosition, point)
end

mapevent5_1_a3.checkMoveToPointPath = function(mapChessboard, start, target)
  return mapBase.checkMoveToPointPath(mapevent5_1_a3, mapChessboard, start, target)
end

mapevent5_1_a3.findClosestEnemy = function(mapChessboard)
  return mapBase.findClosestEnemy(imgevent5_1_a3, mapChessboard)
end

return mapevent5_1_a3