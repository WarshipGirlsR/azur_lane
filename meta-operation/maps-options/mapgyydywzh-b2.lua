-- 光与影的鸢尾之华
local mapBase = require './map'
local imgEvent = require './imggyydywzh-b2'
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
      leftTop = { 586, 505 },
      rightTop = nil,
      leftBottom = nil,
      rightBottom = nil,
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的
      positionMap = {
        { { 586, 505, 0x29313a }, false, false, false, false, false, false, { 1769, 505, 0x212d42 }, },
        { { 571, 628, 0x000000 }, false, false, false, false, false, false, { 1802, 628, 0x29415a }, },
        { { 554, 762, 0x000000 }, false, false, false, false, false, false, { 1838, 762, 0x294163 }, },
        { { 536, 907, 0x000000 }, false, false, false, false, false, false, { 1876, 907, 0x21414a }, },
      },
      pointMap = {},
    },
    {
      leftTop = nil,
      rightTop = { 1595, 503 },
      leftBottom = nil,
      rightBottom = nil,
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的
      positionMap = {
        { false, false, { 408, 503, 0x3a4542 }, false, false, false, false, false, false, { 1595, 503, 0x524142 }, },
        { false, false, { 386, 626, 0x42455a }, false, false, false, false, false, false, { 1620, 626, 0x000000 }, },
        { false, false, { 361, 759, 0x4a4d5a }, false, false, false, false, false, false, { 1648, 759, 0x000000 }, },
        { false, false, { 335, 904, 0x42495a }, false, false, false, false, false, false, { 1678, 904, 0x000000 }, },
      },
      pointMap = {},
    },
    {
      leftTop = nil,
      rightTop = { 1609, 370 },
      leftBottom = nil,
      rightBottom = nil,
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的
      positionMap = {
        { false, false, { 422, 370, 0x313d42 }, false, false, false, false, false, false, { 1609, 370, 0x191821 }, },
        { false, false, { 401, 487, 0x3a455a }, false, false, false, false, false, false, { 1635, 487, 0x000000 }, },
        { false, false, { 377, 615, 0x4a495a }, false, false, false, false, false, false, { 1664, 615, 0x000000 }, },
        { false, false, { 348, 753, 0xd6d2ef }, false, false, false, false, false, false, { 1695, 753, 0x000000 }, },
        { false, false, { 323, 905, 0x4a4d63 }, false, false, false, false, false, false, { 1729, 905, 0x000000 }, }
      },
      pointMap = {},
    },
    {
      leftTop = { 615, 237 },
      rightTop = nil,
      leftBottom = nil,
      rightBottom = nil,
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的
      positionMap = {
        false,
        { { 601, 349, 0x000000 }, false, false, false, false, false, { 1656, 349, 0x21354a }, },
        { { 586, 471, 0x000000 }, false, false, false, false, false, { 1686, 471, 0x213952 }, },
        { { 570, 603, 0x000000 }, false, false, false, false, false, { 1718, 603, 0x294152 }, },
        { { 552, 748, 0x000010 }, false, false, false, false, false, { 1752, 748, 0x42415a }, },
        { { 532, 906, 0x000000 }, false, false, false, false, false, { 1789, 906, 0xadae84 }, },
      },
      pointMap = {},
    },
    {
      leftTop = nil,
      rightTop = nil,
      leftBottom = { 538, 903 },
      rightBottom = nil,
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的
      positionMap = {
        false, false, false,
        { { 612, 296, 0x000000 }, false, false, false, false, { 1569, 296, 0x524d52 }, },
        { { 596, 426, 0x000000 }, false, false, false, false, { 1597, 426, 0x29395a }, },
        { { 579, 569, 0x000000 }, false, false, false, false, { 1628, 569, 0x212d52 }, },
        { { 560, 726, 0x000000 }, false, false, false, false, { 1662, 726, 0x29285a }, },
        { { 538, 903, 0x000000 }, false, false, false, false, { 1701, 903, 0x000000 }, },
      },
      pointMap = {},
    },
    {
      leftTop = nil,
      rightTop = nil,
      leftBottom = nil,
      rightBottom = { 1706, 899 },
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的
      positionMap = {
        false, false, false,
        { false, false, false, { 422, 292, 0x3a414a }, false, false, false, false, false, { 1574, 292, 0x000000 }, },
        { false, false, false, { 396, 422, 0x29243a }, false, false, false, false, false, { 1602, 422, 0x000000 }, },
        { false, false, false, { 371, 565, 0x312d42 }, false, false, false, false, false, { 1633, 565, 0x21285a }, },
        { false, false, false, { 340, 722, 0x42456b }, false, false, false, false, false, { 1668, 722, 0x000000 }, },
        { false, false, false, { 306, 899, 0x000000 }, false, false, false, false, false, { 1706, 899, 0x000000 }, },
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
    height = 7,
    obstacle = {
      { 1, 8 },
      { 2, 8 },
      { 3, 4 }, { 3, 5 }, { 3, 6 },
      { 5, 4 }, { 5, 5 }, { 5, 6 },
      { 6, 8 },
      { 7, 8 },
    },
    waitForBossPosition = { { 1, 9 }, { 7, 9 }, },
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