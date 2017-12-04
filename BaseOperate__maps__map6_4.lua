local mapBase = require 'BaseOperate__maps__map'
local imgEvent = require 'BaseOperate__maps__img6_4'
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
      rightTop = { 1712, 490 },
      leftBotton = nil,
      rightBotton = nil,
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的
      positionMap = {
        { { 408, 490, 0x101419 }, { 569, 490, 0x080c10 }, { 732, 490, 0x101019 }, { 895, 490, 0x081019 }, { 1058, 490, 0x212031 }, { 1221, 490, 0x213131 }, { 1384, 490, 0x212029 }, { 1546, 490, 0x21203a }, { 1712, 490, 0x191821 }, },
        { { 386, 608, 0x000000 }, { 555, 608, 0x191831 }, { 723, 608, 0x21183a }, { 893, 608, 0x21203a }, { 1062, 608, 0x292042 }, { 1231, 608, 0x212042 }, { 1400, 608, 0x292852 }, { 1569, 608, 0xde8642 }, { 1742, 608, 0x6b8e9c }, },
        { { 363, 735, 0x000000 }, { 538, 735, 0x191831 }, { 714, 735, 0x191831 }, { 890, 735, 0x191831 }, { 1066, 735, 0x211c3a }, { 1243, 735, 0x292042 }, { 1418, 735, 0x52353a }, { 1593, 735, 0x84595a }, { 1772, 735, 0x000000 }, },
        { { 336, 873, 0x4a3d10 }, { 520, 873, 0x191431 }, { 704, 873, 0x191831 }, { 887, 873, 0x211c3a }, { 1071, 873, 0x211c3a }, { 1254, 873, 0x191829 }, { 1437, 873, 0x292042 }, { 1621, 873, 0x292042 }, { 1807, 873, 0x000000 }, },
      },
      pointMap = {},
    },
    {
      leftTop = nil,
      rightTop = nil,
      leftBotton = { 542, 925 },
      rightBotton = nil,
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的
      positionMap = {
        false, false, false,
        { { 595, 485, 0xb58108 }, { 777, 485, 0x211c42 }, { 961, 485, 0x211c42 }, { 1144, 485, 0x191429 }, { 1328, 485, 0x191831 }, { 1511, 485, 0x100c10 }, },
        { { 579, 618, 0x000000 }, { 769, 618, 0x191831 }, { 960, 618, 0x211c3a }, { 1152, 618, 0x211c3a }, { 1343, 618, 0x211c31 }, { 1535, 618, 0x191831 }, },
        { { 561, 763, 0x000000 }, { 760, 763, 0x191431 }, { 960, 763, 0x191431 }, { 1161, 763, 0x191831 }, { 1362, 763, 0x191429 }, { 1562, 763, 0x191429 }, },
        { { 542, 925, 0x000000 }, { 751, 925, 0x000000 }, { 961, 925, 0x000000 }, { 1171, 925, 0x000000 }, { 1381, 925, 0x100c10 }, { 1592, 925, 0x080c08 }, },
      },
      pointMap = {},
    },
    {
      leftTop = nil,
      rightTop = nil,
      leftBotton = nil,
      rightBotton = { 1800, 931 },
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的
      positionMap = {
        false, false, false,
        { false, false, false, false, false, { 1137, 491, 0x211c31 }, { 1321, 491, 0x29203a }, { 1504, 491, 0x191c31 }, { 1690, 491, 0x000000 }, },
        { false, false, false, false, false, { 1145, 625, 0x211c31 }, { 1337, 625, 0x211c42 }, { 1529, 625, 0x292042 }, { 1723, 625, 0x000000 }, },
        { false, false, false, false, false, { 1153, 769, 0x211831 }, { 1354, 769, 0x191829 }, { 1554, 769, 0x191829 }, { 1757, 769, 0x000000 }, },
        { false, false, false, false, false, { 1163, 931, 0x000000 }, { 1374, 931, 0x080c08 }, { 1583, 931, 0x100c10 }, { 1800, 931, 0x7b7d7b }, },
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
    height = 6,
    obstacle = {
      { 1, 7 }, { 1, 8 },
      { 2, 8 },
      { 3, 2 },
      { 5, 5 },
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