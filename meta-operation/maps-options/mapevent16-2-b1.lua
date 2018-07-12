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
        { { 332, 522, 0x42414a }, false, false, false, false, false, false, false, { 1644, 522, 0x211431 }, },
        { { 307, 641, 0x4a395a }, false, false, false, false, false, false, false, { 1673, 641, 0x000000 }, },
        { { 278, 772, 0x000000 }, false, false, false, false, false, false, false, { 1706, 772, 0x000000 }, },
        { { 245, 915, 0x000000 }, false, false, false, false, false, false, false, { 1741, 915, 0x080c08 }, },
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
        { { 504, 506, 0x000000 }, false, false, false, { 1248, 506, 0x3a243a }, },
        { { 478, 643, 0x7b7d7b }, false, false, false, { 1265, 643, 0x19103a }, },
        { { 454, 794, 0x211829 }, false, false, false, { 1281, 794, 0x190c29 }, },
        { { 428, 965, 0x000000 }, false, false, false, { 1297, 965, 0x4a494a }, },
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
        { false, false, false, false, { 845, 484, 0x3a2442 }, false, false, false, { 1597, 484, 0x000000 }, },
        { false, false, false, false, { 842, 620, 0x21143a }, false, false, false, { 1629, 620, 0x000000 }, },
        { false, false, false, false, { 835, 770, 0x190c29 }, false, false, false, { 1663, 770, 0x000000 }, },
        { false, false, false, false, { 827, 939, 0x000000 }, false, false, false, { 1703, 939, 0x101010 }, },
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
