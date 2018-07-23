local mapBase = require './map'
local imgEvent = require './img10-2'
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
      leftTop = { 606, 519 },
      rightTop = nil,
      leftBottom = nil,
      rightBottom = nil,
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的
      positionMap = {
        { { 606, 519, 0x312810 }, { 762, 519, 0x191819 }, { 944, 519, 0x081421 }, { 1113, 519, 0x101829 }, { 1282, 519, 0x101829 }, },
        { { 593, 642, 0xb5b6bd }, { 760, 642, 0xdeb67b }, { 943, 642, 0x21183a }, { 1119, 642, 0x21203a }, { 1295, 642, 0x212042 }, },
        { { 577, 776, 0x000000 }, { 759, 776, 0x191831 }, { 942, 776, 0x313931 }, { 1126, 776, 0x212042 }, { 1309, 776, 0x292042 }, },
        { { 560, 922, 0x000000 }, { 750, 922, 0x211c42 }, { 941, 922, 0x191831 }, { 1133, 922, 0x312d3a }, { 1325, 922, 0x312d52 }, },
      },
      pointMap = {},
    },
    {
      leftTop = nil,
      rightTop = { 1513, 526 },
      leftBottom = nil,
      rightBottom = nil,
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的
      positionMap = {
        { false, false, false, false, { 835, 526, 0x101421 }, { 1004, 526, 0x191829 }, { 1173, 526, 0x101429 }, { 1342, 526, 0x211c31 }, { 1513, 526, 0x101c29 }, },
        { false, false, false, false, { 829, 650, 0x21203a }, { 1005, 650, 0x212042 }, { 1182, 650, 0x292852 }, { 1358, 650, 0x423d63 }, { 1536, 650, 0x000000 }, },
        { false, false, false, false, { 824, 784, 0x292442 }, { 1008, 784, 0x292042 }, { 1191, 784, 0x211c3a }, { 1374, 784, 0x31244a }, { 1560, 784, 0x000000 }, },
        { false, false, false, false, { 816, 930, 0xada2ad }, { 1009, 930, 0x211829 }, { 1201, 930, 0x211c3a }, { 1391, 930, 0x191419 }, { 1588, 930, 0x101010 }, },
      },
      pointMap = {},
    },
    {
      leftTop = nil,
      rightTop = nil,
      leftBottom = { 509, 939 },
      rightBottom = nil,
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的
      positionMap = {
        false, false, false,
        { { 568, 478, 0x000000 }, { 758, 478, 0x211c42 }, { 950, 478, 0x31285a }, { 1143, 478, 0x212029 }, { 1334, 478, 0x292042 }, },
        { { 550, 617, 0x000000 }, { 750, 617, 0x191429 }, { 950, 617, 0x191431 }, { 1150, 617, 0x191429 }, { 1351, 617, 0x211c3a }, },
        { { 530, 769, 0x000000 }, { 739, 769, 0x19183a }, { 950, 769, 0x191429 }, { 1160, 769, 0x191429 }, { 1370, 769, 0x191429 }, },
        { { 509, 939, 0x000000 }, { 728, 939, 0x000000 }, { 949, 939, 0x000000 }, { 1170, 939, 0x000000 }, { 1391, 939, 0x101010 }, },
      },
      pointMap = {},
    },
    {
      leftTop = nil,
      rightTop = nil,
      leftBottom = nil,
      rightBottom = { 1611, 934 },
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的
      positionMap = {
        false, false, false,
        { false, false, false, false, { 755, 473, 0xa49ead }, { 948, 473, 0x191829 }, { 1140, 473, 0x191831 }, { 1330, 473, 0x5a6173 }, { 1525, 473, 0x000000 }, },
        { false, false, false, false, { 747, 612, 0x211c31 }, { 948, 612, 0x211c42 }, { 1148, 612, 0x212042 }, { 1348, 612, 0x292042 }, { 1551, 612, 0x000000 }, },
        { false, false, false, false, { 736, 764, 0x211c42 }, { 947, 764, 0x191829 }, { 1156, 764, 0x292842 }, { 1367, 764, 0x211831 }, { 1580, 764, 0x000000 }, },
        { false, false, false, false, { 725, 934, 0x000000 }, { 947, 934, 0x000000 }, { 1168, 934, 0x000000 }, { 1388, 934, 0x211c21 }, { 1611, 934, 0x191819 }, },
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
    height = 6,
    obstacle = {
      { 1, 6 },
      { 2, 2 }, { 2, 3 }, { 2, 6 },
      { 3, 3 }, { 3, 4 }, { 3, 8 },
      { 4, 3 }, { 4, 4 }, { 4, 8 },
      { 5, 2 }, { 5, 3 }, { 5, 6 },
      { 6, 6 },
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