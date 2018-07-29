local mapBase = require './map'
local imgEvent = require './img8-sos'
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
      leftTop = { 325, 525 },
      rightTop = nil,
      leftBottom = nil,
      rightBottom = nil,
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的
      positionMap = {
        { { 325, 525, 0x31393a }, false, false, false, false, false, false, false, { 1629, 525, 0x21203a }, },
        { { 301, 644, 0x000000 }, false, false, false, false, false, false, false, { 1655, 644, 0x000000 }, },
        { { 274, 772, 0x000000 }, false, false, false, false, false, false, false, { 1683, 772, 0x000000 }, },
        { { 245, 912, 0x000000 }, false, false, false, false, false, false, false, { 1714, 912, 0x000000 }, },
      },
      pointMap = {},
    },
    {
      leftTop = { 642, 266 },
      rightTop = nil,
      leftBottom = nil,
      rightBottom = nil,
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的
      positionMap = {
        { { 642, 266, 0x292842 }, false, false, false, false, false, { 1618, 266, 0x293942 }, },
        { { 629, 375, 0x000000 }, false, false, false, false, false, { 1643, 375, 0x218194 }, },
        { { 616, 492, 0x000000 }, false, false, false, false, false, { 1671, 492, 0x9ccede }, },
        { { 601, 620, 0x000000 }, false, false, false, false, false, { 1701, 620, 0x216d94 }, },
        { { 586, 759, 0x000000 }, false, false, false, false, false, { 1734, 759, 0x195d84 }, },
        { { 568, 911, 0x9c2d00 }, false, false, false, false, false, { 1770, 911, 0x194d7b }, },
      },
      pointMap = {},
    },
    {
      leftTop = nil,
      rightTop = { 1520, 268 },
      leftBottom = nil,
      rightBottom = nil,
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的
      positionMap = {
        { false, { 377, 268, 0x31393a }, false, false, false, false, false, false, { 1520, 268, 0x293942 }, },
        { false, { 352, 377, 0x7bbef7 }, false, false, false, false, false, false, { 1541, 377, 0x000000 }, },
        { false, { 330, 495, 0x191008 }, false, false, false, false, false, false, { 1565, 495, 0x000000 }, },
        { false, { 304, 622, 0x217d94 }, false, false, false, false, false, false, { 1590, 622, 0x000000 }, },
        { false, { 275, 761, 0x31719c }, false, false, false, false, false, false, { 1618, 761, 0x000000 }, },
        { false, { 243, 913, 0x296194 }, false, false, false, false, false, false, { 1649, 913, 0x294163 }, },
      },
      pointMap = {},
    },
    {
      leftTop = nil,
      rightTop = nil,
      leftBottom = { 487, 911 },
      rightBottom = nil,
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的
      positionMap = {
        false, false,
        { { 583, 212, 0x000000 }, false, false, false, false, false, { 1638, 212, 0x217594 }, },
        { { 567, 327, 0x000000 }, false, false, false, false, false, { 1667, 327, 0x3a81a4 }, },
        { { 550, 453, 0x000000 }, false, false, false, false, false, { 1698, 453, 0x195d84 }, },
        { { 550, 453, 0x000000 }, false, false, false, false, false, { 1698, 453, 0x195d84 }, },
        { { 530, 591, 0xad3100 }, false, false, false, false, false, { 1733, 591, 0x294d84 }, },
        { { 487, 911, 0x000000 }, false, false, false, false, false, { 1812, 911, 0x000819 }, },
      },
      pointMap = {},
    },
    {
      leftTop = nil,
      rightTop = nil,
      leftBottom = nil,
      rightBottom = { 1680, 914 },
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的
      positionMap = {
        false, false,
        { false, { 297, 214, 0x632408 }, false, false, false, false, false, false, { 1533, 214, 0x000000 }, },
        { false, { 271, 330, 0x197994 }, false, false, false, false, false, false, { 1558, 330, 0x000000 }, },
        { false, { 240, 456, 0x3175a4 }, false, false, false, false, false, false, { 1584, 456, 0x000000 }, },
        { false, { 207, 594, 0x296194 }, false, false, false, false, false, false, { 1613, 594, 0xbde7ff }, },
        { false, { 170, 745, 0x196184 }, false, false, false, false, false, false, { 1645, 745, 0x000000 }, },
        { false, { 130, 914, 0x000000 }, false, false, false, false, false, false, { 1680, 914, 0x100c10 }, },
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
    height = 7,
    obstacle = {
      { 1, 1 }, { 1, 2 },
      { 2, 1 }, { 2, 2 }, { 2, 6 },
      { 4, 8 },
      { 5, 2 }, { 5, 8 },
      { 6, 2 },
      { 7, 7 },
    },
    waitForBossPosition = { { 4, 1 } },
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