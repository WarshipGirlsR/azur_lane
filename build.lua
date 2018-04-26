local options = {
  configPath = './azur_lane.tsproj',
}
-- 字符串分割
local myString = {}
do
  for key, value in pairs(string) do
    myString[key] = value
  end
  myString.split = myString.split or function(str, d)
    if str == '' and d ~= '' then
      return { str }
    elseif str ~= '' and d == '' then
      local lst = {}
      for key = 1, myString.len(str) do
        table.insert(lst, myString.sub(str, key, 1))
      end
      return lst
    else
      local lst = {}
      local n = myString.len(str) --长度
      local start = 1
      while start <= n do
        local i = myString.find(str, d, start) -- find 'next' 0
        if i == nil then
          table.insert(lst, myString.sub(str, start, n))
          break
        end
        table.insert(lst, myString.sub(str, start, i - 1))
        if i == n then
          table.insert(lst, '')
          break
        end
        start = i + 1
      end
      return lst
    end
  end
  for key, value in pairs(myString) do
    string[key] = string[key] or value
  end
end
local path = (function()
  local path = {}
  path.separator = myString.find(package.path, '/') and '/' or '\\'
  path.basename = function(thePath)
    thePath = myString.gsub(thePath, '\\', '/')
    thePath = myString.gsub(thePath, '//+', '/')
    local thePathArray = myString.split(thePath, '/')
    local res = table.remove(thePathArray)
    return res
  end
  path.dirname = function(thePath)
    thePath = myString.gsub(thePath, '\\', '/')
    thePath = myString.gsub(thePath, '//+', '/')
    local thePathArray = myString.split(thePath, '/')
    table.remove(thePathArray)
    return table.concat(thePathArray, path.separator)
  end
  path.extname = function()
  end
  path.join = function(...)
    local pathArray = { ... }
    local resultPathArray = {}
    for key = 1, #pathArray do
      if pathArray[key] ~= '' then
        if type(pathArray[key]) ~= 'string' then
          error('bad argument #' .. key .. ' to \'path.join\' (string expected, got ' .. type(pathArray[key]) .. ')', 2)
        end
        local thePath = myString.gsub(pathArray[key], '\\', '/')
        thePath = myString.gsub(thePath, '//+', '/')
        local thePathArray = myString.split(thePath, '/')
        for key2 = 1, #thePathArray do
          local theName = thePathArray[key2]
          if theName == '' and #resultPathArray > 0 then
          elseif theName == '.' and #resultPathArray > 0 then
          elseif theName == '..' and #resultPathArray == 1 and resultPathArray[1] == '' then
            table.remove(resultPathArray)
          elseif theName == '..' and #resultPathArray == 1 and resultPathArray[1] == '.' then
            resultPathArray = { '..' }
          elseif theName == '..' and #resultPathArray > 0 then
            table.remove(resultPathArray)
          else
            table.insert(resultPathArray, theName)
          end
        end
      end
    end
    return table.concat(resultPathArray, path.separator)
  end
  path.relative = function()
  end
  path.resolve = function(...)
    local pathArray = { ... }
    local resultPathArray = {}
    for key = 1, #pathArray do
      if pathArray[key] ~= '' then
        local thePath = myString.gsub(myString.gsub(pathArray[key], '\\', '/'), '/$', '')
        thePath = myString.gsub(thePath, '//+', '/')
        local thePathArray = myString.split(thePath, '/')
        for key2 = 1, #thePathArray do
          local theName = thePathArray[key2]
          if theName == '' and key2 == 1 then
            resultPathArray = { '' }
          elseif theName == '.' and #resultPathArray > 0 then
          elseif theName == '..' and #resultPathArray == 1 and resultPathArray[1] == '' then
            table.remove(resultPathArray)
          elseif theName == '..' and #resultPathArray == 1 and resultPathArray[1] == '.' then
            resultPathArray = { '..' }
          elseif theName == '..' and #resultPathArray > 0 then
            table.remove(resultPathArray)
          else
            table.insert(resultPathArray, theName)
          end
        end
      end
    end
    return table.concat(resultPathArray, path.separator)
  end
  return path
end)()


-- 通过重载的方式获取本文件的路径
local result = debug.getinfo(1, 'S')
if myString.match(result.short_src, '%[string') then
  local newMain = string.gsub(result.source, '%.lua$', '')
  package.loaded[newMain] = nil
  require(newMain)
  os.exit()
  os.exit()
  return
end
result = nil

local result = debug.getinfo(1, 'S')
local _dirname = string.gsub(result.source, '^@', '')

local theFile, err = io.open(configPath, 'r')
file = theFile
requireSource = file:read('*a')
