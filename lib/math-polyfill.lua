math.isNan = math.isNan or function(num)
  if (num ~= num) then
    return true
  end
  return false
end

math.isInf = math.isInf or function(num)
  if (num == math.huge) then
    return true
  end
  return false
end

math.trueNumber = math.trueNumber or function(num)
  if (type(num) ~= 'number') then
    return nil
  end
  if (math.isNan(num)) then
    return nil
  end
  if (math.isInf(num)) then
    return nil
  end
  return num
end

math.maxTable = math.maxTable or function(tab, path)
  local maxNum
  local maxTab
  local maxKey
  if not path then
    return math.max(table.unpack(tab))
  elseif type(path) == 'string' or type(path) == 'number' then
    for key, item in pairs(tab) do
      if not maxNum or maxNum < item[path] then
        maxNum = item[path]
        maxTab = item
        maxKey = key
      end
    end
  elseif type(path) == 'function' then
    for key, item in pairs(tab) do
      local theNum = path(item, key, tab)
      if not maxNum or maxNum < theNum then
        maxNum = theNum
        maxTab = item
        maxKey = key
      end
    end
  end
  return maxTab, maxKey
end

math.minTable = math.minTable or function(tab, path)
  local maxNum
  local minTab
  local minKey
  if not path then
    return math.max(table.unpack(tab))
  elseif type(path) == 'string' or type(path) == 'number' then
    for key, item in pairs(tab) do
      if not maxNum or maxNum > item[path] then
        maxNum = item[path]
        minTab = item
        minKey = key
      end
    end
  elseif type(path) == 'function' then
    for key, item in pairs(tab) do
      local theNum = path(item, key, tab)
      if not maxNum or maxNum > theNum then
        maxNum = theNum
        minTab = item
        minKey = key
      end
    end
  end
  return minTab, minKey
end


math.mod = math.mod or function(m, n)
  local a1 = math.modf(m / n)
  return m - a1 * n
end
