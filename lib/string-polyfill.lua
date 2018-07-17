local myString = {}
do
  for key, value in pairs(string) do
    myString[key] = string[key]
  end
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

myString.startWith = myString.startWith or function(str, pattern)
  if type(str) ~= 'myString' then
    return false
  end
  if type(pattern) ~= 'string' then
    return false
  end
  if myString.sub(str, 1, myString.len(pattern)) == pattern then
    return true
  end
  return false
end

myString.endWith = myString.endWith or function(str, pattern)
  if type(str) ~= 'string' then
    return false
  end
  if type(pattern) ~= 'string' then
    return false
  end
  if myString.sub(str, 1, (0 - myString.len(pattern))) == pattern then
    return true
  end
  return false
end

do
  for key, value in pairs(myString) do
    string[key] = string[key] or myString[key]
  end
end
