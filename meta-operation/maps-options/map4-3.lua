local mapBase = require './map'
local imgEvent = require './img4-3'
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
      rightTop = { 1635, 594 },
      leftBotton = nil,
      rightBotton = nil,
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的
      positionMap = {
        { { 402, 594, 0x212031 }, { 577, 594, 0x191c29 }, { 754, 594, 0x31283a }, { 930, 594, 0x3a3129 }, { 1106, 594, 0x292031 }, { 1283, 594, 0xad8673 }, { 1459, 594, 0x424142 }, { 1635, 594, 0x212029 }, },
        { { 379, 725, 0x000000 }, { 562, 725, 0x4a354a }, { 745, 725, 0x6b4d52 }, { 929, 725, 0x6b4d52 }, { 1112, 725, 0x6b4542 }, { 1295, 725, 0x7b5552 }, { 1479, 725, 0x7b5d4a }, { 1665, 725, 0x000000 }, },
        { { 354, 869, 0x000000 }, { 544, 869, 0x423542 }, { 736, 869, 0x735152 }, { 927, 869, 0x3a313a }, { 1118, 869, 0x422831 }, { 1310, 869, 0x633d42 }, { 1502, 869, 0x846952 }, { 1696, 869, 0x000000 }, },
      },
      pointMap = {},
    },
    {
      leftTop = nil,
      rightTop = { 1591, 332 },
      leftBotton = nil,
      rightBotton = nil,
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的
      positionMap = {
        false, false,
        { { 305, 584, 0x000000 }, { 495, 584, 0x4a354a }, { 686, 584, 0x845d63 }, { 878, 584, 0x3a2d42 }, { 1070, 584, 0x523142 }, { 1261, 584, 0x633d42 }, { 1453, 584, 0x8c6d5a }, { 1647, 584, 0x000000 }, },
        { { 274, 728, 0x000000 }, { 473, 728, 0x84695a }, { 673, 728, 0x3a314a }, { 875, 728, 0x29243a }, { 1075, 728, 0x292031 }, { 1276, 728, 0x422d42 }, { 1475, 728, 0x6b4142 }, { 1679, 728, 0x212529 }, },
        { { 241, 888, 0x000000 }, { 450, 888, 0x000000 }, { 660, 888, 0x000000 }, { 871, 888, 0x000000 }, { 1080, 888, 0x000000 }, { 1289, 888, 0x000000 }, { 1291, 888, 0x000000 }, { 1502, 888, 0x000000 }, { 1714, 888, 0x000000 }, },
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
    height = 4,
    obstacle = {
      { 3, 1 }, { 3, 2 },
      { 4, 1 }, { 4, 2 },
    },
    waitForBossPosition = { { 1, 7 }, { 3, 6 }, { 4, 3 } },
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