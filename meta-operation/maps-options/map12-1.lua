local mapBase = require './map'
local imgEvent = require './img12-1'
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
      leftTop = { 287, 539 },
      rightTop = nil,
      leftBottom = nil,
      rightBottom = nil,
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的
      positionMap = {
        { { 287, 539, 0x212442 }, { 455, 539, 0x212442 }, { 625, 539, 0x212442 }, { 794, 539, 0x19243a }, { 963, 539, 0x212442 }, { 1133, 539, 0x212442 }, { 1302, 539, 0x19243a }, { 1471, 539, 0x293529 }, { 1642, 539, 0x101829 }, },
        { { 260, 663, 0x000000 }, { 435, 663, 0x21719c }, { 611, 663, 0x217194 }, { 787, 663, 0x218194 }, { 963, 663, 0x217594 }, { 1139, 663, 0x21798c }, { 1316, 663, 0x217d84 }, { 1492, 663, 0x197984 }, { 1670, 663, 0x000000 }, },
        { { 231, 798, 0x000000 }, { 413, 798, 0x217d84 }, { 597, 798, 0x197d8c }, { 780, 798, 0x219ebd }, { 963, 798, 0x63868c }, { 1147, 798, 0x19698c }, { 1331, 798, 0x216d8c }, { 1514, 798, 0x217594 }, { 1700, 798, 0x000000 }, },
        { { 199, 944, 0x000000 }, { 389, 944, 0x197d8c }, { 581, 944, 0x297d94 }, { 772, 944, 0x21758c }, { 963, 944, 0x08597b }, { 1155, 944, 0x73494a }, { 1346, 944, 0x192831 }, { 1539, 944, 0x102831 }, { 1732, 944, 0x101010 }, },
      },
      pointMap = {},
    },
    {
      leftTop = nil,
      rightTop = nil,
      leftBottom = { 460, 956 },
      rightBottom = nil,
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的
      positionMap = {
        false, false, false,
        { { 526, 493, 0x000000 }, { 716, 493, 0x19798c }, { 908, 493, 0x21798c }, { 1099, 493, 0x107184 }, { 1291, 493, 0x10597b }, },
        { { 506, 632, 0x000000 }, { 705, 632, 0x296194 }, { 905, 632, 0x296594 }, { 1106, 632, 0x215d84 }, { 1306, 632, 0x195184 }, },
        { { 484, 785, 0x000000 }, { 692, 785, 0x19618c }, { 903, 785, 0x195d84 }, { 1113, 785, 0x215d84 }, { 1323, 785, 0x105984 }, },
        { { 460, 956, 0x000000 }, { 679, 956, 0x000000 }, { 900, 956, 0x000000 }, { 1121, 956, 0x000000 }, { 1341, 956, 0x8c8a8c }, },
      },
      pointMap = {},
    },
    {
      leftTop = nil,
      rightTop = nil,
      leftBottom = nil,
      rightBottom = { 1565, 954 },
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的
      positionMap = {
        false, false, false,
        { false, false, false, false, { 715, 491, 0x73757b }, { 907, 491, 0x214d84 }, { 1099, 491, 0x21618c }, { 1291, 491, 0x21698c }, { 1485, 491, 0x000000 }, },
        { false, false, false, false, { 704, 631, 0x084973 }, { 905, 631, 0x10497b }, { 1106, 631, 0x214573 }, { 1306, 631, 0x294d84 }, { 1509, 631, 0x000000 }, },
        { false, false, false, false, { 692, 784, 0x215d8c }, { 902, 784, 0x21417b }, { 1112, 784, 0x21498c }, { 1322, 784, 0x29c2de }, { 1536, 784, 0x000000 }, },
        { false, false, false, false, { 678, 954, 0x000000 }, { 900, 954, 0x000000 }, { 1121, 954, 0x000000 }, { 1341, 954, 0x191c19 }, { 1565, 954, 0x080c08 }, },
      },
      pointMap = {},
    },
    {
      leftTop = nil,
      rightTop = nil,
      leftBottom = nil,
      rightBottom = { 1550, 953 },
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的
      positionMap = {
        false, false, false,
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
      { 1, 7 }, { 1, 8 },
      { 2, 1 }, { 2, 4 },
      { 3, 1 }, { 3, 4 }, { 3, 5 },
      { 5, 2 }, { 5, 3 }, { 5, 7 },
      { 6, 7 },
    },
    waitForBossPosition = { { 5, 8 } },
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