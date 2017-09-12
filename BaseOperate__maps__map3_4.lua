local mapBase = require 'BaseOperate__maps__map'
local img3_4 = require 'BaseOperate__maps__img3_4'
local map3_4 = {}

-- 获取地图采样位置。由于地图可能超出一屏，所以这里可以定义多个采样位置。每次扫描都会对每个采样位置进行扫描
-- 标志位为地图四个角。每个采样位置只需定义一个角的坐标即可。
-- 还需要定义每个采样位置的地图矩阵与屏幕坐标的映射关系
map3_4.getCheckpositionList = function()
  local list = {
    {
      leftTop = { 309, 386 },
      rightTop = nil,
      leftBotton = nil,
      rightBotton = nil,
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的
      positionMap = {
        {
          { 309, 386, 0x212d42 }, { 492, 386, 0x293d4a }, { 675, 386, 0x21354a }, { 859, 386, 0x19253a }, { 1043, 386, 0x192842 },
          { 1226, 386, 0x314552 }, { 1410, 386, 0x314d63 }, { 1593, 386, 0x19283a }, { 1778, 386, 0x29394a },
        },
        {
          { 280, 513, 0x000000 }, { 472, 513, 0x19798c }, { 663, 513, 0x298194 }, { 855, 513, 0x198194 }, { 1046, 513, 0x106d84 },
          { 1238, 513, 0x107184 }, { 1428, 513, 0x73595a }, { 1619, 514, 0x427d73 }, { 1814, 515, 0x000000 },
        },
        {
          { 249, 653, 0x000000 }, { 449, 653, 0x218194 }, { 649, 653, 0x298194 }, { 850, 653, 0x086984 }, { 1050, 653, 0x085173 },
          { 1251, 653, 0x194d7b }, { 1451, 653, 0x216184 }, { 1651, 653, 0x19698c }, { 1853, 653, 0x000000 },
        },
        {
          { 214, 807, 0x000000 }, { 424, 807, 0x216184 }, { 634, 807, 0x19618c }, { 845, 807, 0x105d84 }, { 1055, 807, 0x21457b },
          { 1265, 807, 0x10497b }, { 1475, 807, 0x214d84 }, { 1685, 807, 0x4a618c }, { 1896, 807, 0x000000 },
        },
        {
          { 176, 981, 0x000000 }, { 397, 981, 0x000000 }, { 618, 981, 0x000000 }, { 839, 981, 0x000000 }, { 1060, 981, 0xa4595a },
          { 1279, 981, 0x424142 }, { 1503, 981, 0x101010 }, { 1720, 981, 0x6b3500 }, { 1950, 981, 0x6b3500 },
        }
      },
      pointMap = {},
    },
  }
  for key, value in ipairs(list) do
    local positionMap = list[key].positionMap
    for rowNum, rol in ipairs(positionMap) do
      for colNum, col in ipairs(positionMap[rowNum]) do
        if col then
          list[key].pointMap[rowNum .. '-' .. colNum] = col
        end
      end
    end
  end
  return list
end

-- 获取地图棋盘和相关数据
map3_4.getMapChessboard = function()
  return {
    width = 8,
    height = 4,
    obstacle = {},
    waitForBossPosition = { { 3, 8 } },
    bossPosition = {},
    myFleetList = {},
    enemyPositionList = {},
  }
end



map3_4.getMapPosition = function()
  return mapBase.getMapPosition(img3_4)
end

map3_4.moveMapToCheckPosition = function(currentPosition, targetPosition)
  return mapBase.moveMapToCheckPosition(img3_4, currentPosition, targetPosition)
end

map3_4.scanMap = function(targetPosition, mapChessboard)
  return mapBase.scanMap(img3_4, targetPosition, mapChessboard)
end

map3_4.moveToPoint = function(targetPosition, point)
  return mapBase.moveToPoint(img3_4, targetPosition, point)
end

map3_4.findClosestEnemy = function(mapChessboard)
  return mapBase.findClosestEnemy(img3_4, mapChessboard)
end

return map3_4