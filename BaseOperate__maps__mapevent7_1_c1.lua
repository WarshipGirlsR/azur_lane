local mapBase = require 'BaseOperate__maps__map'
local imgEvent = require 'BaseOperate__maps__imgevent7_1_c1'
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
      rightTop = { 1595, 393 },
      leftBotton = nil,
      rightBotton = nil,
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的
      positionMap = {
        { { 494, 393, 0x080400 }, { 647, 393, 0x211010 }, { 802, 393, 0x311410 }, { 964, 393, 0x3a2421 }, { 1121, 393, 0x100808 }, { 1279, 393, 0x190808 }, { 1441, 393, 0x291010 }, { 1595, 393, 0x311008 }, },
        { { 472, 503, 0x310c00 }, { 635, 503, 0x522429 }, { 799, 503, 0x3a2421 }, { 964, 503, 0x632d29 }, { 1129, 503, 0x5a2d31 }, { 1293, 503, 0x211010 }, { 1464, 503, 0x210400 }, { 1625, 503, 0x4a393a }, },
        { { 447, 623, 0x000000 }, { 617, 623, 0xffffff }, { 792, 623, 0x846163 }, { 964, 623, 0x192019 }, { 1138, 623, 0x6b3129 }, { 1310, 623, 0x947573 }, { 1484, 623, 0x5a2d31 }, { 1658, 623, 0x000000 }, },
        { { 419, 756, 0x000000 }, { 601, 756, 0x5a2829 }, { 783, 756, 0x733d3a }, { 965, 756, 0x73393a }, { 1147, 756, 0x5a3129 }, { 1329, 756, 0x73353a }, { 1511, 756, 0x633131 }, { 1695, 756, 0x000000 }, },
        { { 390, 906, 0x000000 }, { 581, 906, 0x000000 }, { 773, 906, 0x000000 }, { 966, 906, 0x000000 }, { 1158, 906, 0x000000 }, { 1350, 906, 0x000000 }, { 1542, 906, 0x000000 }, { 1737, 906, 0x000000 }, },
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
    height = 4,
    obstacle = {
      { 1, 1 }, { 1, 2 }, { 1, 3 }, { 1, 6 }, { 1, 7 },
      { 2, 6 }, { 2, 7 },
      { 4, 4 },
    },
    waitForBossPosition = { { 4, 7 } },
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