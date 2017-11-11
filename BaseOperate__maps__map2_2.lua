local mapBase = require 'BaseOperate__maps__map'
local imgEvent = require 'BaseOperate__maps__img2_2'
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
      leftTop = { 436, 498 },
      rightTop = nil,
      leftBotton = nil,
      rightBotton = nil,
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的
      positionMap = {
        { { 436, 498, 0x294552 }, { 604, 498, 0x293d52 }, { 773, 498, 0x21394a }, { 942, 498, 0x29354a }, { 1112, 498, 0x21354a }, { 1273, 498, 0x19aac5 }, { 1450, 498, 0x313d52 }, { 1621, 498, 0x294152 }, },
        { { 415, 619, 0x000000 }, { 591, 619, 0x52967b }, { 766, 619, 0x427d73 }, { 941, 619, 0x218a9c }, { 1117, 619, 0x21718c }, { 1295, 619, 0xf7718c }, { 1470, 619, 0x4a8e73 }, { 1648, 619, 0x000000 }, },
        { { 392, 753, 0x000000 }, { 574, 753, 0x4a4510 }, { 757, 753, 0x298194 }, { 941, 753, 0x318194 }, { 1124, 753, 0x10597b }, { 1308, 753, 0x19698c }, { 1491, 753, 0x19718c }, { 1677, 753, 0x000000 }, },
        { { 366, 898, 0x000000 }, { 557, 898, 0x296d8c }, { 748, 898, 0x217594 }, { 938, 898, 0x1961a4 }, { 1131, 898, 0x084973 }, { 1323, 898, 0x294973 }, { 1515, 898, 0x295984 }, { 1709, 898, 0x000000 }, },
      },
      pointMap = {},
    },
    {
      leftTop = nil,
      rightTop = nil,
      leftBotton = { 268, 903 },
      rightBotton = nil,
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的
      positionMap = {
        false, false, false,
        { { 330, 598, 0x000000 }, { 520, 598, 0x3a719c }, { 712, 598, 0x3a798c }, { 903, 598, 0x084d73 }, { 1094, 598, 0x214d8c }, { 1286, 598, 0x29518c }, { 1478, 598, 0x31618c }, { 1672, 598, 0x000000 }, },
        { { 301, 743, 0x000000 }, { 499, 743, 0x21719c }, { 700, 743, 0x196184 }, { 900, 743, 0x08496b }, { 1101, 743, 0x104173 }, { 1301, 743, 0x104d7b }, { 1502, 743, 0x21497b }, { 1705, 743, 0x000000 }, },
        { { 268, 903, 0x000000 }, { 477, 903, 0x000000 }, { 687, 903, 0x000000 }, { 897, 903, 0x000000 }, { 1107, 903, 0x000000 }, { 1318, 903, 0x000000 }, { 1528, 903, 0x000000 }, { 1741, 903, 0x000000 }, },
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
    height = 5,
    obstacle = {
      { 1, 1 }, { 1, 2 }, { 1, 3 }, { 1, 5 }, { 1, 6 }, { 1, 7 },
      { 2, 1 }, { 2, 2 }, { 2, 3 }, { 2, 6 }, { 2, 7 },
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