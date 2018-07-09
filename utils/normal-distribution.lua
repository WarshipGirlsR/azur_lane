-- 正态分布

local function normalDistribution(x, u, q) {
  u = u or 0
  q = q or 1
  return 1 / math.sqrt(2 * math.pi) * math.exp(0 - math.pow(x - u, 2) / 2 * math.pow(q, 2))
}

return normalDistribution
