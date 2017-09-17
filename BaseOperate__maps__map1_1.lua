local mapBase = require 'BaseOperate__maps__map'
local img1_1 = require 'BaseOperate__maps__img1_1'
local map1_1 = {}

-- 获取地图采样位置。由于地图可能超出一屏，所以这里可以定义多个采样位置。每次扫描都会对每个采样位置进行扫描
-- 标志位为地图四个角。每个采样位置只需定义一个角的坐标即可。
-- 还需要定义每个采样位置的地图矩阵与屏幕坐标的映射关系
map1_1.getCheckpositionList = function()
  local list = {
    {
      leftTop = nil,
      rightTop = nil,
      leftBotton = { 352, 676 },
      rightBotton = nil,
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的
      positionMap = {
        { { 377, 540, 0x192842 }, { 559, 540, 0xbdbabd }, { 744, 540, 0x21354a }, { 927, 540, 0x21394a }, { 1111, 540, 0x21394a }, { 1294, 540, 0x213952 }, { 1478, 540, 0x21354a }, { 1662, 540, 0x21354a }, },
        { { 352, 676, 0x000000 }, { 543, 676, 0x000000 }, { 734, 676, 0x000000 }, { 926, 676, 0x000000 }, { 1117, 676, 0x000000 }, { 1309, 676, 0x000000 }, { 1500, 676, 0x000000 }, { 1693, 676, 0x000000 }, }
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
map1_1.getMapChessboard = function()
  return {
    width = 7,
    height = 1,
    obstacle = {},
    waitForBossPosition = {},
    bossPosition = {},
    myFleetList = {},
    enemyPositionList = {},
    inBattleList = {},
  }
end

map1_1.getMapPosition = function()
  return mapBase.getMapPosition(img1_1)
end

map1_1.getMoveVector = function(currentPosition, targetPosition)
  return mapBase.getMoveVector(img1_1, currentPosition, targetPosition)
end

map1_1.moveMapToCheckPosition = function(moveVector)
  return mapBase.moveMapToCheckPosition(img1_1, moveVector)
end

map1_1.scanMap = function(targetPosition, mapChessboard)
  return mapBase.scanMap(img1_1, targetPosition, mapChessboard)
end

map1_1.moveToPoint = function(targetPosition, point)
  return mapBase.moveToPoint(img1_1, targetPosition, point)
end

map1_1.findClosestEnemy = function(mapChessboard)
  return mapBase.findClosestEnemy(img1_1, mapChessboard)
end

return map1_1