local mapBase = require 'BaseOperate__maps__map'
local imgevent5_1_a1 = require 'BaseOperate__maps__imgevent5_1_a1'
local mapevent5_1_a1 = {}

-- 获取地图采样位置。由于地图可能超出一屏，所以这里可以定义多个采样位置。每次扫描都会对每个采样位置进行扫描
-- 标志位为地图四个角。每个采样位置只需定义一个角的坐标即可。
-- 还需要定义每个采样位置的地图矩阵与屏幕坐标的映射关系
mapevent5_1_a1.getCheckpositionList = function()
  local list = {
    {
      leftTop = { 332, 530 },
      rightTop = nil,
      leftBotton = nil,
      rightBotton = nil,
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的
      positionMap = {
        { { 332, 530, 0x21314a }, { 502, 530, 0x212031 }, { 673, 530, 0x191419 }, { 843, 530, 0x191c31 }, { 1015, 530, 0xefb284 }, { 1185, 530, 0x312829 }, { 1356, 530, 0x313131 }, { 1523, 530, 0x5a4d63 }, { 1702, 530, 0x8c7d84 }, },
        { { 304, 655, 0x000000 }, { 483, 655, 0xffc68c }, { 660, 655, 0x63494a }, { 838, 655, 0x6b5152 }, { 1016, 655, 0x634d42 }, { 1195, 655, 0x734d4a }, { 1373, 655, 0x7b5d52 }, { 1550, 655, 0x7b757b }, { 1735, 655, 0xb58194 }, },
        { { 273, 793, 0x000000 }, { 459, 793, 0x42394a }, { 646, 793, 0x292419 }, { 832, 793, 0x423942 }, { 1019, 793, 0x4a3942 }, { 1206, 793, 0x63413a }, { 1393, 793, 0x734d42 }, { 1580, 793, 0x737da4 }, { 1769, 793, 0x000000 }, },
        { { 239, 944, 0x000000 }, { 434, 944, 0x633d63 }, { 630, 944, 0x6b4563 }, { 826, 944, 0x422d42 }, { 1022, 944, 0x3a283a }, { 1218, 944, 0x523542 }, { 1414, 944, 0x291c21 }, { 1611, 944, 0x292021 }, { 1809, 944, 0x100c10 }, },
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
        { { 487, 598, 0x000000 }, { 681, 598, 0x5a395a }, { 877, 598, 0x6b455a }, { 1073, 598, 0x3a2831 }, { 1270, 598, 0x3a283a }, },
        { { 461, 748, 0x000000 }, { 666, 748, 0x423152 }, { 873, 748, 0x4a3552 }, { 1079, 748, 0x292842 }, { 1286, 748, 0x292039 }, },
        { { 434, 915, 0x000000 }, { 650, 915, 0x000000 }, { 868, 915, 0x000000 }, { 1086, 915, 0x000000 }, { 1304, 915, 0x000000 }, },
      },
      pointMap = {},
    },
    {
      leftTop = nil,
      rightTop = nil,
      leftBotton = nil,
      rightBotton = { 1604, 906 },
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的
      positionMap = {
        false, false, false,
        { false, false, false, false, { 752, 590, 0x3a283a }, { 948, 590, 0x523142 }, { 1144, 590, 0x633d42 }, { 1341, 590, 0x734d52 }, { 1539, 590, 0x000000 }, },
        { false, false, false, false, { 741, 738, 0x211829 }, { 947, 738, 0x292031 }, { 1154, 738, 0x4a3142 }, { 1360, 738, 0x6b4152 }, { 1570, 738, 0x000000 }, },
        { false, false, false, false, { 730, 906, 0x000000 }, { 947, 906, 0x000000 }, { 1166, 906, 0x000000 }, { 1384, 906, 0x000000 }, { 1604, 906, 0x000000 }, },
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
mapevent5_1_a1.getMapChessboard = function()
  return {
    width = 8,
    height = 5,
    obstacle = {},
    waitForBossPosition = { { 3, 8 } },
    bossPosition = {},
    myFleetList = {},
    enemyPositionList1 = {},
    enemyPositionList2 = {},
    enemyPositionList3 = {},
    inBattleList = {},
    selectedArrowList = {},
  }
end

mapevent5_1_a1.getMapPosition = function(currentPosition)
  return mapBase.getMapPosition(imgevent5_1_a1, currentPosition)
end

mapevent5_1_a1.getMoveVector = function(currentPosition, targetPosition)
  return mapBase.getMoveVector(imgevent5_1_a1, currentPosition, targetPosition)
end

mapevent5_1_a1.moveMapToCheckPosition = function(moveVector)
  return mapBase.moveMapToCheckPosition(imgevent5_1_a1, moveVector)
end

mapevent5_1_a1.scanMap = function(targetPosition, mapChessboard)
  return mapBase.scanMap(imgevent5_1_a1, targetPosition, mapChessboard)
end

mapevent5_1_a1.moveToPoint = function(targetPosition, point)
  return mapBase.moveToPoint(imgevent5_1_a1, targetPosition, point)
end

mapevent5_1_a1.checkMoveToPointPath = function(mapChessboard, start, target)
  return mapBase.checkMoveToPointPath(mapevent5_1_a1, mapChessboard, start, target)
end

mapevent5_1_a1.findClosestEnemy = function(mapChessboard)
  return mapBase.findClosestEnemy(imgevent5_1_a1, mapChessboard)
end

return mapevent5_1_a1