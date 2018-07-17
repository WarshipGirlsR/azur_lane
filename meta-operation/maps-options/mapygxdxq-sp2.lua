local mapBase = require './map'
local imgEvent = require './imgygxdxq-sp2'
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
      rightTop = { 1578, 538 },
      leftBotton = nil,
      rightBotton = nil,
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的
      positionMap = {
        { { 478, 538, 0x100c21 }, false, false, false, false, false, false, { 1578, 538, 0x101021 }, },
        { { 460, 653, 0x000000 }, false, false, false, false, false, false, { 1601, 653, 0x000000 }, },
        { { 441, 777, 0x000000 }, false, false, false, false, false, false, { 1626, 777, 0x000000 }, },
        { { 420, 911, 0x000000 }, false, false, false, false, false, false, { 1653, 911, 0x000000 }, },
      },
      pointMap = {},
    },
    {
      leftTop = nil,
      rightTop = { 1564, 293 },
      leftBotton = nil,
      rightBotton = nil,
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的
      positionMap = {
        false, false,
        { { 426, 513, 0x212042 }, false, false, false, false, false, false, { 1611, 513, 0x000000 }, },
        { { 404, 636, 0x000000 }, false, false, false, false, false, false, { 1637, 636, 0x000000 }, },
        { { 381, 769, 0x211c3a }, false, false, false, false, false, false, { 1666, 769, 0x000000 }, },
        { { 355, 915, 0x000000 }, false, false, false, false, false, false, { 1697, 915, 0x080c08 }, },
      },
      pointMap = {},
    },
    {
      leftTop = nil,
      rightTop = nil,
      leftBotton = nil,
      rightBotton = { 1768, 894 },
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的
      positionMap = {
        false, false, false, false,
        { { 381, 458, 0x211c3a }, false, false, false, false, false, false, { 1666, 458, 0x000000 }, },
        { { 355, 590, 0x000000 }, false, false, false, false, false, false, { 1697, 590, 0x000000 }, },
        { { 327, 734, 0x000000 }, false, false, false, false, false, false, { 1731, 734, 0x000000 }, },
        { { 296, 894, 0x000000 }, false, false, false, false, false, false, { 1769, 894, 0x000000 }, },
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
    height = 7,
    obstacle = {
      { 1, 1 }, { 1, 2 },
      { 2, 2 },
      { 3, 5 }, { 3, 6 }, { 3, 7 },
      { 4, 1 }, { 4, 2 }, { 4, 3 }, { 4, 8 },
      { 5, 3 }, { 5, 5 },
      { 6, 5 },
      { 7, 1 },
    },
    waitForBossPosition = { { 1, 7 }, { 4, 7 } },
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