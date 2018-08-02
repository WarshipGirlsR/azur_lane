local utils = {}

-- 点坐标向量相加
utils.sumVector = function(...)
  local pointList = { ... }
  local result = { 0, 0 }
  for _, v in ipairs(pointList) do
    if type(v) == 'table' and v[1] and v[2] then
      result[1] = result[1] + v[1]
      result[2] = result[2] + v[2]
    end
  end
  return result
end

-- 将点转换为索引字符串
utils.index = function(...)
  local point = utils.sumVector(...)
  return point[1] .. ',' .. point[2]
end

-- 点坐标的并集
utils.unionList = function(...)
  local sets = { ... }
  local setMap = {}
  local result = {}
  for key = 1, #sets do
    local set = sets[key]
    for key2 = 1, #set do
      local point = set[key2]
      local pointIndex = utils.index(point)
      if not setMap[pointIndex] then
        table.insert(result, point)
        setMap[pointIndex] = point
      end
    end
  end
  return result
end

-- 点坐标的交集
utils.intersectionList = function(fSet, ...)
  local sets = { ... }
  local resultMap = table.assign({}, fSet)
  local result = {}

  return result
end

-- 点坐标的差集
utils.subtractionList = function(target, ...)
  local sets = { ... }
  local result = {}
  local setMap = {}
  for key = 1, #target do
    local point = target[key]
    setMap[point[1] .. ',' .. point[2]] = point
  end
  for key = 1, #sets do
    local set = sets[key]
    for key2 = 1, #set do
      local point = set[key2]
      setMap[point[1] .. ',' .. point[2]] = nil
    end
  end
  for key = 1, #target do
    local point = target[key]
    if setMap[point[1] .. ',' .. point[2]] then
      table.insert(result, point)
    end
  end
  return result
end

return table.assign({}, utils)
