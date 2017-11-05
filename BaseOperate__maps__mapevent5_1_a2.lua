local mapBase = require 'BaseOperate__maps__map'
local imgevent5_1_a2 = require 'BaseOperate__maps__imgevent5_1_a2'
local mapevent5_1_a2 = {}

-- 获取地图采样位置。由于地图可能超出一屏，所以这里可以定义多个采样位置。每次扫描都会对每个采样位置进行扫描
-- 标志位为地图四个角。每个采样位置只需定义一个角的坐标即可。
-- 还需要定义每个采样位置的地图矩阵与屏幕坐标的映射关系
mapevent5_1_a2.getCheckpositionList = function()
  local list = {
    {
      leftTop = { 338, 522 },
      rightTop = nil,
      leftBotton = nil,
      rightBotton = nil,
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的
      positionMap = {
        { { 338, 522, 0x523d3a }, { 508, 522, 0x312429 }, { 678, 522, 0x292431 }, { 847, 522, 0xc5866b }, { 1020, 522, 0x312829 }, { 1191, 522, 0x192442 }, { 1361, 522, 0x523d29 }, { 1532, 522, 0x5a413a }, { 1705, 522, 0x21283a }, },
        { { 310, 646, 0x000000 }, { 487, 646, 0x523552 }, { 667, 646, 0x312d10 }, { 844, 646, 0x846163 }, { 1023, 646, 0x734d52 }, { 1201, 646, 0x735142 }, { 1379, 646, 0x73594a }, { 1558, 646, 0x846152 }, { 1738, 646, 0x000000 }, },
        { { 279, 784, 0x000000 }, { 464, 784, 0x523d52 }, { 652, 784, 0x634552 }, { 838, 784, 0x634952 }, { 1026, 784, 0xa49294 }, { 1212, 784, 0x73514a }, { 1399, 784, 0x73594a }, { 1586, 784, 0x7b5552 }, { 1775, 784, 0x000000 }, },
        { { 245, 935, 0x000000 }, { 440, 935, 0x422d42 }, { 637, 935, 0x7b555a }, { 832, 935, 0x3a3131 }, { 1026, 935, 0x9c929c }, { 1225, 935, 0x4a353a }, { 1421, 935, 0x423d3a }, { 1617, 935, 0x42413a }, { 1816, 935, 0x292d29 }, },
      },
      pointMap = {},
    },
    {
      leftTop = nil,
      rightTop = nil,
      leftBotton = { 434, 915 },
      rightBotton = nil,
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的
      positionMap = {
        false, false, false,
      },
      pointMap = {},
    },
    {
      leftTop = nil,
      rightTop = nil,
      leftBotton = { 336, 966 },
      rightBotton = nil,
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的
      positionMap = {
        false, false, false,
        { { 430, 483, 0x000000 }, { 624, 483, 0x422d42 }, { 820, 483, 0x6b4d4a }, { 1017, 483, 0x4a3942 }, { 1213, 483, 0x636984 }, },
        { { 402, 627, 0x000000 }, { 607, 627, 0x4a395a }, { 813, 627, 0x4a3952 }, { 1019, 627, 0x312842 }, { 1226, 627, 0x212029 }, },
        { { 371, 786, 0x000000 }, { 587, 786, 0x3a284a }, { 805, 786, 0x312842 }, { 1023, 786, 0x31243a }, { 1241, 786, 0x29243a }, },
        { { 336, 966, 0x000000 }, { 566, 966, 0x000000 }, { 796, 966, 0x000000 }, { 1027, 966, 0x000000 }, { 1258, 966, 0x7b757b }, },
      },
      pointMap = {},
    },
    {
      leftTop = nil,
      rightTop = nil,
      leftBotton = nil,
      rightBotton = { 1675, 938 },
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的
      positionMap = {
        false, false, false,
        { false, false, false, false, { 779, 460, 0x63657b }, { 976, 460, 0x523142 }, { 1173, 460, 0x63494a }, { 1369, 460, 0x734942 }, { 1568, 460, 0x000000 }, },
        { false, false, false, false, { 771, 602, 0x292031 }, { 977, 602, 0x292029 }, { 1184, 602, 0x634152 }, { 1391, 602, 0x734952 }, { 1600, 602, 0x000000 }, },
        { false, false, false, false, { 760, 759, 0x212031 }, { 978, 759, 0x211829 }, { 1196, 759, 0x292029 }, { 1414, 759, 0x4a313a }, { 1635, 759, 0x000000 }, },
        { false, false, false, false, { 749, 938, 0x000000 }, { 980, 938, 0x000000 }, { 1210, 938, 0x000000 }, { 1441, 938, 0x191819 }, { 1675, 938, 0x191819 }, },
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
mapevent5_1_a2.getMapChessboard = function()
  return {
    width = 10,
    height = 6,
    obstacle = {},
    waitForBossPosition = { { 2, 2 } },
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

mapevent5_1_a2.getMapPosition = function(currentPosition)
  return mapBase.getMapPosition(imgevent5_1_a2, currentPosition)
end

mapevent5_1_a2.getMoveVector = function(currentPosition, targetPosition)
  return mapBase.getMoveVector(imgevent5_1_a2, currentPosition, targetPosition)
end

mapevent5_1_a2.moveMapToCheckPosition = function(moveVector)
  return mapBase.moveMapToCheckPosition(imgevent5_1_a2, moveVector)
end

mapevent5_1_a2.scanMap = function(targetPosition, mapChessboard)
  return mapBase.scanMap(imgevent5_1_a2, targetPosition, mapChessboard)
end

mapevent5_1_a2.moveToPoint = function(targetPosition, point)
  return mapBase.moveToPoint(imgevent5_1_a2, targetPosition, point)
end

mapevent5_1_a2.checkMoveToPointPath = function(mapChessboard, start, target)
  return mapBase.checkMoveToPointPath(mapevent5_1_a2, mapChessboard, start, target)
end

mapevent5_1_a2.findClosestEnemy = function(mapChessboard)
  return mapBase.findClosestEnemy(imgevent5_1_a2, mapChessboard)
end

return mapevent5_1_a2