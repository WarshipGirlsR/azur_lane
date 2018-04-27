local mapBase = require './map'
local imgEvent = require './img11-1'
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
      leftTop = { 577, 527 },
      rightTop = nil,
      leftBotton = nil,
      rightBotton = nil,
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的
      positionMap = {
        { { 577, 527, 0x101419 }, { 745, 527, 0x101419 }, { 915, 527, 0x29243a }, { 1084, 527, 0x101821 }, { 1253, 527, 0x192031 }, { 1422, 527, 0x212431 }, },
        { { 562, 650, 0x000000 }, { 737, 650, 0x191831 }, { 913, 650, 0x21183a }, { 1089, 650, 0x21203a }, { 1265, 650, 0x21203a }, { 1441, 650, 0x212042 }, },
        { { 545, 784, 0x000000 }, { 727, 784, 0x191831 }, { 911, 784, 0x21203a }, { 1094, 784, 0x212042 }, { 1278, 784, 0x292442 }, { 1461, 784, 0x292042 }, },
        { { 527, 931, 0x000000 }, { 717, 931, 0xffffff }, { 908, 931, 0x191831 }, { 1100, 931, 0x191429 }, { 1292, 931, 0x8c7d9c }, { 1483, 931, 0x191421 }, },
      },
      pointMap = {},
    },
    {
      leftTop = nil,
      rightTop = { 1584, 542 },
      leftBotton = nil,
      rightBotton = nil,
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的
      positionMap = {
        { false, false, false, false, { 904, 542, 0x212031 }, { 1074, 542, 0x212031 }, { 1243, 542, 0x191c31 }, { 1412, 542, 0x3a414a }, { 1584, 542, 0x211c31 }, },
        { false, false, false, false, { 902, 666, 0x292042 }, { 1078, 666, 0x292442 }, { 1254, 666, 0x292852 }, { 1431, 666, 0x31315a }, { 1609, 666, 0x000000 }, },
        { false, false, false, false, { 900, 801, 0x211c3a }, { 1083, 801, 0x292042 }, { 1267, 801, 0x31284a }, { 1451, 801, 0x31244a }, { 1636, 801, 0x000000 }, },
        { false, false, false, false, { 894, 948, 0x4a4173 }, { 1089, 948, 0x211831 }, { 1280, 948, 0x292042 }, { 1472, 948, 0x211821 }, { 1666, 948, 0x101010 }, },
      },
      pointMap = {},
    },
    {
      leftTop = nil,
      rightTop = nil,
      leftBotton = { 415, 995 },
      rightBotton = nil,
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的
      positionMap = {
        false, false, false,
        { { 483, 527, 0x3a3d4a }, { 677, 527, 0x525d6b }, { 869, 527, 0x191c3a }, { 1061, 527, 0x211c3a }, { 1254, 527, 0x63618c }, },
        { { 466, 668, 0x000000 }, { 664, 668, 0x211c42 }, { 867, 668, 0x212021 }, { 1065, 668, 0x191831 }, { 1266, 668, 0x212042 }, },
        { { 441, 823, 0x000000 }, { 650, 823, 0x191431 }, { 860, 823, 0x191431 }, { 1070, 823, 0x191429 }, { 1281, 823, 0x191831 }, },
        { { 415, 995, 0x000000 }, { 634, 995, 0x000000 }, { 855, 995, 0x000000 }, { 1073, 995, 0xbd0000 }, { 1297, 995, 0x424142 }, },
      },
      pointMap = {},
    },
    {
      leftTop = nil,
      rightTop = nil,
      leftBotton = nil,
      rightBotton = { 1550, 953 },
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的
      positionMap = {
        false, false, false,
        { false, false, false, false, { 701, 490, 0x291c3a }, { 893, 490, 0x211829 }, { 1084, 490, 0x292042 }, { 1276, 490, 0x292042 }, { 1470, 490, 0x000000 }, },
        { false, false, false, false, { 689, 629, 0x3a2d31 }, { 889, 629, 0x211c31 }, { 1090, 629, 0x191829 }, { 1290, 629, 0x191831 }, { 1493, 629, 0x000000 }, },
        { false, false, false, false, { 676, 782, 0x211c3a }, { 886, 782, 0x211c42 }, { 1096, 782, 0x21203a }, { 1307, 782, 0x211831 }, { 1519, 782, 0x000000 }, },
        { false, false, false, false, { 661, 953, 0x000000 }, { 882, 953, 0x000000 }, { 1103, 953, 0x000000 }, { 1324, 953, 0x080c08 }, { 1550, 953, 0x080c08 }, },
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
    width = 8,
    height = 6,
    obstacle = {
      { 2, 6 }, { 2, 7 },
      { 3, 1 }, { 3, 4 }, { 3, 7 },
      { 4, 3 }, { 4, 4 },
      { 5, 8 },
      { 6, 5 }, { 6, 8 },
    },
    waitForBossPosition = { { 1, 8 } },
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