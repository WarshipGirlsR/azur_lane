local mapBase = require './map'
local imgEvent = require './img10-sos'
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
      leftTop = { 573, 515 },
      rightTop = nil,
      leftBottom = nil,
      rightBottom = nil,
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的
      positionMap = {
        { { 573, 515, 0x192431 }, false, false, false, false, false, false, { 1757, 515, 0x101821 }, },
        { { 558, 638, 0x000000 }, false, false, false, false, false, false, { 1789, 638, 0x21284a }, },
        { { 541, 772, 0x000000 }, false, false, false, false, false, false, { 1824, 772, 0x292042 }, },
        { { 522, 917, 0x000000 }, false, false, false, false, false, false, { 1861, 917, 0x211c21 }, },
      },
      pointMap = {},
    },
    {
      leftTop = nil,
      rightTop = { 1554, 505 },
      leftBottom = nil,
      rightBottom = nil,
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的
      positionMap = {
        { false, false, { 367, 505, 0x192d31 }, false, false, false, false, false, false, { 1554, 505, 0x081419 }, },
        { false, false, { 343, 628, 0x21183a }, false, false, false, false, false, false, { 1578, 628, 0x000000 }, },
        { false, false, { 317, 761, 0x21203a }, false, false, false, false, false, false, { 1604, 761, 0x000000 }, },
        { false, false, { 289, 906, 0x191c31 }, false, false, false, false, false, false, { 1632, 906, 0x000000 }, },
      },
      pointMap = {},
    },
    {
      leftTop = nil,
      rightTop = { 1710, 242 },
      leftBottom = nil,
      rightBottom = nil,
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的
      positionMap = {
        { false, { 353, 242, 0xbdae84 }, false, false, false, false, false, false, false, { 1710, 242, 0x212442 }, },
        { false, { 329, 354, 0x191831 }, false, false, false, false, false, false, false, { 1740, 354, 0x000000 }, },
        { false, { 303, 475, 0x211c3a }, false, false, false, false, false, false, false, { 1773, 475, 0x000000 }, },
        { false, { 274, 608, 0x211c42 }, false, false, false, false, false, false, false, { 1809, 608, 0x000000 }, },
        { false, { 242, 753, 0x191429 }, false, false, false, false, false, false, false, { 1849, 753, 0x000000 }, },
        { false, { 208, 912, 0x42417b }, false, false, false, false, false, false, false, { 1892, 912, 0x000000 }, },
      },
      pointMap = {},
    },
    {
      leftTop = nil,
      rightTop = nil,
      leftBottom = { 467, 913 },
      rightBottom = nil,
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的
      positionMap = {
        false,
        { { 567, 214, 0x000000 }, false, false, false, false, false, { 1622, 214, 0x29284a }, },
        { { 550, 330, 0x000000 }, false, false, false, false, false, { 1650, 330, 0x292042 }, },
        { { 532, 456, 0x000000 }, false, false, false, false, false, { 1681, 456, 0x635d73 }, },
        { { 513, 593, 0x000000 }, false, false, false, false, false, { 1715, 593, 0xffffd6 }, },
        { { 491, 745, 0x000000 }, false, false, false, false, false, { 1750, 745, 0x191429 }, },
        { { 467, 913, 0x000000 }, false, false, false, false, false, { 1791, 913, 0x000000 }, },
      },
      pointMap = {},
    },
    {
      leftTop = nil,
      rightTop = nil,
      leftBottom = nil,
      rightBottom = { 1699, 912 },
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的
      positionMap = {
        false,
        { false, false, false, { 489, 213, 0x8c8e9c }, false, false, false, false, false, { 1549, 213, 0x000000 }, },
        { false, false, false, { 471, 328, 0xdeaa00 }, false, false, false, false, false, { 1574, 328, 0x000000 }, },
        { false, false, false, { 449, 455, 0x211c3a }, false, false, false, false, false, { 1601, 455, 0x000000 }, },
        { false, false, false, { 424, 592, 0xbd4108 }, false, false, false, false, false, { 1630, 592, 0x000000 }, },
        { false, false, false, { 399, 743, 0x21183a }, false, false, false, false, false, { 1663, 743, 0x000000 }, },
        { false, false, false, { 370, 912, 0x000000 }, false, false, false, false, false, { 1699, 912, 0x000000 }, },
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
    height = 6,
    obstacle = {
      { 1, 8 },
      { 2, 2 }, { 2, 3 },
      { 4, 4 }, { 4, 8 },
      { 5, 1 }, { 5, 7 }, { 5, 8 },
      { 6, 1 }, { 6, 2 }, { 6, 3 },
    },
    waitForBossPosition = { { 1, 6 }, { 2, 4 }, { 3, 1 } },
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