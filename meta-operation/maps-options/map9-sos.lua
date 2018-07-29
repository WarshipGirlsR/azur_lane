local mapBase = require './map'
local imgEvent = require './img9-sos'
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
      leftTop = { 526, 513 },
      rightTop = nil,
      leftBottom = nil,
      rightBottom = nil,
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的
      positionMap = {
        { { 526, 513, 0x000c10 }, false, false, false, false, false, false, { 1710, 513, 0x081821 }, },
        { { 509, 636, 0x000000 }, false, false, false, false, false, false, { 1740, 636, 0x313552 }, },
        { { 490, 770, 0xad3908 }, false, false, false, false, false, false, { 1773, 770, 0x211c3a }, },
        { { 469, 915, 0x000000 }, false, false, false, false, false, false, { 1809, 915, 0x191821 }, },
      },
      pointMap = {},
    },
    {
      leftTop = nil,
      rightTop = { 1570, 507 },
      leftBottom = nil,
      rightBottom = nil,
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的
      positionMap = {
        { false, false, { 383, 507, 0x100c19 }, false, false, false, false, false, false, { 1570, 507, 0x081829 }, },
        { false, false, { 359, 629, 0x524d84 }, false, false, false, false, false, false, { 1594, 629, 0x000000 }, },
        { false, false, { 334, 763, 0x191831 }, false, false, false, false, false, false, { 1621, 763, 0x000000 }, },
        { false, false, { 307, 908, 0x191c31 }, false, false, false, false, false, false, { 1650, 908, 0x000000 }, },
      },
      pointMap = {},
    },
    {
      leftTop = nil,
      rightTop = { 1707, 259 },
      leftBottom = nil,
      rightBottom = nil,
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的
      positionMap = {
        { false, { 351, 259, 0x101421 }, false, false, false, false, false, false, false, { 1707, 259, 0x192842 }, },
        { false, { 325, 372, 0x632008 }, false, false, false, false, false, false, false, { 1737, 372, 0x000000 }, },
        { false, { 299, 495, 0x211c3a }, false, false, false, false, false, false, false, { 1770, 495, 0x000000 }, },
        { false, { 270, 628, 0x211c42 }, false, false, false, false, false, false, false, { 1805, 628, 0x000000 }, },
        { false, { 238, 774, 0x211c42 }, false, false, false, false, false, false, false, { 1845, 774, 0x000000 }, },
        { false, { 203, 934, 0x191831 }, false, false, false, false, false, false, false, { 1888, 934, 0x313531 }, },
      },
      pointMap = {},
    },
    {
      leftTop = nil,
      rightTop = nil,
      leftBottom = { 364, 920 },
      rightBottom = nil,
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的
      positionMap = {
        false,
        { { 485, 219, 0x737173 }, false, false, false, false, false, false, { 1716, 219, 0x212442 }, },
        { { 464, 335, 0xbd3500 }, false, false, false, false, false, false, { 1748, 335, 0x191831 }, },
        { { 443, 462, 0x000000 }, false, false, false, false, false, false, { 1783, 462, 0x211c3a }, },
        { { 419, 600, 0x000000 }, false, false, false, false, false, false, { 1821, 600, 0x211831 }, },
        { { 393, 751, 0x000000 }, false, false, false, false, false, false, { 1863, 751, 0x211c3a }, },
        { { 364, 920, 0x000000 }, false, false, false, false, false, false, { 1907, 920, 0x313131 }, },
      },
      pointMap = {},
    },
    {
      leftTop = nil,
      rightTop = nil,
      leftBottom = nil,
      rightBottom = { 1731, 931 },
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的
      positionMap = {
        false,
        { false, false, { 336, 228, 0x9c8a4a }, false, false, false, false, false, { 1574, 228, 0x000000 }, },
        { false, false, { 313, 345, 0xe6d742 }, false, false, false, false, false, { 1600, 345, 0x000000 }, },
        { false, false, { 285, 471, 0x191c3a }, false, false, false, false, false, { 1628, 471, 0x000000 }, },
        { false, false, { 254, 610, 0x211c42 }, false, false, false, false, false, { 1659, 610, 0x000000 }, },
        { false, false, { 219, 762, 0x211831 }, false, false, false, false, false, { 1693, 762, 0x000000 }, },
        { false, false, { 182, 931, 0x000000 }, false, false, false, false, false, { 1731, 931, 0x313131 }, },
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
      { 1, 2 }, { 1, 3 }, { 1, 4 }, { 1, 9 },
      { 2, 3 }, { 2, 9 },
      { 5, 4 },
      { 6, 2 }, { 6, 7 }, { 6, 8 }, { 6, 9 },
    },
    waitForBossPosition = { { 1, 6 }, { 6, 4 } },
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