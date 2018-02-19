local mapBase = require './map'
local imgEvent = require './img7-2'
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
      rightTop = { 1721, 507 },
      leftBotton = nil,
      rightBotton = nil,
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的
      positionMap = {
        { { 367, 507, 0x212029 }, { 535, 507, 0x212029 }, { 704, 507, 0x102021 }, { 873, 507, 0x192431 }, { 1043, 507, 0x213142 }, { 1212, 507, 0x111c21 }, { 1381, 507, 0x192031 }, { 1551, 507, 0x212431 }, { 1721, 507, 0x19243a }, },
        { { 343, 630, 0x000000 }, { 518, 630, 0x211c3a }, { 694, 630, 0x31244a }, { 870, 630, 0x212042 }, { 1046, 630, 0x29244a }, { 1222, 630, 0x292442 }, { 1398, 630, 0x29284a }, { 1575, 630, 0x312d5a }, { 1753, 630, 0x000000 }, },
        { { 317, 763, 0x000000 }, { 499, 763, 0x211c42 }, { 683, 763, 0x211c42 }, { 866, 763, 0x191831 }, { 1050, 763, 0x191831 }, { 1234, 763, 0x191831 }, { 1417, 763, 0x211c3a }, { 1600, 763, 0x211c31 }, { 1786, 763, 0x000000 }, },
        { { 289, 908, 0x000000 }, { 478, 908, 0x424142 }, { 671, 908, 0x19183a }, { 862, 908, 0x211c3a }, { 1054, 908, 0x211c3a }, { 1246, 908, 0x21203a }, { 1436, 908, 0x211c3a }, { 1629, 908, 0x291c42 }, { 1822, 908, 0x000000 }, },
      },
      pointMap = {},
    },
    {
      leftTop = nil,
      rightTop = nil,
      leftBotton = { 455, 888 },
      rightBotton = nil,
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的
      positionMap = {
        false, false, false,
        { { 500, 584, 0x000000 }, { 690, 584, 0x211c42 }, { 881, 584, 0x21183a }, { 1073, 584, 0x191831 }, { 1265, 584, 0x191831 }, { 1457, 584, 0x211831 }, { 1648, 584, 0x211c3a }, },
        { { 478, 728, 0x000000 }, { 677, 728, 0x211831 }, { 878, 728, 0x211c42 }, { 1078, 728, 0x211c3a }, { 1279, 728, 0x191829 }, { 1480, 728, 0x211c3a }, { 1680, 728, 0x211c3a }, },
        { { 455, 888, 0x000000 }, { 664, 888, 0x000000 }, { 874, 888, 0x000000 }, { 1084, 888, 0x000000 }, { 1294, 888, 0x000000 }, { 1505, 888, 0x000000 }, { 1715, 888, 0x000000 }, },
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
      { 1, 2 },
      { 2, 2 }, { 2, 3 },
      { 4, 7 }, { 4, 8 },
      { 5, 7 }, { 5, 8 },
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