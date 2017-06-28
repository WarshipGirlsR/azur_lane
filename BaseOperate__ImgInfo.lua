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
        local basePoint = { 567, 237, 0x314152 }
        local posandcolor = transColorListToString(transRelativePoint({
          { 572, 237, 0x293942 },
          { 577, 237, 0x314152 },
          { 582, 237, 0x213942 },
          { 587, 237, 0x294152 },
          { 589, 238, 0x31aede },
          { 584, 238, 0x31aede },
          { 579, 238, 0x31aede },
          { 574, 238, 0x31aede },
          { 569, 238, 0x31aede },
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
        local rightBotton = { 1020, 1022, }
        local basePoint = { 285, 362, 0x000000 }
        local posandcolor = transColorListToString(transRelativePoint({
          { 286, 362, 0x31b6de },
          { 285, 363, 0x000000 },
          { 286, 363, 0x31b2d6 },
          { 284, 364, 0x000000 },
          { 285, 364, 0x31b2de },
          { 284, 365, 0x000000 },
          { 285, 365, 0x31b6de },
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
        local leftTop = { 950, 155, }
        local rightBotton = { 1899, 1022, }
        local basePoint = { 1800, 297, 0x299ade }
        local posandcolor = transColorListToString(transRelativePoint({
          { 1801, 297, 0x000000 },
          { 1800, 298, 0x299ee6 },
          { 1801, 298, 0x000000 },
          { 1801, 299, 0x299ae6 },
          { 1802, 299, 0x000000 },
          { 1801, 300, 0x299ae6 },
          { 1802, 300, 0x000408 },
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