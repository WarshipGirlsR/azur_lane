init(2)
useNlog = true
require 'console'
require 'TSLib'
mSleep(5000)

local function toPoint(tab)
  -- 由于这里的tab可能很长，所以使用一些特殊方法防止内存耗尽
  local newTab = {}
  local tabLength = #tab
  for key = 1, tabLength do
    newTab[key] = { tab[key].x, tab[key].y }
    tab[key] = nil
  end
  return newTab
end

local result = toPoint(findMultiColorInRegionFuzzyExt(0x000000, '', 99, 196, 268, 1909, 906))

console.log(123)
console.log(result)
