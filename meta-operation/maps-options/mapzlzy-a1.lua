-- 光与影的鸢尾之华
local mapBase = require './map'
local imgEvent = require './imgzlzy-a1'
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
      rightTop = { 1631, 515 },
      leftBottom = nil,
      rightBottom = nil,
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的
      positionMap = {
        { { 373, 515, 0x100808 }, false, false, false, false, false, false, false, { 1631, 515, 0x522010 }, },
        { { 345, 630, 0x000000 }, false, false, false, false, false, false, false, { 1663, 630, 0x312421 }, },
        { { 314, 757, 0x000000 }, false, false, false, false, false, false, false, { 1698, 757, 0x000000 }, },
        { { 280, 897, 0x000000 }, false, false, false, false, false, false, false, { 1737, 897, 0x000000 }, }
      },
      pointMap = {},
    },
    {
      leftTop = nil,
      rightTop = nil,
      leftBottom = { 454, 930 },
      rightBottom = nil,
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的
      positionMap = {
        false, false, false,
        { { 534, 481, 0x000000 }, false, false, false, false, { 1443, 481, 0x632d31 }, },
        { { 511, 613, 0x000000 }, false, false, false, false, { 1470, 613, 0x4a2421 }, },
        { { 484, 761, 0x000000 }, false, false, false, false, { 1500, 761, 0x4a2021 }, },
        { { 454, 930, 0x000000 }, false, false, false, false, { 1534, 930, 0x101010 }, }
      },
      pointMap = {},
    },
    {
      leftTop = nil,
      rightTop = nil,
      leftBottom = nil,
      rightBottom = { 1827, 933 },
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的
      positionMap = {
        false, false, false,
        { false, false, { 594, 483, 0x73494a }, false, false, false, false, false, { 1688, 483, 0x000000 }, },
        { false, false, { 573, 616, 0x7b0810 }, false, false, false, false, false, { 1729, 616, 0x000000 }, },
        { false, false, { 550, 764, 0x6b3131 }, false, false, false, false, false, { 1775, 764, 0x000000 }, },
        { false, false, { 524, 933, 0x000000 }, false, false, false, false, false, { 1827, 933, 0x292829 }, }
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
      { 1, 1 }, { 1, 2 }, { 1, 3 }, { 1, 7 }, { 1, 8 },
      { 2, 5 }, { 2, 7 }, { 2, 8 },
      { 6, 4 },
    },
    waitForBossPosition = { { 6, 8 }, },
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