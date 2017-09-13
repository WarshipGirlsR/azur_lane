local mapBase = require 'BaseOperate__maps__map'
local img4_2 = require 'BaseOperate__maps__img4_2'
local map4_2 = {}

-- 获取地图采样位置。由于地图可能超出一屏，所以这里可以定义多个采样位置。每次扫描都会对每个采样位置进行扫描
-- 标志位为地图四个角。每个采样位置只需定义一个角的坐标即可。
-- 还需要定义每个采样位置的地图矩阵与屏幕坐标的映射关系
map4_2.getCheckpositionList = function()
  local list = {
    {
      leftTop = { 476, 469 },
      rightTop = nil,
      leftBotton = nil,
      rightBotton = nil,
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的
      positionMap = {
        { { 476, 469, 0x31313a }, { 644, 469, 0x191c29 }, { 813, 469, 0x212031 }, { 983, 469, 0x313129 }, { 1152, 469, 0x211c29 }, { 1321, 469, 0x292431 }, { 1490, 469, 0x3a3531 }, },
        { { 455, 590, 0x000000 }, { 632, 590, 0x84556b }, { 808, 590, 0x84595a }, { 984, 590, 0x735152 }, { 1160, 590, 0x845d52 }, { 1336, 590, 0x846152 }, { 1513, 590, 0x000000 }, },
        { { 434, 722, 0x000000 }, { 618, 722, 0x524152 }, { 801, 722, 0x5a454a }, { 985, 722, 0x6b494a }, { 1169, 722, 0x946d5a }, { 1352, 722, 0x7b5552 }, { 1536, 722, 0x000000 }, },
        { { 411, 866, 0x000000 }, { 603, 866, 0x5a415a }, { 794, 866, 0x523942 }, { 986, 866, 0x422842 }, { 1177, 866, 0x523942 }, { 1369, 866, 0x734942 }, { 1562, 866, 0x000000 }, },
      },
      pointMap = {},
    },
    {
      leftTop = nil,
      rightTop = nil,
      leftBotton = { 380, 899 },
      rightBotton = nil,
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的
      positionMap = {
        false, false, false,
        { { 456, 444, 0x000000 }, { 648, 444, 0x523552 }, { 840, 444, 0x523942 }, { 1031, 444, 0x312831 }, { 1223, 444, 0x523942 }, { 1415, 444, 0x734942 }, { 1607, 444, 0x000000 }, },
        { { 433, 581, 0x000000 }, { 634, 581, 0x523d63 }, { 834, 581, 0x31283a }, { 1035, 581, 0x312431 }, { 1235, 581, 0x4a313a }, { 1436, 581, 0x634142 }, { 1640, 581, 0x000000 } },
        { { 407, 732, 0x000000 }, { 615, 732, 0x84656b }, { 828, 732, 0x3a2842 }, { 1038, 732, 0x3a2842 }, { 1248, 732, 0x3a203a }, { 1459, 732, 0x3a2831 }, { 1670, 732, 0x000000 }, },
        { { 380, 899, 0x000000 }, { 600, 899, 0x000000 }, { 821, 899, 0x000000 }, { 1042, 899, 0x000000 }, { 1263, 899, 0x000000 }, { 1484, 899, 0x000000 }, { 1705, 899, 0x000000 }, },
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
map4_2.getMapChessboard = function()
  return {
    width = 6,
    height = 6,
    obstacle = {},
    waitForBossPosition = { { 4, 6 } },
    bossPosition = {},
    myFleetList = {},
    enemyPositionList = {},
  }
end



map4_2.getMapPosition = function()
  return mapBase.getMapPosition(img4_2)
end

map4_2.getMoveVector = function(currentPosition, targetPosition)
  return mapBase.getMoveVector(img4_2, currentPosition, targetPosition)
end

map4_2.moveMapToCheckPosition = function(moveVector)
  return mapBase.moveMapToCheckPosition(img4_2, moveVector)
end

map4_2.scanMap = function(targetPosition, mapChessboard)
  return mapBase.scanMap(img4_2, targetPosition, mapChessboard)
end

map4_2.moveToPoint = function(targetPosition, point)
  return mapBase.moveToPoint(img4_2, targetPosition, point)
end

map4_2.findClosestEnemy = function(mapChessboard)
  return mapBase.findClosestEnemy(img4_2, mapChessboard)
end

return map4_2