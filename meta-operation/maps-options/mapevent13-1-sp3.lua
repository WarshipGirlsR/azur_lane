local mapBase = require './map'
local imgEvent = require './imgevent13-1-sp3'
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
      leftTop = { 433, 531 },
      rightTop = nil,
      leftBotton = nil,
      rightBotton = nil,
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的
      positionMap = {
        { { 433, 531, 0x193942 }, { 595, 531, 0x213d4a }, { 758, 531, 0x193942 }, { 1084, 531, 0x193542 }, { 1247, 531, 0x19394a }, },
        { { 413, 650, 0x000000 }, { 581, 650, 0x19718c }, { 750, 650, 0x21759c }, { 919, 650, 0x298194 }, { 1089, 650, 0x217d8c }, { 1258, 650, 0x217994 }, },
        { { 390, 778, 0x634d10 }, { 566, 778, 0x297d94 }, { 742, 778, 0x4a92ad }, { 918, 778, 0x218194 }, { 1094, 778, 0x217d94 }, { 1270, 778, 0x216d8c }, },
        { { 367, 918, 0x000000 }, { 550, 918, 0xefa610 }, { 732, 918, 0x218194 }, { 916, 918, 0x424142 }, { 1099, 918, 0x086d84 }, { 1283, 918, 0x08597b }, },
      },
      pointMap = {},
    }, {
      leftTop = nil,
      rightTop = { 1571, 529 },
      leftBotton = nil,
      rightBotton = nil,
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的
      positionMap = {
        { false, false, false, false, false, { 918, 529, 0x193542 }, { 1081, 529, 0x21394a }, { 1244, 529, 0x193542 }, { 1407, 529, 0x193d4a }, { 1571, 529, 0x193d4a }, },
        { false, false, false, false, false, { 916, 647, 0x197584 }, { 1085, 647, 0x217d8c }, { 1254, 647, 0x318a9c }, { 1424, 647, 0x197984 }, { 1595, 647, 0x000000 }, },
        { false, false, false, false, false, { 914, 776, 0x216d8c }, { 1090, 776, 0x21698c }, { 1267, 776, 0x10718c }, { 1443, 776, 0x217d8c }, { 1621, 776, 0x000000 }, },
        { false, false, false, false, false, { 912, 916, 0x214d84 }, { 1096, 916, 0x21618c }, { 1280, 916, 0x216d8c }, { 1463, 916, 0x102d31 }, { 1649, 916, 0x100c10 }, },
      },
      pointMap = {},
    }, {
      leftTop = { 375, 398 },
      rightTop = nil,
      leftBotton = nil,
      rightBotton = nil,
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的
      positionMap = {
        false, false, false,
        { { 301, 769, 0x000000 }, { 483, 769, 0xe6a600 }, { 666, 769, 0x197984 }, { 850, 769, 0x292d29 }, { 1033, 769, 0x196d84 }, { 1217, 769, 0x215984 }, { 1400, 769, 0x195984 }, { 1584, 769, 0x19698c }, },
        { { 271, 915, 0x000000 }, { 462, 915, 0x19698c }, { 653, 915, 0x217194 }, { 845, 915, 0x106d8c }, { 1036, 915, 0x004d6b }, { 1420, 915, 0x102029 }, { 1611, 915, 0x192d3a }, { 1611, 915, 0x192d3a }, },
      },
      pointMap = {},
    }, {
      leftTop = nil,
      rightTop = nil,
      leftBotton = { 355, 949 },
      rightBotton = nil,
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的
      positionMap = {
        false, false, false, false,
        { { 436, 486, 0x000000 }, { 626, 486, 0x297194 }, { 817, 486, 0x195d73 }, { 1009, 486, 0x086173 }, { 1201, 486, 0x004d73 }, },
        { { 411, 626, 0x000000 }, { 611, 626, 0x000400 }, { 811, 626, 0x296594 }, { 1011, 626, 0x10618c }, { 1212, 626, 0x215184 }, },
        { { 385, 778, 0x000000 }, { 593, 778, 0x19658c }, { 803, 778, 0x10557b }, { 1014, 778, 0x21618c }, { 1224, 778, 0x194d7b }, },
        { { 355, 949, 0x000000 }, { 575, 949, 0x000000 }, { 796, 949, 0x000000 }, { 1016, 949, 0x000000 }, { 1237, 949, 0x000000 }, },
      },
      pointMap = {},
    }, {
      leftTop = nil,
      rightTop = nil,
      leftBotton = nil,
      rightBotton = { 1510, 938 },
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的
      positionMap = {
        false, false, false, false,
        { false, false, false, false, { 476, 477, 0x004d73 }, { 859, 477, 0x19497b }, { 1051, 477, 0x216184 }, { 1051, 477, 0x216184 }, { 1243, 477, 0x63aae6 }, { 1438, 477, 0x211410 }, },
        { false, false, false, false, { 454, 615, 0x084d73 }, { 654, 615, 0x004173 }, { 854, 615, 0x194173 }, { 1055, 615, 0x294d84 }, { 1255, 615, 0x314d84 }, { 1459, 615, 0x000000 }, },
        { false, false, false, false, { 429, 767, 0x104d7b }, { 639, 767, 0x193d73 }, { 849, 767, 0x7ba2bd }, { 1059, 767, 0x21497b }, { 1270, 767, 0x21497b }, { 1483, 767, 0x000000 }, },
        { false, false, false, false, { 402, 938, 0x000000 }, { 623, 938, 0x000000 }, { 844, 938, 0x000000 }, { 1064, 938, 0x000000 }, { 1286, 938, 0x000000 }, { 1510, 938, 0x211821 }, },
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
      { 1, 4 }, { 1, 5 }, { 1, 8 },
      { 2, 2 },
      { 3, 5 }, { 3, 7 },
      { 4, 4 }, { 4, 8 }, { 4, 9 },
      { 5, 1 }, { 5, 8 }, { 5, 9 },
      { 6, 5 }, { 6, 6 },
      { 7, 3 },
    },
    waitForBossPosition = { { 1, 1 }, { 1, 9 }, { 3, 9 }, { 7, 1 } },
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
