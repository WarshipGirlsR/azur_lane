local mapBase = require 'BaseOperate__maps__map'
local img5_1 = require 'BaseOperate__maps__img5_1'
local map5_1 = {}

-- 获取地图采样位置。由于地图可能超出一屏，所以这里可以定义多个采样位置。每次扫描都会对每个采样位置进行扫描
-- 标志位为地图四个角。每个采样位置只需定义一个角的坐标即可。
-- 还需要定义每个采样位置的地图矩阵与屏幕坐标的映射关系
map5_1.getCheckpositionList = function()
  local list = {
    {
      leftTop = { 303, 471 },
      rightTop = nil,
      leftBotton = nil,
      rightBotton = nil,
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的
      positionMap = {
        { { 303, 471, 0x293d4a }, { 472, 471, 0x213542 }, { 641, 471, 0x29414a }, { 810, 471, 0x212d42 }, { 979, 471, 0x314952 }, { 1149, 471, 0x315152 }, { 1318, 471, 0x212d42 }, { 1487, 471, 0x213142 }, { 1656, 471, 0x19283a }, },
        { { 276, 592, 0x000000 }, { 452, 593, 0x106d8c }, { 628, 593, 0x19718c }, { 804, 593, 0x197d8c }, { 980, 593, 0x19758c }, { 1156, 593, 0x197984 }, { 1332, 593, 0x217d8c }, { 1508, 593, 0x197a8c }, { 1685, 593, 0x000101 }, },
        { { 247, 723, 0x000000 }, { 430, 725, 0x217984 }, { 615, 725, 0xdea608 }, { 798, 725, 0x107984 }, { 981, 725, 0x21718c }, { 1165, 725, 0x216d94 }, { 1348, 725, 0x19698c }, { 1532, 725, 0x19758c }, { 1716, 725, 0x000000 }, },
        { { 216, 867, 0x000000 }, { 407, 869, 0x197d8c }, { 599, 869, 0x297d8c }, { 790, 869, 0x086984 }, { 982, 869, 0x085173 }, { 1174, 869, 0x194d73 }, { 1365, 869, 0x216184 }, { 1557, 869, 0x21698c }, { 1750, 869, 0x000000 }, },
      },
      pointMap = {},
    },
    {
      leftTop = nil,
      rightTop = nil,
      leftBotton = { 385, 885 },
      rightBotton = nil,
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的
      positionMap = {
        false, false, false,
        { { 461, 432, 0x000000 }, { 654, 432, 0x7b5910 }, { 845, 432, 0x297d8c }, { 1036, 432, 0x21758c }, { 1228, 432, 0x21598c }, },
        { { 438, 569, 0x000000 }, { 639, 569, 0x316594 }, { 839, 569, 0x296994 }, { 1040, 569, 0x08517b }, { 1240, 569, 0x08496b }, },
        { { 413, 719, 0x000000 }, { 623, 719, 0x21698c }, { 834, 719, 0x105584 }, { 1044, 719, 0x085573 }, { 1254, 719, 0x105584 }, },
        { { 385, 885, 0x000000 }, { 606, 885, 0x000000 }, { 827, 885, 0x000000 }, { 1048, 885, 0x000000 }, { 1269, 885, 0x000000 }, },
      },
      pointMap = {},
    },
    {
      leftTop = nil,
      rightTop = nil,
      leftBotton = nil,
      rightBotton = { 1676, 884 },
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的
      positionMap = {
        false, false, false,
        { false, false, false, false, { 814, 431, 0x08517c }, { 1005, 431, 0x19517b }, { 1197, 431, 0x195d84 }, { 1389, 431, 0x19698c }, { 1581, 431, 0x000000 }, },
        { false, false, false, false, { 807, 567, 0x214d7b }, { 1007, 567, 0x21497b }, { 1208, 567, 0x194573 }, { 1408, 567, 0x214d84 }, { 1610, 567, 0x000000 }, },
        { false, false, false, false, { 800, 718, 0x216184 }, { 1010, 718, 0x21417b }, { 1219, 718, 0xbdbab5 }, { 1429, 718, 0x3a6163 }, { 1642, 718, 0x000000 }, },
        { false, false, false, false, { 791, 884, 0x000000 }, { 1012, 884, 0x000000 }, { 1233, 884, 0x000000 }, { 1454, 884, 0x000000 }, { 1676, 884, 0x000000 }, },
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
map5_1.getMapChessboard = function()
  return {
    width = 6,
    height = 6,
    obstacle = {},
    waitForBossPosition = { { 3, 5 } },
    bossPosition = {},
    myFleetList = {},
    enemyPositionList = {},
    inBattleList = {},
  }
end



map5_1.getMapPosition = function(currentPosition)
  return mapBase.getMapPosition(img5_1, currentPosition)
end

map5_1.getMoveVector = function(currentPosition, targetPosition)
  return mapBase.getMoveVector(img5_1, currentPosition, targetPosition)
end

map5_1.moveMapToCheckPosition = function(moveVector)
  return mapBase.moveMapToCheckPosition(img5_1, moveVector)
end

map5_1.scanMap = function(targetPosition, mapChessboard)
  return mapBase.scanMap(img5_1, targetPosition, mapChessboard)
end

map5_1.moveToPoint = function(targetPosition, point)
  return mapBase.moveToPoint(img5_1, targetPosition, point)
end

map5_1.findClosestEnemy = function(mapChessboard)
  return mapBase.findClosestEnemy(img5_1, mapChessboard)
end

return map5_1