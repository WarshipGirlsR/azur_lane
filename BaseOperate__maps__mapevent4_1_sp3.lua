local mapBase = require 'BaseOperate__maps__map'
local imgevent4_1_sp3 = require 'BaseOperate__maps__imgevent4_1_sp3'
local mapevent4_1_sp3 = {}

-- 获取地图采样位置。由于地图可能超出一屏，所以这里可以定义多个采样位置。每次扫描都会对每个采样位置进行扫描
-- 标志位为地图四个角。每个采样位置只需定义一个角的坐标即可。
-- 还需要定义每个采样位置的地图矩阵与屏幕坐标的映射关系
mapevent4_1_sp3.getCheckpositionList = function()
  local list = {
    {
      leftTop = nil,
      rightTop = { 1759, 516 },
      leftBotton = nil,
      rightBotton = nil,
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的
      positionMap = {
        { { 292, 516, 0x100c10 }, { 454, 516, 0x42495a }, { 617, 516, 0x312010 }, { 780, 516, 0x211819 }, { 943, 516, 0x101010 }, { 1106, 516, 0x292421 }, { 1269, 516, 0x212021 }, { 1431, 516, 0x101010 }, { 1594, 516, 0x212021 }, { 1759, 516, 0x191419 }, },
        { { 267, 634, 0x000000 }, { 435, 634, 0x292829 }, { 604, 634, 0x3a2d31 }, { 773, 634, 0x423121 }, { 942, 634, 0x523529 }, { 1111, 634, 0x312d29 }, { 1280, 634, 0x42393a }, { 1449, 634, 0x523d29 }, { 1618, 634, 0x8c513a }, { 1790, 634, 0x000000 }, },
        { { 238, 763, 0x080400 }, { 413, 763, 0x292829 }, { 589, 763, 0x423521 }, { 765, 763, 0x4a3119 }, { 942, 763, 0x848a8c }, { 1117, 763, 0x3a3531 }, { 1293, 763, 0x3a3131 }, { 1469, 763, 0x4a3529 }, { 1645, 763, 0x7b4131 }, { 1824, 763, 0x000000 }, },
        { { 208, 902, 0x000000 }, { 391, 902, 0x292829 }, { 574, 902, 0x191419 }, { 757, 902, 0x4a2d19 }, { 940, 902, 0x523121 }, { 1124, 902, 0x3a2d29 }, { 1307, 902, 0x312d29 }, { 1491, 902, 0x422829 }, { 1674, 902, 0x5a3d3a }, { 1860, 902, 0x000000 }, },
      },
      pointMap = {},
    },
    {
      leftTop = { 476, 266 },
      rightTop = nil,
      leftBotton = nil,
      rightBotton = nil,
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的
      positionMap = {
        false, false, false,
        { { 415, 620, 0x000000 }, { 597, 620, 0x292829 }, { 781, 620, 0x292421 }, { 964, 620, 0x523121 }, { 1148, 620, 0x523121 }, { 1331, 620, 0x292821 }, },
        { { 391, 759, 0x000000 }, { 581, 759, 0x312829 }, { 773, 759, 0x313129 }, { 964, 759, 0x312019 }, { 1156, 759, 0x312419 }, { 1348, 759, 0x212019 }, },
        { { 365, 911, 0x000000 }, { 564, 911, 0x312019 }, { 764, 911, 0x292419 }, { 964, 911, 0x212019 }, { 1165, 911, 0x312421 }, { 1365, 911, 0x292429 }, },
      },
      pointMap = {},
    },
    {
      leftTop = nil,
      rightTop = { 1563, 266 },
      leftBotton = nil,
      rightBotton = nil,
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的
      positionMap = {
        false, false, false,
        { false, false, false, false, false, { 903, 620, 0x292821 }, { 1087, 620, 0x292d29 }, { 1270, 620, 0x423129 }, { 1454, 620, 0x847573 }, { 1640, 620, 0x292d3a }, },
        { false, false, false, false, false, { 901, 759, 0x312829 }, { 1092, 759, 0x212421 }, { 1284, 759, 0x312821 }, { 1475, 759, 0x423531 }, { 1671, 759, 0x080408 }, },
        { false, false, false, false, false, { 898, 911, 0x192021 }, { 1098, 911, 0x192021 }, { 1299, 911, 0x313131 }, { 1499, 911, 0x423131 }, { 1702, 911, 0x000000 }, },
      },
      pointMap = {},
    },
    {
      leftTop = nil,
      rightTop = nil,
      leftBotton = { 333, 907 },
      rightBotton = nil,
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的
      positionMap = {
        false, false, false, false, false,
        { { 420, 429, 0x000000 }, { 620, 429, 0x312019 }, { 820, 429, 0x3a353a }, { 1020, 429, 0x212021 }, { 1021, 429, 0x312829 }, { 1221, 429, 0x312429 }, { 1421, 429, 0x292429 }, },
        { { 394, 572, 0x000000 }, { 602, 572, 0x4a2821 }, { 813, 572, 0x312821 }, { 1023, 572, 0x212829 }, { 1233, 572, 0x212021 }, { 1233, 572, 0x212021 }, },
        { { 365, 730, 0x000000 }, { 584, 730, 0x422821 }, { 805, 730, 0x292421 }, { 1026, 730, 0x292429 }, { 1247, 730, 0x212029 }, { 1468, 730, 0x212429 }, },
        { { 333, 907, 0x000000 }, { 565, 907, 0x000000 }, { 797, 907, 0x000000 }, { 1030, 907, 0x000000 }, { 1263, 907, 0x000000 }, { 1495, 907, 0x000000 }, },
      },
      pointMap = {},
    },
    {
      leftTop = nil,
      rightTop = nil,
      leftBotton = nil,
      rightBotton = { 1697, 906 },
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的
      positionMap = {
        false, false, false, false, false,
        { false, false, false, false, false, { 791, 428, 0x212421 }, { 991, 428, 0x212421 }, { 1192, 428, 0x73717b }, { 1392, 428, 0x3a313a }, { 1595, 428, 0x000000 }, },
        { false, false, false, false, false, { 783, 571, 0x212429 }, { 992, 571, 0x192021 }, { 1202, 571, 0x212421 }, { 1413, 571, 0x292831 }, { 1626, 571, 0x000000 }, },
        { false, false, false, false, false, { 774, 729, 0x192019 }, { 995, 729, 0x3a414a }, { 1215, 729, 0x212429 }, { 1437, 729, 0x292831 }, { 1660, 729, 0x000000 }, },
        { false, false, false, false, false, { 763, 906, 0x000000 }, { 996, 906, 0x000000 }, { 1229, 906, 0x000000 }, { 1462, 906, 0x000000 }, { 1697, 906, 0x000000 }, },
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
mapevent4_1_sp3.getMapChessboard = function()
  return {
    width = 9,
    height = 8,
    obstacle = {},
    waitForBossPosition = { { 1, 6 } },
    bossPosition = {},
    myFleetList = {},
    enemyPositionList = {},
    inBattleList = {},
  }
end

mapevent4_1_sp3.getMapPosition = function(currentPosition)
  return mapBase.getMapPosition(imgevent4_1_sp3, currentPosition)
end

mapevent4_1_sp3.getMoveVector = function(currentPosition, targetPosition)
  return mapBase.getMoveVector(imgevent4_1_sp3, currentPosition, targetPosition)
end

mapevent4_1_sp3.moveMapToCheckPosition = function(moveVector)
  return mapBase.moveMapToCheckPosition(imgevent4_1_sp3, moveVector)
end

mapevent4_1_sp3.scanMap = function(targetPosition, mapChessboard)
  return mapBase.scanMap(imgevent4_1_sp3, targetPosition, mapChessboard)
end

mapevent4_1_sp3.moveToPoint = function(targetPosition, point)
  return mapBase.moveToPoint(imgevent4_1_sp3, targetPosition, point)
end

mapevent4_1_sp3.findClosestEnemy = function(mapChessboard)
  return mapBase.findClosestEnemy(imgevent4_1_sp3, mapChessboard)
end

return mapevent4_1_sp3