local mapBase = require './map'
local imgEvent = require './img12-3'
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
      leftTop = { 441, 488 },
      rightTop = nil,
      leftBottom = nil,
      rightBottom = nil,
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的
      positionMap = {
        { { 441, 488, 0x212442 }, false, false, false, false, false, false, { 1625, 488, 0x191c31 }, },
        { { 421, 610, 0x080000 }, false, false, false, false, false, false, { 1652, 610, 0x298194 }, },
        { { 398, 742, 0x210000 }, false, false, false, false, false, false, { 1681, 742, 0x217d8c }, },
        { { 373, 886, 0x190000 }, false, false, false, false, false, false, { 1713, 886, 0x196184 }, },
      },
      pointMap = {},
    },
    {
      leftTop = nil,
      rightTop = { 1558, 479 },
      leftBottom = nil,
      rightBottom = nil,
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的
      positionMap = {
        { false, false, false, { 371, 479, 0x293d52 }, false, false, false, false, false, false, { 1558, 479, 0x192031 }, },
        { false, false, false, { 347, 601, 0x191c19 }, false, false, false, false, false, false, { 1582, 601, 0x000000 }, },
        { false, false, false, { 322, 732, 0x5a6573 }, false, false, false, false, false, false, { 1608, 732, 0x000000 }, },
        { false, false, false, { 293, 877, 0x636973 }, false, false, false, false, false, false, { 1637, 877, 0x000000 }, },
      },
      pointMap = {},
    },
    {
      leftTop = nil,
      rightTop = { 1472, 269 },
      leftBottom = nil,
      rightBottom = nil,
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的
      positionMap = {
        false,
        { false, false, false, { 258, 383, 0x197da4 }, false, false, false, false, false, false, { 1493, 383, 0x000000 }, },
        { false, false, false, { 228, 506, 0x5a6573 }, false, false, false, false, false, false, { 1515, 506, 0x000000 }, },
        { false, false, false, { 196, 640, 0x636d7b }, false, false, false, false, false, false, { 1540, 640, 0x000000 }, },
        { false, false, false, { 161, 786, 0x635963 }, false, false, false, false, false, false, { 1567, 786, 0x000000 }, },
        { false, false, false, { 122, 946, 0x84716b }, false, false, false, false, false, false, { 1596, 946, 0x101010 }, },
      },
      pointMap = {},
    },
    {
      leftTop = { 416, 254 },
      rightTop = nil,
      leftBottom = nil,
      rightBottom = nil,
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的
      positionMap = {
        false,
        { { 394, 367, 0x100000 }, false, false, false, false, false, false, { 1625, 367, 0x21818c }, },
        { { 370, 489, 0x190000 }, false, false, false, false, false, false, { 1653, 489, 0x297d8c }, },
        { { 344, 622, 0x290000 }, false, false, false, false, false, false, { 1684, 622, 0x216184 }, },
        { { 315, 768, 0x100000 }, false, false, false, false, false, false, { 1717, 768, 0x21497b }, },
        { { 284, 927, 0x000000 }, false, false, false, false, false, false, { 1754, 927, 0x313d42 }, },
      },
      pointMap = {},
    },
    {
      leftTop = nil,
      rightTop = nil,
      leftBottom = { 235, 909 },
      rightBottom = nil,
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的
      positionMap = {
        false, false, false,
        { { 363, 300, 0x190000 }, false, false, false, false, false, false, { 1703, 300, 0x196184 }, },
        { { 336, 430, 0x100000 }, false, false, false, false, false, false, { 1738, 430, 0x294d8c }, },
        { { 305, 574, 0x000000 }, false, false, false, false, false, false, { 1776, 574, 0x214d84 }, },
        { { 272, 731, 0x000000 }, false, false, false, false, false, false, { 1817, 731, 0x10457b }, },
        { { 235, 909, 0x000000 }, false, false, false, false, false, false, { 1864, 909, 0x000000 }, },
      },
      pointMap = {},
    },
    {
      leftTop = nil,
      rightTop = nil,
      leftBottom = nil,
      rightBottom = { 1672, 924 },
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的
      positionMap = {
        false, false, false,
        { false, false, false, { 201, 312, 0x5a616b }, false, false, false, false, false, false, { 1545, 312, 0x000000 }, },
        { false, false, false, { 166, 443, 0x5a5563 }, false, false, false, false, false, false, { 1572, 443, 0x000000 }, },
        { false, false, false, { 128, 587, 0x425d5a }, false, false, false, false, false, false, { 1602, 587, 0x000000 }, },
        { false, false, false, { 86, 745, 0x085173 }, false, false, false, false, false, false, { 1634, 745, 0x000000 }, },
        { false, false, false, { 39, 924, 0x000000 }, false, false, false, false, false, false, { 1672, 924, 0x423d42 }, },
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
    height = 7,
    obstacle = {
      { 1, 2 }, { 1, 3 }, { 1, 4 },
      { 2, 9 },
      { 3, 4 }, { 3, 8 }, { 3, 9 },
      { 4, 6 }, { 4, 7 },
      { 5, 10 },
      { 6, 1 }, { 6, 6 }, { 6, 10 },
      { 7, 1 },
    },
    waitForBossPosition = { { 1, 1 }, { 1, 6 }, { 2, 1 }, { 2, 10 }, { 4, 1 } },
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