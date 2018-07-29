local mapBase = require './map'
local imgEvent = require './img10-4'
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
      rightTop = { 1625, 529 },
      leftBottom = nil,
      rightBottom = nil,
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的
      positionMap = {
        { { 439, 529, 0x081019 }, { 608, 529, 0x081019 }, { 777, 529, 0x101421 }, { 946, 529, 0x101821 }, { 1115, 529, 0x21283a }, { 1285, 529, 0x192031 }, { 1454, 529, 0x101c29 }, { 1625, 529, 0x101c29 }, },
        { { 418, 653, 0x000000 }, { 593, 653, 0x211c3a }, { 769, 653, 0x211c3a }, { 949, 653, 0x313163 }, { 1121, 653, 0x292042 }, { 1298, 653, 0x19203a }, { 1474, 653, 0x29284a }, { 1652, 653, 0x000000 }, },
        { { 396, 787, 0x000000 }, { 580, 787, 0xdea608 }, { 762, 787, 0x191831 }, { 945, 787, 0x292442 }, { 1128, 787, 0x191831 }, { 1312, 787, 0x191831 }, { 1495, 787, 0x292042 }, { 1681, 787, 0x000000 }, },
        { { 371, 933, 0x000000 }, { 561, 933, 0x211c3a }, { 752, 933, 0x191831 }, { 944, 933, 0x191429 }, { 1136, 933, 0x191829 }, { 1328, 933, 0x31285a }, { 1519, 933, 0x212031 }, { 1713, 933, 0x313131 }, },
      },
      pointMap = {},
    },
    {
      leftTop = nil,
      rightTop = nil,
      leftBottom = nil,
      rightBottom = { 1805, 956 },
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的
      positionMap = {
        false, false, false,
        { { 349, 493, 0x000000 }, { 539, 493, 0x211c3a }, { 731, 493, 0x312d31 }, { 922, 493, 0x29243a }, { 1114, 493, 0x191829 }, { 1306, 493, 0x31285a }, { 1497, 493, 0x211c42 }, { 1691, 493, 0x000000 }, },
        { { 320, 632, 0x000000 }, { 520, 632, 0x424142 }, { 720, 632, 0x211c42 }, { 920, 632, 0x211c42 }, { 1121, 632, 0x191831 }, { 1321, 632, 0x211831 }, { 1522, 632, 0x212042 }, { 1725, 632, 0x000000 }, },
        { { 285, 785, 0x846952 }, { 498, 785, 0x191831 }, { 709, 785, 0x21183a }, { 918, 785, 0x191429 }, { 1128, 785, 0x191421 }, { 1339, 785, 0x211c3a }, { 1550, 785, 0x212031 }, { 1762, 785, 0x000000 }, },
        { { 255, 956, 0x000000 }, { 475, 956, 0x000000 }, { 696, 956, 0x000000 }, { 917, 956, 0x000000 }, { 1138, 956, 0x000000 }, { 1359, 956, 0x848a84 }, { 1580, 956, 0x101010 }, { 1805, 956, 0x847d84 }, },
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
    height = 6,
    obstacle = {
      { 1, 3 },
      { 2, 3 },
      { 3, 5 }, { 3, 6 },
      { 4, 6 },
      { 5, 3 },
      { 6, 3 }, { 6, 4 }, { 6, 7 },
    },
    waitForBossPosition = { { 2, 7 } },
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