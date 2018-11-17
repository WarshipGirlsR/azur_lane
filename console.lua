local nLog = nLog or function() end

math.mod = math.mod or function(m, n)
  local a1 = math.modf(m / n)
  return m - a1 * n
end

local isArray = table.isArray or function(tab)
  if (type(tab) ~= "table") then
    return false
  end
  local length = #tab
  for k, v in pairs(tab) do
    if ((type(k) ~= "number") or (k > length)) then
      return false
    end
  end
  return true
end

local __console = console or {}

local function runTable(tab, space)
  if type(tab) == 'number' then
    return { tab }
  end
  if type(tab) == 'string' then
    if string.len(tab) > 1000 then
      return { '"' .. string.sub(tab, 1, 1000) .. '..."' }
    end
    return { '"' .. tab .. '"' }
  end
  if type(tab) == 'boolean' then
    if (tab) then
      return { 'true' }
    else
      return { 'false' }
    end
  end
  if type(tab) ~= 'table' then
    return { '(' .. tostring(tab) .. ')' }
  end
  if type(space) == 'number' then
    space = string.rep(' ', space)
  end
  if type(space) ~= 'string' then
    space = ''
  end

  local resultStrList = {}
  local newTabPairs = {}
  local newTabKeys = {}
  local newTabPairsKeysNumber = {}
  local newTabPairsKeysString = {}
  local newTabPairsKeysOther = {}
  local tabIsArray = true
  local tabLength = #tab
  local hasSubTab = false

  -- 将 table 的数组部分取出
  for k, v in ipairs(tab) do
    table.insert(newTabKeys, k)
  end

  -- 将 table 的 map 部分取出，数字按照从小到大顺序排序，字符串按照字典顺序排序，其他按照pairs顺序排序
  for k, v in pairs(tab) do
    if (type(v) == 'table') then
      hasSubTab = true
    end
    if type(k) ~= 'number' or k > tabLength or k < 1 or math.floor(k) ~= k then
      tabIsArray = false
      if type(k) == 'number' then
        table.insert(newTabPairsKeysNumber, k)
      elseif type(k) == 'string' then
        table.insert(newTabPairsKeysString, k)
      else
        table.insert(newTabPairsKeysOther, k)
      end
    end
  end

  table.sort(newTabPairsKeysNumber)
  table.sort(newTabPairsKeysString)
  for _, k in ipairs(newTabPairsKeysNumber) do
    table.insert(newTabKeys, k)
  end
  for _, k in ipairs(newTabPairsKeysString) do
    table.insert(newTabKeys, k)
  end
  for _, k in ipairs(newTabPairsKeysOther) do
    table.insert(newTabKeys, k)
  end
  for _, k in ipairs(newTabKeys) do
    table.insert(newTabPairs, { k, runTable(tab[k], space) })
  end

  if (tabIsArray) then
    local newTabArr = newTabPairs

    if (hasSubTab) then
      table.insert(resultStrList, '[')
      for k, v in ipairs(newTabArr) do
        local v2Length = #v[2]
        v[2][v2Length] = v[2][v2Length] .. ','
        for k2, v2 in ipairs(v[2]) do
          table.insert(resultStrList, space .. v2)
        end
      end
      table.insert(resultStrList, ']')
    else
      local theStr = {}
      for k, v in ipairs(newTabPairs) do
        table.insert(theStr, v[2][1])
      end
      local childStr = table.concat(theStr, ', ')
      table.insert(resultStrList, '[' .. childStr .. ']')
    end
  else
    local newTabArr = newTabPairs
    table.insert(resultStrList, '{')
    for k, v in ipairs(newTabArr) do
      if type(v[1]) == 'string' or type(v[1]) == 'number' then
        v[2][1] = v[1] .. ': ' .. v[2][1]
      else
        v[2][1] = '(' .. tostring(v[1]) .. '): ' .. v[2][1]
      end
      local v2Length = #v[2]
      v[2][v2Length] = v[2][v2Length] .. ','
      for k2, v2 in ipairs(v[2]) do
        table.insert(resultStrList, space .. v2 .. '')
      end
    end
    table.insert(resultStrList, '}')
  end
  return resultStrList
end


__console.log = __console.log or function(obj)
  local res = runTable(obj, 2)
  local info = debug.getinfo(2, 'Sl')
  local lineInfo = ''
  if info.currentline then
    lineInfo = info.source .. ': ' .. info.currentline .. ':'
  end

  if useNlog then
    local tmp = os.date('%Y-%m-%d %X') .. ' ' .. lineInfo
    local resLength = #res
    for i = 1, resLength do
      tmp = tmp .. '\n  ' .. res[i]
      if i >= resLength then
        nLog(tmp .. '\n')
        tmp = ''
        break
      end
      if string.len(tmp) > 8640 then
        nLog(tmp)
        tmp = ''
      end
    end
  end

  wLog('azur_lane', lineInfo .. table.concat(res, '\n'))
end

__console.getJsStr = function(obj)
  return table.concat(runTable(obj, 2), ",\n")
end

__console.color = function(value)
  local resultStr = ''
  local color = getColor(value[1], value[2])
  local oldColor = value[3]
  local colorStr = string.format('0x%06x', color)
  local oldColorStr = string.format('0x%06x', oldColor)
  value[3] = oldColorStr
  if (color == oldColor) then
    resultStr = resultStr .. '\n' .. table.concat(runTable(value), "")
  else
    value[3] = colorStr
    resultStr = resultStr .. '\n' .. table.concat(runTable(value), "") .. '  old Color: ' .. oldColorStr
  end
  __console.log(resultStr)
end

console = __console