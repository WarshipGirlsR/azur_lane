-- -1 = 障碍物
-- 0 = 空格
-- 1 = 玩家舰队1
-- 2 = 玩家舰队2
-- 3 = 玩家舰队3
-- 4 = 玩家舰队4
-- 5 = 未知玩家舰队
-- 11 ~ 20 = 敌方舰队
-- 21 ~ 30 = 奖励

local baseMap = {
  { -1, -1, -1, -1, -1, -1, -1, -1, -1, -1 },
  { -1, 0, 0, 0, 0, 0, -1, -1, -1, -1 },
  { -1, 0, 0, 0, 0, 0, 21, -1, -1, -1 },
  { -1, -1, 0, 0, 0, 0, 0, 0, 0, -1 },
  { -1, 0, 0, 0, 0, 0, 0, 0, 0, -1 },
  { -1, -1, -1, -1, -1, -1, -1, -1, -1, -1 },
}

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

end

return {
  height = 4,
  width = 8,
  baseMap = baseMap,
}