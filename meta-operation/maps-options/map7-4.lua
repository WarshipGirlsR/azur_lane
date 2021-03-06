local mapBase = require './map'
local imgEvent = require './img7-4'
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
      rightTop = { 1695, 497 },
      leftBottom = nil,
      rightBottom = nil,
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的
      positionMap = {
        { { 341, 497, 0x101821 }, { 508, 497, 0x081019 }, { 677, 497, 0x212031 }, { 846, 497, 0x081419 }, { 1016, 497, 0x111421 }, { 1185, 497, 0x211c29 }, { 1354, 497, 0x111c21 }, { 1523, 497, 0x192532 }, { 1695, 497, 0x192029 }, },
        { { 314, 620, 0x523d10 }, { 490, 620, 0x211c3a }, { 666, 620, 0x212042 }, { 842, 620, 0x212442 }, { 1018, 620, 0x292042 }, { 1194, 620, 0x31284a }, { 1370, 620, 0x29284a }, { 1546, 620, 0x3a3563 }, { 1724, 620, 0x000000 }, },
        { { 288, 753, 0x000000 }, { 470, 753, 0x191829 }, { 654, 753, 0x4a3d19 }, { 837, 753, 0x211c42 }, { 1021, 753, 0x292042 }, { 1204, 753, 0x211c31 }, { 1387, 753, 0x212042 }, { 1571, 753, 0x31244a }, { 1757, 753, 0x000000 }, },
        { { 258, 898, 0x000000 }, { 448, 898, 0x211c42 }, { 640, 898, 0x212042 }, { 831, 898, 0x211831 }, { 1023, 898, 0x211831 }, { 1215, 898, 0x211831 }, { 1407, 898, 0x291c3a }, { 1598, 898, 0x292042 }, { 1792, 898, 0x000000 }, },
      },
      pointMap = {},
    },
    {
      leftTop = nil,
      rightTop = { 1693, 373 },
      leftBottom = nil,
      rightBottom = nil,
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的
      positionMap = {
        false, false, false,
        { { 256, 756, 0x000000 }, { 446, 756, 0x211c42 }, { 638, 756, 0x212042 }, { 831, 756, 0x3a356b }, { 1021, 756, 0x211831 }, { 1213, 756, 0x211831 }, { 1404, 756, 0x292042 }, { 1596, 756, 0x292442 }, { 1790, 756, 0x000000 }, },
        { { 224, 908, 0x000000 }, { 423, 908, 0x191831 }, { 624, 908, 0x211c42 }, { 818, 908, 0x292831 }, { 1024, 908, 0x42517b }, { 1225, 908, 0x191831 }, { 1425, 908, 0x211831 }, { 1626, 908, 0x292042 }, { 1829, 908, 0x000000 }, },
      },
      pointMap = {},
    },
    {
      leftTop = nil,
      rightTop = nil,
      leftBottom = { 503, 895 },
      rightBottom = nil,
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的
      positionMap = {
        false, false, false, false,
        { { 545, 577, 0x000000 }, { 743, 577, 0x19183a }, { 944, 577, 0x191431 }, { 1142, 577, 0x191c21 }, { 1345, 577, 0x6b819c }, },
        { { 525, 727, 0x000000 }, { 734, 727, 0x191431 }, { 944, 727, 0x191429 }, { 1154, 727, 0x191429 }, { 1364, 727, 0x191429 }, },
        { { 503, 895, 0x000000 }, { 722, 895, 0x000000 }, { 943, 895, 0x000000 }, { 1164, 895, 0x000000 }, { 1385, 895, 0x000000 }, },
      },
      pointMap = {},
    },
    {
      leftTop = nil,
      rightTop = nil,
      leftBottom = nil,
      rightBottom = { 1681, 898 },
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的
      positionMap = {
        false, false, false, false,
        { false, false, false, false, { 808, 580, 0x52598c }, { 1010, 580, 0x211c3a }, { 1211, 580, 0x211831 }, { 1411, 580, 0x21203a }, { 1614, 580, 0x000000 }, },
        { false, false, false, false, { 803, 730, 0x191831 }, { 1013, 730, 0x191829 }, { 1223, 730, 0x191831 }, { 1433, 730, 0x211831 }, { 1646, 730, 0x000000 }, },
        { false, false, false, false, { 794, 898, 0x000000 }, { 1016, 898, 0x000000 }, { 1236, 898, 0x000000 }, { 1457, 898, 0x000000 }, { 1681, 898, 0x000000 }, },
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
      { 1, 5 }, { 1, 6 }, { 1, 7 },
      { 3, 2 },
      { 4, 2 }, { 4, 3 }, { 4, 4 },
      { 5, 4 }, { 5, 6 },
    },
    waitForBossPosition = { { 1, 1 }, { 1, 8 }, { 6, 7 } },
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