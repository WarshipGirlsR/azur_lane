local mapBase = require 'BaseOperate__maps__map'
local imgEvent = require 'BaseOperate__maps__img1_2'
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
      leftBotton = { 389, 837 },
      rightBotton = nil,
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的
      positionMap = {
        { { 462, 409, 0x31393a }, { 645, 409, 0x42494a }, { 828, 409, 0x313931 }, { 1012, 409, 0x293529 }, { 1196, 409, 0x212821 }, { 1380, 409, 0x424942 }, },
        { { 440, 537, 0x000000 }, { 631, 537, 0x318e94 }, { 823, 537, 0x21868c }, { 1014, 537, 0x106184 }, { 1206, 537, 0x196984 }, { 1398, 537, 0x000000 }, },
        { { 416, 679, 0x000000 }, { 613, 679, 0x316994 }, { 814, 679, 0x00517b }, { 1014, 679, 0x084173 }, { 1214, 679, 0x214d73 }, { 1419, 679, 0x000000 }, },
        { { 389, 837, 0x000000 }, { 599, 837, 0x000000 }, { 809, 837, 0x000000 }, { 1020, 837, 0x000000 }, { 1230, 837, 0x000000 }, { 1441, 837, 0x000000 }, },
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
    width = 5,
    height = 3,
    obstacle = { { 2, 2 }, { 2, 5 }, { 3, 5 } },
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