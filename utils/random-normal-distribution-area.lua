-- 正态分布
local function normalDistribution(x, u, q)
  u = u or 0
  q = q or 1
  return 1 / math.sqrt(2 * math.pi) * math.exp(0 - math.pow(x - u, 2) / 2 * math.pow(q, 2))
end

local function randomNormalDistributionArea(x1, y1, x2, y2)
  math.randomseed(os.time())
  local randX = math.random() * math.abs(x1 - x2)
  local randY = math.random() * math.abs(y1 - y2)
  
  local resultX = normalDistribution(randX) + math.min(x1, x2)
  local resultY = normalDistribution(randY) + math.min(y1, y2)
end

return randomNormalDistributionArea
