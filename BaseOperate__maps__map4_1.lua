local mapBase = require 'BaseOperate__maps__map'
local img4_1 = require 'BaseOperate__maps__img4_1'
local map4_1 = {}

-- 获取地图采样位置。由于地图可能超出一屏，所以这里可以定义多个采样位置。每次扫描都会对每个采样位置进行扫描
-- 标志位为地图四个角。每个采样位置只需定义一个角的坐标即可。
-- 还需要定义每个采样位置的地图矩阵与屏幕坐标的映射关系
map4_1.getCheckpositionList = function()
  local list = {
    {
      leftTop = { 561, 536 },
      rightTop = nil,
      leftBotton = nil,
      rightBotton = nil,
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的
      positionMap = {
        { { 561, 536, 0xa47508 }, { 729, 536, 0x3a3131 }, { 899, 536, 0x292429 }, { 1068, 536, 0x292431 }, { 1237, 536, 0x322d32 }, { 1407, 536, 0x3a3531 }, { 1576, 536, 0x213921 }, },
        { { 545, 660, 0x000000 }, { 720, 660, 0x73455a }, { 896, 660, 0x84595a }, { 1072, 660, 0x735152 }, { 1248, 660, 0x845d52 }, { 1424, 660, 0x846152 }, { 1603, 660, 0x000000 }, },
        { { 528, 795, 0x000000 }, { 710, 795, 0x423542 }, { 893, 795, 0x63494a }, { 1077, 795, 0x6b4d4a }, { 1260, 795, 0x6b5142 }, { 1444, 795, 0x634d42 }, { 1630, 795, 0x000000 }, },
        { { 509, 941, 0x000000 }, { 699, 941, 0x4a394a }, { 890, 941, 0x42353a }, { 1080, 941, 0x7b615a }, { 1274, 941, 0x4a353a }, { 1465, 941, 0x292021 }, { 1659, 941, 0x100c10 }, },
      },
      pointMap = {},
    },
    {
      leftTop = nil,
      rightTop = nil,
      leftBotton = { 438, 980 },
      rightBotton = nil,
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的
      positionMap = {
        false, false, false,
        { { 507, 513, 0x000000 }, { 697, 513, 0x52394a }, { 888, 513, 0x42353a }, { 1078, 514, 0x836963 }, { 1272, 513, 0x4a353a }, { 1463, 513, 0x734d4a }, { 1657, 513, 0x000000 }, },
        { { 486, 654, 0x000000 }, { 685, 654, 0x4a3152 }, { 885, 654, 0x3a3142 }, { 1086, 654, 0x3a243a }, { 1287, 654, 0x42283a }, { 1487, 654, 0x63414a }, { 1690, 654, 0x000000 }, },
        { { 463, 808, 0x000000 }, { 671, 808, 0x292842 }, { 881, 808, 0x31243a }, { 1092, 808, 0x3a2842 }, { 1302, 808, 0x3a203a }, { 1512, 808, 0x422d42 }, { 1725, 808, 0x000000 }, },
        { { 438, 980, 0x000000 }, { 658, 980, 0x000000 }, { 878, 980, 0x000000 }, { 1099, 980, 0x9c5d5a }, { 1325, 980, 0x424142 }, { 1541, 980, 0x191419 }, { 1768, 980, 0x846d73 }, },
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
map4_1.getMapChessboard = function()
  return {
    width = 6,
    height = 6,
    obstacle = {},
    waitForBossPosition = { { 4, 2 } },
    bossPosition = {},
    myFleetList = {},
    enemyPositionList = {},
    inBattleList = {},
    selectedArrowList = {},
  }
end



map4_1.getMapPosition = function(currentPosition)
  return mapBase.getMapPosition(img4_1, currentPosition)
end

map4_1.getMoveVector = function(currentPosition, targetPosition)
  return mapBase.getMoveVector(img4_1, currentPosition, targetPosition)
end

map4_1.moveMapToCheckPosition = function(moveVector)
  return mapBase.moveMapToCheckPosition(img4_1, moveVector)
end

map4_1.scanMap = function(targetPosition, mapChessboard)
  return mapBase.scanMap(img4_1, targetPosition, mapChessboard)
end

map4_1.moveToPoint = function(targetPosition, point)
  return mapBase.moveToPoint(img4_1, targetPosition, point)
end

map4_1.checkMoveToPointPath = function(mapChessboard, start, target)
  return mapBase.checkMoveToPointPath(map4_1, mapChessboard, start, target)
end

map4_1.findClosestEnemy = function(mapChessboard)
  return mapBase.findClosestEnemy(img4_1, mapChessboard)
end

return map4_1