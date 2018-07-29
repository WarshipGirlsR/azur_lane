local mapBase = require './map'
local imgEvent = require './img11-3'
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
      leftTop = { 561, 512 },
      rightTop = nil,
      leftBottom = nil,
      rightBottom = nil,
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的
      positionMap = {
        { { 561, 512, 0x191429 }, { 729, 512, 0x212431 }, { 898, 512, 0x211831 }, { 1068, 512, 0x211c42 }, { 1237, 512, 0x191831 }, { 1406, 512, 0x21203a }, },
        { { 545, 635, 0x000000 }, { 720, 635, 0x191429 }, { 896, 635, 0x191831 }, { 1072, 635, 0x191831 }, { 1248, 635, 0x191c31 }, { 1424, 635, 0x191c31 }, },
        { { 527, 769, 0x000000 }, { 710, 769, 0x191829 }, { 893, 769, 0x212042 }, { 1077, 769, 0x212042 }, { 1260, 769, 0x212042 }, { 1444, 769, 0x211c31 }, },
        { { 508, 914, 0x000000 }, { 699, 914, 0x211831 }, { 890, 914, 0x21204a }, { 1082, 914, 0x211c42 }, { 1273, 914, 0x211831 }, { 1465, 914, 0x191419 }, },
      },
      pointMap = {},
    },
    {
      leftTop = nil,
      rightTop = { 1611, 509 },
      leftBottom = nil,
      rightBottom = nil,
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的
      positionMap = {
        { false, false, false, false, false, { 932, 509, 0x191429 }, { 1101, 509, 0x191831 }, { 1271, 509, 0x21203a }, { 1440, 509, 0x191c31 }, { 1611, 509, 0x102031 }, },
        { false, false, false, false, false, { 931, 632, 0x21203a }, { 1107, 632, 0x212442 }, { 1284, 632, 0x313552 }, { 1460, 632, 0x423d63 }, { 1638, 632, 0x000000 }, },
        { false, false, false, false, false, { 930, 765, 0x211c31 }, { 1113, 765, 0x292042 }, { 1297, 765, 0x292042 }, { 1480, 765, 0x212442 }, { 1666, 765, 0x000000 }, },
        { false, false, false, false, false, { 928, 910, 0x21203a }, { 1120, 910, 0x292042 }, { 1312, 910, 0x292042 }, { 1504, 910, 0x31244a }, { 1697, 910, 0x000000 }, },
      },
      pointMap = {},
    },
    {
      leftTop = nil,
      rightTop = { 1471, 363 },
      leftBottom = nil,
      rightBottom = nil,
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的
      positionMap = {
        false, false, false,
        { false, false, false, false, false, { 770, 746, 0x292442 }, { 962, 746, 0x31244a }, { 1153, 746, 0x211c3a }, { 1345, 746, 0x212042 }, { 1539, 746, 0x000000 }, },
        { false, false, false, false, false, { 761, 897, 0x211c3a }, { 961, 897, 0x312452 }, { 1162, 897, 0x191831 }, { 1363, 897, 0x292042 }, { 1566, 897, 0x000000 }, },
      },
      pointMap = {},
    },
    {
      leftTop = { 579, 372 },
      rightTop = nil,
      leftBottom = nil,
      rightBottom = nil,
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的
      positionMap = {
        false, false, false,
        { { 529, 756, 0x000000 }, { 719, 756, 0x211831 }, { 911, 756, 0x191831 }, { 1103, 756, 0x211831 }, { 1294, 756, 0x21203a }, { 1487, 756, 0x211831 }, },
        { { 509, 907, 0x000000 }, { 707, 907, 0xffffff }, { 906, 907, 0x31354a }, { 1109, 907, 0x211c3a }, { 1310, 907, 0x191429 }, { 1511, 907, 0x211c3a }, },
      },
      pointMap = {},
    },
    {
      leftTop = nil,
      rightTop = nil,
      leftBottom = { 432, 908 },
      rightBottom = nil,
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的
      positionMap = {
        false, false, false,
        { { 525, 299, 0x000000 }, false, false, false, false, false, { 1674, 299, 0x191c31 }, },
        { { 505, 430, 0x000000 }, false, false, false, false, false, { 1707, 430, 0x3a3163 }, },
        { { 483, 573, 0x000000 }, false, false, false, false, false, { 1742, 573, 0x080808 }, },
        { { 459, 731, 0x000000 }, false, false, false, false, false, { 1783, 731, 0x211c3a }, },
        { { 432, 908, 0x000000 }, false, false, false, false, false, { 1828, 908, 0x000000 }, },
      },
      pointMap = {},
    },
    {
      leftTop = nil,
      rightTop = nil,
      leftBottom = nil,
      rightBottom = { 1646, 911 },
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的
      positionMap = {
        false, false, false,
        { false, false, false, { 373, 302, 0x211831 }, false, false, false, false, false, { 1525, 302, 0x000000 }, },
        { false, false, false, { 346, 432, 0x424163 }, false, false, false, false, false, { 1551, 432, 0x000000 }, },
        { false, false, false, { 316, 576, 0x424121 }, false, false, false, false, false, { 1579, 576, 0x000000 }, },
        { false, false, false, { 283, 734, 0x191831 }, false, false, false, false, false, { 1611, 734, 0x000000 }, },
        { false, false, false, { 247, 911, 0x000000 }, false, false, false, false, false, { 1646, 911, 0x000000 }, },
      },
      pointMap = {},
    },
  })
  return list
end

-- 获取地图棋盘和相关数据
mapEvent.getMapChessboard = function()
  return {
    width = 9,
    height = 7,
    obstacle = {
      { 1, 1 }, { 1, 7 }, { 1, 8 }, { 1, 9 },
      { 4, 2 }, { 4, 3 }, { 4, 5 }, { 4, 6 }, { 4, 7 },
      { 5, 1 }, { 5, 2 }, { 5, 3 },
      { 6, 7 },
      { 7, 5 },
    },
    waitForBossPosition = { { 7, 9 } },
    bossPosition = {},
    myFleetList = {},
    enemyPositionList1 = {},
    enemyPositionList2 = {},
    enemyPositionList3 = {},
    movableEnemyPositionList = {},
    inBattleList = {},
    selectedArrowList = {},
    rewardBoxList = {},
  }
end

return mapEvent