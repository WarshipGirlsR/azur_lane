-- 光与影的鸢尾之华
local mapBase = require './map'
local imgEvent = require './imggyydywzh-a1'
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
      leftTop = { 668, 494 },
      rightTop = nil,
      leftBottom = nil,
      rightBottom = nil,
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的
      positionMap = {
        { { 668, 494, 0x314142 }, false, false, false, false, false, { 1691, 494, 0x3a3d42 }, },
        { { 655, 618, 0x000000 }, false, false, false, false, false, { 1724, 618, 0x3a616b }, },
        { { 640, 754, 0x000000 }, false, false, false, false, false, { 1760, 754, 0x427184 }, },
        { { 625, 903, 0x000000 }, false, false, false, false, false, { 1800, 903, 0x31616b }, },
      },
      pointMap = {},
    },
    {
      leftTop = nil,
      rightTop = { 1634, 497 },
      leftBottom = nil,
      rightBottom = nil,
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的
      positionMap = {
        { false, false, { 436, 497, 0x213142 }, false, false, false, false, false, false, { 1634, 497, 0x212831 }, },
        { false, false, { 413, 620, 0x426d73 }, false, false, false, false, false, false, { 1664, 620, 0x000000 }, },
        { false, false, { 387, 756, 0x295973 }, false, false, false, false, false, false, { 1697, 756, 0x000000 }, },
        { false, false, { 358, 905, 0x42797b }, false, false, false, false, false, false, { 1734, 905, 0x000000 }, },
      },
      pointMap = {},
    },
    {
      leftTop = nil,
      rightTop = nil,
      leftBottom = { 592, 904 },
      rightBottom = nil,
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的
      positionMap = {
        false,
        { { 659, 332, 0x000000 }, false, false, false, false, false, { 1728, 332, 0x426173 }, },
        { { 644, 454, 0x000000 }, false, false, false, false, false, { 1764, 454, 0x427184 }, },
        { { 629, 589, 0x000000 }, false, false, false, false, false, { 1805, 589, 0x3a697b }, },
        { { 611, 737, 0x000000 }, false, false, false, false, false, { 1848, 737, 0x31596b }, },
        { { 592, 904, 0x000000 }, false, false, false, false, false, { 1899, 904, 0x000000 }, }
      },
      pointMap = {},
    },
    {
      leftTop = nil,
      rightTop = nil,
      leftBottom = nil,
      rightBottom = { 1743, 904 },
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的
      positionMap = {
        false,
        { false, false, { 350, 332, 0x427584 }, false, false, false, false, false, false, { 1601, 332, 0x000000 }, },
        { false, false, { 321, 454, 0x31be6b }, false, false, false, false, false, false, { 1631, 454, 0x000000 }, },
        { false, false, { 290, 589, 0x292d4a }, false, false, false, false, false, false, { 1665, 589, 0x000000 }, },
        { false, false, { 252, 737, 0x292d42 }, false, false, false, false, false, false, { 1702, 737, 0x000000 }, },
        { false, false, { 215, 904, 0x000000 }, false, false, false, false, false, false, { 1743, 904, 0x000000 }, },
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
    height = 5,
    obstacle = {
      { 1, 3 }, { 1, 7 }, { 1, 8 },
      { 2, 8 },
      { 4, 5 },
      { 5, 5 },
    },
    waitForBossPosition = { { 1, 9 }, { 5, 9 }, { 5, 6 }, },
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