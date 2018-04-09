local mapBase = require './map'
local imgEvent = require './img3-4'
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
      leftTop = { 290, 559 },
      rightTop = nil,
      leftBotton = nil,
      rightBotton = nil,
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的
      positionMap = {
        { { 290, 559, 0x19283a }, { 473, 559, 0x213d42 }, { 657, 559, 0x193142 }, { 840, 559, 0x193142 }, { 1024, 559, 0x213d4a }, { 1207, 559, 0x212442 }, { 1391, 559, 0x212842 }, { 1575, 559, 0x294152 }, { 1758, 559, 0x10203a }, },
        { { 260, 695, 0x000000 }, { 452, 695, 0x197984 }, { 643, 695, 0x298194 }, { 835, 695, 0x218194 }, { 1027, 695, 0x217184 }, { 1218, 695, 0x19718c }, { 1410, 693, 0xd6657b }, { 1602, 694, 0x427d7b }, { 1794, 695, 0x000000 }, },
        { { 228, 844, 0x000000 }, { 428, 844, 0x217d8c }, { 630, 844, 0xd6a608 }, { 829, 844, 0x106d84 }, { 1030, 844, 0x215984 }, { 1230, 844, 0x215184 }, { 1431, 844, 0x195d84 }, { 1631, 844, 0x19658c }, { 1833, 844, 0x000000 }, },
      },
      pointMap = {},
    },
    {
      leftTop = nil,
      rightTop = nil,
      leftBotton = { 363, 862 },
      rightBotton = nil,
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的
      positionMap = {
        false,
        false,
        { { 418, 547, 0x000000 }, { 618, 547, 0x19798c }, { 819, 547, 0x318194 }, { 1019, 547, 0x217184 }, { 1220, 547, 0x085173 }, },
        { { 391, 697, 0x000000 }, { 602, 697, 0x216184 }, { 812, 697, 0x19618c }, { 1022, 697, 0x08517b }, { 1233, 697, 0x21457b }, },
        { { 363, 862, 0x000000 }, { 583, 862, 0x000000 }, { 804, 862, 0x000000 }, { 1025, 862, 0x000000 }, { 1246, 862, 0x000000 }, },
      },
      pointMap = {},
    },
    {
      leftTop = nil,
      rightTop = nil,
      leftBotton = nil,
      rightBotton = { 1736, 856, },
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的
      positionMap = {
        false,
        false,
        { false, false, false, false, { 861, 542, 0x08597b }, { 1062, 542, 0x21518c }, { 1262, 542, 0x21618c }, { 1463, 542, 0x19658c }, { 1664, 542, 0x000000 }, },
        { false, false, false, false, { 857, 691, 0x10457b }, { 1067, 691, 0x214984 }, { 1277, 691, 0x214d7c }, { 1487, 691, 0x314d7b }, { 1699, 691, 0x000000 }, },
        { false, false, false, false, { 851, 856, 0x000000 }, { 1072, 856, 0x000000 }, { 1293, 856, 0x000000 }, { 1514, 856, 0x000000 }, { 1736, 856, 0x000000 }, },
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
    height = 4,
    obstacle = {
      { 1, 6 }, { 1, 7 }, { 1, 8 },
      { 2, 7 }, { 2, 8 },
      { 3, 1 },
    },
    waitForBossPosition = { { 3, 8 } },
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