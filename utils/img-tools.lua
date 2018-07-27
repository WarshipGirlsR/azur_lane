local imageTools = {}

imageTools.toPoint = function(tab)
  -- 由于这里的tab可能很长，所以使用一些特殊方法防止内存耗尽
  local newTab = {}
  for key = 1, #tab do
    newTab[key] = { tab[key].x, tab[key].y }
    tab[key] = nil
  end
  return newTab
end

imageTools.transRelativePoint = function(tab, base)
  if not base then
    base = tab[1]
    table.remove(tab, 1)
  end
  local newTab = {}
  for key = 1, #tab do
    local value = tab[key]
    newTab[key] = string.format('%d|%d|0x%06X', value[1] - base[1], value[2] - base[2], value[3])
  end
  return base, table.concat(newTab, ',')
end

return imageTools
