-- 光与影的鸢尾之华
local mapBase = require './map'
local imgEvent = require './imgzlzy-b1'
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
      leftTop = { 415, 515 },
      rightTop = nil,
      leftBottom = nil,
      rightBottom = nil,
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的
      positionMap = {
        { { 415, 515, 0x190c10 }, false, false, false, false, false, false, { 1514, 515, 0x080400 }, },
        { { 389, 630, 0x000000 }, false, false, false, false, false, false, { 1541, 630, 0x522021 }, },
        { { 360, 757, 0x000000 }, false, false, false, false, false, false, { 1572, 757, 0x7b798c }, },
        { { 329, 897, 0x000000 }, false, false, false, false, false, false, { 1784, 897, 0x5a3131 }, }
      },
      pointMap = {},
    },
    {
      leftTop = nil,
      rightTop = { 1547, 503 },
      leftBottom = nil,
      rightBottom = nil,
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的
      positionMap = {
        { false, false, false, { 444, 503, 0x100808 }, false, false, false, false, false, false, { 1547, 503, 0x190808 }, },
        { false, false, false, { 419, 618, 0x6b3131 }, false, false, false, false, false, false, { 1574, 618, 0x000000 }, },
        { false, false, false, { 392, 744, 0x633142 }, false, false, false, false, false, false, { 1605, 744, 0x000000 }, },
        { false, false, false, { 361, 883, 0xffffff }, false, false, false, false, false, false, { 1639, 883, 0x000000 }, },
      },
      pointMap = {},
    },
    {
      leftTop = nil,
      rightTop = nil,
      leftBottom = nil,
      rightBottom = { 1695, 901 },
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的
      positionMap = {
        false, false, false,
        { false, false, false, false, { 484, 456, 0x8c5152 }, false, false, false, false, false, { 1578, 456, 0x000000 }, },
        { false, false, false, false, { 458, 587, 0x6b2d31 }, false, false, false, false, false, { 1613, 587, 0x000000 }, },
        { false, false, false, false, { 428, 734, 0x311419 }, false, false, false, false, false, { 1652, 734, 0x000000 }, },
        { false, false, false, false, { 395, 901, 0x100c10 }, false, false, false, false, false, { 1695, 901, 0x000000 }, },
      },
      pointMap = {},
    },
    {
      leftTop = nil,
      rightTop = nil,
      leftBottom = { 267, 922 },
      rightBottom = nil,
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的
      positionMap = {
        false, false, false,
        { { 377, 474, 0x000000 }, false, false, false, false, false, { 1468, 474, 0x63313a }, },
        { { 344, 606, 0x000000 }, false, false, false, false, false, { 1496, 606, 0x633131 }, },
        { { 308, 753, 0x000000 }, false, false, false, false, false, { 1528, 753, 0x421819 }, },
        { { 267, 922, 0x000000 }, false, false, false, false, false, { 1565, 922, 0x080c08 }, },
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
    height = 6,
    obstacle = {
      { 1, 5 }, { 1, 6 }, { 1, 7 },
      { 3, 1 }, { 3, 10 },
      { 4, 4 }, { 4, 10 },
      { 5, 4 },
      { 6, 3 }, { 6, 4 }, { 6, 5 }, { 6, 6 },
    },
    waitForBossPosition = { { 1, 10 }, { 6, 7 }, { 6, 10 }, },
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