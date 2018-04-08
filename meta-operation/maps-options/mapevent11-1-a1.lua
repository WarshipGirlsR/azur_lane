local mapBase = require './map'
local imgEvent = require './imgevent11-1-a1'
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
      leftTop = { 569, 464 },
      rightTop = nil,
      leftBotton = nil,
      rightBotton = nil,
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的
      positionMap = {
        { { 569, 464, 0x523931 }, { 739, 464, 0x19243a }, { 910, 464, 0x212842 }, { 1081, 464, 0x523931 }, { 1249, 464, 0xd69e7b }, { 1422, 464, 0x3a3931 }, },
        { { 552, 587, 0x000000 }, { 729, 587, 0x4a314a }, { 908, 587, 0x63494a }, { 1086, 587, 0x6b514a }, { 1264, 587, 0x634d42 }, { 1443, 587, 0x6b4d4a }, },
        { { 533, 721, 0x000000 }, { 718, 721, 0x313542 }, { 905, 721, 0x52414a }, { 1092, 721, 0x423942 }, { 1279, 721, 0x4a3542 }, { 1466, 721, 0x63413a }, },
        { { 511, 869, 0x000000 }, { 705, 869, 0xefebef }, { 902, 869, 0x63414a }, { 1099, 869, 0x3a2d3a }, { 1295, 869, 0x3a2431 }, { 1491, 869, 0x4a3142 }, },
      },
      pointMap = {},
    }, {
      leftTop = nil,
      rightTop = { 1600, 481 },
      leftBotton = nil,
      rightBotton = nil,
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的
      positionMap = {
        { false, false, false, false, false, { 1084, 481, 0x4a4129 }, { 1255, 481, 0x212021 }, { 1430, 481, 0x52495a }, { 1600, 481, 0x8c797b }, },
        { false, false, false, false, false, { 1090, 604, 0x735152 }, { 1268, 604, 0x846152 }, { 1446, 604, 0x847184 }, { 1627, 604, 0xb5868c }, },
        { false, false, false, false, false, { 1096, 739, 0x63413a }, { 1283, 739, 0x734d42 }, { 1470, 739, 0x73718c }, { 1659, 739, 0x000000 }, },
        { false, false, false, false, false, { 1103, 887, 0x4a3142 }, { 1299, 886, 0x523942 }, { 1495, 887, 0x7b5152 }, { 1693, 887, 0x000000 }, },
      },
      pointMap = {},
    }, {
      leftTop = nil,
      rightTop = nil,
      leftBotton = { 448, 903 },
      rightBotton = nil,
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的
      positionMap = {
        false, false, false,
        { { 499, 587, 0x000000 }, { 694, 587, 0xffffff }, { 891, 587, 0x6b455a }, { 1087, 587, 0x3a2d3a }, { 1283, 587, 0x3a243a }, { 1479, 587, 0x4a3142 }, },
        { { 473, 736, 0xb5bed6 }, { 680, 736, 0x42414a }, { 886, 736, 0x523d5a }, { 1094, 736, 0x3a2d42 }, { 1300, 736, 0x29203a }, { 1506, 736, 0x31203a }, },
        { { 448, 903, 0x000000 }, { 665, 903, 0x000000 }, { 883, 903, 0x000000 }, { 1101, 903, 0x000000 }, { 1319, 903, 0x000000 }, { 1537, 903, 0x000000 }, },
      },
      pointMap = {},
    }, {
      leftTop = nil,
      rightTop = nil,
      leftBotton = nil,
      rightBotton = { 1746, 900 },
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的
      positionMap = {
        false, false, false,
        { false, false, false, false, false, { 1077, 585, 0x523142 }, { 1273, 585, 0x5a3942 }, { 1469, 585, 0x7b4d52 }, { 1668, 585, 0x000000 }, },
        { false, false, false, false, false, { 1082, 733, 0x211829 }, { 1290, 733, 0x422831 }, { 1496, 733, 0x633942 }, { 1705, 733, 0x000000 }, },
        { false, false, false, false, false, { 1090, 900, 0x000000 }, { 1307, 900, 0x000000 }, { 1526, 900, 0x000000 }, { 1746, 900, 0x000000 }, },
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
    height = 5,
    obstacle = {
      { 1, 4 }, { 1, 5 }, { 1, 6 }, { 1, 7 }, { 1, 8 },
      { 2, 2 }, { 2, 8 },
      { 3, 6 },
      { 4, 3 }, { 4, 6 },
      { 5, 3 },
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
