local utils = {}

-- 点坐标的并集
utils.unionList = function(...)
  local sets = { ... }
  local setMap = {}
  local result = {}
  for key = 1, #sets do
    local set = sets[key]
    for key2 = 1, #set do
      local point = set[key2]
      if not setMap[point[1] .. ',' .. point[2]] then
        table.insert(result, point)
        setMap[point[1] .. ',' .. point[2]] = point
      end
    end
  end
  return result
end

-- 点坐标的交集
utils.intersectionList = function(...)
  local sets = { ... }
  local setsLength = #sets
  local setCountMap = {}
  local pointCount = {}
  local result = {}
  for key = 1, #sets do
    local set = sets[key]
    for key2 = 1, #set do
      local point = set[key2]
      local pointIndex = point[1] .. ',' .. point[2]
      if not setCountMap[pointIndex] then
        setCountMap[pointIndex] = 0
      end
      setCountMap[pointIndex] = setCountMap[pointIndex] + 1
    end
  end
  for key = 1, #sets do
    local set = sets[key]
    for key2 = 1, #set do
      local point = set[key2]
      local pointIndex = point[1] .. ',' .. point[2]
      if setCountMap[pointIndex] and setCountMap[pointIndex] >= setsLength then
        table.insert(result, point)
        setCountMap[pointIndex] = nil
      end
    end
  end

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

return utils
