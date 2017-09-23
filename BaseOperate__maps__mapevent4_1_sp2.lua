local mapBase = require 'BaseOperate__maps__map'
local imgevent4_1_sp2 = require 'BaseOperate__maps__imgevent4_1_sp2'
local mapevent4_1_sp2 = {}

-- 获取地图采样位置。由于地图可能超出一屏，所以这里可以定义多个采样位置。每次扫描都会对每个采样位置进行扫描
-- 标志位为地图四个角。每个采样位置只需定义一个角的坐标即可。
-- 还需要定义每个采样位置的地图矩阵与屏幕坐标的映射关系
mapevent4_1_sp2.getCheckpositionList = function()
  local list = {
    {
      leftTop = nil,
      rightTop = { 1597, 503 },
      leftBotton = nil,
      rightBotton = nil,
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的
      positionMap = {
        { { 455, 503, 0x312021 }, { 617, 503, 0x101819 }, { 780, 503, 0x101408 }, { 943, 503, 0x100810 }, { 1106, 503, 0x080808 }, { 1269, 503, 0x080c08 }, { 1432, 503, 0x211c10 }, { 1597, 503, 0x000808 }, },
        { { 436, 620, 0x000000 }, { 604, 620, 0x292831 }, { 773, 620, 0x3a2821 }, { 942, 620, 0x523129 }, { 1111, 620, 0x292d29 }, { 1281, 620, 0x423529 }, { 1450, 620, 0xa48184 }, { 1621, 620, 0x000000 }, },
        { { 415, 748, 0x000000 }, { 590, 748, 0x313131 }, { 766, 748, 0x523129 }, { 942, 748, 0x633529 }, { 1118, 748, 0x423539 }, { 1294, 748, 0x423131 }, { 1470, 748, 0x633929 }, { 1648, 748, 0x000000 }, },
        { { 392, 886, 0x000000 }, { 574, 886, 0x312d31 }, { 757, 886, 0x422821 }, { 941, 886, 0x422821 }, { 1125, 886, 0x292821 }, { 1308, 886, 0x292429 }, { 1491, 886, 0x422821 }, { 1677, 886, 0x000000 }, },
      },
      pointMap = {},
    },
    {
      leftTop = nil,
      rightTop = { 1617, 269 },
      leftBotton = nil,
      rightBotton = nil,
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的
      positionMap = {
        false, false, false,
        { { 415, 622, 0x312d31 }, { 597, 622, 0x212829 }, { 780, 622, 0x423129 }, { 963, 622, 0x422821 }, { 1146, 622, 0x3a313a }, { 1331, 622, 0x212021 }, { 1514, 622, 0x423121 }, { 1700, 622, 0x000000 }, },
        { { 390, 762, 0x000000 }, { 581, 762, 0x292821 }, { 772, 762, 0x3a2d29 }, { 963, 762, 0x312421 }, { 1155, 762, 0x292829 }, { 1347, 762, 0x292829 }, { 1538, 762, 0x3a3131 }, { 1732, 762, 0x000000 }, },
        { { 362, 914, 0x3a2429 }, { 562, 914, 0x424142 }, { 764, 914, 0xffb229 }, { 963, 914, 0x292829 }, { 1165, 914, 0x212021 }, { 1364, 914, 0x211c21 }, { 1566, 914, 0x211c21 }, { 1768, 914, 0x100c10 }, },
      },
      pointMap = {},
    },
    {
      leftTop = nil,
      rightTop = nil,
      leftBotton = nil,
      rightBotton = { 1799, 887 },
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的
      positionMap = {
        false, false, false, false, false,
        { { 317, 569, 0x000000 }, { 516, 569, 0x3a2019 }, { 716, 569, 0x212021 }, { 916, 569, 0x212421 }, { 1118, 569, 0x192019 }, { 1318, 569, 0x192021 }, { 1518, 569, 0x212021 }, { 1721, 569, 0x000000 }, },
        { { 286, 720, 0x000000 }, { 494, 720, 0x422821 }, { 704, 720, 0x292829 }, { 914, 720, 0x292829 }, { 1125, 720, 0x212029 }, { 1335, 720, 0x212421 }, { 1543, 720, 0x313542 }, { 1758, 720, 0x000000 }, },
        { { 251, 887, 0x000000 }, { 471, 887, 0x000000 }, { 692, 887, 0x000000 }, { 912, 887, 0x000000 }, { 1134, 887, 0x000000 }, { 1354, 887, 0x000000 }, { 1575, 887, 0x000000 }, { 1799, 887, 0x000000 }, },
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
mapevent4_1_sp2.getMapChessboard = function()
  return {
    width = 7,
    height = 6,
    obstacle = {},
    waitForBossPosition = { { 5, 7 }, },
    bossPosition = {},
    myFleetList = {},
    enemyPositionList = {},
    inBattleList = {},
  }
end

mapevent4_1_sp2.getMapPosition = function()
  return mapBase.getMapPosition(imgevent4_1_sp2)
end

mapevent4_1_sp2.getMoveVector = function(currentPosition, targetPosition)
  return mapBase.getMoveVector(imgevent4_1_sp2, currentPosition, targetPosition)
end

mapevent4_1_sp2.moveMapToCheckPosition = function(moveVector)
  return mapBase.moveMapToCheckPosition(imgevent4_1_sp2, moveVector)
end

mapevent4_1_sp2.scanMap = function(targetPosition, mapChessboard)
  return mapBase.scanMap(imgevent4_1_sp2, targetPosition, mapChessboard)
end

mapevent4_1_sp2.moveToPoint = function(targetPosition, point)
  return mapBase.moveToPoint(imgevent4_1_sp2, targetPosition, point)
end

mapevent4_1_sp2.findClosestEnemy = function(mapChessboard)
  return mapBase.findClosestEnemy(imgevent4_1_sp2, mapChessboard)
end

return mapevent4_1_sp2