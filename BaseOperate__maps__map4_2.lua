local mapBase = require 'BaseOperate__maps__map'
local img4_2 = require 'BaseOperate__maps__img4_2'
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
      leftTop = { 476, 469 },
      rightTop = nil,
      leftBotton = nil,
      rightBotton = nil,
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的
      positionMap = {
        { { 476, 469, 0x31313a }, { 644, 469, 0x191c29 }, { 813, 469, 0x212031 }, { 983, 469, 0x313129 }, { 1152, 469, 0x211c29 }, { 1321, 469, 0x292431 }, { 1490, 469, 0x3a3531 }, },
        { { 455, 590, 0x000000 }, { 632, 590, 0x84556b }, { 808, 590, 0x84595a }, { 984, 590, 0x735152 }, { 1160, 590, 0x845d52 }, { 1336, 590, 0x846152 }, { 1513, 590, 0x000000 }, },
        { { 434, 722, 0x000000 }, { 618, 722, 0x524152 }, { 801, 722, 0x5a454a }, { 985, 722, 0x6b494a }, { 1169, 722, 0x946d5a }, { 1352, 722, 0x7b5552 }, { 1536, 722, 0x000000 }, },
        { { 411, 866, 0x000000 }, { 603, 866, 0x5a415a }, { 794, 866, 0x523942 }, { 986, 866, 0x422842 }, { 1177, 866, 0x523942 }, { 1369, 866, 0x734942 }, { 1562, 866, 0x000000 }, },
      },
      pointMap = {},
    },
    {
      leftTop = nil,
      rightTop = nil,
      leftBotton = { 407, 914 },
      rightBotton = nil,
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的
      positionMap = {
        false, false, false,
        { { 480, 456, 0x000000 }, { 670, 456, 0x523952 }, { 862, 456, 0x523942 }, { 1052, 456, 0x846963 }, { 1245, 456, 0x523942 }, { 1437, 456, 0x734942 }, { 1631, 456, 0x000000 }, },
        { { 457, 594, 0xdeba10 }, { 657, 594, 0x4a355a }, { 858, 594, 0x423152 }, { 1058, 594, 0x3a243a }, { 1258, 594, 0x4a2d42 }, { 1459, 594, 0x63414a }, { 1662, 594, 0x000000 }, },
        { { 434, 745, 0x000000 }, { 642, 745, 0x29243a }, { 852, 745, 0x292031 }, { 1062, 745, 0x212031 }, { 1273, 745, 0x312042 }, { 1483, 745, 0x42283a }, { 1696, 745, 0x000000 }, },
        { { 407, 914, 0x000000 }, { 627, 914, 0x000000 }, { 847, 914, 0x000000 }, { 1068, 914, 0x000000 }, { 1289, 914, 0x000000 }, { 1510, 914, 0x100c10 }, { 1735, 914, 0x080c08 }, },
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
    height = 6,
    obstacle = {
      { 1, 1 }, { 1, 2 }, { 1, 3 },
      { 5, 1 }, { 5, 2 },
      { 6, 1 }, { 6, 2 },
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