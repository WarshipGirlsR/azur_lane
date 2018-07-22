local mapBase = require './map'
local imgEvent = require './img4-sos'
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
      leftTop = { 594, 526 },
      rightTop = nil,
      leftBotton = nil,
      rightBotton = nil,
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的
      positionMap = {
        { { 594, 526, 0x423d42 }, false, false, false, false, false, false, { 1733, 526, 0x312821 }, },
        { { 579, 645, 0x000000 }, false, false, false, false, false, false, { 1763, 645, 0x7b5d4a }, },
        { { 564, 773, 0x000000 }, false, false, false, false, false, false, { 1795, 773, 0x7b5d4a }, },
        { { 547, 913, 0x000000 }, false, false, false, false, false, false, { 1830, 913, 0x63493a }, },
      },
      pointMap = {},
    },
    {
      leftTop = nil,
      rightTop = { 1612, 525 },
      leftBotton = nil,
      rightBotton = nil,
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的
      positionMap = {
        { { 308, 525, 0x212029 }, false, false, false, false, false, false, false, { 1612, 525, 0x312821 }, },
        { { 282, 644, 0x000000 }, false, false, false, false, false, false, false, { 1637, 644, 0x000000 }, },
        { { 255, 772, 0x000000 }, false, false, false, false, false, false, false, { 1664, 772, 0x000000 }, },
        { { 225, 912, 0x000000 }, false, false, false, false, false, false, false, { 1694, 912, 0x000000 }, }
      },
      pointMap = {},
    },
    {
      leftTop = { 610, 268 },
      rightTop = nil,
      leftBotton = nil,
      rightBotton = nil,
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的
      positionMap = {
        { { 610, 268, 0x3a3529 }, false, false, false, false, false, { 1589, 268, 0x292429 }, },
        { { 597, 377, 0x000000 }, false, false, false, false, false, { 1611, 377, 0x735d4a }, },
        { { 582, 495, 0x000000 }, false, false, false, false, false, { 1637, 495, 0x734d4a }, },
        { { 566, 623, 0x000000 }, false, false, false, false, false, { 1666, 623, 0x6b5142 }, },
        { { 549, 762, 0x000000 }, false, false, false, false, false, { 1697, 762, 0x523d42 }, },
        { { 530, 914, 0x000000 }, false, false, false, false, false, { 1731, 914, 0x291c21 }, },
      },
      pointMap = {},
    },
    {
      leftTop = nil,
      rightTop = { 1560, 267 },
      leftBotton = nil,
      rightBotton = nil,
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的
      positionMap = {
        { false, { 418, 267, 0x292429 }, false, false, false, false, false, false, { 1560, 267, 0x312419 }, },
        { false, { 397, 376, 0x4a314a }, false, false, false, false, false, false, { 1584, 376, 0x000000 }, },
        { false, { 374, 494, 0x5a4152 }, false, false, false, false, false, false, { 1609, 494, 0x000000 }, },
        { false, { 350, 622, 0x4a3d52 }, false, false, false, false, false, false, { 1637, 622, 0x000000 }, },
        { false, { 323, 761, 0x633d5a }, false, false, false, false, false, false, { 1666, 761, 0x000000 }, },
        { false, { 294, 913, 0x5a493a }, false, false, false, false, false, false, { 1699, 913, 0x000000 }, },
      },
      pointMap = {},
    },
    {
      leftTop = nil,
      rightTop = nil,
      leftBotton = { 527, 917 },
      rightBotton = nil,
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的
      positionMap = {
        false, false,
        { { 615, 217, 0x000000 }, false, false, false, false, false, { 1670, 217, 0x634d42 }, },
        { { 600, 333, 0x000000 }, false, false, false, false, false, { 1700, 333, 0x735142 }, },
        { { 585, 459, 0x000000 }, false, false, false, false, false, { 1733, 459, 0x5a414a }, },
        { { 567, 597, 0x000000 }, false, false, false, false, false, { 1769, 597, 0x5a3542 }, },
        { { 548, 748, 0x000000 }, false, false, false, false, false, { 1808, 748, 0x422442 }, },
        { { 527, 917, 0x000000 }, false, false, false, false, false, { 1851, 917, 0x100c10 }, },
      },
      pointMap = {},
    },
    {
      leftTop = nil,
      rightTop = nil,
      leftBotton = nil,
      rightBotton = { 1627, 917 },
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的
      positionMap = {
        false, false,
        { false, false, { 433, 217, 0xa49694 }, false, false, false, false, false, { 1492, 217, 0x000000 }, },
        { false, false, { 411, 333, 0x52414a }, false, false, false, false, false, { 1514, 333, 0x000000 }, },
        { false, false, { 387, 459, 0x7b4d5a }, false, false, false, false, false, { 1539, 459, 0x000000 }, },
        { false, false, { 360, 597, 0x422d4a }, false, false, false, false, false, { 1566, 597, 0x000000 }, },
        { false, false, { 331, 748, 0x29243a }, false, false, false, false, false, { 1595, 748, 0x000000 }, },
        { false, false, { 299, 917, 0x000000 }, false, false, false, false, false, { 1627, 917, 0x100c10 }, },
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
    height = 7,
    obstacle = {
      { 1, 5 },
      { 3, 2 },
      { 4, 8 },
      { 6, 1 },
      { 7, 1 }, { 7, 3 }, { 7, 7 },
    },
    waitForBossPosition = { { 2, 4 }, { 2, 5 } },
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