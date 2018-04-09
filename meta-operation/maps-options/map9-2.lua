local mapBase = require './map'
local imgEvent = require './img9-2'
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
      rightTop = { 1826, 495 },
      leftBotton = nil,
      rightBotton = nil,
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的
      positionMap = {
        { { 302, 495, 0x000c11 }, { 470, 495, 0x000c10 }, { 639, 495, 0x192029 }, { 808, 495, 0x081010 }, { 978, 495, 0x101c21 }, { 1147, 495, 0x212d3a }, { 1317, 495, 0x101819 }, { 1486, 495, 0x101819 }, { 1655, 495, 0x292429 }, { 1826, 495, 0x081419 }, },
        { { 276, 617, 0x000000 }, { 450, 617, 0x424173 }, { 627, 617, 0x211c3a }, { 803, 617, 0x211c3a }, { 978, 617, 0x191c3a }, { 1155, 617, 0x292042 }, { 1331, 617, 0x292042 }, { 1507, 617, 0x29284a }, { 1683, 617, 0x3a315a }, { 1861, 617, 0x000000 }, },
        { { 247, 750, 0x000000 }, { 429, 750, 0x211831 }, { 614, 750, 0x946910 }, { 796, 750, 0x212042 }, { 980, 750, 0x63598c }, { 1163, 750, 0x292442 }, { 1347, 750, 0x291c42 }, { 1530, 750, 0x31244a }, { 1713, 750, 0x212042 }, { 1899, 750, 0x000000 }, },
        { { 215, 895, 0x000000 }, { 405, 895, 0x19183a }, { 597, 895, 0x211c3a }, { 787, 895, 0xef5963 }, { 981, 885, 0x4a454a }, { 1172, 895, 0x191421 }, { 1365, 895, 0xffffde }, { 1555, 895, 0x211c3a }, { 1747, 895, 0x292042 }, { 1913, 908, 0x42356b }, },
      },
      pointMap = {},
    },
    {
      leftTop = nil,
      rightTop = nil,
      leftBotton = { 363, 902 },
      rightBotton = nil,
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的
      positionMap = {
        false, false, false,
        { { 416, 597, 0x000000 }, { 607, 597, 0x19183a }, { 798, 597, 0x191831 }, { 990, 597, 0xe65963 }, { 1182, 597, 0x6b4521 }, },
        { { 391, 742, 0x000000 }, { 590, 742, 0x211c42 }, { 791, 742, 0x191831 }, { 991, 742, 0x211831 }, { 1190, 742, 0x211c42 }, },
        { { 363, 902, 0x000000 }, { 572, 902, 0x000000 }, { 783, 902, 0x000000 }, { 993, 902, 0x000000 }, { 1203, 902, 0x000000 }, },
      },
      pointMap = {},
    },
    {
      leftTop = nil,
      rightTop = nil,
      leftBotton = nil,
      rightBotton = { 1615, 902 },
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的
      positionMap = {
        false, false, false,
        { false, false, false, false, { 597, 597, 0xffffff }, { 783, 597, 0x7b5552 }, { 980, 597, 0x191410 }, { 1172, 597, 0x191831 }, { 1363, 597, 0x292042 }, { 1557, 597, 0x000000 }, },
        { false, false, false, false, { 580, 742, 0x211c3a }, { 780, 742, 0x191819 }, { 981, 742, 0x191829 }, { 1181, 742, 0x191831 }, { 1382, 742, 0x212042 }, { 1585, 742, 0x000000 }, },
        { false, false, false, false, { 561, 902, 0x000000 }, { 772, 902, 0x000000 }, { 982, 902, 0x000000 }, { 1192, 902, 0x000000 }, { 1402, 902, 0x000000 }, { 1615, 902, 0x000000 }, },
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
    height = 5,
    obstacle = {
      { 1, 1 }, { 1, 2 },
      { 2, 2 }, { 2, 7 },
      { 3, 4 }, { 3, 5 }, { 3, 6 }, { 3, 7 }, { 3, 9 },
      { 4, 2 }, { 4, 5 },
      { 5, 5 },
    },
    waitForBossPosition = { { 1, 5 } },
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