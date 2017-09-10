-- 存储图像信息，用于界面找色、找图。取代图片搜索，因为找色搜索的像素点更少

require 'TableLib'

local function transRelativePoint(tab, base)
  if not base then
    base = tab[1]
    table.remove(tab, 1)
  end
  local newTab = {}
  for key, value in ipairs(tab) do
    newTab[key] = table.assign(value, { value[1] - base[1], value[2] - base[2] })
  end

  local tmp = {}
  for _, value in ipairs(newTab) do
    value[3] = string.format('0x%06X', value[3])
    table.insert(tmp, table.concat(value, '|'))
  end

  return base, table.concat(tmp, ',')
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
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 712 }
        local basePoint, posandcolor = transRelativePoint({
          { 507, 407, 0x424142 },
          { 536, 407, 0x3a3d3a },
          { 575, 407, 0x424142 },
          { 617, 407, 0x3a4142 },
          { 598, 406, 0x424142 },
          { 565, 406, 0x3a3d3a },
          { 532, 406, 0x42414a },
          { 557, 390, 0xffffff },
          { 564, 390, 0xffffff },
        })
        return {
          leftTop = leftTop,
          rightBotton = rightBotton,
          basePoint = basePoint,
          posandcolor = posandcolor,
          findColorParam = { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] },
        }
      end)(),
      -- 地图上边界2，由于上边界颜色并不清晰，所以准备2个上边界扫描工具
      topLine2 = (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 712 }
        local basePoint, posandcolor = transRelativePoint({
          { 861, 592, 0x29354a },
          { 882, 592, 0x29394a },
          { 910, 592, 0x213142 },
          { 937, 592, 0x193142 },
          { 929, 591, 0x213942 },
          { 890, 591, 0x213142 },
          { 907, 572, 0xffffff },
          { 914, 572, 0xffffff },
        })
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
        local leftTop = { 185, 400 }
        local rightBotton = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
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
        })
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
        local leftTop = { 185, 155 }
        local rightBotton = { 900, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 285, 362, 0x000000 },
          { 286, 362, 0x31b6de },
          { 285, 363, 0x000000 },
          { 286, 363, 0x31b2d6 },
          { 284, 364, 0x000000 },
          { 285, 364, 0x31b2de },
          { 284, 365, 0x000000 },
          { 285, 365, 0x31b6de },
        })
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
        local leftTop = { 600, 155, }
        local rightBotton = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 1800, 297, 0x299ade },
          { 1801, 297, 0x000000 },
          { 1800, 298, 0x299ee6 },
          { 1801, 298, 0x000000 },
          { 1801, 299, 0x299ae6 },
          { 1802, 299, 0x000000 },
          { 1801, 300, 0x299ae6 },
          { 1802, 300, 0x000408 },
        })
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
        local leftTop = { 185, 155 }
        local rightBotton = { 1898, 904, }
        local basePoint, posandcolor = transRelativePoint({
          { 818, 370, 0xe68e4a },
          { 829, 362, 0xde8a42 },
          { 841, 352, 0xde8e4a },
          { 853, 329, 0xd67573 },
        })
        return {
          leftTop = leftTop,
          rightBotton = rightBotton,
          basePoint = basePoint,
          posandcolor = posandcolor,
          findColorParam = { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] },
        }
      end)(),
      -- 我放舰队被选中的舰队的绿色的选中箭头的位置
      selectedArrow = (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1898, 904, }
        local basePoint, posandcolor = transRelativePoint({
          { 454, 303, 0x3aff84 },
          { 474, 303, 0x7bffad },
          { 452, 288, 0x005d21 },
          { 472, 289, 0x00be4a },
        })
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
        local leftTop = { 185, 155 }
        local rightBotton = { 1898, 904, }
        local basePoint, posandcolor = transRelativePoint({
          { 849, 246, 0xdeae00 },
          { 860, 246, 0xe6b600 },
          { 877, 246, 0xdeae00 },
          { 844, 254, 0xd6c221 },
          { 844, 267, 0xcebe10 },
          { 844, 280, 0xd6c219 },
          { 865, 273, 0xd6c221 },
        })
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
        local leftTop = { 185, 155 }
        local rightBotton = { 1898, 904, }
        local basePoint, posandcolor = transRelativePoint({
          { 1478, 660, 0xde9a00 },
          { 1491, 660, 0xdeaa00 },
          { 1504, 660, 0xdeaa00 },
          { 1473, 665, 0xdeaa08 },
          { 1473, 677, 0xe6a600 },
          { 1473, 700, 0xe6ae08 },
          { 1487, 690, 0xdeaa00 },
        })
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
        local leftTop = { 185, 155 }
        local rightBotton = { 1898, 904, }
        local basePoint, posandcolor = transRelativePoint({
          { 884, 517, 0xad3500 },
          { 898, 517, 0xad3500 },
          { 909, 517, 0xb53908 },
          { 878, 523, 0xad3908 },
          { 878, 537, 0x844121 },
          { 878, 556, 0xb53908 },
          { 890, 554, 0xc53500 },
        })
        return {
          leftTop = leftTop,
          rightBotton = rightBotton,
          basePoint = basePoint,
          posandcolor = posandcolor,
          findColorParam = { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] },
        }
      end)(),
      -- boss位置
      bossPoint1 = (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1898, 904, }
        local basePoint, posandcolor = transRelativePoint({
          { 1278, 426, 0x3a3131 },
          { 1277, 412, 0x292021 },
          { 1252, 424, 0x3a353a },
          { 1304, 427, 0x292421 },
          { 1257, 440, 0xe66963 },
          { 1265, 458, 0xffffff },
          { 1302, 461, 0xf7efee },
          { 1321, 461, 0xf7ebe6 },
        })
        return {
          leftTop = leftTop,
          rightBotton = rightBotton,
          basePoint = basePoint,
          posandcolor = posandcolor,
          findColorParam = { basePoint[3], posandcolor, 80, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] },
        }
      end)(),
      -- boss位置第二种形态
      bossPoint2 = (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1898, 904, }
        local basePoint, posandcolor = transRelativePoint({
          { 1284, 357, 0x312d31 },
          { 1284, 349, 0x313131 },
          { 1260, 388, 0xff5152 },
          { 1311, 388, 0xf74d52 },
          { 1289, 393, 0x422831 },
        })
        return {
          leftTop = leftTop,
          rightBotton = rightBotton,
          basePoint = basePoint,
          posandcolor = posandcolor,
          findColorParam = { basePoint[3], posandcolor, 80, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] },
        }
      end)(),
    },
  },
}