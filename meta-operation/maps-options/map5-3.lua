local mapBase = require './map'
local imgEvent = require './img5-3'
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
      leftTop = { 449, 473 },
      rightTop = nil,
      leftBotton = nil,
      rightBotton = nil,
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的
      positionMap = {
        { { 449, 473, 0x213531 }, { 618, 475, 0x213542 }, { 787, 475, 0x213142 }, { 956, 475, 0x19293a }, { 1125, 475, 0x213142 }, { 1293, 475, 0x213142 }, { 1464, 475, 0x19313a }, { 1633, 475, 0x29414a }, },
        { { 428, 597, 0x000000 }, { 604, 597, 0x6b5108 }, { 779, 597, 0x197994 }, { 955, 597, 0x218194 }, { 1131, 597, 0x21718c }, { 1307, 597, 0x218194 }, { 1483, 597, 0x217d94 }, { 1661, 597, 0x000000 }, },
        { { 406, 729, 0x000000 }, { 589, 729, 0x9c7910 }, { 772, 729, 0x19798c }, { 955, 729, 0x318194 }, { 1139, 729, 0x195d7b }, { 1322, 729, 0x196984 }, { 1506, 729, 0x196984 }, { 1691, 729, 0x000000 }, },
        { { 381, 873, 0x000000 }, { 572, 873, 0x21799c }, { 763, 873, 0x21718c }, { 955, 873, 0x104d7b }, { 1147, 873, 0x10497b }, { 1338, 873, 0x194573 }, { 1530, 873, 0x215984 }, { 1724, 873, 0x000000 }, },
      },
      pointMap = {},
    },
    {
      leftTop = nil,
      rightTop = nil,
      leftBotton = { 316, 885 },
      rightBotton = nil,
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的
      positionMap = {
        false, false, false,
        { { 373, 582, 0x000000 }, { 563, 582, 0x298aad }, { 755, 582, 0x21718c }, { 947, 582, 0x084d73 }, { 1138, 582, 0x21498c }, { 1329, 582, 0x214973 }, { 1521, 582, 0x215984 }, { 1715, 582, 0x000000 }, },
        { { 346, 725, 0x000000 }, { 545, 725, 0x21719c }, { 746, 725, 0x196984 }, { 946, 725, 0x08496b }, { 1147, 725, 0x104173 }, { 1347, 725, 0x104d7b }, { 1547, 725, 0x294d84 }, { 1750, 725, 0x000000 }, },
        { { 316, 885, 0x000000 }, { 525, 885, 0x000000 }, { 735, 885, 0x000000 }, { 945, 885, 0x000000 }, { 1156, 885, 0x000000 }, { 1366, 885, 0x000000 }, { 1576, 885, 0x000000 }, { 1789, 885, 0x000000 }, },
      },
      pointMap = {},
    },
  })
  return list
end

-- 获取地图棋盘和相关数据
mapEvent.getMapChessboard = function()
  return {
    width = 7,
    height = 5,
    obstacle = { { 1, 1 }, { 2, 1 }, { 3, 1 }, { 4, 1 }, { 3, 3 }, },
    waitForBossPosition = { { 1, 2 }, { 1, 6 }, { 4, 5 } },
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