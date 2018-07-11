local mapBase = require './map'
local imgEvent = require './img10-3'
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
      leftTop = { 494, 507 },
      rightTop = nil,
      leftBotton = nil,
      rightBotton = nil,
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的
      positionMap = {
        { { 494, 507, 0x080c19 }, { 662, 507, 0x29243a }, { 832, 507, 0x101421 }, { 1001, 507, 0x191831 }, { 1170, 507, 0x101829 }, { 1340, 507, 0x101c31 }, },
        { { 476, 630, 0x000000 }, { 651, 630, 0x191831 }, { 827, 630, 0x21183a }, { 1003, 630, 0x211c3a }, { 1179, 630, 0x212042 }, { 1354, 630, 0x292442 }, },
        { { 455, 763, 0x000000 }, { 638, 763, 0x191831 }, { 821, 763, 0x212042 }, { 1004, 763, 0x191831 }, { 1188, 763, 0x21203a }, { 1372, 763, 0x191c31 }, },
        { { 433, 908, 0x000000 }, { 623, 908, 0x211831 }, { 815, 908, 0x191831 }, { 1006, 908, 0x212042 }, { 1198, 908, 0x21203a }, { 1390, 908, 0x21243a }, },
      },
      pointMap = {},
    },
    {
      leftTop = nil,
      rightTop = { 1607, 505 },
      leftBotton = nil,
      rightBotton = nil,
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的
      positionMap = {
        { false, false, false, false, false, { 928, 505, 0x191429 }, { 1097, 505, 0x191831 }, { 1266, 505, 0x101831 }, { 1436, 505, 0x191c31 }, { 1607, 505, 0x192031 }, },
        { false, false, false, false, false, { 927, 627, 0x292442 }, { 1102, 627, 0x19203a }, { 1279, 627, 0x312d4a }, { 1455, 627, 0x3a3563 }, { 1633, 627, 0x000000 }, },
        { false, false, false, false, false, { 925, 761, 0x292042 }, { 1109, 761, 0x292042 }, { 1292, 761, 0x191831 }, { 1476, 761, 0x212442 }, { 1661, 761, 0x000000 }, },
        { false, false, false, false, false, { 923, 906, 0x211831 }, { 1115, 906, 0x211c3a }, { 1307, 906, 0x211c3a }, { 1498, 906, 0x31244a }, { 1692, 906, 0x000000 }, },
      },
      pointMap = {},
    },
    {
      leftTop = { 561, 257 },
      rightTop = nil,
      leftBotton = nil,
      rightBotton = nil,
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的
      positionMap = {
        false, false, false,
        { { 508, 625, 0x000000 }, { 698, 625, 0x191431 }, { 890, 625, 0x191831 }, { 1081, 625, 0x211c3a }, { 1273, 625, 0x211c3a }, { 1465, 625, 0x292042 }, },
        { { 487, 771, 0x000000 }, { 686, 771, 0x292d29 }, { 886, 771, 0x31354a }, { 1087, 771, 0x211c3a }, { 1288, 771, 0x191429 }, { 1488, 771, 0x191829 }, },
        { { 462, 931, 0x100800 }, { 672, 931, 0xbdc6bd }, { 883, 931, 0x21183a }, { 1094, 931, 0x191831 }, { 1304, 931, 0x191421 }, { 1515, 931, 0x191419 }, },
      },
      pointMap = {},
    },
    {
      leftTop = nil,
      rightTop = { 1493, 249 },
      leftBotton = nil,
      rightBotton = nil,
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的
      positionMap = {
        false, false, false,
        { false, false, false, false, false, { 795, 616, 0x211831 }, { 987, 616, 0x211c31 }, { 1178, 616, 0x292042 }, { 1370, 616, 0x29244a }, { 1564, 616, 0x000000 }, },
        { false, false, false, false, false, { 787, 761, 0x191c31 }, { 988, 761, 0x191429 }, { 1188, 761, 0x191831 }, { 1389, 761, 0x292042 }, { 1592, 761, 0x000000 }, },
        { false, false, false, false, false, { 779, 920, 0x191829 }, { 989, 920, 0x191831 }, { 1199, 920, 0x211831 }, { 1410, 920, 0x191821 }, { 1623, 920, 0x080c08 }, },
      },
      pointMap = {},
    },
    {
      leftTop = nil,
      rightTop = nil,
      leftBotton = { 446, 909 },
      rightBotton = nil,
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的
      positionMap = {
        false, false, false, false, false,
        { { 493, 574, 0x8c2829 }, { 703, 574, 0xfffbff }, { 914, 574, 0x211c42 }, { 1124, 574, 0x212042 }, { 1334, 574, 0x211c42 }, },
        { { 472, 732, 0x000000 }, { 691, 732, 0x211831 }, { 912, 732, 0x211c42 }, { 1133, 732, 0x191831 }, { 1353, 732, 0x191831 }, },
        { { 446, 909, 0x000000 }, { 677, 909, 0x000000 }, { 910, 909, 0x000000 }, { 1143, 909, 0x000000 }, { 1375, 909, 0x000000 }, },
      },
      pointMap = {},
    },
    {
      leftTop = nil,
      rightTop = nil,
      leftBotton = nil,
      rightBotton = { 1630, 912 },
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的
      positionMap = {
        false, false, false, false, false,
        { false, false, false, false, { 512, 576, 0x211c42 }, { 722, 576, 0x211c3a }, { 932, 576, 0x211c42 }, { 1142, 576, 0x211c3a }, { 1352, 576, 0x292042 }, { 1565, 576, 0x000000 }, },
        { false, false, false, false, { 489, 735, 0x191c31 }, { 710, 735, 0x191421 }, { 931, 735, 0x211c3a }, { 1152, 735, 0x191829 }, { 1373, 735, 0x211c3a }, { 1596, 735, 0x000000 }, },
        { false, false, false, false, { 464, 912, 0x000000 }, { 696, 912, 0x000000 }, { 929, 912, 0x000000 }, { 1162, 912, 0x000000 }, { 1395, 912, 0x000000 }, { 1630, 912, 0x000000 }, },
      },
      pointMap = {},
    },
  })
  return list
end

-- 获取地图棋盘和相关数据
mapEvent.getMapChessboard = function()
  return {
    width = 9,
    height = 6,
    obstacle = {
      { 1, 7 },
      { 2, 2 }, { 2, 3 }, { 2, 4 }, { 2, 7 },
      { 4, 3 }, { 4, 4 }, { 4, 7 },
      { 5, 5 }, { 5, 6 }, { 5, 7 },
      { 6, 1 },
    },
    waitForBossPosition = { { 1, 6 } },
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