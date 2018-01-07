local mapBase = require 'BaseOperate__maps__map'
local imgEvent = require 'BaseOperate__maps__img8_2'
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
      leftTop = { 350, 507 },
      rightTop = nil,
      leftBotton = nil,
      rightBotton = nil,
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的
      positionMap = {
        { { 350, 507, 0x191c31 }, { 518, 507, 0x191c31 }, { 687, 507, 0x21243a }, { 857, 507, 0x21243a }, { 1026, 507, 0x192031 }, { 1195, 507, 0x21243a }, { 1365, 507, 0x21243a }, { 1534, 507, 0x192431 }, { 1705, 507, 0x21243a }, },
        { { 326, 630, 0x000000 }, { 501, 630, 0x116d8c }, { 677, 630, 0x217d8c }, { 853, 630, 0x197d8c }, { 1029, 630, 0x21798c }, { 1205, 630, 0x19758c }, { 1381, 630, 0x217d8c }, { 1557, 630, 0x217d8c }, { 1735, 630, 0x000000 }, },
        { { 299, 763, 0x000000 }, { 481, 763, 0x197d8c }, { 665, 763, 0x19818c }, { 848, 763, 0x107984 }, { 1031, 763, 0x21557b }, { 1215, 763, 0x215d84 }, { 1399, 763, 0x216184 }, { 1582, 763, 0x196d8c }, { 1768, 763, 0x000000 }, },
        { { 270, 909, 0x000000 }, { 460, 909, 0x21718c }, { 652, 909, 0x216d8c }, { 843, 909, 0x105d84 }, { 1035, 909, 0x10517b }, { 1227, 909, 0x214d83 }, { 1418, 909, 0x4a3d21 }, { 1609, 909, 0xffdb9c }, { 1804, 909, 0x000000 }, },
      },
      pointMap = {},
    },
    {
      leftTop = nil,
      rightTop = nil,
      leftBotton = { 592, 903 },
      rightBotton = nil,
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的
      positionMap = {
        false, false, false,
        { { 552, 597, 0x000000 }, { 742, 597, 0x217184 }, { 933, 597, 0x297194 }, { 1125, 597, 0x195d84 }, { 1317, 597, 0x19517b }, { 1508, 597, 0x19497b }, },
        { { 533, 741, 0x000000 }, { 732, 741, 0x10618c }, { 931, 741, 0x63aee6 }, { 1133, 741, 0x215d83 }, { 1334, 741, 0x003d63 }, { 1534, 741, 0x10416b }, },
        { { 512, 902, 0x000000 }, { 721, 902, 0x000000 }, { 932, 902, 0x000000 }, { 1142, 902, 0x000001 }, { 1352, 902, 0x000001 }, { 1562, 902, 0x000001 }, },
      },
      pointMap = {},
    },
    {
      leftTop = nil,
      rightTop = nil,
      leftBotton = nil,
      rightBotton = { 1618, 906 },
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的
      positionMap = {
        false, false, false,
        { false, false, false, false, false, { 1043, 600, 0x21497b }, { 1235, 600, 0x7b4521 }, { 1424, 600, 0x735942 }, { 1620, 600, 0x000000 }, },
        { false, false, false, false, false, { 1047, 745, 0x10417b }, { 1247, 745, 0x214d7b }, { 1445, 745, 0xefefff }, { 1651, 745, 0x000000 }, },
        { false, false, false, false, false, { 1051, 905, 0x000001 }, { 1261, 905, 0x000000 }, { 1471, 905, 0x000000 }, { 1686, 905, 0x000000 }, },
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
      { 1, 4 }, { 1, 5 },
      { 2, 5 },
      { 4, 2 }, { 4, 3 }, { 4, 6 }, { 4, 7 },
      { 5, 2 }, { 5, 3 },
    },
    waitForBossPosition = {},
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