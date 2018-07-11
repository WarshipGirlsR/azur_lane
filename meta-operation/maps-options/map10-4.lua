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
      leftTop = { 427, 525 },
      rightTop = nil,
      leftBotton = nil,
      rightBotton = nil,
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的
      positionMap = {
        { { 427, 525, 0x314142 }, { 595, 525, 0x192831 }, { 764, 525, 0x21313a }, { 934, 525, 0x101819 }, { 1103, 525, 0x081019 }, { 1272, 525, 0x081021 }, },
        { { 405, 649, 0x000000 }, { 580, 649, 0x191431 }, { 756, 649, 0x191831 }, { 933, 649, 0x212042 }, { 1109, 649, 0x21244a }, { 1285, 649, 0x4a3d73 }, },
        { { 382, 783, 0x000000 }, { 564, 783, 0x101829 }, { 748, 783, 0x191831 }, { 932, 783, 0x191831 }, { 1115, 783, 0x292442 }, { 1298, 783, 0x5a5d8c }, },
        { { 357, 929, 0x000000 }, { 547, 929, 0x5a555a }, { 738, 929, 0x191831 }, { 930, 929, 0x191829 }, { 1122, 929, 0x191429 }, { 1313, 929, 0x211c3a }, },
      },
      pointMap = {},
    },
    {
      leftTop = nil,
      rightTop = { 1553, 519 },
      leftBotton = nil,
      rightBotton = nil,
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的
      positionMap = {
        { false, false, false, false, false, { 874, 519, 0x101c29 }, { 1044, 519, 0x000c10 }, { 1213, 519, 0x081419 }, { 1382, 519, 0x081419 }, { 1553, 519, 0x101421 }, },
        { false, false, false, false, false, { 871, 642, 0x292442 }, { 1047, 642, 0x292042 }, { 1223, 642, 0x29284a }, { 1399, 642, 0x42356b }, { 1581, 642, 0x3a3573 }, },
        { false, false, false, false, false, { 867, 776, 0x525184 }, { 1051, 776, 0x212042 }, { 1234, 776, 0x292042 }, { 1418, 776, 0x312852 }, { 1603, 776, 0x000000 }, },
        { false, false, false, false, false, { 863, 922, 0x211831 }, { 1055, 922, 0x211831 }, { 1246, 922, 0x292042 }, { 1438, 922, 0x211821 }, { 1632, 922, 0x212021 }, },
      },
      pointMap = {},
    },
    {
      leftTop = nil,
      rightTop = nil,
      leftBotton = { 308, 966 },
      rightBotton = nil,
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的
      positionMap = {
        false, false, false,
        { { 394, 501, 0x000000 }, { 586, 501, 0x191819 }, { 776, 501, 0x191831 }, { 968, 501, 0x191831 }, { 1159, 501, 0x211c3a }, { 1351, 501, 0x211c3a }, },
        { { 366, 641, 0xdee7de }, { 566, 641, 0xffffff }, { 968, 641, 0x191831 }, { 969, 641, 0x211c3a }, { 1169, 641, 0x211c31 }, { 1370, 641, 0x191429 }, },
        { { 340, 794, 0x000000 }, { 548, 794, 0x211c42 }, { 759, 794, 0x211831 }, { 968, 794, 0x211c3a }, { 1179, 794, 0x191831 }, { 1389, 794, 0x191829 }, },
        { { 308, 966, 0x000000 }, { 527, 966, 0x000000 }, { 748, 966, 0x000000 }, { 969, 966, 0x000000 }, { 1190, 966, 0x080408 }, { 1410, 966, 0x524d52 }, },
      },
      pointMap = {},
    },
    {
      leftTop = nil,
      rightTop = nil,
      leftBotton = nil,
      rightBotton = { 1761, 940 },
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点 1761, 940的时候自动加上的
      positionMap = {
        false, false, false,
        { false, false, false, false, false, { 884, 479, 0x191429 }, { 1076, 479, 0x191831 }, { 1267, 479, 0x29203a }, { 1459, 479, 0x292042 }, { 1653, 479, 0x000000 }, },
        { false, false, false, false, false, { 881, 618, 0x191829 }, { 1082, 618, 0x212042 }, { 1282, 618, 0x212042 }, { 1482, 618, 0x292042 }, { 1685, 618, 0x000000 }, },
        { false, false, false, false, false, { 878, 770, 0x211c42 }, { 1087, 770, 0x191831 }, { 1297, 770, 0x211831 }, { 1508, 770, 0x211c3a }, { 1720, 770, 0x000000 }, },
        { false, false, false, false, false, { 873, 940, 0x000000 }, { 1094, 940, 0x000000 }, { 1315, 940, 0x000000 }, { 1536, 940, 0x101010 }, { 1761, 940, 0x100c10 }, },
      },
      {
        leftTop = nil,
        rightTop = nil,
        leftBotton = nil,
        -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点 1761, 940的时候自动加上的
        rightBotton = { 1761, 940 },
        positionMap = {
          false, false, false,
          { false, false, false, false, false, { 884, 479, 0x191429 }, { 1076, 479, 0x191831 }, { 1267, 479, 0x29203a }, { 1459, 479, 0x292042 }, { 1653, 479, 0x000000 }, },
          { false, false, false, false, false, { 881, 618, 0x191829 }, { 1082, 618, 0x212042 }, { 1282, 618, 0x212042 }, { 1482, 618, 0x292042 }, { 1685, 618, 0x000000 }, },
          { false, false, false, false, false, { 878, 770, 0x211c42 }, { 1087, 770, 0x191831 }, { 1297, 770, 0x211831 }, { 1508, 770, 0x211c3a }, { 1720, 770, 0x000000 }, },
          { false, false, false, false, false, { 873, 940, 0x000000 }, { 1094, 940, 0x000000 }, { 1315, 940, 0x000000 }, { 1536, 940, 0x101010 }, { 1761, 940, 0x100c10 }, },
        },
        pointMap = {},
      },
    }
  })
  return list
end

-- 获取地图棋盘和相关数据
mapEvent.getMapChessboard = function()
  return {
    width = 9,
    height = 6,
    obstacle = {
      { 1, 5 }, { 1, 8 }, { 1, 9 },
      { 2, 3 }, { 2, 5 }, { 2, 9 },
      { 3, 6 },
      { 4, 1 }, { 4, 2 }, { 4, 3 }, { 4, 8 },
      { 5, 6 },
      { 6, 6 },
    },
    waitForBossPosition = { { 1, 6 } },
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