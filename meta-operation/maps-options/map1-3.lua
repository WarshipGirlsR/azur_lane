local mapBase = require './map'
local imgEvent = require './img1-3'
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
      leftTop = { 518, 470 },
      rightTop = nil,
      leftBotton = nil,
      rightBotton = nil,
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的
      positionMap = {
        { { 518, 470, 0x293d52 }, { 694, 470, 0x63bece }, { 868, 470, 0x73be8c }, { 1045, 470, 0x293d3a }, { 1221, 470, 0x213142 }, { 1397, 470, 0x193142 }, { 1573, 470, 0x213542 }, },
        { { 498, 597, 0x000000 }, { 682, 597, 0x197984 }, { 865, 597, 0x21819c }, { 1049, 597, 0x21718c }, { 1232, 597, 0x19798c }, { 1416, 597, 0x196d8c }, { 1600, 597, 0x000000 }, },
        { { 478, 735, 0x000000 }, { 669, 735, 0x31719c }, { 861, 735, 0x196d8c }, { 1053, 735, 0x104d7b }, { 1244, 735, 0x19457b }, { 1436, 735, 0x215984 }, { 1628, 735, 0x000000 }, },
        { { 456, 887, 0x000000 }, { 656, 887, 0x000000 }, { 856, 887, 0x000000 }, { 1057, 887, 0x000000 }, { 1257, 887, 0x000000 }, { 1458, 887, 0x000000 }, { 1659, 887, 0x000000 }, },
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
    height = 3,
    obstacle = { { 1, 1 }, { 1, 2 }, { 1, 3 }, { 3, 3 } },
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