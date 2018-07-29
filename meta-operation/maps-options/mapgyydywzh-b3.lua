-- 光与影的鸢尾之华
local mapBase = require './map'
local imgEvent = require './imggyydywzh-b3'
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
      leftTop = { 730, 331 },
      rightTop = nil,
      leftBottom = nil,
      rightBottom = nil,
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的
      positionMap = {
        { { 730, 331, 0x080000 }, false, false, false, false, false, { 1716, 331, 0x10283a }, },
        { { 724, 457, 0x000000 }, false, false, false, false, false, { 1737, 457, 0x29415a }, },
        { { 717, 592, 0x000000 }, false, false, false, false, false, { 1761, 592, 0x293d52 }, },
        { { 709, 735, 0x000000 }, false, false, false, false, false, { 1785, 735, 0x31455a }, },
        { { 701, 887, 0x000000 }, false, false, false, false, false, { 1811, 887, 0x31455a }, }
      },
      pointMap = {},
    },
    {
      leftTop = nil,
      rightTop = { 1686, 331 },
      leftBottom = nil,
      rightBottom = nil,
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的
      positionMap = {
        { false, { 368, 331, 0x10283a }, false, false, false, false, false, false, false, { 1686, 331, 0x102842 }, },
        { false, { 351, 457, 0x525563 }, false, false, false, false, false, false, false, { 1707, 457, 0x000000 }, },
        { false, { 333, 592, 0x42495a }, false, false, false, false, false, false, false, { 1729, 592, 0x000000 }, },
        { false, { 314, 735, 0x314152 }, false, false, false, false, false, false, false, { 1752, 735, 0x000000 }, },
        { false, { 294, 887, 0x31415a }, false, false, false, false, false, false, false, { 1778, 887, 0x31494a }, },
      },
      pointMap = {},
    },
    {
      leftTop = { 638, 216 },
      rightTop = nil,
      leftBottom = nil,
      rightBottom = nil,
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的
      positionMap = {
        { { 638, 216, 0x293531 }, false, false, false, false, false, { 1624, 216, 0x293d4a }, },
        { { 629, 339, 0x000000 }, false, false, false, false, false, { 1643, 339, 0x29415a }, },
        { { 619, 470, 0x000000 }, false, false, false, false, false, { 1663, 470, 0x293d52 }, },
        { { 608, 610, 0x211800 }, false, false, false, false, false, { 1685, 610, 0x29455a }, },
        { { 598, 758, 0x000000 }, false, false, false, false, false, { 1708, 758, 0x3a4563 }, },
        { { 586, 915, 0x000000 }, false, false, false, false, false, { 1732, 915, 0x101c21 }, },
      },
      pointMap = {},
    },
    {
      leftTop = nil,
      rightTop = { 1616, 219 },
      leftBottom = nil,
      rightBottom = nil,
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的
      positionMap = {
        { false, { 298, 219, 0x10283a }, false, false, false, false, false, false, false, { 1616, 219, 0x19313a }, },
        { false, { 279, 342, 0x525563 }, false, false, false, false, false, false, false, { 1634, 342, 0x000000 }, },
        { false, { 259, 474, 0x42495a }, false, false, false, false, false, false, false, { 1654, 474, 0x000000 }, },
        { false, { 237, 613, 0x42455a }, false, false, false, false, false, false, false, { 1676, 613, 0x000000 }, },
        { false, { 215, 761, 0x3a4563 }, false, false, false, false, false, false, false, { 1700, 761, 0x314d52 }, },
        { false, { 190, 919, 0x524d5a }, false, false, false, false, false, false, false, { 1722, 919, 0x212421 }, },
      },
      pointMap = {},
    },
    {
      leftTop = nil,
      rightTop = nil,
      leftBottom = { 550, 912 },
      rightBottom = nil,
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的
      positionMap = {
        false, false, false, false,
        { { 526, 166, 0x000000 }, false, false, false, false, false, { 1635, 166, 0x31455a }, },
        { { 512, 304, 0x000000 }, false, false, false, false, false, { 1657, 304, 0x293d5a }, },
        { { 496, 452, 0x000000 }, false, false, false, false, false, { 1681, 452, 0x313d5a }, },
        { { 479, 610, 0xdeb673 }, false, false, false, false, false, { 1706, 610, 0x313d63 }, },
        { { 463, 779, 0x8c0c10 }, false, false, false, false, false, { 1733, 779, 0x212d5a }, },
        { { 444, 964, 0x000000 }, false, false, false, false, false, { 1764, 964, 0xd67921 }, },
      },
      pointMap = {},
    },
    {
      leftTop = nil,
      rightTop = nil,
      leftBottom = nil,
      rightBottom = { 1711, 974 },
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的
      positionMap = {
        false, false, false, false,
        { false, false, { 294, 174, 0x636173 }, false, false, false, false, false, false, { 1594, 174, 0x314952 }, },
        { false, false, { 271, 312, 0xce9e9c }, false, false, false, false, false, false, { 1613, 312, 0x000000 }, },
        { false, false, { 249, 460, 0x424563 }, false, false, false, false, false, false, { 1635, 460, 0x000000 }, },
        { false, false, { 224, 619, 0x3a415a }, false, false, false, false, false, false, { 1658, 619, 0x000000 }, },
        { false, false, { 198, 788, 0x313d63 }, false, false, false, false, false, false, { 1684, 788, 0x000000 }, },
        { false, false, { 169, 974, 0x000000 }, false, false, false, false, false, false, { 1711, 974, 0xde7508 }, },
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
    height = 9,
    obstacle = {
      { 1, 3 }, { 1, 4 },
      { 2, 3 }, { 2, 4 },
      { 4, 7 }, { 4, 8 }, { 4, 9 },
      { 5, 3 }, { 5, 9 },
      { 6, 3 }, { 6, 7 }, { 6, 8 }, { 6, 9 },
      { 7, 5 },
      { 8, 5 },
      { 9, 6 },
    },
    waitForBossPosition = { { 5, 8 }, },
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