local mapBase = require './map'
local imgEvent = require './imgevent12-1-sp2'
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
      rightTop = { 1643, 528 },
      leftBotton = nil,
      rightBotton = nil,
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的
      positionMap = {
        { { 230, 528, 0x101419 }, { 386, 528, 0x191c21 }, { 540, 528, 0xb5ae8c }, { 699, 528, 0x080c10 }, { 1013, 528, 0x080c10 }, { 1013, 528, 0x080c10 }, { 1170, 528, 0x101019 }, { 1327, 528, 0x080c10 }, { 1484, 528, 0x101021 }, { 1643, 528, 0x080c10 }, },
        { { 193, 643, 0x424963 }, { 364, 643, 0x191429 }, { 527, 643, 0x211c3a }, { 690, 643, 0x312829 }, { 853, 643, 0x212442 }, { 1015, 643, 0x292442 }, { 1178, 643, 0x19203a }, { 1341, 643, 0x292d4a }, { 1504, 643, 0x312d52 }, { 1669, 643, 0x000000 }, },
        { { 151, 766, 0xf7fbc5 }, { 341, 766, 0x525552 }, { 510, 766, 0x212042 }, { 679, 766, 0x211c3a }, { 848, 766, 0x31284a }, { 1018, 766, 0x292042 }, { 1187, 766, 0x292042 }, { 1356, 766, 0x292042 }, { 1525, 766, 0x29284a }, { 1696, 766, 0x000000 }, },
        { { 124, 900, 0x211829 }, { 316, 900, 0x211c42 }, { 492, 900, 0x212042 }, { 668, 900, 0x211c42 }, { 843, 900, 0x313942 }, { 1020, 900, 0x212042 }, { 1196, 900, 0x31244a }, { 1372, 900, 0x292042 }, { 1548, 900, 0x422852 }, { 1726, 900, 0x000000 }, },
      },
      pointMap = {},
    }, {
      leftTop = nil,
      rightTop = { 1663, 413 },
      leftBotton = nil,
      rightBotton = nil,
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的
      positionMap = {
        false, false, false,
        { { 143, 771, 0xf7e7b5 }, { 338, 771, 0x191431 }, { 514, 771, 0x191831 }, { 690, 771, 0x191831 }, { 867, 771, 0x636563 }, { 1043, 771, 0x211c3a }, { 1219, 771, 0x292842 }, { 1395, 771, 0x291c3a }, { 1570, 771, 0x52556b }, { 1749, 771, 0x000000 }, },
        { { 129, 910, 0xbdc2bd }, { 312, 910, 0xcecece }, { 496, 910, 0x211c3a }, { 679, 910, 0x211831 }, { 863, 910, 0x313963 }, { 1046, 910, 0x211c42 }, { 1229, 910, 0x191829 }, { 1413, 910, 0x211c31 }, { 1597, 910, 0x212042 }, { 1782, 910, 0x000000 }, },
      },
      pointMap = {},
    }, {
      leftTop = nil,
      rightTop = nil,
      leftBotton = { 370, 899 },
      rightBotton = nil,
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的
      positionMap = {
        false, false, false, false,
        { { 445, 463, 0x000000 }, { 627, 463, 0x101010 }, { 811, 463, 0x211c3a }, { 994, 463, 0x191429 }, { 1178, 463, 0x425173 }, { 1362, 463, 0x191429 }, },
        { { 421, 595, 0x3a3d4a }, { 611, 595, 0x949ead }, { 804, 595, 0x191431 }, { 996, 595, 0x191831 }, { 1188, 595, 0x191421 }, { 1379, 595, 0x211831 }, },
        { { 397, 739, 0x000000 }, { 596, 739, 0x211831 }, { 797, 739, 0x21183a }, { 998, 739, 0x191429 }, { 1198, 739, 0x191429 }, { 1398, 739, 0x191421 }, },
        { { 370, 899, 0x000000 }, { 579, 899, 0x000000 }, { 790, 899, 0x000000 }, { 1000, 899, 0x000000 }, { 1210, 899, 0x000000 }, { 1420, 899, 0x000000 }, },
      },
      pointMap = {},
    }, {
      leftTop = nil,
      rightTop = nil,
      leftBotton = nil,
      rightBotton = { 1746, 900 },
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的
      positionMap = {
        false, false, false, false,
        { false, false, false, false, false, { 884, 454, 0x211c3a }, { 1068, 454, 0x211c3a }, { 1251, 454, 0x211c3a }, { 1434, 454, 0x292442 }, { 1620, 454, 0x000000 }, },
        { false, false, false, false, false, { 881, 586, 0x191829 }, { 1072, 586, 0x211c3a }, { 1264, 586, 0x211c3a }, { 1455, 586, 0x212031 }, { 1649, 586, 0x100c08 }, },
        { false, false, false, false, false, { 877, 730, 0x191829 }, { 1078, 730, 0x211c42 }, { 1278, 730, 0x212042 }, { 1480, 730, 0x29455a }, { 1684, 730, 0x738e63 }, },
        { false, false, false, false, false, { 873, 890, 0x000000 }, { 1084, 890, 0x000000 }, { 1294, 890, 0x000000 }, { 1504, 890, 0x000000 }, { 1716, 890, 0x000000 }, },
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
    waitForBossPosition = { { 4, 6 } },
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
