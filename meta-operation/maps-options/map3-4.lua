local mapBase = require './map'
local imgEvent = require './img3-4'
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
      leftTop = { 290, 559 },
      rightTop = nil,
      leftBotton = nil,
      rightBotton = nil,
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的
      positionMap = {
        { { 290, 559, 0x19283a }, false, false, false, false, false, false, false, { 1758, 559, 0x10203a }, },
        { { 260, 695, 0x000000 }, false, false, false, false, false, false, false, { 1794, 695, 0x000000 }, },
        { { 228, 844, 0x000000 }, false, false, false, false, false, false, false, { 1833, 844, 0x000000 }, },
      },
      pointMap = {},
    },
    {
      leftTop = nil,
      rightTop = nil,
      leftBotton = { 363, 862 },
      rightBotton = nil,
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的
      positionMap = {
        false,
        false,
        { { 418, 547, 0x000000 }, false, false, false, { 1220, 547, 0x085173 }, },
        { { 391, 697, 0x000000 }, false, false, false, { 1233, 697, 0x21457b }, },
        { { 363, 862, 0x000000 }, false, false, false, { 1246, 862, 0x000000 }, },
      },
      pointMap = {},
    },
    {
      leftTop = nil,
      rightTop = nil,
      leftBotton = nil,
      rightBotton = { 1736, 856, },
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的
      positionMap = {
        false,
        false,
        { false, false, false, false, { 861, 542, 0x08597b }, false, false, false, { 1664, 542, 0x000000 }, },
        { false, false, false, false, { 857, 691, 0x10457b }, false, false, false, { 1699, 691, 0x000000 }, },
        { false, false, false, false, { 851, 856, 0x000000 }, false, false, false, { 1736, 856, 0x000000 }, },
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
    height = 4,
    obstacle = {
      { 1, 6 }, { 1, 7 }, { 1, 8 },
      { 2, 7 }, { 2, 8 },
      { 3, 1 },
    },
    waitForBossPosition = { { 3, 8 } },
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
