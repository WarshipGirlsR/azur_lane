-- 光与影的鸢尾之华
local mapBase = require './map'
local imgEvent = require './imggyydywzh-a3'
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
      leftTop = { 431, 521 },
      rightTop = nil,
      leftBottom = nil,
      rightBottom = nil,
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的
      positionMap = {
        { { 431, 521, 0x213942 }, false, false, false, false, false, false, false, { 1730, 521, 0x19353a }, },
        { { 416, 645, 0x000000 }, false, false, false, false, false, false, false, { 1752, 645, 0x295d6b }, },
        { { 399, 776, 0x000000 }, false, false, false, false, false, false, false, { 1776, 776, 0x426173 }, },
        { { 382, 915, 0x000000 }, false, false, false, false, false, false, false, { 1801, 915, 0x213131 }, }
      },
      pointMap = {},
    },
    {
      leftTop = nil,
      rightTop = { 1621, 520 },
      leftBottom = nil,
      rightBottom = nil,
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的
      positionMap = {
        { false, false, false, { 319, 520, 0x293131 }, false, false, false, false, false, false, false, { 1621, 520, 0x193142 }, },
        { false, false, false, { 300, 643, 0x216163 }, false, false, false, false, false, false, false, { 1640, 643, 0x000000 }, },
        { false, false, false, { 281, 774, 0x3a6973 }, false, false, false, false, false, false, false, { 1660, 774, 0x000000 }, },
        { false, false, false, { 260, 913, 0x316973 }, false, false, false, false, false, false, false, { 1682, 913, 0x000000 }, }
      },
      pointMap = {},
    },
    {
      leftTop = nil,
      rightTop = { 1589, 259 },
      leftBottom = nil,
      rightBottom = nil,
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的
      positionMap = {
        false,
        { false, false, false, { 268, 375, 0x216163 }, false, false, false, false, false, false, false, { 1607, 375, 0x000000 }, },
        { false, false, false, { 247, 498, 0x3a6973 }, false, false, false, false, false, false, false, { 1626, 498, 0x000000 }, },
        { false, false, false, { 225, 629, 0x42697b }, false, false, false, false, false, false, false, { 1647, 629, 0x000000 }, },
        { false, false, false, { 202, 768, 0x527984 }, false, false, false, false, false, false, false, { 1669, 768, 0x000000 }, },
        { false, false, false, { 177, 916, 0x42616b }, false, false, false, false, false, false, false, { 1692, 916, 0x101010 }, },
      },
      pointMap = {},
    },
    {
      leftTop = { 515, 258 },
      rightTop = nil,
      leftBottom = nil,
      rightBottom = nil,
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的
      positionMap = {
        false,
        { { 502, 374, 0x000000 }, false, false, false, false, false, false, false, { 1671, 374, 0x315d6b }, },
        { { 488, 497, 0x000000 }, false, false, false, false, false, false, false, { 1692, 497, 0x31616b }, },
        { { 474, 627, 0x000000 }, false, false, false, false, false, false, false, { 1715, 627, 0x3a697b }, },
        { { 459, 766, 0x000000 }, false, false, false, false, false, false, false, { 1739, 766, 0x426d73 }, },
        { { 442, 914, 0x000000 }, false, false, false, false, false, false, false, { 1764, 914, 0x293d42 }, },
      },
      pointMap = {},
    },
    {
      leftTop = nil,
      rightTop = nil,
      leftBottom = { 550, 912 },
      rightBottom = nil,
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的
      positionMap = {
        false, false, false,
        { { 601, 337, 0x000000 }, false, false, false, false, false, { 1664, 337, 0x3a6973 }, },
        { { 589, 467, 0x000000 }, false, false, false, false, false, { 1687, 467, 0x3a5d7b }, },
        { { 577, 605, 0x000000 }, false, false, false, false, false, { 1711, 605, 0x3a5d7b }, },
        { { 564, 752, 0x000000 }, false, false, false, false, false, { 1736, 752, 0x425173 }, },
        { { 550, 912, 0x000000 }, false, false, false, false, false, { 1763, 912, 0x000000 }, },
      },
      pointMap = {},
    },
    {
      leftTop = nil,
      rightTop = nil,
      leftBottom = nil,
      rightBottom = { 1737, 910 },
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的
      positionMap = {
        false, false, false,
        { false, false, false, false, { 396, 335, 0xf7f79c }, false, false, false, false, false, false, { 1641, 335, 0x000000 }, },
        { false, false, false, false, { 379, 464, 0x426973 }, false, false, false, false, false, false, { 1663, 464, 0x000000 }, },
        { false, false, false, false, { 359, 602, 0x426973 }, false, false, false, false, false, false, { 1686, 602, 0x000000 }, },
        { false, false, false, false, { 339, 750, 0x426173 }, false, false, false, false, false, false, { 1711, 750, 0x000000 }, },
        { false, false, false, false, { 317, 910, 0x000000 }, false, false, false, false, false, false, { 1737, 910, 0x000000 }, }
      },
      pointMap = {},
    },
  })
  return list
end

-- 获取地图棋盘和相关数据
mapEvent.getMapChessboard = function()
  return {
    width = 11,
    height = 7,
    obstacle = {
      { 1, 2 }, { 1, 3 }, { 1, 4 },
      { 2, 8 },
      { 3, 3 }, { 3, 9 }, { 3, 10 },
      { 4, 6 }, { 4, 10 },
      { 6, 3 }, { 6, 4 }, { 6, 9 }, { 6, 10 }, { 6, 11 },
      { 7, 3 }, { 7, 4 },
    },
    waitForBossPosition = { { 4, 9 }, },
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