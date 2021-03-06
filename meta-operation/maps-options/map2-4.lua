local mapBase = require './map'
local imgEvent = require './img2-4'
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
      leftTop = { 437, 493 },
      rightTop = nil,
      leftBottom = nil,
      rightBottom = nil,
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的
      positionMap = {
        { { 437, 493, 0x315152 }, { 614, 493, 0x213942 }, { 790, 493, 0x105d73 }, { 969, 493, 0x213d4a }, { 1146, 493, 0x193142 }, { 1324, 493, 0x212d3a }, { 1501, 493, 0x213142 }, { 1678, 493, 0x19283a }, },
        { { 416, 632, 0x000000 }, { 601, 632, 0x197994 }, { 785, 632, 0x197d8c }, { 969, 632, 0x197d94 }, { 1153, 632, 0x196d8c }, { 1338, 632, 0x217d9c }, { 1522, 632, 0x217d94 }, { 1707, 632, 0x000000 }, },
        { { 394, 783, 0x000000 }, { 586, 783, 0x19758c }, { 778, 783, 0x21798c }, { 969, 783, 0x105d84 }, { 1161, 783, 0x104d7b }, { 1353, 783, 0x215584 }, { 1544, 783, 0x197584 }, { 1737, 783, 0x000000 }, },
      },
      pointMap = {},
    },
    {
      leftTop = nil,
      rightTop = nil,
      leftBottom = { 341, 888 },
      rightBottom = nil,
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的
      positionMap = {
        false, false,
        { { 390, 565, 0x000000 }, { 581, 565, 0x21798c }, { 773, 565, 0x318194 }, { 965, 565, 0x215d84 }, { 1156, 565, 0x104d7b }, { 1348, 565, 0x195184 }, { 1539, 565, 0x217994 }, { 1732, 565, 0x000000 }, },
        { { 366, 720, 0x000000 }, { 567, 720, 0xdeae00 }, { 765, 720, 0x19698c }, { 965, 720, 0x104d73 }, { 1165, 720, 0x10497b }, { 1364, 720, 0x21518c }, { 1562, 716, 0xada6a4 }, { 1765, 720, 0x63a684 }, },
        { { 341, 888, 0x000000 }, { 548, 888, 0x000000 }, { 757, 888, 0x000000 }, { 965, 888, 0x000000 }, { 1173, 888, 0x000000 }, { 1382, 888, 0x000000 }, { 1590, 888, 0x000000 }, { 1799, 888, 0x000000 }, },
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
      { 1, 2 }, { 1, 3 }, { 1, 4 },
      { 3, 6 }, { 3, 7 }, { 4, 7 },
    },
    waitForBossPosition = { { 1, 7 } },
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