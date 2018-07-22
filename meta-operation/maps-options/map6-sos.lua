local mapBase = require './map'
local imgEvent = require './img6-sos'
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
      leftTop = { 643, 530 },
      rightTop = nil,
      leftBotton = nil,
      rightBotton = nil,
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的
      positionMap = {
        { { 643, 530, 0x101421 }, false, false, false, false, false, false, { 1782, 530, 0x211c31 }, },
        { { 630, 649, 0x000000 }, false, false, false, false, false, false, { 1814, 649, 0x292d4a }, },
        { { 617, 777, 0x000000 }, false, false, false, false, false, false, { 1848, 777, 0x21203a }, },
        { { 603, 917, 0xb58a10 }, false, false, false, false, false, false, { 1886, 917, 0x101419 }, }
      },
      pointMap = {},
    },
    {
      leftTop = nil,
      rightTop = { 1623, 522 },
      leftBotton = nil,
      rightBotton = nil,
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的
      positionMap = {
        { { 319, 522, 0x192431 }, false, false, false, false, false, false, false, { 1623, 522, 0x191829 }, },
        { { 294, 641, 0x000000 }, false, false, false, false, false, false, false, { 1649, 641, 0x000000 }, },
        { { 267, 770, 0x000000 }, false, false, false, false, false, false, false, { 1677, 770, 0x000000 }, },
        { { 238, 909, 0x080800 }, false, false, false, false, false, false, false, { 1707, 909, 0x000000 }, }
      },
      pointMap = {},
    },
    {
      leftTop = nil,
      rightTop = nil,
      leftBotton = { 573, 918 },
      rightBotton = nil,
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的
      positionMap = {
        false,
        { { 649, 245, 0x000000 }, false, false, false, false, false, { 1663, 245, 0x29244a }, },
        { { 636, 357, 0x000000 }, false, false, false, false, false, { 1692, 357, 0x191831 }, },
        { { 622, 479, 0x191810 }, false, false, false, false, false, { 1723, 479, 0x29203a }, },
        { { 608, 611, 0x000000 }, false, false, false, false, false, { 1756, 611, 0x191829 }, },
        { { 592, 756, 0x000000 }, false, false, false, false, false, { 1793, 756, 0x191831 }, },
        { { 573, 918, 0x000000 }, false, false, false, false, false, { 1834, 918, 0x211821 }, },
      },
      pointMap = {},
    },
    {
      leftTop = nil,
      rightTop = nil,
      leftBotton = nil,
      rightBotton = { 1728, 908 },
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的
      positionMap = {
        false,
        { false, { 392, 237, 0x191831 }, false, false, false, false, false, false, { 1578, 237, 0x000000 }, },
        { false, { 369, 349, 0x211c3a }, false, false, false, false, false, false, { 1603, 349, 0x000000 }, },
        { false, { 344, 471, 0x191431 }, false, false, false, false, false, false, { 1631, 471, 0x000000 }, },
        { false, { 316, 603, 0x101021 }, false, false, false, false, false, false, { 1660, 603, 0x000000 }, },
        { false, { 287, 747, 0x21183a }, false, false, false, false, false, false, { 1692, 747, 0x000000 }, },
        { false, { 254, 908, 0x000000 }, false, false, false, false, false, false, { 1728, 908, 0x000000 }, },
      },
      pointMap = {},
    },
  })
  console.log(list)
  return list
end

-- 获取地图棋盘和相关数据
mapEvent.getMapChessboard = function()
  return {
    width = 8,
    height = 6,
    obstacle = {
      { 1, 1 }, { 1, 7 }, { 1, 8 },
      { 5, 7 },
      { 6, 2 }, { 6, 7 },
    },
    waitForBossPosition = { { 2, 4 }, { 2, 5 }, { 5, 4 } },
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