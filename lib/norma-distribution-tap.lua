-- 正态分布
local function normalDistribution(x, u, q)
  u = u or 0
  q = q or 1
  return 1 / math.sqrt(2 * math.pi) * math.exp(0 - math.pow(x - u, 2) / 2 * math.pow(q, 2))
end

-- 正态区域
local function randomNormalDistributionArea(x1, y1, x2, y2)
  math.randomseed(os.time())
  if x2 == nil or y2 == nil then
    local s = x2 or 20
    local randX = (math.random() - 0.5) * (s * 2)
    local randY = (math.random() - 0.5) * (s * 2)
    local resultX = normalDistribution(randX) + x1
    local resultY = normalDistribution(randY) + y1
    return resultX, resultY
  else
    local randX = (math.random() - 0.5) * math.abs(x1 - x2)
    local randY = (math.random() - 0.5) * math.abs(y1 - y2)
    local resultX = normalDistribution(randX) + (x1 + x2) / 2
    local resultY = normalDistribution(randY) + (y1 + y2) / 2
    return resultX, resultY
  end
end

local function normaDistributionTap(p1, p2, t)
  if type(p1) == 'table' and type(p2) == 'table' then
    local x, y = randomNormalDistributionArea(p1[1], p1[2], p2[1], p2[2])
    return tap(x, y, t)
  else
    local mt = p2
    local area = t
    local x, y = randomNormalDistributionArea(p1[1], p1[2], area)
    return tap(x, y, mt)
  end
end

return normaDistributionTap
