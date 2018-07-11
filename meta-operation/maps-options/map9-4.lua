local mapBase = require './map'
local imgEvent = require './img9-4'
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
      leftTop = { 384, 519 },
      rightTop = nil,
      leftBotton = nil,
      rightBotton = nil,
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的
      positionMap = {
        { { 384, 519, 0x001010 }, { 552, 519, 0x000c10 }, { 721, 519, 0x081419 }, { 890, 519, 0x081019 }, { 1060, 519, 0x081019 }, { 1229, 519, 0x101821 }, },
        { { 361, 643, 0x000000 }, { 536, 643, 0x191429 }, { 712, 643, 0x191831 }, { 888, 643, 0x191831 }, { 1064, 643, 0x191c3a }, { 1240, 643, 0x191c3a }, },
        { { 334, 776, 0x312819 }, { 518, 776, 0x21203a }, { 701, 776, 0x211c3a }, { 885, 776, 0x211c3a }, { 1068, 776, 0x31244a }, { 1252, 776, 0x292042 }, },
        { { 308, 922, 0x000000 }, { 499, 922, 0x424142 }, { 690, 922, 0x212042 }, { 881, 922, 0x211831 }, { 1073, 922, 0x211831 }, { 1265, 922, 0x211831 }, },
      },
      pointMap = {},
    },
    {
      leftTop = nil,
      rightTop = { 1595, 530 },
      leftBotton = nil,
      rightBotton = nil,
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的
      positionMap = {
        { false, false, false, false, false, { 916, 530, 0x191829 }, { 1085, 530, 0x081019 }, { 1254, 530, 0x211829 }, { 1424, 530, 0x191c29 }, { 1595, 530, 0x101829 }, },
        { false, false, false, false, false, { 914, 654, 0x292442 }, { 1090, 654, 0x29284a }, { 1266, 654, 0x313552 }, { 1442, 654, 0x423d63 }, { 1620, 654, 0x000000 }, },
        { false, false, false, false, false, { 912, 788, 0x292042 }, { 1095, 788, 0x212042 }, { 1279, 788, 0x211c3a }, { 1463, 788, 0x21244a }, { 1648, 788, 0x000000 }, },
        { false, false, false, false, false, { 910, 935, 0x191429 }, { 1102, 935, 0x191831 }, { 1293, 935, 0x21203a }, { 1484, 935, 0x292d31 }, { 1679, 935, 0x292829 }, },
      },
      pointMap = {},
    },
    {
      leftTop = nil,
      rightTop = nil,
      leftBotton = { 235, 921 },
      rightBotton = nil,
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的
      positionMap = {
        false, false, false,
        { { 331, 463, 0x000000 }, { 521, 463, 0x101010 }, { 713, 463, 0x191c3a }, { 905, 463, 0x42456b }, { 1097, 463, 0x211c3a }, { 1288, 463, 0x191429 }, },
        { { 300, 601, 0x949694 }, { 501, 601, 0x191c19 }, { 701, 601, 0x29203a }, { 901, 601, 0x31283a }, { 1101, 601, 0xada2ad }, { 1303, 601, 0x211c3a }, },
        { { 270, 752, 0x000000 }, { 479, 752, 0x191831 }, { 689, 752, 0x211831 }, { 899, 752, 0x191831 }, { 1110, 752, 0x211c3a }, { 1320, 752, 0x211c42 }, },
        { { 235, 921, 0x000000 }, { 455, 921, 0x000000 }, { 675, 921, 0x000000 }, { 896, 921, 0x000000 }, { 1118, 921, 0x000000 }, { 1338, 921, 0x000000 }, },
      },
      pointMap = {},
    },
    {
      leftTop = nil,
      rightTop = nil,
      leftBotton = nil,
      rightBotton = { 1724, 933 },
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的
      positionMap = {
        false, false, false,
        { false, false, false, false, false, { 854, 472, 0x211c3a }, { 1045, 472, 0x211831 }, { 1237, 472, 0x211c3a }, { 1428, 472, 0x292442 }, { 1622, 472, 0x000000 }, },
        { false, false, false, false, false, { 849, 611, 0x211c3a }, { 1049, 611, 0x211c31 }, { 1249, 611, 0x211c31 }, { 1450, 611, 0x211c31 }, { 1653, 611, 0x000000 }, },
        { false, false, false, false, false, { 843, 763, 0x211831 }, { 1053, 763, 0x191c31 }, { 1264, 763, 0x3a3563 }, { 1474, 763, 0x191431 }, { 1687, 763, 0x000000 }, },
        { false, false, false, false, false, { 838, 933, 0x000000 }, { 1059, 933, 0x000000 }, { 1280, 933, 0x000000 }, { 1499, 933, 0x101410 }, { 1724, 933, 0x292d29 }, },
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
      { 1, 5 }, { 1, 6 }, { 1, 7 },
      { 2, 2 },
      { 3, 8 },
      { 4, 3 }, { 4, 4 },
      { 5, 4 }, { 5, 7 },
      { 6, 7 },
    },
    waitForBossPosition = { { 1, 1 }, { 1, 9 }, { 6, 9 } },
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