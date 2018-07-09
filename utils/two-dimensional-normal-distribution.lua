-- 二维正态分布

local function twoDimensionalNormalDistribution(x, y, u1, q1, u2, q2, p) 
  u1 = u1 or 0
  q1 = q1 or 1
  u2 = u2 or 0
  q2 = q2 or 1
  p = p or 0
  return math.pow(2 * math.pi * q1 * q2 * math.sqrt(1 - math.pow(p, 2)), -1) * math.exp(0 - 1 / (2 * (1 - math.pow(p, 2))) * (math.pow(x - u1, 2) / math.pow(q1, 2)) - 2p * (x - u1) * (y - u2) / q1 * q2 + math.pow(y - u2, 2) / math.pow(q2, 2))
end

return twoDimensionalNormalDistribution
