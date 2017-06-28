require 'TableLib'

local function transRelativePoint(tab, base)
  local newTab = {}
  for key, value in ipairs(tab) do
    newTab[key] = table.assign(value, { value[1] - base[1], value[2] - base[2] })
  end
  return newTab
end

local function transColorListToString(tab)
  local tmp = {}
  for key, value in ipairs(tab) do
    value[3] = string.format('0x%06X', value[3])
    table.insert(tmp, table.concat(value, '|'))
  end
  return table.concat(tmp, ',')
end

return {
  -- 基本方法
  toPoint = function(tab)
    local newTab = {}
    for _, value in ipairs(tab) do
      table.insert(newTab, { value.x, value.y })
    end
    return newTab
  end,
  -- 图片数据
  battle = {
    -- 地图
    map = {
      -- 上下边界
      topSide = (function()
        local leftTop = { 188, 157 }
        local rightBotton = { 1905, 1039 }
        local basePoint = { 775, 407, 0x212842 }
        local posandcolor = transColorListToString(transRelativePoint({
          { 775, 408, 0x19283a },
          { 775, 409, 0x192842 },
          { 775, 1009, 0x000000 },
          { 775, 1010, 0x000000 },
          { 775, 1011, 0x000000 },
          { 775, 1012, 0x000000 },
          { 775, 1013, 0x000000 },
        }, basePoint))
        return { leftTop = leftTop, rightBotton = rightBotton, basePoint = basePoint, posandcolor = posandcolor, }
      end)(),
    },
  },
}