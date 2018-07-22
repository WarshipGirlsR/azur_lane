local mapBase = require './map'
local imgEvent = require './img3-sos'
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
      leftTop = { 541, 507 },
      rightTop = nil,
      leftBotton = nil,
      rightBotton = nil,
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的
      positionMap = {
        { { 541, 507, 0x213942 }, false, false, false, false, false, false, { 1773, 507, 0x19203a }, },
        { { 524, 635, 0x000000 }, false, false, false, false, false, false, { 1807, 635, 0x298194 }, },
        { { 504, 775, 0x000000 }, false, false, false, false, false, false, { 1844, 775, 0x196d84 }, },
        { { 483, 927, 0x000000 }, false, false, false, false, false, false, { 1885, 927, 0xd6dbde }, },
      },
      pointMap = {},
    },
    {
      leftTop = nil,
      rightTop = { 1558, 510 },
      leftBotton = nil,
      rightBotton = nil,
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的
      positionMap = {
        { false, { 322, 510, 0x21394a }, false, false, false, false, false, false, { 1558, 510, 0x294152 }, },
        { false, { 296, 637, 0x106d8c }, false, false, false, false, false, false, { 1582, 637, 0x000000 }, },
        { false, { 267, 777, 0x218184 }, false, false, false, false, false, false, { 1610, 777, 0x000000 }, },
        { false, { 234, 930, 0x31759c }, false, false, false, false, false, false, { 1640, 930, 0x191419 }, },
      },
      pointMap = {},
    },
    {
      leftTop = nil,
      rightTop = nil,
      leftBotton = { 436, 910 },
      rightBotton = nil,
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的
      positionMap = {
        false,
        { { 525, 327, 0x000000 }, false, false, false, false, false, { 1625, 327, 0x298194 }, },
        { { 506, 453, 0x000000 }, false, false, false, false, false, { 1654, 453, 0x196184 }, },
        { { 485, 591, 0x000000 }, false, false, false, false, false, { 1686, 591, 0x194d73 }, },
        { { 462, 742, 0x000000 }, false, false, false, false, false, { 1721, 742, 0x214d7b }, },
        { { 436, 910, 0x000000 }, false, false, false, false, false, { 1761, 910, 0x000000 }, },
      },
      pointMap = {},
    },
    {
      leftTop = nil,
      rightTop = nil,
      leftBotton = nil,
      rightBotton = { 1728, 923 },
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的
      positionMap = {
        false,
        { false, { 311, 338, 0x196d94 }, false, false, false, false, false, false, { 1598, 338, 0x000000 }, },
        { false, { 282, 464, 0x52816b }, false, false, false, false, false, false, { 1626, 464, 0x000000 }, },
        { false, { 251, 602, 0x297594 }, false, false, false, false, false, false, { 1656, 602, 0x000000 }, },
        { false, { 217, 754, 0x10658c }, false, false, false, false, false, false, { 1690, 754, 0x000000 }, },
        { false, { 179, 923, 0x000000 }, false, false, false, false, false, false, { 1728, 923, 0x292d29 }, },
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
    height = 5,
    obstacle = {
      { 1, 3 }, { 1, 4 },
      { 2, 1 }, { 2, 7 },
      { 3, 7 },
      { 4, 2 },
      { 5, 5 }, { 5, 8 },
    },
    waitForBossPosition = { { 2, 6 } },
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
