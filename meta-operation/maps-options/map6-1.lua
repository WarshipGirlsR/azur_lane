local mapBase = require './map'
local imgEvent = require './img6-1'
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
      rightTop = { 1685, 483 },
      leftBottom = nil,
      rightBottom = nil,
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的
      positionMap = {
        { { 332, 483, 0x101c21 }, { 500, 483, 0x111c21 }, { 669, 483, 0x5a4921 }, { 838, 483, 0x192029 }, { 1008, 483, 0x192031 }, { 1177, 483, 0x21243a }, { 1346, 483, 0x192431 }, { 1515, 483, 0x212431 }, { 1685, 483, 0x293142 }, },
        { { 306, 605, 0x191000 }, { 481, 605, 0x211c42 }, { 658, 605, 0x191831 }, { 834, 605, 0x191831 }, { 1010, 605, 0x211c3a }, { 1186, 605, 0x191c31 }, { 1362, 605, 0x192042 }, { 1538, 605, 0x29284a }, { 1715, 605, 0x000000 }, },
        { { 278, 738, 0x000000 }, { 461, 738, 0x211831 }, { 645, 738, 0x21183a }, { 828, 738, 0x212042 }, { 1010, 738, 0x31456b }, { 1195, 738, 0x211831 }, { 1379, 738, 0x211c31 }, { 1563, 738, 0x292042 }, { 1747, 738, 0x000000 }, },
        { { 248, 882, 0x000000 }, { 439, 882, 0x21183a }, { 631, 882, 0x21183a }, { 823, 882, 0x191831 }, { 1014, 882, 0x211c3a }, { 1206, 882, 0x211c3a }, { 1397, 882, 0x211831 }, { 1589, 882, 0x211c3a }, { 1782, 882, 0x000000 }, },
      },
      pointMap = {},
    },
    {
      leftTop = nil,
      rightTop = nil,
      leftBottom = { 450, 886 },
      rightBottom = nil,
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的
      positionMap = {
        false, false, false,
        { { 494, 584, 0x000000 }, { 685, 584, 0x21183a }, { 877, 584, 0x21183a }, { 1069, 584, 0x191831 }, { 1261, 584, 0x191831 }, },
        { { 472, 727, 0x000000 }, { 674, 727, 0x4a3d10 }, { 873, 727, 0x211c3a }, { 1074, 727, 0x191429 }, { 1273, 727, 0x191831 }, },
        { { 450, 886, 0x000000 }, { 658, 886, 0x000000 }, { 868, 886, 0x000000 }, { 1079, 886, 0x000000 }, { 1289, 886, 0x000000 }, },
      },
      pointMap = {},
    },
    {
      leftTop = nil,
      rightTop = nil,
      leftBottom = nil,
      rightBottom = { 1711, 885 },
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的
      positionMap = {
        false, false, false,
        { false, false, false, false, { 877, 582, 0x191829 }, { 1069, 582, 0x211831 }, { 1260, 582, 0x21203a }, { 1452, 582, 0x292042 }, { 1645, 582, 0x000000 }, },
        { false, false, false, false, { 874, 725, 0x101021 }, { 1073, 725, 0x211c31 }, { 1274, 725, 0x191829 }, { 1474, 725, 0x191831 }, { 1676, 725, 0x000000 }, },
        { false, false, false, false, { 869, 885, 0x000000 }, { 1079, 885, 0x000000 }, { 1290, 885, 0x000000 }, { 1499, 885, 0x000000 }, { 1711, 885, 0x000000 }, },
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
    height = 5,
    obstacle = {
      { 4, 1 }, { 4, 2 },
      { 5, 1 }, { 5, 2 }, { 5, 6 },
    },
    waitForBossPosition = { { 1, 2 }, { 5, 5 }, { 5, 8 } },
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