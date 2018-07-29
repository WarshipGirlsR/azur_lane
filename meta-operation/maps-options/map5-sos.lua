local mapBase = require './map'
local imgEvent = require './img5-sos'
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
      leftTop = { 612, 507 },
      rightTop = nil,
      leftBottom = nil,
      rightBottom = nil,
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的
      positionMap = {
        { { 612, 507, 0x6b5d00 }, false, false, false, false, false, false, { 1796, 507, 0x19313a }, },
        { { 598, 629, 0x000000 }, false, false, false, false, false, false, { 1829, 629, 0x6ba6bd }, },
        { { 583, 763, 0x000000 }, false, false, false, false, false, false, { 1866, 763, 0x19758c }, },
        { { 566, 908, 0x000000 }, false, false, false, false, false, false, { 1906, 908, 0x21698c }, },
      },
      pointMap = {},
    },
    {
      leftTop = nil,
      rightTop = { 1597, 513 },
      leftBottom = nil,
      rightBottom = nil,
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的
      positionMap = {
        { { 242, 513, 0x213d3a }, false, false, false, false, false, false, false, { 1597, 513, 0x29394a }, },
        { { 213, 636, 0x000000 }, false, false, false, false, false, false, false, { 1622, 636, 0x000000 }, },
        { { 181, 770, 0x000000 }, false, false, false, false, false, false, false, { 1650, 770, 0x000000 }, },
        { { 147, 915, 0x000000 }, false, false, false, false, false, false, false, { 1681, 915, 0x080c08 }, },
      },
      pointMap = {},
    },
    {
      leftTop = nil,
      rightTop = nil,
      leftBottom = { 479, 922 },
      rightBottom = nil,
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的
      positionMap = {
        false,
        { { 576, 221, 0x000000 }, false, false, false, false, false, { 1632, 221, 0x217d8c }, },
        { { 560, 337, 0x000000 }, false, false, false, false, false, { 1660, 337, 0x19698c }, },
        { { 543, 464, 0x000000 }, false, false, false, false, false, { 1691, 464, 0x196184 }, },
        { { 523, 602, 0x000000 }, false, false, false, false, false, { 1725, 602, 0x214973 }, },
        { { 502, 753, 0x000000 }, false, false, false, false, false, { 1762, 753, 0x104173 }, },
        { { 479, 922, 0x000000 }, false, false, false, false, false, { 1803, 922, 0x4a494a }, },
      },
      pointMap = {},
    },
    {
      leftTop = nil,
      rightTop = nil,
      leftBottom = nil,
      rightBottom = { 1722, 905 },
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的
      positionMap = {
        false,
        { false, false, { 509, 207, 0x00ae3a }, false, false, false, false, false, { 1567, 207, 0x000000 }, },
        { false, false, { 490, 323, 0x19798c }, false, false, false, false, false, { 1593, 323, 0x000000 }, },
        { false, false, { 470, 449, 0x840808 }, false, false, false, false, false, { 1621, 449, 0x000000 }, },
        { false, false, { 446, 586, 0x296994 }, false, false, false, false, false, { 1651, 586, 0x000000 }, },
        { false, false, { 421, 737, 0x215d84 }, false, false, false, false, false, { 1685, 737, 0x000000 }, },
        { false, false, { 394, 905, 0x000000 }, false, false, false, false, false, { 1722, 905, 0x000000 }, },
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
      { 1, 4 },
      { 3, 2 },
      { 6, 1 }, { 6, 2 }, { 6, 7 },
    },
    waitForBossPosition = { { 1, 7 }, { 2, 4 }, { 2, 5 }, { 2, 8 } },
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