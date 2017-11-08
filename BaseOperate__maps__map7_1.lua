local mapBase = require 'BaseOperate__maps__map'
local img7_1 = require 'BaseOperate__maps__img7_1'
local map7_1 = {}

-- 获取地图采样位置。由于地图可能超出一屏，所以这里可以定义多个采样位置。每次扫描都会对每个采样位置进行扫描
-- 标志位为地图四个角。每个采样位置只需定义一个角的坐标即可。
-- 还需要定义每个采样位置的地图矩阵与屏幕坐标的映射关系
map7_1.getCheckpositionList = function()
  local list = {
    {
      leftTop = nil,
      rightTop = { 1679, 462 },
      leftBotton = nil,
      rightBotton = nil,
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的
      positionMap = {
        { { 252, 462, 0x191421 }, { 431, 462, 0x292821 }, { 608, 462, 0x191821 }, { 786, 462, 0x191829 }, { 964, 462, 0x212431 }, { 1142, 462, 0x191c29 }, { 1322, 462, 0x191c32 }, { 1500, 462, 0x192129 }, { 1679, 462, 0x191d32 }, },
        { { 218, 590, 0x000000 }, { 404, 590, 0x21203a }, { 590, 590, 0xbdb6bd }, { 778, 590, 0x212042 }, { 965, 590, 0x212042 }, { 1152, 590, 0x292042 }, { 1339, 590, 0x211c42 }, { 1525, 590, 0x42396b }, { 1714, 590, 0x000000 }, },
        { { 181, 732, 0x21183a }, { 375, 732, 0x5a495a }, { 573, 732, 0x191831 }, { 768, 732, 0x3a5173 }, { 966, 732, 0x21203a }, { 1162, 732, 0x211c3a }, { 1358, 732, 0x21203a }, { 1554, 732, 0x292042 }, { 1752, 732, 0x000000 }, },
        { { 141, 889, 0x000000 }, { 345, 889, 0x000000 }, { 553, 889, 0x000000 }, { 758, 889, 0x000000 }, { 966, 889, 0x000000 }, { 1171, 889, 0x000000 }, { 1379, 889, 0x000000 }, { 1585, 889, 0x000000 }, { 1792, 889, 0x000000 }, },
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
map7_1.getMapChessboard = function()
  return {
    width = 8,
    height = 3,
    obstacle = {
      { 1, 7 }, { 1, 8 },
      { 2, 3 }, { 2, 4 }, { 2, 7 }, { 2, 8 },
      { 3, 3 }, { 3, 4 },
    },
    waitForBossPosition = {},
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

map7_1.getMapPosition = function(currentPosition)
  return mapBase.getMapPosition(img7_1, currentPosition)
end

map7_1.getMoveVector = function(currentPosition, targetPosition)
  return mapBase.getMoveVector(img7_1, currentPosition, targetPosition)
end

map7_1.moveMapToCheckPosition = function(moveVector)
  return mapBase.moveMapToCheckPosition(img7_1, moveVector)
end

map7_1.scanMap = function(targetPosition, mapChessboard)
  return mapBase.scanMap(img7_1, targetPosition, mapChessboard)
end

map7_1.moveToPoint = function(targetPosition, point)
  return mapBase.moveToPoint(img7_1, targetPosition, point)
end

map7_1.checkMoveToPointPath = function(mapChessboard, start, target)
  return mapBase.checkMoveToPointPath(map7_1, mapChessboard, start, target)
end

map7_1.findClosestEnemy = function(mapChessboard)
  return mapBase.findClosestEnemy(img7_1, mapChessboard)
end

map7_1.getRandomMoveAStep = function(mapChessboard)
  return mapBase.getRandomMoveAStep(img7_1, mapChessboard)
end

return map7_1