local mapBase = require 'BaseOperate__maps__map'
local imgEvent = require 'BaseOperate__maps__img7_3'
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
      rightTop = { 1705, 501 },
      leftBotton = nil,
      rightBotton = nil,
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的
      positionMap = {
        { { 350, 501, 0x101c21 }, { 520, 501, 0xdeba10 }, { 688, 501, 0x192429 }, { 857, 501, 0x212431 }, { 1026, 501, 0x29353a }, { 1196, 501, 0x212831 }, { 1365, 501, 0x213142 }, { 1534, 501, 0x192431 }, { 1705, 501, 0x212842 }, },
        { { 326, 623, 0x000000 }, { 501, 623, 0x191c3a }, { 677, 623, 0x211c3a }, { 853, 623, 0x21203a }, { 1030, 623, 0x312021 }, { 1205, 623, 0x292442 }, { 1381, 623, 0x29244a }, { 1557, 623, 0x31355a }, { 1735, 623, 0x000000 }, },
        { { 299, 756, 0x000000 }, { 481, 756, 0x191831 }, { 665, 756, 0x21203a }, { 849, 756, 0x211c3a }, { 1032, 756, 0x292442 }, { 1215, 756, 0xffdf94 }, { 1399, 756, 0x211c3a }, { 1582, 756, 0x31244a }, { 1768, 756, 0x000000 }, },
        { { 270, 901, 0x000000 }, { 460, 901, 0x191831 }, { 652, 901, 0x191831 }, { 843, 901, 0x211c3a }, { 1035, 901, 0x211c3a }, { 1226, 901, 0x191829 }, { 1418, 901, 0x191831 }, { 1610, 901, 0x191c31 }, { 1804, 901, 0x000000 }, },
      },
      pointMap = {},
    },
    {
      leftTop = nil,
      rightTop = { 1775, 373 },
      leftBotton = nil,
      rightBotton = nil,
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的
      positionMap = {
        false, false, false,
        { { 349, 757, 0x000000 }, { 539, 757, 0x211c3a }, { 731, 757, 0x191c3a }, { 923, 757, 0x211c3a }, { 1114, 757, 0x191829 }, { 1306, 757, 0x191829 }, { 1497, 757, 0x312852 }, },
        { { 321, 908, 0x000000 }, { 520, 908, 0x211c3a }, { 720, 908, 0x29204a }, { 920, 908, 0x291c3a }, { 1121, 908, 0x211c31 }, { 1321, 908, 0x191831 }, { 1522, 908, 0x21203a }, },
      },
      pointMap = {},
    },
    {
      leftTop = nil,
      rightTop = nil,
      leftBotton = { 516, 900 },
      rightBotton = nil,
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的
      positionMap = {
        false, false, false, false,
        { { 557, 581, 0x000000 }, { 756, 581, 0x191431 }, { 956, 581, 0x191431 }, { 1157, 581, 0x211c42 }, { 1357, 581, 0x211c42 }, },
        { { 537, 732, 0x000000 }, { 746, 732, 0x211c42 }, { 957, 732, 0x211831 }, { 1167, 732, 0x191831 }, { 1376, 732, 0x211c3a }, },
        { { 516, 900, 0x000000 }, { 735, 900, 0x000000 }, { 956, 900, 0x000000 }, { 1177, 900, 0x000000 }, { 1397, 900, 0x000000 }, },
      },
      pointMap = {},
    },
    {
      leftTop = nil,
      rightTop = nil,
      leftBotton = { 516, 900 },
      rightBotton = nil,
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的
      positionMap = {
        false, false, false, false,
        { false, false, false, false, { 892, 584, 0x212042 }, { 1093, 584, 0x191831 }, { 1293, 584, 0x211831 }, { 1494, 584, 0x292042 }, { 1697, 584, 0x000000 }, },
        { false, false, false, false, { 889, 735, 0x191831 }, { 1099, 735, 0x211831 }, { 1310, 735, 0x191829 }, { 1519, 735, 0x211c42 }, { 1732, 735, 0x000000 }, },
        { false, false, false, false, { 885, 903, 0x000000 }, { 1107, 903, 0x000000 }, { 1327, 903, 0x000000 }, { 1548, 903, 0x000000 }, { 1772, 903, 0x000000 }, },
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
      { 2, 3 },
      { 3, 6 }, { 3, 7 }, { 3, 8 },
      { 4, 7 }, { 4, 8 },
      { 5, 2 }, { 5, 3 }, { 5, 4 }, { 5, 7 },
      { 6, 4 },
    },
    waitForBossPosition = { { 3, 4 } },
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