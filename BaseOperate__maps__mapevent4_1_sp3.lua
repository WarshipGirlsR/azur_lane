local mapBase = require 'BaseOperate__maps__map'
local imgevent4_1_sp3 = require 'BaseOperate__maps__imgevent4_1_sp3'
local mapevent4_1_sp3 = {}

-- 获取地图采样位置。由于地图可能超出一屏，所以这里可以定义多个采样位置。每次扫描都会对每个采样位置进行扫描
-- 标志位为地图四个角。每个采样位置只需定义一个角的坐标即可。
-- 还需要定义每个采样位置的地图矩阵与屏幕坐标的映射关系
mapevent4_1_sp3.getCheckpositionList = function()
  local list = {
    {
      leftTop = { 526, 473 },
      rightTop = nil,
      leftBotton = nil,
      rightBotton = nil,
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的
      positionMap = {
        { { 526, 473, 0x4a2d08 }, { 687, 473, 0x4a4542 }, { 850, 473, 0x080400 }, { 1013, 473, 0x211c21 }, { 1176, 473, 0x212021 }, { 1339, 473, 0x212429 }, },
        { { 508, 589, 0x000000 }, { 675, 589, 0x292831 }, { 846, 589, 0x212421 }, { 1015, 589, 0x4a3929 }, { 1184, 589, 0x422d21 }, { 1353, 589, 0x423531 }, },
        { { 490, 715, 0xdeae00 }, { 665, 715, 0x292829 }, { 841, 715, 0x423521 }, { 1017, 715, 0x4a3119 }, { 1194, 715, 0x42454a }, { 1369, 715, 0x3a3531 }, },
        { { 470, 852, 0x000000 }, { 653, 852, 0x292829 }, { 837, 852, 0x100c08 }, { 1019, 852, 0x4a2d19 }, { 1203, 852, 0x4a2d21 }, { 1386, 852, 0x3a2d29 }, },
      },
      pointMap = {},
    },
    {
      leftTop = nil,
      rightTop = { 1640, 446 },
      leftBotton = nil,
      rightBotton = nil,
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的
      positionMap = {
        { false, false, false, false, false, { 987, 446, 0x191819 }, { 1150, 446, 0x292429 }, { 1313, 446, 0x212021 }, { 1475, 446, 0x212021 }, { 1640, 446, 0x191821 }, },
        { false, false, false, false, false, { 988, 562, 0x42313a }, { 1157, 562, 0x3a3529 }, { 1326, 562, 0x63413a }, { 1495, 562, 0x844929 }, { 1667, 562, 0x000000 }, },
        { false, false, false, false, false, { 989, 687, 0x3a3531 }, { 1165, 687, 0x3a3131 }, { 1341, 687, 0x4a3529 }, { 1517, 687, 0x7b4131 }, { 1695, 687, 0x000000 }, },
        { false, false, false, false, false, { 990, 823, 0x292421 }, { 1174, 823, 0x292821 }, { 1357, 823, 0x423129 }, { 1541, 823, 0x523929 }, { 1726, 823, 0x000000 }, },
      },
      pointMap = {},
    },
    {
      leftTop = { 502, 231 },
      rightTop = nil,
      leftBotton = nil,
      rightBotton = nil,
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的
      positionMap = {
        false, false, false,
        { { 444, 580, 0x000000 }, { 626, 580, 0x292d31 }, { 809, 580, 0x292421 }, { 993, 580, 0x4a2d21 }, { 1176, 580, 0x523121 }, { 1360, 580, 0x3a2c29 }, },
        { { 421, 718, 0x000000 }, { 611, 718, 0x292829 }, { 803, 718, 0x312829 }, { 995, 718, 0x312421 }, { 1186, 718, 0x422d21 }, { 1378, 718, 0x312829 }, },
        { { 396, 868, 0x000000 }, { 595, 868, 0x312419 }, { 795, 868, 0x292821 }, { 996, 868, 0x3a2829 }, { 1196, 868, 0x312829 }, { 1397, 868, 0x212429 }, },
      },
      pointMap = {},
    },
    {
      leftTop = nil,
      rightTop = { 1645, 221 },
      leftBotton = nil,
      rightBotton = nil,
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的
      positionMap = {
        false, false, false,
        { false, false, false, false, false, { 996, 568, 0x3a2d29 }, { 1179, 568, 0x292d29 }, { 1363, 568, 0x3a2821 }, { 1546, 568, 0x523529 }, { 1733, 568, 0x424952 }, },
        { false, false, false, false, false, { 997, 705, 0x312829 }, { 1189, 705, 0x312831 }, { 1380, 705, 0x312821 }, { 1572, 705, 0x312821 }, { 1767, 705, 0x080400 }, },
        { false, false, false, false, false, { 999, 855, 0x292429 }, { 1200, 855, 0x192021 }, { 1400, 855, 0x212421 }, { 1600, 855, 0x292821 }, { 1803, 855, 0x000000 }, },
      },
      pointMap = {},
    },
    {
      leftTop = nil,
      rightTop = nil,
      leftBotton = { 311, 900 },
      rightBotton = nil,
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的
      positionMap = {
        false, false, false, false, false,
        { { 402, 422, 0x000000 }, { 601, 422, 0x312419 }, { 802, 422, 0x313542 }, { 1001, 422, 0x292421 }, { 1202, 422, 0x312829 }, { 1402, 422, 0x292829 }, },
        { { 375, 565, 0x000000 }, { 583, 565, 0x4a2810 }, { 793, 565, 0x422821 }, { 1003, 565, 0x292831 }, { 1213, 565, 0x212429 }, { 1424, 565, 0x192021 }, },
        { { 345, 723, 0x000000 }, { 564, 723, 0x312019 }, { 784, 723, 0x292019 }, { 1005, 723, 0x212429 }, { 1226, 723, 0x192021 }, { 1448, 723, 0x192019 }, },
        { { 311, 900, 0x000000 }, { 542, 900, 0x000000 }, { 775, 900, 0x000000 }, { 1008, 900, 0x000000 }, { 1241, 900, 0x000000 }, { 1474, 900, 0x000000 }, },
      },
      pointMap = {},
    },
    {
      leftTop = nil,
      rightTop = nil,
      leftBotton = nil,
      rightBotton = { 1719, 903 },
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的
      positionMap = {
        false, false, false, false, false,
        { false, false, false, false, false, { 809, 426, 0x212421 }, { 1010, 426, 0x292831 }, { 1210, 426, 0x312d31 }, { 1411, 426, 0x312d29 }, { 1614, 426, 0x000000 }, },
        { false, false, false, false, false, { 802, 569, 0x192019 }, { 1012, 569, 0x192021 }, { 1222, 569, 0x192421 }, { 1433, 569, 0x292831 }, { 1646, 569, 0x000000 }, },
        { false, false, false, false, false, { 795, 727, 0x212429 }, { 1018, 727, 0x192021 }, { 1236, 727, 0x192021 }, { 1456, 727, 0x192021 }, { 1681, 727, 0x000000 }, },
        { false, false, false, false, false, { 786, 903, 0x000000 }, { 1018, 903, 0x000000 }, { 1251, 903, 0x000000 }, { 1483, 903, 0x000000 }, { 1719, 903, 0x000000 }, },
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
mapevent4_1_sp3.getMapChessboard = function()
  return {
    width = 9,
    height = 8,
    obstacle = {},
    waitForBossPosition = { { 1, 6 } },
    bossPosition = {},
    myFleetList = {},
    enemyPositionList = {},
    inBattleList = {},
  }
end

mapevent4_1_sp3.getMapPosition = function()
  return mapBase.getMapPosition(imgevent4_1_sp3)
end

mapevent4_1_sp3.getMoveVector = function(currentPosition, targetPosition)
  return mapBase.getMoveVector(imgevent4_1_sp3, currentPosition, targetPosition)
end

mapevent4_1_sp3.moveMapToCheckPosition = function(moveVector)
  return mapBase.moveMapToCheckPosition(imgevent4_1_sp3, moveVector)
end

mapevent4_1_sp3.scanMap = function(targetPosition, mapChessboard)
  return mapBase.scanMap(imgevent4_1_sp3, targetPosition, mapChessboard)
end

mapevent4_1_sp3.moveToPoint = function(targetPosition, point)
  return mapBase.moveToPoint(imgevent4_1_sp3, targetPosition, point)
end

mapevent4_1_sp3.findClosestEnemy = function(mapChessboard)
  return mapBase.findClosestEnemy(imgevent4_1_sp3, mapChessboard)
end

return mapevent4_1_sp3