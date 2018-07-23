local mapBase = require './map'
local imgEvent = require './img7-sos'
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
      leftTop = { 656, 513 },
      rightTop = nil,
      leftBottom = nil,
      rightBottom = nil,
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的
      positionMap = {
        { { 656, 513, 0x191c29 }, false, false, false, false, false, { 1671, 513, 0x101821 }, },
        { { 644, 636, 0x000000 }, false, false, false, false, false, { 1700, 636, 0x00c64a }, },
        { { 631, 770, 0x000000 }, false, false, false, false, false, { 1729, 770, 0xd6923a }, },
        { { 616, 915, 0x000000 }, false, false, false, false, false, { 1765, 915, 0x191821 }, },
      },
      pointMap = {},
    },
    {
      leftTop = nil,
      rightTop = { 1608, 511 },
      leftBottom = nil,
      rightBottom = nil,
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的
      positionMap = {
        { { 253, 511, 0x081419 }, false, false, false, false, false, false, false, { 1608, 511, 0x101c21 }, },
        { { 224, 634, 0x000000 }, false, false, false, false, false, false, false, { 1634, 634, 0x000000 }, },
        { { 193, 767, 0x000000 }, false, false, false, false, false, false, false, { 1662, 767, 0x000000 }, },
        { { 159, 913, 0x000000 }, false, false, false, false, false, false, false, { 1693, 913, 0x000000 }, }
      },
      pointMap = {},
    },
    {
      leftTop = nil,
      rightTop = nil,
      leftBottom = { 558, 910 },
      rightBottom = nil,
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的
      positionMap = {
        false,
        { { 640, 211, 0x000000 }, false, false, false, false, false, { 1695, 211, 0x005121 }, },
        { { 626, 327, 0x000000 }, false, false, false, false, false, { 1726, 327, 0x523129 }, },
        { { 611, 453, 0x000000 }, false, false, false, false, false, { 1760, 453, 0x191831 }, },
        { { 595, 591, 0x000000 }, false, false, false, false, false, { 1797, 591, 0x211c3a }, },
        { { 578, 742, 0x000000 }, false, false, false, false, false, { 1837, 742, 0x191829 }, },
        { { 558, 910, 0x000000 }, false, false, false, false, false, { 1883, 910, 0x000000 }, },
      },
      pointMap = {},
    },
    {
      leftTop = nil,
      rightTop = nil,
      leftBottom = nil,
      rightBottom = { 1636, 912 },
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的
      positionMap = {
        false, false,
        { false, false, { 414, 328, 0x9c7d42 }, false, false, false, false, false, { 1521, 328, 0x080808 }, },
        { false, false, { 393, 454, 0xffffff }, false, false, false, false, false, { 1546, 454, 0x000000 }, },
        { false, false, { 367, 592, 0x947508 }, false, false, false, false, false, { 1573, 592, 0x000000 }, },
        { false, false, { 339, 743, 0x292019 }, false, false, false, false, false, { 1602, 743, 0x29244a }, },
        { false, false, { 307, 912, 0x000000 }, false, false, false, false, false, { 1636, 912, 0x000000 }, },
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
      { 3, 5 },
      { 4, 2 },
      { 5, 7 },
      { 6, 1 },
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