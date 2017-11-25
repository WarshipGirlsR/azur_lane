local mapBase = require 'BaseOperate__maps__map'
local imgEvent = require 'BaseOperate__maps__img8_3'
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
      rightTop = nil,
      leftBotton = { 479, 881 },
      rightBotton = nil,
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的
      positionMap = {
        { { 538, 465, 0x101c29 }, { 712, 465, 0x080c08 }, { 889, 465, 0x192031 }, { 1065, 465, 0x192031 }, { 1241, 465, 0x21203a }, { 1417, 465, 0x21203a }, { 1594, 465, 0x191c31 }, },
        { { 520, 591, 0x000000 }, { 702, 591, 0x21798c }, { 886, 591, 0x11798c }, { 1067, 591, 0x73b6ef }, { 1253, 591, 0x107d94 }, { 1436, 591, 0x105d7b }, { 1620, 591, 0x197984 }, },
        { { 501, 729, 0x000000 }, { 691, 729, 0x316994 }, { 882, 729, 0x216184 }, { 1074, 729, 0x196984 }, { 1266, 729, 0x084d73 }, { 1457, 729, 0x195584 }, { 1649, 729, 0x639ac5 }, },
        { { 479, 881, 0x000000 }, { 679, 881, 0x000000 }, { 879, 881, 0x000000 }, { 1079, 881, 0x000000 }, { 1280, 881, 0x000000 }, { 1480, 881, 0x000001 }, { 1681, 881, 0x000000 }, },
      },
      pointMap = {},
    },
    {
      leftTop = nil,
      rightTop = nil,
      leftBotton = nil,
      rightBotton = { 1745, 896 },
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的
      positionMap = {
        { false, false, false, false, false, false, { 1120, 478, 0x212031 }, { 1296, 478, 0x21203a }, { 1472, 478, 0x21203a }, { 1650, 478, 0x212042 }, },
        { false, false, false, false, false, false, { 1126, 605, 0x197984 }, { 1310, 605, 0x196984 }, { 1493, 605, 0x217d94 }, { 1679, 605, 0x000000 }, },
        { false, false, false, false, false, false, { 1133, 743, 0x194d7b }, { 1325, 743, 0x294d7b }, { 1517, 743, 0x315184 }, { 1711, 743, 0x000000 }, },
        { false, false, false, false, false, false, { 1141, 896, 0x000409 }, { 1342, 896, 0x000000 }, { 1542, 896, 0x000000 }, { 1745, 896, 0x000000 }, },
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
    height = 3,
    obstacle = {
      { 1, 3 }, { 1, 4 }, { 1, 9 },
      { 2, 3 }, { 2, 4 },
      { 3, 6 },
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