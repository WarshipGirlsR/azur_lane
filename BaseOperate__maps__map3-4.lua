local mapUtils = require 'BaseOperate__maps__utils'

local baseMap = {}
baseMap.row = 4;
baseMap.col = 8;
baseMap.leftTop = { 279, 374 };
baseMap.rightTop = { 1753, 374 };
baseMap.LeftBotton = { 140, 970 };
baseMap.rightBotton = { 915, 970 };
baseMap.cellHeight = {
  { 830, 374, 0x212d42 },
  { 825, 503, 0x198194 },
  { 818, 643, 0x086984 },
  { 812, 797, 0x085584 },
  { 804, 970, 0x000000 },
};
-- 障碍物位置
baseMap.obstacle = {
  { 6, 1 },
  { 7, 1 },
  { 8, 1 },
  { 7, 2 },
  { 8, 2 },
};
-- boss等待区
baseMap.waitForBossPosition = {
  { 8, 3 },
  { 8, 4 },
};
-- boss位置
baseMap.bossPosition = {
  { 8, 3 },
  { 8, 4 },
};
-- 敌人位置
baseMap.enemyPosition = {};
-- 每个格子对应的屏幕坐标
-- 格式
-- positionToPointMap = {
--   ['1-1'] = { 300, 300 },
--   ['1-2'] = { 300, 350 },
-- }
baseMap.positionToPointMap = mapUtils.getPositionToPointMap(baseMap)
-- 输入一个格子转换成屏幕坐标
baseMap.positionToPoint = function(position)
  return mapUtils.positionToPoint(position, baseMap.positionToPointMap)
end
-- 输入一个坐标转换成位置
baseMap.pointToPosition = function(point)
  return mapUtils.pointToPosition(point, baseMap.crossingsPointMap)
end

function copyMap()
  local newMap = {};
  local baseMapHeight = #baseMap;
  local baseMapWidth = #baseMap[1];
  for i = 1, baseMapHeight do
    newMap[i] = {}
    for j = 1, baseMapWidth do
      newMap[i][j] = baseMap[i][j]
    end
  end
  return newMap
end

function scanMap()
  return mapUtils.scanMap(baseMap)
end

return baseMap