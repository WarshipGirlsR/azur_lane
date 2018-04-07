local mapBase = require './map'
local imgEvent = require './imgevent8_1_sp3'
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
      leftTop = { 451, 516 },
      rightTop = nil,
      leftBotton = nil,
      rightBotton = nil,
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的
      positionMap = {
        { { 451, 516, 0x192029 }, { 606, 516, 0x84ba8c }, { 763, 516, 0x081010 }, { 917, 516, 0x3a4d42 }, { 1074, 516, 0x8cba84 }, { 1233, 516, 0x080c19 }, { 1390, 516, 0x101419 }, { 1547, 516, 0x081010 }, },
        { { 429, 629, 0x29354a }, { 583, 629, 0x7b8194 }, { 755, 629, 0x29203a }, { 917, 629, 0x21203a }, { 1080, 629, 0x191c31 }, { 1243, 629, 0x212042 }, { 1405, 629, 0x292442 }, { 1569, 629, 0x29244a }, },
        { { 409, 753, 0x000000 }, { 577, 753, 0x211c3a }, { 746, 753, 0x191831 }, { 916, 753, 0x191831 }, { 1085, 753, 0x212442 }, { 1254, 753, 0x211c3a }, { 1423, 753, 0x292042 }, { 1592, 753, 0x21283a }, },
        { { 387, 886, 0x000000 }, { 562, 886, 0x211c42 }, { 738, 886, 0x212042 }, { 914, 886, 0x212442 }, { 1090, 886, 0x212042 }, { 1265, 886, 0xf7c28c }, { 1442, 886, 0x212042 }, { 1618, 886, 0x292042 }, },
      },
      pointMap = {},
    },
    {
      leftTop = nil,
      rightTop = { 1600, 514 },
      leftBotton = nil,
      rightBotton = nil,
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的
      positionMap = {
        { false, false, false, false, false, false, false, { 1122, 514, 0x101021 }, { 1279, 514, 0x080c19 }, { 1436, 514, 0x314952 }, { 1600, 514, 0x84ba8c }, },
        { false, false, false, false, false, false, false, { 1128, 627, 0x19203a }, { 1291, 627, 0x312d4a }, { 1453, 627, 0x3a3963 }, { 1618, 627, 0x101c31 }, },
        { false, false, false, false, false, false, false, { 1135, 750, 0x312842 }, { 1304, 750, 0x292042 }, { 1473, 750, 0x292852 }, { 1644, 750, 0x000000 }, },
        { false, false, false, false, false, false, false, { 1142, 883, 0x191831 }, { 1316, 883, 0x4a0000 }, { 1494, 883, 0x21203a }, { 1672, 883, 0x000000 }, },
      },
      pointMap = {},
    },
    {
      leftTop = { 389, 401 },
      rightTop = nil,
      leftBotton = nil,
      rightBotton = nil,
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的
      positionMap = {
        false, false, false,
        { { 320, 757, 0x000000 }, { 494, 757, 0x191431 }, { 670, 757, 0x191831 }, { 846, 757, 0x191c31 }, { 1022, 757, 0x191831 }, { 1022, 757, 0x191831 }, { 1198, 757, 0xffdb94 }, { 1375, 757, 0x211c31 }, },
        { { 292, 896, 0x000000 }, { 475, 896, 0x191831 }, { 659, 896, 0x191831 }, { 1025, 896, 0x52595a }, { 1210, 896, 0x5b554a }, { 1392, 896, 0x212042 }, { 1576, 896, 0x211c42 }, { 1672, 883, 0x000000 }, },
      },
      pointMap = {},
    },
    {
      leftTop = nil,
      rightTop = { 1612, 399 },
      leftBotton = nil,
      rightBotton = nil,
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的
      positionMap = {
        false, false, false,
        { false, false, false, false, false, false, false, { 1160, 755, 0x191831 }, { 1338, 755, 0x4a0400 }, { 1512, 755, 0x21203a }, { 1691, 755, 0x000000 }, },
        { false, false, false, false, false, false, false, { 1169, 894, 0x211831 }, { 1353, 894, 0x211c3a }, { 1536, 894, 0x292042 }, { 1722, 894, 0x000000 }, },
      },
      pointMap = {},
    },
    {
      leftTop = nil,
      rightTop = nil,
      leftBotton = { 296, 897 },
      rightBotton = nil,
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的
      positionMap = {
        false, false, false, false,
        { { 380, 460, 0x000000 }, { 563, 460, 0x191831 }, { 746, 460, 0x211c42 }, { 930, 460, 0x212042 }, { 1112, 460, 0x7b7d84 }, { 1300, 460, 0x9c8a84 }, { 1480, 460, 0x212042 }, },
        { { 355, 592, 0x000000 }, { 545, 592, 0x191831 }, { 736, 592, 0x211c42 }, { 928, 592, 0x211c42 }, { 1120, 592, 0x211c42 }, { 1311, 592, 0x52596b }, { 1503, 592, 0x191829 }, },
        { { 327, 737, 0x000000 }, { 526, 737, 0x191031 }, { 726, 737, 0x191429 }, { 927, 737, 0x21183a }, { 1127, 737, 0x191831 }, { 1127, 737, 0x191831 }, { 1328, 737, 0x191c3a }, },
        { { 296, 897, 0x000000 }, { 489, 897, 0x4a5d8c }, { 715, 897, 0x000000 }, { 925, 897, 0x000000 }, { 1136, 897, 0x000000 }, { 1346, 897, 0x000000 }, { 1556, 897, 0x000000 }, },
      },
      pointMap = {},
    },
    {
      leftTop = nil,
      rightTop = nil,
      leftBotton = nil,
      rightBotton = { 1769, 896 },
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的
      positionMap = {
        false, false, false, false,
        { false, false, false, false, false, false, { 930, 460, 0x21203a }, { 1113, 460, 0x211831 }, { 1297, 460, 0x3a3131 }, { 1481, 460, 0x292042 }, { 1666, 460, 0x000000 }, },
        { false, false, false, false, false, false, { 928, 592, 0x211c42 }, { 1120, 592, 0x212042 }, { 1312, 592, 0x212042 }, { 1504, 592, 0x292442 }, { 1697, 592, 0x000000 }, },
        { false, false, false, false, false, false, { 927, 736, 0x191829 }, { 1127, 736, 0x211831 }, { 1328, 736, 0x212042 }, { 1529, 736, 0x211831 }, { 1731, 736, 0x000000 }, },
        { false, false, false, false, false, false, { 926, 896, 0x000000 }, { 1136, 896, 0x000000 }, { 1346, 896, 0x000000 }, { 1556, 896, 0x000000 }, { 1769, 896, 0x000000 }, },
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
    width = 10,
    height = 7,
    obstacle = {
      { 1, 1 }, { 1, 2 }, { 1, 3 }, { 1, 4 }, { 1, 5 }, { 1, 9 }, { 1, 10 },
      { 2, 1 }, { 2, 2 }, { 2, 10 },
      { 3, 7 },
      { 4, 4 },
      { 5, 4 },
      { 6, 1 }, { 6, 6 },
      { 7, 1 }, { 7, 8 }, { 7, 9 }, { 7, 10 },
    },
    waitForBossPosition = { { 4, 7 } },
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
