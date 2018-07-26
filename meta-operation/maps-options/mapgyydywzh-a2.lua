-- 光与影的鸢尾之华
local mapBase = require './map'
local imgEvent = require './imggyydywzh-a2'
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
      leftTop = { 541, 498 },
      rightTop = nil,
      leftBottom = nil,
      rightBottom = nil,
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的
      positionMap = {
        { { 541, 498, 0x730808 }, false, false, false, false, false, false, { 1737, 498, 0x214152 }, },
        { { 524, 622, 0x000000 }, false, false, false, false, false, false, { 1772, 622, 0x425d5a }, },
        { { 504, 757, 0x000000 }, false, false, false, false, false, false, { 1810, 757, 0x316163 }, },
        { { 481, 907, 0x000000 }, false, false, false, false, false, false, { 1852, 907, 0x3a6d73 }, },
      },
      pointMap = {},
    },
    {
      leftTop = nil,
      rightTop = { 1573, 497 },
      leftBottom = nil,
      rightBottom = nil,
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的
      positionMap = {
        { false, false, false, { 375, 497, 0x292d3a }, false, false, false, false, false, false, { 1573, 497, 0x192d42 }, },
        { false, false, false, { 349, 620, 0x427973 }, false, false, false, false, false, false, { 1600, 620, 0x000000 }, },
        { false, false, false, { 320, 756, 0x42697b }, false, false, false, false, false, false, { 1630, 756, 0x000000 }, },
        { false, false, false, { 288, 906, 0x426d84 }, false, false, false, false, false, false, { 1664, 906, 0x000000 }, }
      },
      pointMap = {},
    },
    {
      leftTop = nil,
      rightTop = nil,
      leftBottom = { 389, 910 },
      rightBottom = nil,
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的
      positionMap = {
        false, false,
        { { 497, 310, 0x000000 }, false, false, false, false, false, { 1617, 310, 0x528694 }, },
        { { 474, 437, 0x000000 }, false, false, false, false, false, { 1650, 437, 0x31616b }, },
        { { 449, 577, 0x000000 }, false, false, false, false, false, { 1686, 577, 0x315163 }, },
        { { 421, 733, 0x000000 }, false, false, false, false, false, { 1727, 733, 0x3a556b }, },
        { { 389, 910, 0x000000 }, false, false, false, false, false, { 1772, 910, 0x000000 }, }
      },
      pointMap = {},
    },
    {
      leftTop = nil,
      rightTop = nil,
      leftBottom = nil,
      rightBottom = { 1665, 910 },
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的
      positionMap = {
        false, false,
        { false, false, false, false, { 405, 310, 0x847dad }, false, false, false, false, false, { 1531, 310, 0x000000 }, },
        { false, false, false, false, { 380, 437, 0x42717b }, false, false, false, false, false, { 1560, 437, 0x000000 }, },
        { false, false, false, false, { 350, 577, 0x315d6b }, false, false, false, false, false, { 1591, 577, 0x000000 }, },
        { false, false, false, false, { 316, 733, 0x3a616b }, false, false, false, false, false, { 1626, 733, 0x000000 }, },
        { false, false, false, false, { 278, 910, 0x000000 }, false, false, false, false, false, { 1665, 910, 0x000000 }, },
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
    height = 6,
    obstacle = {
      { 2, 7 },
      { 3, 1 }, { 3, 2 }, { 3, 3 }, { 3, 7 }, { 3, 10 },
      { 6, 1 }, { 6, 5 },
    },
    waitForBossPosition = { { 1, 10 }, { 6, 10 }, },
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