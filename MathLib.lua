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

math.tureNumber = math.tureNumber or function(num)
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