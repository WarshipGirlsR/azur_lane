local mapBase = require 'BaseOperate__maps__map'
local img3_3 = require 'BaseOperate__maps__img3_3'
local map3_3 = {}

-- 获取地图采样位置。由于地图可能超出一屏，所以这里可以定义多个采样位置。每次扫描都会对每个采样位置进行扫描
-- 标志位为地图四个角。每个采样位置只需定义一个角的坐标即可。
-- 还需要定义每个采样位置的地图矩阵与屏幕坐标的映射关系
map3_3.getCheckpositionList = function()
  local list = {
    {
      leftTop = { 540, 476 },
      rightTop = nil,
      leftBotton = nil,
      rightBotton = nil,
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的
      positionMap = {
        { { 540, 476, 0x314152 }, { 702, 476, 0x21354a }, { 865, 476, 0x212842 }, { 1028, 476, 0x29314a }, { 1191, 476, 0x213542 }, { 1354, 476, 0x21354a }, { 1518, 476, 0x21314a }, },
        { { 524, 593, 0x000000 }, { 692, 593, 0x19798c }, { 861, 593, 0x218194 }, { 1030, 593, 0x197984 }, { 1200, 593, 0x217d94 }, { 1369, 593, 0x298194 }, { 1540, 593, 0x000000 }, },
        { { 506, 719, 0x000000 }, { 682, 719, 0x4a8a73 }, { 857, 719, 0x107d8c }, { 1033, 719, 0x196184 }, { 1209, 719, 0x196984 }, { 1386, 719, 0x196184 }, { 1564, 719, 0x000000 }, },
        { { 487, 856, 0x000000 }, { 669, 856, 0x296d94 }, { 853, 856, 0x19658c }, { 1037, 856, 0x105173 }, { 1220, 856, 0x214984 }, { 1404, 856, 0x29618c }, { 1592, 856, 0x843908 }, },
      },
      pointMap = {},
    },
    {
      leftTop = nil,
      rightTop = nil,
      leftBotton = { 450, 880 },
      rightBotton = nil,
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的
      positionMap = {
        false, false, false,
        { { 493, 590, 0x000000 }, { 676, 590, 0x316d94 }, { 859, 590, 0x19658c }, { 1043, 590, 0x085173 }, { 1226, 590, 0x214d8c }, { 1410, 590, 0x29618c }, { 1595, 590, 0x000000 }, },
        { { 473, 727, 0x000000 }, { 663, 727, 0x216994 }, { 855, 727, 0x215d8c }, { 1046, 727, 0x003d6b }, { 1238, 727, 0x10416b }, { 1429, 727, 0x214d7b }, { 1623, 727, 0x000000 }, },
        { { 450, 880, 0x000000 }, { 649, 880, 0x000000 }, { 850, 880, 0x000000 }, { 1050, 880, 0x000000 }, { 1251, 880, 0x000000 }, { 1451, 880, 0x000000 }, { 1654, 880, 0x000000 }, },
      },
      pointMap = {},
    },
  }
  for key, value in ipairs(list) do
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
map3_3.getMapChessboard = function()
  return {
    width = 7,
    height = 4,
    obstacle = {
      { 1, 1 }, { 1, 2 }, { 1, 4 }, { 1, 5 },
      { 2, 1 }, { 2, 2 }, { 3, 2 }
    },
    waitForBossPosition = { { 4, 1 } },
    bossPosition = {},
    myFleetList = {},
    enemyPositionList = {},
    inBattleList = {},
  }
end



map3_3.getMapPosition = function(currentPosition)
  return mapBase.getMapPosition(img3_3, currentPosition)
end

map3_3.getMoveVector = function(currentPosition, targetPosition)
  return mapBase.getMoveVector(img3_3, currentPosition, targetPosition)
end

map3_3.moveMapToCheckPosition = function(moveVector)
  return mapBase.moveMapToCheckPosition(img3_3, moveVector)
end

map3_3.scanMap = function(targetPosition, mapChessboard)
  return mapBase.scanMap(img3_3, targetPosition, mapChessboard)
end

map3_3.moveToPoint = function(targetPosition, point)
  return mapBase.moveToPoint(img3_3, targetPosition, point)
end

map3_3.findClosestEnemy = function(mapChessboard)
  return mapBase.findClosestEnemy(img3_3, mapChessboard)
end

return map3_3