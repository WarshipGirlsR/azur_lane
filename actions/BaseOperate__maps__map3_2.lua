local mapBase = require 'BaseOperate__maps__map'
local imgEvent = require 'BaseOperate__maps__img3_2'
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
      leftTop = { 348, 478 },
      rightTop = nil,
      leftBotton = nil,
      rightBotton = nil,
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的
      positionMap = {
        { { 348, 478, 0x29394a }, { 523, 478, 0x21314a }, { 699, 478, 0x213142 }, { 876, 478, 0x21314a }, { 1052, 478, 0x29394a }, { 1228, 478, 0x212842 }, { 1404, 478, 0x29394a }, { 1580, 478, 0x21354a }, { 1758, 478, 0x212842 }, },
        { { 323, 605, 0x000000 }, { 505, 605, 0x217994 }, { 689, 605, 0x298194 }, { 872, 605, 0x19798c }, { 1055, 605, 0x10718c }, { 1239, 605, 0x19758c }, { 1422, 605, 0x197184 }, { 1606, 605, 0x197984 }, { 1792, 605, 0x000000 }, },
        { { 295, 743, 0x000000 }, { 488, 743, 0x428673 }, { 677, 743, 0x318194 }, { 868, 743, 0x086984 }, { 1060, 743, 0x085173 }, { 1251, 743, 0x215184 }, { 1444, 743, 0xce5d73 }, { 1637, 745, 0x63a684 }, { 1828, 743, 0x000000 }, },
        { { 264, 894, 0x000000 }, { 463, 894, 0x296194 }, { 664, 894, 0x29658c }, { 864, 894, 0x215d84 }, { 1065, 894, 0x004173 }, { 1265, 894, 0x104973 }, { 1466, 894, 0x21518c }, { 1666, 894, 0x31518c }, { 1868, 894, 0x000001 }, },
      },
      pointMap = {},
    },
    {
      leftTop = nil,
      rightTop = nil,
      leftBotton = { 237, 880 },
      rightBotton = nil,
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的
      positionMap = {
        false, false, false,
        { { 270, 721, 0x000000 }, { 470, 721, 0x216184 }, { 670, 721, 0x196184 }, { 871, 721, 0x105d84 }, { 1071, 721, 0x10417b }, { 1271, 721, 0x10497b }, { 1472, 721, 0x19497b }, { 1672, 721, 0x214573 }, { 1875, 721, 0x000000 }, },
        { { 237, 880, 0x000000 }, { 446, 880, 0x000000 }, { 656, 880, 0x000000 }, { 866, 880, 0x000000 }, { 1077, 880, 0x000000 }, { 1287, 880, 0x000000 }, { 1497, 880, 0x000000 }, { 1707, 880, 0x000000 }, { 1919, 880, 0x000000 }, },
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
    height = 4,
    obstacle = {
      { 2, 1 }, { 2, 2 }, { 3, 2 },
      { 2, 6 }, { 2, 7 }, { 2, 8 },
      { 3, 7 }, { 3, 8 }, { 4, 8 },
    },
    waitForBossPosition = { { 1, 8 } },
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