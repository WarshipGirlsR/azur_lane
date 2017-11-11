local mapBase = require 'BaseOperate__maps__map'
local imgEvent = require 'BaseOperate__maps__img4_1'
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
      leftTop = { 561, 536 },
      rightTop = nil,
      leftBotton = nil,
      rightBotton = nil,
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的
      positionMap = {
        { { 561, 536, 0xa47508 }, { 729, 536, 0x3a3131 }, { 899, 536, 0x292429 }, { 1068, 536, 0x292431 }, { 1237, 536, 0x322d32 }, { 1407, 536, 0x3a3531 }, { 1576, 536, 0x213921 }, },
        { { 545, 660, 0x000000 }, { 720, 660, 0x73455a }, { 896, 660, 0x84595a }, { 1072, 660, 0x735152 }, { 1248, 660, 0x845d52 }, { 1424, 660, 0x846152 }, { 1603, 660, 0x000000 }, },
        { { 528, 795, 0x000000 }, { 710, 795, 0x423542 }, { 893, 795, 0x63494a }, { 1077, 795, 0x6b4d4a }, { 1260, 795, 0x6b5142 }, { 1444, 795, 0x634d42 }, { 1630, 795, 0x000000 }, },
        { { 509, 941, 0x000000 }, { 699, 941, 0x4a394a }, { 890, 941, 0x42353a }, { 1080, 941, 0x7b615a }, { 1274, 941, 0x4a353a }, { 1465, 941, 0x292021 }, { 1659, 941, 0x100c10 }, },
      },
      pointMap = {},
    },
    {
      leftTop = nil,
      rightTop = nil,
      leftBotton = { 438, 980 },
      rightBotton = nil,
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的
      positionMap = {
        false, false, false,
        { { 507, 513, 0x000000 }, { 697, 513, 0x52394a }, { 888, 513, 0x42353a }, { 1078, 514, 0x836963 }, { 1272, 513, 0x4a353a }, { 1463, 513, 0x734d4a }, { 1657, 513, 0x000000 }, },
        { { 486, 654, 0x000000 }, { 685, 654, 0x4a3152 }, { 885, 654, 0x3a3142 }, { 1086, 654, 0x3a243a }, { 1287, 654, 0x42283a }, { 1487, 654, 0x63414a }, { 1690, 654, 0x000000 }, },
        { { 463, 808, 0x000000 }, { 671, 808, 0x292842 }, { 881, 808, 0x31243a }, { 1092, 808, 0x3a2842 }, { 1302, 808, 0x3a203a }, { 1512, 808, 0x422d42 }, { 1725, 808, 0x000000 }, },
        { { 438, 980, 0x000000 }, { 658, 980, 0x000000 }, { 878, 980, 0x000000 }, { 1099, 980, 0x9c5d5a }, { 1325, 980, 0x424142 }, { 1541, 980, 0x191419 }, { 1768, 980, 0x846d73 }, },
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
    width = 6,
    height = 6,
    obstacle = {
      { 3, 3 }, { 3, 4 },
      { 4, 4 },
      { 6, 3 }, { 6, 4 }, { 6, 5 }, { 6, 6 },
    },
    waitForBossPosition = { { 4, 2 } },
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