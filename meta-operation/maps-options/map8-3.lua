local mapBase = require './map'
local imgEvent = require './img8-3'
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
      leftTop = { 347, 520 },
      rightTop = nil,
      leftBottom = nil,
      rightBottom = nil,
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的
      positionMap = {
        { { 347, 520, 0x3a3d3a }, { 508, 520, 0x293542 }, { 671, 520, 0x212d31 }, { 834, 520, 0x313942 }, { 997, 520, 0x292d42 }, { 1160, 520, 0x313942 }, { 1323, 520, 0x293131 }, { 1486, 520, 0x293542 }, { 1651, 520, 0x29313a }, },
        { { 323, 638, 0x000000 }, { 491, 638, 0x196d94 }, { 660, 638, 0x217594 }, { 829, 638, 0x217d8c }, { 998, 638, 0x422021 }, { 1168, 638, 0x21798c }, { 1337, 638, 0x217d8c }, { 1506, 638, 0x29819c }, { 1677, 638, 0x000000 }, },
        { { 297, 767, 0x000000 }, { 472, 767, 0x217984 }, { 648, 767, 0x197984 }, { 824, 767, 0x107984 }, { 1000, 767, 0x116d84 }, { 1176, 767, 0xf7d784 }, { 1352, 767, 0x196984 }, { 1528, 767, 0x197584 }, { 1707, 767, 0x000000 }, },
        { { 269, 906, 0x000000 }, { 451, 906, 0x197d8c }, { 635, 906, 0x297d8c }, { 818, 906, 0x21758c }, { 1002, 906, 0x21598c }, { 1185, 906, 0x192831 }, { 1369, 906, 0x196184 }, { 1552, 906, 0x21698c }, { 1738, 906, 0x000000 }, },
      },
      pointMap = {},
    },
    {
      leftTop = nil,
      rightTop = nil,
      leftBottom = { 426, 904 },
      rightBottom = nil,
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的
      positionMap = {
        false, false, false,
        { { 494, 467, 0x000000 }, { 675, 467, 0x529ac5 }, { 859, 467, 0x297d8c }, { 1043, 467, 0x217184 }, { 1226, 467, 0x08517b }, { 1409, 467, 0xa4b2b5 }, },
        { { 473, 599, 0x000000 }, { 663, 599, 0x316594 }, { 855, 599, 0x296994 }, { 1046, 599, 0x08557b }, { 1238, 599, 0x084973 }, { 1430, 599, 0x08416b }, },
        { { 451, 743, 0x000000 }, { 649, 743, 0x19658c }, { 850, 743, 0x105584 }, { 1050, 743, 0x10557b }, { 1251, 743, 0x215d84 }, { 1451, 743, 0x21417b }, },
        { { 426, 904, 0x000000 }, { 635, 904, 0x000000 }, { 844, 904, 0x000000 }, { 1055, 904, 0x000000 }, { 1265, 904, 0x000000 }, { 1475, 904, 0x000000 }, },
      },
      pointMap = {},
    },
    {
      leftTop = nil,
      rightTop = nil,
      leftBottom = nil,
      rightBottom = { 1707, 905 },
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的
      positionMap = {
        false, false, false,
        { false, false, false, false, false, { 1059, 468, 0x194d73 }, { 1243, 468, 0x196184 }, { 1426, 468, 0x21698c }, { 1612, 468, 0x000000 }, },
        { false, false, false, false, false, { 1064, 600, 0x214984 }, { 1256, 600, 0x4275a4 }, { 1447, 600, 0x294d84 }, { 1641, 600, 0x000000 }, },
        { false, false, false, false, false, { 1068, 744, 0x21417b }, { 1269, 744, 0x104573 }, { 1469, 744, 0x21497b }, { 1673, 744, 0x000000 }, },
        { false, false, false, false, false, { 1074, 905, 0x000001 }, { 1284, 905, 0x000001 }, { 1494, 905, 0x000000 }, { 1707, 905, 0x000000 }, },
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
      { 2, 4 }, { 2, 5 },
      { 3, 2 }, { 3, 3 },
      { 4, 3 }, { 4, 6 },
      { 5, 5 }, { 5, 6 },
    },
    waitForBossPosition = { { 1, 1 }, { 1, 8 }, { 6, 1 }, { 6, 8 } },
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