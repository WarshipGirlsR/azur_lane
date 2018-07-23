local mapBase = require './map'
local imgEvent = require './img4-4'
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
      rightTop = { 1642, 501 },
      leftBottom = nil,
      rightBottom = nil,
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的
      positionMap = {
        { { 287, 501, 0x313131 }, { 455, 501, 0x423931 }, { 625, 501, 0x312829 }, { 794, 501, 0x292421 }, { 963, 501, 0x312429 }, { 1132, 501, 0x312410 }, { 1302, 501, 0x292421 }, { 1471, 501, 0x312429 }, { 1642, 501, 0x312821 }, },
        { { 260, 623, 0x000000 }, { 435, 623, 0x523d52 }, { 611, 623, 0x734d52 }, { 787, 623, 0x845d5a }, { 963, 623, 0x734d52 }, { 1139, 623, 0x73514a }, { 1315, 623, 0x7b5d4a }, { 1492, 623, 0x8c696b }, { 1670, 623, 0x000000 }, },
        { { 231, 756, 0x000000 }, { 413, 756, 0x4a3d52 }, { 597, 756, 0x5a414a }, { 780, 756, 0x634952 }, { 963, 756, 0x63494a }, { 1147, 756, 0x734942 }, { 1330, 756, 0x845952 }, { 1514, 756, 0x7b5552 }, { 1700, 756, 0x000000 }, },
        { { 199, 901, 0x000000 }, { 389, 901, 0x4a394a }, { 580, 901, 0x735152 }, { 772, 901, 0x3a3131 }, { 963, 901, 0x3a283a }, { 1155, 901, 0x4a353a }, { 1347, 901, 0x63494a }, { 1538, 901, 0x63453a }, { 1732, 901, 0x000000 }, },
      },
      pointMap = {},
    },
    {
      leftTop = nil,
      rightTop = nil,
      leftBottom = { 480, 893 },
      rightBottom = nil,
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的
      positionMap = {
        false, false, false,
        { { 544, 438, 0x000000 }, { 734, 438, 0x523552 }, { 926, 438, 0x845563 }, { 1118, 438, 0x4a3542 }, { 1309, 438, 0x312831 }, { 1501, 438, 0x4a313a }, },
        { { 525, 575, 0x000000 }, { 724, 575, 0x3a2d4a }, { 925, 575, 0x4a3952 }, { 1124, 575, 0x292431 }, { 1327, 575, 0x312431 }, { 1527, 575, 0x422431 }, },
        { { 504, 725, 0x000000 }, { 712, 725, 0x312842 }, { 922, 725, 0x31243a }, { 1133, 725, 0x312842 }, { 1343, 725, 0x312842 }, { 1554, 725, 0x191821 }, },
        { { 480, 893, 0x000000 }, { 700, 893, 0x000000 }, { 921, 893, 0x000000 }, { 1142, 893, 0x000000 }, { 1363, 893, 0x000000 }, { 1583, 893, 0x000000 }, },
      },
      pointMap = {},
    },
    {
      leftTop = nil,
      rightTop = nil,
      leftBottom = nil,
      rightBottom = { 1756, 894 },
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的
      positionMap = {
        false, false, false,
        { false, false, false, false, false, { 1073, 439, 0x4a353a }, { 1264, 439, 0x634142 }, { 1456, 439, 0x63453a }, { 1650, 439, 0x000000 }, },
        { false, false, false, false, false, { 1079, 576, 0x524d42 }, { 1279, 576, 0x523542 }, { 1479, 576, 0x734952 }, { 1685, 576, 0xf7c28c }, },
        { false, false, false, false, false, { 1084, 726, 0x29203a }, { 1294, 726, 0x3a243a }, { 1504, 726, 0x5a3542 }, { 1717, 726, 0x000000 }, },
        { false, false, false, false, false, { 1091, 894, 0x000000 }, { 1311, 894, 0x000000 }, { 1533, 894, 0x000000 }, { 1756, 894, 0x000000 }, },
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
      { 1, 1 }, { 1, 2 }, { 1, 7 }, { 1, 8 },
      { 2, 1 }, { 2, 2 }, { 2, 8 },
      { 3, 1 }, { 3, 2 },
      { 4, 1 }, { 4, 2 }, { 4, 5 },
      { 5, 1 }, { 5, 2 }, { 5, 5 },
    },
    waitForBossPosition = { { 1, 3 }, { 6, 1 } },
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