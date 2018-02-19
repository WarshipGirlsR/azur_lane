local mapBase = require './map'
local imgEvent = require './img4-1'
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
      rightTop = { 1576, 536 },
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
      leftBotton = nil,
      rightBotton = { 1725, 889 },
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的
      positionMap = {
        false, false, false,
        { { 473, 434, 0x000000 }, { 663, 434, 0x312431 }, { 855, 434, 0x4a3542 }, { 1044, 434, 0x846963 }, { 1237, 434, 0x523942 }, { 1430, 434, 0x73514a }, { 1623, 434, 0x000000 }, },
        { { 450, 571, 0x000000 }, { 649, 571, 0x4a355a }, { 849, 571, 0x3a354a }, { 1050, 571, 0x212029 }, { 1250, 571, 0x3a2831 }, { 1451, 571, 0x6b414a }, { 1654, 571, 0x000000 }, },
        { { 425, 721, 0x000000 }, { 634, 721, 0x29243a }, { 844, 721, 0x292031 }, { 1054, 721, 0x212031 }, { 1264, 721, 0x211c29 }, { 1475, 721, 0x42283a }, { 1688, 721, 0x000000 }, },
        { { 398, 889, 0x000000 }, { 618, 889, 0x000000 }, { 838, 889, 0x000000 }, { 1059, 889, 0x000000 }, { 1281, 889, 0x000000 }, { 1501, 889, 0x000000 }, { 1725, 889, 0x000000 }, },
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
    waitForBossPosition = { { 4, 3 } },
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