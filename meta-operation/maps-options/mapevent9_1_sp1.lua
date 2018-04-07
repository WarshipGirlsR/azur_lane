local mapBase = require './map'
local imgEvent = require './imgevent9_1_sp1'
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
      leftTop = { 379, 538 },
      rightTop = nil,
      leftBotton = nil,
      rightBotton = nil,
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的
      positionMap = {
        { { 379, 538, 0x100c21 }, { 535, 538, 0x101031 }, { 692, 538, 0x212852 }, { 849, 538, 0x080c21 }, { 1006, 538, 0x101029 }, { 1163, 538, 0x101029 }, { 1320, 538, 0x293d5a }, { 1477, 538, 0x192042 }, { 1636, 538, 0x191431 }, },
        { { 357, 652, 0x000000 }, { 519, 652, 0x21245a }, { 682, 652, 0x4a3d63 }, { 845, 652, 0x312873 }, { 1007, 652, 0x292873 }, { 1170, 652, 0x3a316b }, { 1333, 652, 0x52558c }, { 1496, 652, 0x636dad }, { 1661, 652, 0x5a618c }, },
        { { 334, 776, 0x000000 }, { 501, 777, 0x292d29 }, { 671, 776, 0x292d73 }, { 840, 776, 0x42398c }, { 1009, 776, 0x313573 }, { 1178, 776, 0x3a3d84 }, { 1347, 776, 0x292d73 }, { 1517, 776, 0x312d73 }, { 1688, 776, 0x000000 }, },
        { { 309, 910, 0x000000 }, { 482, 910, 0x424142 }, { 659, 910, 0x313d7b }, { 835, 910, 0x313173 }, { 1011, 910, 0x313173 }, { 1187, 910, 0x3a3d84 }, { 1363, 910, 0x313173 }, { 1539, 910, 0x313173 }, { 1718, 910, 0x000000 }, },
      },
      pointMap = {},
    }, {
      leftTop = nil,
      rightTop = nil,
      leftBotton = { 543, 904 },
      rightBotton = nil,
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的
      positionMap = {
        false, false, false,
        { { 577, 624, 0x000000 }, { 752, 624, 0xffffff }, { 928, 624, 0x42418c }, { 1104, 624, 0x42358c }, { 1280, 624, 0x42398c }, { 1456, 624, 0x42418c }, { 1632, 624, 0x42398c }, },
        { { 560, 757, 0x848e8c }, { 742, 757, 0xefefef }, { 926, 757, 0x31316b }, { 1110, 757, 0x292d63 }, { 1293, 757, 0x312c73 }, { 1477, 757, 0x31317b }, { 1660, 757, 0x29286b }, },
        { { 543, 904, 0x000000 }, { 734, 904, 0x000000 }, { 925, 904, 0x000000 }, { 1117, 904, 0x000000 }, { 1309, 904, 0x000000 }, { 1500, 904, 0x000000 }, { 1691, 904, 0x000000 }, },
      },
      pointMap = {},
    }, {
      leftTop = nil,
      rightTop = nil,
      leftBotton = nil,
      rightBotton = { 1801, 900 },
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的
      positionMap = {
        false, false, false,
        { false, false, false, false, false, false, { 1378, 620, 0x3a3984 }, { 1554, 620, 0x3a3984 }, { 1733, 620, 0x000000 }, },
        { false, false, false, false, false, false, { 1396, 753, 0x292d6b }, { 1580, 753, 0x21286b }, { 1765, 753, 0x000000 }, },
        { false, false, false, false, false, false, { 1416, 900, 0x000000 }, { 1607, 900, 0x000000 }, { 1801, 900, 0x000000 }, },
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
      { 1, 1 }, { 1, 7 }, { 1, 8 },
      { 2, 1 }, { 2, 7 }, { 2, 8 },
      { 3, 5 },
      { 4, 4 },
      { 5, 3 }, { 5, 4 }, { 5, 5 },
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
