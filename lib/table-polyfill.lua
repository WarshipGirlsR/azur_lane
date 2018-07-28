-- table方法添加
local myTable = {}
do
  for key, value in pairs(table) do
    myTable[key] = table[key]
  end
end

local function runTable(tab, space)
  if (type(tab) == 'number') then
    return { tostring(tab) }
  end
  if (type(tab) == 'string') then
    return { '"' .. tab .. '"' }
  end
  if (type(tab) == 'boolean') then
    if (tab) then
      return { 'true' }
    else
      return { 'false' }
    end
  end
  if (type(tab) ~= 'table') then
    return { '(' .. type(tab) .. ')' }
  end
  if (type(space) == 'number') then
    space = string.rep(' ', space)
  end
  if (type(space) ~= 'string') then
    space = ''
  end

  local resultStrList = {}

  local newTabPairs = {}
  local tabIsArray = true
  local tabLength = 0
  local hasSubTab = false

  for k = 1, #tab do
    local v = tab[k]
    tabLength = k
    myTable.insert(newTabPairs, { k, runTable(v, space) })
    if (type(v) == 'table') then
      hasSubTab = true
    end
  end

  for k, v in pairs(tab) do
    if ((type(k) ~= 'number') or k > tabLength) then
      tabIsArray = false
      myTable.insert(newTabPairs, { k, runTable(v, space) })
      if (type(v) == 'table') then
        hasSubTab = true
      end
    end
  end

  if (tabIsArray) then
    local newTabArr = newTabPairs

    if (hasSubTab) then
      myTable.insert(resultStrList, '[')
      for k = 1, #newTabArr do
        local v = newTabArr[k]
        local v2Length = getLength(v[2])
        v[2][v2Length] = v[2][v2Length] .. ','
        for k2 = 1, #v[2] do
          local v2 = v[2][k2]
          myTable.insert(resultStrList, space .. v2)
        end
      end
      myTable.insert(resultStrList, ']')
    else
      local theStr = {}
      for k = 1, #newTabPairs do
        local v = newTabPairs[k]
        myTable.insert(theStr, v[2][1])
      end
      local childStr = myTable.concat(theStr, ', ')
      myTable.insert(resultStrList, '[' .. childStr .. ']')
    end
  else
    local newTabArr = newTabPairs

    myTable.insert(resultStrList, '{')
    for k = 1, #newTabArr do
      local v = newTabArr[k]
      v[2][1] = v[1] .. ': ' .. v[2][1]
      local v2Length = getLength(v[2])
      v[2][v2Length] = v[2][v2Length] .. ','
      for k2 = 1, #v[2] do
        local v2 = v[2][k2]
        myTable.insert(resultStrList, space .. v2 .. '')
      end
    end
    myTable.insert(resultStrList, '}')
  end
  return resultStrList
end

myTable.length = function(tab)
  return #tab
end

myTable.isArray = function(tab)
  if (type(tab) ~= 'table') then
    return false
  end
  local length = myTable.length(tab)
  for k, v in pairs(tab) do
    if ((type(k) ~= 'number') or (k > length)) then
      return false
    end
  end
  return true
end

myTable.unpack = myTable.unpack or unpack

myTable.slice = function(tab, startIndex, endIndex)
  local length = myTable.length(tab)
  if ((type(endIndex) == 'nil') or (endIndex == 0)) then
    endIndex = length
  end
  if (endIndex < 0) then
    endIndex = length + 1 + endIndex
  end
  local newTab = {}

  for i = startIndex, endIndex do
    myTable.insert(newTab, tab[i])
  end

  return newTab
end

myTable.merge = function(tab, ...)
  local args = { ... }
  for k = 1, #args do
    local tabelement = args[k]
    local length = myTable.length(tabelement)
    for k2 = 1, #tabelement do
      local value = tabelement[k2]
      if ((type(k2) == 'number') and (k2 <= length)) then
        myTable.insert(tab, value)
      end
    end
    for k2 = 1, #tabelement do
      local value = tabelement[k2]
      if ((type(k2) == 'number') and (k2 <= length)) then
      elseif (type(k2) == 'number') then
        tab[tostring(k2)] = value
      else
        tab[k2] = value
      end
    end
  end
  return tab
end

myTable.assign = function(target, ...)
  local sources = { ... }
  if (type(target) ~= 'table') then
    target = {}
  end
  for key1 = 1, #sources do
    local source = sources[key1]
    for key2, value in pairs(source) do
      target[key2] = value
    end
  end
  return target
end

myTable.reverse = function(target)
  local result = {}
  local theLength = myTable.length(target)
  for key = 1, #target do
    local value = target[key]
    result[theLength - key + 1] = value
  end
  return result
end

myTable.filter = function(target, func)
  local result = {}
  local theLength = myTable.length(target)
  for key = 1, #target do
    local value = target[key]
    if (func(value, key, target)) then
      myTable.insert(result, value)
    end
  end
  return result
end

myTable.unique = function(target, path)
  local theMap = {}
  local result = {}
  local pathType = type(path)
  if (pathType == 'nil') then
    for key = 1, #target do
      local value = target[key]
      if (type(theMap[value]) == 'nil') then
        theMap[value] = { key = key, value = value }
        myTable.insert(result, value)
      end
    end
  elseif ((pathType == 'number') or (pathType == 'string')) then
    for key = 1, #target do
      local value = target[key]
      if (type(theMap[value[path]]) == 'nil') then
        theMap[value[path]] = { key = key, value = value }
        myTable.insert(result, value)
      end
    end
  elseif (pathType == 'function') then
    for key = 1, #target do
      local value = target[key]
      if (type(theMap[path(value)]) == 'nil') then
        theMap[path(value)] = { key = key, value = value }
        myTable.insert(result, value)
      end
    end
  end
  return result
end

-- 后覆盖前的unique
myTable.uniqueLast = function(target, path)
  local theMap = {}
  local result = {}
  local pathType = type(path)
  local targetLength = myTable.length(target)
  if (pathType == 'nil') then
    for key = 1, #target do
      local value = target[key]
      theMap[value] = { key = key, value = value }
    end
    for key = 1, #target do
      local value = target[key]
      if (key == theMap[value].key) then
        myTable.insert(result, value)
      end
    end
  elseif ((pathType == 'number') or (pathType == 'string')) then
    for key = 1, #target do
      local value = target[key]
      local res, err = pcall(function()
        theMap[value[path]] = { key = key, value = value }
      end)
      if not res then
        error(console.log(value))
      end
    end
    for key = 1, #target do
      local value = target[key]
      if (key == theMap[value[path]].key) then
        myTable.insert(result, value)
      end
    end
  elseif (pathType == 'function') then
    for key = 1, #target do
      local value = target[key]
      theMap[path(value)] = { key = key, value = value }
    end
    for key = 1, #target do
      local value = target[key]
      if (key == theMap[path(value)].key) then
        myTable.insert(result, value)
      end
    end
  end
  return result
end

myTable.map = function(tab, callback)
  local values = {}
  for k, v in ipairs(tab) do
    local value = callback(v, k, tab)
    myTable.insert(values, value)
  end
  return values
end

myTable.values = function(tab)
  local values = {}
  for k, v in pairs(tab) do
    myTable.insert(values, v)
  end
  return values
end

myTable.keys = function(tab)
  local keys = {}
  for k in pairs(tab) do
    myTable.insert(keys, k)
  end
  return keys
end

-- 对key排序后放入数组中再返回，结果类似entries
myTable.sortByKey = function(tab, call)
  local keys = myTable.keys(tab)
  if (type(call) == 'function') then
    myTable.sort(keys, call)
  else
    myTable.sort(keys)
  end
  local newTable = {}
  for k = 1, #keys do
    local key = keys[k]
    myTable.insert(newTable, { key, tab[key] })
  end
  return newTable
end

-- 对数字和字符串的数组同时排序，数字会从小到大放在前面，之后字符串按照字典排序
myTable.sortNumAndStr = function(tab)
  local numTab = {}
  local strTab = {}
  for k = 1, #tab do
    if type(tab[k]) == 'number' then
      table.insert(numTab, tab[k])
    elseif type(tab[k]) == 'string' then
      table.insert(strTab, tab[k])
    end
  end
  table.sort(numTab)
  table.sort(strTab)
  local result = {}
  for k = 1, #numTab do
    table.insert(result, numTab[k])
  end
  for k = 1, #strTab do
    table.insert(result, strTab[k])
  end
  return result
end

myTable.findIndex = function(tab, call)
  local index = -1
  if type(call) == 'function' then
    if myTable.isArray(tab) then
      for key = 1, #tab do
        local value = tab[key]
        if call(value) then
          index = key
        end
      end
    else
      for key = 1, #tab do
        local value = tab[key]
        if call(value) then
          index = key
        end
      end
    end
  else
    if myTable.isArray(tab) then
      for key = 1, #tab do
        local value = tab[key]
        if value == call then
          index = key
        end
      end
    else
      for key = 1, #tab do
        local value = tab[key]
        if value == call then
          index = key
        end
      end
    end
  end
  return index
end

myTable.find = function(tab, call)
  local result
  if type(call) == 'function' then
    if myTable.isArray(tab) then
      for key = 1, #tab do
        local value = tab[key]
        if call(value) then
          result = value
        end
      end
    else
      for _, value in pairs(tab) do
        if call(value) then
          result = value
        end
      end
    end
  else
    if myTable.isArray(tab) then
      for _, value in pairs(tab) do
        if value == call then
          result = tab[call]
        end
      end
    else
      for key = 1, #tab do
        local value = tab[key]
        if value == call then
          result = tab[call]
        end
      end
    end
  end
  return result
end

myTable.newSet = function(tab)
  local result = {}
  for k, v in ipairs(tab) do
    result[v] = v
  end
  return result
end

myTable.intersect = function(...)
  local args = { ... }
  local result = myTable.assign({}, args[1])
  table.remove(args, 1)
  for _, v in ipairs(args) do
    local newRes = {}
    local theSet = myTable.newSet(v)
    for _, v2 in ipairs(result) do
      if type(theSet[v2]) ~= 'nil' then
        table.insert(newRes, v2)
      end
    end
    result = newRes
  end
  return result
end

myTable.subtract = function(...)
  local args = { ... }
  local result = myTable.assign({}, args[1])
  table.remove(args, 1)
  for _, v in ipairs(args) do
    local newRes = {}
    local theSet = myTable.newSet(v)
    for _, v2 in ipairs(result) do
      if type(theSet[v2]) == 'nil' then
        table.insert(newRes, v2)
      end
    end
    result = newRes
  end
  return result
end

myTable.union = function(...)
  local args = { ... }
  local result = {}
  local resultSet = {}
  for _, v in ipairs(args) do
    if type(resultSet[v]) == 'nil' then
      table.insert(result, v)
      resultSet[v] = v
    end
  end
  return result
end

myTable.toString = function(tab)
  return myTable.concat(runTable(tab), '')
end

myTable.from = function(target)
  if (type(target) ~= 'function') then
    return target
  end
  local result = {}
  for k, v in ipairs(target) do
    result[k] = v
  end
  return result
end

myTable.toJsString = myTable.toJsString or function(tab, space)
  space = space or '  '
  return myTable.concat(runTable(tab, space), '\n')
end

do
  for key, value in pairs(myTable) do
    table[key] = table[key] or myTable[key]
  end
end
