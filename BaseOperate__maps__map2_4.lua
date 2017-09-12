local mapBase = require 'BaseOperate__maps__map'
local img2_4 = require 'BaseOperate__maps__img2_4'
local map2_4 = {}

-- 获取地图采样位置。由于地图可能超出一屏，所以这里可以定义多个采样位置。每次扫描都会对每个采样位置进行扫描
-- 标志位为地图四个角。每个采样位置只需定义一个角的坐标即可。
-- 还需要定义每个采样位置的地图矩阵与屏幕坐标的映射关系
map2_4.getCheckpositionList = function()
  return {
    {
      leftTop = { 392, 317 },
      rightTop = nil,
      leftBotton = nil,
      rightBotton = nil,
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的
      positionMap = {
        { { 392, 317, 0x21414a }, { 569, 317, 0x294152 }, { 745, 317, 0x08a6d6 }, { 923, 316, 0x213942 }, { 1101, 317, 0x213942 }, { 1279, 317, 0x213142 }, { 1454, 316, 0x21314a }, { 1633, 317, 0x212842 }, },
        { { 370, 450, 0x000000 }, { 554, 450, 0x21799c }, { 739, 450, 0x4a9a84 }, { 922, 450, 0x218194 }, { 1107, 450, 0x196d8c }, { 1291, 450, 0x197994 }, { 1475, 450, 0x217d94 }, { 1660, 450, 0x000000 }, },
        { { 346, 593, 0x000000 }, { 538, 593, 0x107584 }, { 729, 593, 0x318194 }, { 921, 593, 0x215d84 }, { 1113, 593, 0x214d84 }, { 1304, 593, 0x195184 }, { 1496, 593, 0x19718c }, { 1688, 593, 0x000000 }, },
        { { 320, 748, 0x000000 }, { 520, 748, 0x296594 }, { 720, 748, 0x216994 }, { 919, 748, 0x085173 }, { 1119, 748, 0x08497c }, { 1319, 748, 0x194d7c }, { 1519, 748, 0x736163 }, { 1720, 744, 0x73c28c }, },
        { { 293, 918, 0x000000 }, { 501, 918, 0x000000 }, { 709, 918, 0x000000 }, { 918, 918, 0x000000 }, { 1126, 918, 0x000000 }, { 1334, 918, 0x000000 }, { 1542, 918, 0x101010 }, { 1752, 918, 0x191819 }, },
      },
    },
  }
end

-- 获取地图棋盘和相关数据
map2_4.getMapChessboard = function()
  return {
    width = 7,
    height = 4,
    obstacle = {
      { 1, 2 }, { 1, 3 }, { 1, 4 },
      { 3, 6 }, { 3, 7 }, { 4, 7 },
    },
    waitForBossPosition = { { 1, 7 } },
    bossPosition = {},
    myFleetList = {},
    enemyPositionList = {},
  }
end



map2_4.getMapPosition = function()
  return mapBase.getMapPosition(img2_4)
end

map2_4.moveMapToCheckPosition = function(currentPosition, targetPosition)
  return mapBase.moveMapToCheckPosition(img2_4, currentPosition, targetPosition)
end

map2_4.scanMap = function(targetPosition, mapChessboard)
  return mapBase.scanMap(img2_4, targetPosition, mapChessboard)
end

map2_4.moveToPoint = function(targetPosition, point)
  return mapBase.moveToPoint(img2_4, targetPosition, point)
end

map2_4.findClosestEnemy = function(mapChessboard)
  return mapBase.findClosestEnemy(img2_4, mapChessboard)
end

return map2_4