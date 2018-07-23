local mapBase = require './map'
local imgEvent = require './img5-2'
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
      leftTop = { 339, 467 },
      rightTop = nil,
      leftBottom = nil,
      rightBottom = nil,
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的
      positionMap = {
        { { 339, 467, 0x314531 }, { 514, 467, 0x19243a }, { 690, 467, 0x19243a }, { 866, 467, 0x19283a }, { 1043, 467, 0x293942 }, { 1219, 467, 0x29414a }, { 1394, 467, 0x293942 }, { 1570, 467, 0x293942 }, { 1748, 467, 0x213d42 }, },
        { { 312, 593, 0x000000 }, { 495, 593, 0x197dad }, { 678, 593, 0x3a7d6b }, { 862, 593, 0x197984 }, { 1045, 593, 0x217994 }, { 1229, 593, 0x21798c }, { 1413, 593, 0x298194 }, { 1596, 593, 0x19798c }, { 1781, 593, 0x000000 }, },
        { { 283, 731, 0x000000 }, { 474, 731, 0x19798c }, { 666, 731, 0x19798c }, { 857, 731, 0x198194 }, { 1049, 731, 0x196184 }, { 1241, 731, 0x31696b }, { 1432, 731, 0x196184 }, { 1624, 731, 0x196d84 }, { 1817, 731, 0x000000 }, },
        { { 252, 881, 0x000000 }, { 452, 881, 0x21718c }, { 652, 881, 0x527152 }, { 852, 881, 0x085984 }, { 1053, 881, 0x21517b }, { 1253, 881, 0x294d84 }, { 1454, 881, 0x194d73 }, { 1655, 881, 0x315d8c }, { 1857, 881, 0x000000 }, },
      },
      pointMap = {},
    },
    {
      leftTop = nil,
      rightTop = nil,
      leftBottom = { 358, 884 },
      rightBottom = nil,
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的
      positionMap = {
        false, false, false,
        { { 414, 567, 0x000000 }, { 613, 567, 0x317594 }, { 814, 567, 0x216d8c }, { 1015, 567, 0x215d84 }, { 1215, 567, 0x215184 }, },
        { { 388, 717, 0x000000 }, { 597, 717, 0x21658c }, { 807, 717, 0x297194 }, { 1017, 717, 0x215d84 }, { 1227, 717, 0x10417b }, },
        { { 358, 884, 0x000000 }, { 578, 884, 0x000000 }, { 799, 884, 0x000000 }, { 1020, 884, 0x000000 }, { 1241, 884, 0x000000 }, },
      },
      pointMap = {},
    },
    {
      leftTop = nil,
      rightTop = nil,
      leftBottom = nil,
      rightBottom = { 1676, 884 },
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的
      positionMap = {
        false, false, false,
        { false, false, false, false, { 866, 564, 0x195184 }, { 1066, 564, 0x295184 }, { 1267, 564, 0x214d7b }, { 1467, 564, 0x29598c }, { 1669, 564, 0x000000 }, },
        { false, false, false, false, { 861, 714, 0x003d73 }, { 1071, 714, 0x104173 }, { 1281, 714, 0x214d7b }, { 1492, 714, 0x31518c }, { 1704, 714, 0x000000 }, },
        { false, false, false, false, { 856, 881, 0x000000 }, { 1077, 881, 0x000000 }, { 1298, 881, 0x000000 }, { 1519, 881, 0x000000 }, { 1741, 881, 0x000000 }, },
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
      { 1, 1 }, { 1, 2 }, { 1, 3 },
      { 2, 5 }, { 2, 6 },
      { 3, 6 },
    },
    waitForBossPosition = { { 1, 5 }, { 3, 5 }, { 3, 7 } },
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