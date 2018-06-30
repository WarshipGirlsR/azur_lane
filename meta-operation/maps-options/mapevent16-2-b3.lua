local mapBase = require './map'
local imgEvent = require './imgevent16-2-b3'
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
      rightTop = { 1583, 522 },
      leftBotton = nil,
      rightBotton = nil,
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的
      positionMap = {
        { { 442, 522, 0x522042 }, { 604, 522, 0x211829 }, { 767, 522, 0x291c42 }, { 930, 522, 0x211842 }, { 1093, 522, 0x191019 }, { 1256, 522, 0x31283a }, { 1419, 522, 0x292031 }, { 1583, 522, 0x31283a }, },
        { { 422, 641, 0x000000 }, { 591, 641, 0x21143a }, { 759, 641, 0x291c42 }, { 929, 641, 0x291c42 }, { 1098, 641, 0x19183a }, { 1267, 641, 0x29204a }, { 1436, 641, 0x292042 }, { 1607, 641, 0x000000 }, },
        { { 400, 769, 0x000000 }, { 575, 769, 0x211c3a }, { 751, 769, 0x19183a }, { 927, 769, 0x19183a }, { 1103, 769, 0x19143a }, { 1279, 769, 0x19183a }, { 1455, 769, 0x291c42 }, { 1634, 769, 0x000000 }, },
        { { 377, 908, 0x000000 }, { 559, 908, 0x21183a }, { 742, 908, 0x212042 }, { 926, 908, 0x211842 }, { 1110, 908, 0x21143a }, { 1293, 908, 0x211431 }, { 1476, 908, 0x211842 }, { 1662, 908, 0x000000 }, },
      },
      pointMap = {},
    }, {
      --      leftTop = { 432, 292 },
      leftTop = nil,
      rightTop = { 1573, 292 },
      leftBotton = nil,
      rightBotton = nil,
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的
      positionMap = {
        false, false, false,
        { { 365, 649, 0x000000 }, { 547, 649, 0x211c42 }, { 731, 649, 0x211c42 }, { 914, 649, 0x101031 }, { 1098, 649, 0x190c29 }, { 1281, 649, 0x29143a }, { 1464, 649, 0x191031 }, { 1650, 649, 0x000000 }, },
        { { 338, 790, 0x000000 }, { 529, 790, 0x191431 }, { 721, 790, 0x21183a }, { 1104, 790, 0x21183a }, { 1296, 790, 0x29183a }, { 1487, 790, 0x21183a }, { 1681, 790, 0x000000 }, },
        { { 310, 943, 0x000000 }, { 509, 943, 0x21183a }, { 710, 943, 0x191031 }, { 909, 943, 0x19143a }, { 1111, 943, 0x21143a }, { 1311, 943, 0x21183a }, { 1511, 943, 0x191421 }, { 1715, 943, 0x100c10 }, },
      },
      pointMap = {},
    }, {
      leftTop = nil,
      rightTop = nil,
      leftBotton = { 436, 952 },
      rightBotton = nil,
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的
      positionMap = {
        false, false, false, false, false,
        { { 509, 468, 0x000000 }, { 708, 468, 0x291c42 }, { 909, 468, 0x191431 }, { 1109, 468, 0x191431 }, { 1310, 468, 0x21143a }, },
        { { 487, 613, 0x000000 }, { 696, 613, 0x312029 }, { 906, 613, 0x100c29 }, { 1116, 613, 0x100c21 }, { 1326, 613, 0x5a5573 }, },
        { { 463, 772, 0x000000 }, { 682, 772, 0x291842 }, { 904, 772, 0x211042 }, { 1125, 772, 0x190829 }, { 1343, 772, 0x190c21 }, },
        { { 436, 952, 0x000000 }, { 668, 952, 0x000000 }, { 900, 952, 0x000000 }, { 1133, 952, 0x000000 }, { 1365, 951, 0x191019 }, },
      },
      pointMap = {},
    }, {
      leftTop = nil,
      rightTop = nil,
      leftBotton = nil,
      rightBotton = { 1716, 950 },
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的
      positionMap = {
        false, false, false, false, false,
        { false, false, false, false, { 1008, 466, 0x21143a }, { 1208, 466, 0x21183a }, { 1408, 466, 0x291842 }, { 1611, 466, 0x000000 }, },
        { false, false, false, false, { 1010, 611, 0x190c29 }, { 1220, 611, 0x190c29 }, { 1430, 611, 0x211431 }, { 1645, 611, 0xde8e4a }, },
        { false, false, false, false, { 1012, 771, 0x100821 }, { 1234, 771, 0x190c29 }, { 1454, 771, 0x190c29 }, { 1678, 771, 0x000000 }, },
        { false, false, false, false, { 1015, 950, 0x000000 }, { 1248, 950, 0x000000 }, { 1481, 950, 0x080c08 }, { 1716, 950, 0x101010 }, },
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
    width = 7,
    height = 8,
    obstacle = {
      { 1, 1 }, { 1, 7 },
      { 3, 2 }, { 3, 3 }, { 3, 4 },
      { 4, 2 }, { 4, 4 },
      { 6, 2 }, { 6, 3 }, { 6, 4 },
    },
    waitForBossPosition = { { 1, 4 } },
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
