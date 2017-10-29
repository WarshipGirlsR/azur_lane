local mapBase = require 'BaseOperate__maps__map'
local img6_3 = require 'BaseOperate__maps__img6_3'
local map6_3 = {}

-- 获取地图采样位置。由于地图可能超出一屏，所以这里可以定义多个采样位置。每次扫描都会对每个采样位置进行扫描
-- 标志位为地图四个角。每个采样位置只需定义一个角的坐标即可。
-- 还需要定义每个采样位置的地图矩阵与屏幕坐标的映射关系
map6_3.getCheckpositionList = function()
  local list = {
    {
      leftTop = nil,
      rightTop = { 1685, 483 },
      leftBotton = nil,
      rightBotton = nil,
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的
      positionMap = {
        { { 332, 483, 0x101c21 }, { 500, 483, 0x111c21 }, { 669, 483, 0x5a4921 }, { 838, 483, 0x192029 }, { 1008, 483, 0x192031 }, { 1177, 483, 0x21243a }, { 1346, 483, 0x192431 }, { 1515, 483, 0x212431 }, { 1685, 483, 0x293142 }, },
        { { 306, 605, 0x191000 }, { 481, 605, 0x211c42 }, { 658, 605, 0x191831 }, { 834, 605, 0x191831 }, { 1010, 605, 0x211c3a }, { 1186, 605, 0x191c31 }, { 1362, 605, 0x192042 }, { 1538, 605, 0x29284a }, { 1715, 605, 0x000000 }, },
        { { 278, 738, 0x000000 }, { 461, 738, 0x211831 }, { 645, 738, 0x21183a }, { 828, 738, 0x212042 }, { 1010, 738, 0x31456b }, { 1195, 738, 0x211831 }, { 1379, 738, 0x211c31 }, { 1563, 738, 0x292042 }, { 1747, 738, 0x000000 }, },
        { { 248, 882, 0x000000 }, { 439, 882, 0x21183a }, { 631, 882, 0x21183a }, { 823, 882, 0x191831 }, { 1014, 882, 0x211c3a }, { 1206, 882, 0x211c3a }, { 1397, 882, 0x211831 }, { 1589, 882, 0x211c3a }, { 1782, 882, 0x000000 }, },
      },
      pointMap = {},
    },
    {
      leftTop = nil,
      rightTop = nil,
      leftBotton = { 450, 886 },
      rightBotton = nil,
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的
      positionMap = {
        false, false, false,
        { { 494, 584, 0x000000 }, { 685, 584, 0x21183a }, { 877, 584, 0x21183a }, { 1069, 584, 0x191831 }, { 1261, 584, 0x191831 }, },
        { { 472, 727, 0x000000 }, { 674, 727, 0x4a3d10 }, { 873, 727, 0x211c3a }, { 1074, 727, 0x191429 }, { 1273, 727, 0x191831 }, },
        { { 450, 886, 0x000000 }, { 658, 886, 0x000000 }, { 868, 886, 0x000000 }, { 1079, 886, 0x000000 }, { 1289, 886, 0x000000 }, },
      },
      pointMap = {},
    },
    {
      leftTop = nil,
      rightTop = nil,
      leftBotton = nil,
      rightBotton = { 1711, 885 },
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的
      positionMap = {
        false, false, false,
        { false, false, false, false, { 877, 582, 0x191829 }, { 1069, 582, 0x211831 }, { 1260, 582, 0x21203a }, { 1452, 582, 0x292042 }, { 1645, 582, 0x000000 }, },
        { false, false, false, false, { 874, 725, 0x101021 }, { 1073, 725, 0x211c31 }, { 1274, 725, 0x191829 }, { 1474, 725, 0x191831 }, { 1676, 725, 0x000000 }, },
        { false, false, false, false, { 869, 885, 0x000000 }, { 1079, 885, 0x000000 }, { 1290, 885, 0x000000 }, { 1499, 885, 0x000000 }, { 1711, 885, 0x000000 }, },
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
map6_3.getMapChessboard = function()
  return {
    width = 8,
    height = 5,
    obstacle = { { 2, 4 }, { 2, 5 }, { 3, 5 }, { 5, 1 } },
    waitForBossPosition = { { 3, 4 } },
    bossPosition = {},
    myFleetList = {},
    enemyPositionList = {},
    inBattleList = {},
    selectedArrowList = {},
  }
end

map6_3.getMapPosition = function(currentPosition)
  return mapBase.getMapPosition(img6_3, currentPosition)
end

map6_3.getMoveVector = function(currentPosition, targetPosition)
  return mapBase.getMoveVector(img6_3, currentPosition, targetPosition)
end

map6_3.moveMapToCheckPosition = function(moveVector)
  return mapBase.moveMapToCheckPosition(img6_3, moveVector)
end

map6_3.scanMap = function(targetPosition, mapChessboard)
  return mapBase.scanMap(img6_3, targetPosition, mapChessboard)
end

map6_3.moveToPoint = function(targetPosition, point)
  return mapBase.moveToPoint(img6_3, targetPosition, point)
end

map6_3.checkMoveToPointPath = function(mapChessboard, start, target)
  return mapBase.checkMoveToPointPath(map6_3, mapChessboard, start, target)
end

map6_3.findClosestEnemy = function(mapChessboard)
  return mapBase.findClosestEnemy(img6_3, mapChessboard)
end

return map6_3