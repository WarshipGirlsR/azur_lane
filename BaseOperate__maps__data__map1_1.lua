local map1_1 = {}

-- 获取地图采样位置。由于地图可能超出一屏，所以这里可以定义多个采样位置。每次扫描都会对每个采样位置进行扫描
-- 标志位为地图四个角。每个采样位置只需定义一个角的坐标即可。
-- 还需要定义每个采样位置的地图矩阵与屏幕坐标的映射关系
map1_1.getCheckpositionList = function()
  return {
    {
      leftTop = { 377, 540 },
      rightTop = nil,
      leftBotton = nil,
      rightBotton = nil,
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的
      positionMap = {
        { { 377, 540, 0x192842 }, { 559, 540, 0xbdbabd }, { 744, 540, 0x21354a }, { 927, 540, 0x21394a }, { 1111, 540, 0x21394a }, { 1294, 540, 0x213952 }, { 1478, 540, 0x21354a }, { 1662, 540, 0x21354a }, },
        { { 352, 676, 0x000000 }, { 543, 676, 0x000000 }, { 734, 676, 0x000000 }, { 926, 676, 0x000000 }, { 1117, 676, 0x000000 }, { 1309, 676, 0x000000 }, { 1500, 676, 0x000000 }, { 1693, 676, 0x000000 }, }
      },
    },
  }
end

-- 获取地图棋盘和相关数据
map1_1.getMapChessboard = function()
  return {
    width = 7,
    height = 1,
    obstacle = {},
    waitForBossPosition = {},
    bossPosition = {},
    myFleetList = {},
    enemyPositionList = {},
  }
end

return map1_1