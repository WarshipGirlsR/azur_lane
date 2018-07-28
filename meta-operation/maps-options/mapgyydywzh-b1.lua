-- 光与影的鸢尾之华
local mapBase = require './map'
local imgEvent = require './imggyydywzh-b1'
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
      leftTop = { 363, 526 },
      rightTop = nil,
      leftBottom = nil,
      rightBottom = nil,
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的
      positionMap = {
        { { 363, 526, 0x21283a }, false, false, false, false, false, false, false, { 1673, 526, 0x4a494a }, },
        { { 338, 646, 0x000000 }, false, false, false, false, false, false, false, { 1704, 646, 0x000000 }, },
        { { 310, 777, 0x000000 }, false, false, false, false, false, false, false, { 1738, 777, 0x000000 }, },
        { { 279, 920, 0x841419 }, false, false, false, false, false, false, false, { 1775, 920, 0x313531 }, },
      },
      pointMap = {},
    },
    {
      leftTop = nil,
      rightTop = nil,
      leftBottom = { 629, 907 },
      rightBottom = nil,
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的
      positionMap = {
        false,
        { { 701, 223, 0x000000 }, false, false, false, false, { 1553, 223, 0x29415a }, },
        { { 690, 335, 0x4a4910 }, false, false, false, false, { 1580, 335, 0x314152 }, },
        { { 676, 457, 0x941c21 }, false, false, false, false, { 1611, 457, 0x191819 }, },
        { { 662, 591, 0x000000 }, false, false, false, false, { 1642, 591, 0x213152 }, },
        { { 646, 740, 0xe6ba7b }, false, false, false, false, { 1678, 740, 0x293963 }, },
        { { 629, 907, 0x000000 }, false, false, false, false, { 1717, 907, 0x000000 }, },
      },
      pointMap = {},
    },
    {
      leftTop = nil,
      rightTop = nil,
      leftBottom = nil,
      rightBottom = { 1709, 906 },
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的
      positionMap = {
        false,
        { false, false, { 520, 222, 0x424d63 }, false, false, false, false, false, { 1546, 222, 0x000000 }, },
        { false, false, { 501, 333, 0x42495a }, false, false, false, false, false, { 1573, 333, 0x000000 }, },
        { false, false, { 479, 456, 0x5a5963 }, false, false, false, false, false, { 1602, 456, 0x000000 }, },
        { false, false, { 455, 590, 0x42455a }, false, false, false, false, false, { 1634, 590, 0x000000 }, },
        { false, false, { 428, 739, 0x31415a }, false, false, false, false, false, { 1670, 739, 0x000000 }, },
        { false, false, { 399, 906, 0x000000 }, false, false, false, false, false, { 1709, 906, 0x000000 }, },
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
      { 1, 1 }, { 1, 2 }, { 1, 3 },
      { 2, 8 },
      { 3, 4 }, { 3, 5 },
      { 4, 4 }, { 4, 5 },
    },
    waitForBossPosition = { { 1, 8 }, { 6, 8 } },
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