local mapBase = require './map'
local imgEvent = require './img8-4'
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
      leftTop = { 594, 530 },
      rightTop = nil,
      leftBottom = nil,
      rightBottom = nil,
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的
      positionMap = {
        { { 594, 530, 0x9cceff }, false, false, false, false, false, false, { 1736, 530, 0x212029 }, },
        { { 583, 649, 0x000000 }, false, false, false, false, false, false, { 1766, 649, 0x197984 }, },
        { { 567, 778, 0x000000 }, false, false, false, false, false, false, { 1798, 778, 0x298194 }, },
        { { 551, 918, 0x000000 }, false, false, false, false, false, false, { 1835, 918, 0x19353a }, },
      },
      pointMap = {},
    },
    {
      leftTop = { 297, 526 },
      rightTop = nil,
      leftBottom = nil,
      rightBottom = nil,
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的
      positionMap = {
        { { 297, 526, 0x9cd7ff }, false, false, false, false, false, false, false, { 1603, 526, 0x212021 }, },
        { { 274, 645, 0x000000 }, false, false, false, false, false, false, false, { 1628, 645, 0x000000 }, },
        { { 246, 774, 0x000000 }, false, false, false, false, false, false, false, { 1655, 774, 0x000000 }, },
        { { 216, 913, 0x000000 }, false, false, false, false, false, false, false, { 1685, 913, 0x000000 }, },
      },
      pointMap = {},
    },
    {
      leftTop = { 537, 277 },
      rightTop = nil,
      leftBottom = nil,
      rightBottom = nil,
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的
      positionMap = {
        false,
        { { 521, 386, 0x000000 }, false, false, false, false, false, false, { 1704, 386, 0x217d94 }, },
        { { 503, 505, 0x000000 }, false, false, false, false, false, false, { 1734, 505, 0x19757b }, },
        { { 484, 633, 0x000000 }, false, false, false, false, false, false, { 1767, 633, 0x19718c }, },
        { { 463, 772, 0x000000 }, false, false, false, false, false, false, { 1803, 772, 0x29798c }, },
        { { 440, 925, 0x000000 }, false, false, false, false, false, false, { 1843, 925, 0xceced6 }, },
      },
      pointMap = {},
    },
    {
      leftTop = nil,
      rightTop = { 1526, 275 },
      leftBottom = nil,
      rightBottom = nil,
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的
      positionMap = {
        false,
        { false, { 362, 384, 0xefbec5 }, false, false, false, false, false, false, { 1548, 384, 0x000000 }, },
        { false, { 337, 502, 0x7b869c }, false, false, false, false, false, false, { 1572, 502, 0x000400 }, },
        { false, { 311, 630, 0x197994 }, false, false, false, false, false, false, { 1598, 630, 0x000000 }, },
        { false, { 282, 770, 0x3175a4 }, false, false, false, false, false, false, { 1626, 770, 0x000000 }, },
        { false, { 251, 922, 0x296194 }, false, false, false, false, false, false, { 1657, 922, 0x101410 }, },
      },
      pointMap = {},
    },
    {
      leftTop = nil,
      rightTop = nil,
      leftBottom = { 489, 911 },
      rightBottom = nil,
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的
      positionMap = {
        false, false,
        { { 584, 212, 0x000000 }, false, false, false, false, false, { 1641, 212, 0x949294 }, },
        { { 568, 328, 0x000000 }, false, false, false, false, false, { 1668, 328, 0x217594 }, },
        { { 551, 454, 0x000000 }, false, false, false, false, false, { 1699, 454, 0x215d84 }, },
        { { 532, 591, 0x000000 }, false, false, false, false, false, { 1733, 591, 0x294d7b }, },
        { { 512, 742, 0x000000 }, false, false, false, false, false, { 1771, 742, 0x104573 }, },
        { { 489, 911, 0x000000 }, false, false, false, false, false, { 1813, 911, 0x000000 }, },
      },
      pointMap = {},
    },
    {
      leftTop = nil,
      rightTop = nil,
      leftBottom = nil,
      rightBottom = { 1658, 915 },
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的
      positionMap = {
        false, false,
        { false, false, { 457, 215, 0xce8a73 }, false, false, false, false, false, { 1516, 215, 0x000000 }, },
        { false, false, { 437, 331, 0x197d8c }, false, false, false, false, false, { 1540, 331, 0x000000 }, },
        { false, false, { 414, 457, 0x217184 }, false, false, false, false, false, { 1565, 457, 0x739eb5 }, },
        { false, false, { 388, 595, 0x216184 }, false, false, false, false, false, { 1593, 595, 0x000000 }, },
        { false, false, { 360, 746, 0x215584 }, false, false, false, false, false, { 1624, 746, 0x000000 }, },
        { false, false, { 330, 915, 0x000000 }, false, false, false, false, false, { 1658, 915, 0x080c08 }, },
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

return mapEvent