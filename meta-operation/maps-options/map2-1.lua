local mapBase = require './map'
local imgEvent = require './img2-1'
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
      leftTop = { 462, 552 },
      rightTop = nil,
      leftBottom = nil,
      rightBottom = nil,
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的
      positionMap = {
        { { 462, 552, 0x21354a }, { 637, 552, 0x212d42 }, { 813, 552, 0x212842 }, { 990, 552, 0x21314a }, { 1166, 552, 0x21314a }, { 1342, 552, 0x21354a }, { 1520, 552, 0x293952 }, },
        { { 442, 681, 0x000000 }, { 624, 681, 0x19798c }, { 807, 681, 0x197d8c }, { 990, 681, 0x106d84 }, { 1174, 681, 0x197584 }, { 1357, 681, 0x298194 }, { 1543, 681, 0x000000 }, },
        { { 419, 823, 0x000000 }, { 609, 823, 0x217994 }, { 800, 823, 0x086d84 }, { 992, 823, 0x085173 }, { 1183, 823, 0x215d84 }, { 1375, 823, 0x216d8c }, { 1569, 823, 0x080c10 }, },
      },
      pointMap = {},
    },
    {
      leftTop = nil,
      rightTop = nil,
      leftBottom = { 385, 905 },
      rightBottom = nil,
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的
      positionMap = {
        false, false,
        { { 436, 599, 0x000000 }, { 626, 599, 0x19798c }, { 817, 599, 0x10718c }, { 1009, 599, 0x10597b }, { 1201, 599, 0x215984 }, { 1392, 599, 0x196984 }, { 1586, 599, 0x4a4d52 }, },
        { { 412, 744, 0x000000 }, { 610, 744, 0x2171a4 }, { 811, 744, 0x085984 }, { 1011, 744, 0x084173 }, { 1212, 744, 0x214d8c }, { 1412, 744, 0x31518c }, { 1615, 744, 0x000000 }, },
        { { 385, 905, 0x000000 }, { 594, 905, 0x000000 }, { 803, 905, 0x000000 }, { 1014, 905, 0x000000 }, { 1224, 905, 0x000000 }, { 1434, 905, 0x000000 }, { 1647, 905, 0x000000 }, },
      },
      pointMap = {},
    },
  })
  return list
end

-- 获取地图棋盘和相关数据
mapEvent.getMapChessboard = function()
  return {
    width = 6,
    height = 4,
    obstacle = {
      { 2, 3 }, { 2, 4 },
      { 3, 1 },
      { 4, 1 }, { 4, 2 }, { 4, 3 }, { 4, 6 },
    },
    waitForBossPosition = { { 4, 4 } },
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