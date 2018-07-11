local mapBase = require './map'
local imgEvent = require './img3-1'
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
  local list = mapBase.calCheckpositionList({
    {
      leftTop = { 412, 434, },
      rightTop = nil,
      leftBotton = nil,
      rightBotton = nil,
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的
      positionMap = {
        { { 412, 434, 0x314552 }, { 594, 434, 0x3a4552 }, { 778, 434, 0x313d52 }, { 961, 434, 0x293d4a }, { 1145, 434, 0x21394a }, { 1329, 434, 0x21394a }, { 1512, 434, 0x313d52 }, { 1698, 434, 0x313d52 }, },
        { { 388, 564, 0x000000 }, { 578, 564, 0x21799c }, { 770, 564, 0x218194 }, { 962, 564, 0x218194 }, { 1153, 564, 0x196d8c }, { 1345, 564, 0x197994 }, { 1536, 564, 0x297d94 }, { 1730, 564, 0x000000 }, },
        { { 361, 707, 0x000000 }, { 561, 707, 0x19798c }, { 761, 707, 0x31818c }, { 962, 707, 0x00597b }, { 1162, 707, 0x104d7b }, { 1363, 707, 0x295584 }, { 1563, 707, 0x217d94 }, { 1766, 707, 0x000000 }, },
        { { 332, 864, 0x000000 }, { 542, 864, 0x4a8a7b }, { 752, 864, 0x216994 }, { 962, 864, 0x215183 }, { 1172, 864, 0x21518c }, { 1382, 864, 0x215184 }, { 1592, 864, 0x31518c }, { 1805, 864, 0x000000 }, },
      },
      pointMap = {},
    },
    {
      leftTop = nil,
      rightTop = nil,
      leftBotton = nil,
      rightBotton = { 1709, 883 },
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的
      positionMap = {
        false, false, false,
        { { 200, 716, 0x000000 }, { 407, 716, 0x63b684 }, { 620, 716, 0x216994 }, { 830, 716, 0x215184 }, { 1040, 716, 0x21518c }, { 1250, 716, 0x215184 }, { 1460, 716, 0x31518c }, { 1673, 716, 0x000000 }, },
        { { 161, 883, 0x000000 }, { 381, 883, 0x000000 }, { 602, 883, 0x000000 }, { 823, 883, 0x000000 }, { 1044, 883, 0x000000 }, { 1265, 883, 0x000000 }, { 1486, 883, 0x000000 }, { 1709, 883, 0x000000 }, },
      },
      pointMap = {},
    },
  })
  return list
end

-- 获取地图棋盘和相关数据
mapEvent.getMapChessboard = function()
  return {
    width = 7,
    height = 4,
    obstacle = {
      { 3, 1 }, { 3, 2 }, { 4, 1 }, { 4, 2 },
      { 4, 6 }, { 4, 7 },
    },
    waitForBossPosition = { { 1, 7 } },
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