local mapBase = require './map'
local imgEvent = require './img12-4'
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
      leftTop = { 365, 399 },
      rightTop = nil,
      leftBottom = nil,
      rightBottom = nil,
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的
      positionMap = {
        { { 365, 399, 0x21243a }, false, false, false, false, false, false, false, { 1667, 399, 0x212442 }, },
        { { 342, 513, 0x000000 }, false, false, false, false, false, false, false, { 1694, 513, 0x197984 }, },
        { { 317, 637, 0x000000 }, false, false, false, false, false, false, false, { 1724, 637, 0x19758c }, },
        { { 290, 770, 0x000000 }, false, false, false, false, false, false, false, { 1756, 770, 0x217d9c }, },
        { { 260, 916, 0x000000 }, false, false, false, false, false, false, false, { 1792, 916, 0x212842 }, },
      },
      pointMap = {},
    },
    {
      leftTop = nil,
      rightTop = { 1565, 407 },
      leftBottom = nil,
      rightBottom = nil,
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的
      positionMap = {
        { false, false, false, { 259, 407, 0x212442 }, false, false, false, false, false, false, false, { 1565, 407, 0x21243a }, },
        { false, false, false, { 232, 521, 0x19718c }, false, false, false, false, false, false, false, { 1588, 521, 0x000000 }, },
        { false, false, false, { 203, 644, 0x197d8c }, false, false, false, false, false, false, false, { 1613, 644, 0x000000 }, },
        { false, false, false, { 171, 778, 0x29798c }, false, false, false, false, false, false, false, { 1641, 778, 0x000000 }, },
        { false, false, false, { 136, 924, 0x427184 }, false, false, false, false, false, false, false, { 1671, 924, 0x313531 }, },
      },
      pointMap = {},
    },
    {
      leftTop = nil,
      rightTop = { 1551, 266 },
      leftBottom = nil,
      rightBottom = nil,
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的
      positionMap = {
        false,
        { false, false, false, { 218, 375, 0x19718c }, false, false, false, false, false, false, false, { 1574, 375, 0x000000 }, },
        { false, false, false, { 188, 492, 0x218194 }, false, false, false, false, false, false, false, { 1599, 492, 0x000000 }, },
        { false, false, false, { 154, 620, 0xefbe5a }, false, false, false, false, false, false, false, { 1626, 620, 0x000000 }, },
        { false, false, false, { 120, 759, 0x21656b }, false, false, false, false, false, false, false, { 1655, 759, 0x000000 }, },
        { false, false, false, { 80, 911, 0x31595a }, false, false, false, false, false, false, false, { 1687, 911, 0x000000 }, },
      },
      pointMap = {},
    },
    {
      leftTop = { 375, 274 },
      rightTop = nil,
      leftBottom = nil,
      rightBottom = nil,
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的
      positionMap = {
        false,
        { { 353, 383, 0x000000 }, false, false, false, false, false, false, false, { 1705, 383, 0x21818c }, },
        { { 328, 501, 0x000000 }, false, false, false, false, false, false, false, { 1735, 501, 0x197594 }, },
        { { 302, 629, 0x000000 }, false, false, false, false, false, false, false, { 1768, 629, 0x19798c }, },
        { { 273, 768, 0x000000 }, false, false, false, false, false, false, false, { 1804, 768, 0x215d8c }, },
        { { 241, 921, 0x000000 }, false, false, false, false, false, false, false, { 1842, 921, 0x293942 }, },
      },
      pointMap = {},
    },
    {
      leftTop = nil,
      rightTop = nil,
      leftBottom = { 208, 904 },
      rightBottom = nil,
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的
      positionMap = {
        false, false, false, false,
        { { 341, 296, 0x000000 }, false, false, false, false, false, false, { 1681, 296, 0x194d7b }, },
        { { 313, 426, 0x000000 }, false, false, false, false, false, false, { 1715, 426, 0x19497b }, },
        { { 281, 569, 0x100000 }, false, false, false, false, false, false, { 1751, 569, 0x10497b }, },
        { { 247, 727, 0x290000 }, false, false, false, false, false, false, { 1791, 727, 0x193d7b }, },
        { { 208, 904, 0x100000 }, false, false, false, false, false, false, { 1837, 904, 0x000000 }, },
      },
      pointMap = {},
    },
    {
      leftTop = nil,
      rightTop = nil,
      leftBottom = nil,
      rightBottom = { 1615, 904 },
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的
      positionMap = {
        false, false, false, false,
        { false, false, false, false, { 347, 296, 0x08597b }, false, false, false, false, false, { 1499, 296, 0x000000 }, },
        { false, false, false, false, { 319, 425, 0x21ae52 }, false, false, false, false, false, { 1524, 426, 0x000000 }, },
        { false, false, false, false, { 286, 569, 0x191819 }, false, false, false, false, false, { 1551, 569, 0x000000 }, },
        { false, false, false, false, { 252, 727, 0x7b8184 }, false, false, false, false, false, { 1582, 727, 0x000000 }, },
        { false, false, false, false, { 216, 904, 0x000000 }, false, false, false, false, false, { 1615, 904, 0x000000 }, },
      },
      pointMap = {},
    },
  })
  return list
end

-- 获取地图棋盘和相关数据
mapEvent.getMapChessboard = function()
  return {
    width = 11,
    height = 8,
    obstacle = {
      { 1, 6 }, { 1, 7 }, { 1, 8 }, { 1, 11 },
      { 2, 2 }, { 2, 7 }, { 2, 8 }, { 2, 11 },
      { 4, 1 }, { 4, 4 }, { 4, 5 }, { 4, 9 }, { 4, 10 },
      { 5, 1 }, { 5, 10 },
      { 6, 1 }, { 6, 8 },
      { 8, 7 }, { 8, 8 }, { 8, 9 },
    },
    waitForBossPosition = { { 1, 1 }, { 1, 2 }, { 1, 9 }, { 1, 10 }, },
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