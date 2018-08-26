local mapBase = require './map'
local imgEvent = require './img12-2'
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
      leftTop = { 393, 533 },
      rightTop = nil,
      leftBottom = nil,
      rightBottom = nil,
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的
      positionMap = {
        { { 393, 533, 0x313942 }, false, false, false, false, false, false, { 1577, 533, 0x31354a }, },
        { { 370, 656, 0x000000 }, false, false, false, false, false, false, { 1601, 656, 0x217d94 }, },
        { { 345, 791, 0x080000 }, false, false, false, false, false, false, { 1628, 791, 0x106d84 }, },
        { { 318, 937, 0x100000 }, false, false, false, false, false, false, { 1658, 937, 0x293d42 }, },
      },
      pointMap = {},
    },
    {
      leftTop = nil,
      rightTop = { 1556, 515 },
      leftBottom = nil,
      rightBottom = nil,
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的
      positionMap = {
        { false, false, false, { 538, 515, 0x293542 }, false, false, false, false, false, { 1556, 515, 0x213142 }, },
        { false, false, false, { 521, 638, 0x297984 }, false, false, false, false, false, { 1580, 638, 0x000000 }, },
        { false, false, false, { 503, 772, 0x316d73 }, false, false, false, false, false, { 1606, 772, 0x000000 }, },
        { false, false, false, { 483, 918, 0x315d73 }, false, false, false, false, false, { 1635, 918, 0x080c08 }, },
      },
      pointMap = {},
    },
    {
      leftTop = nil,
      rightTop = { 1534, 268 },
      leftBottom = nil,
      rightBottom = nil,
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的
      positionMap = {
        false,
        { false, false, false, { 499, 381, 0x3a798c }, false, false, false, false, false, { 1557, 381, 0x000000 }, },
        { false, false, false, { 479, 504, 0x42656b }, false, false, false, false, false, { 1582, 504, 0x000000 }, },
        { false, false, false, { 458, 638, 0x5a617b }, false, false, false, false, false, { 1610, 638, 0x000000 }, },
        { false, false, false, { 435, 784, 0x5a4952 }, false, false, false, false, false, { 1640, 784, 0x000000 }, },
        { false, false, false, { 409, 945, 0x63456b }, false, false, false, false, false, { 1673, 945, 0x100c10 }, },
      },
      pointMap = {},
    },
    {
      leftTop = { 356, 257 },
      rightTop = nil,
      leftBottom = nil,
      rightBottom = nil,
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的
      positionMap = {
        false,
        { { 332, 369, 0x000000 }, false, false, false, false, false, false, { 1563, 369, 0x218194 }, },
        { { 305, 492, 0x080000 }, false, false, false, false, false, false, { 1588, 492, 0x21759c }, },
        { { 276, 626, 0x190000 }, false, false, false, false, false, false, { 1616, 626, 0x21698c }, },
        { { 244, 772, 0x100000 }, false, false, false, false, false, false, { 1647, 772, 0x215d84 }, },
        { { 210, 931, 0x080000 }, false, false, false, false, false, false, { 1679, 931, 0x211c21 }, },
      },
      pointMap = {},
    },
    {
      leftTop = nil,
      rightTop = nil,
      leftBottom = { 159, 924 },
      rightBottom = nil,
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的
      positionMap = {
        false, false, false,
        { { 301, 312, 0x290000 }, false, false, false, false, false, false, { 1641, 312, 0x19698c }, },
        { { 270, 443, 0x100000 }, false, false, false, false, false, false, { 1672, 443, 0x195d7b }, },
        { { 237, 587, 0x100000 }, false, false, false, false, false, false, { 1707, 587, 0x192842 }, },
        { { 200, 746, 0x190000 }, false, false, false, false, false, false, { 1745, 746, 0x104973 }, },
        { { 159, 924, 0x000000 }, false, false, false, false, false, false, { 1786, 924, 0x84868c }, },
      },
      pointMap = {},
    },
    {
      leftTop = nil,
      rightTop = nil,
      leftBottom = nil,
      rightBottom = { 1648, 943 },
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的
      positionMap = {
        false, false, false,
        { false, false, false, { 374, 328, 0x3a6d94 }, false, false, false, false, false, { 1526, 328, 0x000000 }, },
        { false, false, false, { 347, 460, 0x315963 }, false, false, false, false, false, { 1552, 460, 0x000000 }, },
        { false, false, false, { 317, 605, 0x425584 }, false, false, false, false, false, { 1581, 605, 0x000000 }, },
        { false, false, false, { 285, 764, 0x215573 }, false, false, false, false, false, { 1613, 764, 0x000000 }, },
        { false, false, false, { 248, 943, 0x000000 }, false, false, false, false, false, { 1648, 943, 0x080c08 }, },
      },
      pointMap = {},
    },
  })
  return list
end

-- 获取地图棋盘和相关数据
mapEvent.getMapChessboard = function()
  return {
    width = 9,
    height = 7,
    obstacle = {
      { 1, 1 }, { 1, 5 },
      { 2, 1 }, { 2, 9 },
      { 3, 3 }, { 3, 9 },
      { 4, 6 }, { 4, 7 },
      { 5, 1 },
      { 6, 4 },
      { 7, 8 }, { 7, 9 },
    },
    waitForBossPosition = { { 1, 2 }, { 3, 1 }, { 4, 1 } },
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