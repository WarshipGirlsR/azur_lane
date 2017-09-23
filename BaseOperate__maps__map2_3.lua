local mapBase = require 'BaseOperate__maps__map'
local img2_3 = require 'BaseOperate__maps__img2_3'
local map2_3 = {}

-- 获取地图采样位置。由于地图可能超出一屏，所以这里可以定义多个采样位置。每次扫描都会对每个采样位置进行扫描
-- 标志位为地图四个角。每个采样位置只需定义一个角的坐标即可。
-- 还需要定义每个采样位置的地图矩阵与屏幕坐标的映射关系
map2_3.getCheckpositionList = function()
  local list = {
    {
      leftTop = { 493, 502 },
      rightTop = nil,
      leftBotton = nil,
      rightBotton = nil,
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的
      positionMap = {
        { { 493, 502, 0x21414a }, { 660, 502, 0x294552 }, { 830, 502, 0x314552 }, { 999, 502, 0x293d4a }, { 1168, 502, 0x294552 }, { 1338, 502, 0x314552 }, { 1509, 502, 0x213d4a }, },
        { { 474, 624, 0x000000 }, { 649, 624, 0x5a6d4a }, { 825, 624, 0x197d94 }, { 1001, 624, 0x217994 }, { 1177, 624, 0x197594 }, { 1353, 624, 0x297d94 }, { 1531, 624, 0x000000 }, },
        { { 453, 757, 0x000000 }, { 636, 757, 0x19758c }, { 819, 757, 0x107d8c }, { 1002, 757, 0x105d7b }, { 1186, 757, 0x106184 }, { 1371, 756, 0x5a9e7b }, { 1555, 757, 0x000000 }, },
        { { 431, 903, 0x000000 }, { 621, 903, 0x296d94 }, { 812, 903, 0x196184 }, { 1004, 903, 0x084d73 }, { 1196, 903, 0x194173 }, { 1387, 903, 0x295d8c }, { 1582, 903, 0x000000 }, },
      },
      pointMap = {},
    },
    {
      leftTop = nil,
      rightTop = nil,
      leftBotton = { 413, 902 },
      rightBotton = nil,
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的
      positionMap = {
        false, false, false,
        { { 462, 597, 0x000000 }, { 652, 597, 0x21698c }, { 843, 597, 0x19698c }, { 1035, 597, 0x10517b }, { 1226, 597, 0x19416b }, { 1419, 597, 0x295d8c }, { 1612, 597, 0x000000 }, },
        { { 439, 741, 0x000000 }, { 638, 741, 0x10698c }, { 838, 741, 0x085984 }, { 1038, 741, 0x003d63 }, { 1239, 741, 0x10417b }, { 1439, 741, 0x214d7b }, { 1642, 741, 0x000000 }, },
        { { 413, 902, 0x000000 }, { 622, 902, 0x000000 }, { 833, 902, 0x000000 }, { 1042, 902, 0x000000 }, { 1252, 902, 0x000000 }, { 1462, 902, 0x000000 }, { 1676, 902, 0x000000 }, },
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
map2_3.getMapChessboard = function()
  return {
    width = 6,
    height = 5,
    obstacle = {
      { 1, 5 },
      { 2, 4 }, { 2, 5 },
      { 3, 5 },
      { 5, 1 }, { 5, 2 }, { 5, 3 },
    },
    waitForBossPosition = { { 1, 5 } },
    bossPosition = {},
    myFleetList = {},
    enemyPositionList = {},
    inBattleList = {},
  }
end



map2_3.getMapPosition = function()
  return mapBase.getMapPosition(img2_3)
end

map2_3.getMoveVector = function(currentPosition, targetPosition)
  return mapBase.getMoveVector(img1_1, currentPosition, targetPosition)
end

map2_3.moveMapToCheckPosition = function(moveVector)
  return mapBase.moveMapToCheckPosition(img1_1, moveVector)
end

map2_3.scanMap = function(targetPosition, mapChessboard)
  return mapBase.scanMap(img2_3, targetPosition, mapChessboard)
end

map2_3.moveToPoint = function(targetPosition, point)
  return mapBase.moveToPoint(img2_3, targetPosition, point)
end

map2_3.findClosestEnemy = function(mapChessboard)
  return mapBase.findClosestEnemy(img2_3, mapChessboard)
end

return map2_3