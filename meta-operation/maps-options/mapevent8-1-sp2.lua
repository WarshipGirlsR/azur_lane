local mapBase = require './map'
local imgEvent = require './imgevent8_1_sp2'
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
  local list = {
    {
      leftTop = nil,
      rightTop = { 1650, 523 },
      leftBotton = nil,
      rightBotton = nil,
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的
      positionMap = {
        { { 237, 523, 0x081019 }, { 392, 523, 0x101821 }, { 545, 523, 0xa4a284 }, { 707, 523, 0x100c19 }, { 864, 523, 0x000808 }, { 1021, 523, 0x080c10 }, { 1178, 523, 0x000808 }, { 1334, 523, 0x000808 }, { 1492, 523, 0x000808 }, { 1650, 523, 0x000808 }, },
        { { 203, 637, 0x424963 }, { 372, 637, 0x191429 }, { 535, 637, 0x211c3a }, { 699, 637, 0x3a3121 }, { 860, 637, 0x191c31 }, { 1023, 637, 0x292442 }, { 1186, 637, 0x19203a }, { 1348, 637, 0x212442 }, { 1511, 637, 0x3a355a }, { 1676, 637, 0x000000 }, },
        { { 162, 760, 0x63515a }, { 349, 760, 0x191831 }, { 518, 760, 0x212042 }, { 687, 760, 0x21203a }, { 856, 760, 0x31284a }, { 1025, 760, 0x292042 }, { 1194, 760, 0x292042 }, { 1363, 760, 0x211c3a }, { 1533, 760, 0x29284a }, { 1704, 760, 0x000000 }, },
        { { 132, 894, 0xb55d5a }, { 323, 894, 0xfffbff }, { 500, 894, 0x212042 }, { 676, 894, 0x211c42 }, { 851, 894, 0x313d42 }, { 1028, 894, 0x21203a }, { 1204, 894, 0x29244a }, { 1380, 894, 0x292042 }, { 1556, 894, 0x313052 }, { 1734, 894, 0x000000 }, },
      },
      pointMap = {},
    },
    {
      leftTop = { 539, 397 },
      rightTop = nil,
      leftBotton = nil,
      rightBotton = nil,
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的
      positionMap = {
        false, false, false,
        { { 488, 753, 0x000000 }, { 662, 753, 0x292829 }, { 839, 753, 0x191c3a }, { 1015, 753, 0x211c3a }, { 1192, 753, 0x212d31 }, { 1367, 753, 0x211c3a }, { 1544, 753, 0x212442 }, },
        { { 468, 891, 0x94555a }, { 649, 891, 0x4a454a }, { 834, 891, 0x191431 }, { 1018, 891, 0x191429 }, { 1202, 891, 0x42495a }, { 1385, 891, 0x191c31 }, { 1568, 891, 0x191429 }, },
      },
      pointMap = {},
    },
    {
      leftTop = nil,
      rightTop = { 1622, 400 },
      leftBotton = nil,
      rightBotton = nil,
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的
      positionMap = {
        false, false, false,
        { false, false, false, false, false, { 996, 756, 0x212042 }, { 1172, 756, 0x31244a }, { 1348, 756, 0x292042 }, { 1524, 756, 0x5a4d73 }, { 1702, 756, 0x000000 }, },
        { false, false, false, false, false, { 998, 895, 0x191429 }, { 1181, 895, 0x191c31 }, { 1365, 895, 0x291c3a }, { 1548, 895, 0x191c31 }, { 1734, 895, 0x000000 }, },
      },
      pointMap = {},
    },
    {
      leftTop = nil,
      rightTop = nil,
      leftBotton = { 325, 896 },
      rightBotton = nil,
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的
      positionMap = {
        false, false, false, false,
        { { 398, 459, 0xefefef }, { 587, 459, 0x191819 }, { 771, 459, 0x211c3a }, { 955, 459, 0x211c3a }, { 1139, 460, 0x425573 }, { 1322, 459, 0x191429 }, },
        { { 381, 591, 0x000000 }, { 572, 591, 0x191431 }, { 763, 591, 0x21183a }, { 954, 591, 0x191831 }, { 1146, 591, 0x191429 }, { 1338, 591, 0x191429 }, },
        { { 355, 736, 0x21183a }, { 553, 736, 0x291c31 }, { 754, 736, 0x211c3a }, { 955, 736, 0x191829 }, { 1155, 736, 0x191829 }, { 1355, 736, 0x191829 }, },
        { { 325, 896, 0x000000 }, { 534, 896, 0x000000 }, { 744, 896, 0x000000 }, { 954, 896, 0x000000 }, { 1165, 896, 0x000000 }, { 1375, 896, 0x000000 }, },
      },
      pointMap = {},
    },
    {
      leftTop = nil,
      rightTop = nil,
      leftBotton = nil,
      rightBotton = { 1709, 897 },
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的
      positionMap = {
        false, false, false, false,
        { false, false, false, false, false, { 877, 460, 0x191831 }, { 1061, 460, 0x191831 }, { 1244, 460, 0x292042 }, { 1428, 460, 0x292442 }, { 1613, 460, 0x000000 }, },
        { false, false, false, false, false, { 874, 593, 0x191421 }, { 1065, 593, 0x29203a }, { 1257, 593, 0x211c3a }, { 1449, 593, 0x21203a }, { 1642, 593, 0x100c08 }, },
        { false, false, false, false, false, { 870, 737, 0x101421 }, { 1070, 737, 0x191429 }, { 1270, 737, 0x191829 }, { 1474, 737, 0x213d4a }, { 1677, 737, 0x738663 }, },
        { false, false, false, false, false, { 866, 897, 0x000000 }, { 1075, 897, 0x000000 }, { 1285, 897, 0x000000 }, { 1496, 897, 0x000000 }, { 1709, 897, 0x000000 }, },
      },
      pointMap = {},
    },
  }
  for key = 1, #list do
    local positionMap = list[key].positionMap
    for rowNum, rol in ipairs(positionMap) do
      if rol and positionMap[rowNum + 1] then
        for colNum, col in ipairs(rol) do
          if col and rol[colNum + 1] then
            list[key].pointMap[rowNum .. '-' .. colNum] = col
          end
        end
      end
    end
  end
  return list
end

-- 获取地图棋盘和相关数据
mapEvent.getMapChessboard = function()
  return {
    width = 9,
    height = 7,
    obstacle = {
      { 1, 1 }, { 1, 2 }, { 1, 3 },
      { 2, 1 },
      { 3, 1 }, { 3, 7 },
      { 4, 4 }, { 4, 5 },
      { 5, 5 },
      { 6, 8 }, { 6, 9 },
      { 7, 1 }, { 7, 8 }, { 7, 9 },
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
