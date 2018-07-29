local mapBase = require './map'
local imgEvent = require './img9-3'
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
      leftTop = nil,
      rightTop = { 1670, 505 },
      leftBottom = nil,
      rightBottom = nil,
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的
      positionMap = {
        { { 315, 505, 0x102431 }, { 483, 505, 0x10283a }, { 653, 505, 0x19243a }, { 822, 505, 0x102031 }, { 991, 505, 0x10203a }, { 1160, 505, 0x10203a }, { 1330, 505, 0x10243a }, { 1499, 505, 0x192d42 }, { 1670, 505, 0x10283a }, },
        { { 289, 628, 0x000000 }, { 465, 628, 0x191831 }, { 640, 628, 0x29244a }, { 816, 628, 0x212442 }, { 992, 628, 0x292042 }, { 1168, 628, 0x292442 }, { 1345, 628, 0x292442 }, { 1522, 628, 0x4a417b }, { 1699, 628, 0x000000 }, },
        { { 260, 761, 0x212000 }, { 443, 761, 0x292d29 }, { 627, 761, 0x21203a }, { 811, 761, 0x21203a }, { 994, 761, 0x191c3a }, { 1179, 761, 0xe6a263 }, { 1361, 761, 0x291c42 }, { 1544, 761, 0x21203a }, { 1730, 761, 0x000000 }, },
        { { 230, 906, 0x000000 }, { 421, 906, 0x191831 }, { 612, 906, 0x212042 }, { 804, 906, 0x211c3a }, { 995, 906, 0x9ca2b5 }, { 1186, 906, 0x212042 }, { 1379, 906, 0x291c3a }, { 1570, 906, 0x292442 }, { 1764, 906, 0x000000 }, },
      },
      pointMap = {},
    },
    {
      leftTop = nil,
      rightTop = { 1680, 373 },
      leftBottom = nil,
      rightBottom = nil,
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的
      positionMap = {
        false, false, false,
        { { 241, 757, 0x000000 }, { 431, 757, 0x211c3a }, { 623, 757, 0x191c3a }, { 815, 757, 0x211c3a }, { 1007, 757, 0x9ca2b5 }, { 1198, 757, 0x9caebd }, { 1390, 757, 0x191831 }, { 1581, 757, 0x292042 }, { 1775, 757, 0x000000 }, },
        { { 208, 908, 0x000000 }, { 407, 908, 0x191831 }, { 608, 908, 0x211410 }, { 808, 908, 0x211c42 }, { 1008, 908, 0x212042 }, { 1209, 908, 0x191831 }, { 1410, 908, 0x21203a }, { 1610, 908, 0x292042 }, { 1813, 908, 0x000000 }, },
      },
      pointMap = {},
    },
    {
      leftTop = nil,
      rightTop = nil,
      leftBottom = nil,
      rightBottom = { 1768, 903 },
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的
      positionMap = {
        false, false, false, false,
        { { 88, 584, 0x000000 }, { 287, 584, 0x191831 }, { 488, 584, 0xbd3d00 }, { 689, 584, 0x191831 }, { 889, 584, 0x211c31 }, { 1089, 584, 0x191c31 }, { 1290, 584, 0x292442 }, { 1490, 584, 0x292042 }, { 1693, 584, 0x000000 }, },
        { { 44, 735, 0x9475b5 }, { 255, 735, 0x211c3a }, { 465, 735, 0x21183a }, { 675, 735, 0x21183a }, { 886, 735, 0x191429 }, { 1096, 735, 0x191421 }, { 1306, 735, 0x191829 }, { 1516, 735, 0x191829 }, { 1729, 735, 0x000000 }, },
        { { 0, 903, 0x101410 }, { 219, 903, 0x000000 }, { 440, 903, 0x000000 }, { 660, 903, 0x000000 }, { 881, 903, 0x000000 }, { 1102, 903, 0x000000 }, { 1323, 903, 0x000000 }, { 1545, 903, 0x000000 }, { 1768, 903, 0x000000 }, },
      },
      pointMap = {},
    },
  })
  return list
end

-- 获取地图棋盘和相关数据
mapEvent.getMapChessboard = function()
  return {
    width = 8,
    height = 6,
    obstacle = {
      { 1, 7 },
      { 2, 2 }, { 2, 3 }, { 2, 4 }, { 2, 7 },
      { 3, 5 },
      { 4, 4 },
      { 5, 1 }, { 5, 5 }, { 5, 6 }, { 5, 7 },
      { 6, 1 }, { 6, 2 },
    },
    waitForBossPosition = { { 1, 1 }, { 1, 8 }, { 2, 5 }, { 5, 4 }, { 6, 8 } },
    bossPosition = {},
    myFleetList = {},
    enemyPositionList1 = {},
    enemyPositionList2 = {},
    enemyPositionList3 = {},
    movableEnemyPositionList = {},
    inBattleList = {},
    selectedArrowList = {},
    rewardBoxList = {},
  }
end

return mapEvent