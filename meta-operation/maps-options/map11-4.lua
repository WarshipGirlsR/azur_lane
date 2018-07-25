local mapBase = require './map'
local imgEvent = require './img11-4'
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
      leftTop = { 368, 518 },
      rightTop = nil,
      leftBottom = nil,
      rightBottom = nil,
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的
      positionMap = {
        { { 368, 518, 0x100c19 }, false, false, false, false, false, false, false, { 1670, 518, 0x211429 }, },
        { { 345, 637, 0x000000 }, false, false, false, false, false, false, false, { 1697, 637, 0x312d4a }, },
        { { 320, 765, 0x000000 }, false, false, false, false, false, false, false, { 1727, 765, 0x29244a }, },
        { { 293, 904, 0x000000 }, false, false, false, false, false, false, false, { 1760, 904, 0x292042 }, },
      },
      pointMap = {},
    },
    {
      leftTop = nil,
      rightTop = { 1628, 517 },
      leftBottom = nil,
      rightBottom = nil,
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的
      positionMap = {
        { false, false, false, { 486, 517, 0x101821 }, false, false, false, false, false, false, { 1628, 517, 0x101021 }, },
        { false, false, false, { 467, 635, 0x211c3a }, false, false, false, false, false, false, { 1654, 635, 0x000000 }, },
        { false, false, false, { 448, 764, 0x212042 }, false, false, false, false, false, false, { 1682, 764, 0x000000 }, },
        { false, false, false, { 426, 903, 0x191831 }, false, false, false, false, false, false, { 1712, 903, 0x000000 }, },
      },
      pointMap = {},
    },
    {
      leftTop = nil,
      rightTop = { 1566, 269 },
      leftBottom = nil,
      rightBottom = nil,
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的
      positionMap = {
        { false, false, false, { 424, 269, 0x101421 }, false, false, false, false, false, false, { 1566, 269, 0x101c31 }, },
        { false, false, false, { 403, 378, 0x211c3a }, false, false, false, false, false, false, { 1590, 378, 0x000000 }, },
        { false, false, false, { 381, 496, 0x21203a }, false, false, false, false, false, false, { 1615, 496, 0x000000 }, },
        { false, false, false, { 356, 623, 0x191831 }, false, false, false, false, false, false, { 1643, 623, 0x000000 }, },
        { false, false, false, { 329, 762, 0x211831 }, false, false, false, false, false, false, { 1673, 762, 0x000000 }, },
        { false, false, false, { 300, 914, 0x211c42 }, false, false, false, false, false, false, { 1706, 914, 0x100c10 } },
      },
      pointMap = {},
    },
    {
      leftTop = { 468, 256 },
      rightTop = nil,
      leftBottom = nil,
      rightBottom = nil,
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的
      positionMap = {
        { { 468, 256, 0x211c31 }, false, false, false, false, false, false, { 1607, 256, 0x313963 }, },
        { { 449, 365, 0x000000 }, false, false, false, false, false, false, { 1632, 365, 0x212442 }, },
        { { 428, 482, 0x000000 }, false, false, false, false, false, false, { 1659, 482, 0x292042 }, },
        { { 406, 609, 0x000000 }, false, false, false, false, false, false, { 1689, 609, 0x292042 }, },
        { { 381, 747, 0x000000 }, false, false, false, false, false, false, { 1721, 747, 0x211c3a }, },
        { { 354, 899, 0x000000 }, false, false, false, false, false, false, { 1757, 899, 0x211c3a }, },
      },
      pointMap = {},
    },
    {
      leftTop = nil,
      rightTop = nil,
      leftBottom = { 278, 924 },
      rightBottom = nil,
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的
      positionMap = {
        false, false, false, false, false,
        { { 372, 443, 0x000000 }, false, false, false, false, false, { 1574, 443, 0x191829 }, },
        { { 344, 587, 0x000000 }, false, false, false, false, false, { 1604, 587, 0x101421 }, },
        { { 313, 745, 0x000000 }, false, false, false, false, false, { 1637, 745, 0x211831 }, },
        { { 277, 924, 0x000000 }, false, false, false, false, false, { 1671, 914, 0x191821 }, },
      },
      pointMap = {},
    },
    {
      leftTop = nil,
      rightTop = nil,
      leftBottom = nil,
      rightBottom = { 1657, 932 },
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的
      positionMap = {
        false, false, false, false, false,
        { false, false, false, false, { 354, 451, 0x5a4508 }, false, false, false, false, false, { 1560, 451, 0x000000 }, },
        { false, false, false, false, { 325, 595, 0x191831 }, false, false, false, false, false, { 1589, 595, 0x000000 }, },
        { false, false, false, false, { 293, 754, 0x191829 }, false, false, false, false, false, { 1621, 754, 0x000000 }, },
        { false, false, false, false, { 257, 932, 0x000000 }, false, false, false, false, false, { 1657, 932, 0x100c10 }, },
      },
      pointMap = {},
    },
  })
  return list
end

-- 获取地图棋盘和相关数据
mapEvent.getMapChessboard = function()
  return {
    width = 10,
    height = 8,
    obstacle = {
      { 1, 3 }, { 1, 7 },
      { 2, 3 }, { 2, 7 },
      { 3, 5 },
      { 4, 2 },
      { 5, 8 }, { 5, 9 }, { 5, 10 },
      { 6, 1 }, { 6, 2 }, { 6, 3 },
      { 7, 6 }, { 7, 8 },
      { 8, 6 },
    },
    waitForBossPosition = { { 1, 1 }, { 1, 2 }, { 1, 8 }, { 5, 1 }, { 8, 1 }, { 8, 10 } },
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