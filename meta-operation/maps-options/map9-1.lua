local mapBase = require './map'
local imgEvent = require './img9-1'
local mapEvent = {}

-- 从mapBase继承方法
mapEvent = table.assign(mapEvent, mapBase)
for key, value in pairs(mapBase) do
  if type(value) == 'function' then
    mapEvent[key] = function(...)
      return value(imgEvent, ...)
    end
  end
end

-- 获取地图采样位置。由于地图可能超出一屏，所以这里可以定义多个采样位置。每次扫描都会对每个采样位置进行扫描
-- 标志位为地图四个角。每个采样位置只需定义一个角的坐标即可。
-- 还需要定义每个采样位置的地图矩阵与屏幕坐标的映射关系
mapEvent.getCheckpositionList = function()
  local list = mapBase.calCheckpositionList({
    {
      leftTop = nil,
      rightTop = { 1670, 530 },
      leftBotton = nil,
      rightBotton = nil,
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的
      positionMap = {
        { { 303, 530, 0x192431 }, { 472, 530, 0x6b7584 }, { 643, 530, 0x9caabd }, { 811, 530, 0x5a558c }, { 985, 530, 0x081421 }, { 1156, 530, 0x101829 }, { 1325, 530, 0x081419 }, { 1497, 530, 0x101c31 }, { 1670, 530, 0x212042 }, },
        { { 274, 655, 0x000000 }, { 451, 655, 0x211c3a }, { 629, 655, 0x211c3a }, { 805, 655, 0x31354a }, { 989, 655, 0x313d63 }, { 1165, 655, 0x292442 }, { 1343, 655, 0x29244a }, { 1521, 655, 0x31315a }, { 1702, 655, 0x000000 }, },
        { { 241, 793, 0x000000 }, { 426, 793, 0x191831 }, { 613, 793, 0x211c3a }, { 801, 793, 0x211c3a }, { 988, 793, 0x191831 }, { 1175, 793, 0x211c3a }, { 1362, 793, 0x191831 }, { 1546, 793, 0x3a2d63 }, { 1737, 793, 0x000000 }, },
        { { 205, 944, 0x000000 }, { 400, 944, 0x211c42 }, { 598, 944, 0x8c8a8c }, { 793, 944, 0x191831 }, { 989, 944, 0x191831 }, { 1186, 944, 0x21203a }, { 1382, 944, 0x191421 }, { 1577, 943, 0x191421 }, { 1778, 944, 0x101010 }, },
      },
      pointMap = {},
    },
    {
      leftTop = nil,
      rightTop = nil,
      leftBotton = { 502, 893 },
      rightBotton = nil,
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的
      positionMap = {
        false, false, false,
        { { 548, 578, 0x000000 }, { 743, 578, 0x3a3942 }, { 939, 578, 0x191819 }, { 1135, 578, 0x191831 }, { 1331, 578, 0x191831 }, },
        { { 526, 726, 0x000000 }, { 731, 726, 0x211831 }, { 938, 726, 0x31244a }, { 1144, 726, 0x292042 }, { 1351, 726, 0x191829 }, },
        { { 502, 893, 0x000000 }, { 718, 893, 0x000000 }, { 937, 893, 0x000000 }, { 1155, 893, 0x000000 }, { 1373, 893, 0x000000 }, },
      },
      pointMap = {},
    },
    {
      leftTop = nil,
      rightTop = nil,
      leftBotton = nil,
      rightBotton = { 1705, 893 },
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的
      positionMap = {
        false, false, false,
        { false, false, false, false, { 843, 578, 0x191831 }, { 1040, 578, 0x21203a }, { 1236, 578, 0x211c3a }, { 1432, 578, 0x292042 }, { 1631, 578, 0x000000 }, },
        { false, false, false, false, { 838, 726, 0x211c42 }, { 1044, 726, 0x211c3a }, { 1251, 726, 0x211831 }, { 1457, 726, 0x211831 }, { 1666, 726, 0x000000 }, },
        { false, false, false, false, { 831, 893, 0x000000 }, { 1049, 893, 0x000000 }, { 1267, 893, 0x000000 }, { 1485, 893, 0x000000 }, { 1705, 893, 0x000000 }, },
      },
      pointMap = {},
    },
  })
  return list
end

-- 获取地图棋盘和相关数据
mapEvent.getMapChessboard = function()
  return {
    width = 8,
    height = 5,
    obstacle = {
      { 1, 3 }, { 1, 4 }, { 1, 5 },
      { 2, 1 }, { 2, 3 }, { 2, 4 }, { 2, 5 }, { 2, 7 }, { 2, 8 },
      { 3, 7 }, { 3, 8 },
      { 4, 3 }, { 4, 6 },
      { 5, 3 },
    },
    waitForBossPosition = { { 1, 8 } },
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

return mapEvent