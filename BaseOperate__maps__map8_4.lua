local mapBase = require 'BaseOperate__maps__map'
local img8_4 = require 'BaseOperate__maps__img8_4'
local map8_4 = {}

-- 获取地图采样位置。由于地图可能超出一屏，所以这里可以定义多个采样位置。每次扫描都会对每个采样位置进行扫描
-- 标志位为地图四个角。每个采样位置只需定义一个角的坐标即可。
-- 还需要定义每个采样位置的地图矩阵与屏幕坐标的映射关系
map8_4.getCheckpositionList = function()
  local list = {
    {
      leftTop = nil,
      rightTop = { 1693, 509 },
      leftBotton = nil,
      rightBotton = nil,
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的
      positionMap = {
        { { 385, 509, 0xa4d2ff }, { 551, 509, 0x192031 }, { 714, 509, 0x101c29 }, { 877, 509, 0x212042 }, { 1040, 509, 0x191c31 }, { 1202, 509, 0x192031 }, { 1365, 509, 0x212442 }, { 1528, 509, 0x212031 }, { 1693, 509, 0x212442 }, },
        { { 367, 627, 0x000000 }, { 535, 627, 0x21719c }, { 703, 627, 0xffffff }, { 873, 627, 0x218194 }, { 1043, 627, 0x21798c }, { 1212, 627, 0x197984 }, { 1381, 627, 0x218194 }, { 1550, 627, 0x19798c }, { 1721, 627, 0x000000 }, },
        { { 343, 755, 0x000000 }, { 518, 755, 0x19798c }, { 694, 755, 0x19758c }, { 870, 755, 0x292829 }, { 1046, 755, 0x10718c }, { 1222, 755, 0x19698c }, { 1398, 755, 0x19718c }, { 1574, 755, 0x19798c }, { 1752, 755, 0x000000 }, },
        { { 317, 893, 0x000000 }, { 499, 893, 0x197994 }, { 682, 893, 0x107984 }, { 866, 893, 0x197984 }, { 1047, 893, 0x9cd2f7 }, { 1233, 893, 0x215d84 }, { 1417, 893, 0x217194 }, { 1600, 893, 0x196d8c }, { 1786, 893, 0x000000 }, },
      },
      pointMap = {},
    },
    {
      leftTop = nil,
      rightTop = { 1666, 264 },
      leftBotton = nil,
      rightBotton = nil,
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的
      positionMap = {
        false, false, false,
        { { 286, 617, 0x000000 }, { 469, 617, 0x217994 }, { 652, 617, 0x10798c }, { 835, 617, 0x218194 }, { 1019, 617, 0x73b6ef }, { 1202, 617, 0x11557b }, { 1386, 617, 0x196d84 }, { 1569, 617, 0x21718c }, { 1755, 617, 0x000000 }, },
        { { 257, 756, 0x000000 }, { 447, 756, 0x297194 }, { 639, 756, 0x29718c }, { 830, 756, 0x216984 }, { 1021, 756, 0x104d73 }, { 1213, 756, 0x29598c }, { 1405, 756, 0x215d8c }, { 1596, 756, 0x317d9c }, { 1790, 756, 0x3a4d5a }, },
        { { 224, 908, 0x000000 }, { 423, 908, 0x21618c }, { 623, 908, 0x3a7194 }, { 824, 908, 0x195d8c }, { 1024, 908, 0x21518c }, { 1225, 908, 0x104573 }, { 1425, 908, 0x294d7b }, { 1626, 908, 0x315184 }, { 1829, 908, 0x000000 }, },
      },
      pointMap = {},
    },
    {
      leftTop = nil,
      rightTop = nil,
      leftBotton = { 528, 906 },
      rightBotton = nil,
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的
      positionMap = {
        false, false, false, false, false,
        { { 568, 587, 0x000000 }, { 767, 587, 0x316194 }, { 968, 587, 0xb5dbef }, { 1168, 587, 0x08517b }, { 1369, 587, 0x104d7b }, },
        { { 549, 738, 0x000000 }, { 758, 738, 0x216994 }, { 968, 738, 0x215584 }, { 1178, 738, 0x21558c }, { 1388, 738, 0x194984 }, },
        { { 528, 906, 0x000000 }, { 747, 906, 0x000000 }, { 968, 906, 0x000000 }, { 1189, 906, 0x000000 }, { 1411, 906, 0x000000 }, },
      },
      pointMap = {},
    },
    {
      leftTop = nil,
      rightTop = nil,
      leftBotton = nil,
      rightBotton = { 1737, 905 },
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的
      positionMap = {
        false, false, false, false, false,
        { false, false, false, false, { 860, 586, 0x215184 }, { 1060, 586, 0x214984 }, { 1261, 586, 0x214d7b }, { 1461, 586, 0x294973 }, { 1664, 586, 0x000000 }, },
        { false, false, false, false, { 855, 736, 0x084973 }, { 1065, 736, 0x113d73 }, { 1275, 736, 0x104573 }, { 1485, 736, 0x21497b }, { 1698, 736, 0x000000 }, },
        { false, false, false, false, { 850, 905, 0x000000 }, { 1071, 905, 0x000000 }, { 1292, 905, 0x000000 }, { 1513, 905, 0x000000 }, { 1737, 905, 0x000000 }, },
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
map8_4.getMapChessboard = function()
  return {
    width = 8,
    height = 7,
    obstacle = {
      { 1, 1 },
      { 2, 6 }, { 2, 7 },
      { 3, 4 }, { 3, 5 },
      { 4, 1 }, { 4, 2 }, { 4, 4 }, { 4, 5 },
      { 5, 2 }, { 5, 8 },
      { 6, 5 }, { 6, 6 },
    },
    waitForBossPosition = { { 7, 8 } },
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

map8_4.getMapPosition = function(currentPosition)
  return mapBase.getMapPosition(img8_4, currentPosition)
end

map8_4.getMoveVector = function(currentPosition, targetPosition)
  return mapBase.getMoveVector(img8_4, currentPosition, targetPosition)
end

map8_4.moveMapToCheckPosition = function(moveVector)
  return mapBase.moveMapToCheckPosition(img8_4, moveVector)
end

map8_4.scanMap = function(targetPosition, mapChessboard)
  return mapBase.scanMap(img8_4, targetPosition, mapChessboard)
end

map8_4.moveToPoint = function(targetPosition, point)
  return mapBase.moveToPoint(img8_4, targetPosition, point)
end

map8_4.checkMoveToPointPath = function(mapChessboard, start, target)
  return mapBase.checkMoveToPointPath(map8_4, mapChessboard, start, target)
end

map8_4.findClosestEnemy = function(mapChessboard)
  return mapBase.findClosestEnemy(img8_4, mapChessboard)
end

return map8_4