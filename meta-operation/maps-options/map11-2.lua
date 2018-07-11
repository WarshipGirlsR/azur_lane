local mapBase = require './map'
local imgEvent = require './img11-2'
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
      leftTop = { 476, 497 },
      rightTop = nil,
      leftBotton = nil,
      rightBotton = nil,
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的
      positionMap = {
        { { 476, 497, 0x080408 }, { 645, 497, 0x191819 }, { 813, 497, 0x5a7584 }, { 982, 497, 0x000808 }, { 1151, 497, 0x080810 }, { 1321, 497, 0x191421 }, { 1490, 497, 0x081019 }, },
        { { 453, 620, 0x6b7184 }, { 631, 620, 0x9cb6bd }, { 807, 620, 0x211831 }, { 983, 620, 0x211c3a }, { 1159, 620, 0x21203a }, { 1335, 620, 0x212042 }, { 1511, 620, 0x212042 }, },
        { { 435, 753, 0x000000 }, { 617, 753, 0xffffff }, { 801, 753, 0x211c3a }, { 984, 753, 0x191831 }, { 1168, 753, 0x191831 }, { 1351, 753, 0x292442 }, { 1535, 753, 0x21203a }, },
        { { 412, 898, 0x000000 }, { 602, 898, 0x211c42 }, { 793, 898, 0x211c31 }, { 985, 898, 0x211831 }, { 1177, 898, 0x211831 }, { 1368, 898, 0x211c3a }, { 1560, 898, 0x21204a }, },
      },
      pointMap = {},
    },
    {
      leftTop = nil,
      rightTop = { 1592, 499 },
      leftBotton = nil,
      rightBotton = nil,
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的
      positionMap = {
        { false, false, false, false, false, false, { 743, 499, 0x080810 }, { 913, 499, 0x080810 }, { 1082, 499, 0x000808 }, { 1251, 499, 0x191421 }, { 1420, 499, 0x52555a }, { 1592, 499, 0x000810 }, },
        { false, false, false, false, false, false, { 735, 621, 0x292442 }, { 911, 621, 0x212442 }, { 1087, 621, 0x29244a }, { 1263, 621, 0x312d52 }, { 1439, 621, 0x3a3563 }, { 1617, 621, 0x000000 }, },
        { false, false, false, false, false, false, { 725, 754, 0x21203a }, { 909, 754, 0x212042 }, { 1092, 754, 0x292042 }, { 1274, 754, 0xada2ad }, { 1460, 754, 0x3a3552 }, { 1645, 754, 0x000000 }, },
        { false, false, false, false, false, false, { 715, 899, 0x191c42 }, { 906, 899, 0x191829 }, { 1098, 899, 0x191831 }, { 1290, 899, 0x191831 }, { 1481, 899, 0x292442 }, { 1675, 899, 0x000000 }, },
      },
      pointMap = {},
    },
    {
      leftTop = nil,
      rightTop = nil,
      leftBotton = { 377, 972 },
      rightBotton = nil,
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的
      positionMap = {
        false, false, false,
        { { 455, 506, 0x000000 }, { 645, 506, 0x191831 }, { 837, 506, 0x211c31 }, { 1029, 506, 0x211831 }, { 1220, 506, 0x211c3a }, { 1411, 506, 0x211831 }, { 1604, 506, 0x212042 }, },
        { { 431, 646, 0x000000 }, { 631, 646, 0x191831 }, { 831, 646, 0x191831 }, { 1031, 646, 0x21183a }, { 1231, 646, 0x211831 }, { 1432, 646, 0x211c3a }, { 1632, 646, 0x211c3a }, },
        { { 406, 800, 0x000000 }, { 614, 800, 0x211c42 }, { 824, 800, 0x423963 }, { 1035, 800, 0x211831 }, { 1245, 800, 0x211831 }, { 1455, 800, 0x191829 }, { 1665, 800, 0x191829 }, },
        { { 377, 972, 0x000000 }, { 596, 972, 0x000000 }, { 818, 972, 0x000000 }, { 1038, 972, 0x848184 }, { 1259, 972, 0x8c8a8c }, { 1480, 972, 0x313531 }, },
      },
      pointMap = {},
    },
    {
      leftTop = nil,
      rightTop = nil,
      leftBotton = nil,
      rightBotton = { 1550, 953 },
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的
      positionMap = {
        false, false, false,
        { false, false, false, false, false, false, { 619, 497, 0x211c3a }, { 811, 497, 0x211c31 }, { 1002, 497, 0x191831 }, { 1195, 497, 0x211c3a }, { 1386, 497, 0x211c3a }, { 1580, 497, 0x000000 }, },
        { false, false, false, false, false, false, { 603, 636, 0x191829 }, { 804, 636, 0x211c42 }, { 1005, 636, 0x211831 }, { 1205, 636, 0x211c31 }, { 1405, 636, 0x292042 }, { 1608, 636, 0x000000 }, },
        { false, false, false, false, false, false, { 586, 789, 0x191421 }, { 796, 789, 0x191429 }, { 1007, 789, 0x211c3a }, { 1217, 789, 0x211c3a }, { 1427, 789, 0x211c3a }, { 1640, 789, 0x000000 }, },
        { false, false, false, false, false, false, { 567, 961, 0x000000 }, { 788, 961, 0x000000 }, { 1009, 961, 0x000000 }, { 1230, 961, 0x000000 }, { 1451, 961, 0x3a3d3a }, { 1675, 961, 0xc57d42 }, },
      },
      pointMap = {},
    },
  })
  return list
end

-- 获取地图棋盘和相关数据
mapEvent.getMapChessboard = function()
  return {
    width = 11,
    height = 6,
    obstacle = {
      { 1, 1 }, { 1, 2 }, { 1, 3 }, { 1, 6 },
      { 2, 8 }, { 2, 9 },
      { 3, 3 }, { 3, 9 },
      { 4, 3 },
      { 5, 2 }, { 5, 3 }, { 5, 4 }, { 5, 9 }, { 5, 10 }, { 5, 11 },
      { 6, 6 },
    },
    waitForBossPosition = { { 4, 10 } },
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