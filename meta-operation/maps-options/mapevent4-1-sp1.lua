local mapBase = require './map'
local imgEvent = require './imgevent4-1-sp1'
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
      rightTop = { 1709, 478 },
      leftBotton = nil,
      rightBotton = nil,
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的
      positionMap = {
        { { 299, 478, 0x101419 }, { 473, 478, 0x192429 }, { 647, 478, 0xd67910 }, { 826, 478, 0x292421 }, { 1002, 478, 0x292829 }, { 1179, 478, 0x101010 }, { 1353, 478, 0x000800 }, { 1531, 478, 0x101010 }, { 1709, 478, 0x212421 }, },
        { { 272, 604, 0x000000 }, { 454, 604, 0x312831 }, { 637, 604, 0x6b4921 }, { 821, 604, 0x4a2d19 }, { 1004, 604, 0x523531 }, { 1187, 604, 0x293129 }, { 1371, 604, 0x4a3529 }, { 1555, 604, 0x000400 }, { 1740, 604, 0x000000 }, },
        { { 241, 742, 0x000000 }, { 431, 742, 0x292829 }, { 623, 742, 0x312829 }, { 814, 742, 0x523121 }, { 1006, 742, 0x422d29 }, { 1197, 742, 0x212821 }, { 1389, 742, 0x312821 }, { 1581, 742, 0x4a3121 }, { 1775, 742, 0x000000 }, },
        { { 208, 894, 0x000000 }, { 407, 894, 0x3a2821 }, { 607, 894, 0x312829 }, { 808, 894, 0x3a2821 }, { 1008, 894, 0x312829 }, { 1209, 894, 0x212829 }, { 1407, 894, 0x291408 }, { 1610, 894, 0x3a313a }, { 1813, 894, 0x000000 }, },
      },
      pointMap = {},
    },
    {
      leftTop = nil,
      rightTop = nil,
      leftBotton = { 419, 899 },
      rightBotton = nil,
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的
      positionMap = {
        false, false, false,
        { { 469, 580, 0x000000 }, { 669, 580, 0x312821 }, { 869, 580, 0x312829 }, { 1069, 580, 0x312421 }, { 1270, 580, 0x312829 }, },
        { { 445, 731, 0x000000 }, { 654, 731, 0x422010 }, { 864, 731, 0x292419 }, { 1074, 731, 0x192021 }, { 1285, 731, 0x212021 }, },
        { { 419, 899, 0x000000 }, { 638, 899, 0x000000 }, { 859, 899, 0x000000 }, { 1081, 899, 0x000000 }, { 1302, 899, 0x000000 }, },
      },
      pointMap = {},
    },
    {
      leftTop = nil,
      rightTop = nil,
      leftBotton = nil,
      rightBotton = { 1646, 903 },
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的
      positionMap = {
        false, false, false,
        { false, false, false, false, { 779, 584, 0x292421 }, { 980, 584, 0x292831 }, { 1181, 584, 0x292021 }, { 1380, 584, 0x3a3131 }, { 1583, 584, 0x000000 }, },
        { false, false, false, false, { 770, 735, 0x191c19 }, { 981, 735, 0x212429 }, { 1190, 735, 0x192021 }, { 1401, 735, 0x292831 }, { 1613, 735, 0x000000 }, },
        { false, false, false, false, { 761, 903, 0x000000 }, { 982, 903, 0x000000 }, { 1203, 903, 0x000000 }, { 1423, 903, 0x000000 }, { 1646, 903, 0x000000 }, },
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
      { 1, 1 }, { 1, 2 }, { 1, 3 },
      { 2, 7 },
      { 3, 3 }, { 3, 6 },
      { 4, 4 }, { 4, 6 }, { 4, 7 },
      { 5, 4 },
    },
    waitForBossPosition = { { 3, 7 }, },
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