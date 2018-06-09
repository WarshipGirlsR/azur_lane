local mapBase = require './map'
local imgEvent = require './imgevent15-1-a2'
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
      rightTop = { 1564, 505 },
      leftBotton = nil,
      rightBotton = nil,
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的
      positionMap = {
        { { 573, 505, 0x192031 }, { 738, 505, 0x212421 }, { 902, 505, 0x292431 }, { 1067, 505, 0x423542 }, { 1232, 505, 0x423d42 }, { 1397, 505, 0x3a3131 }, { 1564, 505, 0x423942 }, },
        { { 564, 630, 0x000000 }, { 729, 630, 0x6b6173 }, { 900, 630, 0x31415a }, { 1069, 630, 0x21314a }, { 1238, 630, 0x314163 }, { 1407, 630, 0x293d5a }, { 1578, 630, 0x000000 }, },
        { { 554, 760, 0xdea2bd }, { 725, 760, 0xad7db5 }, { 899, 760, 0x293d52 }, { 1072, 760, 0x42496b }, { 1245, 760, 0x313d63 }, { 1418, 760, 0x3a4163 }, { 1593, 760, 0x000000 }, },
        { { 544, 897, 0x000000 }, { 720, 897, 0x213552 }, { 897, 897, 0x29355a }, { 1075, 897, 0xf7f7ff }, { 1252, 897, 0xefebff }, { 1429, 897, 0x313d5a }, { 1609, 897, 0x000000 }, },
      },
      pointMap = {},
    },
    {
      leftTop = { 565, 377 },
      rightTop = nil,
      leftBotton = nil,
      rightBotton = nil,
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的
      positionMap = {
        false, false, false,
        { { 536, 760, 0x000000 }, { 712, 760, 0x314163 }, { 889, 760, 0x293552 }, { 1067, 760, 0xdeebff }, { 1244, 760, 0xf7f3ff }, { 1421, 760, 0x293d52 }, { 1601, 760, 0x000000 }, },
        { { 525, 901, 0x000000 }, { 706, 901, 0x294563 }, { 888, 901, 0x293952 }, { 1070, 901, 0x293d5a }, { 1251, 901, 0x313d5a }, { 1433, 901, 0x3a4163 }, { 1617, 901, 0x000000 }, },
      },
      pointMap = {},
    },
    {
      leftTop = nil,
      rightTop = nil,
      leftBotton = { 528, 946 },
      rightBotton = nil,
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的
      positionMap = {
        false, false, false, false,
        { { 561, 508, 0x000000 }, { 742, 508, 0x3a4d6b }, { 923, 508, 0x293d5a }, { 1105, 508, 0x313d5a }, { 1288, 508, 0x424163 }, { 1469, 508, 0x31415a }, { 1653, 508, 0x000000 }, },
        { { 551, 646, 0x000000 }, { 735, 646, 0x292d29 }, { 923, 646, 0x292d29 }, { 1109, 646, 0x293d5a }, { 1296, 646, 0x3a416b }, { 1483, 646, 0x3a5973 }, { 1671, 646, 0x293152 }, },
        { { 540, 791, 0x000000 }, { 730, 791, 0x213142 }, { 921, 791, 0x314563 }, { 1113, 791, 0x31415a }, { 1305, 791, 0x313d5a }, { 1494, 791, 0x3a353a }, { 1691, 791, 0x000000 }, },
        { { 528, 946, 0x000000 }, { 724, 946, 0x000000 }, { 920, 946, 0x000000 }, { 1117, 946, 0x000000 }, { 1315, 946, 0x000000 }, { 1512, 946, 0x101010 }, { 1712, 946, 0x101010 }, },
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
    height = 7,
    obstacle = {
      { 1, 1 }, { 1, 2 },
      { 2, 1 }, { 2, 2 },
      { 3, 1 }, { 3, 2 },
      { 6, 5 }, { 6, 6 },
      { 7, 5 }, { 7, 6 },
    },
    waitForBossPosition = { { 1, 6 }, { 5, 6 } },
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
