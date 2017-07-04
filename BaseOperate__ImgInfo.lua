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
    -- 由于这里的tab可能很长，所以使用一些特殊方法防止内存耗尽
    local newTab = {}
    local tabLength = #tab
    for key = 1, tabLength do
      newTab[key] = { tab[key].x, tab[key].y }
      tab[key] = nil
    end
    return newTab
  end,
  -- 检测点是否在两个点围围成的区域里
  inArea = function(point, areaPoint1, areaPoint2)
    local leftTop = {}
    local rightBotton = {}
    leftTop[1] = math.min(areaPoint1[1], areaPoint2[1])
    leftTop[2] = math.min(areaPoint1[2], areaPoint2[2])
    rightBotton[1] = math.max(areaPoint1[1], areaPoint2[1])
    rightBotton[2] = math.max(areaPoint1[2], areaPoint2[2])
    if ((point[1] < leftTop[1]) or (point[1] > rightBotton[1])) then
      return false
    end
    if ((point[2] < leftTop[2]) or (point[2] > rightBotton[2])) then
      return false
    end
    return true
  end,
  -- 寻找最近的两个点
  findNearestPoint = function(pointList1, pointList2)
    local nearPoint1
    local nearPoint2
    local distance = 0

    function getDistance(point1, point2)
      return math.sqrt(math.pow((point1[1] - point2[1]), 2) + math.pow((point1[1] - point2[1]), 2))
    end

    for _, value in ipairs(pointList1) do
      for _, value2 in ipairs(pointList2) do
        local newDistance = getDistance(value, value2)
        if ((distance == 0) or (newDistance < distance)) then
          nearPoint1 = value
          nearPoint2 = value2
          distance = newDistance
        end
      end
    end
    return nearPoint1, nearPoint2, distance
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
      -- 我方舰队位置
      myFleet = (function()
        local leftTop = { 185, 156, }
        local rightBotton = { 1898, 791, }
        local basePoint = { 818, 370, 0xe68e4a }
        local posandcolor = transColorListToString(transRelativePoint({
          { 829, 362, 0xde8a42 },
          { 841, 352, 0xde8e4a },
          { 853, 329, 0xd67573 },
        }, basePoint))
        return {
          leftTop = leftTop,
          rightBotton = rightBotton,
          basePoint = basePoint,
          posandcolor = posandcolor,
          findColorParam = { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] },
        }
      end)(),
      -- 敌方舰队位置(1星)
      enemyList1 = (function()
        local leftTop = { 185, 156 }
        local rightBotton = { 1898, 855 }
        local basePoint = { 849, 393, 0xe6b200 }
        local posandcolor = transColorListToString(transRelativePoint({
          { 858, 402, 0xd6c219 },
          { 869, 402, 0xcebe19 },
          { 877, 402, 0xcebe19 },
        }, basePoint))
        return {
          leftTop = leftTop,
          rightBotton = rightBotton,
          basePoint = basePoint,
          posandcolor = posandcolor,
          findColorParam = { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] },
        }
      end)(),
      -- 敌方舰队位置(2星)
      enemyList2 = (function()
        local leftTop = { 185, 156 }
        local rightBotton = { 1898, 855 }
        local basePoint = { 1248, 673, 0xe6a208 }
        local posandcolor = transColorListToString(transRelativePoint({
          { 1256, 679, 0xd6aa00 },
          { 1271, 679, 0xe6a610 },
          { 1288, 679, 0xdea208 },
        }, basePoint))
        return {
          leftTop = leftTop,
          rightBotton = rightBotton,
          basePoint = basePoint,
          posandcolor = posandcolor,
          findColorParam = { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] },
        }
      end)(),
      -- 敌方舰队位置(3星)
      enemyList3 = (function()
        local leftTop = { 185, 156 }
        local rightBotton = { 1898, 855 }
        local basePoint = { 834, 837, 0xbd3500 }
        local posandcolor = transColorListToString(transRelativePoint({
          { 841, 849, 0xb54110 },
          { 853, 849, 0xbd3900 },
          { 863, 849, 0xbd3900 },
        }, basePoint))
        return {
          leftTop = leftTop,
          rightBotton = rightBotton,
          basePoint = basePoint,
          posandcolor = posandcolor,
          findColorParam = { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] },
        }
      end)(),
      -- boss位置
      bossPoint = (function()
        local leftTop = { 281, 370 }
        local rightBotton = { 1885, 925 }
        local basePoint = { 1744, 872, 0xff4d52 }
        local posandcolor = transColorListToString(transRelativePoint({
          { 1803, 875, 0xff4d52 },
          { 1769, 833, 0x313531 },
          { 1775, 898, 0x6b0810 },
          { 1807, 842, 0x292429 },
          { 1743, 840, 0x313531 },
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