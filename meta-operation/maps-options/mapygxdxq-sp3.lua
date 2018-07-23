local mapBase = require './map'
local imgEvent = require './imgygxdxq-sp3'
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
      leftTop = { 554, 561 },
      rightTop = nil,
      leftBottom = nil,
      rightBottom = nil,
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的
      positionMap = {
        { { 554, 561, 0x101821 }, false, false, false, false, false, false, { 1652, 561, 0x191829 }, },
        { { 539, 677, 0x000000 }, false, false, false, false, false, false, { 1678, 677, 0x846d9c }, },
        { { 523, 801, 0x000000 }, false, false, false, false, false, false, { 1706, 801, 0x000000 }, },
        { { 505, 936, 0x000000 }, false, false, false, false, false, false, { 1737, 936, 0xbd815a }, },
      },
      pointMap = {},
    },
    {
      leftTop = { 304, 540 },
      rightTop = nil,
      leftBottom = nil,
      rightBottom = nil,
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的
      positionMap = {
        { { 304, 540, 0x101821 }, false, false, false, false, false, false, false, false, { 1718, 540, 0x191829 }, },
        { { 280, 655, 0x000000 }, false, false, false, false, false, false, false, false, { 1747, 655, 0x846d9c }, },
        { { 253, 779, 0x000000 }, false, false, false, false, false, false, false, false, { 1777, 779, 0x000000 }, },
        { { 224, 913, 0x000000 }, false, false, false, false, false, false, false, false, { 1811, 913, 0xbd815a }, },
      },
      pointMap = {},
    },
    {
      leftTop = nil,
      rightTop = nil,
      leftBottom = { 462, 936 },
      rightBottom = nil,
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的
      positionMap = {
        false, false, false,
        { { 522, 513, 0x000000 }, false, false, false, false, { 1401, 513, 0x211c3a }, },
        { { 504, 641, 0x000000 }, false, false, false, false, { 1420, 641, 0x191429 }, },
        { { 484, 781, 0x000000 }, false, false, false, false, { 1440, 781, 0x191421 }, },
        { { 462, 936, 0x000000 }, false, false, false, false, { 1463, 934, 0x292429 }, },
      },
      pointMap = {},
    },
    {
      leftTop = nil,
      rightTop = nil,
      leftBottom = nil,
      rightBottom = { 1630, 943 },
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的
      positionMap = {
        false, false, false,
        { false, false, false, false, { 666, 519, 0x101021 }, false, false, false, false, { 1548, 519, 0x000000 }, },
        { false, false, false, false, { 653, 648, 0x191831 }, false, false, false, false, { 1573, 648, 0x000000 }, },
        { false, false, false, false, { 640, 788, 0x211c42 }, false, false, false, false, { 1600, 788, 0x000000 }, },
        { false, false, false, false, { 624, 943, 0x000000 }, false, false, false, false, { 1630, 943, 0x080c08 }, },
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
      { 1, 1 }, { 1, 8 }, { 1, 9 },
      { 2, 5 }, { 2, 8 }, { 2, 9 },
      { 4, 1 }, { 4, 2 }, { 4, 3 }, { 4, 8 },
      { 5, 6 },
      { 6, 6 },
    },
    waitForBossPosition = { { 1, 2 }, { 2, 1 }, { 3, 1 }, { 5, 1 } },
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