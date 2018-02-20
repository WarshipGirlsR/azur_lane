local mapBase = require './map'
local imgEvent = require './img1-1'
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
      leftBotton = { 352, 676 },
      rightBotton = nil,
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的
      positionMap = {
        { { 377, 540, 0x192842 }, { 559, 540, 0xbdbabd }, { 744, 540, 0x21354a }, { 927, 540, 0x21394a }, { 1111, 540, 0x21394a }, { 1294, 540, 0x213952 }, { 1478, 540, 0x21354a }, { 1662, 540, 0x21354a }, },
        { { 352, 676, 0x000000 }, { 543, 676, 0x000000 }, { 734, 676, 0x000000 }, { 926, 676, 0x000000 }, { 1117, 676, 0x000000 }, { 1309, 676, 0x000000 }, { 1500, 676, 0x000000 }, { 1693, 676, 0x000000 }, }
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
    width = 7,
    height = 1,
    obstacle = {},
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