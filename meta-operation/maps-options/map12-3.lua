local mapBase = require './map'
local imgEvent = require './img12-3'
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
  local list = mapBase.calCheckpositionList({})
  return list
end

-- 获取地图棋盘和相关数据
mapEvent.getMapChessboard = function()
  return {
    width = 10,
    height = 7,
    obstacle = {
      { 1, 2 }, { 1, 3 }, { 1, 4 },
      { 2, 9 },
      { 3, 4 }, { 3, 8 }, { 3, 9 },
      { 4, 6 }, { 4, 7 },
      { 5, 10 },
      { 6, 1 }, { 6, 6 }, { 6, 10 },
      { 7, 1 },
    },
    waitForBossPosition = { { 1, 1 }, { 1, 6 }, { 2, 1 }, { 2, 10 }, { 4, 1 } },
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