-- 存储图像信息，用于界面找色、找图。取代图片搜索，因为找色搜索的像素点更少

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
    -- 地图扫描
    map = {
      -- 地图上边界
      topLine = (function()
        local leftTop = { 185, 155, }
        local rightBotton = { 1899, 1022, }
        local basePoint = { 694, 407, 0x193542 }
        local posandcolor = transColorListToString(transRelativePoint({
          { 697, 407, 0x213d42 },
          { 700, 407, 0x193142 },
          { 703, 407, 0x213d42 },
          { 706, 407, 0x193542 },
          { 706, 410, 0x31a6e6 },
          { 703, 410, 0x31a2de },
          { 700, 410, 0x31a2de },
          { 697, 410, 0x299ede },
          { 694, 410, 0x31a2e6 },
        }, basePoint))
        return {
          leftTop = leftTop,
          rightBotton = rightBotton,
          basePoint = basePoint,
          posandcolor = posandcolor,
          findColorParam = { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] },
        }
      end)(),
      -- 地图下边界
      bottonLine = (function()
        local leftTop = { 185, 155, }
        local rightBotton = { 1899, 1022, }
        local basePoint = { 695, 890, 0x000000 }
        local posandcolor = transColorListToString(transRelativePoint({
          { 695, 890, 0x000000 },
          { 698, 890, 0x000000 },
          { 701, 890, 0x000000 },
          { 704, 890, 0x000000 },
          { 707, 890, 0x000000 },
          { 707, 889, 0x1971b5 },
          { 704, 889, 0x196db5 },
          { 701, 889, 0x2171b5 },
          { 698, 889, 0x196db5 },
          { 695, 889, 0x1971bd },
        }, basePoint))
        return {
          leftTop = leftTop,
          rightBotton = rightBotton,
          basePoint = basePoint,
          posandcolor = posandcolor,
          findColorParam = { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] },
        }
      end)(),
      -- 地图左边界
      leftLine = (function()
        local leftTop = { 185, 155, }
        local rightBotton = { 1899, 1022, }
        local basePoint = { 365, 487, 0x000000 }
        local posandcolor = transColorListToString(transRelativePoint({
          { 366, 487, 0x29aade },
          { 365, 488, 0x000000 },
          { 366, 488, 0x31aede },
          { 364, 489, 0x000000 },
          { 365, 489, 0x31aede },
          { 364, 490, 0x000000 },
          { 365, 490, 0x29aede },
        }, basePoint))
        return {
          leftTop = leftTop,
          rightBotton = rightBotton,
          basePoint = basePoint,
          posandcolor = posandcolor,
          findColorParam = { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] },
        }
      end)(),
      -- 地图右边界
      rightLine = (function()
        local leftTop = { 185, 155, }
        local rightBotton = { 1899, 1022, }
        local basePoint = { 1855, 403, 0x31aede }
        local posandcolor = transColorListToString(transRelativePoint({
          { 1856, 403, 0x000000 },
          { 1855, 404, 0x31aede },
          { 1856, 404, 0x000000 },
          { 1856, 405, 0x31aede },
          { 1857, 405, 0x000000 },
          { 1856, 406, 0x31b2de },
          { 1857, 406, 0x000000 },
        }, basePoint))
        return {
          leftTop = leftTop,
          rightBotton = rightBotton,
          basePoint = basePoint,
          posandcolor = posandcolor,
          findColorParam = { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] },
        }
      end)(),
    },
  },
}