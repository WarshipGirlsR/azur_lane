local mapBase = require './map'
local imgEvent = require './imgevent16-2-b1'
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
      leftTop = nil,
      rightTop = { 1644, 522 },
      leftBotton = nil,
      rightBotton = nil,
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的
      positionMap = {
        { { 332, 522, 0x42414a }, { 496, 522, 0x211829 }, { 660, 522, 0x3a203a }, { 825, 522, 0x4a1829 }, { 989, 522, 0x310c10 }, { 1153, 522, 0x292829 }, { 1316, 522, 0x521c3a }, { 1478, 522, 0x421431 }, { 1644, 522, 0x211431 }, },
        { { 307, 641, 0x4a395a }, { 477, 641, 0x21183a }, { 648, 641, 0x310821 }, { 819, 641, 0x6b1829 }, { 990, 641, 0x520410 }, { 1160, 641, 0x520421 }, { 1331, 641, 0x6b1431 }, { 1501, 641, 0x5a1c42 }, { 1673, 641, 0x000000 }, },
        { { 278, 772, 0x000000 }, { 455, 772, 0x211c3a }, { 632, 772, 0x311c42 }, { 811, 772, 0x4a1021 }, { 991, 772, 0x4a0c29 }, { 1169, 772, 0x4a0c21 }, { 1347, 772, 0x4a1029 }, { 1525, 772, 0x3a1029 }, { 1706, 772, 0x000000 }, },
        { { 245, 915, 0x000000 }, { 428, 915, 0x424142 }, { 618, 915, 0x211c3a }, { 804, 915, 0x100c29 }, { 988, 915, 0x4a1429 }, { 1177, 915, 0x313152 }, { 1366, 915, 0x101019 }, { 1552, 915, 0x101019 }, { 1741, 915, 0x080c08 }, },
      },
      pointMap = {},
    }, {
      leftTop = nil,
      rightTop = nil,
      leftBotton = { 428, 965 },
      rightBotton = nil,
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的
      positionMap = {
        false, false, false,
        { { 504, 506, 0x000000 }, { 689, 506, 0x191819 }, { 876, 506, 0x312042 }, { 1064, 506, 0x21143a }, { 1248, 506, 0x3a243a }, },
        { { 478, 643, 0x7b7d7b }, { 675, 643, 0x292d29 }, { 872, 643, 0x191031 }, { 1069, 643, 0x21143a }, { 1265, 643, 0x19103a }, },
        { { 454, 794, 0x211829 }, { 661, 794, 0x101421 }, { 868, 794, 0x21143a }, { 1074, 794, 0x211042 }, { 1281, 794, 0x190c29 }, },
        { { 428, 965, 0x000000 }, { 644, 965, 0x000000 }, { 863, 965, 0x000000 }, { 1081, 965, 0x000000 }, { 1297, 965, 0x4a494a }, },
      },
      pointMap = {},
    }, {
      leftTop = nil,
      rightTop = nil,
      leftBotton = nil,
      rightBotton = { 1703, 939 },
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的
      positionMap = {
        false, false, false,
        { false, false, false, false, { 845, 484, 0x3a2442 }, { 1033, 484, 0x313152 }, { 1221, 484, 0x211431 }, { 1407, 484, 0x191031 }, { 1597, 484, 0x000000 }, },
        { false, false, false, false, { 842, 620, 0x21143a }, { 1037, 620, 0x191031 }, { 1234, 620, 0x21183a }, { 1430, 620, 0x291c42 }, { 1629, 620, 0x000000 }, },
        { false, false, false, false, { 835, 770, 0x190c29 }, { 1042, 770, 0x211031 }, { 1248, 770, 0x21143a }, { 1454, 770, 0x291c42 }, { 1663, 770, 0x000000 }, },
        { false, false, false, false, { 827, 939, 0x000000 }, { 1045, 939, 0x000000 }, { 1265, 939, 0x000000 }, { 1483, 939, 0x101010 }, { 1703, 939, 0x101010 }, },
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
      { 1, 1 },
      { 2, 1 },
      { 3, 4 }, { 3, 5 }, { 3, 6 },
      { 4, 4 }, { 4, 5 }, { 4, 6 },
    },
    waitForBossPosition = { { 1, 8 }, { 6, 8 } },
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
