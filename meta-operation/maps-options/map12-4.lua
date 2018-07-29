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
  local list = mapBase.calCheckpositionList({})
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