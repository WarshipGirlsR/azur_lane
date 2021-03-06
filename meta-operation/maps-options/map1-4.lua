local mapBase = require './map'
local imgEvent = require './img1-4'
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
      rightTop = nil,
      leftBottom = { 262, 902 },
      rightBottom = nil,
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的
      positionMap = {
        { { 350, 466, 0x3a4952 }, { 533, 466, 0x19283a }, { 717, 466, 0x4a4542 }, { 900, 466, 0x314531 }, { 1084, 466, 0x21394a }, { 1267, 466, 0x213931 }, { 1451, 466, 0x314531 }, { 1635, 466, 0x213542 }, },
        { { 323, 598, 0x000000 }, { 514, 598, 0x31868c }, { 707, 598, 0x293121 }, { 898, 598, 0x218194 }, { 1089, 598, 0x216d8c }, { 1280, 598, 0x8c868c }, { 1472, 598, 0x4a8a73 }, { 1665, 598, 0x000000 }, },
        { { 293, 742, 0x000000 }, { 492, 742, 0x3a616b }, { 694, 742, 0x297194 }, { 895, 742, 0x08557b }, { 1095, 742, 0x084d7b }, { 1296, 742, 0x295184 }, { 1496, 742, 0x526d9c }, { 1698, 742, 0x000000 }, },
        { { 262, 902, 0x000000 }, { 471, 902, 0x000000 }, { 681, 902, 0x000000 }, { 892, 902, 0x000000 }, { 1102, 902, 0x000000 }, { 1312, 902, 0x000000 }, { 1522, 902, 0x000000 }, { 1733, 902, 0x000000 }, },
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
    height = 3,
    obstacle = {
      { 1, 5 }, { 1, 6 }, { 1, 7 },
      { 2, 6 }, { 2, 7 },
      { 2, 1 }, { 2, 2 }, { 3, 1 }, { 3, 2 }, { 3, 3 },
    },
    waitForBossPosition = { { 3, 7 } },
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