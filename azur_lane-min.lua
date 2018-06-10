
package.sourceCode = package.sourceCode or {}
package.sourceCode["./meta-operation/maps-options/img.lua"] = { path = "./meta-operation/maps-options/img.lua", name = "./meta-operation/maps-options/img.lua", source = "-- 存储图像信息，用于界面找色、找图。取代图片搜索，因为找色搜索的像素点更少\
local function transRelativePoint(tab, base)\
  if not base then\
    base = tab[1]\
    table.remove(tab, 1)\
  end\
  local newTab = {}\
  for key = 1, #tab do\
    local value = tab[key]\
    newTab[key] = string.format('%d|%d|0x%06X', value[1] - base[1], value[2] - base[2], value[3])\
  end\
  return base, table.concat(newTab, ',')\
end\
\
local imgs = {\
  transRelativePoint = transRelativePoint,\
  -- 基本方法\
  toPoint = function(tab)\
    -- 由于这里的tab可能很长，所以使用一些特殊方法防止内存耗尽\
    local newTab = {}\
    local tabLength = #tab\
    for key = 1, tabLength do\
      newTab[key] = { tab[key].x, tab[key].y }\
      tab[key] = nil\
    end\
    return newTab\
  end,\
  -- 过滤被右下角按钮挡住的部分的点，因为右下角按钮也是黑色的容易与边界识别混淆\
  filterNoUsePoint = function(list)\
    local newList = {}\
    for key = 1, #list do\
      local point = list[key]\
      if point[1] < 940 or point[2] < 910 then\
        table.insert(newList, point)\
      end\
    end\
    return newList\
  end,\
  -- 图片数据\
  -- 地图扫描\
  map = {\
    -- 地图上边界\
    topLineList = {},\
    -- 地图下边界\
    bottonLine = {},\
    -- 地图左边界\
    leftLineList = {},\
    -- 地图右边界\
    rightLineList = {},\
    -- 我方舰队位置列表\
    myFleetList = {\
      --  采集位置5-2\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022, }\
        local basePoint, posandcolor = transRelativePoint({\
          { 1356, 430, 0xa4494a }, { 1353, 411, 0xde8a42 },\
          { 1363, 403, 0xe69e5a }, { 1388, 404, 0xef9652 },\
          { 1396, 389, 0xe69652 }, { 1397, 378, 0xce7973 },\
          { 1416, 423, 0x101410 },\
        })\
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
      --  采集位置5-3\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022, }\
        local basePoint, posandcolor = transRelativePoint({\
          { 752, 438, 0xad4d52 }, { 751, 421, 0xde8642 },\
          { 763, 417, 0xe69663 }, { 771, 404, 0xde9e52 },\
          { 795, 402, 0x422d29 }, { 798, 400, 0xce7173 },\
          { 816, 430, 0x211c21 },\
        })\
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
      --  采集位置sp3\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022, }\
        local basePoint, posandcolor = transRelativePoint({\
          { 1030, 346, 0xce7173 }, { 1012, 329, 0xde8184 },\
          { 1007, 338, 0xffffe6 }, { 998, 349, 0xefce8c },\
          { 989, 364, 0xd68642 }, { 981, 369, 0xad5152 },\
          { 999, 376, 0xde8e42 }, { 1016, 361, 0xce8142 },\
          { 1039, 371, 0x191819 }, { 999, 366, 0xffffd6 },\
        })\
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
      --  采集位置 9-3\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022, }\
        local basePoint, posandcolor = transRelativePoint({\
          { 383, 626, 0xde8a4a }, { 351, 622, 0xad5152 },\
          { 356, 603, 0xfffbde }, { 368, 590, 0xfffbe6 },\
          { 390, 585, 0xde9e5a }, { 397, 579, 0xd67d7b },\
          { 422, 596, 0x424542 }, { 396, 615, 0xde9652 },\
        })\
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
    },\
    -- 我放舰队被选中的舰队的绿色的选中箭头的位置\
    selectedArrow = {\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022, }\
        local basePoint, posandcolor = transRelativePoint({\
          { 454, 303, 0x3aff84 }, { 474, 303, 0x7bffad },\
          { 452, 288, 0x005d21 }, { 472, 289, 0x00be4a },\
        })\
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022, }\
        local basePoint, posandcolor = transRelativePoint({\
          { 904, 627, 0x19ff6b }, { 928, 627, 0x7cff9d },\
          { 907, 577, 0x3aff84 }, { 926, 574, 0x83ffb5 },\
        })\
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
    },\
    -- 敌方舰队位置，右上角的难度标志\
    enemyList1 = {\
      -- 小型 左上框\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022, }\
        local basePoint, posandcolor = transRelativePoint({\
          { 975, 577, 0xe6ba08 }, { 986, 577, 0xdeba08 },\
          { 997, 577, 0xe6b200 }, { 969, 596, 0xdeba10 },\
          { 991, 598, 0xd6c219 },\
        })\
        return { basePoint[3], posandcolor, 88, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
      -- 小型 右下框\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022, }\
        local basePoint, posandcolor = transRelativePoint({\
          { 1007, 621, 0xe6b600 }, { 994, 621, 0xdeb200 },\
          { 983, 621, 0xe6b600 }, { 1013, 601, 0xdeba10 },\
          { 991, 604, 0xcebe10 },\
        })\
        return { basePoint[3], posandcolor, 88, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
    },\
    enemyList2 = {\
      -- 中型 左上框\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022, }\
        local basePoint, posandcolor = transRelativePoint({\
          { 1134, 378, 0xe6a610 }, { 1143, 378, 0xe6a208 },\
          { 1156, 378, 0xe6a610 }, { 1126, 395, 0xdea608 },\
          { 1139, 400, 0xdea608 },\
        })\
        return { basePoint[3], posandcolor, 88, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
      -- 中型 右下框\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022, }\
        local basePoint, posandcolor = transRelativePoint({\
          { 1163, 423, 0xe6a608 }, { 1153, 423, 0xe6a608 },\
          { 1139, 423, 0xe6a610 }, { 1171, 408, 0xdea608 },\
          { 1158, 407, 0xdeaa00 },\
        })\
        return { basePoint[3], posandcolor, 88, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
    },\
    enemyList3 = {\
      -- 大型 左上框\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022, }\
        local basePoint, posandcolor = transRelativePoint({\
          { 1394, 475, 0xbd3500 }, { 1400, 475, 0xbd3500 },\
          { 1407, 475, 0xbd3900 }, { 1411, 475, 0xbd3900 },\
          { 1388, 480, 0xbd3908 }, { 1388, 487, 0xbd3500 },\
        })\
        return { basePoint[3], posandcolor, 88, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
      -- 大型 右下框\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022, }\
        local basePoint, posandcolor = transRelativePoint({\
          { 1400, 517, 0xbd3500 }, { 1409, 517, 0xbd3900 },\
          { 1413, 517, 0xbd3900 }, { 1420, 517, 0xb53100 },\
          { 1429, 509, 0xbd3900 }, { 1429, 502, 0xbd3500 },\
        })\
        return { basePoint[3], posandcolor, 88, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
    },\
    -- boss位置\
    bossPointList = {\
      -- 我方舰队和boss重叠 3-3 的 4-1\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022, }\
        local basePoint, posandcolor = transRelativePoint({\
          { 702, 600, 0x313131 }, { 685, 600, 0x31353a },\
          { 677, 600, 0x31353a }, { 669, 600, 0x313131 },\
          { 714, 600, 0x312831 }, { 721, 600, 0x312429 },\
          { 722, 600, 0x312829 }, { 726, 595, 0x211819 },\
          { 714, 595, 0x292829 }, { 703, 594, 0x312d31 },\
          { 683, 596, 0x313531 }, { 674, 595, 0x313131 },\
          { 701, 590, 0x312d31 }, { 697, 609, 0xfff7f7 },\
          { 678, 616, 0xe66d63 }, { 689, 616, 0xe66963 },\
          { 705, 618, 0xde695a },\
        })\
        return { basePoint[3], posandcolor, 82, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
      -- 我方舰队不和boss重叠 9-4 的 6-9\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022, }\
        local basePoint, posandcolor = transRelativePoint({\
          { 1615, 803, 0x3a2d31 }, { 1593, 795, 0xf75152 },\
          { 1645, 797, 0xff5152 }, { 1616, 752, 0x313931 },\
          { 1584, 745, 0x313531 }, { 1648, 742, 0x312831 },\
        })\
        return { basePoint[3], posandcolor, 82, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
      -- 我方舰队不和boss重叠 1-1 的 1-7\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022, }\
        local basePoint, posandcolor = transRelativePoint({\
          { 1462, 426, 0x313131 }, { 1451, 426, 0x31313a },\
          { 1439, 426, 0x31353a }, { 1472, 426, 0x312d31 },\
          { 1488, 426, 0x312429 }, { 1483, 423, 0x312831 },\
          { 1471, 423, 0x313131 }, { 1459, 423, 0x423542 },\
          { 1446, 423, 0x313131 }, { 1464, 417, 0x312d31 },\
          { 1435, 452, 0xf74d52 }, { 1445, 459, 0xff4d52 },\
          { 1482, 459, 0xf74d4a }, { 1492, 452, 0xff4d52 },\
          { 1464, 468, 0x3a2d31 },\
        })\
        return { basePoint[3], posandcolor, 82, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)()\
    },\
    -- 战斗中的点\
    inBattleList = {\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022, }\
        local basePoint, posandcolor = transRelativePoint({\
          { 538, 757, 0xf77d6b }, { 515, 735, 0xf78173 },\
          { 471, 727, 0xfff7f7 }, { 519, 727, 0xfff7f7 },\
          { 558, 727, 0xf7f7f7 }, { 592, 727, 0xf7f7ef },\
          { 581, 751, 0xfffbf7 }, { 581, 762, 0xfffbff },\
        })\
        return { basePoint[3], posandcolor, 85, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
    },\
    -- 奖励点\
    rewardBoxList = {\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022, }\
        local basePoint, posandcolor = transRelativePoint({\
          { 1125, 860, 0x94fff7 }, { 1126, 847, 0x292d29 },\
          { 1125, 839, 0x292829 }, { 1125, 827, 0x94fff7 },\
          { 1125, 812, 0x292829 }, { 1128, 781, 0x84ffef },\
        })\
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022, }\
        local basePoint, posandcolor = transRelativePoint({\
          { 573, 304, 0x94fff7 }, { 573, 296, 0x292d29 },\
          { 573, 289, 0x292829 }, { 573, 277, 0x9cfff7 },\
          { 576, 242, 0x83fff7 },\
        })\
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
    },\
  },\
}\
\
return imgs\
" }


package.sourceCode = package.sourceCode or {}
package.sourceCode["./utils/a-start.lua"] = { path = "./utils/a-start.lua", name = "./utils/a-start.lua", source = "local function setPointInMap(p, map)\
  map[p[1] .. ',' .. p[2]] = p\
end\
\
local function deletePointInMap(p, map)\
  map[p[1] .. ',' .. p[2]] = nil\
end\
\
local function getPointInMap(p, map)\
  return map[p[1] .. ',' .. p[2]]\
end\
\
local function pointGenerator(startPoint, endPoint, weight, lastPoint)\
  weight = weight or 1\
  local point = { startPoint[1], startPoint[2], lastPoint = lastPoint }\
  point.G = lastPoint and (lastPoint.G + weight) or 0\
  point.H = math.abs(endPoint[1] - startPoint[1]) + math.abs(endPoint[2] - startPoint[2])\
  point.F = point.G + point.H\
  return point\
end\
\
-- 找到F值最小的点，如果F值相同则取靠后的\
local function findMinFPoint(list)\
  list = list or {}\
  local minF\
  local minPoint\
  local minPointIndex\
  for k = 1, #list do\
    local v = list[k]\
    if not minF or minF >= v.F then\
      minF = v.F\
      minPoint = v\
      minPointIndex = k\
    end\
  end\
  return minPoint, minPointIndex\
end\
\
-- 主函数\
local AStart = function(startPoint, endPoint, mapObj)\
  if type(startPoint) ~= 'table' or type(endPoint) ~= 'table' then\
    local info = debug.getinfo(3, 'Sl')\
    local lineInfo = ''\
    if info.currentline then\
      lineInfo = info.source .. ': ' .. info.currentline .. ':\\n'\
    end\
    if type(startPoint) ~= 'table' then\
      lineInfo = lineInfo .. '\\n bad argument #1 \"startPoint\"(table excepted, got ' .. type(startPoint) .. ')'\
    end\
    if type(endPoint) ~= 'table' then\
      lineInfo = lineInfo .. '\\n bad argument #2 \"endPoint\"(table excepted, got ' .. type(endPoint) .. ')'\
    end\
    error(lineInfo)\
  end\
\
  -- 棋盘宽高\
  local width = mapObj.width\
  local height = mapObj.height\
  -- 障碍物列表\
  local obstacleMap = {}\
  local cellMap = {}\
  for key = 1, #mapObj.obstacle do\
    local value = mapObj.obstacle[key]\
    if value.weight then\
      setPointInMap(value, cellMap)\
    else\
      setPointInMap(value, obstacleMap)\
    end\
  end\
\
\
  -- 开列表和关列表\
  local openList = {}\
  local openListMap = {}\
  local closeListMap = {}\
\
  -- 将起始点插入开列表\
  local theStartPoint = pointGenerator(startPoint, endPoint)\
  table.insert(openList, theStartPoint)\
  setPointInMap(theStartPoint, openList)\
\
  while #openList > 0 do\
    -- 从开列表选出F值最小的点，如果F值大小相同就选靠后的\
    openList = table.filter(openList, function(e) return not e.isClosed end)\
    local thePoint = findMinFPoint(openList)\
    thePoint.isClosed = true\
    openList = table.filter(openList, function(e) return not e.isClosed end)\
    deletePointInMap(thePoint, openListMap)\
    setPointInMap(thePoint, closeListMap)\
\
    -- 左边\
    local leftPoint = { thePoint[1], thePoint[2] - 1 }\
    if leftPoint[2] >= 1\
      and not getPointInMap(leftPoint, closeListMap)\
      and not getPointInMap(leftPoint, obstacleMap) then\
      local oldOpenPoint = getPointInMap(leftPoint, openListMap)\
      local weight = (getPointInMap(leftPoint, cellMap) or {}).weight or 0\
      local newPoint = pointGenerator(leftPoint, endPoint, weight + 1, thePoint)\
      if oldOpenPoint and oldOpenPoint.F > newPoint.F then\
        oldOpenPoint.isClosed = true\
        openList = table.filter(openList, function(e) return not e.isClosed end)\
        deletePointInMap(oldOpenPoint, openListMap)\
      end\
      if not oldOpenPoint or oldOpenPoint.F > newPoint.F then\
        table.insert(openList, newPoint)\
        setPointInMap(newPoint, openListMap)\
        if newPoint.H == 0 then\
          break\
        end\
      end\
    end\
    -- 右边\
    local rightPoint = { thePoint[1], thePoint[2] + 1 }\
    if rightPoint[2] <= width\
      and not getPointInMap(rightPoint, closeListMap)\
      and not getPointInMap(rightPoint, obstacleMap) then\
      local oldOpenPoint = getPointInMap(rightPoint, openListMap)\
      local weight = (getPointInMap(rightPoint, cellMap) or {}).weight or 0\
      local newPoint = pointGenerator(rightPoint, endPoint, weight + 1, thePoint)\
      if oldOpenPoint and oldOpenPoint.F > newPoint.F then\
        oldOpenPoint.isClosed = true\
        openList = table.filter(openList, function(e) return not e.isClosed end)\
        deletePointInMap(oldOpenPoint, openListMap)\
      end\
      if not oldOpenPoint or oldOpenPoint.F > newPoint.F then\
        table.insert(openList, newPoint)\
        setPointInMap(newPoint, openListMap)\
        if newPoint.H == 0 then\
          break\
        end\
      end\
    end\
    -- 上边\
    local upPoint = { thePoint[1] - 1, thePoint[2] }\
    if upPoint[1] >= 1\
      and not getPointInMap(upPoint, closeListMap)\
      and not getPointInMap(upPoint, obstacleMap) then\
      local oldOpenPoint = getPointInMap(upPoint, openListMap)\
      local weight = (getPointInMap(upPoint, cellMap) or {}).weight or 0\
      local newPoint = pointGenerator(upPoint, endPoint, weight + 1, thePoint)\
      if oldOpenPoint and oldOpenPoint.F > newPoint.F then\
        oldOpenPoint.isClosed = true\
        openList = table.filter(openList, function(e) return not e.isClosed end)\
        deletePointInMap(oldOpenPoint, openListMap)\
      end\
      if not oldOpenPoint or oldOpenPoint.F > newPoint.F then\
        table.insert(openList, newPoint)\
        setPointInMap(newPoint, openListMap)\
        if newPoint.H == 0 then\
          break\
        end\
      end\
    end\
    -- 下边\
    local downPoint = { thePoint[1] + 1, thePoint[2] }\
    if downPoint[1] <= height\
      and not getPointInMap(downPoint, closeListMap)\
      and not getPointInMap(downPoint, obstacleMap) then\
      local oldOpenPoint = getPointInMap(downPoint, openListMap)\
      local weight = (getPointInMap(downPoint, cellMap) or {}).weight or 0\
      local newPoint = pointGenerator(downPoint, endPoint, weight + 1, thePoint)\
      if oldOpenPoint and oldOpenPoint.F > newPoint.F then\
        oldOpenPoint.isClosed = true\
        openList = table.filter(openList, function(e) return not e.isClosed end)\
        deletePointInMap(oldOpenPoint, openListMap)\
      end\
      if not oldOpenPoint or oldOpenPoint.F > newPoint.F then\
        table.insert(openList, newPoint)\
        setPointInMap(newPoint, openListMap)\
        if newPoint.H == 0 then\
          break\
        end\
      end\
    end\
  end\
\
  -- 如果列表最后一个点是终点，说明已找到路线。否则说明无法到达目标\
  if #openList > 0 and openList[#openList].H == 0 then\
    local path = {}\
    local p = openList[#openList]\
    while p.lastPoint do\
      table.insert(path, p)\
      p = p.lastPoint\
    end\
    for i = 1, #path do\
      path[i].lastPoint = nil\
    end\
    -- 反转table\
    local newPath = {}\
    for i = #path, 1, -1 do\
      table.insert(newPath, path[i])\
    end\
    return newPath\
  end\
end\
\
return AStart;\
" }


package.sourceCode = package.sourceCode or {}
package.sourceCode["./meta-operation/maps-options/utils.lua"] = { path = "./meta-operation/maps-options/utils.lua", name = "./meta-operation/maps-options/utils.lua", source = "local utils = {}\
\
-- 点坐标的并集\
utils.unionList = function(...)\
  local sets = { ... }\
  local setMap = {}\
  local result = {}\
  for key = 1, #sets do\
    local set = sets[key]\
    for key2 = 1, #set do\
      local point = set[key2]\
      if not setMap[point[1] .. '-' .. point[2]] then\
        table.insert(result, point)\
        setMap[point[1] .. '-' .. point[2]] = point\
      end\
    end\
  end\
  return result\
end\
\
-- 点坐标的交集\
utils.intersectionList = function(...)\
  local sets = { ... }\
  local setsLength = #sets\
  local setCountMap = {}\
  local pointCount = {}\
  local result = {}\
  for key = 1, #sets do\
    local set = sets[key]\
    for key2 = 1, #set do\
      local point = set[key2]\
      local pointIndex = point[1] .. '-' .. point[2]\
      if not setCountMap[pointIndex] then\
        setCountMap[pointIndex] = 0\
      end\
      setCountMap[pointIndex] = setCountMap[pointIndex] + 1\
    end\
  end\
  for key = 1, #sets do\
    local set = sets[key]\
    for key2 = 1, #set do\
      local point = set[key2]\
      local pointIndex = point[1] .. '-' .. point[2]\
      if setCountMap[pointIndex] and setCountMap[pointIndex] >= setsLength then\
        table.insert(result, point)\
        setCountMap[pointIndex] = nil\
      end\
    end\
  end\
\
  return result\
end\
\
-- 点坐标的差集\
utils.subtractionList = function(target, ...)\
  local sets = { ... }\
  local result = {}\
  local setMap = {}\
  for key = 1, #target do\
    local point = target[key]\
    setMap[point[1] .. '-' .. point[2]] = point\
  end\
  for key = 1, #sets do\
    local set = sets[key]\
    for key2 = 1, #set do\
      local point = set[key2]\
      setMap[point[1] .. '-' .. point[2]] = nil\
    end\
  end\
  for key = 1, #target do\
    local point = target[key]\
    if setMap[point[1] .. '-' .. point[2]] then\
      table.insert(result, point)\
    end\
  end\
  return result\
end\
\
return utils\
" }


package.sourceCode = package.sourceCode or {}
package.sourceCode["./meta-operation/maps-options/imgevent15-2-b2.lua"] = { path = "./meta-operation/maps-options/imgevent15-2-b2.lua", name = "./meta-operation/maps-options/imgevent15-2-b2.lua", source = "-- 存储图像信息，用于界面找色、找图。取代图片搜索，因为找色搜索的像素点更少\
local imgBase = require './img'\
\
local transRelativePoint = imgBase.transRelativePoint\
\
return {\
  transRelativePoint = transRelativePoint,\
  -- 基本方法\
  toPoint = imgBase.toPoint,\
  -- 过滤被右下角按钮挡住的部分的点，因为右下角按钮也是黑色的容易与边界识别混淆\
  filterNoUsePoint = imgBase.filterNoUsePoint,\
  -- 图片数据\
  -- 地图扫描\
  map = {\
    -- 地图上边界\
    topLineList = {\
      -- 1-1的上边\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022, }\
        local basePoint, posandcolor = transRelativePoint({\
          { 459, 531, 0x213942 }, { 472, 531, 0x193542 },\
          { 486, 531, 0x193542 }, { 495, 531, 0x213942 },\
          { 503, 532, 0x299ede }, { 490, 532, 0x319ee6 },\
          { 478, 532, 0x29a2de }, { 464, 532, 0x319ee6 },\
        })\
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
      -- 1-9的上边\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022, }\
        local basePoint, posandcolor = transRelativePoint({\
          { 1502, 529, 0x103942 }, { 1516, 529, 0x193942 },\
          { 1528, 529, 0x193942 }, { 1547, 529, 0x193d4a },\
          { 1556, 530, 0x31b6de }, { 1543, 530, 0x31b6de },\
          { 1527, 530, 0x31bade }, { 1515, 530, 0x31bade },\
        })\
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
      -- 1-2的上边\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022, }\
        local basePoint, posandcolor = transRelativePoint({\
          { 636, 531, 0x193942 }, { 652, 531, 0x193542 },\
          { 662, 531, 0x193542 }, { 673, 531, 0x29414a },\
          { 684, 532, 0x31b6e6 }, { 677, 532, 0x29b2d6 },\
          { 666, 532, 0x31aede }, { 655, 532, 0x31aede },\
        })\
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
      -- 1-8的上边\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022, }\
        local basePoint, posandcolor = transRelativePoint({\
          { 1322, 529, 0x193542 }, { 1337, 529, 0x19394a },\
          { 1350, 529, 0x193542 }, { 1366, 529, 0x193542 },\
          { 1382, 530, 0x42c6e6 }, { 1367, 530, 0x3ac2de },\
          { 1352, 530, 0x42c6de }, { 1342, 530, 0x42c6e6 },\
        })\
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
      -- 1-5的上边\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022, }\
        local basePoint, posandcolor = transRelativePoint({\
          { 780, 529, 0x213942 }, { 791, 529, 0x213d4a },\
          { 802, 529, 0x193942 }, { 815, 529, 0x213d4a },\
          { 829, 530, 0x31bade }, { 820, 530, 0x31b6de },\
          { 800, 530, 0x4ac6d6 }, { 786, 530, 0x31bade },\
        })\
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
    },\
    -- 地图下边界\
    bottonLineList = {\
      -- 7-1 的下面\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022 }\
        local basePoint, posandcolor = transRelativePoint({\
          { 385, 949, 0x000000 }, { 404, 949, 0x000000 },\
          { 424, 949, 0x000000 }, { 441, 949, 0x000000 },\
          { 456, 948, 0x2181c5 }, { 440, 948, 0x2181c5 },\
          { 422, 948, 0x2186c5 }, { 400, 948, 0x2986ce },\
          { 400, 951, 0x000000 }, { 430, 951, 0x000000 },\
        })\
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
      -- 7-3 的下面\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022 }\
        local basePoint, posandcolor = transRelativePoint({\
          { 851, 948, 0x1071b5 }, { 872, 948, 0x2171bd },\
          { 885, 948, 0x1971b5 }, { 902, 948, 0x196db5 },\
          { 918, 949, 0x000000 }, { 905, 949, 0x000000 },\
          { 885, 949, 0x000000 }, { 864, 949, 0x000000 },\
          { 864, 951, 0x000000 }, { 888, 951, 0x000000 },\
        })\
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
      -- 7-5 的下面\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022 }\
        local basePoint, posandcolor = transRelativePoint({\
          { 450, 937, 0x10559c }, { 464, 937, 0x1051a4 },\
          { 477, 937, 0x1051a4 }, { 492, 937, 0x104da4 },\
          { 503, 938, 0x000000 }, { 494, 938, 0x000000 },\
          { 476, 938, 0x000000 }, { 461, 938, 0x000000 },\
          { 462, 940, 0x000000 }, { 493, 940, 0x000000 },\
        })\
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
      -- 7-7 的下面\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022 }\
        local basePoint, posandcolor = transRelativePoint({\
          { 883, 938, 0x000000 }, { 894, 938, 0x000000 },\
          { 905, 938, 0x000000 }, { 917, 938, 0x000000 },\
          { 928, 937, 0x1055ad }, { 918, 937, 0x1055ad },\
          { 904, 937, 0x1055ad }, { 883, 937, 0x1955ad },\
          { 882, 940, 0x000000 }, { 894, 940, 0x000000 },\
        })\
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
    },\
    -- 地图左边界\
    leftLineList = {\
      -- 7-1 的左边\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022, }\
        local basePoint, posandcolor = transRelativePoint({\
          { 359, 930, 0x000000 }, { 360, 930, 0x2986c5 },\
          { 359, 929, 0x000000 }, { 360, 929, 0x2181c5 },\
          { 358, 931, 0x000000 }, { 359, 931, 0x2986c5 },\
          { 358, 932, 0x000000 }, { 359, 932, 0x217dbd },\
        })\
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
      -- 5-1 的左边\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022, }\
        local basePoint, posandcolor = transRelativePoint({\
          { 432, 510, 0x000000 }, { 433, 510, 0x3a92d6 },\
          { 432, 509, 0x000000 }, { 433, 509, 0x3a92d6 },\
          { 431, 511, 0x000000 }, { 432, 511, 0x3192d6 },\
          { 431, 512, 0x000000 }, { 432, 512, 0x4296de },\
        })\
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
      -- 4-1 的左边\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022, }\
        local basePoint, posandcolor = transRelativePoint({\
          { 293, 809, 0x000000 }, { 294, 809, 0x21aed6 },\
          { 293, 808, 0x000000 }, { 294, 808, 0x29b2d6 },\
          { 292, 810, 0x000000 }, { 293, 810, 0x29b2d6 },\
          { 292, 811, 0x000000 }, { 293, 811, 0x29b2d6 },\
        })\
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
      -- 1-1 的左边\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022, }\
        local basePoint, posandcolor = transRelativePoint({\
          { 429, 559, 0x000000 }, { 430, 559, 0x299ede },\
          { 429, 558, 0x000000 }, { 430, 558, 0x31a2de },\
          { 428, 560, 0x000000 }, { 429, 560, 0x299ede },\
          { 428, 561, 0x000000 }, { 429, 561, 0x31a2de },\
        })\
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
      -- 2-1 的左边\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022, }\
        local basePoint, posandcolor = transRelativePoint({\
          { 404, 705, 0x000000 }, { 405, 705, 0x31aede },\
          { 404, 704, 0x000000 }, { 405, 704, 0x31aede },\
          { 403, 706, 0x000000 }, { 404, 706, 0x31aede },\
          { 403, 707, 0x000000 }, { 404, 707, 0x29aad6 },\
        })\
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
    },\
    -- 地图右边界\
    rightLineList = {\
      -- 7-9 的右边\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022, }\
        local basePoint, posandcolor = transRelativePoint({\
          { 1491, 822, 0x000000 }, { 1490, 822, 0x4275ce },\
          { 1491, 821, 0x000000 }, { 1490, 821, 0x3a75bd },\
          { 1492, 823, 0x000000 }, { 1491, 823, 0x3a75c5 },\
          { 1492, 824, 0x000000 }, { 1491, 824, 0x3a75bd },\
        })\
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
      -- 4-9 的右边\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022, }\
        local basePoint, posandcolor = transRelativePoint({\
          { 1418, 363, 0x000000 }, { 1417, 363, 0x31aade },\
          { 1418, 362, 0x000000 }, { 1417, 362, 0x31aad6 },\
          { 1419, 364, 0x000000 }, { 1418, 364, 0x31aede },\
          { 1419, 365, 0x000000 }, { 1418, 365, 0x29aad6 },\
        })\
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
      -- 1-9 的右边\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022, }\
        local basePoint, posandcolor = transRelativePoint({\
          { 1577, 560, 0x000000 }, { 1576, 560, 0x31b2e6 },\
          { 1577, 559, 0x000000 }, { 1576, 559, 0x29aede },\
          { 1578, 561, 0x000000 }, { 1577, 561, 0x31aede },\
          { 1578, 562, 0x000000 }, { 1577, 562, 0x29aede },\
        })\
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
      -- 2-9 的右边\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022, }\
        local basePoint, posandcolor = transRelativePoint({\
          { 1629, 820, 0x000000 }, { 1628, 820, 0x31c2e6 },\
          { 1629, 819, 0x000000 }, { 1628, 819, 0x29bede },\
          { 1630, 821, 0x000000 }, { 1629, 821, 0x31bee6 },\
          { 1630, 822, 0x000000 }, { 1629, 822, 0x29bede },\
        })\
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
      -- 6-9 的右边\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022, }\
        local basePoint, posandcolor = transRelativePoint({\
          { 1460, 627, 0x000000 }, { 1459, 627, 0x3a79c5 },\
          { 1460, 626, 0x000000 }, { 1459, 626, 0x3a79c5 },\
          { 1461, 628, 0x000000 }, { 1460, 628, 0x4279ce },\
          { 1461, 629, 0x000000 }, { 1460, 629, 0x3a75c5 },\
        })\
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
    },\
    -- 我方舰队位置\
    myFleetList = imgBase.map.myFleetList,\
    -- 我放舰队被选中的舰队的绿色的选中箭头的位置\
    selectedArrow = imgBase.map.selectedArrow,\
    -- 敌方舰队位置(小型舰队)\
    enemyList1 = imgBase.map.enemyList1,\
    -- 敌方舰队位置(中型舰队)\
    enemyList2 = imgBase.map.enemyList2,\
    -- 敌方舰队位置(大型舰队)\
    enemyList3 = imgBase.map.enemyList3,\
    -- boss位置\
    bossPointList = imgBase.map.bossPointList,\
    -- 战斗中的位置\
    inBattleList = imgBase.map.inBattleList,\
    -- 奖励箱的位置\
    rewardBoxList = imgBase.map.rewardBoxList,\
  },\
}" }


package.sourceCode = package.sourceCode or {}
package.sourceCode["./meta-operation/maps-options/imgevent15-1-a2.lua"] = { path = "./meta-operation/maps-options/imgevent15-1-a2.lua", name = "./meta-operation/maps-options/imgevent15-1-a2.lua", source = "-- 存储图像信息，用于界面找色、找图。取代图片搜索，因为找色搜索的像素点更少\
local imgBase = require './img'\
\
local transRelativePoint = imgBase.transRelativePoint\
\
return {\
  transRelativePoint = transRelativePoint,\
  -- 基本方法\
  toPoint = imgBase.toPoint,\
  -- 过滤被右下角按钮挡住的部分的点，因为右下角按钮也是黑色的容易与边界识别混淆\
  filterNoUsePoint = imgBase.filterNoUsePoint,\
  -- 图片数据\
  -- 地图扫描\
  map = {\
    -- 地图上边界\
    topLineList = {\
      -- 1-1的上边\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022, }\
        local basePoint, posandcolor = transRelativePoint({\
          { 579, 505, 0x19203a }, { 589, 505, 0x19243a },\
          { 595, 505, 0x19203a }, { 602, 505, 0x102031 },\
          { 609, 506, 0x3a496b }, { 602, 506, 0x424973 },\
          { 592, 506, 0x3a456b }, { 584, 506, 0x3a4563 },\
        })\
        return { basePoint[3], posandcolor, 88, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
      -- 1-3的上边\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022, }\
        local basePoint, posandcolor = transRelativePoint({\
          { 939, 505, 0x3a2d3a }, { 950, 505, 0x312831 },\
          { 964, 505, 0x312831 }, { 974, 505, 0x312831 },\
          { 983, 506, 0x3a4d73 }, { 974, 506, 0x424d73 },\
          { 962, 506, 0x424d73 }, { 952, 506, 0x3a4d73 },\
        })\
        return { basePoint[3], posandcolor, 88, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
      -- 1-4的上边\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022, }\
        local basePoint, posandcolor = transRelativePoint({\
          { 1133, 505, 0x423942 }, { 1146, 505, 0x3a3131 },\
          { 1156, 505, 0x42393a }, { 1164, 505, 0x423942 },\
          { 1172, 506, 0x425584 }, { 1157, 506, 0x3a517b },\
          { 1147, 506, 0x3a517b }, { 1137, 506, 0x3a517b },\
        })\
        return { basePoint[3], posandcolor, 88, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
      -- 1-6的上边\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022, }\
        local basePoint, posandcolor = transRelativePoint({\
          { 1450, 505, 0x212019 }, { 1461, 505, 0x292021 },\
          { 1472, 505, 0x291c21 }, { 1485, 505, 0x4a3131 },\
          { 1500, 506, 0x42557b }, { 1489, 506, 0x3a557b },\
          { 1433, 506, 0x425984 }, { 1473, 506, 0x425984 },\
        })\
        return { basePoint[3], posandcolor, 88, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
    },\
    -- 地图下边界\
    bottonLineList = {\
      -- 7-1 的下面\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022 }\
        local basePoint, posandcolor = transRelativePoint({\
          { 578, 946, 0x000000 }, { 590, 946, 0x000000 },\
          { 604, 946, 0x000000 }, { 619, 946, 0x000000 },\
          { 630, 945, 0x29314a }, { 618, 945, 0x29314a },\
          { 608, 945, 0x29314a }, { 597, 945, 0x29354a },\
        })\
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
      -- 7-3 的下面\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022 }\
        local basePoint, posandcolor = transRelativePoint({\
          { 992, 946, 0x000000 }, { 1005, 946, 0x000000 },\
          { 1018, 946, 0x000000 }, { 1030, 946, 0x000000 },\
          { 1042, 945, 0x31416b }, { 1030, 945, 0x31416b },\
          { 1017, 945, 0x3a456b }, { 1005, 945, 0x3a456b },\
        })\
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
    },\
    -- 地图左边界\
    leftLineList = {\
      -- 1-1 的左边\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022, }\
        local basePoint, posandcolor = transRelativePoint({\
          { 571, 537, 0x000000 }, { 572, 537, 0x314163 },\
          { 571, 536, 0x000000 }, { 572, 536, 0x42456b },\
          { 570, 538, 0x000000 }, { 571, 538, 0x3a456b },\
          { 570, 539, 0x000000 }, { 571, 539, 0x3a456b },\
        })\
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
      -- 2-1 的左边\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022, }\
        local basePoint, posandcolor = transRelativePoint({\
          { 561, 673, 0x000000 }, { 562, 673, 0x3a4973 },\
          { 561, 672, 0x000000 }, { 562, 672, 0x424d7b },\
          { 560, 674, 0x000000 }, { 561, 674, 0x424d73 },\
          { 560, 675, 0x000000 }, { 561, 675, 0x424d73 },\
        })\
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
      -- 3-1 的左边\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022, }\
        local basePoint, posandcolor = transRelativePoint({\
          { 546, 876, 0x000000 }, { 547, 876, 0x3a4d73 },\
          { 546, 875, 0x000000 }, { 547, 875, 0x424d73 },\
          { 545, 877, 0x000000 }, { 546, 877, 0x3a496b },\
          { 545, 878, 0x000000 }, { 546, 878, 0x424d73 },\
        })\
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
      -- 4-1 的左边\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022, }\
        local basePoint, posandcolor = transRelativePoint({\
          { 569, 412, 0x000000 }, { 570, 412, 0x42517b },\
          { 569, 411, 0x000000 }, { 570, 411, 0x424d73 },\
          { 568, 413, 0x000000 }, { 569, 413, 0x424d73 },\
          { 568, 414, 0x000000 }, { 569, 414, 0x424d73 },\
        })\
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
      -- 5-1 的左边\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022, }\
        local basePoint, posandcolor = transRelativePoint({\
          { 556, 583, 0x000000 }, { 557, 583, 0x4a5984 },\
          { 556, 582, 0x000000 }, { 557, 582, 0x4a5984 },\
          { 555, 584, 0x000000 }, { 556, 584, 0x4a5984 },\
          { 555, 585, 0x000000 }, { 556, 585, 0x425984 },\
        })\
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
      -- 7-1 的左边\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022, }\
        local basePoint, posandcolor = transRelativePoint({\
          { 533, 886, 0x000000 }, { 534, 886, 0x424163 },\
          { 533, 885, 0x000000 }, { 534, 885, 0x313d5a },\
          { 532, 887, 0x000000 }, { 533, 887, 0x3a4163 },\
          { 532, 888, 0x000000 }, { 533, 888, 0x3a4163 },\
        })\
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
    },\
    -- 地图右边界\
    rightLineList = {\
      -- 1-7 的右边\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022, }\
        local basePoint, posandcolor = transRelativePoint({\
          { 1447, 545, 0x000000 }, { 1446, 545, 0x5a7184 },\
          { 1447, 544, 0x000000 }, { 1446, 544, 0x5a758c },\
          { 1448, 546, 0x000000 }, { 1447, 546, 0x5a7184 },\
          { 1448, 547, 0x000000 }, { 1447, 547, 0x5a758c },\
        })\
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
      -- 2-7 的右边\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022, }\
        local basePoint, posandcolor = transRelativePoint({\
          { 1460, 686, 0x000000 }, { 1459, 686, 0x5a6984 },\
          { 1460, 685, 0x000000 }, { 1459, 685, 0x5a6984 },\
          { 1461, 687, 0x000000 }, { 1460, 687, 0x5a6984 },\
          { 1461, 688, 0x000000 }, { 1460, 688, 0x636d8c },\
        })\
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
      -- 4-7 的右边\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022, }\
        local basePoint, posandcolor = transRelativePoint({\
          { 1605, 800, 0x000000 }, { 1604, 800, 0x42496b },\
          { 1605, 799, 0x000000 }, { 1604, 799, 0x314963 },\
          { 1606, 801, 0x000000 }, { 1605, 801, 0x3a496b },\
          { 1606, 802, 0x000000 }, { 1605, 802, 0x3a496b },\
        })\
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
      -- 6-7 的右边\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022, }\
        local basePoint, posandcolor = transRelativePoint({\
          { 1497, 678, 0x000000 }, { 1496, 678, 0x4a5573 },\
          { 1497, 677, 0x000000 }, { 1496, 677, 0x42516b },\
          { 1498, 679, 0x000000 }, { 1497, 679, 0x4a556b },\
          { 1498, 680, 0x000000 }, { 1497, 680, 0x4a516b },\
        })\
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
    },\
    -- 我方舰队位置\
    myFleetList = imgBase.map.myFleetList,\
    -- 我放舰队被选中的舰队的绿色的选中箭头的位置\
    selectedArrow = imgBase.map.selectedArrow,\
    -- 敌方舰队位置(小型舰队)\
    enemyList1 = imgBase.map.enemyList1,\
    -- 敌方舰队位置(中型舰队)\
    enemyList2 = imgBase.map.enemyList2,\
    -- 敌方舰队位置(大型舰队)\
    enemyList3 = imgBase.map.enemyList3,\
    -- boss位置\
    bossPointList = imgBase.map.bossPointList,\
    -- 战斗中的位置\
    inBattleList = imgBase.map.inBattleList,\
    -- 奖励箱的位置\
    rewardBoxList = imgBase.map.rewardBoxList,\
  },\
}" }


package.sourceCode = package.sourceCode or {}
package.sourceCode["./meta-operation/maps-options/img12-1.lua"] = { path = "./meta-operation/maps-options/img12-1.lua", name = "./meta-operation/maps-options/img12-1.lua", source = "-- 存储图像信息，用于界面找色、找图。取代图片搜索，因为找色搜索的像素点更少\
local imgBase = require './img'\
\
local transRelativePoint = imgBase.transRelativePoint\
\
return {\
  transRelativePoint = transRelativePoint,\
  -- 基本方法\
  toPoint = imgBase.toPoint,\
  -- 过滤被右下角按钮挡住的部分的点，因为右下角按钮也是黑色的容易与边界识别混淆\
  filterNoUsePoint = imgBase.filterNoUsePoint,\
  -- 图片数据\
  -- 地图扫描\
  map = {\
    -- 地图上边界\
    topLineList = {\
      -- 1-2的上边\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022, }\
        local basePoint, posandcolor = transRelativePoint({\
          { 513, 539, 0x212442 }, { 522, 539, 0x19243a },\
          { 533, 539, 0x212442 }, { 541, 539, 0x212442 },\
          { 550, 540, 0x31aede }, { 544, 540, 0x31aee6 },\
          { 530, 540, 0x31aede }, { 521, 540, 0x31b2e6 },\
        })\
        return { basePoint[3], posandcolor, 93, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
      -- 1-5的上边\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022, }\
        local basePoint, posandcolor = transRelativePoint({\
          { 1001, 539, 0x212442 }, { 1017, 539, 0x212442 },\
          { 1028, 539, 0x19243a }, { 1046, 539, 0x19243a },\
          { 1058, 540, 0x31b6de }, { 1048, 540, 0x31b6e6 },\
          { 1034, 540, 0x31b6de }, { 1018, 540, 0x31c2de },\
        })\
        return { basePoint[3], posandcolor, 93, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
      -- 1-6的上边\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022, }\
        local basePoint, posandcolor = transRelativePoint({\
          { 1173, 539, 0x212442 }, { 1191, 539, 0x212442 },\
          { 1203, 539, 0x212442 }, { 1214, 539, 0x19243a },\
          { 1232, 540, 0x42c6de }, { 1218, 540, 0x3ac2de },\
          { 1204, 540, 0x42bede }, { 1190, 540, 0x3abede },\
        })\
        return { basePoint[3], posandcolor, 93, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
      -- 1-8的上边\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022, }\
        local basePoint, posandcolor = transRelativePoint({\
          { 1585, 539, 0x192031 }, { 1596, 539, 0x101829 },\
          { 1609, 539, 0x191c31 }, { 1620, 539, 0x101829 },\
          { 1632, 540, 0x31b6e6 }, { 1626, 540, 0x31b6de },\
          { 1617, 540, 0x31b6de }, { 1594, 540, 0x31bade },\
        })\
        return { basePoint[3], posandcolor, 93, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
    },\
    -- 地图下边界\
    bottonLineList = {\
      -- 6-1 的下面\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022 }\
        local basePoint, posandcolor = transRelativePoint({\
          { 512, 956, 0x000000 }, { 523, 956, 0x000000 },\
          { 538, 956, 0x000000 }, { 554, 956, 0x000000 },\
          { 566, 955, 0x197dbd }, { 555, 955, 0x2181c5 },\
          { 535, 955, 0x2181c5 }, { 515, 955, 0x2181c5 },\
        })\
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
      -- 6-2 的下面\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022 }\
        local basePoint, posandcolor = transRelativePoint({\
          { 732, 956, 0x000000 }, { 754, 956, 0x000000 },\
          { 769, 956, 0x000000 }, { 783, 956, 0x000000 },\
          { 794, 955, 0x1971b5 }, { 785, 955, 0x2171bd },\
          { 772, 955, 0x1971b5 }, { 752, 955, 0x1971b5 },\
        })\
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
      -- 6-4 的下面\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022 }\
        local basePoint, posandcolor = transRelativePoint({\
          { 514, 954, 0x000000 }, { 529, 954, 0x000000 },\
          { 546, 954, 0x000000 }, { 563, 954, 0x000000 },\
          { 574, 953, 0x1059ad }, { 562, 953, 0x105dad },\
          { 547, 953, 0x1961b5 }, { 533, 953, 0x1961b5 },\
        })\
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
      -- 6-5 的下面\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022 }\
        local basePoint, posandcolor = transRelativePoint({\
          { 718, 954, 0x000000 }, { 730, 954, 0x000000 },\
          { 750, 954, 0x000000 }, { 765, 954, 0x000000 },\
          { 778, 953, 0x10499c }, { 758, 953, 0x10499c },\
          { 741, 953, 0x104da4 }, { 725, 953, 0x1049a4 },\
        })\
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
    },\
    -- 地图左边界\
    leftLineList = {\
      -- 1-1 的左边\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022, }\
        local basePoint, posandcolor = transRelativePoint({\
          { 284, 557, 0x000000 }, { 285, 557, 0x31a2de },\
          { 284, 556, 0x000000 }, { 285, 556, 0x29a2de },\
          { 283, 558, 0x000000 }, { 284, 558, 0x31a2de },\
          { 283, 559, 0x000000 }, { 284, 559, 0x299ace },\
        })\
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
      -- 2-1 的左边\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022, }\
        local basePoint, posandcolor = transRelativePoint({\
          { 249, 717, 0x000000 }, { 250, 717, 0x29b2d6 },\
          { 249, 716, 0x000000 }, { 250, 716, 0x31b6de },\
          { 248, 718, 0x000000 }, { 249, 718, 0x31b6d6 },\
          { 248, 719, 0x000000 }, { 249, 719, 0x31b6de },\
        })\
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
      -- 3-1 的左边\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022, }\
        local basePoint, posandcolor = transRelativePoint({\
          { 222, 840, 0x000000 }, { 223, 840, 0x29bade },\
          { 222, 839, 0x000000 }, { 223, 839, 0x31bade },\
          { 221, 841, 0x000000 }, { 222, 841, 0x29b6d6 },\
          { 221, 842, 0x000000 }, { 222, 842, 0x31bade },\
        })\
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
      -- 6-1 的左边\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022, }\
        local basePoint, posandcolor = transRelativePoint({\
          { 476, 845, 0x000000 }, { 477, 845, 0x218ec5 },\
          { 476, 844, 0x000000 }, { 477, 844, 0x218ac5 },\
          { 475, 846, 0x000000 }, { 476, 846, 0x218ec5 },\
          { 475, 847, 0x000000 }, { 476, 847, 0x218abd },\
        })\
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
    },\
    -- 地图右边界\
    rightLineList = {\
      -- 5-8 的右边\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022, }\
        local basePoint, posandcolor = transRelativePoint({\
          { 1540, 812, 0x000000 }, { 1539, 812, 0x4275bd },\
          { 1540, 811, 0x000000 }, { 1539, 811, 0x4275ce },\
          { 1541, 813, 0x000000 }, { 1540, 813, 0x4275c5 },\
          { 1541, 814, 0x000000 }, { 1540, 814, 0x4275ce },\
        })\
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
      -- 4-8 的右边\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022, }\
        local basePoint, posandcolor = transRelativePoint({\
          { 1491, 530, 0x000000 }, { 1490, 530, 0x319ad6 },\
          { 1491, 529, 0x000000 }, { 1490, 529, 0x2996ce },\
          { 1492, 531, 0x000000 }, { 1491, 531, 0x319ad6 },\
          { 1492, 532, 0x000000 }, { 1491, 532, 0x299ad6 },\
        })\
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
      -- 2-8 的右边\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022, }\
        local basePoint, posandcolor = transRelativePoint({\
          { 1675, 688, 0x000000 }, { 1674, 688, 0x31aee6 },\
          { 1675, 687, 0x000000 }, { 1674, 687, 0x29aade },\
          { 1676, 689, 0x000000 }, { 1675, 689, 0x31aede },\
          { 1676, 690, 0x000000 }, { 1675, 690, 0x31aade },\
        })\
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
      -- 1-8 的右边\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022, }\
        local basePoint, posandcolor = transRelativePoint({\
          { 1650, 576, 0x000000 }, { 1649, 576, 0x29aade },\
          { 1650, 575, 0x000000 }, { 1649, 575, 0x29aade },\
          { 1651, 577, 0x000000 }, { 1650, 577, 0x29aade },\
          { 1651, 578, 0x000000 }, { 1650, 578, 0x31aee6 },\
        })\
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
    },\
    -- 我方舰队位置\
    myFleetList = imgBase.map.myFleetList,\
    -- 我放舰队被选中的舰队的绿色的选中箭头的位置\
    selectedArrow = imgBase.map.selectedArrow,\
    -- 敌方舰队位置(小型舰队)\
    enemyList1 = imgBase.map.enemyList1,\
    -- 敌方舰队位置(中型舰队)\
    enemyList2 = imgBase.map.enemyList2,\
    -- 敌方舰队位置(大型舰队)\
    enemyList3 = imgBase.map.enemyList3,\
    -- boss位置\
    bossPointList = imgBase.map.bossPointList,\
    -- 战斗中的位置\
    inBattleList = imgBase.map.inBattleList,\
    -- 奖励箱的位置\
    rewardBoxList = imgBase.map.rewardBoxList,\
  },\
}" }


package.sourceCode = package.sourceCode or {}
package.sourceCode["./meta-operation/maps-options/img11-3.lua"] = { path = "./meta-operation/maps-options/img11-3.lua", name = "./meta-operation/maps-options/img11-3.lua", source = "-- 存储图像信息，用于界面找色、找图。取代图片搜索，因为找色搜索的像素点更少\
local imgBase = require './img'\
\
local transRelativePoint = imgBase.transRelativePoint\
\
return {\
  transRelativePoint = transRelativePoint,\
  -- 基本方法\
  toPoint = imgBase.toPoint,\
  -- 过滤被右下角按钮挡住的部分的点，因为右下角按钮也是黑色的容易与边界识别混淆\
  filterNoUsePoint = imgBase.filterNoUsePoint,\
  -- 图片数据\
  -- 地图扫描\
  map = {\
    -- 地图上边界\
    topLineList = {\
      -- 1-9的上边\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022, }\
        local basePoint, posandcolor = transRelativePoint({\
          { 1567, 510, 0x21203a }, { 1579, 510, 0x191829 },\
          { 1587, 510, 0x101429 }, { 1598, 510, 0x212042 },\
          { 1604, 511, 0x6371ad }, { 1593, 511, 0x6b75b5 },\
          { 1581, 511, 0x6b75ad }, { 1569, 511, 0x6b6dad },\
        })\
        return { basePoint[3], posandcolor, 95, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
      -- 1-8的上边\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022, }\
        local basePoint, posandcolor = transRelativePoint({\
          { 1399, 510, 0x191c31 }, { 1408, 510, 0x21203a },\
          { 1417, 510, 0x191c31 }, { 1429, 510, 0x191c31 },\
          { 1431, 511, 0x636dad }, { 1420, 511, 0x52659c },\
          { 1406, 511, 0x5a659c }, { 1394, 511, 0x5a619c },\
        })\
        return { basePoint[3], posandcolor, 95, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
      -- 1-2的上边\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022, }\
        local basePoint, posandcolor = transRelativePoint({\
          { 777, 515, 0x212031 }, { 793, 515, 0x212031 },\
          { 807, 515, 0x191c31 }, { 822, 515, 0x101829 },\
          { 837, 516, 0x3a3163 }, { 825, 516, 0x3a315a },\
          { 813, 516, 0x3a3163 }, { 802, 516, 0x3a3963 },\
        })\
        return { basePoint[3], posandcolor, 95, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
      -- 1-4的上边\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022, }\
        local basePoint, posandcolor = transRelativePoint({\
          { 1119, 515, 0x191831 }, { 1132, 515, 0x101829 },\
          { 1147, 515, 0x191831 }, { 1160, 515, 0x101829 },\
          { 1171, 516, 0x312d5a }, { 1160, 516, 0x423963 },\
          { 1148, 516, 0x423963 }, { 1136, 516, 0x423963 },\
        })\
        return { basePoint[3], posandcolor, 95, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
      -- 1-5的上边\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022, }\
        local basePoint, posandcolor = transRelativePoint({\
          { 823, 510, 0x191831 }, { 837, 510, 0x191429 },\
          { 850, 510, 0x211831 }, { 864, 510, 0x211831 },\
          { 879, 511, 0x424173 }, { 866, 511, 0x3a3d73 },\
          { 853, 511, 0x3a4173 }, { 837, 511, 0x3a3d6b },\
        })\
        return { basePoint[3], posandcolor, 95, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
      -- 1-2的上边\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022, }\
        local basePoint, posandcolor = transRelativePoint({\
          { 803, 240, 0x21283a }, { 816, 240, 0x293542 },\
          { 833, 240, 0x212842 }, { 850, 240, 0x213542 },\
          { 867, 241, 0x3a3163 }, { 855, 241, 0x3a3163 },\
          { 840, 241, 0x3a3163 }, { 829, 241, 0x3a3163 },\
        })\
        return { basePoint[3], posandcolor, 95, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
      -- 1-4的上边\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022, }\
        local basePoint, posandcolor = transRelativePoint({\
          { 1140, 240, 0x212842 }, { 1158, 240, 0x212842 },\
          { 1175, 240, 0x19243a }, { 1191, 240, 0x19243a },\
          { 1208, 241, 0x3a315a }, { 1192, 241, 0x312d5a },\
          { 1176, 241, 0x312d5a }, { 1163, 241, 0x313163 },\
        })\
        return { basePoint[3], posandcolor, 95, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
      -- 1-5的上边\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022, }\
        local basePoint, posandcolor = transRelativePoint({\
          { 716, 246, 0x212842 }, { 730, 246, 0x212842 },\
          { 747, 246, 0x21283a }, { 764, 246, 0x212842 },\
          { 779, 247, 0x424173 }, { 766, 247, 0x3a3d6b },\
          { 752, 247, 0x31396b }, { 741, 247, 0x3a396b },\
        })\
        return { basePoint[3], posandcolor, 95, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
      -- 1-9的上边\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022, }\
        local basePoint, posandcolor = transRelativePoint({\
          { 1486, 246, 0x293d52 }, { 1501, 246, 0x19283a },\
          { 1513, 246, 0x212d3a }, { 1519, 246, 0x212d42 },\
          { 1519, 247, 0x6b75b5 }, { 1508, 247, 0x636d9c },\
          { 1496, 247, 0x5a6d9c }, { 1484, 247, 0x5a6d9c },\
        })\
        return { basePoint[3], posandcolor, 95, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
    },\
    -- 地图下边界\
    bottonLineList = {\
      -- 6-1 的下面\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022 }\
        local basePoint, posandcolor = transRelativePoint({\
          { 359, 966, 0x000000 }, { 370, 966, 0x000000 },\
          { 384, 966, 0x000000 }, { 397, 966, 0x000000 },\
          { 407, 968, 0x000000 }, { 398, 968, 0x000000 },\
          { 391, 968, 0x000000 }, { 396, 965, 0x212042 },\
          { 386, 965, 0x212042 }, { 380, 965, 0x212042 },\
        })\
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
      -- 7-1 的下面\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022 }\
        local basePoint, posandcolor = transRelativePoint({\
          { 443, 944, 0x000000 }, { 456, 944, 0x000000 },\
          { 470, 944, 0x000000 }, { 482, 944, 0x000000 },\
          { 489, 943, 0x29204a }, { 476, 943, 0x211c42 },\
          { 464, 943, 0x212042 }, { 455, 943, 0x29204a },\
          { 455, 946, 0x000000 }, { 473, 946, 0x000000 },\
        })\
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
      -- 7-4的下面\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022 }\
        local basePoint, posandcolor = transRelativePoint({\
          { 1107, 944, 0x000000 }, { 1123, 944, 0x000000 },\
          { 1138, 944, 0x000000 }, { 1158, 944, 0x000000 },\
          { 1170, 943, 0x29204a }, { 1155, 943, 0x29244a },\
          { 1140, 943, 0x292042 }, { 1127, 943, 0x29244a },\
          { 1135, 946, 0x000000 }, { 1157, 946, 0x000000 },\
        })\
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
      -- 7-7 的下面\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022 }\
        local basePoint, posandcolor = transRelativePoint({\
          { 1028, 913, 0x000000 }, { 1048, 913, 0x000000 },\
          { 1067, 913, 0x000000 }, { 1081, 913, 0x000000 },\
          { 1097, 912, 0x31284a }, { 1079, 912, 0x29284a },\
          { 1062, 912, 0x312852 }, { 1048, 912, 0x312452 },\
          { 1052, 915, 0x000000 }, { 1069, 915, 0x000000 },\
        })\
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
    },\
    -- 地图左边界\
    leftLineList = {\
      -- 2-1 的左边\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022, }\
        local basePoint, posandcolor = transRelativePoint({\
          { 573, 390, 0x000000 }, { 574, 390, 0x312852 },\
          { 573, 389, 0x000000 }, { 574, 389, 0x29244a },\
          { 572, 391, 0x000000 }, { 573, 391, 0x312852 },\
          { 572, 392, 0x000000 }, { 573, 392, 0x312452 },\
        })\
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
      -- 3-1 的左边\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022, }\
        local basePoint, posandcolor = transRelativePoint({\
          { 555, 526, 0x000000 }, { 556, 526, 0x31395a },\
          { 555, 525, 0x000000 }, { 556, 525, 0x312d52 },\
          { 554, 527, 0x000000 }, { 555, 527, 0x312d5a },\
          { 554, 528, 0x000000 }, { 555, 528, 0x312d52 },\
        })\
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
      -- 6-1 的左边\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022, }\
        local basePoint, posandcolor = transRelativePoint({\
          { 537, 661, 0x000000 }, { 538, 661, 0x29244a },\
          { 537, 660, 0x000000 }, { 538, 660, 0x312852 },\
          { 536, 662, 0x000000 }, { 537, 662, 0x292452 },\
          { 536, 663, 0x000000 }, { 537, 663, 0x292852 },\
        })\
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
      -- 7-1 的左边\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022, }\
        local basePoint, posandcolor = transRelativePoint({\
          { 388, 879, 0x000000 }, { 389, 879, 0x212042 },\
          { 388, 878, 0x000000 }, { 389, 878, 0x212042 },\
          { 387, 880, 0x000000 }, { 388, 880, 0x29204a },\
          { 387, 881, 0x000000 }, { 388, 881, 0x212042 },\
        })\
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
    },\
    -- 地图右边界\
    rightLineList = {\
      -- 1-9 的右边\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022, }\
        local basePoint, posandcolor = transRelativePoint({\
          { 1611, 539, 0x000000 }, { 1610, 539, 0x636dad },\
          { 1611, 538, 0x000000 }, { 1610, 538, 0x6b71b5 },\
          { 1612, 540, 0x000000 }, { 1611, 540, 0x636dad },\
          { 1612, 541, 0x000000 }, { 1611, 541, 0x636db5 },\
        })\
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
      -- 2-9 的右边\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022, }\
        local basePoint, posandcolor = transRelativePoint({\
          { 1547, 383, 0x000000 }, { 1546, 383, 0x5a59a4 },\
          { 1547, 382, 0x000000 }, { 1546, 382, 0x635dad },\
          { 1548, 384, 0x000000 }, { 1547, 384, 0x5a599c },\
          { 1548, 385, 0x000000 }, { 1547, 385, 0x5a59a4 },\
        })\
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
      -- 7-9 的右边\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022, }\
        local basePoint, posandcolor = transRelativePoint({\
          { 1676, 848, 0x000000 }, { 1675, 848, 0x3a3163 },\
          { 1676, 847, 0x000000 }, { 1675, 847, 0x3a3563 },\
          { 1677, 849, 0x000000 }, { 1676, 849, 0x3a3163 },\
          { 1677, 850, 0x000000 }, { 1676, 850, 0x3a3d63 },\
        })\
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
      -- 5-9 的右边\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022, }\
        local basePoint, posandcolor = transRelativePoint({\
          { 1594, 462, 0x000000 }, { 1593, 462, 0x42396b },\
          { 1594, 461, 0x000000 }, { 1593, 461, 0x42396b },\
          { 1595, 463, 0x000000 }, { 1594, 463, 0x42396b },\
          { 1595, 464, 0x000000 }, { 1594, 464, 0x424173 },\
        })\
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
    },\
    -- 我方舰队位置\
    myFleetList = imgBase.map.myFleetList,\
    -- 我放舰队被选中的舰队的绿色的选中箭头的位置\
    selectedArrow = imgBase.map.selectedArrow,\
    -- 敌方舰队位置(小型舰队)\
    enemyList1 = imgBase.map.enemyList1,\
    -- 敌方舰队位置(中型舰队)\
    enemyList2 = imgBase.map.enemyList2,\
    -- 敌方舰队位置(大型舰队)\
    enemyList3 = imgBase.map.enemyList3,\
    -- boss位置\
    bossPointList = imgBase.map.bossPointList,\
    -- 战斗中的位置\
    inBattleList = imgBase.map.inBattleList,\
    -- 奖励箱的位置\
    rewardBoxList = imgBase.map.rewardBoxList,\
  },\
}" }


package.sourceCode = package.sourceCode or {}
package.sourceCode["./meta-operation/maps-options/img11-2.lua"] = { path = "./meta-operation/maps-options/img11-2.lua", name = "./meta-operation/maps-options/img11-2.lua", source = "-- 存储图像信息，用于界面找色、找图。取代图片搜索，因为找色搜索的像素点更少\
local imgBase = require './img'\
\
local transRelativePoint = imgBase.transRelativePoint\
\
return {\
  transRelativePoint = transRelativePoint,\
  -- 基本方法\
  toPoint = imgBase.toPoint,\
  -- 过滤被右下角按钮挡住的部分的点，因为右下角按钮也是黑色的容易与边界识别混淆\
  filterNoUsePoint = imgBase.filterNoUsePoint,\
  -- 图片数据\
  -- 地图扫描\
  map = {\
    -- 地图上边界\
    topLineList = {\
      -- 1-8的上边\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022, }\
        local basePoint, posandcolor = transRelativePoint({\
          { 1514, 542, 0x212042 }, { 1522, 542, 0x212042 },\
          { 1533, 542, 0x191c29 }, { 1549, 542, 0x191c29 },\
          { 1560, 543, 0x6371ad }, { 1550, 543, 0x6371ad },\
          { 1540, 543, 0x6371ad }, { 1531, 543, 0x6b71b5 },\
        })\
        return { basePoint[3], posandcolor, 93, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
      -- 1-1的上边\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022, }\
        local basePoint, posandcolor = transRelativePoint({\
          { 261, 542, 0x081019 }, { 269, 542, 0x081019 },\
          { 282, 542, 0x211421 }, { 290, 542, 0x211421 },\
          { 298, 543, 0x312d5a }, { 288, 543, 0x312d5a },\
          { 279, 543, 0x3a2d63 }, { 268, 543, 0x312d5a },\
        })\
        return { basePoint[3], posandcolor, 93, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
      -- 1-7的上边\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022, }\
        local basePoint, posandcolor = transRelativePoint({\
          { 1379, 542, 0x29313a }, { 1387, 542, 0x21313a },\
          { 1393, 542, 0x212d31 }, { 1400, 542, 0x313d42 },\
          { 1408, 543, 0x5a699c }, { 1398, 543, 0x5a65a4 },\
          { 1388, 543, 0x5a659c }, { 1380, 543, 0x5a619c },\
        })\
        return { basePoint[3], posandcolor, 93, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
      -- 1-7的上边\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022, }\
        local basePoint, posandcolor = transRelativePoint({\
          { 1072, 519, 0x000c10 }, { 1082, 519, 0x000c10 },\
          { 1091, 519, 0x101019 }, { 1098, 519, 0x000c10 },\
          { 1107, 520, 0x3a4173 }, { 1100, 520, 0x424573 },\
          { 1091, 520, 0x3a416b }, { 1082, 520, 0x3a416b },\
        })\
        return { basePoint[3], posandcolor, 93, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
      -- 1-2的上边\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022, }\
        local basePoint, posandcolor = transRelativePoint({\
          { 422, 542, 0x101421 }, { 436, 542, 0x101421 },\
          { 449, 542, 0x081019 }, { 458, 542, 0x211421 },\
          { 467, 543, 0x3a3163 }, { 458, 543, 0x312d5a },\
          { 448, 543, 0x3a315a }, { 439, 543, 0x3a3163 },\
        })\
        return { basePoint[3], posandcolor, 93, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
      -- 1-5的上边\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022, }\
        local basePoint, posandcolor = transRelativePoint({\
          { 1276, 527, 0x101421 }, { 1288, 527, 0x101421 },\
          { 1301, 527, 0x101429 }, { 1311, 527, 0x191829 },\
          { 1322, 528, 0x42457b }, { 1312, 528, 0x42457b },\
          { 1303, 528, 0x42497b }, { 1293, 528, 0x424573 },\
        })\
        return { basePoint[3], posandcolor, 93, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
    },\
    -- 地图下边界\
    bottonLineList = {\
      -- 6-1 的下面\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022 }\
        local basePoint, posandcolor = transRelativePoint({\
          { 359, 966, 0x000000 }, { 370, 966, 0x000000 },\
          { 384, 966, 0x000000 }, { 397, 966, 0x000000 },\
          { 407, 968, 0x000000 }, { 398, 968, 0x000000 },\
          { 391, 968, 0x000000 }, { 396, 965, 0x212042 },\
          { 386, 965, 0x212042 }, { 380, 965, 0x212042 },\
        })\
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
      -- 6-1 的下面\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022 }\
        local basePoint, posandcolor = transRelativePoint({\
          { 451, 995, 0x000000 }, { 465, 995, 0x000000 },\
          { 478, 995, 0x000000 }, { 492, 995, 0x000000 },\
          { 503, 994, 0x29204a }, { 490, 994, 0x29204a },\
          { 477, 994, 0x212042 }, { 468, 994, 0x29204a },\
          { 477, 997, 0x000000 }, { 458, 997, 0x000000 },\
        })\
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
      -- 6-2 的下面\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022 }\
        local basePoint, posandcolor = transRelativePoint({\
          { 697, 995, 0x000000 }, { 709, 995, 0x000000 },\
          { 720, 995, 0x000000 }, { 732, 995, 0x000000 },\
          { 741, 994, 0x29204a }, { 733, 994, 0x29204a },\
          { 722, 994, 0x312452 }, { 713, 994, 0x29204a },\
          { 714, 997, 0x000000 }, { 697, 997, 0x000000 },\
        })\
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
      -- 6-4 的下面\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022 }\
        local basePoint, posandcolor = transRelativePoint({\
          { 478, 953, 0x000000 }, { 491, 953, 0x000000 },\
          { 504, 953, 0x000000 }, { 517, 953, 0x000000 },\
          { 530, 952, 0x31244a }, { 520, 952, 0x31244a },\
          { 510, 952, 0x31244a }, { 498, 952, 0x31204a },\
          { 520, 955, 0x000000 }, { 502, 955, 0x000000 },\
        })\
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
    },\
    -- 地图左边界\
    leftLineList = {\
      -- 1-1 的左边\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022, }\
        local basePoint, posandcolor = transRelativePoint({\
          { 574, 556, 0x000000 }, { 575, 556, 0x31285a },\
          { 574, 555, 0x000000 }, { 575, 555, 0x312d5a },\
          { 573, 557, 0x000000 }, { 574, 557, 0x292852 },\
          { 573, 558, 0x000000 }, { 574, 558, 0x31355a },\
        })\
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
      -- 2-1 的左边\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022, }\
        local basePoint, posandcolor = transRelativePoint({\
          { 558, 684, 0x000000 }, { 559, 684, 0x312852 },\
          { 558, 683, 0x000000 }, { 559, 683, 0x312852 },\
          { 557, 685, 0x000000 }, { 558, 685, 0x29244a },\
          { 557, 686, 0x000000 }, { 558, 686, 0x312852 },\
        })\
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
      -- 6-1 的左边\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022, }\
        local basePoint, posandcolor = transRelativePoint({\
          { 429, 907, 0x000000 }, { 430, 907, 0x211c42 },\
          { 429, 906, 0x000000 }, { 430, 906, 0x29204a },\
          { 428, 908, 0x000000 }, { 429, 908, 0x29204a },\
          { 428, 909, 0x000000 }, { 429, 909, 0x29204a },\
        })\
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
    },\
    -- 地图右边界\
    rightLineList = {\
      -- 1-8 的右边\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022, }\
        local basePoint, posandcolor = transRelativePoint({\
          { 1588, 566, 0x000000 }, { 1587, 566, 0x636db5 },\
          { 1588, 565, 0x000000 }, { 1587, 565, 0x636db5 },\
          { 1589, 567, 0x000000 }, { 1588, 567, 0x636dad },\
          { 1589, 568, 0x000000 }, { 1588, 568, 0x6b6db5 },\
        })\
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
      -- 2-8 的右边\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022, }\
        local basePoint, posandcolor = transRelativePoint({\
          { 1615, 699, 0x000000 }, { 1614, 699, 0x5a559c },\
          { 1615, 698, 0x000000 }, { 1614, 698, 0x6359a4 },\
          { 1616, 700, 0x000000 }, { 1615, 700, 0x5a559c },\
          { 1616, 701, 0x000000 }, { 1615, 701, 0x5a55a4 },\
        })\
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
      -- 4-8 的右边\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022, }\
        local basePoint, posandcolor = transRelativePoint({\
          { 1477, 535, 0x000000 }, { 1476, 535, 0x424173 },\
          { 1477, 534, 0x000000 }, { 1476, 534, 0x42457b },\
          { 1478, 536, 0x000000 }, { 1477, 536, 0x42417b },\
          { 1478, 537, 0x000000 }, { 1477, 537, 0x42417b },\
        })\
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
      -- 6-8 的右边\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022, }\
        local basePoint, posandcolor = transRelativePoint({\
          { 1527, 831, 0x000000 }, { 1526, 831, 0x312d5a },\
          { 1527, 830, 0x000000 }, { 1526, 830, 0x423963 },\
          { 1528, 832, 0x000000 }, { 1527, 832, 0x312d5a },\
          { 1528, 833, 0x000000 }, { 1527, 833, 0x3a3163 },\
        })\
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
    },\
    -- 我方舰队位置\
    myFleetList = imgBase.map.myFleetList,\
    -- 我放舰队被选中的舰队的绿色的选中箭头的位置\
    selectedArrow = imgBase.map.selectedArrow,\
    -- 敌方舰队位置(小型舰队)\
    enemyList1 = imgBase.map.enemyList1,\
    -- 敌方舰队位置(中型舰队)\
    enemyList2 = imgBase.map.enemyList2,\
    -- 敌方舰队位置(大型舰队)\
    enemyList3 = imgBase.map.enemyList3,\
    -- boss位置\
    bossPointList = imgBase.map.bossPointList,\
    -- 战斗中的位置\
    inBattleList = imgBase.map.inBattleList,\
    -- 奖励箱的位置\
    rewardBoxList = imgBase.map.rewardBoxList,\
  },\
}" }


package.sourceCode = package.sourceCode or {}
package.sourceCode["./meta-operation/maps-options/img11-1.lua"] = { path = "./meta-operation/maps-options/img11-1.lua", name = "./meta-operation/maps-options/img11-1.lua", source = "-- 存储图像信息，用于界面找色、找图。取代图片搜索，因为找色搜索的像素点更少\
local imgBase = require './img'\
\
local transRelativePoint = imgBase.transRelativePoint\
\
return {\
  transRelativePoint = transRelativePoint,\
  -- 基本方法\
  toPoint = imgBase.toPoint,\
  -- 过滤被右下角按钮挡住的部分的点，因为右下角按钮也是黑色的容易与边界识别混淆\
  filterNoUsePoint = imgBase.filterNoUsePoint,\
  -- 图片数据\
  -- 地图扫描\
  map = {\
    -- 地图上边界\
    topLineList = {\
      -- 1-8的上边\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022, }\
        local basePoint, posandcolor = transRelativePoint({\
          { 1514, 542, 0x212042 }, { 1522, 542, 0x212042 },\
          { 1533, 542, 0x191c29 }, { 1549, 542, 0x191c29 },\
          { 1560, 543, 0x6371ad }, { 1550, 543, 0x6371ad },\
          { 1540, 543, 0x6371ad }, { 1531, 543, 0x6b71b5 },\
        })\
        return { basePoint[3], posandcolor, 93, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
      -- 1-1的上边\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022, }\
        local basePoint, posandcolor = transRelativePoint({\
          { 261, 542, 0x081019 }, { 269, 542, 0x081019 },\
          { 282, 542, 0x211421 }, { 290, 542, 0x211421 },\
          { 298, 543, 0x312d5a }, { 288, 543, 0x312d5a },\
          { 279, 543, 0x3a2d63 }, { 268, 543, 0x312d5a },\
        })\
        return { basePoint[3], posandcolor, 93, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
      -- 1-7的上边\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022, }\
        local basePoint, posandcolor = transRelativePoint({\
          { 1379, 542, 0x29313a }, { 1387, 542, 0x21313a },\
          { 1393, 542, 0x212d31 }, { 1400, 542, 0x313d42 },\
          { 1408, 543, 0x5a699c }, { 1398, 543, 0x5a65a4 },\
          { 1388, 543, 0x5a659c }, { 1380, 543, 0x5a619c },\
        })\
        return { basePoint[3], posandcolor, 93, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
      -- 1-7的上边\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022, }\
        local basePoint, posandcolor = transRelativePoint({\
          { 1072, 519, 0x000c10 }, { 1082, 519, 0x000c10 },\
          { 1091, 519, 0x101019 }, { 1098, 519, 0x000c10 },\
          { 1107, 520, 0x3a4173 }, { 1100, 520, 0x424573 },\
          { 1091, 520, 0x3a416b }, { 1082, 520, 0x3a416b },\
        })\
        return { basePoint[3], posandcolor, 93, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
      -- 1-2的上边\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022, }\
        local basePoint, posandcolor = transRelativePoint({\
          { 422, 542, 0x101421 }, { 436, 542, 0x101421 },\
          { 449, 542, 0x081019 }, { 458, 542, 0x211421 },\
          { 467, 543, 0x3a3163 }, { 458, 543, 0x312d5a },\
          { 448, 543, 0x3a315a }, { 439, 543, 0x3a3163 },\
        })\
        return { basePoint[3], posandcolor, 93, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
      -- 1-5的上边\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022, }\
        local basePoint, posandcolor = transRelativePoint({\
          { 1276, 527, 0x101421 }, { 1288, 527, 0x101421 },\
          { 1301, 527, 0x101429 }, { 1311, 527, 0x191829 },\
          { 1322, 528, 0x42457b }, { 1312, 528, 0x42457b },\
          { 1303, 528, 0x42497b }, { 1293, 528, 0x424573 },\
        })\
        return { basePoint[3], posandcolor, 93, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
    },\
    -- 地图下边界\
    bottonLineList = {\
      -- 6-1 的下面\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022 }\
        local basePoint, posandcolor = transRelativePoint({\
          { 359, 966, 0x000000 }, { 370, 966, 0x000000 },\
          { 384, 966, 0x000000 }, { 397, 966, 0x000000 },\
          { 407, 968, 0x000000 }, { 398, 968, 0x000000 },\
          { 391, 968, 0x000000 }, { 396, 965, 0x212042 },\
          { 386, 965, 0x212042 }, { 380, 965, 0x212042 },\
        })\
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
      -- 6-1 的下面\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022 }\
        local basePoint, posandcolor = transRelativePoint({\
          { 451, 995, 0x000000 }, { 465, 995, 0x000000 },\
          { 478, 995, 0x000000 }, { 492, 995, 0x000000 },\
          { 503, 994, 0x29204a }, { 490, 994, 0x29204a },\
          { 477, 994, 0x212042 }, { 468, 994, 0x29204a },\
          { 477, 997, 0x000000 }, { 458, 997, 0x000000 },\
        })\
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
      -- 6-2 的下面\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022 }\
        local basePoint, posandcolor = transRelativePoint({\
          { 697, 995, 0x000000 }, { 709, 995, 0x000000 },\
          { 720, 995, 0x000000 }, { 732, 995, 0x000000 },\
          { 741, 994, 0x29204a }, { 733, 994, 0x29204a },\
          { 722, 994, 0x312452 }, { 713, 994, 0x29204a },\
          { 714, 997, 0x000000 }, { 697, 997, 0x000000 },\
        })\
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
      -- 6-4 的下面\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022 }\
        local basePoint, posandcolor = transRelativePoint({\
          { 478, 953, 0x000000 }, { 491, 953, 0x000000 },\
          { 504, 953, 0x000000 }, { 517, 953, 0x000000 },\
          { 530, 952, 0x31244a }, { 520, 952, 0x31244a },\
          { 510, 952, 0x31244a }, { 498, 952, 0x31204a },\
          { 520, 955, 0x000000 }, { 502, 955, 0x000000 },\
        })\
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
    },\
    -- 地图左边界\
    leftLineList = {\
      -- 1-1 的左边\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022, }\
        local basePoint, posandcolor = transRelativePoint({\
          { 574, 556, 0x000000 }, { 575, 556, 0x31285a },\
          { 574, 555, 0x000000 }, { 575, 555, 0x312d5a },\
          { 573, 557, 0x000000 }, { 574, 557, 0x292852 },\
          { 573, 558, 0x000000 }, { 574, 558, 0x31355a },\
        })\
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
      -- 2-1 的左边\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022, }\
        local basePoint, posandcolor = transRelativePoint({\
          { 558, 684, 0x000000 }, { 559, 684, 0x312852 },\
          { 558, 683, 0x000000 }, { 559, 683, 0x312852 },\
          { 557, 685, 0x000000 }, { 558, 685, 0x29244a },\
          { 557, 686, 0x000000 }, { 558, 686, 0x312852 },\
        })\
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
      -- 6-1 的左边\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022, }\
        local basePoint, posandcolor = transRelativePoint({\
          { 429, 907, 0x000000 }, { 430, 907, 0x211c42 },\
          { 429, 906, 0x000000 }, { 430, 906, 0x29204a },\
          { 428, 908, 0x000000 }, { 429, 908, 0x29204a },\
          { 428, 909, 0x000000 }, { 429, 909, 0x29204a },\
        })\
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
    },\
    -- 地图右边界\
    rightLineList = {\
      -- 1-8 的右边\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022, }\
        local basePoint, posandcolor = transRelativePoint({\
          { 1588, 566, 0x000000 }, { 1587, 566, 0x636db5 },\
          { 1588, 565, 0x000000 }, { 1587, 565, 0x636db5 },\
          { 1589, 567, 0x000000 }, { 1588, 567, 0x636dad },\
          { 1589, 568, 0x000000 }, { 1588, 568, 0x6b6db5 },\
        })\
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
      -- 2-8 的右边\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022, }\
        local basePoint, posandcolor = transRelativePoint({\
          { 1615, 699, 0x000000 }, { 1614, 699, 0x5a559c },\
          { 1615, 698, 0x000000 }, { 1614, 698, 0x6359a4 },\
          { 1616, 700, 0x000000 }, { 1615, 700, 0x5a559c },\
          { 1616, 701, 0x000000 }, { 1615, 701, 0x5a55a4 },\
        })\
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
      -- 4-8 的右边\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022, }\
        local basePoint, posandcolor = transRelativePoint({\
          { 1477, 535, 0x000000 }, { 1476, 535, 0x424173 },\
          { 1477, 534, 0x000000 }, { 1476, 534, 0x42457b },\
          { 1478, 536, 0x000000 }, { 1477, 536, 0x42417b },\
          { 1478, 537, 0x000000 }, { 1477, 537, 0x42417b },\
        })\
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
      -- 6-8 的右边\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022, }\
        local basePoint, posandcolor = transRelativePoint({\
          { 1527, 831, 0x000000 }, { 1526, 831, 0x312d5a },\
          { 1527, 830, 0x000000 }, { 1526, 830, 0x423963 },\
          { 1528, 832, 0x000000 }, { 1527, 832, 0x312d5a },\
          { 1528, 833, 0x000000 }, { 1527, 833, 0x3a3163 },\
        })\
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
    },\
    -- 我方舰队位置\
    myFleetList = imgBase.map.myFleetList,\
    -- 我放舰队被选中的舰队的绿色的选中箭头的位置\
    selectedArrow = imgBase.map.selectedArrow,\
    -- 敌方舰队位置(小型舰队)\
    enemyList1 = imgBase.map.enemyList1,\
    -- 敌方舰队位置(中型舰队)\
    enemyList2 = imgBase.map.enemyList2,\
    -- 敌方舰队位置(大型舰队)\
    enemyList3 = imgBase.map.enemyList3,\
    -- boss位置\
    bossPointList = imgBase.map.bossPointList,\
    -- 战斗中的位置\
    inBattleList = imgBase.map.inBattleList,\
    -- 奖励箱的位置\
    rewardBoxList = imgBase.map.rewardBoxList,\
  },\
}" }


package.sourceCode = package.sourceCode or {}
package.sourceCode["./meta-operation/maps-options/img10-3.lua"] = { path = "./meta-operation/maps-options/img10-3.lua", name = "./meta-operation/maps-options/img10-3.lua", source = "-- 存储图像信息，用于界面找色、找图。取代图片搜索，因为找色搜索的像素点更少\
local imgBase = require './img'\
\
local transRelativePoint = imgBase.transRelativePoint\
\
return {\
  transRelativePoint = transRelativePoint,\
  -- 基本方法\
  toPoint = imgBase.toPoint,\
  -- 过滤被右下角按钮挡住的部分的点，因为右下角按钮也是黑色的容易与边界识别混淆\
  filterNoUsePoint = imgBase.filterNoUsePoint,\
  -- 图片数据\
  -- 地图扫描\
  map = {\
    -- 地图上边界\
    topLineList = {\
      -- 1-2的上边\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022, }\
        local basePoint, posandcolor = transRelativePoint({\
          { 694, 507, 0x212431 }, { 712, 507, 0x192031 },\
          { 725, 507, 0x21243a }, { 744, 507, 0x192031 },\
          { 762, 508, 0x3a3963 }, { 748, 508, 0x423963 },\
          { 730, 508, 0x3a3963 }, { 713, 508, 0x3a2d63 },\
        })\
        return { basePoint[3], posandcolor, 93, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
      -- 1-9的上边\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022, }\
        local basePoint, posandcolor = transRelativePoint({\
          { 1570, 505, 0x101821 }, { 1580, 505, 0x101429 },\
          { 1592, 505, 0x081421 }, { 1604, 505, 0x191c29 },\
          { 1606, 506, 0x6b75b5 }, { 1596, 506, 0x6b75b5 },\
          { 1585, 506, 0x6b6d9c }, { 1572, 506, 0x6b71b5 },\
        })\
        return { basePoint[3], posandcolor, 93, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
      -- 1-7的上边\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022, }\
        local basePoint, posandcolor = transRelativePoint({\
          { 1126, 505, 0x101829 }, { 1137, 505, 0x191831 },\
          { 1148, 505, 0x191829 }, { 1158, 505, 0x101829 },\
          { 1165, 506, 0x3a4173 }, { 1150, 506, 0x424173 },\
          { 1137, 506, 0x3a3d6b }, { 1122, 506, 0x424173 },\
        })\
        return { basePoint[3], posandcolor, 93, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
      -- 1-5的上边\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022, }\
        local basePoint, posandcolor = transRelativePoint({\
          { 816, 505, 0x191829 }, { 835, 505, 0x191831 },\
          { 845, 505, 0x191831 }, { 857, 505, 0x191831 },\
          { 869, 506, 0x3a3d73 }, { 860, 506, 0x42417b },\
          { 843, 506, 0x3a3d6b }, { 824, 506, 0x3a416b },\
        })\
        return { basePoint[3], posandcolor, 93, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
      -- 1-3的上边\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022, }\
        local basePoint, posandcolor = transRelativePoint({\
          { 879, 507, 0x191831 }, { 893, 507, 0x191831 },\
          { 904, 507, 0x101429 }, { 920, 507, 0x101429 },\
          { 933, 508, 0x3a3163 }, { 927, 508, 0x3a315a },\
          { 911, 508, 0x3a3163 }, { 894, 508, 0x3a3963 },\
        })\
        return { basePoint[3], posandcolor, 93, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
    },\
    -- 地图下边界\
    bottonLineList = {\
      -- 6-1 的下面\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022 }\
        local basePoint, posandcolor = transRelativePoint({\
          { 493, 909, 0x000000 }, { 511, 909, 0x000000 },\
          { 522, 909, 0x000000 }, { 532, 909, 0x000000 },\
          { 545, 908, 0x29204a }, { 535, 908, 0x212042 },\
          { 520, 908, 0x29204a }, { 508, 908, 0x29204a },\
          { 507, 911, 0x000000 }, { 525, 911, 0x000000 },\
        })\
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
      -- 6-2 的下面\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022 }\
        local basePoint, posandcolor = transRelativePoint({\
          { 728, 909, 0x000000 }, { 741, 909, 0x000000 },\
          { 757, 909, 0x000000 }, { 778, 909, 0x000000 },\
          { 789, 908, 0x29204a }, { 779, 908, 0x29204a },\
          { 763, 908, 0x29204a }, { 749, 908, 0x29204a },\
          { 746, 911, 0x000000 }, { 769, 911, 0x000000 },\
        })\
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
      -- 6-4 的下面\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022 }\
        local basePoint, posandcolor = transRelativePoint({\
          { 272, 912, 0x000000 }, { 291, 912, 0x000000 },\
          { 313, 912, 0x000000 }, { 335, 912, 0x000000 },\
          { 352, 911, 0x212442 }, { 335, 911, 0x29244a },\
          { 315, 911, 0x29244a }, { 298, 911, 0x29204a },\
          { 298, 914, 0x000000 }, { 325, 914, 0x000000 },\
        })\
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
      -- 6-7 的下面\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022 }\
        local basePoint, posandcolor = transRelativePoint({\
          { 976, 912, 0x000000 }, { 992, 912, 0x000000 },\
          { 1009, 912, 0x000000 }, { 1031, 912, 0x000000 },\
          { 1048, 911, 0x29244a }, { 1030, 911, 0x29284a },\
          { 1013, 911, 0x29284a }, { 1000, 911, 0x29284a },\
          { 1000, 914, 0x000000 }, { 1026, 914, 0x000000 },\
        })\
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
    },\
    -- 地图左边界\
    leftLineList = {\
      -- 2-1 的左边\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022, }\
        local basePoint, posandcolor = transRelativePoint({\
          { 472, 657, 0x000000 }, { 473, 657, 0x312852 },\
          { 472, 656, 0x000000 }, { 473, 656, 0x292852 },\
          { 471, 658, 0x000000 }, { 472, 658, 0x312852 },\
          { 471, 659, 0x000000 }, { 472, 659, 0x292852 },\
        })\
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
      -- 3-1 的左边\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022, }\
        local basePoint, posandcolor = transRelativePoint({\
          { 522, 532, 0x000000 }, { 523, 532, 0x312d52 },\
          { 522, 531, 0x000000 }, { 523, 531, 0x312d5a },\
          { 521, 533, 0x000000 }, { 522, 533, 0x292d52 },\
          { 521, 534, 0x000000 }, { 522, 534, 0x31355a },\
        })\
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
      -- 4-1 的左边\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022, }\
        local basePoint, posandcolor = transRelativePoint({\
          { 502, 672, 0x000000 }, { 503, 672, 0x292452 },\
          { 502, 671, 0x000000 }, { 503, 671, 0x312852 },\
          { 501, 673, 0x000000 }, { 502, 673, 0x29244a },\
          { 501, 674, 0x000000 }, { 502, 674, 0x312852 },\
        })\
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
      -- 7-1 的左边\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022, }\
        local basePoint, posandcolor = transRelativePoint({\
          { 457, 834, 0x000000 }, { 458, 834, 0x29204a },\
          { 457, 833, 0x000000 }, { 458, 833, 0x211c42 },\
          { 456, 835, 0x000000 }, { 457, 835, 0x29204a },\
          { 456, 836, 0x000000 }, { 457, 836, 0x29204a },\
        })\
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
    },\
    -- 地图右边界\
    rightLineList = {\
      -- 1-9 的右边\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022, }\
        local basePoint, posandcolor = transRelativePoint({\
          { 1615, 546, 0x000000 }, { 1614, 546, 0x636db5 },\
          { 1615, 545, 0x000000 }, { 1614, 545, 0x5a69ad },\
          { 1616, 547, 0x000000 }, { 1615, 547, 0x636db5 },\
          { 1616, 548, 0x000000 }, { 1615, 548, 0x6369ad },\
        })\
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
      -- 2-9 的右边\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022, }\
        local basePoint, posandcolor = transRelativePoint({\
          { 1639, 658, 0x000000 }, { 1638, 658, 0x635dad },\
          { 1639, 657, 0x000000 }, { 1638, 657, 0x5a599c },\
          { 1640, 659, 0x000000 }, { 1639, 659, 0x6359a4 },\
          { 1640, 660, 0x000000 }, { 1639, 660, 0x5a599c },\
        })\
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
      -- 4-9 的右边\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022, }\
        local basePoint, posandcolor = transRelativePoint({\
          { 1569, 646, 0x000000 }, { 1568, 646, 0x4a417b },\
          { 1569, 645, 0x000000 }, { 1568, 645, 0x4a3d7b },\
          { 1570, 647, 0x000000 }, { 1569, 647, 0x4a417b },\
          { 1570, 648, 0x000000 }, { 1569, 648, 0x4a417b },\
        })\
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
      -- 6-9 的右边\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022, }\
        local basePoint, posandcolor = transRelativePoint({\
          { 1611, 814, 0x000000 }, { 1610, 814, 0x423963 },\
          { 1611, 813, 0x000000 }, { 1610, 813, 0x312d5a },\
          { 1612, 815, 0x000000 }, { 1611, 815, 0x3a3163 },\
          { 1612, 816, 0x000000 }, { 1611, 816, 0x31315a },\
        })\
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
    },\
    -- 我方舰队位置\
    myFleetList = imgBase.map.myFleetList,\
    -- 我放舰队被选中的舰队的绿色的选中箭头的位置\
    selectedArrow = imgBase.map.selectedArrow,\
    -- 敌方舰队位置(小型舰队)\
    enemyList1 = imgBase.map.enemyList1,\
    -- 敌方舰队位置(中型舰队)\
    enemyList2 = imgBase.map.enemyList2,\
    -- 敌方舰队位置(大型舰队)\
    enemyList3 = imgBase.map.enemyList3,\
    -- boss位置\
    bossPointList = imgBase.map.bossPointList,\
    -- 战斗中的位置\
    inBattleList = imgBase.map.inBattleList,\
    -- 奖励箱的位置\
    rewardBoxList = imgBase.map.rewardBoxList,\
  },\
}" }


package.sourceCode = package.sourceCode or {}
package.sourceCode["./meta-operation/maps-options/img10-2.lua"] = { path = "./meta-operation/maps-options/img10-2.lua", name = "./meta-operation/maps-options/img10-2.lua", source = "-- 存储图像信息，用于界面找色、找图。取代图片搜索，因为找色搜索的像素点更少\
local imgBase = require './img'\
\
local transRelativePoint = imgBase.transRelativePoint\
\
return {\
  transRelativePoint = transRelativePoint,\
  -- 基本方法\
  toPoint = imgBase.toPoint,\
  -- 过滤被右下角按钮挡住的部分的点，因为右下角按钮也是黑色的容易与边界识别混淆\
  filterNoUsePoint = imgBase.filterNoUsePoint,\
  -- 图片数据\
  -- 地图扫描\
  map = {\
    -- 地图上边界\
    topLineList = {\
      -- 1-2的上边\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022, }\
        local basePoint, posandcolor = transRelativePoint({\
          { 880, 519, 0x081421 }, { 893, 519, 0x101829 },\
          { 904, 519, 0x081421 }, { 917, 519, 0x101829 },\
          { 926, 520, 0x3a3963 }, { 916, 520, 0x423963 },\
          { 906, 520, 0x3a3963 }, { 897, 520, 0x3a3163 },\
        })\
        return { basePoint[3], posandcolor, 93, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
      -- 1-6的上边\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022, }\
        local basePoint, posandcolor = transRelativePoint({\
          { 1427, 529, 0x192031 }, { 1415, 529, 0x192431 },\
          { 1403, 529, 0x192431 }, { 1395, 529, 0x192031 },\
          { 1403, 530, 0x525594 }, { 1413, 530, 0x525994 },\
          { 1421, 530, 0x525d94 }, { 1431, 530, 0x5a5d9c },\
        })\
        return { basePoint[3], posandcolor, 93, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
      -- 1-3的上边\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022, }\
        local basePoint, posandcolor = transRelativePoint({\
          { 984, 519, 0x081421 }, { 992, 519, 0x081421 },\
          { 1001, 519, 0x101829 }, { 1011, 519, 0x191829 },\
          { 1022, 520, 0x3a3963 }, { 1011, 520, 0x3a3163 },\
          { 1001, 520, 0x3a3163 }, { 990, 520, 0x3a3d63 },\
        })\
        return { basePoint[3], posandcolor, 93, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
      -- 1-4的上边\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022, }\
        local basePoint, posandcolor = transRelativePoint({\
          { 1160, 519, 0x081821 }, { 1171, 519, 0x191831 },\
          { 1183, 519, 0x191831 }, { 1196, 519, 0x081821 },\
          { 1213, 520, 0x3a3163 }, { 1203, 520, 0x3a3163 },\
          { 1192, 520, 0x423d63 }, { 1183, 520, 0x3a3163 },\
        })\
        return { basePoint[3], posandcolor, 93, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
      -- 1-8的上边\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022, }\
        local basePoint, posandcolor = transRelativePoint({\
          { 1397, 526, 0x101c29 }, { 1412, 526, 0x192031 },\
          { 1434, 526, 0x212042 }, { 1454, 526, 0x212042 },\
          { 1469, 527, 0x6b71b5 }, { 1453, 527, 0x6b71b5 },\
          { 1438, 527, 0x636db5 }, { 1422, 527, 0x636dad },\
        })\
        return { basePoint[3], posandcolor, 93, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
      -- 1-7的上边\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022, }\
        local basePoint, posandcolor = transRelativePoint({\
          { 1234, 526, 0x211c31 }, { 1249, 526, 0x101829 },\
          { 1264, 526, 0x191c31 }, { 1281, 526, 0x101829 },\
          { 1293, 527, 0x5a619c }, { 1284, 527, 0x525d94 },\
          { 1270, 527, 0x4a598c }, { 1252, 527, 0x4a558c },\
        })\
        return { basePoint[3], posandcolor, 93, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
      -- 1-6的上边\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022, }\
        local basePoint, posandcolor = transRelativePoint({\
          { 1032, 526, 0x191829 }, { 1046, 526, 0x211831 },\
          { 1063, 526, 0x101429 }, { 1075, 526, 0x101429 },\
          { 1085, 527, 0x3a3d6b }, { 1067, 527, 0x3a396b },\
          { 1044, 527, 0x31396b }, { 1030, 527, 0x31396b },\
        })\
        return { basePoint[3], posandcolor, 93, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
    },\
    -- 地图下边界\
    bottonLineList = {\
      -- 6-1 的下面\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022 }\
        local basePoint, posandcolor = transRelativePoint({\
          { 570, 939, 0x000000 }, { 592, 939, 0x000000 },\
          { 613, 939, 0x000000 }, { 634, 939, 0x000000 },\
          { 651, 938, 0x29204a }, { 635, 938, 0x29204a },\
          { 623, 938, 0x29204a }, { 611, 938, 0x212042 },\
          { 610, 941, 0x000000 }, { 629, 941, 0x000000 },\
        })\
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
      -- 6-3 的下面\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022 }\
        local basePoint, posandcolor = transRelativePoint({\
          { 1002, 939, 0x000000 }, { 1019, 939, 0x000000 },\
          { 1034, 939, 0x000000 }, { 1048, 939, 0x000000 },\
          { 1062, 938, 0x312452 }, { 1049, 938, 0x31244a },\
          { 1033, 938, 0x31244a }, { 1019, 938, 0x31244a },\
          { 1021, 941, 0x000000 }, { 1040, 941, 0x000000 },\
        })\
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
      -- 6-5 的下面\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022 }\
        local basePoint, posandcolor = transRelativePoint({\
          { 792, 934, 0x000000 }, { 804, 934, 0x000000 },\
          { 815, 934, 0x000000 }, { 828, 934, 0x000000 },\
          { 836, 933, 0x29244a }, { 820, 933, 0x31244a },\
          { 811, 933, 0x31244a }, { 800, 933, 0x31244a },\
          { 799, 936, 0x000000 }, { 816, 936, 0x000000 },\
        })\
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
      -- 6-7 的下面\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022 }\
        local basePoint, posandcolor = transRelativePoint({\
          { 1199, 934, 0x000000 }, { 1213, 934, 0x000000 },\
          { 1228, 934, 0x000000 }, { 1240, 934, 0x000000 },\
          { 1252, 933, 0x29284a }, { 1241, 933, 0x312d52 },\
          { 1230, 933, 0x29284a }, { 1219, 933, 0x292d52 },\
          { 1218, 936, 0x000000 }, { 1236, 936, 0x000000 },\
        })\
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
    },\
    -- 地图左边界\
    leftLineList = {\
      -- 2-1 的左边\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022, }\
        local basePoint, posandcolor = transRelativePoint({\
          { 582, 734, 0x000000 }, { 583, 734, 0x312d52 },\
          { 582, 733, 0x000000 }, { 583, 733, 0x312d52 },\
          { 581, 735, 0x000000 }, { 582, 735, 0x312852 },\
          { 581, 736, 0x000000 }, { 582, 736, 0x31355a },\
        })\
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
      -- 4-1 的左边\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022, }\
        local basePoint, posandcolor = transRelativePoint({\
          { 556, 959, 0x000000 }, { 557, 959, 0x29244a },\
          { 556, 958, 0x000000 }, { 557, 958, 0x29244a },\
          { 555, 960, 0x000000 }, { 556, 960, 0x312452 },\
          { 555, 961, 0x000000 }, { 556, 961, 0x29204a },\
        })\
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
      -- 6-1 的左边\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022, }\
        local basePoint, posandcolor = transRelativePoint({\
          { 513, 907, 0x000000 }, { 514, 907, 0x212042 },\
          { 513, 906, 0x000000 }, { 514, 906, 0x29244a },\
          { 512, 908, 0x000000 }, { 513, 908, 0x212042 },\
          { 512, 909, 0x000000 }, { 513, 909, 0x29204a },\
        })\
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
    },\
    -- 地图右边界\
    rightLineList = {\
      -- 1-8 的右边\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022, }\
        local basePoint, posandcolor = transRelativePoint({\
          { 1520, 565, 0x000000 }, { 1519, 565, 0x636db5 },\
          { 1520, 564, 0x000000 }, { 1519, 564, 0x6369ad },\
          { 1521, 566, 0x000000 }, { 1520, 566, 0x636db5 },\
          { 1521, 567, 0x000000 }, { 1520, 567, 0x6369ad },\
        })\
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
      -- 2-8 的右边\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022, }\
        local basePoint, posandcolor = transRelativePoint({\
          { 1543, 692, 0x000000 }, { 1542, 692, 0x6359a4 },\
          { 1543, 691, 0x000000 }, { 1542, 691, 0x5a559c },\
          { 1544, 693, 0x000000 }, { 1543, 693, 0x5a55a4 },\
          { 1544, 694, 0x000000 }, { 1543, 694, 0x5a55a4 },\
        })\
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
      -- 5-8 的右边\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022, }\
        local basePoint, posandcolor = transRelativePoint({\
          { 1560, 660, 0x000000 }, { 1559, 660, 0x3a3563 },\
          { 1560, 659, 0x000000 }, { 1559, 659, 0x3a3563 },\
          { 1561, 661, 0x000000 }, { 1560, 661, 0x3a3163 },\
          { 1561, 662, 0x000000 }, { 1560, 662, 0x423d6b },\
        })\
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
      -- 6-8 的右边\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022, }\
        local basePoint, posandcolor = transRelativePoint({\
          { 1591, 825, 0x000000 }, { 1590, 825, 0x312d5a },\
          { 1591, 824, 0x000000 }, { 1590, 824, 0x3a3963 },\
          { 1592, 826, 0x000000 }, { 1591, 826, 0x3a2d63 },\
          { 1592, 827, 0x000000 }, { 1591, 827, 0x3a3163 },\
        })\
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
    },\
    -- 我方舰队位置\
    myFleetList = imgBase.map.myFleetList,\
    -- 我放舰队被选中的舰队的绿色的选中箭头的位置\
    selectedArrow = imgBase.map.selectedArrow,\
    -- 敌方舰队位置(小型舰队)\
    enemyList1 = imgBase.map.enemyList1,\
    -- 敌方舰队位置(中型舰队)\
    enemyList2 = imgBase.map.enemyList2,\
    -- 敌方舰队位置(大型舰队)\
    enemyList3 = imgBase.map.enemyList3,\
    -- boss位置\
    bossPointList = imgBase.map.bossPointList,\
    -- 战斗中的位置\
    inBattleList = imgBase.map.inBattleList,\
    -- 奖励箱的位置\
    rewardBoxList = imgBase.map.rewardBoxList,\
  },\
}" }


package.sourceCode = package.sourceCode or {}
package.sourceCode["./meta-operation/maps-options/img10-4.lua"] = { path = "./meta-operation/maps-options/img10-4.lua", name = "./meta-operation/maps-options/img10-4.lua", source = "-- 存储图像信息，用于界面找色、找图。取代图片搜索，因为找色搜索的像素点更少\
local imgBase = require './img'\
\
local transRelativePoint = imgBase.transRelativePoint\
\
return {\
  transRelativePoint = transRelativePoint,\
  -- 基本方法\
  toPoint = imgBase.toPoint,\
  -- 过滤被右下角按钮挡住的部分的点，因为右下角按钮也是黑色的容易与边界识别混淆\
  filterNoUsePoint = imgBase.filterNoUsePoint,\
  -- 图片数据\
  -- 地图扫描\
  map = {\
    -- 地图上边界\
    topLineList = {\
      -- 1-1的上边\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022, }\
        local basePoint, posandcolor = transRelativePoint({\
          { 466, 525, 0x081c19 }, { 478, 525, 0x000c10 },\
          { 489, 525, 0x080c19 }, { 498, 525, 0x000c10 },\
          { 515, 526, 0x312d63 }, { 504, 526, 0x3a3963 },\
          { 496, 526, 0x3a3963 }, { 488, 526, 0x3a3963 },\
        })\
        return { basePoint[3], posandcolor, 93, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
      -- 1-9的上边\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022, }\
        local basePoint, posandcolor = transRelativePoint({\
          { 1484, 519, 0x081019 }, { 1494, 519, 0x081419 },\
          { 1512, 519, 0x081419 }, { 1527, 519, 0x101421 },\
          { 1546, 520, 0x6b75b5 }, { 1531, 520, 0x6b71ad },\
          { 1519, 520, 0x6b71ad }, { 1506, 520, 0x6b75b5 },\
        })\
        return { basePoint[3], posandcolor, 93, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
      -- 1-8的上边\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022, }\
        local basePoint, posandcolor = transRelativePoint({\
          { 1289, 519, 0x081421 }, { 1298, 519, 0x081019 },\
          { 1307, 519, 0x101421 }, { 1315, 519, 0x101421 },\
          { 1328, 520, 0x5a65a4 }, { 1318, 520, 0x5a65a4 },\
          { 1312, 520, 0x5a61a4 }, { 1304, 520, 0x5a61a4 },\
        })\
        return { basePoint[3], posandcolor, 93, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
      -- 1-7的上边\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022, }\
        local basePoint, posandcolor = transRelativePoint({\
          { 1072, 519, 0x000c10 }, { 1082, 519, 0x000c10 },\
          { 1091, 519, 0x101019 }, { 1098, 519, 0x000c10 },\
          { 1107, 520, 0x3a4173 }, { 1100, 520, 0x424573 },\
          { 1091, 520, 0x3a416b }, { 1082, 520, 0x3a416b },\
        })\
        return { basePoint[3], posandcolor, 93, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
      -- 1-3的上边\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022, }\
        local basePoint, posandcolor = transRelativePoint({\
          { 785, 525, 0x293142 }, { 795, 525, 0x21283a },\
          { 803, 525, 0x192431 }, { 808, 525, 0x192029 },\
          { 823, 526, 0x3a3163 }, { 815, 526, 0x3a3163 },\
          { 807, 526, 0x3a3163 }, { 798, 526, 0x423963 },\
        })\
        return { basePoint[3], posandcolor, 93, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
      -- 1-5的上边\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022, }\
        local basePoint, posandcolor = transRelativePoint({\
          { 1140, 525, 0x081019 }, { 1149, 525, 0x101419 },\
          { 1156, 525, 0x081019 }, { 1166, 525, 0x001019 },\
          { 1177, 526, 0x3a396b }, { 1169, 526, 0x3a396b },\
          { 1163, 526, 0x3a396b }, { 1152, 526, 0x3a416b },\
        })\
        return { basePoint[3], posandcolor, 93, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
    },\
    -- 地图下边界\
    bottonLineList = {\
      -- 6-1 的下面\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022 }\
        local basePoint, posandcolor = transRelativePoint({\
          { 359, 966, 0x000000 }, { 370, 966, 0x000000 },\
          { 384, 966, 0x000000 }, { 397, 966, 0x000000 },\
          { 407, 968, 0x000000 }, { 398, 968, 0x000000 },\
          { 391, 968, 0x000000 }, { 396, 965, 0x212042 },\
          { 386, 965, 0x212042 }, { 380, 965, 0x212042 },\
        })\
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
      -- 6-6 的下面\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022 }\
        local basePoint, posandcolor = transRelativePoint({\
          { 916, 940, 0x000000 }, { 927, 940, 0x000000 },\
          { 938, 940, 0x000000 }, { 947, 940, 0x000000 },\
          { 962, 939, 0x29284a }, { 954, 939, 0x29284a },\
          { 946, 939, 0x29244a }, { 940, 939, 0x29244a },\
          { 940, 942, 0x000000 }, { 931, 942, 0x000000 },\
        })\
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
      -- 6-4 的下面\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022 }\
        local basePoint, posandcolor = transRelativePoint({\
          { 472, 940, 0x000000 }, { 481, 940, 0x000000 },\
          { 492, 940, 0x000000 }, { 502, 940, 0x000000 },\
          { 510, 939, 0x29204a }, { 502, 939, 0x29204a },\
          { 495, 939, 0x31204a }, { 488, 939, 0x292442 },\
          { 488, 942, 0x000000 }, { 495, 943, 0x000000 },\
        })\
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
    },\
    -- 地图左边界\
    leftLineList = {\
      -- 1-1 的左边\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022, }\
        local basePoint, posandcolor = transRelativePoint({\
          { 422, 557, 0x000000 }, { 423, 557, 0x312d5a },\
          { 422, 556, 0x000000 }, { 423, 556, 0x31285a },\
          { 421, 558, 0x000000 }, { 422, 558, 0x31315a },\
          { 421, 559, 0x000000 }, { 422, 559, 0x31285a },\
        })\
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
      -- 2-1 的左边\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022, }\
        local basePoint, posandcolor = transRelativePoint({\
          { 397, 700, 0x000000 }, { 398, 700, 0x313552 },\
          { 397, 699, 0x000000 }, { 398, 699, 0x292852 },\
          { 396, 701, 0x000000 }, { 397, 701, 0x312d52 },\
          { 396, 702, 0x000000 }, { 397, 702, 0x312852 },\
        })\
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
      -- 6-1 的左边\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022, }\
        local basePoint, posandcolor = transRelativePoint({\
          { 330, 849, 0x000000 }, { 331, 849, 0x29204a },\
          { 330, 848, 0x000400 }, { 331, 848, 0x29204a },\
          { 329, 850, 0x000000 }, { 330, 850, 0x29204a },\
          { 329, 851, 0x000000 }, { 330, 851, 0x29204a },\
        })\
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
    },\
    -- 地图右边界\
    rightLineList = {\
      -- 1-9 的右边\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022, }\
        local basePoint, posandcolor = transRelativePoint({\
          { 1554, 525, 0x000000 }, { 1553, 525, 0x6b71ad },\
          { 1554, 524, 0x000000 }, { 1553, 524, 0x6b71ad },\
          { 1555, 526, 0x000000 }, { 1554, 526, 0x6b71b5 },\
          { 1555, 527, 0x000000 }, { 1554, 527, 0x636dad },\
        })\
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
      -- 2-9 的右边\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022, }\
        local basePoint, posandcolor = transRelativePoint({\
          { 1588, 699, 0x000000 }, { 1587, 699, 0x6355a4 },\
          { 1588, 698, 0x000000 }, { 1587, 698, 0x5a55a4 },\
          { 1589, 700, 0x000000 }, { 1588, 700, 0x6359a4 },\
          { 1589, 701, 0x000000 }, { 1588, 701, 0x5a559c },\
        })\
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
      -- 6-9 的右边\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022, }\
        local basePoint, posandcolor = transRelativePoint({\
          { 1727, 800, 0x000000 }, { 1726, 800, 0x3a3963 },\
          { 1727, 799, 0x000000 }, { 1726, 799, 0x3a315a },\
          { 1728, 801, 0x000000 }, { 1727, 801, 0x3a315a },\
          { 1728, 802, 0x000000 }, { 1727, 802, 0x3a315a },\
        })\
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
      -- 5-9 的右边\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022, }\
        local basePoint, posandcolor = transRelativePoint({\
          { 1696, 666, 0x000000 }, { 1695, 666, 0x3a3563 },\
          { 1696, 665, 0x000000 }, { 1695, 665, 0x3a3563 },\
          { 1697, 667, 0x000000 }, { 1696, 667, 0x3a3163 },\
          { 1697, 668, 0x000000 }, { 1696, 668, 0x423d6b },\
        })\
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
      -- 5-8 的右边\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022, }\
        local basePoint, posandcolor = transRelativePoint({\
          { 1664, 663, 0x000000 }, { 1663, 663, 0x3a3563 },\
          { 1664, 662, 0x000000 }, { 1663, 662, 0x3a3563 },\
          { 1665, 664, 0x000000 }, { 1664, 664, 0x423d6b },\
          { 1665, 665, 0x000000 }, { 1664, 665, 0x3a3563 },\
        })\
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
    },\
    -- 我方舰队位置\
    myFleetList = imgBase.map.myFleetList,\
    -- 我放舰队被选中的舰队的绿色的选中箭头的位置\
    selectedArrow = imgBase.map.selectedArrow,\
    -- 敌方舰队位置(小型舰队)\
    enemyList1 = imgBase.map.enemyList1,\
    -- 敌方舰队位置(中型舰队)\
    enemyList2 = imgBase.map.enemyList2,\
    -- 敌方舰队位置(大型舰队)\
    enemyList3 = imgBase.map.enemyList3,\
    -- boss位置\
    bossPointList = imgBase.map.bossPointList,\
    -- 战斗中的位置\
    inBattleList = imgBase.map.inBattleList,\
    -- 奖励箱的位置\
    rewardBoxList = imgBase.map.rewardBoxList,\
  },\
}" }


package.sourceCode = package.sourceCode or {}
package.sourceCode["./meta-operation/maps-options/img9-4.lua"] = { path = "./meta-operation/maps-options/img9-4.lua", name = "./meta-operation/maps-options/img9-4.lua", source = "-- 存储图像信息，用于界面找色、找图。取代图片搜索，因为找色搜索的像素点更少\
local imgBase = require './img'\
\
local transRelativePoint = imgBase.transRelativePoint\
\
return {\
  transRelativePoint = transRelativePoint,\
  -- 基本方法\
  toPoint = imgBase.toPoint,\
  -- 过滤被右下角按钮挡住的部分的点，因为右下角按钮也是黑色的容易与边界识别混淆\
  filterNoUsePoint = imgBase.filterNoUsePoint,\
  -- 图片数据\
  -- 地图扫描\
  map = {\
    -- 地图上边界\
    topLineList = {\
      -- 1-1的上边\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022, }\
        local basePoint, posandcolor = transRelativePoint({\
          { 409, 519, 0x081019 }, { 421, 519, 0x081019 },\
          { 434, 519, 0x000c10 }, { 447, 519, 0x100c19 },\
          { 458, 520, 0x3a3963 }, { 444, 520, 0x423963 },\
          { 433, 520, 0x3a2d63 }, { 424, 520, 0x423963 },\
        })\
        return { basePoint[3], posandcolor, 93, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
      -- 1-9的上边\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022, }\
        local basePoint, posandcolor = transRelativePoint({\
          { 1466, 530, 0x211831 }, { 1477, 530, 0x081421 },\
          { 1485, 530, 0x081421 }, { 1493, 530, 0x081421 },\
          { 1503, 531, 0x636db5 }, { 1495, 531, 0x636db5 },\
          { 1486, 531, 0x636dad }, { 1476, 531, 0x636dad },\
        })\
        return { basePoint[3], posandcolor, 93, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
      -- 1-5的上边\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022, }\
        local basePoint, posandcolor = transRelativePoint({\
          { 787, 530, 0x101019 }, { 798, 530, 0x101421 },\
          { 807, 530, 0x081019 }, { 813, 530, 0x081019 },\
          { 824, 531, 0x31396b }, { 814, 531, 0x3a3963 },\
          { 805, 531, 0x3a396b }, { 796, 531, 0x313963 },\
        })\
        return { basePoint[3], posandcolor, 93, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
      -- 1-3的上边\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022, }\
        local basePoint, posandcolor = transRelativePoint({\
          { 747, 519, 0x101419 }, { 757, 519, 0x081419 },\
          { 766, 519, 0x081019 }, { 773, 519, 0x081419 },\
          { 784, 520, 0x423963 }, { 776, 520, 0x423963 },\
          { 770, 520, 0x3a3963 }, { 762, 520, 0x3a3963 },\
        })\
        return { basePoint[3], posandcolor, 93, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
      -- 1-2的上边\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022, }\
        local basePoint, posandcolor = transRelativePoint({\
          { 338, 530, 0x212031 }, { 350, 530, 0x211c29 },\
          { 359, 530, 0x101821 }, { 368, 530, 0x191c21 },\
          { 379, 531, 0x3a3163 }, { 371, 531, 0x3a3163 },\
          { 364, 531, 0x312d5a }, { 356, 531, 0x312d5a },\
        })\
        return { basePoint[3], posandcolor, 93, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
      -- 1-8的上边\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022, }\
        local basePoint, posandcolor = transRelativePoint({\
          { 1283, 530, 0x101421 }, { 1292, 530, 0x191829 },\
          { 1302, 530, 0x211831 }, { 1311, 530, 0x101429 },\
          { 1320, 531, 0x4a598c }, { 1313, 531, 0x525994 },\
          { 1305, 531, 0x4a598c }, { 1296, 531, 0x4a5184 },\
        })\
        return { basePoint[3], posandcolor, 93, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
      -- 1-4的上边\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022, }\
        local basePoint, posandcolor = transRelativePoint({\
          { 602, 530, 0x101421 }, { 621, 530, 0x081019 },\
          { 641, 530, 0x081019 }, { 662, 530, 0x101421 },\
          { 677, 531, 0x3a3163 }, { 661, 531, 0x3a3163 },\
          { 644, 531, 0x312d5a }, { 621, 531, 0x3a3163 },\
        })\
        return { basePoint[3], posandcolor, 93, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
    },\
    -- 地图下边界\
    bottonLineList = {\
      -- 6-1 的下面\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022 }\
        local basePoint, posandcolor = transRelativePoint({\
          { 274, 921, 0x000000 }, { 282, 921, 0x000000 },\
          { 292, 921, 0x000000 }, { 299, 921, 0x000000 },\
          { 310, 920, 0x29204a }, { 305, 920, 0x212042 },\
          { 298, 920, 0x29204a }, { 289, 920, 0x29204a },\
        })\
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
      -- 6-4 的下面\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022 }\
        local basePoint, posandcolor = transRelativePoint({\
          { 948, 921, 0x000000 }, { 957, 921, 0x000000 },\
          { 967, 921, 0x000000 }, { 977, 921, 0x000000 },\
          { 987, 920, 0x29204a }, { 980, 920, 0x29244a },\
          { 973, 920, 0x29204a }, { 966, 920, 0x31204a },\
        })\
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
      -- 6-7 的下面\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022 }\
        local basePoint, posandcolor = transRelativePoint({\
          { 1111, 933, 0x000000 }, { 1122, 933, 0x000000 },\
          { 1129, 933, 0x000000 }, { 1137, 933, 0x000000 },\
          { 1146, 932, 0x312852 }, { 1138, 932, 0x312852 },\
          { 1131, 932, 0x29284a }, { 1122, 932, 0x312852 },\
        })\
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
      -- 6-5 的下面\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022 }\
        local basePoint, posandcolor = transRelativePoint({\
          { 645, 933, 0x000000 }, { 654, 933, 0x000000 },\
          { 663, 933, 0x000000 }, { 671, 933, 0x000000 },\
          { 681, 932, 0x31244a }, { 675, 932, 0x292442 },\
          { 667, 932, 0x292442 }, { 659, 932, 0x29244a },\
        })\
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
    },\
    -- 地图左边界\
    leftLineList = {\
      -- 1-1 的左边\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022, }\
        local basePoint, posandcolor = transRelativePoint({\
          { 378, 555, 0x000000 }, { 379, 555, 0x31285a },\
          { 378, 554, 0x000000 }, { 379, 554, 0x31285a },\
          { 377, 556, 0x000000 }, { 378, 556, 0x31355a },\
          { 377, 557, 0x000000 }, { 378, 557, 0x31285a },\
        })\
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
      -- 2-1 的左边\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022, }\
        local basePoint, posandcolor = transRelativePoint({\
          { 354, 682, 0x000000 }, { 355, 682, 0x312852 },\
          { 354, 681, 0x000000 }, { 355, 681, 0x312852 },\
          { 353, 683, 0x000000 }, { 354, 683, 0x292852 },\
          { 353, 684, 0x000000 }, { 354, 684, 0x31285a },\
        })\
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
      -- 6-1 的左边\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022, }\
        local basePoint, posandcolor = transRelativePoint({\
          { 259, 809, 0x000000 }, { 260, 809, 0x29204a },\
          { 259, 808, 0x000000 }, { 260, 808, 0x29244a },\
          { 258, 810, 0x000000 }, { 259, 810, 0x29204a },\
          { 258, 811, 0x000000 }, { 259, 811, 0x29204a },\
        })\
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
    },\
    -- 地图右边界\
    rightLineList = {\
      -- 1-8 的右边\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022, }\
        local basePoint, posandcolor = transRelativePoint({\
          { 1597, 567, 0x000000 }, { 1596, 567, 0x5a69ad },\
          { 1597, 566, 0x000000 }, { 1596, 566, 0x636db5 },\
          { 1598, 568, 0x000000 }, { 1597, 568, 0x6369b5 },\
          { 1598, 569, 0x000000 }, { 1597, 569, 0x636db5 },\
        })\
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
      -- 1-8 的右边\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022, }\
        local basePoint, posandcolor = transRelativePoint({\
          { 1611, 635, 0x000000 }, { 1610, 635, 0x5a59a4 },\
          { 1611, 634, 0x000000 }, { 1610, 634, 0x635dad },\
          { 1612, 636, 0x000000 }, { 1611, 636, 0x5a5d9c },\
          { 1612, 637, 0x000000 }, { 1611, 637, 0x5a5da4 },\
        })\
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
      -- 2-8 的右边\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022, }\
        local basePoint, posandcolor = transRelativePoint({\
          { 1716, 520, 0x000000 }, { 1715, 520, 0x5a559c },\
          { 1716, 519, 0x000000 }, { 1715, 519, 0x6355a4 },\
          { 1717, 521, 0x000000 }, { 1716, 521, 0x5a559c },\
          { 1717, 522, 0x000000 }, { 1716, 522, 0x6359a4 },\
        })\
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
      -- 3-8 的右边\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022, }\
        local basePoint, posandcolor = transRelativePoint({\
          { 1631, 707, 0x000000 }, { 1630, 707, 0x5a559c },\
          { 1631, 706, 0x000000 }, { 1630, 706, 0x6355a4 },\
          { 1632, 708, 0x000008 }, { 1631, 708, 0x5a559c },\
          { 1632, 709, 0x000000 }, { 1631, 709, 0x5a55a4 },\
        })\
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
      -- 6-8 的右边\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022, }\
        local basePoint, posandcolor = transRelativePoint({\
          { 1696, 807, 0x000000 }, { 1695, 807, 0x3a3163 },\
          { 1696, 806, 0x000000 }, { 1695, 806, 0x3a2d63 },\
          { 1697, 808, 0x000000 }, { 1696, 808, 0x423963 },\
          { 1697, 809, 0x000000 }, { 1696, 809, 0x312d5a },\
        })\
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
      -- 5-8 的右边\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022, }\
        local basePoint, posandcolor = transRelativePoint({\
          { 1664, 663, 0x000000 }, { 1663, 663, 0x3a3563 },\
          { 1664, 662, 0x000000 }, { 1663, 662, 0x3a3563 },\
          { 1665, 664, 0x000000 }, { 1664, 664, 0x423d6b },\
          { 1665, 665, 0x000000 }, { 1664, 665, 0x3a3563 },\
        })\
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
      -- 4-8 的右边\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022, }\
        local basePoint, posandcolor = transRelativePoint({\
          { 1631, 513, 0x000000 }, { 1630, 513, 0x423d73 },\
          { 1631, 512, 0x000000 }, { 1630, 512, 0x42417b },\
          { 1632, 514, 0x000000 }, { 1631, 514, 0x42417b },\
          { 1632, 515, 0x000000 }, { 1631, 515, 0x42417b },\
        })\
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
    },\
    -- 我方舰队位置\
    myFleetList = imgBase.map.myFleetList,\
    -- 我放舰队被选中的舰队的绿色的选中箭头的位置\
    selectedArrow = imgBase.map.selectedArrow,\
    -- 敌方舰队位置(小型舰队)\
    enemyList1 = imgBase.map.enemyList1,\
    -- 敌方舰队位置(中型舰队)\
    enemyList2 = imgBase.map.enemyList2,\
    -- 敌方舰队位置(大型舰队)\
    enemyList3 = imgBase.map.enemyList3,\
    -- boss位置\
    bossPointList = imgBase.map.bossPointList,\
    -- 战斗中的位置\
    inBattleList = imgBase.map.inBattleList,\
    -- 奖励箱的位置\
    rewardBoxList = imgBase.map.rewardBoxList,\
  },\
}" }


package.sourceCode = package.sourceCode or {}
package.sourceCode["./meta-operation/maps-options/img9-3.lua"] = { path = "./meta-operation/maps-options/img9-3.lua", name = "./meta-operation/maps-options/img9-3.lua", source = "-- 存储图像信息，用于界面找色、找图。取代图片搜索，因为找色搜索的像素点更少\
local imgBase = require './img'\
\
local transRelativePoint = imgBase.transRelativePoint\
\
return {\
  transRelativePoint = transRelativePoint,\
  -- 基本方法\
  toPoint = imgBase.toPoint,\
  -- 过滤被右下角按钮挡住的部分的点，因为右下角按钮也是黑色的容易与边界识别混淆\
  filterNoUsePoint = imgBase.filterNoUsePoint,\
  -- 图片数据\
  -- 地图扫描\
  map = {\
    -- 地图上边界\
    topLineList = {\
      -- 1-8的上边\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022, }\
        local basePoint, posandcolor = transRelativePoint({\
          { 1534, 505, 0x10283a }, { 1547, 505, 0x192d42 },\
          { 1558, 505, 0x10283a }, { 1573, 505, 0x192d42 },\
          { 1586, 506, 0x6b71b5 }, { 1572, 506, 0x636db5 },\
          { 1562, 506, 0x636db5 }, { 1548, 506, 0x6371b5 },\
        })\
        return { basePoint[3], posandcolor, 93, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
      -- 1-7的上边\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022, }\
        local basePoint, posandcolor = transRelativePoint({\
          { 1447, 505, 0x102842 }, { 1460, 505, 0x10243a },\
          { 1472, 505, 0x10243a }, { 1483, 505, 0x102842 },\
          { 1494, 506, 0x636dad }, { 1482, 506, 0x6369a4 },\
          { 1471, 506, 0x5a65a4 }, { 1457, 506, 0x5a619c },\
        })\
        return { basePoint[3], posandcolor, 93, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
      -- 1-4的上边\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022, }\
        local basePoint, posandcolor = transRelativePoint({\
          { 860, 505, 0x102031 }, { 874, 505, 0x102031 },\
          { 889, 505, 0x192442 }, { 901, 505, 0x192442 },\
          { 913, 506, 0x3a3163 }, { 903, 506, 0x3a3163 },\
          { 891, 506, 0x3a3163 }, { 880, 506, 0x3a3d63 },\
        })\
        return { basePoint[3], posandcolor, 93, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
    },\
    -- 地图下边界\
    bottonLineList = {\
      -- 6-3 的下面\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022 }\
        local basePoint, posandcolor = transRelativePoint({\
          { 476, 879, 0x000000 }, { 492, 879, 0x000000 },\
          { 511, 879, 0x000000 }, { 532, 879, 0x000000 },\
          { 553, 878, 0x29204a }, { 532, 878, 0x312452 },\
          { 517, 878, 0x31244a }, { 504, 878, 0x312452 },\
          { 503, 882, 0x000000 }, { 529, 882, 0x000000 },\
        })\
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
    },\
    -- 地图左边界\
    leftLineList = {\
      -- 1-1 的左边\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022, }\
        local basePoint, posandcolor = transRelativePoint({\
          { 321, 395, 0x000000 }, { 322, 395, 0x31285a },\
          { 321, 394, 0x000000 }, { 322, 394, 0x31355a },\
          { 320, 396, 0x000000 }, { 321, 396, 0x31285a },\
          { 320, 397, 0x000000 }, { 321, 397, 0x312d5a },\
        })\
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
    },\
    -- 地图右边界\
    rightLineList = {\
      -- 1-8 的右边\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022, }\
        local basePoint, posandcolor = transRelativePoint({\
          { 1686, 399, 0x000000 }, { 1685, 399, 0x636db5 },\
          { 1686, 398, 0x000000 }, { 1685, 398, 0x636dad },\
          { 1687, 400, 0x000000 }, { 1686, 400, 0x636db5 },\
          { 1687, 401, 0x000000 }, { 1686, 401, 0x5a6dad },\
        })\
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
      -- 2-8 的右边\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022, }\
        local basePoint, posandcolor = transRelativePoint({\
          { 1716, 520, 0x000000 }, { 1715, 520, 0x5a559c },\
          { 1716, 519, 0x000000 }, { 1715, 519, 0x6355a4 },\
          { 1717, 521, 0x000000 }, { 1716, 521, 0x5a559c },\
          { 1717, 522, 0x000000 }, { 1716, 522, 0x6359a4 },\
        })\
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
      -- 3-8 的右边\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022, }\
        local basePoint, posandcolor = transRelativePoint({\
          { 1752, 665, 0x000000 }, { 1751, 665, 0x4a457b },\
          { 1752, 664, 0x000000 }, { 1751, 664, 0x4a417b },\
          { 1753, 666, 0x000000 }, { 1752, 666, 0x4a4584 },\
          { 1753, 667, 0x000000 }, { 1752, 667, 0x42417b },\
        })\
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
      -- 6-8 的右边\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022, }\
        local basePoint, posandcolor = transRelativePoint({\
          { 1741, 789, 0x000000 }, { 1740, 789, 0x312d5a },\
          { 1741, 788, 0x000000 }, { 1740, 788, 0x423963 },\
          { 1742, 790, 0x000000 }, { 1741, 790, 0x312d5a },\
          { 1742, 791, 0x000000 }, { 1741, 791, 0x3a3163 },\
        })\
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
      -- 5-8 的右边\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022, }\
        local basePoint, posandcolor = transRelativePoint({\
          { 1702, 623, 0x000000 }, { 1701, 623, 0x3a3563 },\
          { 1702, 622, 0x000000 }, { 1701, 622, 0x3a3563 },\
          { 1703, 624, 0x000000 }, { 1702, 624, 0x423d63 },\
          { 1703, 625, 0x000000 }, { 1702, 625, 0x3a3163 },\
        })\
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
    },\
    -- 我方舰队位置\
    myFleetList = imgBase.map.myFleetList,\
    -- 我放舰队被选中的舰队的绿色的选中箭头的位置\
    selectedArrow = imgBase.map.selectedArrow,\
    -- 敌方舰队位置(小型舰队)\
    enemyList1 = imgBase.map.enemyList1,\
    -- 敌方舰队位置(中型舰队)\
    enemyList2 = imgBase.map.enemyList2,\
    -- 敌方舰队位置(大型舰队)\
    enemyList3 = imgBase.map.enemyList3,\
    -- boss位置\
    bossPointList = imgBase.map.bossPointList,\
    -- 战斗中的位置\
    inBattleList = imgBase.map.inBattleList,\
    -- 奖励箱的位置\
    rewardBoxList = imgBase.map.rewardBoxList,\
  },\
}" }


package.sourceCode = package.sourceCode or {}
package.sourceCode["./meta-operation/maps-options/img9-2.lua"] = { path = "./meta-operation/maps-options/img9-2.lua", name = "./meta-operation/maps-options/img9-2.lua", source = "-- 存储图像信息，用于界面找色、找图。取代图片搜索，因为找色搜索的像素点更少\
local imgBase = require './img'\
\
local transRelativePoint = imgBase.transRelativePoint\
\
return {\
  transRelativePoint = transRelativePoint,\
  -- 基本方法\
  toPoint = imgBase.toPoint,\
  -- 过滤被右下角按钮挡住的部分的点，因为右下角按钮也是黑色的容易与边界识别混淆\
  filterNoUsePoint = imgBase.filterNoUsePoint,\
  -- 图片数据\
  -- 地图扫描\
  map = {\
    -- 地图上边界\
    topLineList = {\
      -- 1-8的上边\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022, }\
        local basePoint, posandcolor = transRelativePoint({\
          { 1702, 495, 0x081019 }, { 1713, 495, 0x081419 },\
          { 1724, 495, 0x081019 }, { 1733, 495, 0x081419 },\
          { 1740, 496, 0x6b71b5 }, { 1728, 496, 0x6b71b5 },\
          { 1718, 496, 0x636db5 }, { 1705, 496, 0x636dad },\
        })\
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
      -- 1-4的上边\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022, }\
        local basePoint, posandcolor = transRelativePoint({\
          { 846, 495, 0x081419 }, { 854, 495, 0x081419 },\
          { 862, 495, 0x081419 }, { 870, 495, 0x081419 },\
          { 879, 496, 0x312d5a }, { 867, 496, 0x31315a },\
          { 858, 496, 0x3a3563 }, { 848, 496, 0x423563 },\
        })\
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
      -- 1-1的上边\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022, }\
        local basePoint, posandcolor = transRelativePoint({\
          { 332, 495, 0x000c10 }, { 342, 495, 0x000c10 },\
          { 351, 495, 0x101019 }, { 362, 495, 0x000c11 },\
          { 372, 496, 0x423563 }, { 361, 496, 0x3a2d5a },\
          { 352, 496, 0x423563 }, { 343, 496, 0x312d5a },\
        })\
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
    },\
    -- 地图下边界\
    bottonLineList = {\
      -- 5-1 的下面\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022 }\
        local basePoint, posandcolor = transRelativePoint({\
          { 425, 902, 0x000000 }, { 436, 902, 0x000000 },\
          { 444, 902, 0x000000 }, { 449, 902, 0x000000 },\
          { 457, 901, 0x29204a }, { 443, 901, 0x212042 },\
          { 430, 901, 0x212042 }, { 423, 901, 0x29204a },\
        })\
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
      -- 5-4 的下面\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022 }\
        local basePoint, posandcolor = transRelativePoint({\
          { 1037, 902, 0x000000 }, { 1047, 902, 0x000000 },\
          { 1053, 902, 0x000000 }, { 1064, 902, 0x000000 },\
          { 1076, 901, 0x29204a }, { 1064, 901, 0x29204a },\
          { 1058, 901, 0x292042 }, { 1048, 901, 0x292042 },\
        })\
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
      -- 5-9 的下面\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022 }\
        local basePoint, posandcolor = transRelativePoint({\
          { 1453, 902, 0x000000 }, { 1464, 902, 0x000000 },\
          { 1470, 902, 0x000000 }, { 1479, 902, 0x000000 },\
          { 1491, 901, 0x312d52 }, { 1482, 901, 0x292d4a },\
          { 1474, 901, 0x292d4a }, { 1467, 901, 0x312c52 },\
        })\
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
    },\
    -- 地图左边界\
    leftLineList = {\
      -- 5-1 的左边\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022, }\
        local basePoint, posandcolor = transRelativePoint({\
          { 379, 813, 0x000000 }, { 380, 813, 0x29204a },\
          { 379, 812, 0x000000 }, { 380, 812, 0x29204a },\
          { 378, 814, 0x000000 }, { 379, 814, 0x29204a },\
          { 378, 815, 0x000000 }, { 379, 815, 0x29204a },\
        })\
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
      -- 1-1 的左边\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022, }\
        local basePoint, posandcolor = transRelativePoint({\
          { 295, 530, 0x000000 }, { 296, 530, 0x31315a },\
          { 295, 529, 0x000000 }, { 296, 529, 0x31285a },\
          { 294, 531, 0x000000 }, { 295, 531, 0x312d5a },\
          { 294, 532, 0x000000 }, { 295, 532, 0x31285a },\
        })\
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
    },\
    -- 地图右边界\
    rightLineList = {\
      -- 5-9 的右边\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022, }\
        local basePoint, posandcolor = transRelativePoint({\
          { 1597, 807, 0x000000 }, { 1596, 807, 0x312d5a },\
          { 1597, 806, 0x000000 }, { 1596, 806, 0x3a3563 },\
          { 1598, 808, 0x000000 }, { 1597, 808, 0x3a2d63 },\
          { 1598, 809, 0x000000 }, { 1597, 809, 0x3a3163 },\
        })\
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
      -- 3-9 的右边\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022, }\
        local basePoint, posandcolor = transRelativePoint({\
          { 1902, 761, 0x000000 }, { 1901, 761, 0x4a417b },\
          { 1902, 760, 0x000000 }, { 1901, 760, 0x4a417b },\
          { 1903, 762, 0x000000 }, { 1902, 762, 0x4a4184 },\
          { 1903, 763, 0x000000 }, { 1902, 763, 0x4a3d7b },\
        })\
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
      -- 1-9 的右边\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022, }\
        local basePoint, posandcolor = transRelativePoint({\
          { 1836, 531, 0x000000 }, { 1835, 531, 0x6369b5 },\
          { 1836, 530, 0x000000 }, { 1835, 530, 0x6369b5 },\
          { 1837, 532, 0x000000 }, { 1836, 532, 0x6b69b5 },\
          { 1837, 533, 0x000000 }, { 1836, 533, 0x6365ad },\
        })\
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
    },\
    -- 我方舰队位置\
    myFleetList = imgBase.map.myFleetList,\
    -- 我放舰队被选中的舰队的绿色的选中箭头的位置\
    selectedArrow = imgBase.map.selectedArrow,\
    -- 敌方舰队位置(小型舰队)\
    enemyList1 = imgBase.map.enemyList1,\
    -- 敌方舰队位置(中型舰队)\
    enemyList2 = imgBase.map.enemyList2,\
    -- 敌方舰队位置(大型舰队)\
    enemyList3 = imgBase.map.enemyList3,\
    -- boss位置\
    bossPointList = imgBase.map.bossPointList,\
    -- 战斗中的位置\
    inBattleList = imgBase.map.inBattleList,\
    -- 奖励箱的位置\
    rewardBoxList = imgBase.map.rewardBoxList,\
  },\
}" }


package.sourceCode = package.sourceCode or {}
package.sourceCode["./meta-operation/maps-options/img9-1.lua"] = { path = "./meta-operation/maps-options/img9-1.lua", name = "./meta-operation/maps-options/img9-1.lua", source = "-- 存储图像信息，用于界面找色、找图。取代图片搜索，因为找色搜索的像素点更少\
local imgBase = require './img'\
\
local transRelativePoint = imgBase.transRelativePoint\
\
return {\
  transRelativePoint = transRelativePoint,\
  -- 基本方法\
  toPoint = imgBase.toPoint,\
  -- 过滤被右下角按钮挡住的部分的点，因为右下角按钮也是黑色的容易与边界识别混淆\
  filterNoUsePoint = imgBase.filterNoUsePoint,\
  -- 图片数据\
  -- 地图扫描\
  map = {\
    -- 地图上边界\
    topLineList = {\
      -- 1-8的上边\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022, }\
        local basePoint, posandcolor = transRelativePoint({\
          { 1534, 505, 0x10283a }, { 1547, 505, 0x192d42 },\
          { 1558, 505, 0x10283a }, { 1573, 505, 0x192d42 },\
          { 1586, 506, 0x6b71b5 }, { 1572, 506, 0x636db5 },\
          { 1562, 506, 0x636db5 }, { 1548, 506, 0x6371b5 },\
        })\
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
      -- 1-7的上边\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022, }\
        local basePoint, posandcolor = transRelativePoint({\
          { 1473, 551, 0x101c31 }, { 1484, 551, 0x081c29 },\
          { 1493, 551, 0x102031 }, { 1505, 551, 0x102031 },\
          { 1516, 552, 0x636dad }, { 1504, 552, 0x6369a4 },\
          { 1490, 552, 0x5a65a4 }, { 1479, 552, 0x5a619c },\
        })\
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
      -- 1-5的上边\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022, }\
        local basePoint, posandcolor = transRelativePoint({\
          { 1061, 551, 0x081821 }, { 1075, 551, 0x101821 },\
          { 1088, 551, 0x081419 }, { 1100, 551, 0x081419 },\
          { 1116, 552, 0x424173 }, { 1106, 552, 0x42417b },\
          { 1089, 552, 0x42457b }, { 1076, 552, 0x42457b },\
        })\
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
      -- 1-3的上边\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022, }\
        local basePoint, posandcolor = transRelativePoint({\
          { 684, 551, 0x102431 }, { 702, 551, 0x192831 },\
          { 718, 551, 0x102431 }, { 728, 551, 0x102831 },\
          { 739, 552, 0x3a3163 }, { 730, 552, 0x3a3963 },\
          { 717, 552, 0x3a3163 }, { 699, 552, 0x3a3163 },\
        })\
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
      -- 1-2的上边\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022, }\
        local basePoint, posandcolor = transRelativePoint({\
          { 550, 551, 0x213131 }, { 562, 551, 0x193131 },\
          { 574, 551, 0x193131 }, { 586, 551, 0x192831 },\
          { 598, 552, 0x3a3963 }, { 587, 552, 0x3a3163 },\
          { 573, 552, 0x3a3163 }, { 562, 552, 0x3a3963 },\
        })\
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
    },\
    -- 地图下边界\
    bottonLineList = {\
      -- 6-3 的下面\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022 }\
        local basePoint, posandcolor = transRelativePoint({\
          { 476, 879, 0x000000 }, { 492, 879, 0x000000 },\
          { 511, 879, 0x000000 }, { 532, 879, 0x000000 },\
          { 553, 878, 0x29204a }, { 532, 878, 0x312452 },\
          { 517, 878, 0x31244a }, { 504, 878, 0x312452 },\
          { 503, 882, 0x000000 }, { 529, 882, 0x000000 },\
        })\
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
    },\
    -- 地图左边界\
    leftLineList = {\
      -- 1-1 的左边\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022, }\
        local basePoint, posandcolor = transRelativePoint({\
          { 320, 582, 0x000400 }, { 321, 582, 0x31285a },\
          { 320, 581, 0x000000 }, { 321, 581, 0x31285a },\
          { 319, 583, 0x000000 }, { 320, 583, 0x31285a },\
          { 319, 584, 0x000000 }, { 320, 584, 0x31355a },\
        })\
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
      -- 1-3 的左边\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022, }\
        local basePoint, posandcolor = transRelativePoint({\
          { 258, 855, 0x000000 }, { 259, 855, 0x312852 },\
          { 258, 854, 0x000000 }, { 259, 854, 0x312852 },\
          { 257, 856, 0x000000 }, { 258, 856, 0x312852 },\
          { 257, 857, 0x000000 }, { 258, 857, 0x29244a },\
        })\
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
    },\
    -- 地图右边界\
    rightLineList = {\
      -- 1-8 的右边\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022, }\
        local basePoint, posandcolor = transRelativePoint({\
          { 1686, 399, 0x000000 }, { 1685, 399, 0x636db5 },\
          { 1686, 398, 0x000000 }, { 1685, 398, 0x636dad },\
          { 1687, 400, 0x000000 }, { 1686, 400, 0x636db5 },\
          { 1687, 401, 0x000000 }, { 1686, 401, 0x5a6dad },\
        })\
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
      -- 2-8 的右边\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022, }\
        local basePoint, posandcolor = transRelativePoint({\
          { 1733, 706, 0x000000 }, { 1732, 706, 0x6359a4 },\
          { 1733, 705, 0x000000 }, { 1732, 705, 0x5a559c },\
          { 1734, 707, 0x000000 }, { 1733, 707, 0x5a55a4 },\
          { 1734, 708, 0x000000 }, { 1733, 708, 0x5a559c },\
        })\
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
      -- 3-8 的右边\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022, }\
        local basePoint, posandcolor = transRelativePoint({\
          { 1769, 843, 0x000000 }, { 1768, 843, 0x42417b },\
          { 1769, 842, 0x000000 }, { 1768, 842, 0x4a457b },\
          { 1770, 844, 0x000000 }, { 1769, 844, 0x4a417b },\
          { 1770, 845, 0x000000 }, { 1769, 845, 0x4a417b },\
        })\
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
      -- 4-8 的右边\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022, }\
        local basePoint, posandcolor = transRelativePoint({\
          { 1675, 694, 0x000000 }, { 1674, 694, 0x42416b },\
          { 1675, 693, 0x000000 }, { 1674, 693, 0x3a3563 },\
          { 1676, 695, 0x000000 }, { 1675, 695, 0x423563 },\
          { 1676, 696, 0x000000 }, { 1675, 696, 0x3a3563 },\
        })\
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
      -- 5-8 的右边\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022, }\
        local basePoint, posandcolor = transRelativePoint({\
          { 1702, 623, 0x000000 }, { 1701, 623, 0x3a3563 },\
          { 1702, 622, 0x000000 }, { 1701, 622, 0x3a3563 },\
          { 1703, 624, 0x000000 }, { 1702, 624, 0x423d63 },\
          { 1703, 625, 0x000000 }, { 1702, 625, 0x3a3163 },\
        })\
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
    },\
    -- 我方舰队位置\
    myFleetList = imgBase.map.myFleetList,\
    -- 我放舰队被选中的舰队的绿色的选中箭头的位置\
    selectedArrow = imgBase.map.selectedArrow,\
    -- 敌方舰队位置(小型舰队)\
    enemyList1 = imgBase.map.enemyList1,\
    -- 敌方舰队位置(中型舰队)\
    enemyList2 = imgBase.map.enemyList2,\
    -- 敌方舰队位置(大型舰队)\
    enemyList3 = imgBase.map.enemyList3,\
    -- boss位置\
    bossPointList = imgBase.map.bossPointList,\
    -- 战斗中的位置\
    inBattleList = imgBase.map.inBattleList,\
    -- 奖励箱的位置\
    rewardBoxList = imgBase.map.rewardBoxList,\
  },\
}" }


package.sourceCode = package.sourceCode or {}
package.sourceCode["./meta-operation/maps-options/img8-4.lua"] = { path = "./meta-operation/maps-options/img8-4.lua", name = "./meta-operation/maps-options/img8-4.lua", source = "-- 存储图像信息，用于界面找色、找图。取代图片搜索，因为找色搜索的像素点更少\
local imgBase = require './img'\
\
local transRelativePoint = imgBase.transRelativePoint\
\
return {\
  transRelativePoint = transRelativePoint,\
  -- 基本方法\
  toPoint = imgBase.toPoint,\
  -- 过滤被右下角按钮挡住的部分的点，因为右下角按钮也是黑色的容易与边界识别混淆\
  filterNoUsePoint = imgBase.filterNoUsePoint,\
  -- 图片数据\
  -- 地图扫描\
  map = {\
    -- 地图上边界\
    topLineList = {\
      -- 1-8的上边\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022, }\
        local basePoint, posandcolor = transRelativePoint({\
          { 1558, 509, 0x192031 }, { 1565, 509, 0x212442 },\
          { 1576, 509, 0x212031 }, { 1588, 509, 0x191c31 },\
          { 1598, 510, 0x3abee6 }, { 1586, 510, 0x3ac2e6 },\
          { 1570, 510, 0x31c2de }, { 1559, 510, 0x31bede },\
        })\
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
      -- 1-7的上边\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022, }\
        local basePoint, posandcolor = transRelativePoint({\
          { 1390, 509, 0x192031 }, { 1405, 509, 0x212442 },\
          { 1421, 509, 0x212442 }, { 1435, 509, 0x212431 },\
          { 1448, 510, 0x3acade }, { 1428, 510, 0x3acade },\
          { 1413, 510, 0x3ac6d6 }, { 1396, 510, 0x42dbe6 },\
        })\
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
      -- 1-4的上边\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022, }\
        local basePoint, posandcolor = transRelativePoint({\
          { 898, 509, 0x101c31 }, { 918, 509, 0x191c31 },\
          { 935, 509, 0x19203a }, { 950, 509, 0x191c31 },\
          { 959, 510, 0x31b6de }, { 938, 510, 0x3ab6e6 },\
          { 924, 510, 0x31b2de }, { 909, 510, 0x31b2de },\
        })\
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
    },\
    -- 地图下边界\
    bottonLineList = {\
      -- 7-1 的下面\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022 }\
        local basePoint, posandcolor = transRelativePoint({\
          { 572, 906, 0x000000 }, { 589, 906, 0x000000 },\
          { 604, 906, 0x000000 }, { 617, 906, 0x000000 },\
          { 631, 905, 0x2181c5 }, { 608, 905, 0x197dc5 },\
          { 591, 905, 0x2181c5 }, { 574, 905, 0x217dbd },\
        })\
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
      -- 6-3 的下面\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022 }\
        local basePoint, posandcolor = transRelativePoint({\
          { 1009, 906, 0x000000 }, { 1029, 906, 0x000000 },\
          { 1043, 906, 0x000000 }, { 1055, 906, 0x000000 },\
          { 1066, 905, 0x1965b5 }, { 1049, 905, 0x2169b5 },\
          { 1034, 905, 0x1969b5 }, { 1020, 905, 0x1969ad },\
        })\
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
      -- 6-5 的下面\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022 }\
        local basePoint, posandcolor = transRelativePoint({\
          { 1444, 906, 0x000000 }, { 1461, 906, 0x000000 },\
          { 1475, 906, 0x000000 }, { 1488, 906, 0x000000 },\
          { 1501, 905, 0x1049a4 }, { 1481, 905, 0x104da4 },\
          { 1465, 905, 0x1049a4 }, { 1452, 905, 0x104da4 },\
        })\
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
      -- 6-8 的下面\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022 }\
        local basePoint, posandcolor = transRelativePoint({\
          { 1549, 905, 0x000000 }, { 1566, 905, 0x000000 },\
          { 1581, 905, 0x000000 }, { 1595, 905, 0x000000 },\
          { 1607, 904, 0x3a6dbd }, { 1587, 904, 0x3169b5 },\
          { 1572, 904, 0x3169bd }, { 1557, 904, 0x3169bd },\
        })\
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
    },\
    -- 地图左边界\
    leftLineList = {\
      -- 1-7 的左边\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022, }\
        local basePoint, posandcolor = transRelativePoint({\
          { 544, 784, 0x000000 }, { 545, 784, 0x218ec5 },\
          { 544, 783, 0x000000 }, { 545, 783, 0x218ec5 },\
          { 543, 785, 0x000000 }, { 544, 785, 0x218ec5 },\
          { 543, 786, 0x000000 }, { 544, 786, 0x2992ce },\
        })\
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
      -- 1-5 的左边\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022, }\
        local basePoint, posandcolor = transRelativePoint({\
          { 581, 489, 0x000000 }, { 582, 489, 0x3192d6 },\
          { 581, 488, 0x000000 }, { 582, 488, 0x3a96de },\
          { 580, 490, 0x000000 }, { 581, 490, 0x3196d6 },\
          { 580, 491, 0x000000 }, { 581, 491, 0x3a96d6 },\
        })\
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
      -- 1-3 的左边\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022, }\
        local basePoint, posandcolor = transRelativePoint({\
          { 614, 227, 0x000101 }, { 615, 227, 0x31bad6 },\
          { 614, 226, 0x000000 }, { 615, 226, 0x29bad6 },\
          { 613, 228, 0x000000 }, { 614, 228, 0x31bad6 },\
          { 613, 229, 0x000000 }, { 614, 229, 0x29b6d6 },\
        })\
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
    },\
    -- 地图右边界\
    rightLineList = {\
      -- 7-8 的右边\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022, }\
        local basePoint, posandcolor = transRelativePoint({\
          { 1724, 850, 0x000000 }, { 1723, 850, 0x3171c5 },\
          { 1724, 849, 0x000000 }, { 1723, 849, 0x3175c5 },\
          { 1725, 851, 0x000000 }, { 1724, 851, 0x3171bd },\
          { 1725, 852, 0x000000 }, { 1724, 852, 0x3a75ce },\
        })\
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
      -- 4-8 的右边\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022, }\
        local basePoint, posandcolor = transRelativePoint({\
          { 1617, 378, 0x000000 }, { 1616, 378, 0x31b2de },\
          { 1617, 377, 0x000000 }, { 1616, 377, 0x29b2d6 },\
          { 1618, 379, 0x000000 }, { 1617, 379, 0x31b2de },\
          { 1618, 380, 0x000000 }, { 1617, 380, 0x31b2de },\
        })\
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
      -- 1-8 的右边\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022, }\
        local basePoint, posandcolor = transRelativePoint({\
          { 1672, 290, 0x000000 }, { 1671, 290, 0x31aede },\
          { 1672, 289, 0x000000 }, { 1671, 289, 0x31b2de },\
          { 1673, 291, 0x000000 }, { 1672, 291, 0x29aede },\
          { 1673, 292, 0x000000 }, { 1672, 292, 0x31b2e6 },\
        })\
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
    },\
    -- 我方舰队位置\
    myFleetList = imgBase.map.myFleetList,\
    -- 我放舰队被选中的舰队的绿色的选中箭头的位置\
    selectedArrow = imgBase.map.selectedArrow,\
    -- 敌方舰队位置(小型舰队)\
    enemyList1 = imgBase.map.enemyList1,\
    -- 敌方舰队位置(中型舰队)\
    enemyList2 = imgBase.map.enemyList2,\
    -- 敌方舰队位置(大型舰队)\
    enemyList3 = imgBase.map.enemyList3,\
    -- boss位置\
    bossPointList = imgBase.map.bossPointList,\
    -- 战斗中的位置\
    inBattleList = imgBase.map.inBattleList,\
    -- 奖励箱的位置\
    rewardBoxList = imgBase.map.rewardBoxList,\
  },\
}" }


package.sourceCode = package.sourceCode or {}
package.sourceCode["./meta-operation/maps-options/img8-3.lua"] = { path = "./meta-operation/maps-options/img8-3.lua", name = "./meta-operation/maps-options/img8-3.lua", source = "-- 存储图像信息，用于界面找色、找图。取代图片搜索，因为找色搜索的像素点更少\
local imgBase = require './img'\
\
local transRelativePoint = imgBase.transRelativePoint\
\
return {\
  transRelativePoint = transRelativePoint,\
  -- 基本方法\
  toPoint = imgBase.toPoint,\
  -- 过滤被右下角按钮挡住的部分的点，因为右下角按钮也是黑色的容易与边界识别混淆\
  filterNoUsePoint = imgBase.filterNoUsePoint,\
  -- 图片数据\
  -- 地图扫描\
  map = {\
    -- 地图上边界\
    topLineList = {\
      -- 1-8的上边\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022, }\
        local basePoint, posandcolor = transRelativePoint({\
          { 1558, 509, 0x192031 }, { 1565, 509, 0x212442 },\
          { 1576, 509, 0x212031 }, { 1588, 509, 0x191c31 },\
          { 1598, 510, 0x3abee6 }, { 1586, 510, 0x3ac2e6 },\
          { 1570, 510, 0x31c2de }, { 1559, 510, 0x31bede },\
        })\
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
      -- 1-7的上边\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022, }\
        local basePoint, posandcolor = transRelativePoint({\
          { 1390, 509, 0x192031 }, { 1405, 509, 0x212442 },\
          { 1421, 509, 0x212442 }, { 1435, 509, 0x212431 },\
          { 1448, 510, 0x3acade }, { 1428, 510, 0x3acade },\
          { 1413, 510, 0x3ac6d6 }, { 1396, 510, 0x42dbe6 },\
        })\
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
      -- 1-4的上边\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022, }\
        local basePoint, posandcolor = transRelativePoint({\
          { 898, 509, 0x101c31 }, { 918, 509, 0x191c31 },\
          { 935, 509, 0x19203a }, { 950, 509, 0x191c31 },\
          { 959, 510, 0x31b6de }, { 938, 510, 0x3ab6e6 },\
          { 924, 510, 0x31b2de }, { 909, 510, 0x31b2de },\
        })\
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
      -- 1-1的上边\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022, }\
        local basePoint, posandcolor = transRelativePoint({\
          { 395, 523, 0x3a353a }, { 408, 523, 0x292829 },\
          { 417, 523, 0x312d31 }, { 426, 523, 0x292829 },\
          { 438, 524, 0x31a2e6 }, { 428, 524, 0x319ee6 },\
          { 418, 524, 0x319ee6 }, { 408, 524, 0x319ee6 },\
        })\
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
      -- 1-2的上边\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022, }\
        local basePoint, posandcolor = transRelativePoint({\
          { 554, 523, 0x292829 }, { 567, 523, 0x312d31 },\
          { 581, 523, 0x312d31 }, { 592, 523, 0x292829 },\
          { 601, 524, 0x31aede }, { 588, 524, 0x31aee6 },\
          { 577, 524, 0x31b2e6 }, { 566, 524, 0x31b2de },\
        })\
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
    },\
    -- 地图下边界\
    bottonLineList = {\
      -- 7-1 的下面\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022 }\
        local basePoint, posandcolor = transRelativePoint({\
          { 572, 906, 0x000000 }, { 589, 906, 0x000000 },\
          { 604, 906, 0x000000 }, { 617, 906, 0x000000 },\
          { 631, 905, 0x2181c5 }, { 608, 905, 0x197dc5 },\
          { 591, 905, 0x2181c5 }, { 574, 905, 0x217dbd },\
        })\
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
      -- 6-3 的下面\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022 }\
        local basePoint, posandcolor = transRelativePoint({\
          { 1009, 906, 0x000000 }, { 1029, 906, 0x000000 },\
          { 1043, 906, 0x000000 }, { 1055, 906, 0x000000 },\
          { 1066, 905, 0x1965b5 }, { 1049, 905, 0x2169b5 },\
          { 1034, 905, 0x1969b5 }, { 1020, 905, 0x1969ad },\
        })\
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
      -- 6-5 的下面\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022 }\
        local basePoint, posandcolor = transRelativePoint({\
          { 1444, 906, 0x000000 }, { 1461, 906, 0x000000 },\
          { 1475, 906, 0x000000 }, { 1488, 906, 0x000000 },\
          { 1501, 905, 0x1049a4 }, { 1481, 905, 0x104da4 },\
          { 1465, 905, 0x1049a4 }, { 1452, 905, 0x104da4 },\
        })\
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
      -- 6-8 的下面\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022 }\
        local basePoint, posandcolor = transRelativePoint({\
          { 1549, 905, 0x000000 }, { 1566, 905, 0x000000 },\
          { 1581, 905, 0x000000 }, { 1595, 905, 0x000000 },\
          { 1607, 904, 0x3a6dbd }, { 1587, 904, 0x3169b5 },\
          { 1572, 904, 0x3169bd }, { 1557, 904, 0x3169bd },\
        })\
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
    },\
    -- 地图左边界\
    leftLineList = {\
      -- 1-7 的左边\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022, }\
        local basePoint, posandcolor = transRelativePoint({\
          { 544, 784, 0x000000 }, { 545, 784, 0x218ec5 },\
          { 544, 783, 0x000000 }, { 545, 783, 0x218ec5 },\
          { 543, 785, 0x000000 }, { 544, 785, 0x218ec5 },\
          { 543, 786, 0x000000 }, { 544, 786, 0x2992ce },\
        })\
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
      -- 1-5 的左边\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022, }\
        local basePoint, posandcolor = transRelativePoint({\
          { 581, 489, 0x000000 }, { 582, 489, 0x3192d6 },\
          { 581, 488, 0x000000 }, { 582, 488, 0x3a96de },\
          { 580, 490, 0x000000 }, { 581, 490, 0x3196d6 },\
          { 580, 491, 0x000000 }, { 581, 491, 0x3a96d6 },\
        })\
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
      -- 1-3 的左边\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022, }\
        local basePoint, posandcolor = transRelativePoint({\
          { 614, 227, 0x000101 }, { 615, 227, 0x31bad6 },\
          { 614, 226, 0x000000 }, { 615, 226, 0x29bad6 },\
          { 613, 228, 0x000000 }, { 614, 228, 0x31bad6 },\
          { 613, 229, 0x000000 }, { 614, 229, 0x29b6d6 },\
        })\
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
      -- 1-1 的左边\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022, }\
        local basePoint, posandcolor = transRelativePoint({\
          { 337, 601, 0x000000 }, { 338, 601, 0x31aade },\
          { 337, 600, 0x000000 }, { 338, 600, 0x3aaede },\
          { 336, 602, 0x000000 }, { 337, 602, 0x31aede },\
          { 336, 603, 0x000000 }, { 337, 603, 0x31aede },\
        })\
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
    },\
    -- 地图右边界\
    rightLineList = {\
      -- 7-8 的右边\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022, }\
        local basePoint, posandcolor = transRelativePoint({\
          { 1724, 850, 0x000000 }, { 1723, 850, 0x3171c5 },\
          { 1724, 849, 0x000000 }, { 1723, 849, 0x3175c5 },\
          { 1725, 851, 0x000000 }, { 1724, 851, 0x3171bd },\
          { 1725, 852, 0x000000 }, { 1724, 852, 0x3a75ce },\
        })\
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
      -- 4-8 的右边\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022, }\
        local basePoint, posandcolor = transRelativePoint({\
          { 1617, 378, 0x000000 }, { 1616, 378, 0x31b2de },\
          { 1617, 377, 0x000000 }, { 1616, 377, 0x29b2d6 },\
          { 1618, 379, 0x000000 }, { 1617, 379, 0x31b2de },\
          { 1618, 380, 0x000000 }, { 1617, 380, 0x31b2de },\
        })\
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
      -- 1-8 的右边\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022, }\
        local basePoint, posandcolor = transRelativePoint({\
          { 1672, 290, 0x000000 }, { 1671, 290, 0x31aede },\
          { 1672, 289, 0x000000 }, { 1671, 289, 0x31b2de },\
          { 1673, 291, 0x000000 }, { 1672, 291, 0x29aede },\
          { 1673, 292, 0x000000 }, { 1672, 292, 0x31b2e6 },\
        })\
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
    },\
    -- 我方舰队位置\
    myFleetList = imgBase.map.myFleetList,\
    -- 我放舰队被选中的舰队的绿色的选中箭头的位置\
    selectedArrow = imgBase.map.selectedArrow,\
    -- 敌方舰队位置(小型舰队)\
    enemyList1 = imgBase.map.enemyList1,\
    -- 敌方舰队位置(中型舰队)\
    enemyList2 = imgBase.map.enemyList2,\
    -- 敌方舰队位置(大型舰队)\
    enemyList3 = imgBase.map.enemyList3,\
    -- boss位置\
    bossPointList = imgBase.map.bossPointList,\
    -- 战斗中的位置\
    inBattleList = imgBase.map.inBattleList,\
    -- 奖励箱的位置\
    rewardBoxList = imgBase.map.rewardBoxList,\
  },\
}" }


package.sourceCode = package.sourceCode or {}
package.sourceCode["./meta-operation/maps-options/img8-2.lua"] = { path = "./meta-operation/maps-options/img8-2.lua", name = "./meta-operation/maps-options/img8-2.lua", source = "-- 存储图像信息，用于界面找色、找图。取代图片搜索，因为找色搜索的像素点更少\
local imgBase = require './img'\
\
local transRelativePoint = imgBase.transRelativePoint\
\
return {\
  transRelativePoint = transRelativePoint,\
  -- 基本方法\
  toPoint = imgBase.toPoint,\
  -- 过滤被右下角按钮挡住的部分的点，因为右下角按钮也是黑色的容易与边界识别混淆\
  filterNoUsePoint = imgBase.filterNoUsePoint,\
  -- 图片数据\
  -- 地图扫描\
  map = {\
    -- 地图上边界\
    topLineList = {\
      -- 1-8的上边\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022, }\
        local basePoint, posandcolor = transRelativePoint({\
          { 1558, 509, 0x192031 }, { 1565, 509, 0x212442 },\
          { 1576, 509, 0x212031 }, { 1588, 509, 0x191c31 },\
          { 1598, 510, 0x3abee6 }, { 1586, 510, 0x3ac2e6 },\
          { 1570, 510, 0x31c2de }, { 1559, 510, 0x31bede },\
        })\
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
      -- 1-7的上边\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022, }\
        local basePoint, posandcolor = transRelativePoint({\
          { 1390, 509, 0x192031 }, { 1405, 509, 0x212442 },\
          { 1421, 509, 0x212442 }, { 1435, 509, 0x212431 },\
          { 1448, 510, 0x3acade }, { 1428, 510, 0x3acade },\
          { 1413, 510, 0x3ac6d6 }, { 1396, 510, 0x42dbe6 },\
        })\
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
      -- 1-4的上边\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022, }\
        local basePoint, posandcolor = transRelativePoint({\
          { 898, 509, 0x101c31 }, { 918, 509, 0x191c31 },\
          { 935, 509, 0x19203a }, { 950, 509, 0x191c31 },\
          { 959, 510, 0x31b6de }, { 938, 510, 0x3ab6e6 },\
          { 924, 510, 0x31b2de }, { 909, 510, 0x31b2de },\
        })\
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
    },\
    -- 地图下边界\
    bottonLineList = {\
      -- 7-1 的下面\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022 }\
        local basePoint, posandcolor = transRelativePoint({\
          { 572, 906, 0x000000 }, { 589, 906, 0x000000 },\
          { 604, 906, 0x000000 }, { 617, 906, 0x000000 },\
          { 631, 905, 0x2181c5 }, { 608, 905, 0x197dc5 },\
          { 591, 905, 0x2181c5 }, { 574, 905, 0x217dbd },\
        })\
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
      -- 6-3 的下面\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022 }\
        local basePoint, posandcolor = transRelativePoint({\
          { 1009, 906, 0x000000 }, { 1029, 906, 0x000000 },\
          { 1043, 906, 0x000000 }, { 1055, 906, 0x000000 },\
          { 1066, 905, 0x1965b5 }, { 1049, 905, 0x2169b5 },\
          { 1034, 905, 0x1969b5 }, { 1020, 905, 0x1969ad },\
        })\
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
      -- 6-5 的下面\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022 }\
        local basePoint, posandcolor = transRelativePoint({\
          { 1444, 906, 0x000000 }, { 1461, 906, 0x000000 },\
          { 1475, 906, 0x000000 }, { 1488, 906, 0x000000 },\
          { 1501, 905, 0x1049a4 }, { 1481, 905, 0x104da4 },\
          { 1465, 905, 0x1049a4 }, { 1452, 905, 0x104da4 },\
        })\
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
      -- 6-8 的下面\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022 }\
        local basePoint, posandcolor = transRelativePoint({\
          { 1549, 905, 0x000000 }, { 1566, 905, 0x000000 },\
          { 1581, 905, 0x000000 }, { 1595, 905, 0x000000 },\
          { 1607, 904, 0x3a6dbd }, { 1587, 904, 0x3169b5 },\
          { 1572, 904, 0x3169bd }, { 1557, 904, 0x3169bd },\
        })\
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
    },\
    -- 地图左边界\
    leftLineList = {\
      -- 1-7 的左边\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022, }\
        local basePoint, posandcolor = transRelativePoint({\
          { 544, 784, 0x000000 }, { 545, 784, 0x218ec5 },\
          { 544, 783, 0x000000 }, { 545, 783, 0x218ec5 },\
          { 543, 785, 0x000000 }, { 544, 785, 0x218ec5 },\
          { 543, 786, 0x000000 }, { 544, 786, 0x2992ce },\
        })\
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
      -- 1-5 的左边\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022, }\
        local basePoint, posandcolor = transRelativePoint({\
          { 581, 489, 0x000000 }, { 582, 489, 0x3192d6 },\
          { 581, 488, 0x000000 }, { 582, 488, 0x3a96de },\
          { 580, 490, 0x000000 }, { 581, 490, 0x3196d6 },\
          { 580, 491, 0x000000 }, { 581, 491, 0x3a96d6 },\
        })\
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
      -- 1-3 的左边\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022, }\
        local basePoint, posandcolor = transRelativePoint({\
          { 614, 227, 0x000101 }, { 615, 227, 0x31bad6 },\
          { 614, 226, 0x000000 }, { 615, 226, 0x29bad6 },\
          { 613, 228, 0x000000 }, { 614, 228, 0x31bad6 },\
          { 613, 229, 0x000000 }, { 614, 229, 0x29b6d6 },\
        })\
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
    },\
    -- 地图右边界\
    rightLineList = {\
      -- 7-8 的右边\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022, }\
        local basePoint, posandcolor = transRelativePoint({\
          { 1724, 850, 0x000000 }, { 1723, 850, 0x3171c5 },\
          { 1724, 849, 0x000000 }, { 1723, 849, 0x3175c5 },\
          { 1725, 851, 0x000000 }, { 1724, 851, 0x3171bd },\
          { 1725, 852, 0x000000 }, { 1724, 852, 0x3a75ce },\
        })\
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
      -- 4-8 的右边\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022, }\
        local basePoint, posandcolor = transRelativePoint({\
          { 1617, 378, 0x000000 }, { 1616, 378, 0x31b2de },\
          { 1617, 377, 0x000000 }, { 1616, 377, 0x29b2d6 },\
          { 1618, 379, 0x000000 }, { 1617, 379, 0x31b2de },\
          { 1618, 380, 0x000000 }, { 1617, 380, 0x31b2de },\
        })\
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
      -- 1-8 的右边\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022, }\
        local basePoint, posandcolor = transRelativePoint({\
          { 1672, 290, 0x000000 }, { 1671, 290, 0x31aede },\
          { 1672, 289, 0x000000 }, { 1671, 289, 0x31b2de },\
          { 1673, 291, 0x000000 }, { 1672, 291, 0x29aede },\
          { 1673, 292, 0x000000 }, { 1672, 292, 0x31b2e6 },\
        })\
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
    },\
    -- 我方舰队位置\
    myFleetList = imgBase.map.myFleetList,\
    -- 我放舰队被选中的舰队的绿色的选中箭头的位置\
    selectedArrow = imgBase.map.selectedArrow,\
    -- 敌方舰队位置(小型舰队)\
    enemyList1 = imgBase.map.enemyList1,\
    -- 敌方舰队位置(中型舰队)\
    enemyList2 = imgBase.map.enemyList2,\
    -- 敌方舰队位置(大型舰队)\
    enemyList3 = imgBase.map.enemyList3,\
    -- boss位置\
    bossPointList = imgBase.map.bossPointList,\
    -- 战斗中的位置\
    inBattleList = imgBase.map.inBattleList,\
    -- 奖励箱的位置\
    rewardBoxList = imgBase.map.rewardBoxList,\
  },\
}" }


package.sourceCode = package.sourceCode or {}
package.sourceCode["./meta-operation/maps-options/img8-1.lua"] = { path = "./meta-operation/maps-options/img8-1.lua", name = "./meta-operation/maps-options/img8-1.lua", source = "-- 存储图像信息，用于界面找色、找图。取代图片搜索，因为找色搜索的像素点更少\
local imgBase = require './img'\
\
local transRelativePoint = imgBase.transRelativePoint\
\
return {\
  transRelativePoint = transRelativePoint,\
  -- 基本方法\
  toPoint = imgBase.toPoint,\
  -- 过滤被右下角按钮挡住的部分的点，因为右下角按钮也是黑色的容易与边界识别混淆\
  filterNoUsePoint = imgBase.filterNoUsePoint,\
  -- 图片数据\
  -- 地图扫描\
  map = {\
    -- 地图上边界\
    topLineList = {\
      -- 1-8的上边\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022, }\
        local basePoint, posandcolor = transRelativePoint({\
          { 1558, 509, 0x192031 }, { 1565, 509, 0x212442 },\
          { 1576, 509, 0x212031 }, { 1588, 509, 0x191c31 },\
          { 1598, 510, 0x3abee6 }, { 1586, 510, 0x3ac2e6 },\
          { 1570, 510, 0x31c2de }, { 1559, 510, 0x31bede },\
        })\
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
      -- 1-7的上边\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022, }\
        local basePoint, posandcolor = transRelativePoint({\
          { 1390, 509, 0x192031 }, { 1405, 509, 0x212442 },\
          { 1421, 509, 0x212442 }, { 1435, 509, 0x212431 },\
          { 1448, 510, 0x3acade }, { 1428, 510, 0x3acade },\
          { 1413, 510, 0x3ac6d6 }, { 1396, 510, 0x42dbe6 },\
        })\
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
      -- 1-4的上边\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022, }\
        local basePoint, posandcolor = transRelativePoint({\
          { 898, 509, 0x101c31 }, { 918, 509, 0x191c31 },\
          { 935, 509, 0x19203a }, { 950, 509, 0x191c31 },\
          { 959, 510, 0x31b6de }, { 938, 510, 0x3ab6e6 },\
          { 924, 510, 0x31b2de }, { 909, 510, 0x31b2de },\
        })\
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
    },\
    -- 地图下边界\
    bottonLineList = {\
      -- 3-1 的下面\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022 }\
        local basePoint, posandcolor = transRelativePoint({\
          { 506, 881, 0x000000 }, { 516, 881, 0x000000 },\
          { 525, 881, 0x000000 }, { 538, 881, 0x000000 },\
          { 548, 880, 0x2181c5 }, { 537, 880, 0x217dc5 },\
          { 527, 880, 0x217dbd }, { 517, 880, 0x2181c5 },\
        })\
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
      -- 3-4 的下面\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022 }\
        local basePoint, posandcolor = transRelativePoint({\
          { 1327, 881, 0x000000 }, { 1341, 881, 0x000000 },\
          { 1350, 881, 0x000000 }, { 1361, 881, 0x000000 },\
          { 1371, 880, 0x10519c }, { 1358, 880, 0x1055a4 },\
          { 1348, 880, 0x1055ad }, { 1338, 880, 0x1955ad },\
        })\
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
      -- 3-5 的下面\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022 }\
        local basePoint, posandcolor = transRelativePoint({\
          { 976, 896, 0x000001 }, { 991, 896, 0x000001 },\
          { 1001, 896, 0x000000 }, { 1012, 896, 0x000001 },\
          { 1027, 895, 0x1051a4 }, { 1014, 895, 0x1049a4 },\
          { 1002, 895, 0x1049a4 }, { 987, 895, 0x1051a4 },\
          { 979, 895, 0x1051a4 },\
        })\
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
    },\
    -- 地图左边界\
    leftLineList = {\
      -- 1-1 的左边\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022, }\
        local basePoint, posandcolor = transRelativePoint({\
          { 529, 531, 0x000000 }, { 530, 531, 0x31a6d6 },\
          { 529, 530, 0x000000 }, { 530, 530, 0x31aee6 },\
          { 528, 532, 0x080408 }, { 529, 532, 0x31aede },\
          { 528, 533, 0x000000 }, { 529, 533, 0x31aede },\
        })\
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
      -- 2-1 的左边\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022, }\
        local basePoint, posandcolor = transRelativePoint({\
          { 512, 652, 0x080509 }, { 513, 652, 0x29aace },\
          { 512, 651, 0x000101 }, { 513, 651, 0x29aad6 },\
          { 511, 653, 0x000000 }, { 512, 653, 0x29aace },\
          { 511, 654, 0x000000 }, { 512, 654, 0x29aed6 },\
        })\
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
      -- 3-1 的左边\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022, }\
        local basePoint, posandcolor = transRelativePoint({\
          { 494, 779, 0x000000 }, { 495, 779, 0x2992ce },\
          { 494, 778, 0x000000 }, { 495, 778, 0x2192c5 },\
          { 493, 780, 0x000000 }, { 494, 780, 0x3192ce },\
          { 493, 781, 0x000000 }, { 494, 781, 0x298ec5 },\
        })\
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
    },\
    -- 地图右边界\
    rightLineList = {\
      -- 1-9 的右边\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022, }\
        local basePoint, posandcolor = transRelativePoint({\
          { 1676, 594, 0x000000 }, { 1675, 594, 0x29b9dd },\
          { 1676, 593, 0x000000 }, { 1675, 593, 0x29b9e5 },\
          { 1677, 595, 0x000000 }, { 1676, 595, 0x29b5dd },\
          { 1677, 596, 0x000000 }, { 1676, 596, 0x31bae6 },\
        })\
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
      -- 2-9 的右边\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022, }\
        local basePoint, posandcolor = transRelativePoint({\
          { 1690, 655, 0x000000 }, { 1689, 655, 0x31b2de },\
          { 1690, 654, 0x000000 }, { 1689, 654, 0x29aed6 },\
          { 1691, 656, 0x000000 }, { 1690, 656, 0x31b1dd },\
          { 1691, 657, 0x000000 }, { 1690, 657, 0x29aede },\
        })\
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
      -- 3-9 的右边\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022, }\
        local basePoint, posandcolor = transRelativePoint({\
          { 1730, 829, 0x000000 }, { 1729, 829, 0x4275c5 },\
          { 1730, 828, 0x000000 }, { 1729, 828, 0x4275c5 },\
          { 1731, 830, 0x000000 }, { 1730, 830, 0x4a79ce },\
          { 1731, 831, 0x000000 }, { 1730, 831, 0x4275c5 },\
        })\
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
    },\
    -- 我方舰队位置\
    myFleetList = imgBase.map.myFleetList,\
    -- 我放舰队被选中的舰队的绿色的选中箭头的位置\
    selectedArrow = imgBase.map.selectedArrow,\
    -- 敌方舰队位置(小型舰队)\
    enemyList1 = imgBase.map.enemyList1,\
    -- 敌方舰队位置(中型舰队)\
    enemyList2 = imgBase.map.enemyList2,\
    -- 敌方舰队位置(大型舰队)\
    enemyList3 = imgBase.map.enemyList3,\
    -- boss位置\
    bossPointList = imgBase.map.bossPointList,\
    -- 战斗中的位置\
    inBattleList = imgBase.map.inBattleList,\
    -- 奖励箱的位置\
    rewardBoxList = imgBase.map.rewardBoxList,\
  },\
}" }


package.sourceCode = package.sourceCode or {}
package.sourceCode["./meta-operation/maps-options/img7-4.lua"] = { path = "./meta-operation/maps-options/img7-4.lua", name = "./meta-operation/maps-options/img7-4.lua", source = "-- 存储图像信息，用于界面找色、找图。取代图片搜索，因为找色搜索的像素点更少\
local imgBase = require './img'\
\
local transRelativePoint = imgBase.transRelativePoint\
\
return {\
  transRelativePoint = transRelativePoint,\
  -- 基本方法\
  toPoint = imgBase.toPoint,\
  -- 过滤被右下角按钮挡住的部分的点，因为右下角按钮也是黑色的容易与边界识别混淆\
  filterNoUsePoint = imgBase.filterNoUsePoint,\
  -- 图片数据\
  -- 地图扫描\
  map = {\
    -- 地图上边界\
    topLineList = {\
      -- 1-8的上边\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022, }\
        local basePoint, posandcolor = transRelativePoint({\
          { 1632, 497, 0x21252a }, { 1648, 497, 0x101421 },\
          { 1665, 497, 0x211921 }, { 1675, 497, 0x191d21 },\
          { 1687, 498, 0x6371ad }, { 1671, 498, 0x6371ad },\
          { 1655, 498, 0x6b71ad }, { 1641, 498, 0x6371ad },\
        })\
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
      -- 1-7的上边\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022, }\
        local basePoint, posandcolor = transRelativePoint({\
          { 1469, 497, 0x212542 }, { 1481, 497, 0x212542 },\
          { 1496, 497, 0x191d2a }, { 1507, 497, 0x192132 },\
          { 1513, 498, 0x5a65a4 }, { 1499, 498, 0x5a65a4 },\
          { 1488, 498, 0x6365a4 }, { 1478, 498, 0x5a61a4 },\
        })\
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
      -- 1-4的上边\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022, }\
        local basePoint, posandcolor = transRelativePoint({\
          { 864, 497, 0x101421 }, { 877, 497, 0x211821 },\
          { 890, 497, 0x111419 }, { 902, 497, 0x111419 },\
          { 914, 498, 0x3a3563 }, { 900, 498, 0x3a3563 },\
          { 885, 498, 0x3a315a }, { 872, 498, 0x3a3163 },\
        })\
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
      -- 1-2的上边\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022, }\
        local basePoint, posandcolor = transRelativePoint({\
          { 568, 371, 0x101410 }, { 577, 371, 0x191819 },\
          { 586, 371, 0x101410 }, { 598, 371, 0x101410 },\
          { 608, 372, 0x423963 }, { 599, 372, 0x3a3163 },\
          { 591, 372, 0x3a3163 }, { 583, 372, 0x3a3163 },\
        })\
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
      -- 1-1的上边\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022, }\
        local basePoint, posandcolor = transRelativePoint({\
          { 390, 371, 0x101419 }, { 403, 371, 0x191819 },\
          { 413, 371, 0x191819 }, { 426, 371, 0x101410 },\
          { 436, 372, 0x423563 }, { 425, 372, 0x312d63 },\
          { 413, 372, 0x312d63 }, { 405, 372, 0x3a2d5a },\
        })\
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
    },\
    -- 地图下边界\
    bottonLineList = {\
      -- 6-1 的下面\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022 }\
        local basePoint, posandcolor = transRelativePoint({\
          { 573, 895, 0x000000 }, { 586, 895, 0x000000 },\
          { 597, 895, 0x000000 }, { 607, 895, 0x000000 },\
          { 614, 894, 0x29204a }, { 600, 894, 0x29204a },\
          { 589, 894, 0x29204a }, { 576, 894, 0x29204a },\
        })\
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
      -- 6-3 的下面\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022 }\
        local basePoint, posandcolor = transRelativePoint({\
          { 1014, 895, 0x000000 }, { 1032, 895, 0x000000 },\
          { 1052, 895, 0x000000 }, { 1071, 895, 0x000000 },\
          { 1082, 894, 0x312452 }, { 1063, 894, 0x29244a },\
          { 1047, 894, 0x31244a }, { 1029, 894, 0x29204a },\
        })\
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
      -- 6-5 的下面\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022 }\
        local basePoint, posandcolor = transRelativePoint({\
          { 837, 897, 0x312452 }, { 855, 897, 0x31244a },\
          { 873, 897, 0x312452 }, { 888, 897, 0x31244a },\
          { 900, 898, 0x000000 }, { 881, 898, 0x000000 },\
          { 865, 898, 0x000000 }, { 851, 898, 0x000000 },\
        })\
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
      -- 6-8 的下面\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022 }\
        local basePoint, posandcolor = transRelativePoint({\
          { 1549, 898, 0x000000 }, { 1560, 898, 0x000000 },\
          { 1572, 898, 0x000000 }, { 1584, 898, 0x000000 },\
          { 1592, 897, 0x312d52 }, { 1578, 897, 0x312852 },\
          { 1566, 897, 0x292852 }, { 1558, 897, 0x292d4a },\
        })\
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
    },\
    -- 地图左边界\
    leftLineList = {\
      -- 1-6 的左边\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022, }\
        local basePoint, posandcolor = transRelativePoint({\
          { 517, 790, 0x000000 }, { 518, 790, 0x29204a },\
          { 517, 789, 0x000000 }, { 518, 789, 0x212042 },\
          { 516, 791, 0x000000 }, { 517, 791, 0x29204a },\
          { 516, 792, 0x000000 }, { 517, 792, 0x29204a },\
        })\
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
      -- 1-4 的左边\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022, }\
        local basePoint, posandcolor = transRelativePoint({\
          { 558, 483, 0x000000 }, { 559, 483, 0x312452 },\
          { 558, 482, 0x000000 }, { 559, 482, 0x29244a },\
          { 557, 484, 0x000000 }, { 558, 484, 0x312452 },\
          { 557, 485, 0x000000 }, { 558, 485, 0x29204a },\
        })\
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
      -- 1-5 的左边\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022, }\
        local basePoint, posandcolor = transRelativePoint({\
          { 540, 618, 0x000000 }, { 541, 618, 0x29204a },\
          { 540, 617, 0x000000 }, { 541, 617, 0x292052 },\
          { 539, 619, 0x000000 }, { 540, 619, 0x21204a },\
          { 539, 620, 0x000000 }, { 540, 620, 0x292052 },\
        })\
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
      -- 1-1 的左边\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022, }\
        local basePoint, posandcolor = transRelativePoint({\
          { 337, 382, 0x000000 }, { 338, 382, 0x3a2d5a },\
          { 337, 381, 0x000000 }, { 338, 381, 0x312d52 },\
          { 336, 383, 0x000000 }, { 337, 383, 0x31315a },\
          { 336, 384, 0x000000 }, { 337, 384, 0x312d5a },\
        })\
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
    },\
    -- 地图右边界\
    rightLineList = {\
      -- 1-8 的右边\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022, }\
        local basePoint, posandcolor = transRelativePoint({\
          { 1696, 506, 0x000000 }, { 1695, 506, 0x6b71b5 },\
          { 1696, 505, 0x000000 }, { 1695, 505, 0x6b71b5 },\
          { 1697, 507, 0x000000 }, { 1696, 507, 0x636dad },\
          { 1697, 508, 0x000000 }, { 1696, 508, 0x6b71b5 },\
        })\
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
      -- 2-8 的右边\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022, }\
        local basePoint, posandcolor = transRelativePoint({\
          { 1731, 650, 0x000001 }, { 1730, 650, 0x6359a4 },\
          { 1731, 649, 0x000000 }, { 1730, 649, 0x5a559c },\
          { 1732, 651, 0x000000 }, { 1731, 651, 0x6355a4 },\
          { 1732, 652, 0x000000 }, { 1731, 652, 0x5a559c },\
        })\
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
      -- 3-8 的右边\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022, }\
        local basePoint, posandcolor = transRelativePoint({\
          { 1652, 643, 0x000000 }, { 1651, 643, 0x4a417b },\
          { 1652, 642, 0x000000 }, { 1651, 642, 0x4a417b },\
          { 1653, 644, 0x000000 }, { 1652, 644, 0x4a4184 },\
          { 1653, 645, 0x000000 }, { 1652, 645, 0x4a3d7b },\
        })\
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
      -- 6-8 的右边\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022, }\
        local basePoint, posandcolor = transRelativePoint({\
          { 1658, 789, 0x000000 }, { 1657, 789, 0x423563 },\
          { 1658, 788, 0x000000 }, { 1657, 788, 0x3a2d63 },\
          { 1659, 790, 0x000000 }, { 1658, 790, 0x3a3163 },\
          { 1659, 791, 0x000000 }, { 1658, 791, 0x312d5a },\
        })\
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
      -- 4-8 的右边\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022, }\
        local basePoint, posandcolor = transRelativePoint({\
          { 1594, 486, 0x000000 }, { 1593, 486, 0x42417b },\
          { 1594, 485, 0x000000 }, { 1593, 485, 0x42417b },\
          { 1595, 487, 0x000000 }, { 1594, 487, 0x424173 },\
          { 1595, 488, 0x000000 }, { 1594, 488, 0x4a417b },\
        })\
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
    },\
    -- 我方舰队位置\
    myFleetList = imgBase.map.myFleetList,\
    -- 我放舰队被选中的舰队的绿色的选中箭头的位置\
    selectedArrow = imgBase.map.selectedArrow,\
    -- 敌方舰队位置(小型舰队)\
    enemyList1 = imgBase.map.enemyList1,\
    -- 敌方舰队位置(中型舰队)\
    enemyList2 = imgBase.map.enemyList2,\
    -- 敌方舰队位置(大型舰队)\
    enemyList3 = imgBase.map.enemyList3,\
    -- boss位置\
    bossPointList = imgBase.map.bossPointList,\
    -- 战斗中的位置\
    inBattleList = imgBase.map.inBattleList,\
    -- 奖励箱的位置\
    rewardBoxList = imgBase.map.rewardBoxList,\
  },\
}" }


package.sourceCode = package.sourceCode or {}
package.sourceCode["./meta-operation/maps-options/img7-3.lua"] = { path = "./meta-operation/maps-options/img7-3.lua", name = "./meta-operation/maps-options/img7-3.lua", source = "-- 存储图像信息，用于界面找色、找图。取代图片搜索，因为找色搜索的像素点更少\
local imgBase = require './img'\
\
local transRelativePoint = imgBase.transRelativePoint\
\
return {\
  transRelativePoint = transRelativePoint,\
  -- 基本方法\
  toPoint = imgBase.toPoint,\
  -- 过滤被右下角按钮挡住的部分的点，因为右下角按钮也是黑色的容易与边界识别混淆\
  filterNoUsePoint = imgBase.filterNoUsePoint,\
  -- 图片数据\
  -- 地图扫描\
  map = {\
    -- 地图上边界\
    topLineList = {\
      -- 1-8的上边\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022, }\
        local basePoint, posandcolor = transRelativePoint({\
          { 1614, 451, 0x192431 }, { 1621, 451, 0x21283a },\
          { 1632, 451, 0x192431 }, { 1643, 451, 0x212842 },\
          { 1655, 452, 0x6b71ad }, { 1642, 452, 0x6b71b5 },\
          { 1630, 452, 0x6b71b5 }, { 1620, 452, 0x6b71b5 },\
        })\
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
      -- 1-7的上边\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022, }\
        local basePoint, posandcolor = transRelativePoint({\
          { 1448, 451, 0x192431 }, { 1459, 451, 0x21283a },\
          { 1473, 451, 0x21283a }, { 1487, 451, 0x21283a },\
          { 1501, 452, 0x5a65a4 }, { 1485, 452, 0x5a619c },\
          { 1473, 452, 0x5a619c }, { 1463, 452, 0x52619c },\
        })\
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
      -- 1-4的上边\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022, }\
        local basePoint, posandcolor = transRelativePoint({\
          { 864, 497, 0x101421 }, { 877, 497, 0x211821 },\
          { 890, 497, 0x111419 }, { 902, 497, 0x111419 },\
          { 914, 498, 0x3a3563 }, { 900, 498, 0x3a3563 },\
          { 885, 498, 0x3a315a }, { 872, 498, 0x3a3163 },\
        })\
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
      -- 1-2的上边\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022, }\
        local basePoint, posandcolor = transRelativePoint({\
          { 568, 371, 0x101410 }, { 577, 371, 0x191819 },\
          { 586, 371, 0x101410 }, { 598, 371, 0x101410 },\
          { 608, 372, 0x423963 }, { 599, 372, 0x3a3163 },\
          { 591, 372, 0x3a3163 }, { 583, 372, 0x3a3163 },\
        })\
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
      -- 1-1的上边\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022, }\
        local basePoint, posandcolor = transRelativePoint({\
          { 390, 371, 0x101419 }, { 403, 371, 0x191819 },\
          { 413, 371, 0x191819 }, { 426, 371, 0x101410 },\
          { 436, 372, 0x423563 }, { 425, 372, 0x312d63 },\
          { 413, 372, 0x312d63 }, { 405, 372, 0x3a2d5a },\
        })\
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
    },\
    -- 地图下边界\
    bottonLineList = {\
      -- 6-2 的下面\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022 }\
        local basePoint, posandcolor = transRelativePoint({\
          { 666, 869, 0x000000 }, { 680, 869, 0x000000 },\
          { 695, 869, 0x000000 }, { 707, 869, 0x000000 },\
          { 719, 868, 0x29204a }, { 707, 868, 0x29204a },\
          { 696, 868, 0x312452 }, { 675, 868, 0x29204a },\
        })\
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
      -- 6-6 的下面\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022 }\
        local basePoint, posandcolor = transRelativePoint({\
          { 1072, 880, 0x000000 }, { 1082, 880, 0x000000 },\
          { 1092, 880, 0x000000 }, { 1110, 880, 0x000000 },\
          { 1120, 879, 0x29244a }, { 1106, 879, 0x29244a },\
          { 1096, 879, 0x292442 }, { 1088, 879, 0x292442 },\
        })\
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
    },\
    -- 地图左边界\
    leftLineList = {\
      -- 5-5 的左边\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022, }\
        local basePoint, posandcolor = transRelativePoint({\
          { 472, 774, 0x000000 }, { 473, 774, 0x29204a },\
          { 472, 773, 0x000000 }, { 473, 773, 0x292052 },\
          { 471, 775, 0x000000 }, { 472, 775, 0x211c42 },\
          { 471, 776, 0x000000 }, { 472, 776, 0x29204a },\
        })\
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
      -- 5-3 的左边\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022, }\
        local basePoint, posandcolor = transRelativePoint({\
          { 513, 497, 0x000000 }, { 514, 497, 0x292452 },\
          { 513, 496, 0x000000 }, { 514, 496, 0x312852 },\
          { 512, 498, 0x000000 }, { 513, 498, 0x292852 },\
          { 512, 499, 0x000000 }, { 513, 499, 0x292852 },\
        })\
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
    },\
    -- 地图右边界\
    rightLineList = {\
      -- 1-8 的右边\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022, }\
        local basePoint, posandcolor = transRelativePoint({\
          { 1600, 405, 0x000001 }, { 1599, 405, 0x6365ad },\
          { 1600, 404, 0x000000 }, { 1599, 404, 0x6365ad },\
          { 1601, 406, 0x000000 }, { 1600, 406, 0x6369b5 },\
          { 1601, 407, 0x000000 }, { 1600, 407, 0x5a65ad },\
        })\
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
      -- 2-8 的右边\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022, }\
        local basePoint, posandcolor = transRelativePoint({\
          { 1621, 501, 0x000000 }, { 1620, 501, 0x5a559c },\
          { 1621, 500, 0x000000 }, { 1620, 500, 0x6355a4 },\
          { 1622, 502, 0x000000 }, { 1621, 502, 0x5a559c },\
          { 1622, 503, 0x000000 }, { 1621, 503, 0x5a55a4 },\
        })\
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
      -- 3-8 的右边\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022, }\
        local basePoint, posandcolor = transRelativePoint({\
          { 1652, 643, 0x000000 }, { 1651, 643, 0x4a417b },\
          { 1652, 642, 0x000000 }, { 1651, 642, 0x4a417b },\
          { 1653, 644, 0x000000 }, { 1652, 644, 0x4a4184 },\
          { 1653, 645, 0x000000 }, { 1652, 645, 0x4a3d7b },\
        })\
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
    },\
    -- 我方舰队位置\
    myFleetList = imgBase.map.myFleetList,\
    -- 我放舰队被选中的舰队的绿色的选中箭头的位置\
    selectedArrow = imgBase.map.selectedArrow,\
    -- 敌方舰队位置(小型舰队)\
    enemyList1 = imgBase.map.enemyList1,\
    -- 敌方舰队位置(中型舰队)\
    enemyList2 = imgBase.map.enemyList2,\
    -- 敌方舰队位置(大型舰队)\
    enemyList3 = imgBase.map.enemyList3,\
    -- boss位置\
    bossPointList = imgBase.map.bossPointList,\
    -- 战斗中的位置\
    inBattleList = imgBase.map.inBattleList,\
    -- 奖励箱的位置\
    rewardBoxList = imgBase.map.rewardBoxList,\
  },\
}" }


package.sourceCode = package.sourceCode or {}
package.sourceCode["./meta-operation/maps-options/img7-2.lua"] = { path = "./meta-operation/maps-options/img7-2.lua", name = "./meta-operation/maps-options/img7-2.lua", source = "-- 存储图像信息，用于界面找色、找图。取代图片搜索，因为找色搜索的像素点更少\
local imgBase = require './img'\
\
local transRelativePoint = imgBase.transRelativePoint\
\
return {\
  transRelativePoint = transRelativePoint,\
  -- 基本方法\
  toPoint = imgBase.toPoint,\
  -- 过滤被右下角按钮挡住的部分的点，因为右下角按钮也是黑色的容易与边界识别混淆\
  filterNoUsePoint = imgBase.filterNoUsePoint,\
  -- 图片数据\
  -- 地图扫描\
  map = {\
    -- 地图上边界\
    topLineList = {\
      -- 1-8的上边\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022, }\
        local basePoint, posandcolor = transRelativePoint({\
          { 1528, 364, 0x21283a }, { 1548, 364, 0x21283a },\
          { 1560, 364, 0x21283a }, { 1576, 364, 0x29283a },\
          { 1588, 365, 0x6371ad }, { 1575, 365, 0x6b71ad },\
          { 1560, 365, 0x6371ad }, { 1544, 365, 0x6371ad },\
        })\
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
      -- 1-7的上边\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022, }\
        local basePoint, posandcolor = transRelativePoint({\
          { 1358, 364, 0x21283a }, { 1376, 364, 0x21283a },\
          { 1386, 364, 0x21283a }, { 1400, 364, 0x21243a },\
          { 1412, 365, 0x5a69a4 }, { 1394, 365, 0x52659c },\
          { 1378, 365, 0x5a619c }, { 1361, 365, 0x525d9c },\
        })\
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
      -- 1-4的上边\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022, }\
        local basePoint, posandcolor = transRelativePoint({\
          { 767, 364, 0x192829 }, { 784, 364, 0x212d3a },\
          { 804, 364, 0x29353a }, { 824, 364, 0x29353a },\
          { 835, 365, 0x3a3563 }, { 815, 365, 0x3a3563 },\
          { 798, 365, 0x31315a }, { 783, 365, 0x3a3563 },\
        })\
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
      -- 1-2的上边\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022, }\
        local basePoint, posandcolor = transRelativePoint({\
          { 568, 371, 0x101410 }, { 577, 371, 0x191819 },\
          { 586, 371, 0x101410 }, { 598, 371, 0x101410 },\
          { 608, 372, 0x423963 }, { 599, 372, 0x3a3163 },\
          { 591, 372, 0x3a3163 }, { 583, 372, 0x3a3163 },\
        })\
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
      -- 1-1的上边\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022, }\
        local basePoint, posandcolor = transRelativePoint({\
          { 390, 371, 0x101419 }, { 403, 371, 0x191819 },\
          { 413, 371, 0x191819 }, { 426, 371, 0x101410 },\
          { 436, 372, 0x423563 }, { 425, 372, 0x312d63 },\
          { 413, 372, 0x312d63 }, { 405, 372, 0x3a2d5a },\
        })\
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
    },\
    -- 地图下边界\
    bottonLineList = {\
      -- 5-1 的下面\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022 }\
        local basePoint, posandcolor = transRelativePoint({\
          { 487, 888, 0x000000 }, { 501, 888, 0x000000 },\
          { 514, 888, 0x000000 }, { 528, 888, 0x000000 },\
          { 542, 887, 0x211c42 }, { 528, 887, 0x212042 },\
          { 513, 887, 0x212042 }, { 495, 887, 0x29204a },\
        })\
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
      -- 5-3 的下面\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022 }\
        local basePoint, posandcolor = transRelativePoint({\
          { 893, 888, 0x000000 }, { 917, 888, 0x000000 },\
          { 937, 888, 0x000000 }, { 957, 888, 0x000000 },\
          { 974, 887, 0x29244a }, { 956, 887, 0x29204a },\
          { 934, 887, 0x31244a }, { 913, 887, 0x312852 },\
        })\
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
      -- 5-5 的下面\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022 }\
        local basePoint, posandcolor = transRelativePoint({\
          { 1317, 888, 0x000000 }, { 1333, 888, 0x000000 },\
          { 1346, 888, 0x000000 }, { 1359, 888, 0x000000 },\
          { 1372, 887, 0x29244a }, { 1353, 887, 0x31244a },\
          { 1335, 887, 0x312452 }, { 1312, 887, 0x29244a },\
        })\
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
    },\
    -- 地图左边界\
    leftLineList = {\
      -- 5-5 的左边\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022, }\
        local basePoint, posandcolor = transRelativePoint({\
          { 472, 774, 0x000000 }, { 473, 774, 0x29204a },\
          { 472, 773, 0x000000 }, { 473, 773, 0x292052 },\
          { 471, 775, 0x000000 }, { 472, 775, 0x211c42 },\
          { 471, 776, 0x000000 }, { 472, 776, 0x29204a },\
        })\
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
      -- 5-3 的左边\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022, }\
        local basePoint, posandcolor = transRelativePoint({\
          { 513, 497, 0x000000 }, { 514, 497, 0x292452 },\
          { 513, 496, 0x000000 }, { 514, 496, 0x312852 },\
          { 512, 498, 0x000000 }, { 513, 498, 0x292852 },\
          { 512, 499, 0x000000 }, { 513, 499, 0x292852 },\
        })\
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
    },\
    -- 地图右边界\
    rightLineList = {\
      -- 1-8 的右边\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022, }\
        local basePoint, posandcolor = transRelativePoint({\
          { 1600, 405, 0x000001 }, { 1599, 405, 0x6365ad },\
          { 1600, 404, 0x000000 }, { 1599, 404, 0x6365ad },\
          { 1601, 406, 0x000000 }, { 1600, 406, 0x6369b5 },\
          { 1601, 407, 0x000000 }, { 1600, 407, 0x5a65ad },\
        })\
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
      -- 2-8 的右边\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022, }\
        local basePoint, posandcolor = transRelativePoint({\
          { 1621, 501, 0x000000 }, { 1620, 501, 0x5a559c },\
          { 1621, 500, 0x000000 }, { 1620, 500, 0x6355a4 },\
          { 1622, 502, 0x000000 }, { 1621, 502, 0x5a559c },\
          { 1622, 503, 0x000000 }, { 1621, 503, 0x5a55a4 },\
        })\
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
      -- 3-8 的右边\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022, }\
        local basePoint, posandcolor = transRelativePoint({\
          { 1652, 643, 0x000000 }, { 1651, 643, 0x4a417b },\
          { 1652, 642, 0x000000 }, { 1651, 642, 0x4a417b },\
          { 1653, 644, 0x000000 }, { 1652, 644, 0x4a4184 },\
          { 1653, 645, 0x000000 }, { 1652, 645, 0x4a3d7b },\
        })\
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
    },\
    -- 我方舰队位置\
    myFleetList = imgBase.map.myFleetList,\
    -- 我放舰队被选中的舰队的绿色的选中箭头的位置\
    selectedArrow = imgBase.map.selectedArrow,\
    -- 敌方舰队位置(小型舰队)\
    enemyList1 = imgBase.map.enemyList1,\
    -- 敌方舰队位置(中型舰队)\
    enemyList2 = imgBase.map.enemyList2,\
    -- 敌方舰队位置(大型舰队)\
    enemyList3 = imgBase.map.enemyList3,\
    -- boss位置\
    bossPointList = imgBase.map.bossPointList,\
    -- 战斗中的位置\
    inBattleList = imgBase.map.inBattleList,\
    -- 奖励箱的位置\
    rewardBoxList = imgBase.map.rewardBoxList,\
  },\
}" }


package.sourceCode = package.sourceCode or {}
package.sourceCode["./meta-operation/maps-options/img7-1.lua"] = { path = "./meta-operation/maps-options/img7-1.lua", name = "./meta-operation/maps-options/img7-1.lua", source = "-- 存储图像信息，用于界面找色、找图。取代图片搜索，因为找色搜索的像素点更少\
local imgBase = require './img'\
\
local transRelativePoint = imgBase.transRelativePoint\
\
return {\
  transRelativePoint = transRelativePoint,\
  -- 基本方法\
  toPoint = imgBase.toPoint,\
  -- 过滤被右下角按钮挡住的部分的点，因为右下角按钮也是黑色的容易与边界识别混淆\
  filterNoUsePoint = imgBase.filterNoUsePoint,\
  -- 图片数据\
  -- 地图扫描\
  map = {\
    -- 地图上边界\
    topLineList = {\
      -- 1-8的上边\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022, }\
        local basePoint, posandcolor = transRelativePoint({\
          { 1533, 462, 0x191d2a }, { 1575, 462, 0x191d32 },\
          { 1609, 462, 0x191d2a }, { 1646, 462, 0x212132 },\
          { 1660, 463, 0x6371ad }, { 1616, 463, 0x636dad },\
          { 1580, 463, 0x636dad }, { 1548, 463, 0x636dad },\
        })\
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
      -- 1-7的上边\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022, }\
        local basePoint, posandcolor = transRelativePoint({\
          { 1352, 462, 0x191d29 }, { 1400, 462, 0x191c29 },\
          { 1431, 462, 0x191d2a }, { 1473, 462, 0x111d21 },\
          { 1495, 463, 0x6369ad }, { 1452, 463, 0x525d9c },\
          { 1418, 463, 0x4a598c }, { 1376, 463, 0x424d84 },\
        })\
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
      -- 1-4的上边\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022, }\
        local basePoint, posandcolor = transRelativePoint({\
          { 798, 462, 0x191829 }, { 826, 462, 0x212431 },\
          { 866, 462, 0x191c29 }, { 897, 462, 0x192429 },\
          { 917, 463, 0x3a3963 }, { 891, 463, 0x423563 },\
          { 859, 463, 0x423563 }, { 825, 463, 0x3a3563 },\
        })\
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
    },\
    -- 地图下边界\
    bottonLineList = {\
      -- 3-3 的下面\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022 }\
        local basePoint, posandcolor = transRelativePoint({\
          { 561, 889, 0x000000 }, { 601, 889, 0x000000 },\
          { 630, 889, 0x000000 }, { 673, 889, 0x000000 },\
          { 690, 888, 0x31244a }, { 663, 888, 0x29244a },\
          { 633, 888, 0x29244a }, { 604, 888, 0x312452 },\
        })\
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
      -- 3-8 的下面\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022 }\
        local basePoint, posandcolor = transRelativePoint({\
          { 1597, 889, 0x000000 }, { 1645, 889, 0x000000 },\
          { 1683, 889, 0x000000 }, { 1719, 889, 0x000000 },\
          { 1753, 888, 0x3a315a }, { 1718, 888, 0x3a315a },\
          { 1676, 888, 0x312d52 }, { 1635, 888, 0x31284a },\
        })\
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
    },\
    -- 地图左边界\
    leftLineList = {\
      -- 1-1 的左边\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022, }\
        local basePoint, posandcolor = transRelativePoint({\
          { 250, 468, 0x000000 }, { 251, 468, 0x312d5a },\
          { 250, 467, 0x000000 }, { 251, 467, 0x42315a },\
          { 249, 469, 0x000000 }, { 250, 469, 0x31285a },\
          { 249, 470, 0x000000 }, { 250, 470, 0x3a2d63 },\
        })\
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
    },\
    -- 地图右边界\
    rightLineList = {\
      -- 1-8 的右边\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022, }\
        local basePoint, posandcolor = transRelativePoint({\
          { 1681, 469, 0x000000 }, { 1680, 469, 0x636dad },\
          { 1681, 468, 0x000000 }, { 1680, 468, 0x6b71b5 },\
          { 1682, 470, 0x000000 }, { 1681, 470, 0x6371ad },\
          { 1682, 471, 0x000000 }, { 1681, 471, 0x6371ad },\
        })\
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
      -- 2-8 的右边\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022, }\
        local basePoint, posandcolor = transRelativePoint({\
          { 1730, 652, 0x000000 }, { 1729, 652, 0x4a417b },\
          { 1730, 651, 0x000000 }, { 1729, 651, 0x4a417b },\
          { 1731, 653, 0x000000 }, { 1730, 653, 0x423d73 },\
          { 1731, 654, 0x000000 }, { 1730, 654, 0x4a417b },\
        })\
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
    },\
    -- 我方舰队位置\
    myFleetList = imgBase.map.myFleetList,\
    -- 我放舰队被选中的舰队的绿色的选中箭头的位置\
    selectedArrow = imgBase.map.selectedArrow,\
    -- 敌方舰队位置(小型舰队)\
    enemyList1 = imgBase.map.enemyList1,\
    -- 敌方舰队位置(中型舰队)\
    enemyList2 = imgBase.map.enemyList2,\
    -- 敌方舰队位置(大型舰队)\
    enemyList3 = imgBase.map.enemyList3,\
    -- boss位置\
    bossPointList = table.merge(--\
    -- 我方舰队不和boss重叠 3-8\
      {\
        (function()\
          local leftTop = { 185, 155 }\
          local rightBotton = { 1899, 1022, }\
          local basePoint, posandcolor = transRelativePoint({\
            { 1624, 752, 0x423d42 }, { 1648, 751, 0x312d31 },\
            { 1675, 755, 0x292429 }, { 1626, 784, 0xff4d52 },\
            { 1675, 785, 0xff4d52 }, { 1649, 798, 0x312831 },\
            { 1650, 812, 0x7b0410 }, { 1621, 727, 0x211010 },\
            { 1677, 730, 0x211819 },\
          })\
          return { basePoint[3], posandcolor, 82, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
        end)(),\
      },\
      imgBase.map.bossPointList),\
    -- 战斗中的位置\
    inBattleList = imgBase.map.inBattleList,\
    -- 奖励箱的位置\
    rewardBoxList = imgBase.map.rewardBoxList,\
  },\
}" }


package.sourceCode = package.sourceCode or {}
package.sourceCode["./meta-operation/maps-options/img6-4.lua"] = { path = "./meta-operation/maps-options/img6-4.lua", name = "./meta-operation/maps-options/img6-4.lua", source = "-- 存储图像信息，用于界面找色、找图。取代图片搜索，因为找色搜索的像素点更少\
local imgBase = require './img'\
\
local transRelativePoint = imgBase.transRelativePoint\
\
return {\
  transRelativePoint = transRelativePoint,\
  -- 基本方法\
  toPoint = imgBase.toPoint,\
  -- 过滤被右下角按钮挡住的部分的点，因为右下角按钮也是黑色的容易与边界识别混淆\
  filterNoUsePoint = imgBase.filterNoUsePoint,\
  -- 图片数据\
  -- 地图扫描\
  map = {\
    -- 地图上边界\
    topLineList = {\
      -- 1-8的上边\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022, }\
        local basePoint, posandcolor = transRelativePoint({\
          { 1552, 151, 0x212829 }, { 1568, 151, 0x101419 },\
          { 1577, 151, 0x212429 }, { 1592, 151, 0x101819 },\
          { 1598, 152, 0x6b75b5 }, { 1586, 152, 0x6b75ad },\
          { 1565, 152, 0x6b6dad }, { 1546, 152, 0x6b71b5 },\
        })\
        return { basePoint[3], posandcolor, 92, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
      -- 1-8的上边\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022, }\
        local basePoint, posandcolor = transRelativePoint({\
          { 1254, 730, 0x211421 }, { 1271, 730, 0x100c19 },\
          { 1286, 730, 0x211421 }, { 1303, 730, 0x101019 },\
          { 1317, 731, 0x6b71ad }, { 1294, 731, 0x636da4 },\
          { 1276, 731, 0x63699c }, { 1256, 731, 0x63699c },\
        })\
        return { basePoint[3], posandcolor, 92, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
      -- 1-7的上边\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022, }\
        local basePoint, posandcolor = transRelativePoint({\
          { 1421, 490, 0x191c21 }, { 1438, 490, 0x191c29 },\
          { 1456, 490, 0x211c29 }, { 1471, 490, 0x191c29 },\
          { 1485, 491, 0x525d94 }, { 1459, 491, 0x52558c },\
          { 1437, 491, 0x4a5184 }, { 1413, 491, 0x4a5184 },\
        })\
        return { basePoint[3], posandcolor, 92, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
      -- 1-4的上边\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022, }\
        local basePoint, posandcolor = transRelativePoint({\
          { 954, 490, 0x191421 }, { 968, 490, 0x191421 },\
          { 981, 490, 0x101419 }, { 998, 490, 0x191821 },\
          { 1008, 491, 0x313563 }, { 995, 491, 0x423963 },\
          { 979, 491, 0x423563 }, { 960, 491, 0x31315a },\
        })\
        return { basePoint[3], posandcolor, 92, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
    },\
    -- 地图下边界\
    bottonLineList = {\
      -- 6-1 的下面\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022 }\
        local basePoint, posandcolor = transRelativePoint({\
          { 558, 925, 0x000000 }, { 581, 925, 0x000000 },\
          { 601, 925, 0x000000 }, { 619, 925, 0x000000 },\
          { 635, 924, 0x29204a }, { 613, 924, 0x212042 },\
          { 592, 924, 0x29204a }, { 571, 924, 0x212042 },\
        })\
        return { basePoint[3], posandcolor, 95, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
      -- 6-3 的下面\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022 }\
        local basePoint, posandcolor = transRelativePoint({\
          { 982, 925, 0x000000 }, { 997, 925, 0x000000 },\
          { 1015, 925, 0x000000 }, { 1035, 925, 0x000000 },\
          { 1055, 924, 0x31244a }, { 1035, 924, 0x31244a },\
          { 1013, 924, 0x31244a }, { 987, 924, 0x312452 },\
        })\
        return { basePoint[3], posandcolor, 95, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
      -- 6-5 的下面\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022 }\
        local basePoint, posandcolor = transRelativePoint({\
          { 992, 931, 0x000000 }, { 1015, 931, 0x000000 },\
          { 1029, 931, 0x000000 }, { 1044, 931, 0x000000 },\
          { 1058, 930, 0x312852 }, { 1040, 930, 0x312452 },\
          { 1017, 930, 0x31244a }, { 996, 930, 0x312452 },\
        })\
        return { basePoint[3], posandcolor, 95, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
    },\
    -- 地图左边界\
    leftLineList = {\
      -- 1-1 的左边\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022, }\
        local basePoint, posandcolor = transRelativePoint({\
          { 404, 514, 0x000000 }, { 405, 514, 0x31285a },\
          { 404, 513, 0x000000 }, { 405, 513, 0x31315a },\
          { 403, 515, 0x000000 }, { 404, 515, 0x292852 },\
          { 403, 516, 0x000000 }, { 404, 516, 0x312d5a },\
        })\
        return { basePoint[3], posandcolor, 95, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
      -- 1-3 的左边\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022, }\
        local basePoint, posandcolor = transRelativePoint({\
          { 359, 760, 0x000000 }, { 360, 760, 0x312d5a },\
          { 359, 759, 0x000000 }, { 360, 759, 0x292d52 },\
          { 358, 761, 0x000000 }, { 359, 761, 0x313152 },\
          { 358, 762, 0x000000 }, { 359, 762, 0x312d52 },\
        })\
        return { basePoint[3], posandcolor, 95, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
    },\
    -- 地图右边界\
    rightLineList = {\
      -- 1-8 的右边\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022, }\
        local basePoint, posandcolor = transRelativePoint({\
          { 1609, 158, 0x000000 }, { 1608, 158, 0x6b71b5 },\
          { 1609, 157, 0x000000 }, { 1608, 157, 0x6369ad },\
          { 1610, 159, 0x000000 }, { 1609, 159, 0x6b71b5 },\
          { 1610, 160, 0x080408 }, { 1609, 160, 0x6b71b5 },\
        })\
        return { basePoint[3], posandcolor, 95, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
      -- 1-8 的右边\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022, }\
        local basePoint, posandcolor = transRelativePoint({\
          { 1358, 736, 0x000000 }, { 1357, 736, 0x6b71ad },\
          { 1358, 735, 0x000000 }, { 1357, 735, 0x6b71ad },\
          { 1359, 737, 0x000000 }, { 1358, 737, 0x636d9c },\
          { 1359, 738, 0x000000 }, { 1358, 738, 0x6b71b5 },\
        })\
        return { basePoint[3], posandcolor, 95, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
      -- 3-8 的右边\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022, }\
        local basePoint, posandcolor = transRelativePoint({\
          { 1682, 460, 0x000000 }, { 1681, 460, 0x4a417b },\
          { 1682, 459, 0x000000 }, { 1681, 459, 0x4a417b },\
          { 1683, 461, 0x000000 }, { 1682, 461, 0x423d7b },\
          { 1683, 462, 0x000000 }, { 1682, 462, 0x4a417b },\
        })\
        return { basePoint[3], posandcolor, 95, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
      -- 4-8 的右边\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022, }\
        local basePoint, posandcolor = transRelativePoint({\
          { 1702, 542, 0x000000 }, { 1701, 542, 0x423d73 },\
          { 1702, 541, 0x000000 }, { 1701, 541, 0x42417b },\
          { 1703, 543, 0x000000 }, { 1702, 543, 0x423d73 },\
          { 1703, 544, 0x000000 }, { 1702, 544, 0x4a4173 },\
        })\
        return { basePoint[3], posandcolor, 95, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
      -- 6-8 的右边\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022, }\
        local basePoint, posandcolor = transRelativePoint({\
          { 1761, 786, 0x000000 }, { 1760, 786, 0x3a3563 },\
          { 1761, 785, 0x000000 }, { 1760, 785, 0x3a355a },\
          { 1762, 787, 0x000000 }, { 1761, 787, 0x3a355a },\
          { 1762, 788, 0x000000 }, { 1761, 788, 0x3a315a },\
        })\
        return { basePoint[3], posandcolor, 95, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
    },\
    -- 我方舰队位置\
    myFleetList = imgBase.map.myFleetList,\
    -- 我放舰队被选中的舰队的绿色的选中箭头的位置\
    selectedArrow = imgBase.map.selectedArrow,\
    -- 敌方舰队位置(小型舰队)\
    enemyList1 = imgBase.map.enemyList1,\
    -- 敌方舰队位置(中型舰队)\
    enemyList2 = imgBase.map.enemyList2,\
    -- 敌方舰队位置(大型舰队)\
    enemyList3 = imgBase.map.enemyList3,\
    -- boss位置\
    bossPointList = imgBase.map.bossPointList,\
    -- 战斗中的位置\
    inBattleList = imgBase.map.inBattleList,\
    -- 奖励箱的位置\
    rewardBoxList = imgBase.map.rewardBoxList,\
  },\
}" }


package.sourceCode = package.sourceCode or {}
package.sourceCode["./meta-operation/maps-options/img6-3.lua"] = { path = "./meta-operation/maps-options/img6-3.lua", name = "./meta-operation/maps-options/img6-3.lua", source = "-- 存储图像信息，用于界面找色、找图。取代图片搜索，因为找色搜索的像素点更少\
local imgBase = require './img'\
\
local transRelativePoint = imgBase.transRelativePoint\
\
return {\
  transRelativePoint = transRelativePoint,\
  -- 基本方法\
  toPoint = imgBase.toPoint,\
  -- 过滤被右下角按钮挡住的部分的点，因为右下角按钮也是黑色的容易与边界识别混淆\
  filterNoUsePoint = imgBase.filterNoUsePoint,\
  -- 图片数据\
  -- 地图扫描\
  map = {\
    -- 地图上边界\
    topLineList = {\
      -- 1-8 的上边\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022, }\
        local basePoint, posandcolor = transRelativePoint({\
          { 1668, 513, 0x101c21 }, { 1677, 513, 0x192031 },\
          { 1685, 513, 0x192029 }, { 1692, 513, 0x101c21 },\
          { 1702, 514, 0x6b75b5 }, { 1692, 514, 0x6b75b5 },\
          { 1682, 514, 0x6b75b5 }, { 1675, 514, 0x6b6db5 },\
        })\
        return { basePoint[3], posandcolor, 95, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
      -- 1-7 的上边\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022, }\
        local basePoint, posandcolor = transRelativePoint({\
          { 1489, 513, 0x191819 }, { 1499, 513, 0x192029 },\
          { 1512, 513, 0x212429 }, { 1522, 513, 0x192429 },\
          { 1533, 514, 0x5a699c }, { 1521, 514, 0x5a659c },\
          { 1512, 514, 0x6369a4 }, { 1499, 514, 0x5a619c },\
        })\
        return { basePoint[3], posandcolor, 95, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
      -- 1-6 的上边\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022, }\
        local basePoint, posandcolor = transRelativePoint({\
          { 1218, 513, 0x101819 }, { 1229, 513, 0x191c29 },\
          { 1244, 513, 0x191821 }, { 1259, 513, 0x192029 },\
          { 1269, 514, 0x3a396b }, { 1257, 514, 0x3a396b },\
          { 1240, 514, 0x3a3d6b }, { 1231, 514, 0x3a3d6b },\
        })\
        return { basePoint[3], posandcolor, 95, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
      -- 1-5 的上边\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022, }\
        local basePoint, posandcolor = transRelativePoint({\
          { 1066, 513, 0x191821 }, { 1078, 513, 0x101821 },\
          { 1091, 513, 0x191c29 }, { 1107, 513, 0x191821 },\
          { 1117, 514, 0x3a4173 }, { 1103, 514, 0x42457b },\
          { 1094, 514, 0x42457b }, { 1083, 514, 0x424573 },\
        })\
        return { basePoint[3], posandcolor, 95, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
    },\
    -- 地图下边界\
    bottonLineList = {\
      -- 5-3 的下面\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022 }\
        local basePoint, posandcolor = transRelativePoint({\
          { 561, 889, 0x000000 }, { 601, 889, 0x000000 },\
          { 630, 889, 0x000000 }, { 673, 889, 0x000000 },\
          { 690, 888, 0x31244a }, { 663, 888, 0x29244a },\
          { 633, 888, 0x29244a }, { 604, 888, 0x312452 },\
        })\
        return { basePoint[3], posandcolor, 95, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
      -- 5-8 的下面\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022 }\
        local basePoint, posandcolor = transRelativePoint({\
          { 1597, 889, 0x000000 }, { 1645, 889, 0x000000 },\
          { 1683, 889, 0x000000 }, { 1719, 889, 0x000000 },\
          { 1753, 888, 0x3a315a }, { 1718, 888, 0x3a315a },\
          { 1676, 888, 0x312d52 }, { 1635, 888, 0x31284a },\
        })\
        return { basePoint[3], posandcolor, 95, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
    },\
    -- 地图左边界\
    leftLineList = {\
      -- 1-1 的左边\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022, }\
        local basePoint, posandcolor = transRelativePoint({\
          { 326, 509, 0x000000 }, { 327, 509, 0x31315a },\
          { 326, 508, 0x000000 }, { 327, 508, 0x31285a },\
          { 325, 510, 0x000000 }, { 326, 510, 0x312d5a },\
          { 325, 511, 0x000000 }, { 326, 511, 0x31285a },\
        })\
        return { basePoint[3], posandcolor, 95, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
      -- 4-1 的左边\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022, }\
        local basePoint, posandcolor = transRelativePoint({\
          { 482, 532, 0x000000 }, { 483, 532, 0x29244a },\
          { 482, 531, 0x000000 }, { 483, 531, 0x29244a },\
          { 481, 533, 0x000000 }, { 482, 533, 0x29204a },\
          { 481, 534, 0x000000 }, { 482, 534, 0x312452 },\
        })\
        return { basePoint[3], posandcolor, 95, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
      -- 6-1 的左边\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022, }\
        local basePoint, posandcolor = transRelativePoint({\
          { 435, 832, 0x000000 }, { 436, 832, 0x29204a },\
          { 435, 831, 0x000000 }, { 436, 831, 0x211c42 },\
          { 434, 833, 0x000000 }, { 435, 833, 0x212042 },\
          { 434, 834, 0x000000 }, { 435, 834, 0x212042 },\
        })\
        return { basePoint[3], posandcolor, 95, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
    },\
    -- 地图右边界\
    rightLineList = {\
      -- 1-8 的右边\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022, }\
        local basePoint, posandcolor = transRelativePoint({\
          { 1695, 524, 0x000000 }, { 1694, 524, 0x6369b5 },\
          { 1695, 523, 0x000000 }, { 1694, 523, 0x6365ad },\
          { 1696, 525, 0x000000 }, { 1695, 525, 0x6365ad },\
          { 1696, 526, 0x000000 }, { 1695, 526, 0x6365ad },\
        })\
        return { basePoint[3], posandcolor, 95, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
      -- 3-8 的右边\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022, }\
        local basePoint, posandcolor = transRelativePoint({\
          { 1546, 320, 0x000000 }, { 1545, 320, 0x4a417b },\
          { 1546, 319, 0x000000 }, { 1545, 319, 0x4a417b },\
          { 1547, 321, 0x000000 }, { 1546, 321, 0x423d7b },\
          { 1547, 322, 0x000000 }, { 1546, 322, 0x4a4184 },\
        })\
        return { basePoint[3], posandcolor, 95, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
      -- 6-8 的右边\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022, }\
        local basePoint, posandcolor = transRelativePoint({\
          { 1663, 729, 0x000000 }, { 1662, 729, 0x31355a },\
          { 1663, 728, 0x000000 }, { 1662, 728, 0x3a3563 },\
          { 1664, 730, 0x000000 }, { 1663, 730, 0x3a355a },\
          { 1664, 731, 0x000000 }, { 1663, 731, 0x423963 },\
        })\
        return { basePoint[3], posandcolor, 95, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
    },\
    -- 我方舰队位置\
    myFleetList = imgBase.map.myFleetList,\
    -- 我放舰队被选中的舰队的绿色的选中箭头的位置\
    selectedArrow = imgBase.map.selectedArrow,\
    -- 敌方舰队位置(小型舰队)\
    enemyList1 = imgBase.map.enemyList1,\
    -- 敌方舰队位置(中型舰队)\
    enemyList2 = imgBase.map.enemyList2,\
    -- 敌方舰队位置(大型舰队)\
    enemyList3 = imgBase.map.enemyList3,\
    -- boss位置\
    bossPointList = imgBase.map.bossPointList,\
    -- 战斗中的位置\
    inBattleList = imgBase.map.inBattleList,\
    -- 奖励箱的位置\
    rewardBoxList = imgBase.map.rewardBoxList,\
  },\
}" }


package.sourceCode = package.sourceCode or {}
package.sourceCode["./meta-operation/maps-options/img6-2.lua"] = { path = "./meta-operation/maps-options/img6-2.lua", name = "./meta-operation/maps-options/img6-2.lua", source = "-- 存储图像信息，用于界面找色、找图。取代图片搜索，因为找色搜索的像素点更少\
local imgBase = require './img'\
\
local transRelativePoint = imgBase.transRelativePoint\
\
return {\
  transRelativePoint = transRelativePoint,\
  -- 基本方法\
  toPoint = imgBase.toPoint,\
  -- 过滤被右下角按钮挡住的部分的点，因为右下角按钮也是黑色的容易与边界识别混淆\
  filterNoUsePoint = imgBase.filterNoUsePoint,\
  -- 图片数据\
  -- 地图扫描\
  map = {\
    -- 地图上边界\
    topLineList = {\
      -- 1-8 的上边\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022, }\
        local basePoint, posandcolor = transRelativePoint({\
          { 1665, 473, 0x21313a }, { 1677, 473, 0x213542 },\
          { 1685, 473, 0x213142 }, { 1693, 473, 0x212d42 },\
          { 1697, 474, 0x6b75ad }, { 1687, 474, 0x6b75ad },\
          { 1678, 474, 0x6b75b5 }, { 1671, 474, 0x6b6dad },\
        })\
        return { basePoint[3], posandcolor, 92, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
      -- 1-7 的上边\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022, }\
        local basePoint, posandcolor = transRelativePoint({\
          { 1489, 513, 0x191819 }, { 1499, 513, 0x192029 },\
          { 1512, 513, 0x212429 }, { 1522, 513, 0x192429 },\
          { 1533, 514, 0x5a699c }, { 1521, 514, 0x5a659c },\
          { 1512, 514, 0x6369a4 }, { 1499, 514, 0x5a619c },\
        })\
        return { basePoint[3], posandcolor, 92, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
      -- 1-6 的上边\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022, }\
        local basePoint, posandcolor = transRelativePoint({\
          { 1218, 513, 0x101819 }, { 1229, 513, 0x191c29 },\
          { 1244, 513, 0x191821 }, { 1259, 513, 0x192029 },\
          { 1269, 514, 0x3a396b }, { 1257, 514, 0x3a396b },\
          { 1240, 514, 0x3a3d6b }, { 1231, 514, 0x3a3d6b },\
        })\
        return { basePoint[3], posandcolor, 92, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
      -- 1-5 的上边\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022, }\
        local basePoint, posandcolor = transRelativePoint({\
          { 1066, 513, 0x191821 }, { 1078, 513, 0x101821 },\
          { 1091, 513, 0x191c29 }, { 1107, 513, 0x191821 },\
          { 1117, 514, 0x3a4173 }, { 1103, 514, 0x42457b },\
          { 1094, 514, 0x42457b }, { 1083, 514, 0x424573 },\
        })\
        return { basePoint[3], posandcolor, 92, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
    },\
    -- 地图下边界\
    bottonLineList = {\
      -- 6-3 的下面\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022 }\
        local basePoint, posandcolor = transRelativePoint({\
          { 1034, 884, 0x000000 }, { 1080, 884, 0x000000 },\
          { 1140, 884, 0x000000 }, { 1183, 884, 0x000000 },\
          { 1212, 883, 0x29244a }, { 1161, 883, 0x29244a },\
          { 1117, 883, 0x29244a }, { 1075, 883, 0x31204a },\
        })\
        return { basePoint[3], posandcolor, 95, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
      -- 6-8 的下面\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022 }\
        local basePoint, posandcolor = transRelativePoint({\
          { 1486, 885, 0x000000 }, { 1546, 885, 0x000000 },\
          { 1598, 885, 0x000000 }, { 1641, 885, 0x000000 },\
          { 1669, 884, 0x3a315a }, { 1627, 884, 0x312d52 },\
          { 1584, 884, 0x312d5a }, { 1543, 884, 0x31284a },\
        })\
        return { basePoint[3], posandcolor, 95, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
    },\
    -- 地图左边界\
    leftLineList = {\
      -- 1-1 的左边\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022, }\
        local basePoint, posandcolor = transRelativePoint({\
          { 326, 509, 0x000000 }, { 327, 509, 0x31315a },\
          { 326, 508, 0x000000 }, { 327, 508, 0x31285a },\
          { 325, 510, 0x000000 }, { 326, 510, 0x312d5a },\
          { 325, 511, 0x000000 }, { 326, 511, 0x31285a },\
        })\
        return { basePoint[3], posandcolor, 95, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
      -- 4-1 的左边\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022, }\
        local basePoint, posandcolor = transRelativePoint({\
          { 482, 532, 0x000000 }, { 483, 532, 0x29244a },\
          { 482, 531, 0x000000 }, { 483, 531, 0x29244a },\
          { 481, 533, 0x000000 }, { 482, 533, 0x29204a },\
          { 481, 534, 0x000000 }, { 482, 534, 0x312452 },\
        })\
        return { basePoint[3], posandcolor, 95, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
      -- 6-1 的左边\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022, }\
        local basePoint, posandcolor = transRelativePoint({\
          { 435, 832, 0x000000 }, { 436, 832, 0x29204a },\
          { 435, 831, 0x000000 }, { 436, 831, 0x211c42 },\
          { 434, 833, 0x000000 }, { 435, 833, 0x212042 },\
          { 434, 834, 0x000000 }, { 435, 834, 0x212042 },\
        })\
        return { basePoint[3], posandcolor, 95, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
    },\
    -- 地图右边界\
    rightLineList = {\
      -- 1-8 的右边\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022, }\
        local basePoint, posandcolor = transRelativePoint({\
          { 1695, 524, 0x000000 }, { 1694, 524, 0x6369b5 },\
          { 1695, 523, 0x000000 }, { 1694, 523, 0x6365ad },\
          { 1696, 525, 0x000000 }, { 1695, 525, 0x6365ad },\
          { 1696, 526, 0x000000 }, { 1695, 526, 0x6365ad },\
        })\
        return { basePoint[3], posandcolor, 95, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
      -- 3-8 的右边\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022, }\
        local basePoint, posandcolor = transRelativePoint({\
          { 1788, 746, 0x000000 }, { 1787, 746, 0x52498c },\
          { 1788, 745, 0x000000 }, { 1787, 745, 0x52498c },\
          { 1789, 747, 0x000000 }, { 1788, 747, 0x524584 },\
          { 1789, 748, 0x000000 }, { 1788, 748, 0x5a498c },\
        })\
        return { basePoint[3], posandcolor, 95, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
      -- 6-8 的右边\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022, }\
        local basePoint, posandcolor = transRelativePoint({\
          { 1663, 729, 0x000000 }, { 1662, 729, 0x31355a },\
          { 1663, 728, 0x000000 }, { 1662, 728, 0x3a3563 },\
          { 1664, 730, 0x000000 }, { 1663, 730, 0x3a355a },\
          { 1664, 731, 0x000000 }, { 1663, 731, 0x423963 },\
        })\
        return { basePoint[3], posandcolor, 95, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
    },\
    -- 我方舰队位置\
    myFleetList = imgBase.map.myFleetList,\
    -- 我放舰队被选中的舰队的绿色的选中箭头的位置\
    selectedArrow = imgBase.map.selectedArrow,\
    -- 敌方舰队位置(小型舰队)\
    enemyList1 = imgBase.map.enemyList1,\
    -- 敌方舰队位置(中型舰队)\
    enemyList2 = imgBase.map.enemyList2,\
    -- 敌方舰队位置(大型舰队)\
    enemyList3 = imgBase.map.enemyList3,\
    -- boss位置\
    bossPointList = imgBase.map.bossPointList,\
    -- 战斗中的位置\
    inBattleList = imgBase.map.inBattleList,\
    -- 奖励箱的位置\
    rewardBoxList = imgBase.map.rewardBoxList,\
  },\
}" }


package.sourceCode = package.sourceCode or {}
package.sourceCode["./meta-operation/maps-options/img6-1.lua"] = { path = "./meta-operation/maps-options/img6-1.lua", name = "./meta-operation/maps-options/img6-1.lua", source = "-- 存储图像信息，用于界面找色、找图。取代图片搜索，因为找色搜索的像素点更少\
local imgBase = require './img'\
\
local transRelativePoint = imgBase.transRelativePoint\
\
return {\
  transRelativePoint = transRelativePoint,\
  -- 基本方法\
  toPoint = imgBase.toPoint,\
  -- 过滤被右下角按钮挡住的部分的点，因为右下角按钮也是黑色的容易与边界识别混淆\
  filterNoUsePoint = imgBase.filterNoUsePoint,\
  -- 图片数据\
  -- 地图扫描\
  map = {\
    -- 地图上边界\
    topLineList = {\
      -- 1-8的上边\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022, }\
        local basePoint, posandcolor = transRelativePoint({\
          { 1617, 488, 0x100c19 }, { 1635, 488, 0x110d19 },\
          { 1657, 488, 0x110d19 }, { 1680, 488, 0x111119 },\
          { 1701, 489, 0x6b71b5 }, { 1677, 489, 0x636db5 },\
          { 1656, 489, 0x636dad }, { 1629, 489, 0x6371b5 },\
        })\
        return { basePoint[3], posandcolor, 95, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
      -- 1-7 的上边\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022, }\
        local basePoint, posandcolor = transRelativePoint({\
          { 1469, 488, 0x111019 }, { 1490, 488, 0x101019 },\
          { 1514, 488, 0x111019 }, { 1539, 488, 0x080c19 },\
          { 1553, 489, 0x5a65a4 }, { 1531, 489, 0x5a619c },\
          { 1512, 489, 0x525d94 }, { 1487, 489, 0x4a558c },\
        })\
        return { basePoint[3], posandcolor, 95, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
      -- 1-6 的上边\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022, }\
        local basePoint, posandcolor = transRelativePoint({\
          { 1107, 488, 0x101419 }, { 1127, 488, 0x111421 },\
          { 1152, 488, 0x191421 }, { 1170, 488, 0x191421 },\
          { 1183, 489, 0x424173 }, { 1163, 489, 0x424173 },\
          { 1139, 489, 0x424573 }, { 1117, 489, 0x424d7b },\
        })\
        return { basePoint[3], posandcolor, 95, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
      -- 1-4的上边\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022, }\
        local basePoint, posandcolor = transRelativePoint({\
          { 946, 488, 0x101019 }, { 967, 488, 0x101019 },\
          { 990, 488, 0x191421 }, { 1009, 488, 0x101019 },\
          { 1021, 489, 0x423963 }, { 995, 489, 0x3a3563 },\
          { 974, 489, 0x31315a }, { 954, 489, 0x31315a },\
        })\
        return { basePoint[3], posandcolor, 95, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
    },\
    -- 地图下边界\
    bottonLineList = {\
      -- 5-3 的下面\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022 }\
        local basePoint, posandcolor = transRelativePoint({\
          { 860, 883, 0x000000 }, { 890, 883, 0x000000 },\
          { 932, 883, 0x000000 }, { 974, 883, 0x000000 },\
          { 1000, 882, 0x31244a }, { 961, 882, 0x29244a },\
          { 924, 882, 0x312452 }, { 877, 882, 0x31244a },\
        })\
        return { basePoint[3], posandcolor, 95, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
      -- 5-8 的下面\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022 }\
        local basePoint, posandcolor = transRelativePoint({\
          { 1525, 886, 0x000000 }, { 1581, 886, 0x000000 },\
          { 1630, 886, 0x000000 }, { 1682, 886, 0x000000 },\
          { 1711, 885, 0x3a395a }, { 1664, 885, 0x312d52 },\
          { 1623, 885, 0x313152 }, { 1579, 885, 0x31314a },\
        })\
        return { basePoint[3], posandcolor, 95, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
    },\
    -- 地图左边界\
    leftLineList = {\
      -- 1-1 的左边\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022, }\
        local basePoint, posandcolor = transRelativePoint({\
          { 326, 509, 0x000000 }, { 327, 509, 0x31315a },\
          { 326, 508, 0x000000 }, { 327, 508, 0x31285a },\
          { 325, 510, 0x000000 }, { 326, 510, 0x312d5a },\
          { 325, 511, 0x000000 }, { 326, 511, 0x31285a },\
        })\
        return { basePoint[3], posandcolor, 95, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
    },\
    -- 地图右边界\
    rightLineList = {\
      -- 1-8 的右边\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022, }\
        local basePoint, posandcolor = transRelativePoint({\
          { 1695, 524, 0x000000 }, { 1694, 524, 0x6369b5 },\
          { 1695, 523, 0x000000 }, { 1694, 523, 0x6365ad },\
          { 1696, 525, 0x000000 }, { 1695, 525, 0x6365ad },\
          { 1696, 526, 0x000000 }, { 1695, 526, 0x6365ad },\
        })\
        return { basePoint[3], posandcolor, 95, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
      -- 3-8 的右边\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022, }\
        local basePoint, posandcolor = transRelativePoint({\
          { 1546, 320, 0x000000 }, { 1545, 320, 0x4a417b },\
          { 1546, 319, 0x000000 }, { 1545, 319, 0x4a417b },\
          { 1547, 321, 0x000000 }, { 1546, 321, 0x423d7b },\
          { 1547, 322, 0x000000 }, { 1546, 322, 0x4a4184 },\
        })\
        return { basePoint[3], posandcolor, 95, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
    },\
    -- 我方舰队位置\
    myFleetList = imgBase.map.myFleetList,\
    -- 我放舰队被选中的舰队的绿色的选中箭头的位置\
    selectedArrow = imgBase.map.selectedArrow,\
    -- 敌方舰队位置(小型舰队)\
    enemyList1 = imgBase.map.enemyList1,\
    -- 敌方舰队位置(中型舰队)\
    enemyList2 = imgBase.map.enemyList2,\
    -- 敌方舰队位置(大型舰队)\
    enemyList3 = imgBase.map.enemyList3,\
    -- boss位置\
    bossPointList = imgBase.map.bossPointList,\
    -- 战斗中的位置\
    inBattleList = imgBase.map.inBattleList,\
    -- 奖励箱的位置\
    rewardBoxList = imgBase.map.rewardBoxList,\
  },\
}" }


package.sourceCode = package.sourceCode or {}
package.sourceCode["./meta-operation/maps-options/img5-4.lua"] = { path = "./meta-operation/maps-options/img5-4.lua", name = "./meta-operation/maps-options/img5-4.lua", source = "-- 存储图像信息，用于界面找色、找图。取代图片搜索，因为找色搜索的像素点更少\
local imgBase = require './img'\
\
local transRelativePoint = imgBase.transRelativePoint\
\
return {\
  transRelativePoint = transRelativePoint,\
  -- 基本方法\
  toPoint = imgBase.toPoint,\
  -- 过滤被右下角按钮挡住的部分的点，因为右下角按钮也是黑色的容易与边界识别混淆\
  filterNoUsePoint = imgBase.filterNoUsePoint,\
  -- 图片数据\
  -- 地图扫描\
  map = {\
    -- 地图上边界\
    topLineList = {\
      -- 1-5的上边\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022, }\
        local basePoint, posandcolor = transRelativePoint({\
          { 889, 467, 0x213142 }, { 927, 467, 0x213142 },\
          { 967, 467, 0x213542 }, { 1007, 467, 0x213542 },\
          { 1022, 468, 0x31bade }, { 979, 468, 0x42ceef },\
          { 941, 468, 0x31b6de }, { 900, 468, 0x3ab6de },\
        })\
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
      -- 1-7的上边\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022, }\
        local basePoint, posandcolor = transRelativePoint({\
          { 1422, 467, 0x293942 }, { 1459, 467, 0x29414a },\
          { 1502, 467, 0x293942 }, { 1534, 467, 0x293942 },\
          { 1556, 468, 0x3ac6de }, { 1517, 468, 0x3ac6de },\
          { 1476, 468, 0x3acade }, { 1441, 468, 0x3ac6de },\
        })\
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
    },\
    -- 地图下边界\
    bottonLineList = {\
      -- 5-2 的下面\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022 }\
        local basePoint, posandcolor = transRelativePoint({\
          { 614, 884, 0x000000 }, { 660, 884, 0x000000 },\
          { 693, 884, 0x000000 }, { 726, 884, 0x000000 },\
          { 751, 883, 0x2171b5 }, { 701, 883, 0x2175bd },\
          { 674, 883, 0x1971b5 }, { 630, 883, 0x1971b5 },\
        })\
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
      -- 6-6 的下面\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022 }\
        local basePoint, posandcolor = transRelativePoint({\
          { 1109, 881, 0x000000 }, { 1158, 881, 0x000000 },\
          { 1207, 881, 0x000000 }, { 1242, 881, 0x000000 },\
          { 1265, 880, 0x1959ac }, { 1219, 880, 0x1059ac },\
          { 1166, 880, 0x195db4 }, { 1128, 880, 0x1959ac },\
        })\
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
    },\
    -- 地图左边界\
    leftLineList = {\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022, }\
        local basePoint, posandcolor = transRelativePoint({\
          { 273, 608, 0x000000 }, { 274, 608, 0x31aede },\
          { 273, 607, 0x000000 }, { 274, 607, 0x29aade },\
          { 272, 609, 0x000000 }, { 273, 609, 0x31aede },\
          { 272, 610, 0x000000 }, { 273, 610, 0x29aede },\
        })\
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
    },\
    -- 地图右边界\
    rightLineList = {\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022, }\
        local basePoint, posandcolor = transRelativePoint({\
          { 1722, 752, 0x000000 }, { 1721, 752, 0x29b2de },\
          { 1722, 751, 0x000000 }, { 1721, 751, 0x29b6de },\
          { 1723, 753, 0x000000 }, { 1722, 753, 0x21b2de },\
          { 1723, 754, 0x000000 }, { 1722, 754, 0x29b6e6 },\
        })\
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
    },\
    -- 我方舰队位置\
    myFleetList = imgBase.map.myFleetList,\
    -- 我放舰队被选中的舰队的绿色的选中箭头的位置\
    selectedArrow = imgBase.map.selectedArrow,\
    -- 敌方舰队位置(小型舰队)\
    enemyList1 = imgBase.map.enemyList1,\
    -- 敌方舰队位置(中型舰队)\
    enemyList2 = imgBase.map.enemyList2,\
    -- 敌方舰队位置(大型舰队)\
    enemyList3 = imgBase.map.enemyList3,\
    -- boss位置\
    bossPointList = imgBase.map.bossPointList,\
    -- 战斗中的位置\
    inBattleList = imgBase.map.inBattleList,\
    -- 奖励箱的位置\
    rewardBoxList = imgBase.map.rewardBoxList,\
  },\
}" }


package.sourceCode = package.sourceCode or {}
package.sourceCode["./meta-operation/maps-options/img5-3.lua"] = { path = "./meta-operation/maps-options/img5-3.lua", name = "./meta-operation/maps-options/img5-3.lua", source = "-- 存储图像信息，用于界面找色、找图。取代图片搜索，因为找色搜索的像素点更少\
local imgBase = require './img'\
\
local transRelativePoint = imgBase.transRelativePoint\
\
return {\
  transRelativePoint = transRelativePoint,\
  -- 基本方法\
  toPoint = imgBase.toPoint,\
  -- 过滤被右下角按钮挡住的部分的点，因为右下角按钮也是黑色的容易与边界识别混淆\
  filterNoUsePoint = imgBase.filterNoUsePoint,\
  -- 图片数据\
  -- 地图扫描\
  map = {\
    -- 地图上边界\
    topLineList = {\
      -- 1-1的上边\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022, }\
        local basePoint, posandcolor = transRelativePoint({\
          { 474, 477, 0x193d21 }, { 483, 477, 0x214531 },\
          { 495, 477, 0x214131 }, { 505, 477, 0x29493a },\
          { 513, 478, 0x299ede }, { 500, 478, 0x319edd },\
          { 489, 478, 0x299ede }, { 478, 478, 0x319ee6 },\
        })\
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
      -- 1-4的上边\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022, }\
        local basePoint, posandcolor = transRelativePoint({\
          { 1007, 474, 0x212d42 }, { 1015, 474, 0x212d42 },\
          { 1023, 474, 0x212d42 }, { 1032, 474, 0x21354a },\
          { 1044, 475, 0x29b6de }, { 1033, 475, 0x31bade },\
          { 1022, 475, 0x31bade }, { 1009, 475, 0x31bede },\
        })\
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
      -- 1-7的上边\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022, }\
        local basePoint, posandcolor = transRelativePoint({\
          { 1505, 474, 0x213542 }, { 1512, 474, 0x293d4a },\
          { 1519, 474, 0x21354a }, { 1526, 474, 0x313d4a },\
          { 1534, 475, 0x31bade }, { 1526, 475, 0x31bede },\
          { 1516, 475, 0x31bede }, { 1509, 475, 0x3ac2de },\
        })\
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
    },\
    -- 地图下边界\
    bottonLineList = {\
      -- 5-1 的下面\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022 }\
        local basePoint, posandcolor = transRelativePoint({\
          { 422, 850, 0x010203 }, { 433, 850, 0x010203 },\
          { 445, 850, 0x010203 }, { 455, 850, 0x010203 },\
          { 468, 849, 0x217ebd }, { 456, 849, 0x217ebd },\
          { 444, 849, 0x2181c5 }, { 433, 849, 0x2985c5 },\
        })\
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
      -- 5-7 的下面\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022 }\
        local basePoint, posandcolor = transRelativePoint({\
          { 1109, 881, 0x000000 }, { 1158, 881, 0x000000 },\
          { 1207, 881, 0x000000 }, { 1242, 881, 0x000000 },\
          { 1265, 880, 0x1959ac }, { 1219, 880, 0x1059ac },\
          { 1166, 880, 0x195db4 }, { 1128, 880, 0x1959ac },\
        })\
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
    },\
    -- 地图左边界\
    leftLineList = {\
      -- 1-1 的左边\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022, }\
        local basePoint, posandcolor = transRelativePoint({\
          { 652, 739, 0x000000 }, { 653, 739, 0x29a2de },\
          { 652, 738, 0x000000 }, { 653, 738, 0x299ede },\
          { 651, 740, 0x000000 }, { 652, 740, 0x31a2e6 },\
          { 651, 741, 0x000000 }, { 652, 741, 0x299ede },\
        })\
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
      -- 1-1 的左边\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022, }\
        local basePoint, posandcolor = transRelativePoint({\
          { 451, 492, 0x000000 }, { 452, 492, 0x31a2de },\
          { 451, 491, 0x000000 }, { 452, 491, 0x29a2de },\
          { 450, 493, 0x000000 }, { 451, 493, 0x31a2de },\
          { 450, 494, 0x000000 }, { 451, 494, 0x29a2de },\
        })\
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
      -- 1-4 的左边\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022, }\
        local basePoint, posandcolor = transRelativePoint({\
          { 447, 536, 0x010203 }, { 448, 536, 0x4296d6 },\
          { 447, 535, 0x010203 }, { 448, 535, 0x3196ce },\
          { 446, 537, 0x010203 }, { 447, 537, 0x3993d2 },\
          { 446, 538, 0x010203 }, { 447, 538, 0x3296d6 },\
        })\
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
    },\
    -- 地图右边界\
    rightLineList = {\
      -- 7-4 的右边\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022, }\
        local basePoint, posandcolor = transRelativePoint({\
          { 1453, 623, 0x000400 }, { 1452, 623, 0x3175c5 },\
          { 1453, 622, 0x000000 }, { 1452, 622, 0x3978c2 },\
          { 1454, 624, 0x000000 }, { 1453, 624, 0x3974c2 },\
          { 1454, 625, 0x000000 }, { 1453, 625, 0x3a79c5 },\
        })\
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
    },\
    -- 我方舰队位置\
    myFleetList = imgBase.map.myFleetList,\
    -- 我放舰队被选中的舰队的绿色的选中箭头的位置\
    selectedArrow = imgBase.map.selectedArrow,\
    -- 敌方舰队位置(小型舰队)\
    enemyList1 = imgBase.map.enemyList1,\
    -- 敌方舰队位置(中型舰队)\
    enemyList2 = imgBase.map.enemyList2,\
    -- 敌方舰队位置(大型舰队)\
    enemyList3 = imgBase.map.enemyList3,\
    -- boss位置\
    bossPointList = imgBase.map.bossPointList,\
    -- 战斗中的位置\
    inBattleList = imgBase.map.inBattleList,\
    -- 奖励箱的位置\
    rewardBoxList = imgBase.map.rewardBoxList,\
  },\
}" }


package.sourceCode = package.sourceCode or {}
package.sourceCode["./meta-operation/maps-options/img5-2.lua"] = { path = "./meta-operation/maps-options/img5-2.lua", name = "./meta-operation/maps-options/img5-2.lua", source = "-- 存储图像信息，用于界面找色、找图。取代图片搜索，因为找色搜索的像素点更少\
local imgBase = require './img'\
\
local transRelativePoint = imgBase.transRelativePoint\
\
return {\
  transRelativePoint = transRelativePoint,\
  -- 基本方法\
  toPoint = imgBase.toPoint,\
  -- 过滤被右下角按钮挡住的部分的点，因为右下角按钮也是黑色的容易与边界识别混淆\
  filterNoUsePoint = imgBase.filterNoUsePoint,\
  -- 图片数据\
  -- 地图扫描\
  map = {\
    -- 地图上边界\
    topLineList = {\
      -- 1-5的上边\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022, }\
        local basePoint, posandcolor = transRelativePoint({\
          { 889, 467, 0x213142 }, { 927, 467, 0x213142 },\
          { 967, 467, 0x213542 }, { 1007, 467, 0x213542 },\
          { 1022, 468, 0x31bade }, { 979, 468, 0x42ceef },\
          { 941, 468, 0x31b6de }, { 900, 468, 0x3ab6de },\
        })\
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
      -- 1-7的上边\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022, }\
        local basePoint, posandcolor = transRelativePoint({\
          { 1422, 467, 0x293942 }, { 1459, 467, 0x29414a },\
          { 1502, 467, 0x293942 }, { 1534, 467, 0x293942 },\
          { 1556, 468, 0x3ac6de }, { 1517, 468, 0x3ac6de },\
          { 1476, 468, 0x3acade }, { 1441, 468, 0x3ac6de },\
        })\
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
    },\
    -- 地图下边界\
    bottonLineList = {\
      -- 5-2 的下面\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022 }\
        local basePoint, posandcolor = transRelativePoint({\
          { 614, 884, 0x000000 }, { 660, 884, 0x000000 },\
          { 693, 884, 0x000000 }, { 726, 884, 0x000000 },\
          { 751, 883, 0x2171b5 }, { 701, 883, 0x2175bd },\
          { 674, 883, 0x1971b5 }, { 630, 883, 0x1971b5 },\
        })\
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
      -- 6-6 的下面\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022 }\
        local basePoint, posandcolor = transRelativePoint({\
          { 1109, 881, 0x000000 }, { 1158, 881, 0x000000 },\
          { 1207, 881, 0x000000 }, { 1242, 881, 0x000000 },\
          { 1265, 880, 0x1959ac }, { 1219, 880, 0x1059ac },\
          { 1166, 880, 0x195db4 }, { 1128, 880, 0x1959ac },\
        })\
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
    },\
    -- 地图左边界\
    leftLineList = {\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022, }\
        local basePoint, posandcolor = transRelativePoint({\
          { 273, 608, 0x000000 }, { 274, 608, 0x31aede },\
          { 273, 607, 0x000000 }, { 274, 607, 0x29aade },\
          { 272, 609, 0x000000 }, { 273, 609, 0x31aede },\
          { 272, 610, 0x000000 }, { 273, 610, 0x29aede },\
        })\
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
    },\
    -- 地图右边界\
    rightLineList = {\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022, }\
        local basePoint, posandcolor = transRelativePoint({\
          { 1722, 752, 0x000000 }, { 1721, 752, 0x29b2de },\
          { 1722, 751, 0x000000 }, { 1721, 751, 0x29b6de },\
          { 1723, 753, 0x000000 }, { 1722, 753, 0x21b2de },\
          { 1723, 754, 0x000000 }, { 1722, 754, 0x29b6e6 },\
        })\
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
    },\
    -- 我方舰队位置\
    myFleetList = imgBase.map.myFleetList,\
    -- 我放舰队被选中的舰队的绿色的选中箭头的位置\
    selectedArrow = imgBase.map.selectedArrow,\
    -- 敌方舰队位置(小型舰队)\
    enemyList1 = imgBase.map.enemyList1,\
    -- 敌方舰队位置(中型舰队)\
    enemyList2 = imgBase.map.enemyList2,\
    -- 敌方舰队位置(大型舰队)\
    enemyList3 = imgBase.map.enemyList3,\
    -- boss位置\
    bossPointList = imgBase.map.bossPointList,\
    -- 战斗中的位置\
    inBattleList = imgBase.map.inBattleList,\
    -- 奖励箱的位置\
    rewardBoxList = imgBase.map.rewardBoxList,\
  },\
}" }


package.sourceCode = package.sourceCode or {}
package.sourceCode["./meta-operation/maps-options/img5-1.lua"] = { path = "./meta-operation/maps-options/img5-1.lua", name = "./meta-operation/maps-options/img5-1.lua", source = "-- 存储图像信息，用于界面找色、找图。取代图片搜索，因为找色搜索的像素点更少\
local imgBase = require './img'\
\
local transRelativePoint = imgBase.transRelativePoint\
\
return {\
  transRelativePoint = transRelativePoint,\
  -- 基本方法\
  toPoint = imgBase.toPoint,\
  -- 过滤被右下角按钮挡住的部分的点，因为右下角按钮也是黑色的容易与边界识别混淆\
  filterNoUsePoint = imgBase.filterNoUsePoint,\
  -- 图片数据\
  -- 地图扫描\
  map = {\
    -- 地图上边界\
    topLineList = {\
      -- 1-1的上边\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022, }\
        local basePoint, posandcolor = transRelativePoint({\
          { 700, 516, 0x314254 }, { 712, 516, 0x313e4c },\
          { 728, 516, 0x394654 }, { 742, 516, 0x314654 },\
          { 744, 517, 0x299ede }, { 728, 517, 0x299ede },\
          { 712, 517, 0x299ede }, { 698, 517, 0x299ed6 },\
        })\
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
      -- 1-2的上边\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022, }\
        local basePoint, posandcolor = transRelativePoint({\
          { 875, 516, 0x213344 }, { 884, 516, 0x313b4c },\
          { 897, 516, 0x213744 }, { 913, 516, 0x213344 },\
          { 921, 517, 0x31aede }, { 911, 517, 0x31aede },\
          { 897, 517, 0x31aede }, { 880, 517, 0x29b2d6 },\
        })\
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
      -- 1-3的上边\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022, }\
        local basePoint, posandcolor = transRelativePoint({\
          { 1042, 516, 0x4a454a }, { 1049, 516, 0x4a4542 },\
          { 1058, 516, 0x4a4542 }, { 1067, 516, 0x31393a },\
          { 1078, 517, 0x29a6de }, { 1067, 517, 0x31a6e6 },\
          { 1058, 517, 0x29a6de }, { 1049, 517, 0x31a2de },\
        })\
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
      -- 1-4的上边\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022, }\
        local basePoint, posandcolor = transRelativePoint({\
          { 1193, 516, 0x213931 }, { 1202, 516, 0x294131 },\
          { 1213, 516, 0x294131 }, { 1225, 516, 0x294131 },\
          { 1231, 517, 0x31b6de }, { 1220, 517, 0x29b2d6 },\
          { 1205, 517, 0x31b2de }, { 1196, 517, 0x31b2de },\
        })\
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
    },\
    -- 地图下边界\
    bottonLineList = {\
      -- 6-3 的下面\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022 }\
        local basePoint, posandcolor = transRelativePoint({\
          { 806, 885, 0x000000 }, { 849, 885, 0x000000 },\
          { 891, 885, 0x000000 }, { 930, 885, 0x000000 },\
          { 957, 884, 0x1965b5 }, { 916, 884, 0x1969bd },\
          { 880, 884, 0x1969b5 }, { 841, 884, 0x1969b5 },\
        })\
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
      -- 6-6 的下面\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022 }\
        local basePoint, posandcolor = transRelativePoint({\
          { 1008, 886, 0x000000 }, { 1069, 886, 0x000000 },\
          { 1115, 886, 0x000000 }, { 1151, 886, 0x000000 },\
          { 1175, 885, 0x1959ad }, { 1140, 885, 0x1055ad },\
          { 1102, 885, 0x1055ad }, { 1065, 885, 0x2155ad },\
        })\
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
    },\
    -- 地图左边界\
    leftLineList = {\
      -- 1-1 的左边\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022, }\
        local basePoint, posandcolor = transRelativePoint({\
          { 653, 555, 0x000000 }, { 654, 555, 0x29a2de },\
          { 653, 554, 0x000000 }, { 654, 554, 0x31a6de },\
          { 652, 556, 0x000000 }, { 653, 556, 0x31a2de },\
          { 652, 557, 0x000000 }, { 653, 557, 0x31a2de },\
        })\
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
      -- 6-1 的左边\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022, }\
        local basePoint, posandcolor = transRelativePoint({\
          { 611, 246, 0x010203 }, { 612, 246, 0x3197d2 },\
          { 611, 245, 0x000000 }, { 612, 245, 0x3193c2 },\
          { 610, 247, 0x000000 }, { 611, 247, 0x319ad6 },\
          { 610, 248, 0x000000 }, { 611, 248, 0x3197d3 },\
        })\
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
    },\
    -- 地图右边界\
    rightLineList = {\
      -- 5-8 的右边\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022, }\
        local basePoint, posandcolor = transRelativePoint({\
          { 1702, 545, 0x010203 }, { 1701, 545, 0x4275c5 },\
          { 1702, 544, 0x000000 }, { 1701, 544, 0x3a75c5 },\
          { 1703, 546, 0x000000 }, { 1702, 546, 0x3a79ce },\
          { 1703, 547, 0x010203 }, { 1702, 547, 0x3a75c5 },\
        })\
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
    },\
    -- 我方舰队位置\
    myFleetList = imgBase.map.myFleetList,\
    -- 我放舰队被选中的舰队的绿色的选中箭头的位置\
    selectedArrow = imgBase.map.selectedArrow,\
    -- 敌方舰队位置(小型舰队)\
    enemyList1 = imgBase.map.enemyList1,\
    -- 敌方舰队位置(中型舰队)\
    enemyList2 = imgBase.map.enemyList2,\
    -- 敌方舰队位置(大型舰队)\
    enemyList3 = imgBase.map.enemyList3,\
    -- boss位置\
    bossPointList = imgBase.map.bossPointList,\
    -- 战斗中的位置\
    inBattleList = imgBase.map.inBattleList,\
    -- 奖励箱的位置\
    rewardBoxList = imgBase.map.rewardBoxList,\
  },\
}" }


package.sourceCode = package.sourceCode or {}
package.sourceCode["./meta-operation/maps-options/img4-4.lua"] = { path = "./meta-operation/maps-options/img4-4.lua", name = "./meta-operation/maps-options/img4-4.lua", source = "-- 存储图像信息，用于界面找色、找图。取代图片搜索，因为找色搜索的像素点更少\
local imgBase = require './img'\
\
local transRelativePoint = imgBase.transRelativePoint\
\
return {\
  transRelativePoint = transRelativePoint,\
  -- 基本方法\
  toPoint = imgBase.toPoint,\
  -- 过滤被右下角按钮挡住的部分的点，因为右下角按钮也是黑色的容易与边界识别混淆\
  filterNoUsePoint = imgBase.filterNoUsePoint,\
  -- 图片数据\
  -- 地图扫描\
  map = {\
    -- 地图上边界\
    topLineList = {\
      -- 1-8的上边\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022, }\
        local basePoint, posandcolor = transRelativePoint({\
          { 1509, 501, 0x312829 }, { 1517, 501, 0x312829 },\
          { 1525, 501, 0x322929 }, { 1533, 501, 0x322929 },\
          { 1539, 502, 0xce9a6b }, { 1533, 502, 0xce9a63 },\
          { 1526, 502, 0xce9e63 }, { 1520, 502, 0xce9e63 },\
        })\
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
      -- 1-7的上边\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022, }\
        local basePoint, posandcolor = transRelativePoint({\
          { 1336, 501, 0x292421 }, { 1347, 501, 0x312429 },\
          { 1354, 501, 0x292421 }, { 1361, 501, 0x312429 },\
          { 1371, 502, 0xce9a6b }, { 1363, 502, 0xce9a73 },\
          { 1354, 502, 0xce9e73 }, { 1347, 502, 0xce9e73 },\
        })\
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
    },\
    -- 地图下边界\
    bottonLineList = {\
      -- 6-8的下边\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022 }\
        local basePoint, posandcolor = transRelativePoint({\
          { 1656, 894, 0x000000 }, { 1664, 894, 0x000000 },\
          { 1674, 894, 0x000000 }, { 1683, 894, 0x000000 },\
          { 1691, 893, 0x734d5a }, { 1682, 893, 0x73495a },\
          { 1673, 893, 0x734962 }, { 1663, 893, 0x734d63 },\
        })\
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
      -- 6-5的下边\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022 }\
        local basePoint, posandcolor = transRelativePoint({\
          { 912, 894, 0x000000 }, { 919, 894, 0x000000 },\
          { 926, 894, 0x000000 }, { 932, 894, 0x000000 },\
          { 938, 893, 0x29203a }, { 927, 893, 0x312442 },\
          { 917, 893, 0x312442 }, { 907, 893, 0x312442 },\
        })\
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
      -- 6-1的下边\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022 }\
        local basePoint, posandcolor = transRelativePoint({\
          { 512, 893, 0x000000 }, { 520, 893, 0x000000 },\
          { 530, 893, 0x000000 }, { 538, 893, 0x000000 },\
          { 545, 892, 0x3a356b }, { 537, 892, 0x3a356b },\
          { 528, 892, 0x3a396b }, { 521, 892, 0x3a396b },\
        })\
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
    },\
    -- 地图左边界\
    leftLineList = {\
      -- 4-1的左边\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022, }\
        local basePoint, posandcolor = transRelativePoint({\
          { 534, 511, 0x000000 }, { 535, 511, 0x524584 },\
          { 534, 510, 0x000000 }, { 535, 510, 0x524584 },\
          { 533, 512, 0x000000 }, { 534, 512, 0x5a4584 },\
          { 533, 513, 0x000000 }, { 534, 513, 0x524584 },\
        })\
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
      -- 6-1的左边\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022, }\
        local basePoint, posandcolor = transRelativePoint({\
          { 486, 854, 0x000000 }, { 487, 854, 0x423973 },\
          { 486, 853, 0x000000 }, { 487, 853, 0x424173 },\
          { 485, 855, 0x000000 }, { 486, 855, 0x42396b },\
          { 485, 856, 0x000000 }, { 486, 856, 0x423d73 },\
        })\
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
    },\
    -- 地图右边界\
    rightLineList = {\
      -- 1-8的右边\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022, }\
        local basePoint, posandcolor = transRelativePoint({\
          { 1648, 529, 0x000000 }, { 1647, 529, 0xce9663 },\
          { 1648, 528, 0x000000 }, { 1647, 528, 0xc59663 },\
          { 1649, 530, 0x000000 }, { 1648, 530, 0xce9663 },\
          { 1649, 531, 0x000000 }, { 1648, 531, 0xbd9663 },\
        })\
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
      -- 2-8的右边\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022, }\
        local basePoint, posandcolor = transRelativePoint({\
          { 1675, 649, 0x000000 }, { 1674, 649, 0xbd8a63 },\
          { 1675, 648, 0x000000 }, { 1674, 648, 0xc58a6b },\
          { 1676, 650, 0x000000 }, { 1675, 650, 0xbd8a6b },\
          { 1676, 651, 0x000000 }, { 1675, 651, 0xbd8a6b },\
        })\
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
      -- 6-8的右边\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022, }\
        local basePoint, posandcolor = transRelativePoint({\
          { 1731, 788, 0x000000 }, { 1730, 788, 0x84556b },\
          { 1731, 787, 0x000000 }, { 1730, 787, 0x845563 },\
          { 1732, 789, 0x000000 }, { 1731, 789, 0x845563 },\
          { 1732, 790, 0x000400 }, { 1731, 790, 0x845563 },\
        })\
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
    },\
    -- 我方舰队位置\
    myFleetList = imgBase.map.myFleetList,\
    -- 我放舰队被选中的舰队的绿色的选中箭头的位置\
    selectedArrow = imgBase.map.selectedArrow,\
    -- 敌方舰队位置(小型舰队)\
    enemyList1 = imgBase.map.enemyList1,\
    -- 敌方舰队位置(中型舰队)\
    enemyList2 = imgBase.map.enemyList2,\
    -- 敌方舰队位置(大型舰队)\
    enemyList3 = imgBase.map.enemyList3,\
    -- boss位置\
    bossPointList = imgBase.map.bossPointList,\
    -- 战斗中的位置\
    inBattleList = imgBase.map.inBattleList,\
    -- 奖励箱的位置\
    rewardBoxList = imgBase.map.rewardBoxList,\
  },\
}" }


package.sourceCode = package.sourceCode or {}
package.sourceCode["./meta-operation/maps-options/img4-3.lua"] = { path = "./meta-operation/maps-options/img4-3.lua", name = "./meta-operation/maps-options/img4-3.lua", source = "-- 存储图像信息，用于界面找色、找图。取代图片搜索，因为找色搜索的像素点更少\
local imgBase = require './img'\
\
local transRelativePoint = imgBase.transRelativePoint\
\
return {\
  transRelativePoint = transRelativePoint,\
  -- 基本方法\
  toPoint = imgBase.toPoint,\
  -- 过滤被右下角按钮挡住的部分的点，因为右下角按钮也是黑色的容易与边界识别混淆\
  filterNoUsePoint = imgBase.filterNoUsePoint,\
  -- 图片数据\
  -- 地图扫描\
  map = {\
    -- 地图上边界\
    topLineList = {\
      -- 1-7的上边\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022, }\
        local basePoint, posandcolor = transRelativePoint({\
          { 1484, 594, 0x212431 }, { 1490, 594, 0x292431 },\
          { 1500, 594, 0x212431 }, { 1512, 594, 0x212429 },\
          { 1522, 595, 0xce9a5a }, { 1511, 595, 0xce9e6b },\
          { 1501, 595, 0xce9e63 }, { 1490, 595, 0xc59e63 },\
        })\
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
      -- 1-5的上边\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022, }\
        local basePoint, posandcolor = transRelativePoint({\
          { 1142, 594, 0x292431 }, { 1148, 594, 0x212431 },\
          { 1155, 594, 0x212029 }, { 1160, 594, 0x212431 },\
          { 1169, 595, 0xb58173 }, { 1161, 595, 0xb58173 },\
          { 1152, 595, 0xb57d73 }, { 1143, 595, 0xb58173 },\
        })\
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
      -- 1-3的上边\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022, }\
        local basePoint, posandcolor = transRelativePoint({\
          { 767, 594, 0x292431 }, { 778, 594, 0x31283a },\
          { 786, 594, 0x31283a }, { 795, 594, 0x292831 },\
          { 804, 595, 0x9c6d7b }, { 795, 595, 0xa4697b },\
          { 786, 595, 0xa4697b }, { 776, 595, 0x9c657b },\
        })\
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
    },\
    -- 地图下边界\
    bottonLineList = {\
      -- 4-7的下边\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022 }\
        local basePoint, posandcolor = transRelativePoint({\
          {\
            { 1591, 888, 0x000000 }, { 1598, 888, 0x000000 },\
            { 1606, 888, 0x000000 }, { 1614, 888, 0x000000 },\
            { 1622, 887, 0x73495a }, { 1613, 887, 0x6b455a },\
            { 1606, 887, 0x623c52 }, { 1599, 887, 0x63415a },\
          }\
        })\
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
    },\
    -- 地图左边界\
    leftLineList = {\
      -- 2-1的左边\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022, }\
        local basePoint, posandcolor = transRelativePoint({\
          { 368, 791, 0x000000 }, { 369, 791, 0x524d8c },\
          { 368, 790, 0x000000 }, { 369, 790, 0x524d84 },\
          { 367, 792, 0x000000 }, { 368, 792, 0x524d8c },\
          { 367, 793, 0x000000 }, { 368, 793, 0x524984 },\
        })\
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
    },\
    -- 地图右边界\
    rightLineList = {\
      -- 1-7的右边\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022, }\
        local basePoint, posandcolor = transRelativePoint({\
          { 1639, 609, 0x000000 }, { 1638, 609, 0xbd9663 },\
          { 1639, 608, 0x000000 }, { 1638, 608, 0xce9663 },\
          { 1640, 610, 0x000000 }, { 1639, 610, 0xce9663 },\
          { 1640, 611, 0x000000 }, { 1639, 611, 0xce966b },\
        })\
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
      -- 2-7的右边\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022, }\
        local basePoint, posandcolor = transRelativePoint({\
          { 1672, 761, 0x010100 }, { 1671, 761, 0xb58e73 },\
          { 1672, 760, 0x000000 }, { 1671, 760, 0xb58e73 },\
          { 1673, 762, 0x000000 }, { 1672, 762, 0xb58e73 },\
          { 1673, 763, 0x000000 }, { 1672, 763, 0xb58a6b },\
        })\
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
    },\
    -- 我方舰队位置\
    myFleetList = imgBase.map.myFleetList,\
    -- 我放舰队被选中的舰队的绿色的选中箭头的位置\
    selectedArrow = imgBase.map.selectedArrow,\
    -- 敌方舰队位置(小型舰队)\
    enemyList1 = imgBase.map.enemyList1,\
    -- 敌方舰队位置(中型舰队)\
    enemyList2 = imgBase.map.enemyList2,\
    -- 敌方舰队位置(大型舰队)\
    enemyList3 = imgBase.map.enemyList3,\
    -- boss位置\
    bossPointList = imgBase.map.bossPointList,\
    -- 战斗中的位置\
    inBattleList = imgBase.map.inBattleList,\
    -- 奖励箱的位置\
    rewardBoxList = imgBase.map.rewardBoxList,\
  },\
}" }


package.sourceCode = package.sourceCode or {}
package.sourceCode["./meta-operation/maps-options/img4-2.lua"] = { path = "./meta-operation/maps-options/img4-2.lua", name = "./meta-operation/maps-options/img4-2.lua", source = "-- 存储图像信息，用于界面找色、找图。取代图片搜索，因为找色搜索的像素点更少\
local imgBase = require './img'\
\
local transRelativePoint = imgBase.transRelativePoint\
\
return {\
  transRelativePoint = transRelativePoint,\
  -- 基本方法\
  toPoint = imgBase.toPoint,\
  -- 过滤被右下角按钮挡住的部分的点，因为右下角按钮也是黑色的容易与边界识别混淆\
  filterNoUsePoint = imgBase.filterNoUsePoint,\
  -- 图片数据\
  -- 地图扫描\
  map = {\
    -- 地图上边界\
    topLineList = {\
      -- 1-4的上边\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022, }\
        local basePoint, posandcolor = transRelativePoint({\
          { 1025, 490, 0x313129 }, { 1082, 490, 0x292431 },\
          { 1120, 490, 0x212031 }, { 1144, 490, 0x212031 },\
          { 1138, 491, 0xbd8a73 }, { 1099, 491, 0xb58173 },\
          { 1063, 491, 0xb58173 }, { 1029, 491, 0xb58673 },\
        })\
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
      -- 1-5的上边\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022, }\
        local basePoint, posandcolor = transRelativePoint({\
          { 1176, 490, 0x212431 }, { 1209, 490, 0x212029 },\
          { 1251, 490, 0x212031 }, { 1299, 490, 0x212031 },\
          { 1317, 491, 0xce9e6b }, { 1290, 491, 0xc59a6b },\
          { 1245, 491, 0xce9a73 }, { 1201, 491, 0xc59673 },\
        })\
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
      -- 1-6的上边\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022, }\
        local basePoint, posandcolor = transRelativePoint({\
          { 1344, 490, 0x312d31 }, { 1379, 490, 0x292831 },\
          { 1418, 490, 0x31283a }, { 1465, 490, 0x313131 },\
          { 1486, 491, 0xc59663 }, { 1438, 491, 0xce9a63 },\
          { 1399, 491, 0xce9e63 }, { 1357, 491, 0xce9e6b },\
        })\
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
    },\
    -- 地图下边界\
    bottonLineList = {\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022 }\
        local basePoint, posandcolor = transRelativePoint({\
          { 449, 899, 0x000000 }, { 466, 899, 0x000000 },\
          { 494, 899, 0x000000 }, { 527, 899, 0x000000 },\
          { 547, 898, 0x312d52 }, { 518, 898, 0x3a2d5a },\
          { 479, 898, 0x3a315a }, { 453, 898, 0x3a3563 },\
        })\
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
    },\
    -- 地图左边界\
    leftLineList = {\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022, }\
        local basePoint, posandcolor = transRelativePoint({\
          { 483, 288, 0x000001 }, { 484, 288, 0x5a518c },\
          { 483, 287, 0x000000 }, { 484, 287, 0x524d84 },\
          { 482, 289, 0x000000 }, { 483, 289, 0x525184 },\
          { 482, 290, 0x000000 }, { 483, 290, 0x525184 },\
        })\
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
    },\
    -- 地图右边界\
    rightLineList = {\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022, }\
        local basePoint, posandcolor = transRelativePoint({\
          { 1586, 348, 0x010000 }, { 1585, 348, 0xb5816b },\
          { 1586, 347, 0x000000 }, { 1585, 347, 0xb5866b },\
          { 1587, 349, 0x000000 }, { 1586, 349, 0xad7d63 },\
          { 1587, 350, 0x000000 }, { 1586, 350, 0xb5816b },\
        })\
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
    },\
    -- 我方舰队位置\
    myFleetList = imgBase.map.myFleetList,\
    -- 我放舰队被选中的舰队的绿色的选中箭头的位置\
    selectedArrow = imgBase.map.selectedArrow,\
    -- 敌方舰队位置(小型舰队)\
    enemyList1 = imgBase.map.enemyList1,\
    -- 敌方舰队位置(中型舰队)\
    enemyList2 = imgBase.map.enemyList2,\
    -- 敌方舰队位置(大型舰队)\
    enemyList3 = imgBase.map.enemyList3,\
    -- boss位置\
    bossPointList = imgBase.map.bossPointList,\
    -- 战斗中的位置\
    inBattleList = imgBase.map.inBattleList,\
    -- 奖励箱的位置\
    rewardBoxList = imgBase.map.rewardBoxList,\
  },\
}" }


package.sourceCode = package.sourceCode or {}
package.sourceCode["./meta-operation/maps-options/img4-1.lua"] = { path = "./meta-operation/maps-options/img4-1.lua", name = "./meta-operation/maps-options/img4-1.lua", source = "-- 存储图像信息，用于界面找色、找图。取代图片搜索，因为找色搜索的像素点更少\
local imgBase = require './img'\
\
local transRelativePoint = imgBase.transRelativePoint\
\
return {\
  transRelativePoint = transRelativePoint,\
  -- 基本方法\
  toPoint = imgBase.toPoint,\
  -- 过滤被右下角按钮挡住的部分的点，因为右下角按钮也是黑色的容易与边界识别混淆\
  filterNoUsePoint = imgBase.filterNoUsePoint,\
  -- 图片数据\
  -- 地图扫描\
  map = {\
    -- 地图上边界\
    topLineList = {\
      -- 1-4的上边\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022, }\
        local basePoint, posandcolor = transRelativePoint({\
          { 1025, 490, 0x313129 }, { 1082, 490, 0x292431 },\
          { 1120, 490, 0x212031 }, { 1144, 490, 0x212031 },\
          { 1138, 491, 0xbd8a73 }, { 1099, 491, 0xb58173 },\
          { 1063, 491, 0xb58173 }, { 1029, 491, 0xb58673 },\
        })\
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
      -- 1-5的上边\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022, }\
        local basePoint, posandcolor = transRelativePoint({\
          { 1176, 490, 0x212431 }, { 1209, 490, 0x212029 },\
          { 1251, 490, 0x212031 }, { 1299, 490, 0x212031 },\
          { 1317, 491, 0xce9e6b }, { 1290, 491, 0xc59a6b },\
          { 1245, 491, 0xce9a73 }, { 1201, 491, 0xc59673 },\
        })\
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
      -- 1-6的上边\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022, }\
        local basePoint, posandcolor = transRelativePoint({\
          { 1309, 488, 0x312829 }, { 1319, 488, 0x292829 },\
          { 1328, 488, 0x422831 }, { 1337, 488, 0x312831 },\
          { 1347, 489, 0xce9e63 }, { 1338, 489, 0xc59e5a },\
          { 1329, 489, 0xce9e6b }, { 1320, 489, 0xc59a6b },\
        })\
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
    },\
    -- 地图下边界\
    bottonLineList = {\
      -- 6-6的下边\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022 }\
        local basePoint, posandcolor = transRelativePoint({\
          { 1584, 889, 0x000000 }, { 1597, 889, 0x000000 },\
          { 1608, 889, 0x000000 }, { 1617, 889, 0x000000 },\
          { 1628, 888, 0x63415a }, { 1617, 888, 0x634152 },\
          { 1606, 888, 0x63415a }, { 1598, 888, 0x63415a },\
        })\
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
    },\
    -- 地图左边界\
    leftLineList = {\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022, }\
        local basePoint, posandcolor = transRelativePoint({\
          { 483, 288, 0x000001 }, { 484, 288, 0x5a518c },\
          { 483, 287, 0x000000 }, { 484, 287, 0x524d84 },\
          { 482, 289, 0x000000 }, { 483, 289, 0x525184 },\
          { 482, 290, 0x000000 }, { 483, 290, 0x525184 },\
        })\
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
    },\
    -- 地图右边界\
    rightLineList = {\
      -- 1-6的右边\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022, }\
        local basePoint, posandcolor = transRelativePoint({\
          { 1477, 546, 0x000000 }, { 1476, 546, 0xce8e63 },\
          { 1477, 545, 0x000000 }, { 1476, 545, 0xc58a63 },\
          { 1478, 547, 0x000000 }, { 1477, 547, 0xce8e63 },\
          { 1478, 548, 0x000000 }, { 1477, 548, 0xce8e63 },\
        })\
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
      -- 3-6的右边\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022, }\
        local basePoint, posandcolor = transRelativePoint({\
          { 1519, 796, 0x000000 }, { 1518, 796, 0xb5816b },\
          { 1519, 795, 0x000000 }, { 1518, 795, 0xad7963 },\
          { 1520, 797, 0x000000 }, { 1519, 797, 0xb58163 },\
          { 1520, 798, 0x000400 }, { 1519, 798, 0xb57d63 },\
        })\
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
      -- 5-6的右边\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022, }\
        local basePoint, posandcolor = transRelativePoint({\
          { 1662, 609, 0x000000 }, { 1661, 609, 0x9c6163 },\
          { 1662, 608, 0x000000 }, { 1661, 608, 0x9c6163 },\
          { 1663, 610, 0x000000 }, { 1662, 610, 0xa4616b },\
          { 1663, 611, 0x000000 }, { 1662, 611, 0x9c5d63 },\
        })\
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
      -- 6-6的右边\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022, }\
        local basePoint, posandcolor = transRelativePoint({\
          { 1696, 760, 0x000000 }, { 1695, 760, 0x8c5963 },\
          { 1696, 759, 0x000000 }, { 1695, 759, 0x8c5963 },\
          { 1697, 761, 0x000000 }, { 1696, 761, 0x845563 },\
          { 1697, 762, 0x000000 }, { 1696, 762, 0x8c5963 },\
        })\
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
    },\
    -- 我方舰队位置\
    myFleetList = imgBase.map.myFleetList,\
    -- 我放舰队被选中的舰队的绿色的选中箭头的位置\
    selectedArrow = imgBase.map.selectedArrow,\
    -- 敌方舰队位置(小型舰队)\
    enemyList1 = imgBase.map.enemyList1,\
    -- 敌方舰队位置(中型舰队)\
    enemyList2 = imgBase.map.enemyList2,\
    -- 敌方舰队位置(大型舰队)\
    enemyList3 = imgBase.map.enemyList3,\
    -- boss位置\
    bossPointList = imgBase.map.bossPointList,\
    -- 战斗中的位置\
    inBattleList = imgBase.map.inBattleList,\
    -- 奖励箱的位置\
    rewardBoxList = imgBase.map.rewardBoxList,\
  },\
}" }


package.sourceCode = package.sourceCode or {}
package.sourceCode["./meta-operation/maps-options/img3-4.lua"] = { path = "./meta-operation/maps-options/img3-4.lua", name = "./meta-operation/maps-options/img3-4.lua", source = "-- 存储图像信息，用于界面找色、找图。取代图片搜索，因为找色搜索的像素点更少\
local imgBase = require './img'\
\
local transRelativePoint = imgBase.transRelativePoint\
\
return {\
  transRelativePoint = transRelativePoint,\
  -- 基本方法\
  toPoint = imgBase.toPoint,\
  -- 过滤被右下角按钮挡住的部分的点，因为右下角按钮也是黑色的容易与边界识别混淆\
  filterNoUsePoint = imgBase.filterNoUsePoint,\
  -- 图片数据\
  -- 地图扫描\
  map = {\
    -- 地图上边界\
    topLineList = {\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022, }\
        local basePoint, posandcolor = transRelativePoint({\
          { 398, 334, 0x314152 }, { 429, 334, 0x293d4a },\
          { 471, 334, 0x293d4a }, { 501, 334, 0x213d4a },\
          { 485, 335, 0x31aade }, { 463, 335, 0x31a6de },\
          { 439, 335, 0x319ede }, { 409, 335, 0x29a2de },\
        })\
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
      -- 1-6 上方\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022, }\
        local basePoint, posandcolor = transRelativePoint({\
          { 1229, 559, 0x212431 }, { 1277, 559, 0x212431 },\
          { 1314, 559, 0x192429 }, { 1344, 559, 0x192421 },\
          { 1362, 560, 0x42cade }, { 1329, 560, 0x3ac2de },\
          { 1292, 560, 0x3ac2de }, { 1248, 560, 0x3abede },\
        })\
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
    },\
    -- 地图下边界\
    bottonLineList = {\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022 }\
        local basePoint, posandcolor = transRelativePoint({\
          { 482, 918, 0x000000 }, { 554, 918, 0x000000 },\
          { 615, 918, 0x000000 }, { 658, 918, 0x000000 },\
          { 636, 917, 0x1971b4 }, { 596, 917, 0x2171b4 },\
          { 560, 917, 0x2171b4 }, { 518, 917, 0x1971ac },\
        })\
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
    },\
    -- 地图左边界\
    leftLineList = {\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022 }\
        local basePoint, posandcolor = transRelativePoint({\
          { 271, 652, 0x000000 }, { 272, 652, 0x3ab2e6 },\
          { 271, 651, 0x000000 }, { 272, 651, 0x31aad6 },\
          { 270, 653, 0x000000 }, { 271, 653, 0x31aede },\
          { 270, 654, 0x000000 }, { 271, 654, 0x31aede },\
        })\
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
      -- 4-1 的左边\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022 }\
        local basePoint, posandcolor = transRelativePoint({\
          { 342, 803, 0x000000 }, { 343, 803, 0x218ec5 },\
          { 342, 802, 0x080408 }, { 343, 802, 0x218ec5 },\
          { 341, 804, 0x000000 }, { 342, 804, 0x298ec5 },\
          { 341, 805, 0x000000 }, { 342, 805, 0x218abd },\
        })\
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
    },\
    -- 地图右边界\
    rightLineList = {\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022 }\
        local basePoint, posandcolor = transRelativePoint({\
          { 1609, 304, 0x000000 }, { 1608, 304, 0x29a2e6 },\
          { 1609, 303, 0x000000 }, { 1608, 303, 0x219ede },\
          { 1610, 305, 0x000000 }, { 1609, 305, 0x299ee6 },\
          { 1610, 306, 0x000000 }, { 1609, 306, 0x299ede },\
        })\
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
      -- 4-8 的右边\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022 }\
        local basePoint, posandcolor = transRelativePoint({\
          { 1733, 831, 0x000000 }, { 1732, 831, 0x296dbd },\
          { 1733, 830, 0x000000 }, { 1732, 830, 0x316dc5 },\
          { 1734, 832, 0x000000 }, { 1733, 832, 0x316dbd },\
          { 1734, 833, 0x000000 }, { 1733, 833, 0x316dbd },\
        })\
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
    },\
    -- 我方舰队位置\
    myFleetList = imgBase.map.myFleetList,\
    -- 我放舰队被选中的舰队的绿色的选中箭头的位置\
    selectedArrow = imgBase.map.selectedArrow,\
    -- 敌方舰队位置(小型舰队)\
    enemyList1 = imgBase.map.enemyList1,\
    -- 敌方舰队位置(中型舰队)\
    enemyList2 = imgBase.map.enemyList2,\
    -- 敌方舰队位置(大型舰队)\
    enemyList3 = imgBase.map.enemyList3,\
    -- boss位置\
    bossPointList = imgBase.map.bossPointList,\
    -- 战斗中的位置\
    inBattleList = imgBase.map.inBattleList,\
    -- 奖励箱的位置\
    rewardBoxList = imgBase.map.rewardBoxList,\
  },\
}" }


package.sourceCode = package.sourceCode or {}
package.sourceCode["./meta-operation/maps-options/img3-3.lua"] = { path = "./meta-operation/maps-options/img3-3.lua", name = "./meta-operation/maps-options/img3-3.lua", source = "-- 存储图像信息，用于界面找色、找图。取代图片搜索，因为找色搜索的像素点更少\
local imgBase = require './img'\
\
local transRelativePoint = imgBase.transRelativePoint\
\
return {\
  transRelativePoint = transRelativePoint,\
  -- 基本方法\
  toPoint = imgBase.toPoint,\
  -- 过滤被右下角按钮挡住的部分的点，因为右下角按钮也是黑色的容易与边界识别混淆\
  filterNoUsePoint = imgBase.filterNoUsePoint,\
  -- 图片数据\
  -- 地图扫描\
  map = {\
    -- 地图上边界\
    topLineList = {\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022, }\
        local basePoint, posandcolor = transRelativePoint({\
          { 398, 334, 0x314152 }, { 429, 334, 0x293d4a },\
          { 471, 334, 0x293d4a }, { 501, 334, 0x213d4a },\
          { 485, 335, 0x31aade }, { 463, 335, 0x31a6de },\
          { 439, 335, 0x319ede }, { 409, 335, 0x29a2de },\
        })\
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
    },\
    -- 地图下边界\
    bottonLineList = {\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022 }\
        local basePoint, posandcolor = transRelativePoint({\
          { 482, 918, 0x000000 }, { 554, 918, 0x000000 },\
          { 615, 918, 0x000000 }, { 658, 918, 0x000000 },\
          { 636, 917, 0x1971b4 }, { 596, 917, 0x2171b4 },\
          { 560, 917, 0x2171b4 }, { 518, 917, 0x1971ac },\
        })\
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
    },\
    -- 地图左边界\
    leftLineList = {\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022 }\
        local basePoint, posandcolor = transRelativePoint({\
          { 455, 458, 0x000000 }, { 456, 458, 0x31bade },\
          { 455, 457, 0x000000 }, { 456, 457, 0x31b6de },\
          { 454, 459, 0x000000 }, { 455, 459, 0x31bade },\
          { 454, 460, 0x000000 }, { 455, 460, 0x31bade },\
        })\
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
    },\
    -- 地图右边界\
    rightLineList = {\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022 }\
        local basePoint, posandcolor = transRelativePoint({\
          { 1609, 304, 0x000000 }, { 1608, 304, 0x29a2e6 },\
          { 1609, 303, 0x000000 }, { 1608, 303, 0x219ede },\
          { 1610, 305, 0x000000 }, { 1609, 305, 0x299ee6 },\
          { 1610, 306, 0x000000 }, { 1609, 306, 0x299ede },\
        })\
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
    },\
    -- 我方舰队位置\
    myFleetList = imgBase.map.myFleetList,\
    -- 我放舰队被选中的舰队的绿色的选中箭头的位置\
    selectedArrow = imgBase.map.selectedArrow,\
    -- 敌方舰队位置(小型舰队)\
    enemyList1 = imgBase.map.enemyList1,\
    -- 敌方舰队位置(中型舰队)\
    enemyList2 = imgBase.map.enemyList2,\
    -- 敌方舰队位置(大型舰队)\
    enemyList3 = imgBase.map.enemyList3,\
    -- boss位置\
    bossPointList = imgBase.map.bossPointList,\
    -- 战斗中的位置\
    inBattleList = imgBase.map.inBattleList,\
    -- 奖励箱的位置\
    rewardBoxList = imgBase.map.rewardBoxList,\
  },\
}" }


package.sourceCode = package.sourceCode or {}
package.sourceCode["./meta-operation/maps-options/img3-2.lua"] = { path = "./meta-operation/maps-options/img3-2.lua", name = "./meta-operation/maps-options/img3-2.lua", source = "-- 存储图像信息，用于界面找色、找图。取代图片搜索，因为找色搜索的像素点更少\
local imgBase = require './img'\
\
local transRelativePoint = imgBase.transRelativePoint\
\
return {\
  transRelativePoint = transRelativePoint,\
  -- 基本方法\
  toPoint = imgBase.toPoint,\
  -- 过滤被右下角按钮挡住的部分的点，因为右下角按钮也是黑色的容易与边界识别混淆\
  filterNoUsePoint = imgBase.filterNoUsePoint,\
  -- 图片数据\
  -- 地图扫描\
  map = {\
    -- 地图上边界\
    topLineList = {\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022, }\
        local basePoint, posandcolor = transRelativePoint({\
          { 398, 334, 0x314152 }, { 429, 334, 0x293d4a },\
          { 471, 334, 0x293d4a }, { 501, 334, 0x213d4a },\
          { 485, 335, 0x31aade }, { 463, 335, 0x31a6de },\
          { 439, 335, 0x319ede }, { 409, 335, 0x29a2de },\
        })\
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
      -- 1-5上方\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022, }\
        local basePoint, posandcolor = transRelativePoint({\
          { 1040, 378, 0x3a3d42 }, { 1086, 378, 0x3a3942 },\
          { 1133, 378, 0x31393a }, { 1168, 378, 0x313942 },\
          { 1190, 379, 0x29bade }, { 1148, 379, 0x29b2d6 },\
          { 1107, 379, 0x31b6de }, { 1067, 379, 0x31bade },\
        })\
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
      -- 1-8上方\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022, }\
        local basePoint, posandcolor = transRelativePoint({\
          { 1572, 378, 0x42454a }, { 1616, 378, 0x31393a },\
          { 1666, 378, 0x292831 }, { 1695, 378, 0x212429 },\
          { 1720, 379, 0x29b2d6 }, { 1688, 379, 0x31bade },\
          { 1634, 379, 0x31bade }, { 1590, 379, 0x31bed6 },\
        })\
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
    },\
    -- 地图下边界\
    bottonLineList = {\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022 }\
        local basePoint, posandcolor = transRelativePoint({\
          { 482, 918, 0x000000 }, { 554, 918, 0x000000 },\
          { 615, 918, 0x000000 }, { 658, 918, 0x000000 },\
          { 636, 917, 0x1971b4 }, { 596, 917, 0x2171b4 },\
          { 560, 917, 0x2171b4 }, { 518, 917, 0x1971ac },\
        })\
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
    },\
    -- 地图左边界\
    leftLineList = {\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022 }\
        local basePoint, posandcolor = transRelativePoint({\
          { 455, 458, 0x000000 }, { 456, 458, 0x31bade },\
          { 455, 457, 0x000000 }, { 456, 457, 0x31b6de },\
          { 454, 459, 0x000000 }, { 455, 459, 0x31bade },\
          { 454, 460, 0x000000 }, { 455, 460, 0x31bade },\
        })\
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
    },\
    -- 地图右边界\
    rightLineList = {\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022 }\
        local basePoint, posandcolor = transRelativePoint({\
          { 1609, 304, 0x000000 }, { 1608, 304, 0x29a2e6 },\
          { 1609, 303, 0x000000 }, { 1608, 303, 0x219ede },\
          { 1610, 305, 0x000000 }, { 1609, 305, 0x299ee6 },\
          { 1610, 306, 0x000000 }, { 1609, 306, 0x299ede },\
        })\
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
    },\
    -- 我方舰队位置\
    myFleetList = imgBase.map.myFleetList,\
    -- 我放舰队被选中的舰队的绿色的选中箭头的位置\
    selectedArrow = imgBase.map.selectedArrow,\
    -- 敌方舰队位置(小型舰队)\
    enemyList1 = imgBase.map.enemyList1,\
    -- 敌方舰队位置(中型舰队)\
    enemyList2 = imgBase.map.enemyList2,\
    -- 敌方舰队位置(大型舰队)\
    enemyList3 = imgBase.map.enemyList3,\
    -- boss位置\
    bossPointList = imgBase.map.bossPointList,\
    -- 战斗中的位置\
    inBattleList = imgBase.map.inBattleList,\
    -- 奖励箱的位置\
    rewardBoxList = imgBase.map.rewardBoxList,\
  },\
}" }


package.sourceCode = package.sourceCode or {}
package.sourceCode["./meta-operation/maps-options/img3-1.lua"] = { path = "./meta-operation/maps-options/img3-1.lua", name = "./meta-operation/maps-options/img3-1.lua", source = "-- 存储图像信息，用于界面找色、找图。取代图片搜索，因为找色搜索的像素点更少\
local imgBase = require './img'\
\
local transRelativePoint = imgBase.transRelativePoint\
\
return {\
  transRelativePoint = transRelativePoint,\
  -- 基本方法\
  toPoint = imgBase.toPoint,\
  -- 过滤被右下角按钮挡住的部分的点，因为右下角按钮也是黑色的容易与边界识别混淆\
  filterNoUsePoint = imgBase.filterNoUsePoint,\
  -- 图片数据\
  -- 地图扫描\
  map = {\
    -- 地图上边界\
    topLineList = {\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022, }\
        local basePoint, posandcolor = transRelativePoint({\
          { 398, 334, 0x314152 }, { 429, 334, 0x293d4a },\
          { 471, 334, 0x293d4a }, { 501, 334, 0x213d4a },\
          { 485, 335, 0x31aade }, { 463, 335, 0x31a6de },\
          { 439, 335, 0x319ede }, { 409, 335, 0x29a2de },\
        })\
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
    },\
    -- 地图下边界\
    bottonLineList = {\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022 }\
        local basePoint, posandcolor = transRelativePoint({\
          { 482, 918, 0x000000 }, { 554, 918, 0x000000 },\
          { 615, 918, 0x000000 }, { 658, 918, 0x000000 },\
          { 636, 917, 0x1971b4 }, { 596, 917, 0x2171b4 },\
          { 560, 917, 0x2171b4 }, { 518, 917, 0x1971ac },\
        })\
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
    },\
    -- 地图左边界\
    leftLineList = {\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022 }\
        local basePoint, posandcolor = transRelativePoint({\
          { 455, 458, 0x000000 }, { 456, 458, 0x31bade },\
          { 455, 457, 0x000000 }, { 456, 457, 0x31b6de },\
          { 454, 459, 0x000000 }, { 455, 459, 0x31bade },\
          { 454, 460, 0x000000 }, { 455, 460, 0x31bade },\
        })\
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
    },\
    -- 地图右边界\
    rightLineList = {\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022 }\
        local basePoint, posandcolor = transRelativePoint({\
          { 1609, 304, 0x000000 }, { 1608, 304, 0x29a2e6 },\
          { 1609, 303, 0x000000 }, { 1608, 303, 0x219ede },\
          { 1610, 305, 0x000000 }, { 1609, 305, 0x299ee6 },\
          { 1610, 306, 0x000000 }, { 1609, 306, 0x299ede },\
        })\
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
    },\
    -- 我方舰队位置\
    myFleetList = imgBase.map.myFleetList,\
    -- 我放舰队被选中的舰队的绿色的选中箭头的位置\
    selectedArrow = imgBase.map.selectedArrow,\
    -- 敌方舰队位置(小型舰队)\
    enemyList1 = imgBase.map.enemyList1,\
    -- 敌方舰队位置(中型舰队)\
    enemyList2 = imgBase.map.enemyList2,\
    -- 敌方舰队位置(大型舰队)\
    enemyList3 = imgBase.map.enemyList3,\
    -- boss位置\
    bossPointList = imgBase.map.bossPointList,\
    -- 战斗中的位置\
    inBattleList = imgBase.map.inBattleList,\
    -- 奖励箱的位置\
    rewardBoxList = imgBase.map.rewardBoxList,\
  },\
}" }


package.sourceCode = package.sourceCode or {}
package.sourceCode["./meta-operation/maps-options/img2-4.lua"] = { path = "./meta-operation/maps-options/img2-4.lua", name = "./meta-operation/maps-options/img2-4.lua", source = "-- 存储图像信息，用于界面找色、找图。取代图片搜索，因为找色搜索的像素点更少\
local imgBase = require './img'\
\
local transRelativePoint = imgBase.transRelativePoint\
\
return {\
  transRelativePoint = transRelativePoint,\
  -- 基本方法\
  toPoint = imgBase.toPoint,\
  -- 过滤被右下角按钮挡住的部分的点，因为右下角按钮也是黑色的容易与边界识别混淆\
  filterNoUsePoint = imgBase.filterNoUsePoint,\
  -- 图片数据\
  -- 地图扫描\
  map = {\
    -- 地图上边界\
    topLineList = {\
      -- 1-1 上边\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022, }\
        local basePoint, posandcolor = transRelativePoint({\
          { 418, 309, 0x213d42 }, { 432, 309, 0x213d42 },\
          { 450, 309, 0x213d42 }, { 472, 309, 0x213d42 },\
          { 484, 310, 0x31aae6 }, { 462, 310, 0x319ee6 },\
          { 445, 310, 0x299ede }, { 427, 310, 0x299ede },\
        })\
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
      -- 1-5 上边\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022, }\
        local basePoint, posandcolor = transRelativePoint({\
          { 1207, 309, 0x213142 }, { 1222, 309, 0x192d3a },\
          { 1238, 309, 0x192d3a }, { 1256, 309, 0x212d42 },\
          { 1267, 310, 0x3ac2de }, { 1246, 310, 0x3ac2de },\
          { 1226, 310, 0x3abee6 }, { 1202, 310, 0x31bade },\
        })\
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
      -- 1-7 上边\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022, }\
        local basePoint, posandcolor = transRelativePoint({\
          { 1480, 309, 0x19253a }, { 1496, 309, 0x19243a },\
          { 1513, 309, 0x212842 }, { 1529, 309, 0x212842 },\
          { 1539, 310, 0x31bede }, { 1522, 310, 0x3abee6 },\
          { 1502, 310, 0x3ac2de }, { 1482, 310, 0x3ac6e6 },\
        })\
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
    },\
    -- 地图下边界\
    bottonLineList = {\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022 }\
        local basePoint, posandcolor = transRelativePoint({\
          { 613, 859, 0x000000 }, { 643, 859, 0x000000 },\
          { 668, 859, 0x000000 }, { 699, 859, 0x000000 },\
          { 717, 858, 0x1965ad }, { 676, 858, 0x1969b5 },\
          { 646, 858, 0x1965b5 }, { 625, 858, 0x1965ad },\
        })\
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
    },\
    -- 地图左边界\
    leftLineList = {\
      -- 1-1 左边\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022 }\
        local basePoint, posandcolor = transRelativePoint({\
          { 384, 344, 0x000000 }, { 385, 344, 0x31a2e6 },\
          { 384, 343, 0x000000 }, { 385, 343, 0x31a2e6 },\
          { 383, 345, 0x000000 }, { 384, 345, 0x29a2de },\
          { 383, 346, 0x000000 }, { 384, 346, 0x31a2e6 },\
        })\
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
      -- 4-1 左边\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022 }\
        local basePoint, posandcolor = transRelativePoint({\
          { 309, 794, 0x000000 }, { 310, 794, 0x2992ce },\
          { 309, 793, 0x000000 }, { 310, 793, 0x218ebd },\
          { 308, 795, 0x000000 }, { 309, 795, 0x298ece },\
          { 308, 796, 0x000000 }, { 309, 796, 0x298ec5 },\
        })\
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
    },\
    -- 地图右边界\
    rightLineList = {\
      -- 1-7 右边\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022 }\
        local basePoint, posandcolor = transRelativePoint({\
          { 1637, 337, 0x000000 }, { 1636, 337, 0x29aede },\
          { 1637, 336, 0x000000 }, { 1636, 336, 0x31aede },\
          { 1638, 338, 0x000000 }, { 1637, 338, 0x29aede },\
          { 1638, 339, 0x000000 }, { 1637, 339, 0x31aede },\
        })\
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
      -- 2-7 右边\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022 }\
        local basePoint, posandcolor = transRelativePoint({\
          { 1667, 490, 0x000000 }, { 1666, 490, 0x31bee6 },\
          { 1667, 489, 0x000000 }, { 1666, 489, 0x29bade },\
          { 1668, 491, 0x000000 }, { 1667, 491, 0x31bee6 },\
          { 1668, 492, 0x000000 }, { 1667, 492, 0x29bade },\
        })\
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
      -- 4-7 右边\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022 }\
        local basePoint, posandcolor = transRelativePoint({\
          { 1738, 851, 0x000000 }, { 1737, 851, 0x3a75c5 },\
          { 1738, 850, 0x000000 }, { 1737, 850, 0x3a75c5 },\
          { 1739, 852, 0x000000 }, { 1738, 852, 0x3a79c5 },\
          { 1739, 853, 0x000000 }, { 1738, 853, 0x3175bd },\
        })\
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
    },\
    -- 我方舰队位置\
    myFleetList = imgBase.map.myFleetList,\
    -- 我放舰队被选中的舰队的绿色的选中箭头的位置\
    selectedArrow = imgBase.map.selectedArrow,\
    -- 敌方舰队位置(小型舰队)\
    enemyList1 = imgBase.map.enemyList1,\
    -- 敌方舰队位置(中型舰队)\
    enemyList2 = imgBase.map.enemyList2,\
    -- 敌方舰队位置(大型舰队)\
    enemyList3 = imgBase.map.enemyList3,\
    -- boss位置\
    bossPointList = imgBase.map.bossPointList,\
    -- 战斗中的位置\
    inBattleList = imgBase.map.inBattleList,\
    -- 奖励箱的位置\
    rewardBoxList = imgBase.map.rewardBoxList,\
  },\
}" }


package.sourceCode = package.sourceCode or {}
package.sourceCode["./meta-operation/maps-options/img2-3.lua"] = { path = "./meta-operation/maps-options/img2-3.lua", name = "./meta-operation/maps-options/img2-3.lua", source = "-- 存储图像信息，用于界面找色、找图。取代图片搜索，因为找色搜索的像素点更少\
local imgBase = require './img'\
\
local transRelativePoint = imgBase.transRelativePoint\
\
return {\
  transRelativePoint = transRelativePoint,\
  -- 基本方法\
  toPoint = imgBase.toPoint,\
  -- 过滤被右下角按钮挡住的部分的点，因为右下角按钮也是黑色的容易与边界识别混淆\
  filterNoUsePoint = imgBase.filterNoUsePoint,\
  -- 图片数据\
  -- 地图扫描\
  map = {\
    -- 地图上边界\
    topLineList = {\
      -- 1-1 上边\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022, }\
        local basePoint, posandcolor = transRelativePoint({\
          { 418, 309, 0x213d42 }, { 432, 309, 0x213d42 },\
          { 450, 309, 0x213d42 }, { 472, 309, 0x213d42 },\
          { 484, 310, 0x31aae6 }, { 462, 310, 0x319ee6 },\
          { 445, 310, 0x299ede }, { 427, 310, 0x299ede },\
        })\
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
      -- 1-5 上边\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022, }\
        local basePoint, posandcolor = transRelativePoint({\
          { 1207, 309, 0x213142 }, { 1222, 309, 0x192d3a },\
          { 1238, 309, 0x192d3a }, { 1256, 309, 0x212d42 },\
          { 1267, 310, 0x3ac2de }, { 1246, 310, 0x3ac2de },\
          { 1226, 310, 0x3abee6 }, { 1202, 310, 0x31bade },\
        })\
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
      -- 1-7 上边\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022, }\
        local basePoint, posandcolor = transRelativePoint({\
          { 1480, 309, 0x19253a }, { 1496, 309, 0x19243a },\
          { 1513, 309, 0x212842 }, { 1529, 309, 0x212842 },\
          { 1539, 310, 0x31bede }, { 1522, 310, 0x3abee6 },\
          { 1502, 310, 0x3ac2de }, { 1482, 310, 0x3ac6e6 },\
        })\
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
    },\
    -- 地图下边界\
    bottonLineList = {\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022 }\
        local basePoint, posandcolor = transRelativePoint({\
          { 613, 859, 0x000000 }, { 643, 859, 0x000000 },\
          { 668, 859, 0x000000 }, { 699, 859, 0x000000 },\
          { 717, 858, 0x1965ad }, { 676, 858, 0x1969b5 },\
          { 646, 858, 0x1965b5 }, { 625, 858, 0x1965ad },\
        })\
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
    },\
    -- 地图左边界\
    leftLineList = {\
      -- 1-1 左边\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022 }\
        local basePoint, posandcolor = transRelativePoint({\
          { 384, 344, 0x000000 }, { 385, 344, 0x31a2e6 },\
          { 384, 343, 0x000000 }, { 385, 343, 0x31a2e6 },\
          { 383, 345, 0x000000 }, { 384, 345, 0x29a2de },\
          { 383, 346, 0x000000 }, { 384, 346, 0x31a2e6 },\
        })\
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
      -- 4-1 左边\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022 }\
        local basePoint, posandcolor = transRelativePoint({\
          { 309, 794, 0x000000 }, { 310, 794, 0x2992ce },\
          { 309, 793, 0x000000 }, { 310, 793, 0x218ebd },\
          { 308, 795, 0x000000 }, { 309, 795, 0x298ece },\
          { 308, 796, 0x000000 }, { 309, 796, 0x298ec5 },\
        })\
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
    },\
    -- 地图右边界\
    rightLineList = {\
      -- 1-7 右边\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022 }\
        local basePoint, posandcolor = transRelativePoint({\
          { 1637, 337, 0x000000 }, { 1636, 337, 0x29aede },\
          { 1637, 336, 0x000000 }, { 1636, 336, 0x31aede },\
          { 1638, 338, 0x000000 }, { 1637, 338, 0x29aede },\
          { 1638, 339, 0x000000 }, { 1637, 339, 0x31aede },\
        })\
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
      -- 2-7 右边\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022 }\
        local basePoint, posandcolor = transRelativePoint({\
          { 1667, 490, 0x000000 }, { 1666, 490, 0x31bee6 },\
          { 1667, 489, 0x000000 }, { 1666, 489, 0x29bade },\
          { 1668, 491, 0x000000 }, { 1667, 491, 0x31bee6 },\
          { 1668, 492, 0x000000 }, { 1667, 492, 0x29bade },\
        })\
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
      -- 4-7 右边\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022 }\
        local basePoint, posandcolor = transRelativePoint({\
          { 1738, 851, 0x000000 }, { 1737, 851, 0x3a75c5 },\
          { 1738, 850, 0x000000 }, { 1737, 850, 0x3a75c5 },\
          { 1739, 852, 0x000000 }, { 1738, 852, 0x3a79c5 },\
          { 1739, 853, 0x000000 }, { 1738, 853, 0x3175bd },\
        })\
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
    },\
    -- 我方舰队位置\
    myFleetList = imgBase.map.myFleetList,\
    -- 我放舰队被选中的舰队的绿色的选中箭头的位置\
    selectedArrow = imgBase.map.selectedArrow,\
    -- 敌方舰队位置(小型舰队)\
    enemyList1 = imgBase.map.enemyList1,\
    -- 敌方舰队位置(中型舰队)\
    enemyList2 = imgBase.map.enemyList2,\
    -- 敌方舰队位置(大型舰队)\
    enemyList3 = imgBase.map.enemyList3,\
    -- boss位置\
    bossPointList = imgBase.map.bossPointList,\
    -- 战斗中的位置\
    inBattleList = imgBase.map.inBattleList,\
    -- 奖励箱的位置\
    rewardBoxList = imgBase.map.rewardBoxList,\
  },\
}" }


package.sourceCode = package.sourceCode or {}
package.sourceCode["./meta-operation/maps-options/img2-2.lua"] = { path = "./meta-operation/maps-options/img2-2.lua", name = "./meta-operation/maps-options/img2-2.lua", source = "-- 存储图像信息，用于界面找色、找图。取代图片搜索，因为找色搜索的像素点更少\
local imgBase = require './img'\
\
local transRelativePoint = imgBase.transRelativePoint\
\
return {\
  transRelativePoint = transRelativePoint,\
  -- 基本方法\
  toPoint = imgBase.toPoint,\
  -- 过滤被右下角按钮挡住的部分的点，因为右下角按钮也是黑色的容易与边界识别混淆\
  filterNoUsePoint = imgBase.filterNoUsePoint,\
  -- 图片数据\
  -- 地图扫描\
  map = {\
    -- 地图上边界\
    topLineList = {\
      -- 1-1 上边\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022, }\
        local basePoint, posandcolor = transRelativePoint({\
          { 418, 309, 0x213d42 }, { 432, 309, 0x213d42 },\
          { 450, 309, 0x213d42 }, { 472, 309, 0x213d42 },\
          { 484, 310, 0x31aae6 }, { 462, 310, 0x319ee6 },\
          { 445, 310, 0x299ede }, { 427, 310, 0x299ede },\
        })\
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
      -- 1-5 上边\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022, }\
        local basePoint, posandcolor = transRelativePoint({\
          { 1207, 309, 0x213142 }, { 1222, 309, 0x192d3a },\
          { 1238, 309, 0x192d3a }, { 1256, 309, 0x212d42 },\
          { 1267, 310, 0x3ac2de }, { 1246, 310, 0x3ac2de },\
          { 1226, 310, 0x3abee6 }, { 1202, 310, 0x31bade },\
        })\
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
      -- 1-7 上边\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022, }\
        local basePoint, posandcolor = transRelativePoint({\
          { 1480, 309, 0x19253a }, { 1496, 309, 0x19243a },\
          { 1513, 309, 0x212842 }, { 1529, 309, 0x212842 },\
          { 1539, 310, 0x31bede }, { 1522, 310, 0x3abee6 },\
          { 1502, 310, 0x3ac2de }, { 1482, 310, 0x3ac6e6 },\
        })\
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
    },\
    -- 地图下边界\
    bottonLineList = {\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022 }\
        local basePoint, posandcolor = transRelativePoint({\
          { 613, 859, 0x000000 }, { 643, 859, 0x000000 },\
          { 668, 859, 0x000000 }, { 699, 859, 0x000000 },\
          { 717, 858, 0x1965ad }, { 676, 858, 0x1969b5 },\
          { 646, 858, 0x1965b5 }, { 625, 858, 0x1965ad },\
        })\
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
    },\
    -- 地图左边界\
    leftLineList = {\
      -- 1-1 左边\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022 }\
        local basePoint, posandcolor = transRelativePoint({\
          { 384, 344, 0x000000 }, { 385, 344, 0x31a2e6 },\
          { 384, 343, 0x000000 }, { 385, 343, 0x31a2e6 },\
          { 383, 345, 0x000000 }, { 384, 345, 0x29a2de },\
          { 383, 346, 0x000000 }, { 384, 346, 0x31a2e6 },\
        })\
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
      -- 4-1 左边\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022 }\
        local basePoint, posandcolor = transRelativePoint({\
          { 309, 794, 0x000000 }, { 310, 794, 0x2992ce },\
          { 309, 793, 0x000000 }, { 310, 793, 0x218ebd },\
          { 308, 795, 0x000000 }, { 309, 795, 0x298ece },\
          { 308, 796, 0x000000 }, { 309, 796, 0x298ec5 },\
        })\
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
    },\
    -- 地图右边界\
    rightLineList = {\
      -- 1-7 右边\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022 }\
        local basePoint, posandcolor = transRelativePoint({\
          { 1637, 337, 0x000000 }, { 1636, 337, 0x29aede },\
          { 1637, 336, 0x000000 }, { 1636, 336, 0x31aede },\
          { 1638, 338, 0x000000 }, { 1637, 338, 0x29aede },\
          { 1638, 339, 0x000000 }, { 1637, 339, 0x31aede },\
        })\
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
      -- 2-7 右边\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022 }\
        local basePoint, posandcolor = transRelativePoint({\
          { 1667, 490, 0x000000 }, { 1666, 490, 0x31bee6 },\
          { 1667, 489, 0x000000 }, { 1666, 489, 0x29bade },\
          { 1668, 491, 0x000000 }, { 1667, 491, 0x31bee6 },\
          { 1668, 492, 0x000000 }, { 1667, 492, 0x29bade },\
        })\
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
      -- 4-7 右边\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022 }\
        local basePoint, posandcolor = transRelativePoint({\
          { 1738, 851, 0x000000 }, { 1737, 851, 0x3a75c5 },\
          { 1738, 850, 0x000000 }, { 1737, 850, 0x3a75c5 },\
          { 1739, 852, 0x000000 }, { 1738, 852, 0x3a79c5 },\
          { 1739, 853, 0x000000 }, { 1738, 853, 0x3175bd },\
        })\
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
    },\
    -- 我方舰队位置\
    myFleetList = imgBase.map.myFleetList,\
    -- 我放舰队被选中的舰队的绿色的选中箭头的位置\
    selectedArrow = imgBase.map.selectedArrow,\
    -- 敌方舰队位置(小型舰队)\
    enemyList1 = imgBase.map.enemyList1,\
    -- 敌方舰队位置(中型舰队)\
    enemyList2 = imgBase.map.enemyList2,\
    -- 敌方舰队位置(大型舰队)\
    enemyList3 = imgBase.map.enemyList3,\
    -- boss位置\
    bossPointList = imgBase.map.bossPointList,\
    -- 战斗中的位置\
    inBattleList = imgBase.map.inBattleList,\
    -- 奖励箱的位置\
    rewardBoxList = imgBase.map.rewardBoxList,\
  },\
}" }


package.sourceCode = package.sourceCode or {}
package.sourceCode["./meta-operation/maps-options/img2-1.lua"] = { path = "./meta-operation/maps-options/img2-1.lua", name = "./meta-operation/maps-options/img2-1.lua", source = "-- 存储图像信息，用于界面找色、找图。取代图片搜索，因为找色搜索的像素点更少\
local imgBase = require './img'\
\
local transRelativePoint = imgBase.transRelativePoint\
\
return {\
  transRelativePoint = transRelativePoint,\
  -- 基本方法\
  toPoint = imgBase.toPoint,\
  -- 过滤被右下角按钮挡住的部分的点，因为右下角按钮也是黑色的容易与边界识别混淆\
  filterNoUsePoint = imgBase.filterNoUsePoint,\
  -- 图片数据\
  -- 地图扫描\
  map = {\
    -- 地图上边界\
    topLineList = {\
      -- 1-1 上边\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022, }\
        local basePoint, posandcolor = transRelativePoint({\
          { 418, 309, 0x213d42 }, { 432, 309, 0x213d42 },\
          { 450, 309, 0x213d42 }, { 472, 309, 0x213d42 },\
          { 484, 310, 0x31aae6 }, { 462, 310, 0x319ee6 },\
          { 445, 310, 0x299ede }, { 427, 310, 0x299ede },\
        })\
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
      -- 1-5 上边\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022, }\
        local basePoint, posandcolor = transRelativePoint({\
          { 1207, 309, 0x213142 }, { 1222, 309, 0x192d3a },\
          { 1238, 309, 0x192d3a }, { 1256, 309, 0x212d42 },\
          { 1267, 310, 0x3ac2de }, { 1246, 310, 0x3ac2de },\
          { 1226, 310, 0x3abee6 }, { 1202, 310, 0x31bade },\
        })\
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
      -- 1-7 上边\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022, }\
        local basePoint, posandcolor = transRelativePoint({\
          { 1480, 309, 0x19253a }, { 1496, 309, 0x19243a },\
          { 1513, 309, 0x212842 }, { 1529, 309, 0x212842 },\
          { 1539, 310, 0x31bede }, { 1522, 310, 0x3abee6 },\
          { 1502, 310, 0x3ac2de }, { 1482, 310, 0x3ac6e6 },\
        })\
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
    },\
    -- 地图下边界\
    bottonLineList = {\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022 }\
        local basePoint, posandcolor = transRelativePoint({\
          { 613, 859, 0x000000 }, { 643, 859, 0x000000 },\
          { 668, 859, 0x000000 }, { 699, 859, 0x000000 },\
          { 717, 858, 0x1965ad }, { 676, 858, 0x1969b5 },\
          { 646, 858, 0x1965b5 }, { 625, 858, 0x1965ad },\
        })\
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
    },\
    -- 地图左边界\
    leftLineList = {\
      -- 1-1 左边\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022 }\
        local basePoint, posandcolor = transRelativePoint({\
          { 384, 344, 0x000000 }, { 385, 344, 0x31a2e6 },\
          { 384, 343, 0x000000 }, { 385, 343, 0x31a2e6 },\
          { 383, 345, 0x000000 }, { 384, 345, 0x29a2de },\
          { 383, 346, 0x000000 }, { 384, 346, 0x31a2e6 },\
        })\
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
      -- 4-1 左边\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022 }\
        local basePoint, posandcolor = transRelativePoint({\
          { 309, 794, 0x000000 }, { 310, 794, 0x2992ce },\
          { 309, 793, 0x000000 }, { 310, 793, 0x218ebd },\
          { 308, 795, 0x000000 }, { 309, 795, 0x298ece },\
          { 308, 796, 0x000000 }, { 309, 796, 0x298ec5 },\
        })\
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
    },\
    -- 地图右边界\
    rightLineList = {\
      -- 1-7 右边\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022 }\
        local basePoint, posandcolor = transRelativePoint({\
          { 1637, 337, 0x000000 }, { 1636, 337, 0x29aede },\
          { 1637, 336, 0x000000 }, { 1636, 336, 0x31aede },\
          { 1638, 338, 0x000000 }, { 1637, 338, 0x29aede },\
          { 1638, 339, 0x000000 }, { 1637, 339, 0x31aede },\
        })\
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
      -- 2-7 右边\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022 }\
        local basePoint, posandcolor = transRelativePoint({\
          { 1667, 490, 0x000000 }, { 1666, 490, 0x31bee6 },\
          { 1667, 489, 0x000000 }, { 1666, 489, 0x29bade },\
          { 1668, 491, 0x000000 }, { 1667, 491, 0x31bee6 },\
          { 1668, 492, 0x000000 }, { 1667, 492, 0x29bade },\
        })\
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
      -- 4-7 右边\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022 }\
        local basePoint, posandcolor = transRelativePoint({\
          { 1738, 851, 0x000000 }, { 1737, 851, 0x3a75c5 },\
          { 1738, 850, 0x000000 }, { 1737, 850, 0x3a75c5 },\
          { 1739, 852, 0x000000 }, { 1738, 852, 0x3a79c5 },\
          { 1739, 853, 0x000000 }, { 1738, 853, 0x3175bd },\
        })\
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
    },\
    -- 我方舰队位置\
    myFleetList = imgBase.map.myFleetList,\
    -- 我放舰队被选中的舰队的绿色的选中箭头的位置\
    selectedArrow = imgBase.map.selectedArrow,\
    -- 敌方舰队位置(小型舰队)\
    enemyList1 = imgBase.map.enemyList1,\
    -- 敌方舰队位置(中型舰队)\
    enemyList2 = imgBase.map.enemyList2,\
    -- 敌方舰队位置(大型舰队)\
    enemyList3 = imgBase.map.enemyList3,\
    -- boss位置\
    bossPointList = imgBase.map.bossPointList,\
    -- 战斗中的位置\
    inBattleList = imgBase.map.inBattleList,\
    -- 奖励箱的位置\
    rewardBoxList = imgBase.map.rewardBoxList,\
  },\
}" }


package.sourceCode = package.sourceCode or {}
package.sourceCode["./meta-operation/maps-options/img1-4.lua"] = { path = "./meta-operation/maps-options/img1-4.lua", name = "./meta-operation/maps-options/img1-4.lua", source = "-- 存储图像信息，用于界面找色、找图。取代图片搜索，因为找色搜索的像素点更少\
local imgBase = require './img'\
\
local transRelativePoint = imgBase.transRelativePoint\
\
return {\
  transRelativePoint = transRelativePoint,\
  -- 基本方法\
  toPoint = imgBase.toPoint,\
  -- 过滤被右下角按钮挡住的部分的点，因为右下角按钮也是黑色的容易与边界识别混淆\
  filterNoUsePoint = imgBase.filterNoUsePoint,\
  -- 图片数据\
  -- 地图扫描\
  map = {\
    -- 地图上边界\
    topLineList = {\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022, }\
        local basePoint, posandcolor = transRelativePoint({\
          { 1089, 466, 0x213542 }, { 1109, 466, 0x192d3a },\
          { 1153, 466, 0x213542 }, { 1185, 466, 0x29414a },\
          { 1218, 466, 0x424d52 }, { 1238, 467, 0x31bede },\
          { 1207, 467, 0x31bede }, { 1175, 467, 0x31b6de },\
          { 1146, 467, 0x29b6de }, { 1117, 467, 0x29b2de },\
        })\
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
    },\
    -- 地图下边界\
    bottonLineList = {\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022 }\
        local basePoint, posandcolor = transRelativePoint({\
          { 285, 897, 0x000000 }, { 301, 897, 0x000000 },\
          { 313, 897, 0x000000 }, { 326, 897, 0x000000 },\
          { 339, 896, 0x1981c5 }, { 322, 896, 0x2083c2 },\
          { 307, 896, 0x2080c2 }, { 297, 896, 0x2181c5 },\
        })\
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
    },\
    -- 地图左边界\
    leftLineList = {\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022 }\
        local basePoint, posandcolor = transRelativePoint({\
          { 275, 796, 0x000000 }, { 276, 796, 0x288bca },\
          { 275, 795, 0x000000 }, { 276, 795, 0x2087ba },\
          { 274, 797, 0x000000 }, { 275, 797, 0x298ec5 },\
          { 274, 798, 0x000000 }, { 275, 798, 0x298ac5 },\
        })\
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
    },\
    -- 地图右边界\
    rightLineList = {\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022 }\
        local basePoint, posandcolor = transRelativePoint({\
          { 1669, 617, 0x000000 }, { 1668, 617, 0x29aed6 },\
          { 1669, 616, 0x000000 }, { 1668, 616, 0x29b2de },\
          { 1670, 618, 0x000000 }, { 1669, 618, 0x29aad6 },\
          { 1670, 619, 0x000000 }, { 1669, 619, 0x29aade },\
        })\
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
    },\
    -- 我方舰队位置\
    myFleetList = imgBase.map.myFleetList,\
    -- 我放舰队被选中的舰队的绿色的选中箭头的位置\
    selectedArrow = imgBase.map.selectedArrow,\
    -- 敌方舰队位置(小型舰队)\
    enemyList1 = imgBase.map.enemyList1,\
    -- 敌方舰队位置(中型舰队)\
    enemyList2 = imgBase.map.enemyList2,\
    -- 敌方舰队位置(大型舰队)\
    enemyList3 = imgBase.map.enemyList3,\
    -- boss位置\
    bossPointList = imgBase.map.bossPointList,\
    -- 战斗中的位置\
    inBattleList = imgBase.map.inBattleList,\
    -- 奖励箱的位置\
    rewardBoxList = imgBase.map.rewardBoxList,\
  },\
}" }


package.sourceCode = package.sourceCode or {}
package.sourceCode["./meta-operation/maps-options/img1-3.lua"] = { path = "./meta-operation/maps-options/img1-3.lua", name = "./meta-operation/maps-options/img1-3.lua", source = "-- 存储图像信息，用于界面找色、找图。取代图片搜索，因为找色搜索的像素点更少\
local imgBase = require './img'\
\
local transRelativePoint = imgBase.transRelativePoint\
\
return {\
  transRelativePoint = transRelativePoint,\
  -- 基本方法\
  toPoint = imgBase.toPoint,\
  -- 过滤被右下角按钮挡住的部分的点，因为右下角按钮也是黑色的容易与边界识别混淆\
  filterNoUsePoint = imgBase.filterNoUsePoint,\
  -- 图片数据\
  -- 地图扫描\
  map = {\
    -- 地图上边界\
    topLineList = {\
      -- 1-4 上方\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022, }\
        local basePoint, posandcolor = transRelativePoint({\
          { 1064, 470, 0x4a494a }, { 1105, 470, 0x21313a },\
          { 1153, 470, 0x192d42 }, { 1193, 470, 0x193142 },\
          { 1210, 471, 0x31bede }, { 1162, 471, 0x29bade },\
          { 1106, 471, 0x31b2de }, { 1076, 471, 0x29b6de },\
        })\
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
      -- 1-5 上方\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022, }\
        local basePoint, posandcolor = transRelativePoint({\
          { 1246, 470, 0x29394a }, { 1280, 470, 0x213952 },\
          { 1327, 470, 0x21394a }, { 1358, 470, 0x29394a },\
          { 1386, 471, 0x3abede }, { 1344, 471, 0x31c2d6 },\
          { 1307, 471, 0x42d7de }, { 1268, 471, 0x31bed6 },\
        })\
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
    },\
    -- 地图下边界\
    bottonLineList = {\
      -- 3-4 下方\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022 }\
        local basePoint, posandcolor = transRelativePoint({\
          { 1066, 887, 0x000000 }, { 1119, 887, 0x000000 },\
          { 1159, 887, 0x000000 }, { 1200, 887, 0x000000 },\
          { 1229, 886, 0x1055ad }, { 1171, 886, 0x104da4 },\
          { 1134, 886, 0x1051ad }, { 1099, 886, 0x104da4 },\
        })\
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
    },\
    -- 地图左边界\
    leftLineList = {\
      -- 3-1 左方\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022 }\
        local basePoint, posandcolor = transRelativePoint({\
          { 465, 824, 0x000000 }, { 466, 824, 0x2992c5 },\
          { 465, 823, 0x000000 }, { 466, 823, 0x218ac5 },\
          { 464, 825, 0x000000 }, { 465, 825, 0x218ec5 },\
          { 464, 826, 0x000000 }, { 465, 826, 0x218ec5 },\
        })\
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
    },\
    -- 地图右边界\
    rightLineList = {\
      -- 1-5 右方\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022 }\
        local basePoint, posandcolor = transRelativePoint({\
          { 1580, 501, 0x000000 }, { 1579, 501, 0x29a2de },\
          { 1580, 500, 0x000000 }, { 1579, 500, 0x29a2de },\
          { 1581, 502, 0x000000 }, { 1580, 502, 0x31a6de },\
          { 1581, 503, 0x000000 }, { 1580, 503, 0x29a2de },\
        })\
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
    },\
    -- 我方舰队位置\
    myFleetList = imgBase.map.myFleetList,\
    -- 我放舰队被选中的舰队的绿色的选中箭头的位置\
    selectedArrow = imgBase.map.selectedArrow,\
    -- 敌方舰队位置(小型舰队)\
    enemyList1 = imgBase.map.enemyList1,\
    -- 敌方舰队位置(中型舰队)\
    enemyList2 = imgBase.map.enemyList2,\
    -- 敌方舰队位置(大型舰队)\
    enemyList3 = imgBase.map.enemyList3,\
    -- boss位置\
    bossPointList = imgBase.map.bossPointList,\
    -- 战斗中的位置\
    inBattleList = imgBase.map.inBattleList,\
    -- 奖励箱的位置\
    rewardBoxList = imgBase.map.rewardBoxList,\
  },\
}" }


package.sourceCode = package.sourceCode or {}
package.sourceCode["./meta-operation/maps-options/img1-2.lua"] = { path = "./meta-operation/maps-options/img1-2.lua", name = "./meta-operation/maps-options/img1-2.lua", source = "-- 存储图像信息，用于界面找色、找图。取代图片搜索，因为找色搜索的像素点更少\
local imgBase = require './img'\
\
local transRelativePoint = imgBase.transRelativePoint\
\
return {\
  transRelativePoint = transRelativePoint,\
  -- 基本方法\
  toPoint = imgBase.toPoint,\
  -- 过滤被右下角按钮挡住的部分的点，因为右下角按钮也是黑色的容易与边界识别混淆\
  filterNoUsePoint = imgBase.filterNoUsePoint,\
  -- 图片数据\
  -- 地图扫描\
  map = {\
    -- 地图上边界\
    topLineList = {\
      -- 1-5 上边\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022, }\
        local basePoint, posandcolor = transRelativePoint({\
          { 1214, 409, 0x212d21 }, { 1231, 409, 0x424131 },\
          { 1255, 409, 0x293929 }, { 1276, 409, 0x212d21 },\
          { 1293, 409, 0x293531 }, { 1297, 410, 0x31bede },\
          { 1277, 410, 0x31bede }, { 1256, 410, 0x3ac6de },\
          { 1239, 410, 0x3ac6de }, { 1223, 410, 0x3ac6de },\
        })\
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
      -- 1-3 上边\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022, }\
        local basePoint, posandcolor = transRelativePoint({\
          { 851, 409, 0x314132 }, { 872, 409, 0x314131 },\
          { 891, 409, 0x424942 }, { 912, 409, 0x4a4942 },\
          { 923, 410, 0x31bade }, { 903, 410, 0x3abede },\
          { 879, 410, 0x4aceef }, { 852, 410, 0x3abade },\
        })\
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
    },\
    -- 地图下边界\
    bottonLineList = {\
      -- 3-1 下边\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022 }\
        local basePoint, posandcolor = transRelativePoint({\
          { 410, 837, 0x000000 }, { 424, 837, 0x000000 },\
          { 445, 837, 0x000000 }, { 469, 837, 0x000000 },\
          { 481, 836, 0x197dbd }, { 459, 836, 0x197dbd },\
          { 442, 836, 0x2181c5 }, { 421, 836, 0x2181c5 },\
        })\
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
      -- 3-1 下边\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022 }\
        local basePoint, posandcolor = transRelativePoint({\
          { 836, 627, 0x000000 }, { 848, 627, 0x000000 },\
          { 859, 627, 0x000000 }, { 871, 627, 0x000000 },\
          { 880, 626, 0x207cc2 }, { 866, 626, 0x2080c2 },\
          { 852, 626, 0x2181c5 }, { 841, 626, 0x187cba },\
        })\
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
    },\
    -- 地图左边界\
    leftLineList = {\
      -- 3-1 左边\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022 }\
        local basePoint, posandcolor = transRelativePoint({\
          { 402, 772, 0x000400 }, { 403, 772, 0x298ec5 },\
          { 402, 771, 0x000000 }, { 403, 771, 0x298ec5 },\
          { 401, 773, 0x000000 }, { 402, 773, 0x218ac6 },\
          { 401, 774, 0x000000 }, { 402, 774, 0x298ece },\
        })\
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
    },\
    -- 地图右边界\
    rightLineList = {\
      -- 1-5 右边\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022 }\
        local basePoint, posandcolor = transRelativePoint({\
          { 1386, 454, 0x000000 }, { 1385, 454, 0x299ade },\
          { 1386, 453, 0x000000 }, { 1385, 453, 0x299ee6 },\
          { 1387, 455, 0x000000 }, { 1386, 455, 0x299ade },\
          { 1387, 456, 0x000000 }, { 1386, 456, 0x299ee6 },\
        })\
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
      -- 3-5 右边\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022 }\
        local basePoint, posandcolor = transRelativePoint({\
          { 1423, 713, 0x000001 }, { 1422, 713, 0x3175bd },\
          { 1423, 712, 0x000000 }, { 1422, 712, 0x3a79c5 },\
          { 1424, 714, 0x000000 }, { 1423, 714, 0x3a75c5 },\
          { 1424, 715, 0x000000 }, { 1423, 715, 0x4275c5 },\
        })\
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
    },\
    -- 我方舰队位置\
    myFleetList = imgBase.map.myFleetList,\
    -- 我放舰队被选中的舰队的绿色的选中箭头的位置\
    selectedArrow = imgBase.map.selectedArrow,\
    -- 敌方舰队位置(小型舰队)\
    enemyList1 = imgBase.map.enemyList1,\
    -- 敌方舰队位置(中型舰队)\
    enemyList2 = imgBase.map.enemyList2,\
    -- 敌方舰队位置(大型舰队)\
    enemyList3 = imgBase.map.enemyList3,\
    -- boss位置\
    bossPointList = imgBase.map.bossPointList,\
    -- 战斗中的位置\
    inBattleList = imgBase.map.inBattleList,\
    -- 奖励箱的位置\
    rewardBoxList = imgBase.map.rewardBoxList,\
  },\
}" }


package.sourceCode = package.sourceCode or {}
package.sourceCode["./meta-operation/maps-options/img1-1.lua"] = { path = "./meta-operation/maps-options/img1-1.lua", name = "./meta-operation/maps-options/img1-1.lua", source = "-- 存储图像信息，用于界面找色、找图。取代图片搜索，因为找色搜索的像素点更少\
local imgBase = require './img'\
\
local transRelativePoint = imgBase.transRelativePoint\
\
return {\
  transRelativePoint = transRelativePoint,\
  -- 基本方法\
  toPoint = imgBase.toPoint,\
  -- 过滤被右下角按钮挡住的部分的点，因为右下角按钮也是黑色的容易与边界识别混淆\
  filterNoUsePoint = imgBase.filterNoUsePoint,\
  -- 图片数据\
  -- 地图扫描\
  map = {\
    -- 地图上边界\
    topLineList = {\
      -- 1-2 上边\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022, }\
        local basePoint, posandcolor = transRelativePoint({\
          { 644, 576, 0x21354a }, { 663, 576, 0x213142 },\
          { 681, 576, 0x213142 }, { 699, 576, 0x213142 },\
          { 716, 576, 0x29354a }, { 725, 577, 0x31a2de },\
          { 699, 577, 0x29a6de }, { 683, 577, 0x29a6de },\
          { 664, 577, 0x29a6de }, { 644, 577, 0x31aade },\
        })\
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
      -- 1-4 上边\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022, }\
        local basePoint, posandcolor = transRelativePoint({\
          { 971, 576, 0x21394a }, { 993, 576, 0x29394a },\
          { 1013, 576, 0x21394a }, { 1033, 576, 0x21394a },\
          { 1054, 576, 0x213952 }, { 1067, 577, 0x31bade },\
          { 1045, 577, 0x31bede }, { 1025, 577, 0x31b6de },\
          { 1005, 577, 0x31b6de }, { 982, 577, 0x29b6d6 },\
        })\
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
    },\
    -- 地图下边界\
    bottonLineList = {\
      -- 1-2 下边\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022 }\
        local basePoint, posandcolor = transRelativePoint({\
          { 573, 715, 0x000000 }, { 600, 715, 0x000000 },\
          { 620, 715, 0x000000 }, { 642, 715, 0x000000 },\
          { 662, 714, 0x195d9c }, { 639, 714, 0x105994 },\
          { 612, 714, 0x21619c }, { 588, 714, 0x21619c },\
        })\
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
    },\
    -- 地图左边界\
    leftLineList = {\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022, }\
        local basePoint, posandcolor = transRelativePoint({\
          { 285, 362, 0x000000 }, { 286, 362, 0x31b6de },\
          { 285, 363, 0x000000 }, { 286, 363, 0x31b2d6 },\
          { 284, 364, 0x000000 }, { 285, 364, 0x31b2de },\
          { 284, 365, 0x000000 }, { 285, 365, 0x31b6de },\
        })\
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
    },\
    -- 地图右边界\
    rightLineList = {\
      (function()\
        local leftTop = { 185, 155 }\
        local rightBotton = { 1899, 1022, }\
        local basePoint, posandcolor = transRelativePoint({\
          { 1800, 297, 0x299ade }, { 1801, 297, 0x000000 },\
          { 1800, 298, 0x299ee6 }, { 1801, 298, 0x000000 },\
          { 1801, 299, 0x299ae6 }, { 1802, 299, 0x000000 },\
          { 1801, 300, 0x299ae6 }, { 1802, 300, 0x000408 },\
        })\
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }\
      end)(),\
    },\
    -- 我方舰队位置\
    myFleetList = imgBase.map.myFleetList,\
    -- 我放舰队被选中的舰队的绿色的选中箭头的位置\
    selectedArrow = imgBase.map.selectedArrow,\
    -- 敌方舰队位置(小型舰队)\
    enemyList1 = imgBase.map.enemyList1,\
    -- 敌方舰队位置(中型舰队)\
    enemyList2 = imgBase.map.enemyList2,\
    -- 敌方舰队位置(大型舰队)\
    enemyList3 = imgBase.map.enemyList3,\
    -- boss位置\
    bossPointList = imgBase.map.bossPointList,\
    -- 战斗中的位置\
    inBattleList = imgBase.map.inBattleList,\
    -- 奖励箱的位置\
    rewardBoxList = imgBase.map.rewardBoxList,\
  },\
}" }


package.sourceCode = package.sourceCode or {}
package.sourceCode["./meta-operation/maps-options/map.lua"] = { path = "./meta-operation/maps-options/map.lua", name = "./meta-operation/maps-options/map.lua", source = "local utils = require './utils'\
local AStart = require '../../utils/a-start'\
local _sWidth, _sHeight = getScreenSize();\
local sWidth = math.max(_sWidth, _sHeight)\
local sHeight = math.min(_sWidth, _sHeight)\
\
local map = {}\
\
\
-- 舰队坐标修正向量\
local myFleetListCorrectionValue = (function()\
  local point = {\
    { 965, 474, 0xded28c },\
    { 909, 689, 0x313531 },\
  }\
  return { point[2][1] - point[1][1], point[2][2] - point[1][2] }\
end)()\
-- 选中的舰队头上的绿色箭头的坐标修正向量\
local selectedArrowCorrectionValue = (function()\
  local point = {\
    { 455, 272, 0x3aff84 },\
    { 456, 568, 0xa49ead },\
  }\
  return { point[2][1] - point[1][1], point[2][2] - point[1][2] }\
end)()\
-- 敌人坐标修正向量\
local enemyListCorrectionValue = (function()\
  local point = {\
    { 1082, 528, 0xa43d10 },\
    { 1152, 619, 0xf7f7ef },\
  }\
  return { point[2][1] - point[1][1], point[2][2] - point[1][2] }\
end)()\
-- 奖励点坐标修正向量\
local rewardBoxListCorrectionValue = (function()\
  local point = {\
    { 1126, 859, 0x8cffef },\
    { 1122, 939, 0x000810 },\
  }\
  return { point[2][1] - point[1][1], point[2][2] - point[1][2] }\
end)()\
-- 坐标修正偏差方法，因为搜索的图像并不在它所在的棋盘格子里\
local corrected = function(list, correctionValue)\
  local res = {}\
  for key = 1, #list do\
    local item = list[key]\
    table.insert(res, { item[1] + correctionValue[1], item[2] + correctionValue[2] })\
  end\
  return res\
end\
\
\
-- 将数组形式的棋盘坐标列表转换为索引形式的，为了方便去重和查找\
-- 例如：\
-- local list = {\
--   { 1, 2 },\
--   { 3, 4 },\
-- }\
-- 转换为\
-- local list = {\
--   ['1-2'] = { 1, 2 }\
--   ['3-4'] = { 3, 4 }\
-- }\
local function transListToMap(list)\
  local result = {}\
  for _, item in pairs(list) do\
    result[item[1] .. '-' .. item[2]] = item\
  end\
  return result\
end\
\
-- 检查坐标点在直线的左边还是右边，直线用两点表示\
local function checkPointPosition(checkPoint, topPoint, bottonPoint)\
  if topPoint[2] == bottonPoint[2] then\
    if checkPoint[1] < topPoint[1] then\
      return -1\
    elseif checkPoint[1] > topPoint[1] then\
      return 1\
    end\
    return 0\
  end\
  local x = (checkPoint[2] - topPoint[2]) * (bottonPoint[1] - topPoint[1]) / (bottonPoint[2] - topPoint[2]) + topPoint[1]\
  if checkPoint[1] < x then\
    return -1\
  elseif checkPoint[1] > x then\
    return 1\
  end\
  return 0\
end\
\
-- 将屏幕坐标列表转换为地图棋盘坐标列表\
local function transPointListToChessboardPointList(positionMap, positionList)\
  local result = {}\
  -- 因为有可能有空的坐标，所以需要处理\
  -- 计算出地图棋盘的宽度\
  local height = #positionMap\
  local width = 0\
  for _, row in ipairs(positionMap) do\
    if row then\
      width = math.max(width, #row)\
    end\
  end\
  for i = 1, #positionList do\
    local theRow = -1\
    local theCol = -1\
    local item = positionList[i]\
    -- 匹配点在第几行。\
    -- 保证匹配的点在检查的棋盘里，棋盘之外的目标不放入棋盘\
    for rowNum, row in ipairs(positionMap) do\
      if row then\
        local theRowPoint = nil\
        for _, col in ipairs(row) do\
          if col then\
            theRowPoint = col\
            break\
          end\
        end\
        if theRowPoint[2] < item[2] then\
          theRow = rowNum\
        else\
          break\
        end\
      end\
    end\
    if theRow > #positionMap - 1 then\
      theRow = -1\
    end\
\
    if theRow > 0 then\
      -- 匹配点在第几列\
      -- 保存最左边那条线的两个点，匹配目標必須在第1条线和第n条线的中间\
      -- 避免匹配到第1条线左边的点\
      local firstTopPoint = nil\
      local firstBottonPoint = nil\
      for col = 1, width do\
        -- 寻找这一列最高和最低的两个点，做直线\
        local topPoint\
        local bottonPoint\
        for row = 1, height do\
          if positionMap[row] and positionMap[row][col] then\
            if not topPoint then\
              topPoint = positionMap[row][col]\
            else\
              bottonPoint = positionMap[row][col]\
            end\
          end\
        end\
        if topPoint and bottonPoint then\
          if checkPointPosition(item, topPoint, bottonPoint) > 0 then\
            theCol = col\
          else\
            break\
          end\
        end\
      end\
      if theCol > width - 1 then\
        theCol = -1\
      end\
      if theCol > 0 then\
        table.insert(result, { theRow, theCol })\
      end\
    end\
  end\
  return result\
end\
\
-- 将地图棋盘坐标列表转换为屏幕坐标列表\
local function transChessboardPointListToPositionList(positionMap, pointList)\
  local result = {}\
  for _, item in pairs(pointList) do\
    local leftTop = positionMap[item[1]][item[2]]\
    local rightTop = positionMap[item[1]][item[2] + 1]\
    local leftBotton = positionMap[item[1] + 1][item[2]]\
    local rightBotton = positionMap[item[1] + 1][item[2] + 1]\
    local theLeft = (leftTop[1] + rightTop[1] + leftBotton[1] + rightBotton[1]) / 4\
    local theTop = (leftTop[2] + rightTop[2] + leftBotton[2] + rightBotton[2]) / 4\
    theLeft = math.floor(theLeft)\
    theTop = math.floor(theTop)\
    table.insert(result, { theLeft, theTop })\
  end\
  return result\
end\
\
\
-- 搜索一个颜色列表\
local function findMultiColorList(ImgInfo, list, simpleMode)\
  local res = {}\
  for key = 1, #list do\
    local myFleet = list[key]\
    res = table.merge(res, findMultiColorInRegionFuzzyExt(table.unpack(myFleet)))\
    if simpleMode and #res > 0 then\
      break\
    end\
  end\
  return ImgInfo.toPoint(res)\
end\
\
-- 将列表转换成索引方便查询\
local function makePointMap(list)\
  local theMap = {}\
  for key = 1, #list do\
    local point = list[key]\
    theMap[point[1] .. '-' .. point[2]] = point\
  end\
  return theMap\
end\
\
\
-- 获取地图采样位置。由于地图可能超出一屏，所以这里可以定义多个采样位置。每次扫描都会对每个采样位置进行扫描\
-- 标志位为地图四个角。每个采样位置只需定义一个角的坐标即可。\
-- 还需要定义每个采样位置的地图矩阵与屏幕坐标的映射关系\
map.getCheckpositionList = function()\
  return {}\
end\
\
-- 获取地图棋盘和相关数据\
map.getMapChessboard = function()\
  return {}\
end\
\
-- 检查地图在屏幕中的位置，返回地图四个角的坐标\
map.getMapPosition = function(ImgInfo, targetPosition)\
  local __keepScreenState = keepScreenState\
  if __keepScreenState then keepScreen(false) end\
  keepScreen(true)\
  local isCenter = false\
  -- 扫描边界\
  keepScreen(true)\
  -- 需要扫描哪几个角，不需要扫描的角就跳过以加快扫描速度\
  local topLinePointList = {}\
  local bottonLinePointList = {}\
  local leftLinePointList = {}\
  local rightLinePointList = {}\
  if targetPosition.leftTop then\
    topLinePointList = ImgInfo.filterNoUsePoint(findMultiColorList(ImgInfo, ImgInfo.map.topLineList, true))\
    leftLinePointList = ImgInfo.filterNoUsePoint(findMultiColorList(ImgInfo, ImgInfo.map.leftLineList))\
  end\
  if targetPosition.rightTop then\
    topLinePointList = ImgInfo.filterNoUsePoint(findMultiColorList(ImgInfo, ImgInfo.map.topLineList, true))\
    rightLinePointList = ImgInfo.filterNoUsePoint(findMultiColorList(ImgInfo, ImgInfo.map.rightLineList))\
  end\
  if targetPosition.leftBotton then\
    bottonLinePointList = ImgInfo.filterNoUsePoint(findMultiColorList(ImgInfo, ImgInfo.map.bottonLineList, true))\
    leftLinePointList = ImgInfo.filterNoUsePoint(findMultiColorList(ImgInfo, ImgInfo.map.leftLineList))\
  end\
  if targetPosition.rightBotton then\
    bottonLinePointList = ImgInfo.filterNoUsePoint(findMultiColorList(ImgInfo, ImgInfo.map.bottonLineList, true))\
    rightLinePointList = ImgInfo.filterNoUsePoint(findMultiColorList(ImgInfo, ImgInfo.map.rightLineList))\
  end\
\
  function findMostYPointList(pointList)\
    local mostPointMap = {}\
    for key = 1, #pointList do\
      local point = pointList[key]\
      mostPointMap[point[2]] = mostPointMap[point[2]] or {}\
      table.insert(mostPointMap[point[2]], point)\
    end\
    return math.maxTable(mostPointMap, function(item) return #item end) or {}\
  end\
\
  local topLinePoint = findMostYPointList(topLinePointList)[1] or { -1, -1 }\
  local bottonLinePoint = findMostYPointList(bottonLinePointList)[1] or { -1, -1 }\
\
  function getTopAndBottonPoint(topLinePoint, bottonLinePoint, pointList)\
    -- 获取左右边界的上下两点(就是算四个叫的坐标)\
    -- 这个函数求一条斜边的上点和下点，需要2次才能计算出四个角\
    -- 结果第一个是上点，第二个是下点\
    local result = { false, false }\
    if pointList and #pointList > 0 then\
      local point1 = math.minTable(pointList, 2) or { -1, -1 }\
      local point2 = math.maxTable(pointList, 2) or { -1, -1 }\
      if topLinePoint and topLinePoint[1] > 0 then\
        local Y1 = math.floor(topLinePoint[2])\
        local X1 = (Y1 - point1[2]) / (point2[2] - point1[2]) * (point2[1] - point1[1]) + point1[1] or -1\
        X1 = math.trueNumber(X1) or -1\
        X1 = math.floor(X1)\
        if X1 > 0 then\
          result[1] = { X1, Y1 }\
        end\
      end\
      if bottonLinePoint and bottonLinePoint[1] > 0 then\
        local Y2 = math.floor(bottonLinePoint[2])\
        local X2 = (Y2 - point1[2]) / (point2[2] - point1[2]) * (point2[1] - point1[1]) + point1[1] or -1\
        X2 = math.trueNumber(X2) or -1\
        X2 = math.floor(X2)\
        if X2 > 0 then\
          result[2] = { X2, Y2 }\
        end\
      end\
    end\
    return result\
  end\
\
  local leftPoint = getTopAndBottonPoint(topLinePoint, bottonLinePoint, leftLinePointList)\
  local rightPoint = getTopAndBottonPoint(topLinePoint, bottonLinePoint, rightLinePointList)\
\
  if not __keepScreenState then keepScreen(false) end\
  return {\
    leftTop = leftPoint[1],\
    rightTop = rightPoint[1],\
    leftBotton = leftPoint[2],\
    rightBotton = rightPoint[2],\
  }\
end\
\
-- 检查地图位置与预设位置的偏差\
map.getMoveVector = function(ImgInfo, currentPosition, targetPosition)\
  local __keepScreenState = keepScreenState\
  if __keepScreenState then keepScreen(false) end\
  keepScreen(true)\
\
  -- 计算偏差\
  local moveVector = { 0, 0 }\
  local effectiveStep = false\
  if targetPosition.leftTop then\
    if not currentPosition.leftTop then\
      moveVector = { sWidth / 3, sHeight / 3 }\
    else\
      effectiveStep = true\
      moveVector[1] = targetPosition.leftTop[1] - currentPosition.leftTop[1];\
      moveVector[2] = targetPosition.leftTop[2] - currentPosition.leftTop[2];\
    end\
  elseif targetPosition.rightTop then\
    if not currentPosition.rightTop then\
      moveVector = { (0 - sWidth) / 3, sHeight / 3 }\
    else\
      effectiveStep = true\
      moveVector[1] = targetPosition.rightTop[1] - currentPosition.rightTop[1];\
      moveVector[2] = targetPosition.rightTop[2] - currentPosition.rightTop[2];\
    end\
  elseif targetPosition.leftBotton then\
    if not currentPosition.leftBotton then\
      moveVector = { sWidth / 3, (0 - sHeight) / 3 }\
    else\
      effectiveStep = true\
      moveVector[1] = targetPosition.leftBotton[1] - currentPosition.leftBotton[1];\
      moveVector[2] = targetPosition.leftBotton[2] - currentPosition.leftBotton[2];\
    end\
  elseif targetPosition.rightBotton then\
    if not currentPosition.rightBotton then\
      moveVector = { (0 - sWidth) / 3, (0 - sHeight) / 3 }\
    else\
      effectiveStep = true\
      moveVector[1] = targetPosition.rightBotton[1] - currentPosition.rightBotton[1]\
      moveVector[2] = targetPosition.rightBotton[2] - currentPosition.rightBotton[2]\
    end\
  end\
\
  if moveVector[1] > 25 then\
    moveVector[1] = math.floor(moveVector[1] * 0.6)\
  else\
    moveVector[1] = math.floor(moveVector[1] * 0.8)\
  end\
  if moveVector[2] > 25 then\
    moveVector[2] = math.floor(moveVector[2] * 0.6)\
  else\
    moveVector[2] = math.floor(moveVector[2] * 0.8)\
  end\
\
  if not __keepScreenState then keepScreen(false) end\
  return moveVector, effectiveStep\
end\
\
-- 将地图移动到指定位置\
map.moveMapToCheckPosition = function(ImgInfo, moveVector)\
  local isCenter = false;\
  local minLength = 5\
\
  -- 将地图移动到中心\
  local moveStep\
  if (math.abs(moveVector[1]) > minLength) or (math.abs(moveVector[2]) > minLength) then\
    -- 因为屏幕滑动和画面滚动不一致，所以需要减少移动幅度\
    moveStep = math.max(math.abs(moveVector[1]), math.abs(moveVector[2]))\
    moveStep = math.abs(moveStep)\
    moveStep = moveStep / 8\
    moveStep = math.min(25, moveStep)\
    moveStep = math.max(1, moveStep)\
    moveStep = math.floor(moveStep)\
    moveTo(sWidth / 2, sHeight / 2, sWidth / 2 + moveVector[1], sHeight / 2 + moveVector[2], moveStep, 100)\
  else\
    isCenter = true\
  end\
  return isCenter, moveStep\
end\
\
-- 扫描地图\
map.scanMap = function(ImgInfo, targetPosition, mapChessboard)\
  local __keepScreenState = keepScreenState\
  if __keepScreenState then keepScreen(false) end\
  keepScreen(true)\
  local positionMap = targetPosition.positionMap\
\
  -- 扫描屏幕上的对象\
  local myFleetPositionList = ImgInfo.filterNoUsePoint(findMultiColorList(ImgInfo, ImgInfo.map.myFleetList))\
  myFleetPositionList = corrected(myFleetPositionList, myFleetListCorrectionValue)\
\
  local selectedArrowPositionList = ImgInfo.filterNoUsePoint(findMultiColorList(ImgInfo, ImgInfo.map.selectedArrow))\
  selectedArrowPositionList = corrected(selectedArrowPositionList, selectedArrowCorrectionValue)\
  local enemyList1 = ImgInfo.filterNoUsePoint(findMultiColorList(ImgInfo, ImgInfo.map.enemyList1))\
  enemyList1 = corrected(enemyList1, enemyListCorrectionValue)\
  local enemyList2 = ImgInfo.filterNoUsePoint(findMultiColorList(ImgInfo, ImgInfo.map.enemyList2))\
  enemyList2 = corrected(enemyList2, enemyListCorrectionValue)\
  local enemyList3 = ImgInfo.filterNoUsePoint(findMultiColorList(ImgInfo, ImgInfo.map.enemyList3))\
  enemyList3 = corrected(enemyList3, enemyListCorrectionValue)\
  local rewardBoxPointList = ImgInfo.filterNoUsePoint(findMultiColorList(ImgInfo, ImgInfo.map.rewardBoxList))\
  rewardBoxPointList = corrected(rewardBoxPointList, rewardBoxListCorrectionValue)\
  local bossPointList = ImgInfo.filterNoUsePoint(findMultiColorList(ImgInfo, ImgInfo.map.bossPointList))\
  local inBattlePointList = ImgInfo.filterNoUsePoint(findMultiColorList(ImgInfo, ImgInfo.map.inBattleList))\
\
  local inBattleList = utils.unionList(mapChessboard.inBattleList, transPointListToChessboardPointList(positionMap, inBattlePointList))\
  local selectedArrowList = utils.unionList(mapChessboard.selectedArrowList, transPointListToChessboardPointList(positionMap, selectedArrowPositionList))\
  local myFleetList = utils.unionList(selectedArrowList, transPointListToChessboardPointList(positionMap, myFleetPositionList))\
  -- 假如舰队和敌方重合了，我方标记会偏下一格，导致扫描结果有偏差。进行修正\
  local inBattleMap = makePointMap(inBattleList)\
  for key = 1, #myFleetList do\
    local point = myFleetList[key]\
    if inBattleMap[(point[1] - 1) .. '-' .. point[2]] then\
      myFleetList[key][1] = point[1] - 1\
    end\
  end\
  myFleetList = utils.unionList(myFleetList, mapChessboard.myFleetList)\
  local enemyPositionList1 = utils.unionList(mapChessboard.enemyPositionList1, transPointListToChessboardPointList(positionMap, enemyList1))\
\
  local enemyPositionList2 = utils.unionList(mapChessboard.enemyPositionList2, transPointListToChessboardPointList(positionMap, enemyList2))\
  local enemyPositionList3 = utils.unionList(mapChessboard.enemyPositionList3, transPointListToChessboardPointList(positionMap, enemyList3))\
  local rewardBoxList = utils.unionList(mapChessboard.rewardBoxList, transPointListToChessboardPointList(positionMap, rewardBoxPointList))\
  local enemyPositionList = utils.unionList(enemyPositionList1, enemyPositionList2, enemyPositionList3)\
  local bossPosition = utils.unionList(mapChessboard.bossPosition, transPointListToChessboardPointList(positionMap, bossPointList))\
  -- 只有一个boss，如果出现多个boss的情况取最后一个\
  bossPosition = #bossPosition > 1 and { bossPosition[#bossPosition] } or bossPosition\
  -- 如果boss出现在敌人列表里，那么说明这个位置不是boss\
  bossPosition = utils.subtractionList(bossPosition, enemyPositionList)\
  -- 如果我方舰队在敌人列表里但是不在战斗中列表里，说明这个位置的敌人已经消灭了\
  local myFleetListNotInBattle = utils.subtractionList(myFleetList, inBattleList)\
  enemyPositionList1 = utils.subtractionList(enemyPositionList1, myFleetListNotInBattle)\
  enemyPositionList2 = utils.subtractionList(enemyPositionList2, myFleetListNotInBattle)\
  enemyPositionList3 = utils.subtractionList(enemyPositionList3, myFleetListNotInBattle)\
\
  local newMapChessboard = table.assign({}, mapChessboard, {\
    inBattleList = inBattleList,\
    selectedArrowList = selectedArrowList,\
    myFleetList = myFleetList,\
    rewardBoxList = rewardBoxList,\
    enemyPositionList1 = enemyPositionList1,\
    enemyPositionList2 = enemyPositionList2,\
    enemyPositionList3 = enemyPositionList3,\
    bossPosition = bossPosition,\
  })\
\
  if not __keepScreenState then keepScreen(false) end\
  return newMapChessboard\
end\
\
-- 合并新老版本的地图数据\
map.assignMapChessboard = function(ImgInfo, mapChessboard, newMapChessboard)\
  -- 将我方舰队上方和右上方和右边的敌人找到，并保存下来。因为扫描时会被遮挡，所以从上次敌人列表中寻找\
  local checkMyFleetList = utils.subtractionList(newMapChessboard.myFleetList, newMapChessboard.inBattleList)\
  local checkMyFleetMap = makePointMap(checkMyFleetList)\
  function findMyFleetTopRightEnemy(el)\
    local res = {}\
    for key, enemy in ipairs(el) do\
      if checkMyFleetMap[(enemy[1] + 1) .. '-' .. enemy[2]]\
        or checkMyFleetMap[(enemy[1] + 1) .. '-' .. (enemy[2] - 1)]\
        or checkMyFleetMap[(enemy[1]) .. '-' .. (enemy[2] - 1)] then\
        table.insert(res, enemy)\
      end\
    end\
    return res\
  end\
\
  local theMapChessBoard = table.assign({}, newMapChessboard, {\
    rewardBoxList = utils.unionList(newMapChessboard.rewardBoxList, findMyFleetTopRightEnemy(mapChessboard.rewardBoxList)),\
    enemyPositionList1 = utils.unionList(newMapChessboard.enemyPositionList1, findMyFleetTopRightEnemy(mapChessboard.enemyPositionList1)),\
    enemyPositionList2 = utils.unionList(newMapChessboard.enemyPositionList2, findMyFleetTopRightEnemy(mapChessboard.enemyPositionList2)),\
    enemyPositionList3 = utils.unionList(newMapChessboard.enemyPositionList3, findMyFleetTopRightEnemy(mapChessboard.enemyPositionList3)),\
    bossPosition = utils.unionList(newMapChessboard.bossPosition, mapChessboard.bossPosition),\
  })\
  return theMapChessBoard\
end\
\
map.moveToPoint = function(ImgInfo, targetPosition, point)\
  local positionMap = targetPosition.positionMap\
  local tapPointList = transChessboardPointListToPositionList(positionMap, { point })\
  tap(tapPointList[1][1], tapPointList[1][2], 100)\
end\
\
map.checkMoveToPointPath = function(ImgInfo, mapChessboard, start, target)\
  local enemyPositionList = utils.unionList(mapChessboard.enemyPositionList1, mapChessboard.enemyPositionList2, mapChessboard.enemyPositionList3)\
  local enemyPositionListExceptTarget = utils.subtractionList(enemyPositionList, { target })\
  local theObstacle = utils.unionList(mapChessboard.obstacle, enemyPositionListExceptTarget)\
  local thePath = AStart(start, target, {\
    width = mapChessboard.width,\
    height = mapChessboard.height,\
    obstacle = theObstacle,\
  })\
  -- 如果到达不了目标，说明道路被其他敌人堵死了，\
  -- 那么就不考虑敌人，只寻找到目标的路径，然后在寻找路径上的敌人一路打过去\
  if not thePath or #thePath == 0 then\
    thePath = AStart(start, target, {\
      width = mapChessboard.width,\
      height = mapChessboard.height,\
      obstacle = mapChessboard.obstacle,\
    })\
  end\
  local targetPath = {}\
\
  -- 检查路径上是否有其他敌方舰队，如果有就点击\
  if thePath and #thePath > 0 then\
    local enemyPositionMap = transListToMap(enemyPositionList)\
    for key = 1, #thePath do\
      local p = thePath[key]\
      table.insert(targetPath, p)\
      if enemyPositionMap[p[1] .. '-' .. p[2]] then\
        return p, targetPath, thePath\
      end\
    end\
  end\
\
  local target = thePath and thePath[#thePath]\
  return target, thePath, thePath\
end\
\
map.findClosestEnemy = function(ImgInfo, mapChessboard, myFleed, myFleed2)\
  -- 取得等待boss位置，因为清除boss附近的小怪会更有效率\
  local waitForBossPosition = mapChessboard.waitForBossPosition[1]\
  -- 除了3种敌人的位置，还会考虑奖励点的位置，方便获取额外奖励\
  local myField = myFleed or mapChessboard.myFleetList[1]\
  local myField2 = myFleed2 or mapChessboard.myFleetList[2]\
  local rewardBoxList = table.map(mapChessboard.rewardBoxList, function(enemy)\
    return table.assign({}, enemy, { weight = 0 })\
  end)\
  local enemyPositionList1 = table.map(mapChessboard.enemyPositionList1, function(enemy)\
    return table.assign({}, enemy, { weight = 5 })\
  end)\
  local enemyPositionList2 = table.map(mapChessboard.enemyPositionList2, function(enemy)\
    return table.assign({}, enemy, { weight = 7 })\
  end)\
  local enemyPositionList3 = table.map(mapChessboard.enemyPositionList3, function(enemy)\
    return table.assign({}, enemy, { weight = 10 })\
  end)\
  -- 所有敌人的列表\
  local enemyPositionList = utils.unionList(rewardBoxList, enemyPositionList1, enemyPositionList2, enemyPositionList3)\
  local enemyPositionMap = {}\
  for key = 1, #enemyPositionList do\
    local value = enemyPositionList[key]\
    enemyPositionMap[value[1] .. '-' .. value[2]] = value\
  end\
  local theObstacle = utils.unionList(mapChessboard.obstacle, enemyPositionList)\
\
  local inBattleList = mapChessboard.inBattleList\
  local minCoast = nil\
  local minCoastEnemy = nil\
  local minCoastPath = nil\
\
  for key = 1, #enemyPositionList do\
    local enemy = enemyPositionList[key]\
    if not myField2 or enemy[1] ~= myField2[1] or enemy[2] ~= myField2[2] then\
      -- 这里将敌人视为高权重方块，因为1.4.77版本之后我方舰队会绕过路途中的敌人走向目标。\
      local thePath = AStart(myField, enemy, {\
        width = mapChessboard.width,\
        height = mapChessboard.height,\
        obstacle = theObstacle,\
      })\
      if thePath and #thePath > 0 then\
        -- 将权重也加入到coast里以便让结果倾向选择小型舰队\
        local weight = enemy.weight or 0\
        local theCoast = thePath[#thePath].G + weight\
        -- 计算敌人到boss的距离，因为清除boss附近的小怪会更有效率\
        -- 现在会自动识别路上阻拦的敌人所以不需要这个功能了\
        --        if waitForBossPosition then\
        --          -- 这里将敌人视为高权重方块，因为1.4.77版本之后我方舰队会绕过路途中的敌人走向目标。\
        --          local boosPath = AStart(waitForBossPosition, enemy, {\
        --            width = mapChessboard.width,\
        --            height = mapChessboard.height,\
        --            obstacle = theObstacle,\
        --          })\
        --          if boosPath and #boosPath > 0 then\
        --            theCoast = theCoast + boosPath[#boosPath].G * 0.1\
        --          end\
        --        end\
        if not minCoast or minCoast > theCoast then\
          minCoast = theCoast\
          minCoastEnemy = enemy\
          minCoastPath = thePath\
          -- 如果此时路线还是穿过别的舰队了，说明穿过别的舰队是必经之路，所以我们先走到最近的一个敌人上\
          for key = 1, #thePath do\
            local value = thePath[key]\
            if enemyPositionMap[value[1] .. '-' .. value[2]] then\
              minCoastEnemy = value\
              break;\
            end\
          end\
        end\
      end\
    end\
  end\
\
  return minCoastEnemy, minCoastPath\
end\
\
-- 向四周随意移动一步\
map.getRandomMoveAStep = function(ImgInfo, mapChessboard)\
  local myFleet = mapChessboard.myFleetList[1]\
  local width = mapChessboard.width\
  local height = mapChessboard.height\
  -- 尽可能选择空地\
  local enemyList1Map = transListToMap(mapChessboard.enemyPositionList1)\
  local enemyList2Map = transListToMap(mapChessboard.enemyPositionList2)\
  local enemyList3Map = transListToMap(mapChessboard.enemyPositionList3)\
  local obstacleMap = transListToMap(mapChessboard.obstacle)\
  local checkList = {\
    { myFleet[1] - 1, myFleet[2], coast = nil }, -- topPoint\
    { myFleet[1] + 1, myFleet[2], coast = nil }, -- bottonPoint\
    { myFleet[1], myFleet[2] - 1, coast = nil }, -- leftPoint\
    { myFleet[1], myFleet[2] + 1, coast = nil }, -- rightPoint\
  }\
  local canUseList = {}\
  for key, point in ipairs(checkList) do\
    if point[1] >= 1 and point[1] <= width and point[2] >= 1 and point[2] <= height\
      and not obstacleMap[point[1] .. '-' .. point[2]] then\
      if enemyList3Map[point[1] .. '-' .. point[2]] then\
        checkList[key].coast = 3\
      elseif enemyList2Map[point[1] .. '-' .. point[2]] then\
        checkList[key].coast = 2\
      elseif enemyList1Map[point[1] .. '-' .. point[2]] then\
        checkList[key].coast = 1\
      end\
      table.insert(canUseList, checkList[key])\
    end\
  end\
\
  local minCoast\
  for _, point in ipairs(canUseList) do\
    if not minCoast then\
      minCoast = point.coast\
    elseif point.coast then\
      minCoast = math.min(minCoast, point.coast)\
    end\
  end\
\
  local resultPoint = table.find(canUseList, function(point)\
    return point.coast == minCoast\
  end)\
\
  return resultPoint and { resultPoint[1], resultPoint[2] } or nil\
end\
\
return map" }


package.sourceCode = package.sourceCode or {}
package.sourceCode["./meta-operation/maps-options/mapevent15-2-b2.lua"] = { path = "./meta-operation/maps-options/mapevent15-2-b2.lua", name = "./meta-operation/maps-options/mapevent15-2-b2.lua", source = "local mapBase = require './map'\
local imgEvent = require './imgevent15-2-b2'\
local mapEvent = {}\
\
-- 从mapBase继承方法\
mapEvent = table.assign(mapEvent, mapBase)\
for key, value in pairs(mapBase) do\
  if type(value) == 'function' then\
    mapEvent[key] = function(...)\
      return value(imgEvent, ...)\
    end\
  end\
end\
\
-- 获取地图采样位置。由于地图可能超出一屏，所以这里可以定义多个采样位置。每次扫描都会对每个采样位置进行扫描\
-- 标志位为地图四个角。每个采样位置只需定义一个角的坐标即可。\
-- 还需要定义每个采样位置的地图矩阵与屏幕坐标的映射关系\
\
mapEvent.getCheckpositionList = function()\
  local list = {\
    {\
      leftTop = { 433, 531 },\
      rightTop = nil,\
      leftBotton = nil,\
      rightBotton = nil,\
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的\
      positionMap = {\
        { { 433, 531, 0x193942 }, { 595, 531, 0x213d4a }, { 758, 531, 0x193942 }, { 1084, 531, 0x193542 }, { 1247, 531, 0x19394a }, },\
        { { 413, 650, 0x000000 }, { 581, 650, 0x19718c }, { 750, 650, 0x21759c }, { 919, 650, 0x298194 }, { 1089, 650, 0x217d8c }, { 1258, 650, 0x217994 }, },\
        { { 390, 778, 0x634d10 }, { 566, 778, 0x297d94 }, { 742, 778, 0x4a92ad }, { 918, 778, 0x218194 }, { 1094, 778, 0x217d94 }, { 1270, 778, 0x216d8c }, },\
        { { 367, 918, 0x000000 }, { 550, 918, 0xefa610 }, { 732, 918, 0x218194 }, { 916, 918, 0x424142 }, { 1099, 918, 0x086d84 }, { 1283, 918, 0x08597b }, },\
      },\
      pointMap = {},\
    }, {\
      leftTop = nil,\
      rightTop = { 1571, 529 },\
      leftBotton = nil,\
      rightBotton = nil,\
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的\
      positionMap = {\
        { false, false, false, false, false, { 918, 529, 0x193542 }, { 1081, 529, 0x21394a }, { 1244, 529, 0x193542 }, { 1407, 529, 0x193d4a }, { 1571, 529, 0x193d4a }, },\
        { false, false, false, false, false, { 916, 647, 0x197584 }, { 1085, 647, 0x217d8c }, { 1254, 647, 0x318a9c }, { 1424, 647, 0x197984 }, { 1595, 647, 0x000000 }, },\
        { false, false, false, false, false, { 914, 776, 0x216d8c }, { 1090, 776, 0x21698c }, { 1267, 776, 0x10718c }, { 1443, 776, 0x217d8c }, { 1621, 776, 0x000000 }, },\
        { false, false, false, false, false, { 912, 916, 0x214d84 }, { 1096, 916, 0x21618c }, { 1280, 916, 0x216d8c }, { 1463, 916, 0x102d31 }, { 1649, 916, 0x100c10 }, },\
      },\
      pointMap = {},\
    }, {\
      leftTop = { 375, 398 },\
      rightTop = nil,\
      leftBotton = nil,\
      rightBotton = nil,\
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的\
      positionMap = {\
        false, false, false,\
        { { 301, 769, 0x000000 }, { 483, 769, 0xe6a600 }, { 666, 769, 0x197984 }, { 850, 769, 0x292d29 }, { 1033, 769, 0x196d84 }, { 1217, 769, 0x215984 }, { 1400, 769, 0x195984 }, { 1584, 769, 0x19698c }, },\
        { { 271, 915, 0x000000 }, { 462, 915, 0x19698c }, { 653, 915, 0x217194 }, { 845, 915, 0x106d8c }, { 1036, 915, 0x004d6b }, { 1420, 915, 0x102029 }, { 1611, 915, 0x192d3a }, { 1611, 915, 0x192d3a }, },\
      },\
      pointMap = {},\
    }, {\
      leftTop = nil,\
      rightTop = nil,\
      leftBotton = { 355, 949 },\
      rightBotton = nil,\
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的\
      positionMap = {\
        false, false, false, false,\
        { { 436, 486, 0x000000 }, { 626, 486, 0x297194 }, { 817, 486, 0x195d73 }, { 1009, 486, 0x086173 }, { 1201, 486, 0x004d73 }, },\
        { { 411, 626, 0x000000 }, { 611, 626, 0x000400 }, { 811, 626, 0x296594 }, { 1011, 626, 0x10618c }, { 1212, 626, 0x215184 }, },\
        { { 385, 778, 0x000000 }, { 593, 778, 0x19658c }, { 803, 778, 0x10557b }, { 1014, 778, 0x21618c }, { 1224, 778, 0x194d7b }, },\
        { { 355, 949, 0x000000 }, { 575, 949, 0x000000 }, { 796, 949, 0x000000 }, { 1016, 949, 0x000000 }, { 1237, 949, 0x000000 }, },\
      },\
      pointMap = {},\
    }, {\
      leftTop = nil,\
      rightTop = nil,\
      leftBotton = nil,\
      rightBotton = { 1510, 938 },\
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的\
      positionMap = {\
        false, false, false, false,\
        { false, false, false, false, { 476, 477, 0x004d73 }, { 859, 477, 0x19497b }, { 1051, 477, 0x216184 }, { 1051, 477, 0x216184 }, { 1243, 477, 0x63aae6 }, { 1438, 477, 0x211410 }, },\
        { false, false, false, false, { 454, 615, 0x084d73 }, { 654, 615, 0x004173 }, { 854, 615, 0x194173 }, { 1055, 615, 0x294d84 }, { 1255, 615, 0x314d84 }, { 1459, 615, 0x000000 }, },\
        { false, false, false, false, { 429, 767, 0x104d7b }, { 639, 767, 0x193d73 }, { 849, 767, 0x7ba2bd }, { 1059, 767, 0x21497b }, { 1270, 767, 0x21497b }, { 1483, 767, 0x000000 }, },\
        { false, false, false, false, { 402, 938, 0x000000 }, { 623, 938, 0x000000 }, { 844, 938, 0x000000 }, { 1064, 938, 0x000000 }, { 1286, 938, 0x000000 }, { 1510, 938, 0x211821 }, },\
      },\
      pointMap = {},\
    },\
  }\
  for key = 1, #list do\
    local positionMap = list[key].positionMap\
    for rowNum, rol in ipairs(positionMap) do\
      if rol and positionMap[rowNum + 1] then\
        for colNum, col in ipairs(rol) do\
          if col and rol[colNum + 1] then\
            list[key].pointMap[rowNum .. '-' .. colNum] = col\
          end\
        end\
      end\
    end\
  end\
  return list\
end\
\
-- 获取地图棋盘和相关数据\
mapEvent.getMapChessboard = function()\
  return {\
    width = 9,\
    height = 7,\
    obstacle = {\
      { 1, 2 }, { 1, 3 }, { 1, 4 }, { 1, 5 }, { 1, 8 }, { 1, 9 },\
      { 2, 3 }, { 2, 4 }, { 2, 5 }, { 2, 8 }, { 2, 9 },\
      { 3, 4 }, { 3, 5 },\
      { 4, 4 }, { 4, 5 },\
      { 7, 4 }, { 7, 5 }, { 7, 8 }, { 7, 9 },\
    },\
    waitForBossPosition = { { 5, 1 } },\
    bossPosition = {},\
    myFleetList = {},\
    enemyPositionList1 = {},\
    enemyPositionList2 = {},\
    enemyPositionList3 = {},\
    inBattleList = {},\
    selectedArrowList = {},\
    rewardBoxList = {},\
  }\
end\
\
return mapEvent\
" }


package.sourceCode = package.sourceCode or {}
package.sourceCode["./meta-operation/maps-options/mapevent15-1-a2.lua"] = { path = "./meta-operation/maps-options/mapevent15-1-a2.lua", name = "./meta-operation/maps-options/mapevent15-1-a2.lua", source = "local mapBase = require './map'\
local imgEvent = require './imgevent15-1-a2'\
local mapEvent = {}\
\
-- 从mapBase继承方法\
mapEvent = table.assign(mapEvent, mapBase)\
for key, value in pairs(mapBase) do\
  if type(value) == 'function' then\
    mapEvent[key] = function(...)\
      return value(imgEvent, ...)\
    end\
  end\
end\
\
-- 获取地图采样位置。由于地图可能超出一屏，所以这里可以定义多个采样位置。每次扫描都会对每个采样位置进行扫描\
-- 标志位为地图四个角。每个采样位置只需定义一个角的坐标即可。\
-- 还需要定义每个采样位置的地图矩阵与屏幕坐标的映射关系\
\
mapEvent.getCheckpositionList = function()\
  local list = {\
    {\
      leftTop = nil,\
      rightTop = { 1564, 505 },\
      leftBotton = nil,\
      rightBotton = nil,\
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的\
      positionMap = {\
        { { 573, 505, 0x192031 }, { 738, 505, 0x212421 }, { 902, 505, 0x292431 }, { 1067, 505, 0x423542 }, { 1232, 505, 0x423d42 }, { 1397, 505, 0x3a3131 }, { 1564, 505, 0x423942 }, },\
        { { 564, 630, 0x000000 }, { 729, 630, 0x6b6173 }, { 900, 630, 0x31415a }, { 1069, 630, 0x21314a }, { 1238, 630, 0x314163 }, { 1407, 630, 0x293d5a }, { 1578, 630, 0x000000 }, },\
        { { 554, 760, 0xdea2bd }, { 725, 760, 0xad7db5 }, { 899, 760, 0x293d52 }, { 1072, 760, 0x42496b }, { 1245, 760, 0x313d63 }, { 1418, 760, 0x3a4163 }, { 1593, 760, 0x000000 }, },\
        { { 544, 897, 0x000000 }, { 720, 897, 0x213552 }, { 897, 897, 0x29355a }, { 1075, 897, 0xf7f7ff }, { 1252, 897, 0xefebff }, { 1429, 897, 0x313d5a }, { 1609, 897, 0x000000 }, },\
      },\
      pointMap = {},\
    },\
    {\
      leftTop = { 565, 377 },\
      rightTop = nil,\
      leftBotton = nil,\
      rightBotton = nil,\
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的\
      positionMap = {\
        false, false, false,\
        { { 536, 760, 0x000000 }, { 712, 760, 0x314163 }, { 889, 760, 0x293552 }, { 1067, 760, 0xdeebff }, { 1244, 760, 0xf7f3ff }, { 1421, 760, 0x293d52 }, { 1601, 760, 0x000000 }, },\
        { { 525, 901, 0x000000 }, { 706, 901, 0x294563 }, { 888, 901, 0x293952 }, { 1070, 901, 0x293d5a }, { 1251, 901, 0x313d5a }, { 1433, 901, 0x3a4163 }, { 1617, 901, 0x000000 }, },\
      },\
      pointMap = {},\
    },\
    {\
      leftTop = nil,\
      rightTop = nil,\
      leftBotton = { 528, 946 },\
      rightBotton = nil,\
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的\
      positionMap = {\
        false, false, false, false,\
        { { 561, 508, 0x000000 }, { 742, 508, 0x3a4d6b }, { 923, 508, 0x293d5a }, { 1105, 508, 0x313d5a }, { 1288, 508, 0x424163 }, { 1469, 508, 0x31415a }, { 1653, 508, 0x000000 }, },\
        { { 551, 646, 0x000000 }, { 735, 646, 0x292d29 }, { 923, 646, 0x292d29 }, { 1109, 646, 0x293d5a }, { 1296, 646, 0x3a416b }, { 1483, 646, 0x3a5973 }, { 1671, 646, 0x293152 }, },\
        { { 540, 791, 0x000000 }, { 730, 791, 0x213142 }, { 921, 791, 0x314563 }, { 1113, 791, 0x31415a }, { 1305, 791, 0x313d5a }, { 1494, 791, 0x3a353a }, { 1691, 791, 0x000000 }, },\
        { { 528, 946, 0x000000 }, { 724, 946, 0x000000 }, { 920, 946, 0x000000 }, { 1117, 946, 0x000000 }, { 1315, 946, 0x000000 }, { 1512, 946, 0x101010 }, { 1712, 946, 0x101010 }, },\
      },\
      pointMap = {},\
    },\
  }\
  for key = 1, #list do\
    local positionMap = list[key].positionMap\
    for rowNum, rol in ipairs(positionMap) do\
      if rol and positionMap[rowNum + 1] then\
        for colNum, col in ipairs(rol) do\
          if col and rol[colNum + 1] then\
            list[key].pointMap[rowNum .. '-' .. colNum] = col\
          end\
        end\
      end\
    end\
  end\
  return list\
end\
\
-- 获取地图棋盘和相关数据\
mapEvent.getMapChessboard = function()\
  return {\
    width = 6,\
    height = 7,\
    obstacle = {\
      { 1, 1 }, { 1, 2 },\
      { 2, 1 }, { 2, 2 },\
      { 3, 1 }, { 3, 2 },\
      { 6, 5 }, { 6, 6 },\
      { 7, 5 }, { 7, 6 },\
    },\
    waitForBossPosition = { { 1, 6 }, { 5, 6 } },\
    bossPosition = {},\
    myFleetList = {},\
    enemyPositionList1 = {},\
    enemyPositionList2 = {},\
    enemyPositionList3 = {},\
    inBattleList = {},\
    selectedArrowList = {},\
    rewardBoxList = {},\
  }\
end\
\
return mapEvent\
" }


package.sourceCode = package.sourceCode or {}
package.sourceCode["./meta-operation/maps-options/map12-1.lua"] = { path = "./meta-operation/maps-options/map12-1.lua", name = "./meta-operation/maps-options/map12-1.lua", source = "local mapBase = require './map'\
local imgEvent = require './img12-1'\
local mapEvent = {}\
\
-- 从mapBase继承方法\
mapEvent = table.assign(mapEvent, mapBase)\
for key, value in pairs(mapBase) do\
  if type(value) == 'function' then\
    mapEvent[key] = function(...)\
      return value(imgEvent, ...)\
    end\
  end\
end\
\
-- 获取地图采样位置。由于地图可能超出一屏，所以这里可以定义多个采样位置。每次扫描都会对每个采样位置进行扫描\
-- 标志位为地图四个角。每个采样位置只需定义一个角的坐标即可。\
-- 还需要定义每个采样位置的地图矩阵与屏幕坐标的映射关系\
mapEvent.getCheckpositionList = function()\
  local list = {\
    {\
      leftTop = { 287, 539 },\
      rightTop = nil,\
      leftBotton = nil,\
      rightBotton = nil,\
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的\
      positionMap = {\
        { { 287, 539, 0x212442 }, { 455, 539, 0x212442 }, { 625, 539, 0x212442 }, { 794, 539, 0x19243a }, { 963, 539, 0x212442 }, { 1133, 539, 0x212442 }, { 1302, 539, 0x19243a }, { 1471, 539, 0x293529 }, { 1642, 539, 0x101829 }, },\
        { { 260, 663, 0x000000 }, { 435, 663, 0x21719c }, { 611, 663, 0x217194 }, { 787, 663, 0x218194 }, { 963, 663, 0x217594 }, { 1139, 663, 0x21798c }, { 1316, 663, 0x217d84 }, { 1492, 663, 0x197984 }, { 1670, 663, 0x000000 }, },\
        { { 231, 798, 0x000000 }, { 413, 798, 0x217d84 }, { 597, 798, 0x197d8c }, { 780, 798, 0x219ebd }, { 963, 798, 0x63868c }, { 1147, 798, 0x19698c }, { 1331, 798, 0x216d8c }, { 1514, 798, 0x217594 }, { 1700, 798, 0x000000 }, },\
        { { 199, 944, 0x000000 }, { 389, 944, 0x197d8c }, { 581, 944, 0x297d94 }, { 772, 944, 0x21758c }, { 963, 944, 0x08597b }, { 1155, 944, 0x73494a }, { 1346, 944, 0x192831 }, { 1539, 944, 0x102831 }, { 1732, 944, 0x101010 }, },\
      },\
      pointMap = {},\
    },\
    {\
      leftTop = nil,\
      rightTop = nil,\
      leftBotton = { 460, 956 },\
      rightBotton = nil,\
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的\
      positionMap = {\
        false, false, false,\
        { { 526, 493, 0x000000 }, { 716, 493, 0x19798c }, { 908, 493, 0x21798c }, { 1099, 493, 0x107184 }, { 1291, 493, 0x10597b }, },\
        { { 506, 632, 0x000000 }, { 705, 632, 0x296194 }, { 905, 632, 0x296594 }, { 1106, 632, 0x215d84 }, { 1306, 632, 0x195184 }, },\
        { { 484, 785, 0x000000 }, { 692, 785, 0x19618c }, { 903, 785, 0x195d84 }, { 1113, 785, 0x215d84 }, { 1323, 785, 0x105984 }, },\
        { { 460, 956, 0x000000 }, { 679, 956, 0x000000 }, { 900, 956, 0x000000 }, { 1121, 956, 0x000000 }, { 1341, 956, 0x8c8a8c }, },\
      },\
      pointMap = {},\
    },\
    {\
      leftTop = nil,\
      rightTop = nil,\
      leftBotton = nil,\
      rightBotton = { 1565, 954 },\
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的\
      positionMap = {\
        false, false, false,\
        { false, false, false, false, { 715, 491, 0x73757b }, { 907, 491, 0x214d84 }, { 1099, 491, 0x21618c }, { 1291, 491, 0x21698c }, { 1485, 491, 0x000000 }, },\
        { false, false, false, false, { 704, 631, 0x084973 }, { 905, 631, 0x10497b }, { 1106, 631, 0x214573 }, { 1306, 631, 0x294d84 }, { 1509, 631, 0x000000 }, },\
        { false, false, false, false, { 692, 784, 0x215d8c }, { 902, 784, 0x21417b }, { 1112, 784, 0x21498c }, { 1322, 784, 0x29c2de }, { 1536, 784, 0x000000 }, },\
        { false, false, false, false, { 678, 954, 0x000000 }, { 900, 954, 0x000000 }, { 1121, 954, 0x000000 }, { 1341, 954, 0x191c19 }, { 1565, 954, 0x080c08 }, },\
      },\
      pointMap = {},\
    },\
    {\
      leftTop = nil,\
      rightTop = nil,\
      leftBotton = nil,\
      rightBotton = { 1550, 953 },\
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的\
      positionMap = {\
        false, false, false,\
      },\
      pointMap = {},\
    },\
  }\
  for key = 1, #list do\
    local positionMap = list[key].positionMap\
    for rowNum, rol in ipairs(positionMap) do\
      if rol and positionMap[rowNum + 1] then\
        for colNum, col in ipairs(rol) do\
          if col and rol[colNum + 1] then\
            list[key].pointMap[rowNum .. '-' .. colNum] = col\
          end\
        end\
      end\
    end\
  end\
  return list\
end\
\
-- 获取地图棋盘和相关数据\
mapEvent.getMapChessboard = function()\
  return {\
    width = 8,\
    height = 6,\
    obstacle = {\
      { 1, 7 }, { 1, 8 },\
      { 2, 1 }, { 2, 4 },\
      { 3, 1 }, { 3, 4 }, { 3, 5 },\
      { 5, 2 }, { 5, 3 }, { 5, 7 },\
      { 6, 7 },\
    },\
    waitForBossPosition = { { 5, 8 } },\
    bossPosition = {},\
    myFleetList = {},\
    enemyPositionList1 = {},\
    enemyPositionList2 = {},\
    enemyPositionList3 = {},\
    inBattleList = {},\
    selectedArrowList = {},\
    rewardBoxList = {},\
  }\
end\
\
return mapEvent" }


package.sourceCode = package.sourceCode or {}
package.sourceCode["./meta-operation/maps-options/map11-3.lua"] = { path = "./meta-operation/maps-options/map11-3.lua", name = "./meta-operation/maps-options/map11-3.lua", source = "local mapBase = require './map'\
local imgEvent = require './img11-3'\
local mapEvent = {}\
\
-- 从mapBase继承方法\
mapEvent = table.assign(mapEvent, mapBase)\
for key, value in pairs(mapBase) do\
  if type(value) == 'function' then\
    mapEvent[key] = function(...)\
      return value(imgEvent, ...)\
    end\
  end\
end\
\
-- 获取地图采样位置。由于地图可能超出一屏，所以这里可以定义多个采样位置。每次扫描都会对每个采样位置进行扫描\
-- 标志位为地图四个角。每个采样位置只需定义一个角的坐标即可。\
-- 还需要定义每个采样位置的地图矩阵与屏幕坐标的映射关系\
mapEvent.getCheckpositionList = function()\
  local list = {\
    {\
      leftTop = { 561, 512 },\
      rightTop = nil,\
      leftBotton = nil,\
      rightBotton = nil,\
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的\
      positionMap = {\
        { { 561, 512, 0x191429 }, { 729, 512, 0x212431 }, { 898, 512, 0x211831 }, { 1068, 512, 0x211c42 }, { 1237, 512, 0x191831 }, { 1406, 512, 0x21203a }, },\
        { { 545, 635, 0x000000 }, { 720, 635, 0x191429 }, { 896, 635, 0x191831 }, { 1072, 635, 0x191831 }, { 1248, 635, 0x191c31 }, { 1424, 635, 0x191c31 }, },\
        { { 527, 769, 0x000000 }, { 710, 769, 0x191829 }, { 893, 769, 0x212042 }, { 1077, 769, 0x212042 }, { 1260, 769, 0x212042 }, { 1444, 769, 0x211c31 }, },\
        { { 508, 914, 0x000000 }, { 699, 914, 0x211831 }, { 890, 914, 0x21204a }, { 1082, 914, 0x211c42 }, { 1273, 914, 0x211831 }, { 1465, 914, 0x191419 }, },\
      },\
      pointMap = {},\
    },\
    {\
      leftTop = nil,\
      rightTop = { 1611, 509 },\
      leftBotton = nil,\
      rightBotton = nil,\
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的\
      positionMap = {\
        { false, false, false, false, false, { 932, 509, 0x191429 }, { 1101, 509, 0x191831 }, { 1271, 509, 0x21203a }, { 1440, 509, 0x191c31 }, { 1611, 509, 0x102031 }, },\
        { false, false, false, false, false, { 931, 632, 0x21203a }, { 1107, 632, 0x212442 }, { 1284, 632, 0x313552 }, { 1460, 632, 0x423d63 }, { 1638, 632, 0x000000 }, },\
        { false, false, false, false, false, { 930, 765, 0x211c31 }, { 1113, 765, 0x292042 }, { 1297, 765, 0x292042 }, { 1480, 765, 0x212442 }, { 1666, 765, 0x000000 }, },\
        { false, false, false, false, false, { 928, 910, 0x21203a }, { 1120, 910, 0x292042 }, { 1312, 910, 0x292042 }, { 1504, 910, 0x31244a }, { 1697, 910, 0x000000 }, },\
      },\
      pointMap = {},\
    },\
    {\
      leftTop = nil,\
      rightTop = { 1471, 363 },\
      leftBotton = nil,\
      rightBotton = nil,\
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的\
      positionMap = {\
        false, false, false,\
        { false, false, false, false, false, { 770, 746, 0x292442 }, { 962, 746, 0x31244a }, { 1153, 746, 0x211c3a }, { 1345, 746, 0x212042 }, { 1539, 746, 0x000000 }, },\
        { false, false, false, false, false, { 761, 897, 0x211c3a }, { 961, 897, 0x312452 }, { 1162, 897, 0x191831 }, { 1363, 897, 0x292042 }, { 1566, 897, 0x000000 }, },\
      },\
      pointMap = {},\
    },\
    {\
      leftTop = { 579, 372 },\
      rightTop = nil,\
      leftBotton = nil,\
      rightBotton = nil,\
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的\
      positionMap = {\
        false, false, false,\
        { { 529, 756, 0x000000 }, { 719, 756, 0x211831 }, { 911, 756, 0x191831 }, { 1103, 756, 0x211831 }, { 1294, 756, 0x21203a }, { 1487, 756, 0x211831 }, },\
        { { 509, 907, 0x000000 }, { 707, 907, 0xffffff }, { 906, 907, 0x31354a }, { 1109, 907, 0x211c3a }, { 1310, 907, 0x191429 }, { 1511, 907, 0x211c3a }, },\
      },\
      pointMap = {},\
    },\
    {\
      leftTop = nil,\
      rightTop = nil,\
      leftBotton = { 377, 944 },\
      rightBotton = nil,\
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的\
      positionMap = {\
        false, false, false, false,\
        { { 458, 460, 0xdedfde }, { 656, 460, 0x211821 }, { 854, 460, 0x31283a }, { 1058, 460, 0x292042 }, { 1258, 460, 0x211c3a }, { 1458, 460, 0x292452 }, },\
        { { 434, 605, 0x000000 }, { 642, 605, 0xffffff }, { 852, 605, 0x191431 }, { 1062, 605, 0x191831 }, { 1272, 605, 0x191429 }, },\
        { { 406, 765, 0x000000 }, { 626, 765, 0x191431 }, { 848, 765, 0x191431 }, { 1068, 765, 0x191429 }, { 1289, 765, 0x211c3a }, },\
        { { 377, 944, 0x000000 }, { 609, 944, 0x000000 }, { 841, 944, 0x000000 }, { 1074, 944, 0x000000 }, { 1306, 944, 0x000000 }, },\
      },\
      pointMap = {},\
    },\
    {\
      leftTop = nil,\
      rightTop = nil,\
      leftBotton = nil,\
      rightBotton = { 1690, 913 },\
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的\
      positionMap = {\
        false, false, false, false, false,\
        { false, false, false, false, { 783, 434, 0x3a356b }, { 982, 434, 0x42355a }, { 1185, 434, 0x211c31 }, { 1385, 434, 0x212042 }, { 1588, 434, 0x000000 }, },\
        { false, false, false, false, { 566, 577, 0x191421 }, { 776, 577, 0x191429 }, { 986, 577, 0x191829 }, { 1196, 577, 0x191831 }, { 1406, 577, 0x191831 }, { 1619, 577, 0x000000 }, },\
        { false, false, false, false, { 545, 735, 0x191c31 }, { 766, 735, 0x191421 }, { 987, 735, 0x211c3a }, { 1208, 735, 0x191829 }, { 1429, 735, 0x211c3a }, { 1652, 735, 0x000000 }, },\
        { false, false, false, false, { 523, 913, 0x000000 }, { 756, 913, 0x000000 }, { 988, 913, 0x000000 }, { 1222, 913, 0x000000 }, { 1455, 913, 0x000000 }, { 1690, 913, 0x000000 }, },\
      },\
      pointMap = {},\
    },\
  }\
  for key = 1, #list do\
    local positionMap = list[key].positionMap\
    for rowNum, rol in ipairs(positionMap) do\
      if rol and positionMap[rowNum + 1] then\
        for colNum, col in ipairs(rol) do\
          if col and rol[colNum + 1] then\
            list[key].pointMap[rowNum .. '-' .. colNum] = col\
          end\
        end\
      end\
    end\
  end\
  return list\
end\
\
-- 获取地图棋盘和相关数据\
mapEvent.getMapChessboard = function()\
  return {\
    width = 9,\
    height = 7,\
    obstacle = {\
      { 1, 1 }, { 1, 7 }, { 1, 8 }, { 1, 9 },\
      { 4, 2 }, { 4, 3 }, { 4, 5 }, { 4, 6 }, { 4, 7 },\
      { 5, 1 }, { 5, 2 }, { 5, 3 },\
      { 6, 7 },\
      { 7, 5 },\
    },\
    waitForBossPosition = { { 7, 9 } },\
    bossPosition = {},\
    myFleetList = {},\
    enemyPositionList1 = {},\
    enemyPositionList2 = {},\
    enemyPositionList3 = {},\
    inBattleList = {},\
    selectedArrowList = {},\
    rewardBoxList = {},\
  }\
end\
\
return mapEvent" }


package.sourceCode = package.sourceCode or {}
package.sourceCode["./meta-operation/maps-options/map11-2.lua"] = { path = "./meta-operation/maps-options/map11-2.lua", name = "./meta-operation/maps-options/map11-2.lua", source = "local mapBase = require './map'\
local imgEvent = require './img11-2'\
local mapEvent = {}\
\
-- 从mapBase继承方法\
mapEvent = table.assign(mapEvent, mapBase)\
for key, value in pairs(mapBase) do\
  if type(value) == 'function' then\
    mapEvent[key] = function(...)\
      return value(imgEvent, ...)\
    end\
  end\
end\
\
-- 获取地图采样位置。由于地图可能超出一屏，所以这里可以定义多个采样位置。每次扫描都会对每个采样位置进行扫描\
-- 标志位为地图四个角。每个采样位置只需定义一个角的坐标即可。\
-- 还需要定义每个采样位置的地图矩阵与屏幕坐标的映射关系\
mapEvent.getCheckpositionList = function()\
  local list = {\
    {\
      leftTop = { 476, 497 },\
      rightTop = nil,\
      leftBotton = nil,\
      rightBotton = nil,\
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的\
      positionMap = {\
        { { 476, 497, 0x080408 }, { 645, 497, 0x191819 }, { 813, 497, 0x5a7584 }, { 982, 497, 0x000808 }, { 1151, 497, 0x080810 }, { 1321, 497, 0x191421 }, { 1490, 497, 0x081019 }, },\
        { { 453, 620, 0x6b7184 }, { 631, 620, 0x9cb6bd }, { 807, 620, 0x211831 }, { 983, 620, 0x211c3a }, { 1159, 620, 0x21203a }, { 1335, 620, 0x212042 }, { 1511, 620, 0x212042 }, },\
        { { 435, 753, 0x000000 }, { 617, 753, 0xffffff }, { 801, 753, 0x211c3a }, { 984, 753, 0x191831 }, { 1168, 753, 0x191831 }, { 1351, 753, 0x292442 }, { 1535, 753, 0x21203a }, },\
        { { 412, 898, 0x000000 }, { 602, 898, 0x211c42 }, { 793, 898, 0x211c31 }, { 985, 898, 0x211831 }, { 1177, 898, 0x211831 }, { 1368, 898, 0x211c3a }, { 1560, 898, 0x21204a }, },\
      },\
      pointMap = {},\
    },\
    {\
      leftTop = nil,\
      rightTop = { 1592, 499 },\
      leftBotton = nil,\
      rightBotton = nil,\
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的\
      positionMap = {\
        { false, false, false, false, false, false, { 743, 499, 0x080810 }, { 913, 499, 0x080810 }, { 1082, 499, 0x000808 }, { 1251, 499, 0x191421 }, { 1420, 499, 0x52555a }, { 1592, 499, 0x000810 }, },\
        { false, false, false, false, false, false, { 735, 621, 0x292442 }, { 911, 621, 0x212442 }, { 1087, 621, 0x29244a }, { 1263, 621, 0x312d52 }, { 1439, 621, 0x3a3563 }, { 1617, 621, 0x000000 }, },\
        { false, false, false, false, false, false, { 725, 754, 0x21203a }, { 909, 754, 0x212042 }, { 1092, 754, 0x292042 }, { 1274, 754, 0xada2ad }, { 1460, 754, 0x3a3552 }, { 1645, 754, 0x000000 }, },\
        { false, false, false, false, false, false, { 715, 899, 0x191c42 }, { 906, 899, 0x191829 }, { 1098, 899, 0x191831 }, { 1290, 899, 0x191831 }, { 1481, 899, 0x292442 }, { 1675, 899, 0x000000 }, },\
      },\
      pointMap = {},\
    },\
    {\
      leftTop = nil,\
      rightTop = nil,\
      leftBotton = { 377, 972 },\
      rightBotton = nil,\
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的\
      positionMap = {\
        false, false, false,\
        { { 455, 506, 0x000000 }, { 645, 506, 0x191831 }, { 837, 506, 0x211c31 }, { 1029, 506, 0x211831 }, { 1220, 506, 0x211c3a }, { 1411, 506, 0x211831 }, { 1604, 506, 0x212042 }, },\
        { { 431, 646, 0x000000 }, { 631, 646, 0x191831 }, { 831, 646, 0x191831 }, { 1031, 646, 0x21183a }, { 1231, 646, 0x211831 }, { 1432, 646, 0x211c3a }, { 1632, 646, 0x211c3a }, },\
        { { 406, 800, 0x000000 }, { 614, 800, 0x211c42 }, { 824, 800, 0x423963 }, { 1035, 800, 0x211831 }, { 1245, 800, 0x211831 }, { 1455, 800, 0x191829 }, { 1665, 800, 0x191829 }, },\
        { { 377, 972, 0x000000 }, { 596, 972, 0x000000 }, { 818, 972, 0x000000 }, { 1038, 972, 0x848184 }, { 1259, 972, 0x8c8a8c }, { 1480, 972, 0x313531 }, },\
      },\
      pointMap = {},\
    },\
    {\
      leftTop = nil,\
      rightTop = nil,\
      leftBotton = nil,\
      rightBotton = { 1550, 953 },\
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的\
      positionMap = {\
        false, false, false,\
        { false, false, false, false, false, false, { 619, 497, 0x211c3a }, { 811, 497, 0x211c31 }, { 1002, 497, 0x191831 }, { 1195, 497, 0x211c3a }, { 1386, 497, 0x211c3a }, { 1580, 497, 0x000000 }, },\
        { false, false, false, false, false, false, { 603, 636, 0x191829 }, { 804, 636, 0x211c42 }, { 1005, 636, 0x211831 }, { 1205, 636, 0x211c31 }, { 1405, 636, 0x292042 }, { 1608, 636, 0x000000 }, },\
        { false, false, false, false, false, false, { 586, 789, 0x191421 }, { 796, 789, 0x191429 }, { 1007, 789, 0x211c3a }, { 1217, 789, 0x211c3a }, { 1427, 789, 0x211c3a }, { 1640, 789, 0x000000 }, },\
        { false, false, false, false, false, false, { 567, 961, 0x000000 }, { 788, 961, 0x000000 }, { 1009, 961, 0x000000 }, { 1230, 961, 0x000000 }, { 1451, 961, 0x3a3d3a }, { 1675, 961, 0xc57d42 }, },\
      },\
      pointMap = {},\
    },\
  }\
  for key = 1, #list do\
    local positionMap = list[key].positionMap\
    for rowNum, rol in ipairs(positionMap) do\
      if rol and positionMap[rowNum + 1] then\
        for colNum, col in ipairs(rol) do\
          if col and rol[colNum + 1] then\
            list[key].pointMap[rowNum .. '-' .. colNum] = col\
          end\
        end\
      end\
    end\
  end\
  return list\
end\
\
-- 获取地图棋盘和相关数据\
mapEvent.getMapChessboard = function()\
  return {\
    width = 11,\
    height = 6,\
    obstacle = {\
      { 1, 1 }, { 1, 2 }, { 1, 3 }, { 1, 6 },\
      { 2, 8 }, { 2, 9 },\
      { 3, 3 }, { 3, 9 },\
      { 4, 3 },\
      { 5, 2 }, { 5, 3 }, { 5, 4 }, { 5, 9 }, { 5, 10 }, { 5, 11 },\
      { 6, 6 },\
    },\
    waitForBossPosition = { { 4, 10 } },\
    bossPosition = {},\
    myFleetList = {},\
    enemyPositionList1 = {},\
    enemyPositionList2 = {},\
    enemyPositionList3 = {},\
    inBattleList = {},\
    selectedArrowList = {},\
    rewardBoxList = {},\
  }\
end\
\
return mapEvent" }


package.sourceCode = package.sourceCode or {}
package.sourceCode["./meta-operation/maps-options/map11-1.lua"] = { path = "./meta-operation/maps-options/map11-1.lua", name = "./meta-operation/maps-options/map11-1.lua", source = "local mapBase = require './map'\
local imgEvent = require './img11-1'\
local mapEvent = {}\
\
-- 从mapBase继承方法\
mapEvent = table.assign(mapEvent, mapBase)\
for key, value in pairs(mapBase) do\
  if type(value) == 'function' then\
    mapEvent[key] = function(...)\
      return value(imgEvent, ...)\
    end\
  end\
end\
\
-- 获取地图采样位置。由于地图可能超出一屏，所以这里可以定义多个采样位置。每次扫描都会对每个采样位置进行扫描\
-- 标志位为地图四个角。每个采样位置只需定义一个角的坐标即可。\
-- 还需要定义每个采样位置的地图矩阵与屏幕坐标的映射关系\
mapEvent.getCheckpositionList = function()\
  local list = {\
    {\
      leftTop = { 577, 527 },\
      rightTop = nil,\
      leftBotton = nil,\
      rightBotton = nil,\
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的\
      positionMap = {\
        { { 577, 527, 0x101419 }, { 745, 527, 0x101419 }, { 915, 527, 0x29243a }, { 1084, 527, 0x101821 }, { 1253, 527, 0x192031 }, { 1422, 527, 0x212431 }, },\
        { { 562, 650, 0x000000 }, { 737, 650, 0x191831 }, { 913, 650, 0x21183a }, { 1089, 650, 0x21203a }, { 1265, 650, 0x21203a }, { 1441, 650, 0x212042 }, },\
        { { 545, 784, 0x000000 }, { 727, 784, 0x191831 }, { 911, 784, 0x21203a }, { 1094, 784, 0x212042 }, { 1278, 784, 0x292442 }, { 1461, 784, 0x292042 }, },\
        { { 527, 931, 0x000000 }, { 717, 931, 0xffffff }, { 908, 931, 0x191831 }, { 1100, 931, 0x191429 }, { 1292, 931, 0x8c7d9c }, { 1483, 931, 0x191421 }, },\
      },\
      pointMap = {},\
    },\
    {\
      leftTop = nil,\
      rightTop = { 1584, 542 },\
      leftBotton = nil,\
      rightBotton = nil,\
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的\
      positionMap = {\
        { false, false, false, false, { 904, 542, 0x212031 }, { 1074, 542, 0x212031 }, { 1243, 542, 0x191c31 }, { 1412, 542, 0x3a414a }, { 1584, 542, 0x211c31 }, },\
        { false, false, false, false, { 902, 666, 0x292042 }, { 1078, 666, 0x292442 }, { 1254, 666, 0x292852 }, { 1431, 666, 0x31315a }, { 1609, 666, 0x000000 }, },\
        { false, false, false, false, { 900, 801, 0x211c3a }, { 1083, 801, 0x292042 }, { 1267, 801, 0x31284a }, { 1451, 801, 0x31244a }, { 1636, 801, 0x000000 }, },\
        { false, false, false, false, { 894, 948, 0x4a4173 }, { 1089, 948, 0x211831 }, { 1280, 948, 0x292042 }, { 1472, 948, 0x211821 }, { 1666, 948, 0x101010 }, },\
      },\
      pointMap = {},\
    },\
    {\
      leftTop = nil,\
      rightTop = nil,\
      leftBotton = { 415, 995 },\
      rightBotton = nil,\
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的\
      positionMap = {\
        false, false, false,\
        { { 483, 527, 0x3a3d4a }, { 677, 527, 0x525d6b }, { 869, 527, 0x191c3a }, { 1061, 527, 0x211c3a }, { 1254, 527, 0x63618c }, },\
        { { 466, 668, 0x000000 }, { 664, 668, 0x211c42 }, { 867, 668, 0x212021 }, { 1065, 668, 0x191831 }, { 1266, 668, 0x212042 }, },\
        { { 441, 823, 0x000000 }, { 650, 823, 0x191431 }, { 860, 823, 0x191431 }, { 1070, 823, 0x191429 }, { 1281, 823, 0x191831 }, },\
        { { 415, 995, 0x000000 }, { 634, 995, 0x000000 }, { 855, 995, 0x000000 }, { 1073, 995, 0xbd0000 }, { 1297, 995, 0x424142 }, },\
      },\
      pointMap = {},\
    },\
    {\
      leftTop = nil,\
      rightTop = nil,\
      leftBotton = nil,\
      rightBotton = { 1550, 953 },\
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的\
      positionMap = {\
        false, false, false,\
        { false, false, false, false, { 701, 490, 0x291c3a }, { 893, 490, 0x211829 }, { 1084, 490, 0x292042 }, { 1276, 490, 0x292042 }, { 1470, 490, 0x000000 }, },\
        { false, false, false, false, { 689, 629, 0x3a2d31 }, { 889, 629, 0x211c31 }, { 1090, 629, 0x191829 }, { 1290, 629, 0x191831 }, { 1493, 629, 0x000000 }, },\
        { false, false, false, false, { 676, 782, 0x211c3a }, { 886, 782, 0x211c42 }, { 1096, 782, 0x21203a }, { 1307, 782, 0x211831 }, { 1519, 782, 0x000000 }, },\
        { false, false, false, false, { 661, 953, 0x000000 }, { 882, 953, 0x000000 }, { 1103, 953, 0x000000 }, { 1324, 953, 0x080c08 }, { 1550, 953, 0x080c08 }, },\
      },\
      pointMap = {},\
    },\
  }\
  for key = 1, #list do\
    local positionMap = list[key].positionMap\
    for rowNum, rol in ipairs(positionMap) do\
      if rol and positionMap[rowNum + 1] then\
        for colNum, col in ipairs(rol) do\
          if col and rol[colNum + 1] then\
            list[key].pointMap[rowNum .. '-' .. colNum] = col\
          end\
        end\
      end\
    end\
  end\
  return list\
end\
\
-- 获取地图棋盘和相关数据\
mapEvent.getMapChessboard = function()\
  return {\
    width = 8,\
    height = 6,\
    obstacle = {\
      { 2, 6 }, { 2, 7 },\
      { 3, 1 }, { 3, 4 }, { 3, 7 },\
      { 4, 3 }, { 4, 4 },\
      { 5, 8 },\
      { 6, 5 }, { 6, 8 },\
    },\
    waitForBossPosition = { { 1, 8 } },\
    bossPosition = {},\
    myFleetList = {},\
    enemyPositionList1 = {},\
    enemyPositionList2 = {},\
    enemyPositionList3 = {},\
    inBattleList = {},\
    selectedArrowList = {},\
    rewardBoxList = {},\
  }\
end\
\
return mapEvent" }


package.sourceCode = package.sourceCode or {}
package.sourceCode["./meta-operation/maps-options/map10-4.lua"] = { path = "./meta-operation/maps-options/map10-4.lua", name = "./meta-operation/maps-options/map10-4.lua", source = "local mapBase = require './map'\
local imgEvent = require './img10-4'\
local mapEvent = {}\
\
-- 从mapBase继承方法\
mapEvent = table.assign(mapEvent, mapBase)\
for key, value in pairs(mapBase) do\
  if type(value) == 'function' then\
    mapEvent[key] = function(...)\
      return value(imgEvent, ...)\
    end\
  end\
end\
\
-- 获取地图采样位置。由于地图可能超出一屏，所以这里可以定义多个采样位置。每次扫描都会对每个采样位置进行扫描\
-- 标志位为地图四个角。每个采样位置只需定义一个角的坐标即可。\
-- 还需要定义每个采样位置的地图矩阵与屏幕坐标的映射关系\
mapEvent.getCheckpositionList = function()\
  local list = {\
    {\
      leftTop = { 427, 525 },\
      rightTop = nil,\
      leftBotton = nil,\
      rightBotton = nil,\
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的\
      positionMap = {\
        { { 427, 525, 0x314142 }, { 595, 525, 0x192831 }, { 764, 525, 0x21313a }, { 934, 525, 0x101819 }, { 1103, 525, 0x081019 }, { 1272, 525, 0x081021 }, },\
        { { 405, 649, 0x000000 }, { 580, 649, 0x191431 }, { 756, 649, 0x191831 }, { 933, 649, 0x212042 }, { 1109, 649, 0x21244a }, { 1285, 649, 0x4a3d73 }, },\
        { { 382, 783, 0x000000 }, { 564, 783, 0x101829 }, { 748, 783, 0x191831 }, { 932, 783, 0x191831 }, { 1115, 783, 0x292442 }, { 1298, 783, 0x5a5d8c }, },\
        { { 357, 929, 0x000000 }, { 547, 929, 0x5a555a }, { 738, 929, 0x191831 }, { 930, 929, 0x191829 }, { 1122, 929, 0x191429 }, { 1313, 929, 0x211c3a }, },\
      },\
      pointMap = {},\
    },\
    {\
      leftTop = nil,\
      rightTop = { 1553, 519 },\
      leftBotton = nil,\
      rightBotton = nil,\
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的\
      positionMap = {\
        { false, false, false, false, false, { 874, 519, 0x101c29 }, { 1044, 519, 0x000c10 }, { 1213, 519, 0x081419 }, { 1382, 519, 0x081419 }, { 1553, 519, 0x101421 }, },\
        { false, false, false, false, false, { 871, 642, 0x292442 }, { 1047, 642, 0x292042 }, { 1223, 642, 0x29284a }, { 1399, 642, 0x42356b }, { 1581, 642, 0x3a3573 }, },\
        { false, false, false, false, false, { 867, 776, 0x525184 }, { 1051, 776, 0x212042 }, { 1234, 776, 0x292042 }, { 1418, 776, 0x312852 }, { 1603, 776, 0x000000 }, },\
        { false, false, false, false, false, { 863, 922, 0x211831 }, { 1055, 922, 0x211831 }, { 1246, 922, 0x292042 }, { 1438, 922, 0x211821 }, { 1632, 922, 0x212021 }, },\
      },\
      pointMap = {},\
    },\
    {\
      leftTop = nil,\
      rightTop = nil,\
      leftBotton = { 308, 966 },\
      rightBotton = nil,\
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的\
      positionMap = {\
        false, false, false,\
        { { 394, 501, 0x000000 }, { 586, 501, 0x191819 }, { 776, 501, 0x191831 }, { 968, 501, 0x191831 }, { 1159, 501, 0x211c3a }, { 1351, 501, 0x211c3a }, },\
        { { 366, 641, 0xdee7de }, { 566, 641, 0xffffff }, { 968, 641, 0x191831 }, { 969, 641, 0x211c3a }, { 1169, 641, 0x211c31 }, { 1370, 641, 0x191429 }, },\
        { { 340, 794, 0x000000 }, { 548, 794, 0x211c42 }, { 759, 794, 0x211831 }, { 968, 794, 0x211c3a }, { 1179, 794, 0x191831 }, { 1389, 794, 0x191829 }, },\
        { { 308, 966, 0x000000 }, { 527, 966, 0x000000 }, { 748, 966, 0x000000 }, { 969, 966, 0x000000 }, { 1190, 966, 0x080408 }, { 1410, 966, 0x524d52 }, },\
      },\
      pointMap = {},\
    },\
    {\
      leftTop = nil,\
      rightTop = nil,\
      leftBotton = nil,\
      rightBotton = { 1761, 940 },\
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点 1761, 940的时候自动加上的\
      positionMap = {\
        false, false, false,\
        { false, false, false, false, false, { 884, 479, 0x191429 }, { 1076, 479, 0x191831 }, { 1267, 479, 0x29203a }, { 1459, 479, 0x292042 }, { 1653, 479, 0x000000 }, },\
        { false, false, false, false, false, { 881, 618, 0x191829 }, { 1082, 618, 0x212042 }, { 1282, 618, 0x212042 }, { 1482, 618, 0x292042 }, { 1685, 618, 0x000000 }, },\
        { false, false, false, false, false, { 878, 770, 0x211c42 }, { 1087, 770, 0x191831 }, { 1297, 770, 0x211831 }, { 1508, 770, 0x211c3a }, { 1720, 770, 0x000000 }, },\
        { false, false, false, false, false, { 873, 940, 0x000000 }, { 1094, 940, 0x000000 }, { 1315, 940, 0x000000 }, { 1536, 940, 0x101010 }, { 1761, 940, 0x100c10 }, },\
      },\
      {\
        leftTop = nil,\
        rightTop = nil,\
        leftBotton = nil,\
        -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点 1761, 940的时候自动加上的\
        rightBotton = { 1761, 940 },\
        positionMap = {\
          false, false, false,\
          { false, false, false, false, false, { 884, 479, 0x191429 }, { 1076, 479, 0x191831 }, { 1267, 479, 0x29203a }, { 1459, 479, 0x292042 }, { 1653, 479, 0x000000 }, },\
          { false, false, false, false, false, { 881, 618, 0x191829 }, { 1082, 618, 0x212042 }, { 1282, 618, 0x212042 }, { 1482, 618, 0x292042 }, { 1685, 618, 0x000000 }, },\
          { false, false, false, false, false, { 878, 770, 0x211c42 }, { 1087, 770, 0x191831 }, { 1297, 770, 0x211831 }, { 1508, 770, 0x211c3a }, { 1720, 770, 0x000000 }, },\
          { false, false, false, false, false, { 873, 940, 0x000000 }, { 1094, 940, 0x000000 }, { 1315, 940, 0x000000 }, { 1536, 940, 0x101010 }, { 1761, 940, 0x100c10 }, },\
        },\
        pointMap = {},\
      },\
    }\
  }\
  for key = 1, #list do\
    local positionMap = list[key].positionMap\
    for rowNum, rol in ipairs(positionMap) do\
      if rol and positionMap[rowNum + 1] then\
        for colNum, col in ipairs(rol) do\
          if col and rol[colNum + 1] then\
            list[key].pointMap[rowNum .. '-' .. colNum] = col\
          end\
        end\
      end\
    end\
  end\
  return list\
end\
\
-- 获取地图棋盘和相关数据\
mapEvent.getMapChessboard = function()\
  return {\
    width = 9,\
    height = 6,\
    obstacle = {\
      { 1, 5 }, { 1, 8 }, { 1, 9 },\
      { 2, 3 }, { 2, 5 }, { 2, 9 },\
      { 3, 6 },\
      { 4, 1 }, { 4, 2 }, { 4, 3 }, { 4, 8 },\
      { 5, 6 },\
      { 6, 6 },\
    },\
    waitForBossPosition = { { 1, 6 } },\
    bossPosition = {},\
    myFleetList = {},\
    enemyPositionList1 = {},\
    enemyPositionList2 = {},\
    enemyPositionList3 = {},\
    inBattleList = {},\
    selectedArrowList = {},\
    rewardBoxList = {},\
  }\
end\
\
return mapEvent" }


package.sourceCode = package.sourceCode or {}
package.sourceCode["./meta-operation/maps-options/map10-3.lua"] = { path = "./meta-operation/maps-options/map10-3.lua", name = "./meta-operation/maps-options/map10-3.lua", source = "local mapBase = require './map'\
local imgEvent = require './img10-3'\
local mapEvent = {}\
\
-- 从mapBase继承方法\
mapEvent = table.assign(mapEvent, mapBase)\
for key, value in pairs(mapBase) do\
  if type(value) == 'function' then\
    mapEvent[key] = function(...)\
      return value(imgEvent, ...)\
    end\
  end\
end\
\
-- 获取地图采样位置。由于地图可能超出一屏，所以这里可以定义多个采样位置。每次扫描都会对每个采样位置进行扫描\
-- 标志位为地图四个角。每个采样位置只需定义一个角的坐标即可。\
-- 还需要定义每个采样位置的地图矩阵与屏幕坐标的映射关系\
mapEvent.getCheckpositionList = function()\
  local list = {\
    {\
      leftTop = { 494, 507 },\
      rightTop = nil,\
      leftBotton = nil,\
      rightBotton = nil,\
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的\
      positionMap = {\
        { { 494, 507, 0x080c19 }, { 662, 507, 0x29243a }, { 832, 507, 0x101421 }, { 1001, 507, 0x191831 }, { 1170, 507, 0x101829 }, { 1340, 507, 0x101c31 }, },\
        { { 476, 630, 0x000000 }, { 651, 630, 0x191831 }, { 827, 630, 0x21183a }, { 1003, 630, 0x211c3a }, { 1179, 630, 0x212042 }, { 1354, 630, 0x292442 }, },\
        { { 455, 763, 0x000000 }, { 638, 763, 0x191831 }, { 821, 763, 0x212042 }, { 1004, 763, 0x191831 }, { 1188, 763, 0x21203a }, { 1372, 763, 0x191c31 }, },\
        { { 433, 908, 0x000000 }, { 623, 908, 0x211831 }, { 815, 908, 0x191831 }, { 1006, 908, 0x212042 }, { 1198, 908, 0x21203a }, { 1390, 908, 0x21243a }, },\
      },\
      pointMap = {},\
    },\
    {\
      leftTop = nil,\
      rightTop = { 1607, 505 },\
      leftBotton = nil,\
      rightBotton = nil,\
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的\
      positionMap = {\
        { false, false, false, false, false, { 928, 505, 0x191429 }, { 1097, 505, 0x191831 }, { 1266, 505, 0x101831 }, { 1436, 505, 0x191c31 }, { 1607, 505, 0x192031 }, },\
        { false, false, false, false, false, { 927, 627, 0x292442 }, { 1102, 627, 0x19203a }, { 1279, 627, 0x312d4a }, { 1455, 627, 0x3a3563 }, { 1633, 627, 0x000000 }, },\
        { false, false, false, false, false, { 925, 761, 0x292042 }, { 1109, 761, 0x292042 }, { 1292, 761, 0x191831 }, { 1476, 761, 0x212442 }, { 1661, 761, 0x000000 }, },\
        { false, false, false, false, false, { 923, 906, 0x211831 }, { 1115, 906, 0x211c3a }, { 1307, 906, 0x211c3a }, { 1498, 906, 0x31244a }, { 1692, 906, 0x000000 }, },\
      },\
      pointMap = {},\
    },\
    {\
      leftTop = { 561, 257 },\
      rightTop = nil,\
      leftBotton = nil,\
      rightBotton = nil,\
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的\
      positionMap = {\
        false, false, false,\
        { { 508, 625, 0x000000 }, { 698, 625, 0x191431 }, { 890, 625, 0x191831 }, { 1081, 625, 0x211c3a }, { 1273, 625, 0x211c3a }, { 1465, 625, 0x292042 }, },\
        { { 487, 771, 0x000000 }, { 686, 771, 0x292d29 }, { 886, 771, 0x31354a }, { 1087, 771, 0x211c3a }, { 1288, 771, 0x191429 }, { 1488, 771, 0x191829 }, },\
        { { 462, 931, 0x100800 }, { 672, 931, 0xbdc6bd }, { 883, 931, 0x21183a }, { 1094, 931, 0x191831 }, { 1304, 931, 0x191421 }, { 1515, 931, 0x191419 }, },\
      },\
      pointMap = {},\
    },\
    {\
      leftTop = nil,\
      rightTop = { 1493, 249 },\
      leftBotton = nil,\
      rightBotton = nil,\
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的\
      positionMap = {\
        false, false, false,\
        { false, false, false, false, false, { 795, 616, 0x211831 }, { 987, 616, 0x211c31 }, { 1178, 616, 0x292042 }, { 1370, 616, 0x29244a }, { 1564, 616, 0x000000 }, },\
        { false, false, false, false, false, { 787, 761, 0x191c31 }, { 988, 761, 0x191429 }, { 1188, 761, 0x191831 }, { 1389, 761, 0x292042 }, { 1592, 761, 0x000000 }, },\
        { false, false, false, false, false, { 779, 920, 0x191829 }, { 989, 920, 0x191831 }, { 1199, 920, 0x211831 }, { 1410, 920, 0x191821 }, { 1623, 920, 0x080c08 }, },\
      },\
      pointMap = {},\
    },\
    {\
      leftTop = nil,\
      rightTop = nil,\
      leftBotton = { 446, 909 },\
      rightBotton = nil,\
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的\
      positionMap = {\
        false, false, false, false, false,\
        { { 493, 574, 0x8c2829 }, { 703, 574, 0xfffbff }, { 914, 574, 0x211c42 }, { 1124, 574, 0x212042 }, { 1334, 574, 0x211c42 }, },\
        { { 472, 732, 0x000000 }, { 691, 732, 0x211831 }, { 912, 732, 0x211c42 }, { 1133, 732, 0x191831 }, { 1353, 732, 0x191831 }, },\
        { { 446, 909, 0x000000 }, { 677, 909, 0x000000 }, { 910, 909, 0x000000 }, { 1143, 909, 0x000000 }, { 1375, 909, 0x000000 }, },\
      },\
      pointMap = {},\
    },\
    {\
      leftTop = nil,\
      rightTop = nil,\
      leftBotton = nil,\
      rightBotton = { 1630, 912 },\
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的\
      positionMap = {\
        false, false, false, false, false,\
        { false, false, false, false, { 512, 576, 0x211c42 }, { 722, 576, 0x211c3a }, { 932, 576, 0x211c42 }, { 1142, 576, 0x211c3a }, { 1352, 576, 0x292042 }, { 1565, 576, 0x000000 }, },\
        { false, false, false, false, { 489, 735, 0x191c31 }, { 710, 735, 0x191421 }, { 931, 735, 0x211c3a }, { 1152, 735, 0x191829 }, { 1373, 735, 0x211c3a }, { 1596, 735, 0x000000 }, },\
        { false, false, false, false, { 464, 912, 0x000000 }, { 696, 912, 0x000000 }, { 929, 912, 0x000000 }, { 1162, 912, 0x000000 }, { 1395, 912, 0x000000 }, { 1630, 912, 0x000000 }, },\
      },\
      pointMap = {},\
    },\
  }\
  for key = 1, #list do\
    local positionMap = list[key].positionMap\
    for rowNum, rol in ipairs(positionMap) do\
      if rol and positionMap[rowNum + 1] then\
        for colNum, col in ipairs(rol) do\
          if col and rol[colNum + 1] then\
            list[key].pointMap[rowNum .. '-' .. colNum] = col\
          end\
        end\
      end\
    end\
  end\
  return list\
end\
\
-- 获取地图棋盘和相关数据\
mapEvent.getMapChessboard = function()\
  return {\
    width = 9,\
    height = 6,\
    obstacle = {\
      { 1, 7 },\
      { 2, 2 }, { 2, 3 }, { 2, 4 }, { 2, 7 },\
      { 4, 3 }, { 4, 4 }, { 4, 7 },\
      { 5, 5 }, { 5, 6 }, { 5, 7 },\
      { 6, 1 },\
    },\
    waitForBossPosition = { { 1, 6 } },\
    bossPosition = {},\
    myFleetList = {},\
    enemyPositionList1 = {},\
    enemyPositionList2 = {},\
    enemyPositionList3 = {},\
    inBattleList = {},\
    selectedArrowList = {},\
    rewardBoxList = {},\
  }\
end\
\
return mapEvent" }


package.sourceCode = package.sourceCode or {}
package.sourceCode["./meta-operation/maps-options/map10-2.lua"] = { path = "./meta-operation/maps-options/map10-2.lua", name = "./meta-operation/maps-options/map10-2.lua", source = "local mapBase = require './map'\
local imgEvent = require './img10-2'\
local mapEvent = {}\
\
-- 从mapBase继承方法\
mapEvent = table.assign(mapEvent, mapBase)\
for key, value in pairs(mapBase) do\
  if type(value) == 'function' then\
    mapEvent[key] = function(...)\
      return value(imgEvent, ...)\
    end\
  end\
end\
\
-- 获取地图采样位置。由于地图可能超出一屏，所以这里可以定义多个采样位置。每次扫描都会对每个采样位置进行扫描\
-- 标志位为地图四个角。每个采样位置只需定义一个角的坐标即可。\
-- 还需要定义每个采样位置的地图矩阵与屏幕坐标的映射关系\
mapEvent.getCheckpositionList = function()\
  local list = {\
    {\
      leftTop = { 606, 519 },\
      rightTop = nil,\
      leftBotton = nil,\
      rightBotton = nil,\
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的\
      positionMap = {\
        { { 606, 519, 0x312810 }, { 762, 519, 0x191819 }, { 944, 519, 0x081421 }, { 1113, 519, 0x101829 }, { 1282, 519, 0x101829 }, },\
        { { 593, 642, 0xb5b6bd }, { 760, 642, 0xdeb67b }, { 943, 642, 0x21183a }, { 1119, 642, 0x21203a }, { 1295, 642, 0x212042 }, },\
        { { 577, 776, 0x000000 }, { 759, 776, 0x191831 }, { 942, 776, 0x313931 }, { 1126, 776, 0x212042 }, { 1309, 776, 0x292042 }, },\
        { { 560, 922, 0x000000 }, { 750, 922, 0x211c42 }, { 941, 922, 0x191831 }, { 1133, 922, 0x312d3a }, { 1325, 922, 0x312d52 }, },\
      },\
      pointMap = {},\
    },\
    {\
      leftTop = nil,\
      rightTop = { 1513, 526 },\
      leftBotton = nil,\
      rightBotton = nil,\
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的\
      positionMap = {\
        { false, false, false, false, { 835, 526, 0x101421 }, { 1004, 526, 0x191829 }, { 1173, 526, 0x101429 }, { 1342, 526, 0x211c31 }, { 1513, 526, 0x101c29 }, },\
        { false, false, false, false, { 829, 650, 0x21203a }, { 1005, 650, 0x212042 }, { 1182, 650, 0x292852 }, { 1358, 650, 0x423d63 }, { 1536, 650, 0x000000 }, },\
        { false, false, false, false, { 824, 784, 0x292442 }, { 1008, 784, 0x292042 }, { 1191, 784, 0x211c3a }, { 1374, 784, 0x31244a }, { 1560, 784, 0x000000 }, },\
        { false, false, false, false, { 816, 930, 0xada2ad }, { 1009, 930, 0x211829 }, { 1201, 930, 0x211c3a }, { 1391, 930, 0x191419 }, { 1588, 930, 0x101010 }, },\
      },\
      pointMap = {},\
    },\
    {\
      leftTop = nil,\
      rightTop = nil,\
      leftBotton = { 509, 939 },\
      rightBotton = nil,\
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的\
      positionMap = {\
        false, false, false,\
        { { 568, 478, 0x000000 }, { 758, 478, 0x211c42 }, { 950, 478, 0x31285a }, { 1143, 478, 0x212029 }, { 1334, 478, 0x292042 }, },\
        { { 550, 617, 0x000000 }, { 750, 617, 0x191429 }, { 950, 617, 0x191431 }, { 1150, 617, 0x191429 }, { 1351, 617, 0x211c3a }, },\
        { { 530, 769, 0x000000 }, { 739, 769, 0x19183a }, { 950, 769, 0x191429 }, { 1160, 769, 0x191429 }, { 1370, 769, 0x191429 }, },\
        { { 509, 939, 0x000000 }, { 728, 939, 0x000000 }, { 949, 939, 0x000000 }, { 1170, 939, 0x000000 }, { 1391, 939, 0x101010 }, },\
      },\
      pointMap = {},\
    },\
    {\
      leftTop = nil,\
      rightTop = nil,\
      leftBotton = nil,\
      rightBotton = { 1611, 934 },\
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的\
      positionMap = {\
        false, false, false,\
        { false, false, false, false, { 755, 473, 0xa49ead }, { 948, 473, 0x191829 }, { 1140, 473, 0x191831 }, { 1330, 473, 0x5a6173 }, { 1525, 473, 0x000000 }, },\
        { false, false, false, false, { 747, 612, 0x211c31 }, { 948, 612, 0x211c42 }, { 1148, 612, 0x212042 }, { 1348, 612, 0x292042 }, { 1551, 612, 0x000000 }, },\
        { false, false, false, false, { 736, 764, 0x211c42 }, { 947, 764, 0x191829 }, { 1156, 764, 0x292842 }, { 1367, 764, 0x211831 }, { 1580, 764, 0x000000 }, },\
        { false, false, false, false, { 725, 934, 0x000000 }, { 947, 934, 0x000000 }, { 1168, 934, 0x000000 }, { 1388, 934, 0x211c21 }, { 1611, 934, 0x191819 }, },\
      },\
      pointMap = {},\
    },\
  }\
  for key = 1, #list do\
    local positionMap = list[key].positionMap\
    for rowNum, rol in ipairs(positionMap) do\
      if rol and positionMap[rowNum + 1] then\
        for colNum, col in ipairs(rol) do\
          if col and rol[colNum + 1] then\
            list[key].pointMap[rowNum .. '-' .. colNum] = col\
          end\
        end\
      end\
    end\
  end\
  return list\
end\
\
-- 获取地图棋盘和相关数据\
mapEvent.getMapChessboard = function()\
  return {\
    width = 8,\
    height = 6,\
    obstacle = {\
      { 1, 6 },\
      { 2, 2 }, { 2, 3 }, { 2, 6 },\
      { 3, 3 }, { 3, 4 }, { 3, 8 },\
      { 4, 3 }, { 4, 4 }, { 4, 8 },\
      { 5, 2 }, { 5, 3 }, { 5, 6 },\
      { 6, 6 },\
    },\
    waitForBossPosition = { { 1, 8 } },\
    bossPosition = {},\
    myFleetList = {},\
    enemyPositionList1 = {},\
    enemyPositionList2 = {},\
    enemyPositionList3 = {},\
    inBattleList = {},\
    selectedArrowList = {},\
    rewardBoxList = {},\
  }\
end\
\
return mapEvent" }


package.sourceCode = package.sourceCode or {}
package.sourceCode["./meta-operation/maps-options/map10-1.lua"] = { path = "./meta-operation/maps-options/map10-1.lua", name = "./meta-operation/maps-options/map10-1.lua", source = "local mapBase = require './map'\
local imgEvent = require './img10-4'\
local mapEvent = {}\
\
-- 从mapBase继承方法\
mapEvent = table.assign(mapEvent, mapBase)\
for key, value in pairs(mapBase) do\
  if type(value) == 'function' then\
    mapEvent[key] = function(...)\
      return value(imgEvent, ...)\
    end\
  end\
end\
\
-- 获取地图采样位置。由于地图可能超出一屏，所以这里可以定义多个采样位置。每次扫描都会对每个采样位置进行扫描\
-- 标志位为地图四个角。每个采样位置只需定义一个角的坐标即可。\
-- 还需要定义每个采样位置的地图矩阵与屏幕坐标的映射关系\
mapEvent.getCheckpositionList = function()\
  local list = {\
    {\
      leftTop = nil,\
      rightTop = { 1625, 529 },\
      leftBotton = nil,\
      rightBotton = nil,\
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的\
      positionMap = {\
        { { 439, 529, 0x081019 }, { 608, 529, 0x081019 }, { 777, 529, 0x101421 }, { 946, 529, 0x101821 }, { 1115, 529, 0x21283a }, { 1285, 529, 0x192031 }, { 1454, 529, 0x101c29 }, { 1625, 529, 0x101c29 }, },\
        { { 418, 653, 0x000000 }, { 593, 653, 0x211c3a }, { 769, 653, 0x211c3a }, { 949, 653, 0x313163 }, { 1121, 653, 0x292042 }, { 1298, 653, 0x19203a }, { 1474, 653, 0x29284a }, { 1652, 653, 0x000000 }, },\
        { { 396, 787, 0x000000 }, { 580, 787, 0xdea608 }, { 762, 787, 0x191831 }, { 945, 787, 0x292442 }, { 1128, 787, 0x191831 }, { 1312, 787, 0x191831 }, { 1495, 787, 0x292042 }, { 1681, 787, 0x000000 }, },\
        { { 371, 933, 0x000000 }, { 561, 933, 0x211c3a }, { 752, 933, 0x191831 }, { 944, 933, 0x191429 }, { 1136, 933, 0x191829 }, { 1328, 933, 0x31285a }, { 1519, 933, 0x212031 }, { 1713, 933, 0x313131 }, },\
      },\
      pointMap = {},\
    },\
    {\
      leftTop = nil,\
      rightTop = nil,\
      leftBotton = nil,\
      rightBotton = { 1805, 956 },\
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的\
      positionMap = {\
        false, false, false,\
        { { 349, 493, 0x000000 }, { 539, 493, 0x211c3a }, { 731, 493, 0x312d31 }, { 922, 493, 0x29243a }, { 1114, 493, 0x191829 }, { 1306, 493, 0x31285a }, { 1497, 493, 0x211c42 }, { 1691, 493, 0x000000 }, },\
        { { 320, 632, 0x000000 }, { 520, 632, 0x424142 }, { 720, 632, 0x211c42 }, { 920, 632, 0x211c42 }, { 1121, 632, 0x191831 }, { 1321, 632, 0x211831 }, { 1522, 632, 0x212042 }, { 1725, 632, 0x000000 }, },\
        { { 285, 785, 0x846952 }, { 498, 785, 0x191831 }, { 709, 785, 0x21183a }, { 918, 785, 0x191429 }, { 1128, 785, 0x191421 }, { 1339, 785, 0x211c3a }, { 1550, 785, 0x212031 }, { 1762, 785, 0x000000 }, },\
        { { 255, 956, 0x000000 }, { 475, 956, 0x000000 }, { 696, 956, 0x000000 }, { 917, 956, 0x000000 }, { 1138, 956, 0x000000 }, { 1359, 956, 0x848a84 }, { 1580, 956, 0x101010 }, { 1805, 956, 0x847d84 }, },\
      },\
      pointMap = {},\
    },\
  }\
  for key = 1, #list do\
    local positionMap = list[key].positionMap\
    for rowNum, rol in ipairs(positionMap) do\
      if rol and positionMap[rowNum + 1] then\
        for colNum, col in ipairs(rol) do\
          if col and rol[colNum + 1] then\
            list[key].pointMap[rowNum .. '-' .. colNum] = col\
          end\
        end\
      end\
    end\
  end\
  return list\
end\
\
-- 获取地图棋盘和相关数据\
mapEvent.getMapChessboard = function()\
  return {\
    width = 7,\
    height = 6,\
    obstacle = {\
      { 1, 3 },\
      { 2, 3 },\
      { 3, 5 }, { 3, 6 },\
      { 4, 6 },\
      { 5, 3 },\
      { 6, 3 }, { 6, 4 }, { 6, 7 },\
    },\
    waitForBossPosition = { { 2, 7 } },\
    bossPosition = {},\
    myFleetList = {},\
    enemyPositionList1 = {},\
    enemyPositionList2 = {},\
    enemyPositionList3 = {},\
    inBattleList = {},\
    selectedArrowList = {},\
    rewardBoxList = {},\
  }\
end\
\
return mapEvent" }


package.sourceCode = package.sourceCode or {}
package.sourceCode["./meta-operation/maps-options/map9-4.lua"] = { path = "./meta-operation/maps-options/map9-4.lua", name = "./meta-operation/maps-options/map9-4.lua", source = "local mapBase = require './map'\
local imgEvent = require './img9-4'\
local mapEvent = {}\
\
-- 从mapBase继承方法\
mapEvent = table.assign(mapEvent, mapBase)\
for key, value in pairs(mapBase) do\
  if type(value) == 'function' then\
    mapEvent[key] = function(...)\
      return value(imgEvent, ...)\
    end\
  end\
end\
\
-- 获取地图采样位置。由于地图可能超出一屏，所以这里可以定义多个采样位置。每次扫描都会对每个采样位置进行扫描\
-- 标志位为地图四个角。每个采样位置只需定义一个角的坐标即可。\
-- 还需要定义每个采样位置的地图矩阵与屏幕坐标的映射关系\
mapEvent.getCheckpositionList = function()\
  local list = {\
    {\
      leftTop = { 384, 519 },\
      rightTop = nil,\
      leftBotton = nil,\
      rightBotton = nil,\
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的\
      positionMap = {\
        { { 384, 519, 0x001010 }, { 552, 519, 0x000c10 }, { 721, 519, 0x081419 }, { 890, 519, 0x081019 }, { 1060, 519, 0x081019 }, { 1229, 519, 0x101821 }, },\
        { { 361, 643, 0x000000 }, { 536, 643, 0x191429 }, { 712, 643, 0x191831 }, { 888, 643, 0x191831 }, { 1064, 643, 0x191c3a }, { 1240, 643, 0x191c3a }, },\
        { { 334, 776, 0x312819 }, { 518, 776, 0x21203a }, { 701, 776, 0x211c3a }, { 885, 776, 0x211c3a }, { 1068, 776, 0x31244a }, { 1252, 776, 0x292042 }, },\
        { { 308, 922, 0x000000 }, { 499, 922, 0x424142 }, { 690, 922, 0x212042 }, { 881, 922, 0x211831 }, { 1073, 922, 0x211831 }, { 1265, 922, 0x211831 }, },\
      },\
      pointMap = {},\
    },\
    {\
      leftTop = nil,\
      rightTop = { 1595, 530 },\
      leftBotton = nil,\
      rightBotton = nil,\
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的\
      positionMap = {\
        { false, false, false, false, false, { 916, 530, 0x191829 }, { 1085, 530, 0x081019 }, { 1254, 530, 0x211829 }, { 1424, 530, 0x191c29 }, { 1595, 530, 0x101829 }, },\
        { false, false, false, false, false, { 914, 654, 0x292442 }, { 1090, 654, 0x29284a }, { 1266, 654, 0x313552 }, { 1442, 654, 0x423d63 }, { 1620, 654, 0x000000 }, },\
        { false, false, false, false, false, { 912, 788, 0x292042 }, { 1095, 788, 0x212042 }, { 1279, 788, 0x211c3a }, { 1463, 788, 0x21244a }, { 1648, 788, 0x000000 }, },\
        { false, false, false, false, false, { 910, 935, 0x191429 }, { 1102, 935, 0x191831 }, { 1293, 935, 0x21203a }, { 1484, 935, 0x292d31 }, { 1679, 935, 0x292829 }, },\
      },\
      pointMap = {},\
    },\
    {\
      leftTop = nil,\
      rightTop = nil,\
      leftBotton = { 235, 921 },\
      rightBotton = nil,\
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的\
      positionMap = {\
        false, false, false,\
        { { 331, 463, 0x000000 }, { 521, 463, 0x101010 }, { 713, 463, 0x191c3a }, { 905, 463, 0x42456b }, { 1097, 463, 0x211c3a }, { 1288, 463, 0x191429 }, },\
        { { 300, 601, 0x949694 }, { 501, 601, 0x191c19 }, { 701, 601, 0x29203a }, { 901, 601, 0x31283a }, { 1101, 601, 0xada2ad }, { 1303, 601, 0x211c3a }, },\
        { { 270, 752, 0x000000 }, { 479, 752, 0x191831 }, { 689, 752, 0x211831 }, { 899, 752, 0x191831 }, { 1110, 752, 0x211c3a }, { 1320, 752, 0x211c42 }, },\
        { { 235, 921, 0x000000 }, { 455, 921, 0x000000 }, { 675, 921, 0x000000 }, { 896, 921, 0x000000 }, { 1118, 921, 0x000000 }, { 1338, 921, 0x000000 }, },\
      },\
      pointMap = {},\
    },\
    {\
      leftTop = nil,\
      rightTop = nil,\
      leftBotton = nil,\
      rightBotton = { 1724, 933 },\
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的\
      positionMap = {\
        false, false, false,\
        { false, false, false, false, false, { 854, 472, 0x211c3a }, { 1045, 472, 0x211831 }, { 1237, 472, 0x211c3a }, { 1428, 472, 0x292442 }, { 1622, 472, 0x000000 }, },\
        { false, false, false, false, false, { 849, 611, 0x211c3a }, { 1049, 611, 0x211c31 }, { 1249, 611, 0x211c31 }, { 1450, 611, 0x211c31 }, { 1653, 611, 0x000000 }, },\
        { false, false, false, false, false, { 843, 763, 0x211831 }, { 1053, 763, 0x191c31 }, { 1264, 763, 0x3a3563 }, { 1474, 763, 0x191431 }, { 1687, 763, 0x000000 }, },\
        { false, false, false, false, false, { 838, 933, 0x000000 }, { 1059, 933, 0x000000 }, { 1280, 933, 0x000000 }, { 1499, 933, 0x101410 }, { 1724, 933, 0x292d29 }, },\
      },\
      pointMap = {},\
    },\
  }\
  for key = 1, #list do\
    local positionMap = list[key].positionMap\
    for rowNum, rol in ipairs(positionMap) do\
      if rol and positionMap[rowNum + 1] then\
        for colNum, col in ipairs(rol) do\
          if col and rol[colNum + 1] then\
            list[key].pointMap[rowNum .. '-' .. colNum] = col\
          end\
        end\
      end\
    end\
  end\
  return list\
end\
\
-- 获取地图棋盘和相关数据\
mapEvent.getMapChessboard = function()\
  return {\
    width = 9,\
    height = 6,\
    obstacle = {\
      { 1, 5 }, { 1, 6 }, { 1, 7 },\
      { 2, 2 },\
      { 3, 8 },\
      { 4, 3 }, { 4, 4 },\
      { 5, 4 }, { 5, 7 },\
      { 6, 7 },\
    },\
    waitForBossPosition = { { 1, 1 }, { 1, 9 }, { 6, 9 } },\
    bossPosition = {},\
    myFleetList = {},\
    enemyPositionList1 = {},\
    enemyPositionList2 = {},\
    enemyPositionList3 = {},\
    inBattleList = {},\
    selectedArrowList = {},\
    rewardBoxList = {},\
  }\
end\
\
return mapEvent" }


package.sourceCode = package.sourceCode or {}
package.sourceCode["./meta-operation/maps-options/map9-3.lua"] = { path = "./meta-operation/maps-options/map9-3.lua", name = "./meta-operation/maps-options/map9-3.lua", source = "local mapBase = require './map'\
local imgEvent = require './img9-3'\
local mapEvent = {}\
\
-- 从mapBase继承方法\
mapEvent = table.assign(mapEvent, mapBase)\
for key, value in pairs(mapBase) do\
  if type(value) == 'function' then\
    mapEvent[key] = function(...)\
      return value(imgEvent, ...)\
    end\
  end\
end\
\
-- 获取地图采样位置。由于地图可能超出一屏，所以这里可以定义多个采样位置。每次扫描都会对每个采样位置进行扫描\
-- 标志位为地图四个角。每个采样位置只需定义一个角的坐标即可。\
-- 还需要定义每个采样位置的地图矩阵与屏幕坐标的映射关系\
mapEvent.getCheckpositionList = function()\
  local list = {\
    {\
      leftTop = nil,\
      rightTop = { 1670, 505 },\
      leftBotton = nil,\
      rightBotton = nil,\
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的\
      positionMap = {\
        { { 315, 505, 0x102431 }, { 483, 505, 0x10283a }, { 653, 505, 0x19243a }, { 822, 505, 0x102031 }, { 991, 505, 0x10203a }, { 1160, 505, 0x10203a }, { 1330, 505, 0x10243a }, { 1499, 505, 0x192d42 }, { 1670, 505, 0x10283a }, },\
        { { 289, 628, 0x000000 }, { 465, 628, 0x191831 }, { 640, 628, 0x29244a }, { 816, 628, 0x212442 }, { 992, 628, 0x292042 }, { 1168, 628, 0x292442 }, { 1345, 628, 0x292442 }, { 1522, 628, 0x4a417b }, { 1699, 628, 0x000000 }, },\
        { { 260, 761, 0x212000 }, { 443, 761, 0x292d29 }, { 627, 761, 0x21203a }, { 811, 761, 0x21203a }, { 994, 761, 0x191c3a }, { 1179, 761, 0xe6a263 }, { 1361, 761, 0x291c42 }, { 1544, 761, 0x21203a }, { 1730, 761, 0x000000 }, },\
        { { 230, 906, 0x000000 }, { 421, 906, 0x191831 }, { 612, 906, 0x212042 }, { 804, 906, 0x211c3a }, { 995, 906, 0x9ca2b5 }, { 1186, 906, 0x212042 }, { 1379, 906, 0x291c3a }, { 1570, 906, 0x292442 }, { 1764, 906, 0x000000 }, },\
      },\
      pointMap = {},\
    },\
    {\
      leftTop = nil,\
      rightTop = { 1680, 373 },\
      leftBotton = nil,\
      rightBotton = nil,\
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的\
      positionMap = {\
        false, false, false,\
        { { 241, 757, 0x000000 }, { 431, 757, 0x211c3a }, { 623, 757, 0x191c3a }, { 815, 757, 0x211c3a }, { 1007, 757, 0x9ca2b5 }, { 1198, 757, 0x9caebd }, { 1390, 757, 0x191831 }, { 1581, 757, 0x292042 }, { 1775, 757, 0x000000 }, },\
        { { 208, 908, 0x000000 }, { 407, 908, 0x191831 }, { 608, 908, 0x211410 }, { 808, 908, 0x211c42 }, { 1008, 908, 0x212042 }, { 1209, 908, 0x191831 }, { 1410, 908, 0x21203a }, { 1610, 908, 0x292042 }, { 1813, 908, 0x000000 }, },\
      },\
      pointMap = {},\
    },\
    {\
      leftTop = nil,\
      rightTop = nil,\
      leftBotton = nil,\
      rightBotton = { 1768, 903 },\
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的\
      positionMap = {\
        false, false, false, false,\
        { { 88, 584, 0x000000 }, { 287, 584, 0x191831 }, { 488, 584, 0xbd3d00 }, { 689, 584, 0x191831 }, { 889, 584, 0x211c31 }, { 1089, 584, 0x191c31 }, { 1290, 584, 0x292442 }, { 1490, 584, 0x292042 }, { 1693, 584, 0x000000 }, },\
        { { 44, 735, 0x9475b5 }, { 255, 735, 0x211c3a }, { 465, 735, 0x21183a }, { 675, 735, 0x21183a }, { 886, 735, 0x191429 }, { 1096, 735, 0x191421 }, { 1306, 735, 0x191829 }, { 1516, 735, 0x191829 }, { 1729, 735, 0x000000 }, },\
        { { 0, 903, 0x101410 }, { 219, 903, 0x000000 }, { 440, 903, 0x000000 }, { 660, 903, 0x000000 }, { 881, 903, 0x000000 }, { 1102, 903, 0x000000 }, { 1323, 903, 0x000000 }, { 1545, 903, 0x000000 }, { 1768, 903, 0x000000 }, },\
      },\
      pointMap = {},\
    },\
  }\
  for key = 1, #list do\
    local positionMap = list[key].positionMap\
    for rowNum, rol in ipairs(positionMap) do\
      if rol and positionMap[rowNum + 1] then\
        for colNum, col in ipairs(rol) do\
          if col and rol[colNum + 1] then\
            list[key].pointMap[rowNum .. '-' .. colNum] = col\
          end\
        end\
      end\
    end\
  end\
  return list\
end\
\
-- 获取地图棋盘和相关数据\
mapEvent.getMapChessboard = function()\
  return {\
    width = 8,\
    height = 6,\
    obstacle = {\
      { 1, 7 },\
      { 2, 2 }, { 2, 3 }, { 2, 4 }, { 2, 7 },\
      { 3, 5 },\
      { 4, 4 },\
      { 5, 1 }, { 5, 5 }, { 5, 6 }, { 5, 7 },\
      { 6, 1 }, { 6, 2 },\
    },\
    waitForBossPosition = { { 1, 1 }, { 1, 8 }, { 2, 5 }, { 5, 4 }, { 6, 8 } },\
    bossPosition = {},\
    myFleetList = {},\
    enemyPositionList1 = {},\
    enemyPositionList2 = {},\
    enemyPositionList3 = {},\
    inBattleList = {},\
    selectedArrowList = {},\
    rewardBoxList = {},\
  }\
end\
\
return mapEvent" }


package.sourceCode = package.sourceCode or {}
package.sourceCode["./meta-operation/maps-options/map9-2.lua"] = { path = "./meta-operation/maps-options/map9-2.lua", name = "./meta-operation/maps-options/map9-2.lua", source = "local mapBase = require './map'\
local imgEvent = require './img9-2'\
local mapEvent = {}\
\
-- 从mapBase继承方法\
mapEvent = table.assign(mapEvent, mapBase)\
for key, value in pairs(mapBase) do\
  if type(value) == 'function' then\
    mapEvent[key] = function(...)\
      return value(imgEvent, ...)\
    end\
  end\
end\
\
-- 获取地图采样位置。由于地图可能超出一屏，所以这里可以定义多个采样位置。每次扫描都会对每个采样位置进行扫描\
-- 标志位为地图四个角。每个采样位置只需定义一个角的坐标即可。\
-- 还需要定义每个采样位置的地图矩阵与屏幕坐标的映射关系\
mapEvent.getCheckpositionList = function()\
  local list = {\
    {\
      leftTop = nil,\
      rightTop = { 1826, 495 },\
      leftBotton = nil,\
      rightBotton = nil,\
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的\
      positionMap = {\
        { { 302, 495, 0x000c11 }, { 470, 495, 0x000c10 }, { 639, 495, 0x192029 }, { 808, 495, 0x081010 }, { 978, 495, 0x101c21 }, { 1147, 495, 0x212d3a }, { 1317, 495, 0x101819 }, { 1486, 495, 0x101819 }, { 1655, 495, 0x292429 }, { 1826, 495, 0x081419 }, },\
        { { 276, 617, 0x000000 }, { 450, 617, 0x424173 }, { 627, 617, 0x211c3a }, { 803, 617, 0x211c3a }, { 978, 617, 0x191c3a }, { 1155, 617, 0x292042 }, { 1331, 617, 0x292042 }, { 1507, 617, 0x29284a }, { 1683, 617, 0x3a315a }, { 1861, 617, 0x000000 }, },\
        { { 247, 750, 0x000000 }, { 429, 750, 0x211831 }, { 614, 750, 0x946910 }, { 796, 750, 0x212042 }, { 980, 750, 0x63598c }, { 1163, 750, 0x292442 }, { 1347, 750, 0x291c42 }, { 1530, 750, 0x31244a }, { 1713, 750, 0x212042 }, { 1899, 750, 0x000000 }, },\
        { { 215, 895, 0x000000 }, { 405, 895, 0x19183a }, { 597, 895, 0x211c3a }, { 787, 895, 0xef5963 }, { 981, 885, 0x4a454a }, { 1172, 895, 0x191421 }, { 1365, 895, 0xffffde }, { 1555, 895, 0x211c3a }, { 1747, 895, 0x292042 }, { 1913, 908, 0x42356b }, },\
      },\
      pointMap = {},\
    },\
    {\
      leftTop = nil,\
      rightTop = nil,\
      leftBotton = { 363, 902 },\
      rightBotton = nil,\
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的\
      positionMap = {\
        false, false, false,\
        { { 416, 597, 0x000000 }, { 607, 597, 0x19183a }, { 798, 597, 0x191831 }, { 990, 597, 0xe65963 }, { 1182, 597, 0x6b4521 }, },\
        { { 391, 742, 0x000000 }, { 590, 742, 0x211c42 }, { 791, 742, 0x191831 }, { 991, 742, 0x211831 }, { 1190, 742, 0x211c42 }, },\
        { { 363, 902, 0x000000 }, { 572, 902, 0x000000 }, { 783, 902, 0x000000 }, { 993, 902, 0x000000 }, { 1203, 902, 0x000000 }, },\
      },\
      pointMap = {},\
    },\
    {\
      leftTop = nil,\
      rightTop = nil,\
      leftBotton = nil,\
      rightBotton = { 1615, 902 },\
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的\
      positionMap = {\
        false, false, false,\
        { false, false, false, false, { 597, 597, 0xffffff }, { 783, 597, 0x7b5552 }, { 980, 597, 0x191410 }, { 1172, 597, 0x191831 }, { 1363, 597, 0x292042 }, { 1557, 597, 0x000000 }, },\
        { false, false, false, false, { 580, 742, 0x211c3a }, { 780, 742, 0x191819 }, { 981, 742, 0x191829 }, { 1181, 742, 0x191831 }, { 1382, 742, 0x212042 }, { 1585, 742, 0x000000 }, },\
        { false, false, false, false, { 561, 902, 0x000000 }, { 772, 902, 0x000000 }, { 982, 902, 0x000000 }, { 1192, 902, 0x000000 }, { 1402, 902, 0x000000 }, { 1615, 902, 0x000000 }, },\
      },\
      pointMap = {},\
    },\
  }\
  for key = 1, #list do\
    local positionMap = list[key].positionMap\
    for rowNum, rol in ipairs(positionMap) do\
      if rol and positionMap[rowNum + 1] then\
        for colNum, col in ipairs(rol) do\
          if col and rol[colNum + 1] then\
            list[key].pointMap[rowNum .. '-' .. colNum] = col\
          end\
        end\
      end\
    end\
  end\
  return list\
end\
\
-- 获取地图棋盘和相关数据\
mapEvent.getMapChessboard = function()\
  return {\
    width = 9,\
    height = 5,\
    obstacle = {\
      { 1, 1 }, { 1, 2 },\
      { 2, 2 }, { 2, 7 },\
      { 3, 4 }, { 3, 5 }, { 3, 6 }, { 3, 7 }, { 3, 9 },\
      { 4, 2 }, { 4, 5 },\
      { 5, 5 },\
    },\
    waitForBossPosition = { { 1, 5 } },\
    bossPosition = {},\
    myFleetList = {},\
    enemyPositionList1 = {},\
    enemyPositionList2 = {},\
    enemyPositionList3 = {},\
    inBattleList = {},\
    selectedArrowList = {},\
    rewardBoxList = {},\
  }\
end\
\
return mapEvent" }


package.sourceCode = package.sourceCode or {}
package.sourceCode["./meta-operation/maps-options/map9-1.lua"] = { path = "./meta-operation/maps-options/map9-1.lua", name = "./meta-operation/maps-options/map9-1.lua", source = "local mapBase = require './map'\
local imgEvent = require './img9-1'\
local mapEvent = {}\
\
-- 从mapBase继承方法\
mapEvent = table.assign(mapEvent, mapBase)\
for key, value in pairs(mapBase) do\
  if type(value) == 'function' then\
    mapEvent[key] = function(...)\
      return value(imgEvent, ...)\
    end\
  end\
end\
\
-- 获取地图采样位置。由于地图可能超出一屏，所以这里可以定义多个采样位置。每次扫描都会对每个采样位置进行扫描\
-- 标志位为地图四个角。每个采样位置只需定义一个角的坐标即可。\
-- 还需要定义每个采样位置的地图矩阵与屏幕坐标的映射关系\
mapEvent.getCheckpositionList = function()\
  local list = {\
    {\
      leftTop = nil,\
      rightTop = { 1670, 530 },\
      leftBotton = nil,\
      rightBotton = nil,\
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的\
      positionMap = {\
        { { 303, 530, 0x192431 }, { 472, 530, 0x6b7584 }, { 643, 530, 0x9caabd }, { 811, 530, 0x5a558c }, { 985, 530, 0x081421 }, { 1156, 530, 0x101829 }, { 1325, 530, 0x081419 }, { 1497, 530, 0x101c31 }, { 1670, 530, 0x212042 }, },\
        { { 274, 655, 0x000000 }, { 451, 655, 0x211c3a }, { 629, 655, 0x211c3a }, { 805, 655, 0x31354a }, { 989, 655, 0x313d63 }, { 1165, 655, 0x292442 }, { 1343, 655, 0x29244a }, { 1521, 655, 0x31315a }, { 1702, 655, 0x000000 }, },\
        { { 241, 793, 0x000000 }, { 426, 793, 0x191831 }, { 613, 793, 0x211c3a }, { 801, 793, 0x211c3a }, { 988, 793, 0x191831 }, { 1175, 793, 0x211c3a }, { 1362, 793, 0x191831 }, { 1546, 793, 0x3a2d63 }, { 1737, 793, 0x000000 }, },\
        { { 205, 944, 0x000000 }, { 400, 944, 0x211c42 }, { 598, 944, 0x8c8a8c }, { 793, 944, 0x191831 }, { 989, 944, 0x191831 }, { 1186, 944, 0x21203a }, { 1382, 944, 0x191421 }, { 1577, 943, 0x191421 }, { 1778, 944, 0x101010 }, },\
      },\
      pointMap = {},\
    },\
    {\
      leftTop = nil,\
      rightTop = nil,\
      leftBotton = { 502, 893 },\
      rightBotton = nil,\
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的\
      positionMap = {\
        false, false, false,\
        { { 548, 578, 0x000000 }, { 743, 578, 0x3a3942 }, { 939, 578, 0x191819 }, { 1135, 578, 0x191831 }, { 1331, 578, 0x191831 }, },\
        { { 526, 726, 0x000000 }, { 731, 726, 0x211831 }, { 938, 726, 0x31244a }, { 1144, 726, 0x292042 }, { 1351, 726, 0x191829 }, },\
        { { 502, 893, 0x000000 }, { 718, 893, 0x000000 }, { 937, 893, 0x000000 }, { 1155, 893, 0x000000 }, { 1373, 893, 0x000000 }, },\
      },\
      pointMap = {},\
    },\
    {\
      leftTop = nil,\
      rightTop = nil,\
      leftBotton = nil,\
      rightBotton = { 1705, 893 },\
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的\
      positionMap = {\
        false, false, false,\
        { false, false, false, false, { 843, 578, 0x191831 }, { 1040, 578, 0x21203a }, { 1236, 578, 0x211c3a }, { 1432, 578, 0x292042 }, { 1631, 578, 0x000000 }, },\
        { false, false, false, false, { 838, 726, 0x211c42 }, { 1044, 726, 0x211c3a }, { 1251, 726, 0x211831 }, { 1457, 726, 0x211831 }, { 1666, 726, 0x000000 }, },\
        { false, false, false, false, { 831, 893, 0x000000 }, { 1049, 893, 0x000000 }, { 1267, 893, 0x000000 }, { 1485, 893, 0x000000 }, { 1705, 893, 0x000000 }, },\
      },\
      pointMap = {},\
    },\
  }\
  for key = 1, #list do\
    local positionMap = list[key].positionMap\
    for rowNum, rol in ipairs(positionMap) do\
      if rol and positionMap[rowNum + 1] then\
        for colNum, col in ipairs(rol) do\
          if col and rol[colNum + 1] then\
            list[key].pointMap[rowNum .. '-' .. colNum] = col\
          end\
        end\
      end\
    end\
  end\
  return list\
end\
\
-- 获取地图棋盘和相关数据\
mapEvent.getMapChessboard = function()\
  return {\
    width = 8,\
    height = 5,\
    obstacle = {\
      { 1, 3 }, { 1, 4 }, { 1, 5 },\
      { 2, 1 }, { 2, 3 }, { 2, 4 }, { 2, 5 }, { 2, 7 }, { 2, 8 },\
      { 3, 7 }, { 3, 8 },\
      { 4, 3 }, { 4, 6 },\
      { 5, 3 },\
    },\
    waitForBossPosition = { { 1, 8 } },\
    bossPosition = {},\
    myFleetList = {},\
    enemyPositionList1 = {},\
    enemyPositionList2 = {},\
    enemyPositionList3 = {},\
    inBattleList = {},\
    selectedArrowList = {},\
    rewardBoxList = {},\
  }\
end\
\
return mapEvent" }


package.sourceCode = package.sourceCode or {}
package.sourceCode["./meta-operation/maps-options/map8-4.lua"] = { path = "./meta-operation/maps-options/map8-4.lua", name = "./meta-operation/maps-options/map8-4.lua", source = "local mapBase = require './map'\
local imgEvent = require './img8-4'\
local mapEvent = {}\
\
-- 从mapBase继承方法\
mapEvent = table.assign(mapEvent, mapBase)\
for key, value in pairs(mapBase) do\
  if type(value) == 'function' then\
    mapEvent[key] = function(...)\
      return value(imgEvent, ...)\
    end\
  end\
end\
\
-- 获取地图采样位置。由于地图可能超出一屏，所以这里可以定义多个采样位置。每次扫描都会对每个采样位置进行扫描\
-- 标志位为地图四个角。每个采样位置只需定义一个角的坐标即可。\
-- 还需要定义每个采样位置的地图矩阵与屏幕坐标的映射关系\
mapEvent.getCheckpositionList = function()\
  local list = {\
    {\
      leftTop = nil,\
      rightTop = { 1693, 509 },\
      leftBotton = nil,\
      rightBotton = nil,\
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的\
      positionMap = {\
        { { 385, 509, 0xa4d2ff }, { 551, 509, 0x192031 }, { 714, 509, 0x101c29 }, { 877, 509, 0x212042 }, { 1040, 509, 0x191c31 }, { 1202, 509, 0x192031 }, { 1365, 509, 0x212442 }, { 1528, 509, 0x212031 }, { 1693, 509, 0x212442 }, },\
        { { 367, 627, 0x000000 }, { 535, 627, 0x21719c }, { 703, 627, 0xffffff }, { 873, 627, 0x218194 }, { 1043, 627, 0x21798c }, { 1212, 627, 0x197984 }, { 1381, 627, 0x218194 }, { 1550, 627, 0x19798c }, { 1721, 627, 0x000000 }, },\
        { { 343, 755, 0x000000 }, { 518, 755, 0x19798c }, { 694, 755, 0x19758c }, { 870, 755, 0x292829 }, { 1046, 755, 0x10718c }, { 1222, 755, 0x19698c }, { 1398, 755, 0x19718c }, { 1574, 755, 0x19798c }, { 1752, 755, 0x000000 }, },\
        { { 317, 893, 0x000000 }, { 499, 893, 0x197994 }, { 682, 893, 0x107984 }, { 866, 893, 0x197984 }, { 1047, 893, 0x9cd2f7 }, { 1233, 893, 0x215d84 }, { 1417, 893, 0x217194 }, { 1600, 893, 0x196d8c }, { 1786, 893, 0x000000 }, },\
      },\
      pointMap = {},\
    },\
    {\
      leftTop = nil,\
      rightTop = { 1666, 264 },\
      leftBotton = nil,\
      rightBotton = nil,\
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的\
      positionMap = {\
        false, false, false,\
        { { 286, 617, 0x000000 }, { 469, 617, 0x217994 }, { 652, 617, 0x10798c }, { 835, 617, 0x218194 }, { 1019, 617, 0x73b6ef }, { 1202, 617, 0x11557b }, { 1386, 617, 0x196d84 }, { 1569, 617, 0x21718c }, { 1755, 617, 0x000000 }, },\
        { { 257, 756, 0x000000 }, { 447, 756, 0x297194 }, { 639, 756, 0x29718c }, { 830, 756, 0x216984 }, { 1021, 756, 0x104d73 }, { 1213, 756, 0x29598c }, { 1405, 756, 0x215d8c }, { 1596, 756, 0x317d9c }, { 1790, 756, 0x3a4d5a }, },\
        { { 224, 908, 0x000000 }, { 423, 908, 0x21618c }, { 623, 908, 0x3a7194 }, { 824, 908, 0x195d8c }, { 1024, 908, 0x21518c }, { 1225, 908, 0x104573 }, { 1425, 908, 0x294d7b }, { 1626, 908, 0x315184 }, { 1829, 908, 0x000000 }, },\
      },\
      pointMap = {},\
    },\
    {\
      leftTop = nil,\
      rightTop = nil,\
      leftBotton = { 528, 906 },\
      rightBotton = nil,\
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的\
      positionMap = {\
        false, false, false, false, false,\
        { { 568, 587, 0x000000 }, { 767, 587, 0x316194 }, { 968, 587, 0xb5dbef }, { 1168, 587, 0x08517b }, { 1369, 587, 0x104d7b }, },\
        { { 549, 738, 0x000000 }, { 758, 738, 0x216994 }, { 968, 738, 0x215584 }, { 1178, 738, 0x21558c }, { 1388, 738, 0x194984 }, },\
        { { 528, 906, 0x000000 }, { 747, 906, 0x000000 }, { 968, 906, 0x000000 }, { 1189, 906, 0x000000 }, { 1411, 906, 0x000000 }, },\
      },\
      pointMap = {},\
    },\
    {\
      leftTop = nil,\
      rightTop = nil,\
      leftBotton = nil,\
      rightBotton = { 1737, 905 },\
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的\
      positionMap = {\
        false, false, false, false, false,\
        { false, false, false, false, { 860, 586, 0x215184 }, { 1060, 586, 0x214984 }, { 1261, 586, 0x214d7b }, { 1461, 586, 0x294973 }, { 1664, 586, 0x000000 }, },\
        { false, false, false, false, { 855, 736, 0x084973 }, { 1065, 736, 0x113d73 }, { 1275, 736, 0x104573 }, { 1485, 736, 0x21497b }, { 1698, 736, 0x000000 }, },\
        { false, false, false, false, { 850, 905, 0x000000 }, { 1071, 905, 0x000000 }, { 1292, 905, 0x000000 }, { 1513, 905, 0x000000 }, { 1737, 905, 0x000000 }, },\
      },\
      pointMap = {},\
    },\
  }\
  for key = 1, #list do\
    local positionMap = list[key].positionMap\
    for rowNum, rol in ipairs(positionMap) do\
      if rol and positionMap[rowNum + 1] then\
        for colNum, col in ipairs(rol) do\
          if col and rol[colNum + 1] then\
            list[key].pointMap[rowNum .. '-' .. colNum] = col\
          end\
        end\
      end\
    end\
  end\
  return list\
end\
\
-- 获取地图棋盘和相关数据\
mapEvent.getMapChessboard = function()\
  return {\
    width = 8,\
    height = 7,\
    obstacle = {\
      { 1, 1 },\
      { 2, 6 }, { 2, 7 },\
      { 3, 4 }, { 3, 5 },\
      { 4, 1 }, { 4, 2 }, { 4, 4 }, { 4, 5 },\
      { 5, 2 }, { 5, 8 },\
      { 6, 5 }, { 6, 6 },\
    },\
    waitForBossPosition = { { 7, 8 } },\
    bossPosition = {},\
    myFleetList = {},\
    enemyPositionList1 = {},\
    enemyPositionList2 = {},\
    enemyPositionList3 = {},\
    inBattleList = {},\
    selectedArrowList = {},\
    rewardBoxList = {},\
  }\
end\
\
return mapEvent" }


package.sourceCode = package.sourceCode or {}
package.sourceCode["./meta-operation/maps-options/map8-3.lua"] = { path = "./meta-operation/maps-options/map8-3.lua", name = "./meta-operation/maps-options/map8-3.lua", source = "local mapBase = require './map'\
local imgEvent = require './img8-3'\
local mapEvent = {}\
\
-- 从mapBase继承方法\
mapEvent = table.assign(mapEvent, mapBase)\
for key, value in pairs(mapBase) do\
  if type(value) == 'function' then\
    mapEvent[key] = function(...)\
      return value(imgEvent, ...)\
    end\
  end\
end\
\
-- 获取地图采样位置。由于地图可能超出一屏，所以这里可以定义多个采样位置。每次扫描都会对每个采样位置进行扫描\
-- 标志位为地图四个角。每个采样位置只需定义一个角的坐标即可。\
-- 还需要定义每个采样位置的地图矩阵与屏幕坐标的映射关系\
mapEvent.getCheckpositionList = function()\
  local list = {\
    {\
      leftTop = { 347, 520 },\
      rightTop = nil,\
      leftBotton = nil,\
      rightBotton = nil,\
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的\
      positionMap = {\
        { { 347, 520, 0x3a3d3a }, { 508, 520, 0x293542 }, { 671, 520, 0x212d31 }, { 834, 520, 0x313942 }, { 997, 520, 0x292d42 }, { 1160, 520, 0x313942 }, { 1323, 520, 0x293131 }, { 1486, 520, 0x293542 }, { 1651, 520, 0x29313a }, },\
        { { 323, 638, 0x000000 }, { 491, 638, 0x196d94 }, { 660, 638, 0x217594 }, { 829, 638, 0x217d8c }, { 998, 638, 0x422021 }, { 1168, 638, 0x21798c }, { 1337, 638, 0x217d8c }, { 1506, 638, 0x29819c }, { 1677, 638, 0x000000 }, },\
        { { 297, 767, 0x000000 }, { 472, 767, 0x217984 }, { 648, 767, 0x197984 }, { 824, 767, 0x107984 }, { 1000, 767, 0x116d84 }, { 1176, 767, 0xf7d784 }, { 1352, 767, 0x196984 }, { 1528, 767, 0x197584 }, { 1707, 767, 0x000000 }, },\
        { { 269, 906, 0x000000 }, { 451, 906, 0x197d8c }, { 635, 906, 0x297d8c }, { 818, 906, 0x21758c }, { 1002, 906, 0x21598c }, { 1185, 906, 0x192831 }, { 1369, 906, 0x196184 }, { 1552, 906, 0x21698c }, { 1738, 906, 0x000000 }, },\
      },\
      pointMap = {},\
    },\
    {\
      leftTop = nil,\
      rightTop = nil,\
      leftBotton = { 426, 904 },\
      rightBotton = nil,\
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的\
      positionMap = {\
        false, false, false,\
        { { 494, 467, 0x000000 }, { 675, 467, 0x529ac5 }, { 859, 467, 0x297d8c }, { 1043, 467, 0x217184 }, { 1226, 467, 0x08517b }, { 1409, 467, 0xa4b2b5 }, },\
        { { 473, 599, 0x000000 }, { 663, 599, 0x316594 }, { 855, 599, 0x296994 }, { 1046, 599, 0x08557b }, { 1238, 599, 0x084973 }, { 1430, 599, 0x08416b }, },\
        { { 451, 743, 0x000000 }, { 649, 743, 0x19658c }, { 850, 743, 0x105584 }, { 1050, 743, 0x10557b }, { 1251, 743, 0x215d84 }, { 1451, 743, 0x21417b }, },\
        { { 426, 904, 0x000000 }, { 635, 904, 0x000000 }, { 844, 904, 0x000000 }, { 1055, 904, 0x000000 }, { 1265, 904, 0x000000 }, { 1475, 904, 0x000000 }, },\
      },\
      pointMap = {},\
    },\
    {\
      leftTop = nil,\
      rightTop = nil,\
      leftBotton = nil,\
      rightBotton = { 1707, 905 },\
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的\
      positionMap = {\
        false, false, false,\
        { false, false, false, false, false, { 1059, 468, 0x194d73 }, { 1243, 468, 0x196184 }, { 1426, 468, 0x21698c }, { 1612, 468, 0x000000 }, },\
        { false, false, false, false, false, { 1064, 600, 0x214984 }, { 1256, 600, 0x4275a4 }, { 1447, 600, 0x294d84 }, { 1641, 600, 0x000000 }, },\
        { false, false, false, false, false, { 1068, 744, 0x21417b }, { 1269, 744, 0x104573 }, { 1469, 744, 0x21497b }, { 1673, 744, 0x000000 }, },\
        { false, false, false, false, false, { 1074, 905, 0x000001 }, { 1284, 905, 0x000001 }, { 1494, 905, 0x000000 }, { 1707, 905, 0x000000 }, },\
      },\
      pointMap = {},\
    },\
  }\
  for key = 1, #list do\
    local positionMap = list[key].positionMap\
    for rowNum, rol in ipairs(positionMap) do\
      if rol and positionMap[rowNum + 1] then\
        for colNum, col in ipairs(rol) do\
          if col and rol[colNum + 1] then\
            list[key].pointMap[rowNum .. '-' .. colNum] = col\
          end\
        end\
      end\
    end\
  end\
  return list\
end\
\
-- 获取地图棋盘和相关数据\
mapEvent.getMapChessboard = function()\
  return {\
    width = 8,\
    height = 6,\
    obstacle = {\
      { 2, 4 }, { 2, 5 },\
      { 3, 2 }, { 3, 3 },\
      { 4, 3 }, { 4, 6 },\
      { 5, 5 }, { 5, 6 },\
    },\
    waitForBossPosition = { { 1, 1 }, { 1, 8 }, { 6, 1 }, { 6, 8 } },\
    bossPosition = {},\
    myFleetList = {},\
    enemyPositionList1 = {},\
    enemyPositionList2 = {},\
    enemyPositionList3 = {},\
    inBattleList = {},\
    selectedArrowList = {},\
    rewardBoxList = {},\
  }\
end\
\
return mapEvent" }


package.sourceCode = package.sourceCode or {}
package.sourceCode["./meta-operation/maps-options/map8-2.lua"] = { path = "./meta-operation/maps-options/map8-2.lua", name = "./meta-operation/maps-options/map8-2.lua", source = "local mapBase = require './map'\
local imgEvent = require './img8-2'\
local mapEvent = {}\
\
-- 从mapBase继承方法\
mapEvent = table.assign(mapEvent, mapBase)\
for key, value in pairs(mapBase) do\
  if type(value) == 'function' then\
    mapEvent[key] = function(...)\
      return value(imgEvent, ...)\
    end\
  end\
end\
\
-- 获取地图采样位置。由于地图可能超出一屏，所以这里可以定义多个采样位置。每次扫描都会对每个采样位置进行扫描\
-- 标志位为地图四个角。每个采样位置只需定义一个角的坐标即可。\
-- 还需要定义每个采样位置的地图矩阵与屏幕坐标的映射关系\
mapEvent.getCheckpositionList = function()\
  local list = {\
    {\
      leftTop = { 350, 507 },\
      rightTop = nil,\
      leftBotton = nil,\
      rightBotton = nil,\
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的\
      positionMap = {\
        { { 350, 507, 0x191c31 }, { 518, 507, 0x191c31 }, { 687, 507, 0x21243a }, { 857, 507, 0x21243a }, { 1026, 507, 0x192031 }, { 1195, 507, 0x21243a }, { 1365, 507, 0x21243a }, { 1534, 507, 0x192431 }, { 1705, 507, 0x21243a }, },\
        { { 326, 630, 0x000000 }, { 501, 630, 0x116d8c }, { 677, 630, 0x217d8c }, { 853, 630, 0x197d8c }, { 1029, 630, 0x21798c }, { 1205, 630, 0x19758c }, { 1381, 630, 0x217d8c }, { 1557, 630, 0x217d8c }, { 1735, 630, 0x000000 }, },\
        { { 299, 763, 0x000000 }, { 481, 763, 0x197d8c }, { 665, 763, 0x19818c }, { 848, 763, 0x107984 }, { 1031, 763, 0x21557b }, { 1215, 763, 0x215d84 }, { 1399, 763, 0x216184 }, { 1582, 763, 0x196d8c }, { 1768, 763, 0x000000 }, },\
        { { 270, 909, 0x000000 }, { 460, 909, 0x21718c }, { 652, 909, 0x216d8c }, { 843, 909, 0x105d84 }, { 1035, 909, 0x10517b }, { 1227, 909, 0x214d83 }, { 1418, 909, 0x4a3d21 }, { 1609, 909, 0xffdb9c }, { 1804, 909, 0x000000 }, },\
      },\
      pointMap = {},\
    },\
    {\
      leftTop = nil,\
      rightTop = nil,\
      leftBotton = { 512, 902 },\
      rightBotton = nil,\
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的\
      positionMap = {\
        false, false, false,\
        { { 552, 597, 0x000000 }, { 742, 597, 0x217184 }, { 933, 597, 0x297194 }, { 1125, 597, 0x195d84 }, { 1317, 597, 0x19517b }, { 1508, 597, 0x19497b }, },\
        { { 533, 741, 0x000000 }, { 732, 741, 0x10618c }, { 931, 741, 0x63aee6 }, { 1133, 741, 0x215d83 }, { 1334, 741, 0x003d63 }, { 1534, 741, 0x10416b }, },\
        { { 512, 902, 0x000000 }, { 721, 902, 0x000000 }, { 932, 902, 0x000000 }, { 1142, 902, 0x000001 }, { 1352, 902, 0x000001 }, { 1562, 902, 0x000001 }, },\
      },\
      pointMap = {},\
    },\
    {\
      leftTop = nil,\
      rightTop = nil,\
      leftBotton = nil,\
      rightBotton = { 1471, 905 },\
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的\
      positionMap = {\
        false, false, false,\
        { false, false, false, false, false, { 1043, 600, 0x21497b }, { 1235, 600, 0x7b4521 }, { 1424, 600, 0x735942 }, { 1620, 600, 0x000000 }, },\
        { false, false, false, false, false, { 1047, 745, 0x10417b }, { 1247, 745, 0x214d7b }, { 1445, 745, 0xefefff }, { 1651, 745, 0x000000 }, },\
        { false, false, false, false, false, { 1051, 905, 0x000001 }, { 1261, 905, 0x000000 }, { 1471, 905, 0x000000 }, { 1686, 905, 0x000000 }, },\
      },\
      pointMap = {},\
    },\
  }\
  for key = 1, #list do\
    local positionMap = list[key].positionMap\
    for rowNum, rol in ipairs(positionMap) do\
      if rol and positionMap[rowNum + 1] then\
        for colNum, col in ipairs(rol) do\
          if col and rol[colNum + 1] then\
            list[key].pointMap[rowNum .. '-' .. colNum] = col\
          end\
        end\
      end\
    end\
  end\
  return list\
end\
\
-- 获取地图棋盘和相关数据\
mapEvent.getMapChessboard = function()\
  return {\
    width = 8,\
    height = 5,\
    obstacle = {\
      { 1, 4 }, { 1, 5 },\
      { 2, 5 },\
      { 4, 2 }, { 4, 3 }, { 4, 6 }, { 4, 7 },\
      { 5, 2 }, { 5, 3 },\
    },\
    waitForBossPosition = { { 1, 1 }, { 1, 8 } },\
    bossPosition = {},\
    myFleetList = {},\
    enemyPositionList1 = {},\
    enemyPositionList2 = {},\
    enemyPositionList3 = {},\
    inBattleList = {},\
    selectedArrowList = {},\
    rewardBoxList = {},\
  }\
end\
\
return mapEvent" }


package.sourceCode = package.sourceCode or {}
package.sourceCode["./meta-operation/maps-options/map8-1.lua"] = { path = "./meta-operation/maps-options/map8-1.lua", name = "./meta-operation/maps-options/map8-1.lua", source = "local mapBase = require './map'\
local imgEvent = require './img8-1'\
local mapEvent = {}\
\
-- 从mapBase继承方法\
mapEvent = table.assign(mapEvent, mapBase)\
for key, value in pairs(mapBase) do\
  if type(value) == 'function' then\
    mapEvent[key] = function(...)\
      return value(imgEvent, ...)\
    end\
  end\
end\
\
-- 获取地图采样位置。由于地图可能超出一屏，所以这里可以定义多个采样位置。每次扫描都会对每个采样位置进行扫描\
-- 标志位为地图四个角。每个采样位置只需定义一个角的坐标即可。\
-- 还需要定义每个采样位置的地图矩阵与屏幕坐标的映射关系\
mapEvent.getCheckpositionList = function()\
  local list = {\
    {\
      leftTop = nil,\
      rightTop = nil,\
      leftBotton = { 479, 881 },\
      rightBotton = nil,\
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的\
      positionMap = {\
        { { 538, 465, 0x101c29 }, { 712, 465, 0x080c08 }, { 889, 465, 0x192031 }, { 1065, 465, 0x192031 }, { 1241, 465, 0x21203a }, { 1417, 465, 0x21203a }, { 1594, 465, 0x191c31 }, },\
        { { 520, 591, 0x000000 }, { 702, 591, 0x21798c }, { 886, 591, 0x11798c }, { 1067, 591, 0x73b6ef }, { 1253, 591, 0x107d94 }, { 1436, 591, 0x105d7b }, { 1620, 591, 0x197984 }, },\
        { { 501, 729, 0x000000 }, { 691, 729, 0x316994 }, { 882, 729, 0x216184 }, { 1074, 729, 0x196984 }, { 1266, 729, 0x084d73 }, { 1457, 729, 0x195584 }, { 1649, 729, 0x639ac5 }, },\
        { { 479, 881, 0x000000 }, { 679, 881, 0x000000 }, { 879, 881, 0x000000 }, { 1079, 881, 0x000000 }, { 1280, 881, 0x000000 }, { 1480, 881, 0x000001 }, { 1681, 881, 0x000000 }, },\
      },\
      pointMap = {},\
    },\
    {\
      leftTop = nil,\
      rightTop = nil,\
      leftBotton = nil,\
      rightBotton = { 1745, 896 },\
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的\
      positionMap = {\
        { false, false, false, false, false, false, { 1120, 478, 0x212031 }, { 1296, 478, 0x21203a }, { 1472, 478, 0x21203a }, { 1650, 478, 0x212042 }, },\
        { false, false, false, false, false, false, { 1126, 605, 0x197984 }, { 1310, 605, 0x196984 }, { 1493, 605, 0x217d94 }, { 1679, 605, 0x000000 }, },\
        { false, false, false, false, false, false, { 1133, 743, 0x194d7b }, { 1325, 743, 0x294d7b }, { 1517, 743, 0x315184 }, { 1711, 743, 0x000000 }, },\
        { false, false, false, false, false, false, { 1141, 896, 0x000409 }, { 1342, 896, 0x000000 }, { 1542, 896, 0x000000 }, { 1745, 896, 0x000000 }, },\
      },\
      pointMap = {},\
    },\
  }\
  for key = 1, #list do\
    local positionMap = list[key].positionMap\
    for rowNum, rol in ipairs(positionMap) do\
      if rol and positionMap[rowNum + 1] then\
        for colNum, col in ipairs(rol) do\
          if col and rol[colNum + 1] then\
            list[key].pointMap[rowNum .. '-' .. colNum] = col\
          end\
        end\
      end\
    end\
  end\
  return list\
end\
\
-- 获取地图棋盘和相关数据\
mapEvent.getMapChessboard = function()\
  return {\
    width = 9,\
    height = 3,\
    obstacle = {\
      { 1, 3 }, { 1, 4 }, { 1, 9 },\
      { 2, 3 }, { 2, 4 },\
      { 3, 6 },\
    },\
    waitForBossPosition = { { 1, 8 } },\
    bossPosition = {},\
    myFleetList = {},\
    enemyPositionList1 = {},\
    enemyPositionList2 = {},\
    enemyPositionList3 = {},\
    inBattleList = {},\
    selectedArrowList = {},\
    rewardBoxList = {},\
  }\
end\
\
return mapEvent" }


package.sourceCode = package.sourceCode or {}
package.sourceCode["./meta-operation/maps-options/map7-4.lua"] = { path = "./meta-operation/maps-options/map7-4.lua", name = "./meta-operation/maps-options/map7-4.lua", source = "local mapBase = require './map'\
local imgEvent = require './img7-4'\
local mapEvent = {}\
\
-- 从mapBase继承方法\
mapEvent = table.assign(mapEvent, mapBase)\
for key, value in pairs(mapBase) do\
  if type(value) == 'function' then\
    mapEvent[key] = function(...)\
      return value(imgEvent, ...)\
    end\
  end\
end\
\
-- 获取地图采样位置。由于地图可能超出一屏，所以这里可以定义多个采样位置。每次扫描都会对每个采样位置进行扫描\
-- 标志位为地图四个角。每个采样位置只需定义一个角的坐标即可。\
-- 还需要定义每个采样位置的地图矩阵与屏幕坐标的映射关系\
mapEvent.getCheckpositionList = function()\
  local list = {\
    {\
      leftTop = nil,\
      rightTop = { 1695, 497 },\
      leftBotton = nil,\
      rightBotton = nil,\
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的\
      positionMap = {\
        { { 341, 497, 0x101821 }, { 508, 497, 0x081019 }, { 677, 497, 0x212031 }, { 846, 497, 0x081419 }, { 1016, 497, 0x111421 }, { 1185, 497, 0x211c29 }, { 1354, 497, 0x111c21 }, { 1523, 497, 0x192532 }, { 1695, 497, 0x192029 }, },\
        { { 314, 620, 0x523d10 }, { 490, 620, 0x211c3a }, { 666, 620, 0x212042 }, { 842, 620, 0x212442 }, { 1018, 620, 0x292042 }, { 1194, 620, 0x31284a }, { 1370, 620, 0x29284a }, { 1546, 620, 0x3a3563 }, { 1724, 620, 0x000000 }, },\
        { { 288, 753, 0x000000 }, { 470, 753, 0x191829 }, { 654, 753, 0x4a3d19 }, { 837, 753, 0x211c42 }, { 1021, 753, 0x292042 }, { 1204, 753, 0x211c31 }, { 1387, 753, 0x212042 }, { 1571, 753, 0x31244a }, { 1757, 753, 0x000000 }, },\
        { { 258, 898, 0x000000 }, { 448, 898, 0x211c42 }, { 640, 898, 0x212042 }, { 831, 898, 0x211831 }, { 1023, 898, 0x211831 }, { 1215, 898, 0x211831 }, { 1407, 898, 0x291c3a }, { 1598, 898, 0x292042 }, { 1792, 898, 0x000000 }, },\
      },\
      pointMap = {},\
    },\
    {\
      leftTop = nil,\
      rightTop = { 1693, 373 },\
      leftBotton = nil,\
      rightBotton = nil,\
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的\
      positionMap = {\
        false, false, false,\
        { { 256, 756, 0x000000 }, { 446, 756, 0x211c42 }, { 638, 756, 0x212042 }, { 831, 756, 0x3a356b }, { 1021, 756, 0x211831 }, { 1213, 756, 0x211831 }, { 1404, 756, 0x292042 }, { 1596, 756, 0x292442 }, { 1790, 756, 0x000000 }, },\
        { { 224, 908, 0x000000 }, { 423, 908, 0x191831 }, { 624, 908, 0x211c42 }, { 818, 908, 0x292831 }, { 1024, 908, 0x42517b }, { 1225, 908, 0x191831 }, { 1425, 908, 0x211831 }, { 1626, 908, 0x292042 }, { 1829, 908, 0x000000 }, },\
      },\
      pointMap = {},\
    },\
    {\
      leftTop = nil,\
      rightTop = nil,\
      leftBotton = { 503, 895 },\
      rightBotton = nil,\
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的\
      positionMap = {\
        false, false, false, false,\
        { { 545, 577, 0x000000 }, { 743, 577, 0x19183a }, { 944, 577, 0x191431 }, { 1142, 577, 0x191c21 }, { 1345, 577, 0x6b819c }, },\
        { { 525, 727, 0x000000 }, { 734, 727, 0x191431 }, { 944, 727, 0x191429 }, { 1154, 727, 0x191429 }, { 1364, 727, 0x191429 }, },\
        { { 503, 895, 0x000000 }, { 722, 895, 0x000000 }, { 943, 895, 0x000000 }, { 1164, 895, 0x000000 }, { 1385, 895, 0x000000 }, },\
      },\
      pointMap = {},\
    },\
    {\
      leftTop = nil,\
      rightTop = nil,\
      leftBotton = nil,\
      rightBotton = { 1681, 898 },\
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的\
      positionMap = {\
        false, false, false, false,\
        { false, false, false, false, { 808, 580, 0x52598c }, { 1010, 580, 0x211c3a }, { 1211, 580, 0x211831 }, { 1411, 580, 0x21203a }, { 1614, 580, 0x000000 }, },\
        { false, false, false, false, { 803, 730, 0x191831 }, { 1013, 730, 0x191829 }, { 1223, 730, 0x191831 }, { 1433, 730, 0x211831 }, { 1646, 730, 0x000000 }, },\
        { false, false, false, false, { 794, 898, 0x000000 }, { 1016, 898, 0x000000 }, { 1236, 898, 0x000000 }, { 1457, 898, 0x000000 }, { 1681, 898, 0x000000 }, },\
      },\
      pointMap = {},\
    },\
  }\
  for key = 1, #list do\
    local positionMap = list[key].positionMap\
    for rowNum, rol in ipairs(positionMap) do\
      if rol and positionMap[rowNum + 1] then\
        for colNum, col in ipairs(rol) do\
          if col and rol[colNum + 1] then\
            list[key].pointMap[rowNum .. '-' .. colNum] = col\
          end\
        end\
      end\
    end\
  end\
  return list\
end\
\
-- 获取地图棋盘和相关数据\
mapEvent.getMapChessboard = function()\
  return {\
    width = 8,\
    height = 6,\
    obstacle = {\
      { 1, 5 }, { 1, 6 }, { 1, 7 },\
      { 3, 2 },\
      { 4, 2 }, { 4, 3 }, { 4, 4 },\
      { 5, 4 }, { 5, 6 },\
    },\
    waitForBossPosition = { { 1, 1 }, { 1, 8 }, { 6, 7 } },\
    bossPosition = {},\
    myFleetList = {},\
    enemyPositionList1 = {},\
    enemyPositionList2 = {},\
    enemyPositionList3 = {},\
    inBattleList = {},\
    selectedArrowList = {},\
    rewardBoxList = {},\
  }\
end\
\
return mapEvent" }


package.sourceCode = package.sourceCode or {}
package.sourceCode["./meta-operation/maps-options/map7-3.lua"] = { path = "./meta-operation/maps-options/map7-3.lua", name = "./meta-operation/maps-options/map7-3.lua", source = "local mapBase = require './map'\
local imgEvent = require './img7-3'\
local mapEvent = {}\
\
-- 从mapBase继承方法\
mapEvent = table.assign(mapEvent, mapBase)\
for key, value in pairs(mapBase) do\
  if type(value) == 'function' then\
    mapEvent[key] = function(...)\
      return value(imgEvent, ...)\
    end\
  end\
end\
\
-- 获取地图采样位置。由于地图可能超出一屏，所以这里可以定义多个采样位置。每次扫描都会对每个采样位置进行扫描\
-- 标志位为地图四个角。每个采样位置只需定义一个角的坐标即可。\
-- 还需要定义每个采样位置的地图矩阵与屏幕坐标的映射关系\
mapEvent.getCheckpositionList = function()\
  local list = {\
    {\
      leftTop = nil,\
      rightTop = { 1705, 501 },\
      leftBotton = nil,\
      rightBotton = nil,\
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的\
      positionMap = {\
        { { 350, 501, 0x101c21 }, { 520, 501, 0xdeba10 }, { 688, 501, 0x192429 }, { 857, 501, 0x212431 }, { 1026, 501, 0x29353a }, { 1196, 501, 0x212831 }, { 1365, 501, 0x213142 }, { 1534, 501, 0x192431 }, { 1705, 501, 0x212842 }, },\
        { { 326, 623, 0x000000 }, { 501, 623, 0x191c3a }, { 677, 623, 0x211c3a }, { 853, 623, 0x21203a }, { 1030, 623, 0x312021 }, { 1205, 623, 0x292442 }, { 1381, 623, 0x29244a }, { 1557, 623, 0x31355a }, { 1735, 623, 0x000000 }, },\
        { { 299, 756, 0x000000 }, { 481, 756, 0x191831 }, { 665, 756, 0x21203a }, { 849, 756, 0x211c3a }, { 1032, 756, 0x292442 }, { 1215, 756, 0xffdf94 }, { 1399, 756, 0x211c3a }, { 1582, 756, 0x31244a }, { 1768, 756, 0x000000 }, },\
        { { 270, 901, 0x000000 }, { 460, 901, 0x191831 }, { 652, 901, 0x191831 }, { 843, 901, 0x211c3a }, { 1035, 901, 0x211c3a }, { 1226, 901, 0x191829 }, { 1418, 901, 0x191831 }, { 1610, 901, 0x191c31 }, { 1804, 901, 0x000000 }, },\
      },\
      pointMap = {},\
    },\
    {\
      leftTop = nil,\
      rightTop = { 1775, 373 },\
      leftBotton = nil,\
      rightBotton = nil,\
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的\
      positionMap = {\
        false, false, false,\
        { { 349, 757, 0x000000 }, { 539, 757, 0x211c3a }, { 731, 757, 0x191c3a }, { 923, 757, 0x211c3a }, { 1114, 757, 0x191829 }, { 1306, 757, 0x191829 }, { 1497, 757, 0x312852 }, },\
        { { 321, 908, 0x000000 }, { 520, 908, 0x211c3a }, { 720, 908, 0x29204a }, { 920, 908, 0x291c3a }, { 1121, 908, 0x211c31 }, { 1321, 908, 0x191831 }, { 1522, 908, 0x21203a }, },\
      },\
      pointMap = {},\
    },\
    {\
      leftTop = nil,\
      rightTop = nil,\
      leftBotton = { 516, 900 },\
      rightBotton = nil,\
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的\
      positionMap = {\
        false, false, false, false,\
        { { 557, 581, 0x000000 }, { 756, 581, 0x191431 }, { 956, 581, 0x191431 }, { 1157, 581, 0x211c42 }, { 1357, 581, 0x211c42 }, },\
        { { 537, 732, 0x000000 }, { 746, 732, 0x211c42 }, { 957, 732, 0x211831 }, { 1167, 732, 0x191831 }, { 1376, 732, 0x211c3a }, },\
        { { 516, 900, 0x000000 }, { 735, 900, 0x000000 }, { 956, 900, 0x000000 }, { 1177, 900, 0x000000 }, { 1397, 900, 0x000000 }, },\
      },\
      pointMap = {},\
    },\
    {\
      leftTop = nil,\
      rightTop = nil,\
      leftBotton = nil,\
      rightBotton = { 1772, 903 },\
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的\
      positionMap = {\
        false, false, false, false,\
        { false, false, false, false, { 892, 584, 0x212042 }, { 1093, 584, 0x191831 }, { 1293, 584, 0x211831 }, { 1494, 584, 0x292042 }, { 1697, 584, 0x000000 }, },\
        { false, false, false, false, { 889, 735, 0x191831 }, { 1099, 735, 0x211831 }, { 1310, 735, 0x191829 }, { 1519, 735, 0x211c42 }, { 1732, 735, 0x000000 }, },\
        { false, false, false, false, { 885, 903, 0x000000 }, { 1107, 903, 0x000000 }, { 1327, 903, 0x000000 }, { 1548, 903, 0x000000 }, { 1772, 903, 0x000000 }, },\
      },\
      pointMap = {},\
    },\
  }\
  for key = 1, #list do\
    local positionMap = list[key].positionMap\
    for rowNum, rol in ipairs(positionMap) do\
      if rol and positionMap[rowNum + 1] then\
        for colNum, col in ipairs(rol) do\
          if col and rol[colNum + 1] then\
            list[key].pointMap[rowNum .. '-' .. colNum] = col\
          end\
        end\
      end\
    end\
  end\
  return list\
end\
\
-- 获取地图棋盘和相关数据\
mapEvent.getMapChessboard = function()\
  return {\
    width = 8,\
    height = 6,\
    obstacle = {\
      { 2, 3 },\
      { 3, 6 }, { 3, 7 }, { 3, 8 },\
      { 4, 7 }, { 4, 8 },\
      { 5, 2 }, { 5, 3 }, { 5, 4 }, { 5, 7 },\
      { 6, 4 },\
    },\
    waitForBossPosition = { { 1, 1 }, { 1, 8 }, { 5, 8 }, { 6, 3 }, },\
    bossPosition = {},\
    myFleetList = {},\
    enemyPositionList1 = {},\
    enemyPositionList2 = {},\
    enemyPositionList3 = {},\
    inBattleList = {},\
    selectedArrowList = {},\
    rewardBoxList = {},\
  }\
end\
\
return mapEvent" }


package.sourceCode = package.sourceCode or {}
package.sourceCode["./meta-operation/maps-options/map7-2.lua"] = { path = "./meta-operation/maps-options/map7-2.lua", name = "./meta-operation/maps-options/map7-2.lua", source = "local mapBase = require './map'\
local imgEvent = require './img7-2'\
local mapEvent = {}\
\
-- 从mapBase继承方法\
mapEvent = table.assign(mapEvent, mapBase)\
for key, value in pairs(mapBase) do\
  if type(value) == 'function' then\
    mapEvent[key] = function(...)\
      return value(imgEvent, ...)\
    end\
  end\
end\
\
-- 获取地图采样位置。由于地图可能超出一屏，所以这里可以定义多个采样位置。每次扫描都会对每个采样位置进行扫描\
-- 标志位为地图四个角。每个采样位置只需定义一个角的坐标即可。\
-- 还需要定义每个采样位置的地图矩阵与屏幕坐标的映射关系\
mapEvent.getCheckpositionList = function()\
  local list = {\
    {\
      leftTop = nil,\
      rightTop = { 1721, 507 },\
      leftBotton = nil,\
      rightBotton = nil,\
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的\
      positionMap = {\
        { { 367, 507, 0x212029 }, { 535, 507, 0x212029 }, { 704, 507, 0x102021 }, { 873, 507, 0x192431 }, { 1043, 507, 0x213142 }, { 1212, 507, 0x111c21 }, { 1381, 507, 0x192031 }, { 1551, 507, 0x212431 }, { 1721, 507, 0x19243a }, },\
        { { 343, 630, 0x000000 }, { 518, 630, 0x211c3a }, { 694, 630, 0x31244a }, { 870, 630, 0x212042 }, { 1046, 630, 0x29244a }, { 1222, 630, 0x292442 }, { 1398, 630, 0x29284a }, { 1575, 630, 0x312d5a }, { 1753, 630, 0x000000 }, },\
        { { 317, 763, 0x000000 }, { 499, 763, 0x211c42 }, { 683, 763, 0x211c42 }, { 866, 763, 0x191831 }, { 1050, 763, 0x191831 }, { 1234, 763, 0x191831 }, { 1417, 763, 0x211c3a }, { 1600, 763, 0x211c31 }, { 1786, 763, 0x000000 }, },\
        { { 289, 908, 0x000000 }, { 478, 908, 0x424142 }, { 671, 908, 0x19183a }, { 862, 908, 0x211c3a }, { 1054, 908, 0x211c3a }, { 1246, 908, 0x21203a }, { 1436, 908, 0x211c3a }, { 1629, 908, 0x291c42 }, { 1822, 908, 0x000000 }, },\
      },\
      pointMap = {},\
    },\
    {\
      leftTop = nil,\
      rightTop = nil,\
      leftBotton = { 455, 888 },\
      rightBotton = nil,\
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的\
      positionMap = {\
        false, false, false,\
        { { 500, 584, 0x000000 }, { 690, 584, 0x211c42 }, { 881, 584, 0x21183a }, { 1073, 584, 0x191831 }, { 1265, 584, 0x191831 }, { 1457, 584, 0x211831 }, { 1648, 584, 0x211c3a }, },\
        { { 478, 728, 0x000000 }, { 677, 728, 0x211831 }, { 878, 728, 0x211c42 }, { 1078, 728, 0x211c3a }, { 1279, 728, 0x191829 }, { 1480, 728, 0x211c3a }, { 1680, 728, 0x211c3a }, },\
        { { 455, 888, 0x000000 }, { 664, 888, 0x000000 }, { 874, 888, 0x000000 }, { 1084, 888, 0x000000 }, { 1294, 888, 0x000000 }, { 1505, 888, 0x000000 }, { 1715, 888, 0x000000 }, },\
      },\
      pointMap = {},\
    },\
  }\
  for key = 1, #list do\
    local positionMap = list[key].positionMap\
    for rowNum, rol in ipairs(positionMap) do\
      if rol and positionMap[rowNum + 1] then\
        for colNum, col in ipairs(rol) do\
          if col and rol[colNum + 1] then\
            list[key].pointMap[rowNum .. '-' .. colNum] = col\
          end\
        end\
      end\
    end\
  end\
  return list\
end\
\
-- 获取地图棋盘和相关数据\
mapEvent.getMapChessboard = function()\
  return {\
    width = 8,\
    height = 5,\
    obstacle = {\
      { 1, 2 },\
      { 2, 2 }, { 2, 3 },\
      { 4, 7 }, { 4, 8 },\
      { 5, 7 }, { 5, 8 },\
    },\
    waitForBossPosition = { { 3, 4 } },\
    bossPosition = {},\
    myFleetList = {},\
    enemyPositionList1 = {},\
    enemyPositionList2 = {},\
    enemyPositionList3 = {},\
    inBattleList = {},\
    selectedArrowList = {},\
    rewardBoxList = {},\
  }\
end\
\
return mapEvent" }


package.sourceCode = package.sourceCode or {}
package.sourceCode["./meta-operation/maps-options/map7-1.lua"] = { path = "./meta-operation/maps-options/map7-1.lua", name = "./meta-operation/maps-options/map7-1.lua", source = "local mapBase = require './map'\
local imgEvent = require './img7-1'\
local mapEvent = {}\
\
-- 从mapBase继承方法\
mapEvent = table.assign(mapEvent, mapBase)\
for key, value in pairs(mapBase) do\
  if type(value) == 'function' then\
    mapEvent[key] = function(...)\
      return value(imgEvent, ...)\
    end\
  end\
end\
\
-- 获取地图采样位置。由于地图可能超出一屏，所以这里可以定义多个采样位置。每次扫描都会对每个采样位置进行扫描\
-- 标志位为地图四个角。每个采样位置只需定义一个角的坐标即可。\
-- 还需要定义每个采样位置的地图矩阵与屏幕坐标的映射关系\
mapEvent.getCheckpositionList = function()\
  local list = {\
    {\
      leftTop = nil,\
      rightTop = { 1679, 462 },\
      leftBotton = nil,\
      rightBotton = nil,\
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的\
      positionMap = {\
        { { 252, 462, 0x191421 }, { 431, 462, 0x292821 }, { 608, 462, 0x191821 }, { 786, 462, 0x191829 }, { 964, 462, 0x212431 }, { 1142, 462, 0x191c29 }, { 1322, 462, 0x191c32 }, { 1500, 462, 0x192129 }, { 1679, 462, 0x191d32 }, },\
        { { 218, 590, 0x000000 }, { 404, 590, 0x21203a }, { 590, 590, 0xbdb6bd }, { 778, 590, 0x212042 }, { 965, 590, 0x212042 }, { 1152, 590, 0x292042 }, { 1339, 590, 0x211c42 }, { 1525, 590, 0x42396b }, { 1714, 590, 0x000000 }, },\
        { { 181, 732, 0x21183a }, { 375, 732, 0x5a495a }, { 573, 732, 0x191831 }, { 768, 732, 0x3a5173 }, { 966, 732, 0x21203a }, { 1162, 732, 0x211c3a }, { 1358, 732, 0x21203a }, { 1554, 732, 0x292042 }, { 1752, 732, 0x000000 }, },\
        { { 141, 889, 0x000000 }, { 345, 889, 0x000000 }, { 553, 889, 0x000000 }, { 758, 889, 0x000000 }, { 966, 889, 0x000000 }, { 1171, 889, 0x000000 }, { 1379, 889, 0x000000 }, { 1585, 889, 0x000000 }, { 1792, 889, 0x000000 }, },\
      },\
      pointMap = {},\
    },\
  }\
  for key = 1, #list do\
    local positionMap = list[key].positionMap\
    for rowNum, rol in ipairs(positionMap) do\
      if rol and positionMap[rowNum + 1] then\
        for colNum, col in ipairs(rol) do\
          if col and rol[colNum + 1] then\
            list[key].pointMap[rowNum .. '-' .. colNum] = col\
          end\
        end\
      end\
    end\
  end\
  return list\
end\
\
-- 获取地图棋盘和相关数据\
mapEvent.getMapChessboard = function()\
  return {\
    width = 8,\
    height = 3,\
    obstacle = {\
      { 1, 7 }, { 1, 8 },\
      { 2, 3 }, { 2, 4 }, { 2, 7 }, { 2, 8 },\
      { 3, 3 }, { 3, 4 },\
    },\
    waitForBossPosition = { { 3, 8 } },\
    bossPosition = {},\
    myFleetList = {},\
    enemyPositionList1 = {},\
    enemyPositionList2 = {},\
    enemyPositionList3 = {},\
    inBattleList = {},\
    selectedArrowList = {},\
    rewardBoxList = {},\
  }\
end\
\
return mapEvent" }


package.sourceCode = package.sourceCode or {}
package.sourceCode["./meta-operation/maps-options/map6-4.lua"] = { path = "./meta-operation/maps-options/map6-4.lua", name = "./meta-operation/maps-options/map6-4.lua", source = "local mapBase = require './map'\
local imgEvent = require './img6-4'\
local mapEvent = {}\
\
-- 从mapBase继承方法\
mapEvent = table.assign(mapEvent, mapBase)\
for key, value in pairs(mapBase) do\
  if type(value) == 'function' then\
    mapEvent[key] = function(...)\
      return value(imgEvent, ...)\
    end\
  end\
end\
\
-- 获取地图采样位置。由于地图可能超出一屏，所以这里可以定义多个采样位置。每次扫描都会对每个采样位置进行扫描\
-- 标志位为地图四个角。每个采样位置只需定义一个角的坐标即可。\
-- 还需要定义每个采样位置的地图矩阵与屏幕坐标的映射关系\
mapEvent.getCheckpositionList = function()\
  local list = {\
    {\
      leftTop = nil,\
      rightTop = { 1712, 490 },\
      leftBotton = nil,\
      rightBotton = nil,\
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的\
      positionMap = {\
        { { 408, 490, 0x101419 }, { 569, 490, 0x080c10 }, { 732, 490, 0x101019 }, { 895, 490, 0x081019 }, { 1058, 490, 0x212031 }, { 1221, 490, 0x213131 }, { 1384, 490, 0x212029 }, { 1546, 490, 0x21203a }, { 1712, 490, 0x191821 }, },\
        { { 386, 608, 0x000000 }, { 555, 608, 0x191831 }, { 723, 608, 0x21183a }, { 893, 608, 0x21203a }, { 1062, 608, 0x292042 }, { 1231, 608, 0x212042 }, { 1400, 608, 0x292852 }, { 1569, 608, 0xde8642 }, { 1742, 608, 0x6b8e9c }, },\
        { { 363, 735, 0x000000 }, { 538, 735, 0x191831 }, { 714, 735, 0x191831 }, { 890, 735, 0x191831 }, { 1066, 735, 0x211c3a }, { 1243, 735, 0x292042 }, { 1418, 735, 0x52353a }, { 1593, 735, 0x84595a }, { 1772, 735, 0x000000 }, },\
        { { 336, 873, 0x4a3d10 }, { 520, 873, 0x191431 }, { 704, 873, 0x191831 }, { 887, 873, 0x211c3a }, { 1071, 873, 0x211c3a }, { 1254, 873, 0x191829 }, { 1437, 873, 0x292042 }, { 1621, 873, 0x292042 }, { 1807, 873, 0x000000 }, },\
      },\
      pointMap = {},\
    },\
    {\
      leftTop = nil,\
      rightTop = nil,\
      leftBotton = { 542, 925 },\
      rightBotton = nil,\
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的\
      positionMap = {\
        false, false, false,\
        { { 595, 485, 0xb58108 }, { 777, 485, 0x211c42 }, { 961, 485, 0x211c42 }, { 1144, 485, 0x191429 }, { 1328, 485, 0x191831 }, { 1511, 485, 0x100c10 }, },\
        { { 579, 618, 0x000000 }, { 769, 618, 0x191831 }, { 960, 618, 0x211c3a }, { 1152, 618, 0x211c3a }, { 1343, 618, 0x211c31 }, { 1535, 618, 0x191831 }, },\
        { { 561, 763, 0x000000 }, { 760, 763, 0x191431 }, { 960, 763, 0x191431 }, { 1161, 763, 0x191831 }, { 1362, 763, 0x191429 }, { 1562, 763, 0x191429 }, },\
        { { 542, 925, 0x000000 }, { 751, 925, 0x000000 }, { 961, 925, 0x000000 }, { 1171, 925, 0x000000 }, { 1381, 925, 0x100c10 }, { 1592, 925, 0x080c08 }, },\
      },\
      pointMap = {},\
    },\
    {\
      leftTop = nil,\
      rightTop = nil,\
      leftBotton = nil,\
      rightBotton = { 1800, 931 },\
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的\
      positionMap = {\
        false, false, false,\
        { false, false, false, false, false, { 1137, 491, 0x211c31 }, { 1321, 491, 0x29203a }, { 1504, 491, 0x191c31 }, { 1690, 491, 0x000000 }, },\
        { false, false, false, false, false, { 1145, 625, 0x211c31 }, { 1337, 625, 0x211c42 }, { 1529, 625, 0x292042 }, { 1723, 625, 0x000000 }, },\
        { false, false, false, false, false, { 1153, 769, 0x211831 }, { 1354, 769, 0x191829 }, { 1554, 769, 0x191829 }, { 1757, 769, 0x000000 }, },\
        { false, false, false, false, false, { 1163, 931, 0x000000 }, { 1374, 931, 0x080c08 }, { 1583, 931, 0x100c10 }, { 1800, 931, 0x7b7d7b }, },\
      },\
      pointMap = {},\
    },\
  }\
  for key = 1, #list do\
    local positionMap = list[key].positionMap\
    for rowNum, rol in ipairs(positionMap) do\
      if rol and positionMap[rowNum + 1] then\
        for colNum, col in ipairs(rol) do\
          if col and rol[colNum + 1] then\
            list[key].pointMap[rowNum .. '-' .. colNum] = col\
          end\
        end\
      end\
    end\
  end\
  return list\
end\
\
-- 获取地图棋盘和相关数据\
mapEvent.getMapChessboard = function()\
  return {\
    width = 8,\
    height = 6,\
    obstacle = {\
      { 1, 7 }, { 1, 8 },\
      { 2, 8 },\
      { 3, 2 },\
      { 5, 5 },\
    },\
    waitForBossPosition = { { 1, 3 }, { 1, 4 }, { 2, 1 }, { 4, 8 }, { 5, 4 }, { 6, 1 } },\
    bossPosition = {},\
    myFleetList = {},\
    enemyPositionList1 = {},\
    enemyPositionList2 = {},\
    enemyPositionList3 = {},\
    inBattleList = {},\
    selectedArrowList = {},\
    rewardBoxList = {},\
  }\
end\
\
return mapEvent" }


package.sourceCode = package.sourceCode or {}
package.sourceCode["./meta-operation/maps-options/map6-3.lua"] = { path = "./meta-operation/maps-options/map6-3.lua", name = "./meta-operation/maps-options/map6-3.lua", source = "local mapBase = require './map'\
local imgEvent = require './img6-3'\
local mapEvent = {}\
\
-- 从mapBase继承方法\
mapEvent = table.assign(mapEvent, mapBase)\
for key, value in pairs(mapBase) do\
  if type(value) == 'function' then\
    mapEvent[key] = function(...)\
      return value(imgEvent, ...)\
    end\
  end\
end\
\
-- 获取地图采样位置。由于地图可能超出一屏，所以这里可以定义多个采样位置。每次扫描都会对每个采样位置进行扫描\
-- 标志位为地图四个角。每个采样位置只需定义一个角的坐标即可。\
-- 还需要定义每个采样位置的地图矩阵与屏幕坐标的映射关系\
mapEvent.getCheckpositionList = function()\
  local list = {\
    {\
      leftTop = nil,\
      rightTop = { 1685, 483 },\
      leftBotton = nil,\
      rightBotton = nil,\
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的\
      positionMap = {\
        { { 332, 483, 0x101c21 }, { 500, 483, 0x111c21 }, { 669, 483, 0x5a4921 }, { 838, 483, 0x192029 }, { 1008, 483, 0x192031 }, { 1177, 483, 0x21243a }, { 1346, 483, 0x192431 }, { 1515, 483, 0x212431 }, { 1685, 483, 0x293142 }, },\
        { { 306, 605, 0x191000 }, { 481, 605, 0x211c42 }, { 658, 605, 0x191831 }, { 834, 605, 0x191831 }, { 1010, 605, 0x211c3a }, { 1186, 605, 0x191c31 }, { 1362, 605, 0x192042 }, { 1538, 605, 0x29284a }, { 1715, 605, 0x000000 }, },\
        { { 278, 738, 0x000000 }, { 461, 738, 0x211831 }, { 645, 738, 0x21183a }, { 828, 738, 0x212042 }, { 1010, 738, 0x31456b }, { 1195, 738, 0x211831 }, { 1379, 738, 0x211c31 }, { 1563, 738, 0x292042 }, { 1747, 738, 0x000000 }, },\
        { { 248, 882, 0x000000 }, { 439, 882, 0x21183a }, { 631, 882, 0x21183a }, { 823, 882, 0x191831 }, { 1014, 882, 0x211c3a }, { 1206, 882, 0x211c3a }, { 1397, 882, 0x211831 }, { 1589, 882, 0x211c3a }, { 1782, 882, 0x000000 }, },\
      },\
      pointMap = {},\
    },\
    {\
      leftTop = nil,\
      rightTop = nil,\
      leftBotton = { 450, 886 },\
      rightBotton = nil,\
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的\
      positionMap = {\
        false, false, false,\
        { { 494, 584, 0x000000 }, { 685, 584, 0x21183a }, { 877, 584, 0x21183a }, { 1069, 584, 0x191831 }, { 1261, 584, 0x191831 }, },\
        { { 472, 727, 0x000000 }, { 674, 727, 0x4a3d10 }, { 873, 727, 0x211c3a }, { 1074, 727, 0x191429 }, { 1273, 727, 0x191831 }, },\
        { { 450, 886, 0x000000 }, { 658, 886, 0x000000 }, { 868, 886, 0x000000 }, { 1079, 886, 0x000000 }, { 1289, 886, 0x000000 }, },\
      },\
      pointMap = {},\
    },\
    {\
      leftTop = nil,\
      rightTop = nil,\
      leftBotton = nil,\
      rightBotton = { 1711, 885 },\
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的\
      positionMap = {\
        false, false, false,\
        { false, false, false, false, { 877, 582, 0x191829 }, { 1069, 582, 0x211831 }, { 1260, 582, 0x21203a }, { 1452, 582, 0x292042 }, { 1645, 582, 0x000000 }, },\
        { false, false, false, false, { 874, 725, 0x101021 }, { 1073, 725, 0x211c31 }, { 1274, 725, 0x191829 }, { 1474, 725, 0x191831 }, { 1676, 725, 0x000000 }, },\
        { false, false, false, false, { 869, 885, 0x000000 }, { 1079, 885, 0x000000 }, { 1290, 885, 0x000000 }, { 1499, 885, 0x000000 }, { 1711, 885, 0x000000 }, },\
      },\
      pointMap = {},\
    },\
  }\
  for key = 1, #list do\
    local positionMap = list[key].positionMap\
    for rowNum, rol in ipairs(positionMap) do\
      if rol and positionMap[rowNum + 1] then\
        for colNum, col in ipairs(rol) do\
          if col and rol[colNum + 1] then\
            list[key].pointMap[rowNum .. '-' .. colNum] = col\
          end\
        end\
      end\
    end\
  end\
  return list\
end\
\
-- 获取地图棋盘和相关数据\
mapEvent.getMapChessboard = function()\
  return {\
    width = 8,\
    height = 5,\
    obstacle = { { 2, 4 }, { 2, 5 }, { 3, 5 }, { 5, 1 } },\
    waitForBossPosition = { { 1, 1 }, { 3, 4 }, { 3, 8 } },\
    bossPosition = {},\
    myFleetList = {},\
    enemyPositionList1 = {},\
    enemyPositionList2 = {},\
    enemyPositionList3 = {},\
    inBattleList = {},\
    selectedArrowList = {},\
    rewardBoxList = {},\
  }\
end\
\
return mapEvent" }


package.sourceCode = package.sourceCode or {}
package.sourceCode["./meta-operation/maps-options/map6-2.lua"] = { path = "./meta-operation/maps-options/map6-2.lua", name = "./meta-operation/maps-options/map6-2.lua", source = "local mapBase = require './map'\
local imgEvent = require './img6-2'\
local mapEvent = {}\
\
-- 从mapBase继承方法\
mapEvent = table.assign(mapEvent, mapBase)\
for key, value in pairs(mapBase) do\
  if type(value) == 'function' then\
    mapEvent[key] = function(...)\
      return value(imgEvent, ...)\
    end\
  end\
end\
\
-- 获取地图采样位置。由于地图可能超出一屏，所以这里可以定义多个采样位置。每次扫描都会对每个采样位置进行扫描\
-- 标志位为地图四个角。每个采样位置只需定义一个角的坐标即可。\
-- 还需要定义每个采样位置的地图矩阵与屏幕坐标的映射关系\
mapEvent.getCheckpositionList = function()\
  local list = {\
    {\
      leftTop = nil,\
      rightTop = { 1719, 473 },\
      leftBotton = nil,\
      rightBotton = nil,\
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的\
      positionMap = {\
        { { 365, 473, 0x211c29 }, { 533, 473, 0x211829 }, { 703, 473, 0x191c29 }, { 872, 473, 0x191829 }, { 1041, 473, 0x212031 }, { 1211, 473, 0x21283a }, { 1380, 473, 0x191c29 }, { 1549, 473, 0x212431 }, { 1719, 473, 0x21243a }, },\
        { { 341, 594, 0x000000 }, { 516, 594, 0x211c3a }, { 692, 594, 0x212042 }, { 868, 594, 0x212442 }, { 1044, 594, 0x292042 }, { 1220, 594, 0x292442 }, { 1397, 594, 0x212442 }, { 1572, 594, 0x3a3563 }, { 1750, 594, 0x000000 }, },\
        { { 314, 726, 0x000000 }, { 498, 726, 0x21203a }, { 681, 726, 0x21203a }, { 865, 726, 0x211c3a }, { 1048, 726, 0x525584 }, { 1231, 726, 0x292042 }, { 1415, 726, 0x211c42 }, { 1598, 726, 0x31244a }, { 1783, 726, 0x000000 }, },\
        { { 286, 870, 0x000000 }, { 477, 870, 0x191831 }, { 669, 870, 0x191831 }, { 860, 870, 0x211c3a }, { 1051, 870, 0xe6e7de }, { 1242, 870, 0x424d7b }, { 1434, 870, 0x292042 }, { 1627, 870, 0x29203a }, { 1820, 870, 0x000000 }, },\
      },\
      pointMap = {},\
    },\
    {\
      leftTop = nil,\
      rightTop = nil,\
      leftBotton = { 357, 884 },\
      rightBotton = nil,\
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的\
      positionMap = {\
        false, false, false,\
        { { 437, 430, 0x000000 }, { 628, 430, 0x211c42 }, { 819, 430, 0x191831 }, { 1011, 430, 0x211831 }, { 1203, 430, 0x292431 }, },\
        { { 413, 567, 0x000000 }, { 612, 567, 0x191429 }, { 813, 567, 0x19183a }, { 1013, 567, 0x191831 }, { 1214, 567, 0x191831 }, },\
        { { 386, 717, 0x000000 }, { 595, 717, 0x19183a }, { 805, 717, 0x211842 }, { 1016, 717, 0x191429 }, { 1226, 717, 0x191429 }, },\
        { { 357, 884, 0x000000 }, { 577, 884, 0x000000 }, { 798, 884, 0x000000 }, { 1019, 884, 0x000000 }, { 1240, 884, 0x000000 }, },\
      },\
      pointMap = {},\
    },\
    {\
      leftTop = nil,\
      rightTop = nil,\
      leftBotton = nil,\
      rightBotton = { 1697, 885 },\
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的\
      positionMap = {\
        false, false, false,\
        { false, false, false, false, { 829, 431, 0x212431 }, { 1021, 431, 0x42497b }, { 1214, 431, 0x191831 }, { 1405, 431, 0x29203a }, { 1599, 431, 0x000000 }, },\
        { false, false, false, false, { 825, 567, 0x211c3a }, { 1025, 567, 0x191c31 }, { 1226, 567, 0x191831 }, { 1426, 567, 0x211c31 }, { 1628, 567, 0x000000 }, },\
        { false, false, false, false, { 818, 717, 0x191429 }, { 1028, 717, 0x191429 }, { 1238, 717, 0x191829 }, { 1448, 717, 0x191831 }, { 1661, 717, 0x000000 }, },\
        { false, false, false, false, { 811, 885, 0x000000 }, { 1032, 885, 0x000000 }, { 1253, 885, 0x000000 }, { 1474, 885, 0x000000 }, { 1697, 885, 0x000000 }, },\
      },\
      pointMap = {},\
    },\
  }\
  for key = 1, #list do\
    local positionMap = list[key].positionMap\
    for rowNum, rol in ipairs(positionMap) do\
      if rol and positionMap[rowNum + 1] then\
        for colNum, col in ipairs(rol) do\
          if col and rol[colNum + 1] then\
            list[key].pointMap[rowNum .. '-' .. colNum] = col\
          end\
        end\
      end\
    end\
  end\
  return list\
end\
\
-- 获取地图棋盘和相关数据\
mapEvent.getMapChessboard = function()\
  return {\
    width = 8,\
    height = 6,\
    obstacle = {\
      { 1, 6 }, { 1, 7 }, { 1, 8 },\
      { 3, 4 }, { 3, 5 },\
      { 4, 5 },\
      { 5, 2 }, { 5, 3 }, { 5, 7 },\
      { 6, 4 }, { 6, 5 },\
    },\
    waitForBossPosition = { { 5, 5 }, { 5, 8 }, { 6, 2 }, { 6, 7 } },\
    bossPosition = {},\
    myFleetList = {},\
    enemyPositionList1 = {},\
    enemyPositionList2 = {},\
    enemyPositionList3 = {},\
    inBattleList = {},\
    selectedArrowList = {},\
    rewardBoxList = {},\
  }\
end\
\
return mapEvent" }


package.sourceCode = package.sourceCode or {}
package.sourceCode["./meta-operation/maps-options/map6-1.lua"] = { path = "./meta-operation/maps-options/map6-1.lua", name = "./meta-operation/maps-options/map6-1.lua", source = "local mapBase = require './map'\
local imgEvent = require './img6-1'\
local mapEvent = {}\
\
-- 从mapBase继承方法\
mapEvent = table.assign(mapEvent, mapBase)\
for key, value in pairs(mapBase) do\
  if type(value) == 'function' then\
    mapEvent[key] = function(...)\
      return value(imgEvent, ...)\
    end\
  end\
end\
\
-- 获取地图采样位置。由于地图可能超出一屏，所以这里可以定义多个采样位置。每次扫描都会对每个采样位置进行扫描\
-- 标志位为地图四个角。每个采样位置只需定义一个角的坐标即可。\
-- 还需要定义每个采样位置的地图矩阵与屏幕坐标的映射关系\
mapEvent.getCheckpositionList = function()\
  local list = {\
    {\
      leftTop = nil,\
      rightTop = { 1685, 483 },\
      leftBotton = nil,\
      rightBotton = nil,\
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的\
      positionMap = {\
        { { 332, 483, 0x101c21 }, { 500, 483, 0x111c21 }, { 669, 483, 0x5a4921 }, { 838, 483, 0x192029 }, { 1008, 483, 0x192031 }, { 1177, 483, 0x21243a }, { 1346, 483, 0x192431 }, { 1515, 483, 0x212431 }, { 1685, 483, 0x293142 }, },\
        { { 306, 605, 0x191000 }, { 481, 605, 0x211c42 }, { 658, 605, 0x191831 }, { 834, 605, 0x191831 }, { 1010, 605, 0x211c3a }, { 1186, 605, 0x191c31 }, { 1362, 605, 0x192042 }, { 1538, 605, 0x29284a }, { 1715, 605, 0x000000 }, },\
        { { 278, 738, 0x000000 }, { 461, 738, 0x211831 }, { 645, 738, 0x21183a }, { 828, 738, 0x212042 }, { 1010, 738, 0x31456b }, { 1195, 738, 0x211831 }, { 1379, 738, 0x211c31 }, { 1563, 738, 0x292042 }, { 1747, 738, 0x000000 }, },\
        { { 248, 882, 0x000000 }, { 439, 882, 0x21183a }, { 631, 882, 0x21183a }, { 823, 882, 0x191831 }, { 1014, 882, 0x211c3a }, { 1206, 882, 0x211c3a }, { 1397, 882, 0x211831 }, { 1589, 882, 0x211c3a }, { 1782, 882, 0x000000 }, },\
      },\
      pointMap = {},\
    },\
    {\
      leftTop = nil,\
      rightTop = nil,\
      leftBotton = { 450, 886 },\
      rightBotton = nil,\
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的\
      positionMap = {\
        false, false, false,\
        { { 494, 584, 0x000000 }, { 685, 584, 0x21183a }, { 877, 584, 0x21183a }, { 1069, 584, 0x191831 }, { 1261, 584, 0x191831 }, },\
        { { 472, 727, 0x000000 }, { 674, 727, 0x4a3d10 }, { 873, 727, 0x211c3a }, { 1074, 727, 0x191429 }, { 1273, 727, 0x191831 }, },\
        { { 450, 886, 0x000000 }, { 658, 886, 0x000000 }, { 868, 886, 0x000000 }, { 1079, 886, 0x000000 }, { 1289, 886, 0x000000 }, },\
      },\
      pointMap = {},\
    },\
    {\
      leftTop = nil,\
      rightTop = nil,\
      leftBotton = nil,\
      rightBotton = { 1711, 885 },\
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的\
      positionMap = {\
        false, false, false,\
        { false, false, false, false, { 877, 582, 0x191829 }, { 1069, 582, 0x211831 }, { 1260, 582, 0x21203a }, { 1452, 582, 0x292042 }, { 1645, 582, 0x000000 }, },\
        { false, false, false, false, { 874, 725, 0x101021 }, { 1073, 725, 0x211c31 }, { 1274, 725, 0x191829 }, { 1474, 725, 0x191831 }, { 1676, 725, 0x000000 }, },\
        { false, false, false, false, { 869, 885, 0x000000 }, { 1079, 885, 0x000000 }, { 1290, 885, 0x000000 }, { 1499, 885, 0x000000 }, { 1711, 885, 0x000000 }, },\
      },\
      pointMap = {},\
    },\
  }\
  for key = 1, #list do\
    local positionMap = list[key].positionMap\
    for rowNum, rol in ipairs(positionMap) do\
      if rol and positionMap[rowNum + 1] then\
        for colNum, col in ipairs(rol) do\
          if col and rol[colNum + 1] then\
            list[key].pointMap[rowNum .. '-' .. colNum] = col\
          end\
        end\
      end\
    end\
  end\
  return list\
end\
\
-- 获取地图棋盘和相关数据\
mapEvent.getMapChessboard = function()\
  return {\
    width = 8,\
    height = 5,\
    obstacle = {\
      { 4, 1 }, { 4, 2 },\
      { 5, 1 }, { 5, 2 }, { 5, 6 },\
    },\
    waitForBossPosition = { { 1, 2 }, { 5, 5 }, { 5, 8 } },\
    bossPosition = {},\
    myFleetList = {},\
    enemyPositionList1 = {},\
    enemyPositionList2 = {},\
    enemyPositionList3 = {},\
    inBattleList = {},\
    selectedArrowList = {},\
    rewardBoxList = {},\
  }\
end\
\
return mapEvent" }


package.sourceCode = package.sourceCode or {}
package.sourceCode["./meta-operation/maps-options/map5-4.lua"] = { path = "./meta-operation/maps-options/map5-4.lua", name = "./meta-operation/maps-options/map5-4.lua", source = "local mapBase = require './map'\
local imgEvent = require './img5-4'\
local mapEvent = {}\
\
-- 从mapBase继承方法\
mapEvent = table.assign(mapEvent, mapBase)\
for key, value in pairs(mapBase) do\
  if type(value) == 'function' then\
    mapEvent[key] = function(...)\
      return value(imgEvent, ...)\
    end\
  end\
end\
\
-- 获取地图采样位置。由于地图可能超出一屏，所以这里可以定义多个采样位置。每次扫描都会对每个采样位置进行扫描\
-- 标志位为地图四个角。每个采样位置只需定义一个角的坐标即可。\
-- 还需要定义每个采样位置的地图矩阵与屏幕坐标的映射关系\
mapEvent.getCheckpositionList = function()\
  local list = {\
    {\
      leftTop = { 335, 475 },\
      rightTop = nil,\
      leftBotton = nil,\
      rightBotton = nil,\
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的\
      positionMap = {\
        { { 335, 475, 0x294152 }, { 509, 475, 0x29414a }, { 685, 475, 0x29414a }, { 861, 475, 0x29414a }, { 1037, 475, 0x29414a }, { 1214, 475, 0x293542 }, { 1390, 475, 0x213542 }, { 1566, 475, 0x213142 }, { 1744, 475, 0x213042 }, },\
        { { 308, 601, 0x000000 }, { 490, 601, 0x117994 }, { 674, 601, 0x427d63 }, { 857, 601, 0x218194 }, { 1041, 601, 0x217994 }, { 1224, 601, 0x19758c }, { 1408, 601, 0x19798c }, { 1591, 601, 0x218194 }, { 1777, 601, 0x000000 }, },\
        { { 279, 739, 0x000000 }, { 470, 739, 0x19798c }, { 661, 739, 0x19818c }, { 853, 739, 0x198194 }, { 1044, 739, 0x109ebd }, { 1236, 739, 0x105d84 }, { 1428, 739, 0x195d84 }, { 1619, 739, 0x217194 }, { 1813, 739, 0x000000 }, },\
        { { 248, 890, 0x000000 }, { 447, 890, 0x297594 }, { 648, 890, 0x317594 }, { 848, 890, 0x196184 }, { 1048, 890, 0xada6a4 }, { 1249, 890, 0x8cebad }, { 1449, 890, 0x214d7b }, { 1650, 890, 0x315584 }, { 1852, 890, 0x000000 }, },\
      },\
      pointMap = {},\
    },\
    {\
      leftTop = nil,\
      rightTop = nil,\
      leftBotton = { 365, 885 },\
      rightBotton = nil,\
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的\
      positionMap = {\
        false, false, false,\
        { { 420, 568, 0x000000 }, { 619, 568, 0x29758c }, { 820, 568, 0x31759c }, { 1020, 568, 0x21618c }, { 1221, 568, 0xada6a4 }, },\
        { { 394, 718, 0x000000 }, { 603, 718, 0x19658c }, { 813, 718, 0x216d8c }, { 1023, 718, 0x115984 }, { 1233, 718, 0x003d73 }, },\
        { { 365, 885, 0x000000 }, { 585, 885, 0x000000 }, { 806, 885, 0x000000 }, { 1026, 885, 0x000000 }, { 1247, 885, 0x000000 }, },\
      },\
      pointMap = {},\
    },\
    {\
      leftTop = nil,\
      rightTop = nil,\
      leftBotton = nil,\
      rightBotton = { 1738, 885 },\
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的\
      positionMap = {\
        false, false, false,\
        { false, false, false, false, { 862, 568, 0xb5aaad }, { 1064, 568, 0x73c68c }, { 1263, 568, 0x214d73 }, { 1463, 568, 0x215184 }, { 1666, 568, 0x000000 }, },\
        { false, false, false, false, { 858, 718, 0x19417b }, { 1068, 718, 0x214584 }, { 1277, 718, 0x214d7b }, { 1488, 718, 0x31518c }, { 1700, 718, 0x000000 }, },\
        { false, false, false, false, { 852, 885, 0x000000 }, { 1073, 885, 0x000000 }, { 1294, 885, 0x000000 }, { 1515, 885, 0x000000 }, { 1738, 885, 0x000000 }, },\
      },\
      pointMap = {},\
    },\
  }\
  for key = 1, #list do\
    local positionMap = list[key].positionMap\
    for rowNum, rol in ipairs(positionMap) do\
      if rol and positionMap[rowNum + 1] then\
        for colNum, col in ipairs(rol) do\
          if col and rol[colNum + 1] then\
            list[key].pointMap[rowNum .. '-' .. colNum] = col\
          end\
        end\
      end\
    end\
  end\
  return list\
end\
\
-- 获取地图棋盘和相关数据\
mapEvent.getMapChessboard = function()\
  return {\
    width = 8,\
    height = 5,\
    obstacle = {\
      { 1, 1 }, { 1, 2 }, { 1, 3 }, { 1, 4 },\
      { 3, 4 }, { 3, 5 }, { 4, 5 },\
      { 5, 1 }, { 5, 2 },\
    },\
    waitForBossPosition = { { 1, 5 }, { 1, 8 }, { 4, 2 }, { 5, 5 }, { 5, 8 } },\
    bossPosition = {},\
    myFleetList = {},\
    enemyPositionList1 = {},\
    enemyPositionList2 = {},\
    enemyPositionList3 = {},\
    inBattleList = {},\
    selectedArrowList = {},\
    rewardBoxList = {},\
  }\
end\
\
return mapEvent" }


package.sourceCode = package.sourceCode or {}
package.sourceCode["./meta-operation/maps-options/map5-3.lua"] = { path = "./meta-operation/maps-options/map5-3.lua", name = "./meta-operation/maps-options/map5-3.lua", source = "local mapBase = require './map'\
local imgEvent = require './img5-3'\
local mapEvent = {}\
\
-- 从mapBase继承方法\
mapEvent = table.assign(mapEvent, mapBase)\
for key, value in pairs(mapBase) do\
  if type(value) == 'function' then\
    mapEvent[key] = function(...)\
      return value(imgEvent, ...)\
    end\
  end\
end\
\
-- 获取地图采样位置。由于地图可能超出一屏，所以这里可以定义多个采样位置。每次扫描都会对每个采样位置进行扫描\
-- 标志位为地图四个角。每个采样位置只需定义一个角的坐标即可。\
-- 还需要定义每个采样位置的地图矩阵与屏幕坐标的映射关系\
mapEvent.getCheckpositionList = function()\
  local list = {\
    {\
      leftTop = { 449, 473 },\
      rightTop = nil,\
      leftBotton = nil,\
      rightBotton = nil,\
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的\
      positionMap = {\
        { { 449, 473, 0x213531 }, { 618, 475, 0x213542 }, { 787, 475, 0x213142 }, { 956, 475, 0x19293a }, { 1125, 475, 0x213142 }, { 1293, 475, 0x213142 }, { 1464, 475, 0x19313a }, { 1633, 475, 0x29414a }, },\
        { { 428, 597, 0x000000 }, { 604, 597, 0x6b5108 }, { 779, 597, 0x197994 }, { 955, 597, 0x218194 }, { 1131, 597, 0x21718c }, { 1307, 597, 0x218194 }, { 1483, 597, 0x217d94 }, { 1661, 597, 0x000000 }, },\
        { { 406, 729, 0x000000 }, { 589, 729, 0x9c7910 }, { 772, 729, 0x19798c }, { 955, 729, 0x318194 }, { 1139, 729, 0x195d7b }, { 1322, 729, 0x196984 }, { 1506, 729, 0x196984 }, { 1691, 729, 0x000000 }, },\
        { { 381, 873, 0x000000 }, { 572, 873, 0x21799c }, { 763, 873, 0x21718c }, { 955, 873, 0x104d7b }, { 1147, 873, 0x10497b }, { 1338, 873, 0x194573 }, { 1530, 873, 0x215984 }, { 1724, 873, 0x000000 }, },\
      },\
      pointMap = {},\
    },\
    {\
      leftTop = nil,\
      rightTop = nil,\
      leftBotton = { 316, 885 },\
      rightBotton = nil,\
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的\
      positionMap = {\
        false, false, false,\
        { { 373, 582, 0x000000 }, { 563, 582, 0x298aad }, { 755, 582, 0x21718c }, { 947, 582, 0x084d73 }, { 1138, 582, 0x21498c }, { 1329, 582, 0x214973 }, { 1521, 582, 0x215984 }, { 1715, 582, 0x000000 }, },\
        { { 346, 725, 0x000000 }, { 545, 725, 0x21719c }, { 746, 725, 0x196984 }, { 946, 725, 0x08496b }, { 1147, 725, 0x104173 }, { 1347, 725, 0x104d7b }, { 1547, 725, 0x294d84 }, { 1750, 725, 0x000000 }, },\
        { { 316, 885, 0x000000 }, { 525, 885, 0x000000 }, { 735, 885, 0x000000 }, { 945, 885, 0x000000 }, { 1156, 885, 0x000000 }, { 1366, 885, 0x000000 }, { 1576, 885, 0x000000 }, { 1789, 885, 0x000000 }, },\
      },\
      pointMap = {},\
    },\
  }\
  for key = 1, #list do\
    local positionMap = list[key].positionMap\
    for rowNum, rol in ipairs(positionMap) do\
      if rol and positionMap[rowNum + 1] then\
        for colNum, col in ipairs(rol) do\
          if col and rol[colNum + 1] then\
            list[key].pointMap[rowNum .. '-' .. colNum] = col\
          end\
        end\
      end\
    end\
  end\
  return list\
end\
\
-- 获取地图棋盘和相关数据\
mapEvent.getMapChessboard = function()\
  return {\
    width = 7,\
    height = 5,\
    obstacle = { { 1, 1 }, { 2, 1 }, { 3, 1 }, { 4, 1 }, { 3, 3 }, },\
    waitForBossPosition = { { 1, 2 }, { 1, 6 }, { 4, 5 } },\
    bossPosition = {},\
    myFleetList = {},\
    enemyPositionList1 = {},\
    enemyPositionList2 = {},\
    enemyPositionList3 = {},\
    inBattleList = {},\
    selectedArrowList = {},\
    rewardBoxList = {},\
  }\
end\
\
return mapEvent" }


package.sourceCode = package.sourceCode or {}
package.sourceCode["./meta-operation/maps-options/map5-2.lua"] = { path = "./meta-operation/maps-options/map5-2.lua", name = "./meta-operation/maps-options/map5-2.lua", source = "local mapBase = require './map'\
local imgEvent = require './img5-2'\
local mapEvent = {}\
\
-- 从mapBase继承方法\
mapEvent = table.assign(mapEvent, mapBase)\
for key, value in pairs(mapBase) do\
  if type(value) == 'function' then\
    mapEvent[key] = function(...)\
      return value(imgEvent, ...)\
    end\
  end\
end\
\
-- 获取地图采样位置。由于地图可能超出一屏，所以这里可以定义多个采样位置。每次扫描都会对每个采样位置进行扫描\
-- 标志位为地图四个角。每个采样位置只需定义一个角的坐标即可。\
-- 还需要定义每个采样位置的地图矩阵与屏幕坐标的映射关系\
mapEvent.getCheckpositionList = function()\
  local list = {\
    {\
      leftTop = { 339, 467 },\
      rightTop = nil,\
      leftBotton = nil,\
      rightBotton = nil,\
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的\
      positionMap = {\
        { { 339, 467, 0x314531 }, { 514, 467, 0x19243a }, { 690, 467, 0x19243a }, { 866, 467, 0x19283a }, { 1043, 467, 0x293942 }, { 1219, 467, 0x29414a }, { 1394, 467, 0x293942 }, { 1570, 467, 0x293942 }, { 1748, 467, 0x213d42 }, },\
        { { 312, 593, 0x000000 }, { 495, 593, 0x197dad }, { 678, 593, 0x3a7d6b }, { 862, 593, 0x197984 }, { 1045, 593, 0x217994 }, { 1229, 593, 0x21798c }, { 1413, 593, 0x298194 }, { 1596, 593, 0x19798c }, { 1781, 593, 0x000000 }, },\
        { { 283, 731, 0x000000 }, { 474, 731, 0x19798c }, { 666, 731, 0x19798c }, { 857, 731, 0x198194 }, { 1049, 731, 0x196184 }, { 1241, 731, 0x31696b }, { 1432, 731, 0x196184 }, { 1624, 731, 0x196d84 }, { 1817, 731, 0x000000 }, },\
        { { 252, 881, 0x000000 }, { 452, 881, 0x21718c }, { 652, 881, 0x527152 }, { 852, 881, 0x085984 }, { 1053, 881, 0x21517b }, { 1253, 881, 0x294d84 }, { 1454, 881, 0x194d73 }, { 1655, 881, 0x315d8c }, { 1857, 881, 0x000000 }, },\
      },\
      pointMap = {},\
    },\
    {\
      leftTop = nil,\
      rightTop = nil,\
      leftBotton = { 358, 884 },\
      rightBotton = nil,\
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的\
      positionMap = {\
        false, false, false,\
        { { 414, 567, 0x000000 }, { 613, 567, 0x317594 }, { 814, 567, 0x216d8c }, { 1015, 567, 0x215d84 }, { 1215, 567, 0x215184 }, },\
        { { 388, 717, 0x000000 }, { 597, 717, 0x21658c }, { 807, 717, 0x297194 }, { 1017, 717, 0x215d84 }, { 1227, 717, 0x10417b }, },\
        { { 358, 884, 0x000000 }, { 578, 884, 0x000000 }, { 799, 884, 0x000000 }, { 1020, 884, 0x000000 }, { 1241, 884, 0x000000 }, },\
      },\
      pointMap = {},\
    },\
    {\
      leftTop = nil,\
      rightTop = nil,\
      leftBotton = nil,\
      rightBotton = { 1676, 884 },\
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的\
      positionMap = {\
        false, false, false,\
        { false, false, false, false, { 866, 564, 0x195184 }, { 1066, 564, 0x295184 }, { 1267, 564, 0x214d7b }, { 1467, 564, 0x29598c }, { 1669, 564, 0x000000 }, },\
        { false, false, false, false, { 861, 714, 0x003d73 }, { 1071, 714, 0x104173 }, { 1281, 714, 0x214d7b }, { 1492, 714, 0x31518c }, { 1704, 714, 0x000000 }, },\
        { false, false, false, false, { 856, 881, 0x000000 }, { 1077, 881, 0x000000 }, { 1298, 881, 0x000000 }, { 1519, 881, 0x000000 }, { 1741, 881, 0x000000 }, },\
      },\
      pointMap = {},\
    },\
  }\
  for key = 1, #list do\
    local positionMap = list[key].positionMap\
    for rowNum, rol in ipairs(positionMap) do\
      if rol and positionMap[rowNum + 1] then\
        for colNum, col in ipairs(rol) do\
          if col and rol[colNum + 1] then\
            list[key].pointMap[rowNum .. '-' .. colNum] = col\
          end\
        end\
      end\
    end\
  end\
  return list\
end\
\
-- 获取地图棋盘和相关数据\
mapEvent.getMapChessboard = function()\
  return {\
    width = 8,\
    height = 5,\
    obstacle = {\
      { 1, 1 }, { 1, 2 }, { 1, 3 },\
      { 2, 5 }, { 2, 6 },\
      { 3, 6 },\
    },\
    waitForBossPosition = { { 1, 5 }, { 3, 5 }, { 3, 7 } },\
    bossPosition = {},\
    myFleetList = {},\
    enemyPositionList1 = {},\
    enemyPositionList2 = {},\
    enemyPositionList3 = {},\
    inBattleList = {},\
    selectedArrowList = {},\
    rewardBoxList = {},\
  }\
end\
\
return mapEvent" }


package.sourceCode = package.sourceCode or {}
package.sourceCode["./meta-operation/maps-options/map5-1.lua"] = { path = "./meta-operation/maps-options/map5-1.lua", name = "./meta-operation/maps-options/map5-1.lua", source = "local mapBase = require './map'\
local imgEvent = require './img5-1'\
local mapEvent = {}\
\
-- 从mapBase继承方法\
mapEvent = table.assign(mapEvent, mapBase)\
for key, value in pairs(mapBase) do\
  if type(value) == 'function' then\
    mapEvent[key] = function(...)\
      return value(imgEvent, ...)\
    end\
  end\
end\
\
-- 获取地图采样位置。由于地图可能超出一屏，所以这里可以定义多个采样位置。每次扫描都会对每个采样位置进行扫描\
-- 标志位为地图四个角。每个采样位置只需定义一个角的坐标即可。\
-- 还需要定义每个采样位置的地图矩阵与屏幕坐标的映射关系\
mapEvent.getCheckpositionList = function()\
  local list = {\
    {\
      leftTop = { 303, 471 },\
      rightTop = nil,\
      leftBotton = nil,\
      rightBotton = nil,\
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的\
      positionMap = {\
        { { 303, 471, 0x293d4a }, { 472, 471, 0x213542 }, { 641, 471, 0x29414a }, { 810, 471, 0x212d42 }, { 979, 471, 0x314952 }, { 1149, 471, 0x315152 }, { 1318, 471, 0x212d42 }, { 1487, 471, 0x213142 }, { 1656, 471, 0x19283a }, },\
        { { 276, 592, 0x000000 }, { 452, 593, 0x106d8c }, { 628, 593, 0x19718c }, { 804, 593, 0x197d8c }, { 980, 593, 0x19758c }, { 1156, 593, 0x197984 }, { 1332, 593, 0x217d8c }, { 1508, 593, 0x197a8c }, { 1685, 593, 0x000101 }, },\
        { { 247, 723, 0x000000 }, { 430, 725, 0x217984 }, { 615, 725, 0xdea608 }, { 798, 725, 0x107984 }, { 981, 725, 0x21718c }, { 1165, 725, 0x216d94 }, { 1348, 725, 0x19698c }, { 1532, 725, 0x19758c }, { 1716, 725, 0x000000 }, },\
        { { 216, 867, 0x000000 }, { 407, 869, 0x197d8c }, { 599, 869, 0x297d8c }, { 790, 869, 0x086984 }, { 982, 869, 0x085173 }, { 1174, 869, 0x194d73 }, { 1365, 869, 0x216184 }, { 1557, 869, 0x21698c }, { 1750, 869, 0x000000 }, },\
      },\
      pointMap = {},\
    },\
    {\
      leftTop = nil,\
      rightTop = nil,\
      leftBotton = { 385, 885 },\
      rightBotton = nil,\
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的\
      positionMap = {\
        false, false, false,\
        { { 461, 432, 0x000000 }, { 654, 432, 0x7b5910 }, { 845, 432, 0x297d8c }, { 1036, 432, 0x21758c }, { 1228, 432, 0x21598c }, },\
        { { 438, 569, 0x000000 }, { 639, 569, 0x316594 }, { 839, 569, 0x296994 }, { 1040, 569, 0x08517b }, { 1240, 569, 0x08496b }, },\
        { { 413, 719, 0x000000 }, { 623, 719, 0x21698c }, { 834, 719, 0x105584 }, { 1044, 719, 0x085573 }, { 1254, 719, 0x105584 }, },\
        { { 385, 885, 0x000000 }, { 606, 885, 0x000000 }, { 827, 885, 0x000000 }, { 1048, 885, 0x000000 }, { 1269, 885, 0x000000 }, },\
      },\
      pointMap = {},\
    },\
    {\
      leftTop = nil,\
      rightTop = nil,\
      leftBotton = nil,\
      rightBotton = { 1676, 884 },\
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的\
      positionMap = {\
        false, false, false,\
        { false, false, false, false, { 814, 431, 0x08517c }, { 1005, 431, 0x19517b }, { 1197, 431, 0x195d84 }, { 1389, 431, 0x19698c }, { 1581, 431, 0x000000 }, },\
        { false, false, false, false, { 807, 567, 0x214d7b }, { 1007, 567, 0x21497b }, { 1208, 567, 0x194573 }, { 1408, 567, 0x214d84 }, { 1610, 567, 0x000000 }, },\
        { false, false, false, false, { 800, 718, 0x216184 }, { 1010, 718, 0x21417b }, { 1219, 718, 0xbdbab5 }, { 1429, 718, 0x3a6163 }, { 1642, 718, 0x000000 }, },\
        { false, false, false, false, { 791, 884, 0x000000 }, { 1012, 884, 0x000000 }, { 1233, 884, 0x000000 }, { 1454, 884, 0x000000 }, { 1676, 884, 0x000000 }, },\
      },\
      pointMap = {},\
    },\
  }\
  for key = 1, #list do\
    local positionMap = list[key].positionMap\
    for rowNum, rol in ipairs(positionMap) do\
      if rol and positionMap[rowNum + 1] then\
        for colNum, col in ipairs(rol) do\
          if col and rol[colNum + 1] then\
            list[key].pointMap[rowNum .. '-' .. colNum] = col\
          end\
        end\
      end\
    end\
  end\
  return list\
end\
\
-- 获取地图棋盘和相关数据\
mapEvent.getMapChessboard = function()\
  return {\
    width = 8,\
    height = 6,\
    obstacle = {\
      { 1, 4 }, { 1, 5 }, { 1, 6 }, { 1, 7 }, { 1, 8 },\
      { 5, 6 }, { 5, 7 }, { 5, 8 },\
      { 6, 7 }, { 6, 8 },\
    },\
    waitForBossPosition = { { 1, 1 }, { 2, 8 }, { 4, 8 }, { 6, 1 }, },\
    bossPosition = {},\
    myFleetList = {},\
    enemyPositionList1 = {},\
    enemyPositionList2 = {},\
    enemyPositionList3 = {},\
    inBattleList = {},\
    selectedArrowList = {},\
    rewardBoxList = {},\
  }\
end\
\
return mapEvent" }


package.sourceCode = package.sourceCode or {}
package.sourceCode["./meta-operation/maps-options/map4-4.lua"] = { path = "./meta-operation/maps-options/map4-4.lua", name = "./meta-operation/maps-options/map4-4.lua", source = "local mapBase = require './map'\
local imgEvent = require './img4-4'\
local mapEvent = {}\
\
-- 从mapBase继承方法\
mapEvent = table.assign(mapEvent, mapBase)\
for key, value in pairs(mapBase) do\
  if type(value) == 'function' then\
    mapEvent[key] = function(...)\
      return value(imgEvent, ...)\
    end\
  end\
end\
\
-- 获取地图采样位置。由于地图可能超出一屏，所以这里可以定义多个采样位置。每次扫描都会对每个采样位置进行扫描\
-- 标志位为地图四个角。每个采样位置只需定义一个角的坐标即可。\
-- 还需要定义每个采样位置的地图矩阵与屏幕坐标的映射关系\
mapEvent.getCheckpositionList = function()\
  local list = {\
    {\
      leftTop = nil,\
      rightTop = { 1642, 501 },\
      leftBotton = nil,\
      rightBotton = nil,\
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的\
      positionMap = {\
        { { 287, 501, 0x313131 }, { 455, 501, 0x423931 }, { 625, 501, 0x312829 }, { 794, 501, 0x292421 }, { 963, 501, 0x312429 }, { 1132, 501, 0x312410 }, { 1302, 501, 0x292421 }, { 1471, 501, 0x312429 }, { 1642, 501, 0x312821 }, },\
        { { 260, 623, 0x000000 }, { 435, 623, 0x523d52 }, { 611, 623, 0x734d52 }, { 787, 623, 0x845d5a }, { 963, 623, 0x734d52 }, { 1139, 623, 0x73514a }, { 1315, 623, 0x7b5d4a }, { 1492, 623, 0x8c696b }, { 1670, 623, 0x000000 }, },\
        { { 231, 756, 0x000000 }, { 413, 756, 0x4a3d52 }, { 597, 756, 0x5a414a }, { 780, 756, 0x634952 }, { 963, 756, 0x63494a }, { 1147, 756, 0x734942 }, { 1330, 756, 0x845952 }, { 1514, 756, 0x7b5552 }, { 1700, 756, 0x000000 }, },\
        { { 199, 901, 0x000000 }, { 389, 901, 0x4a394a }, { 580, 901, 0x735152 }, { 772, 901, 0x3a3131 }, { 963, 901, 0x3a283a }, { 1155, 901, 0x4a353a }, { 1347, 901, 0x63494a }, { 1538, 901, 0x63453a }, { 1732, 901, 0x000000 }, },\
      },\
      pointMap = {},\
    },\
    {\
      leftTop = nil,\
      rightTop = nil,\
      leftBotton = { 480, 893 },\
      rightBotton = nil,\
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的\
      positionMap = {\
        false, false, false,\
        { { 544, 438, 0x000000 }, { 734, 438, 0x523552 }, { 926, 438, 0x845563 }, { 1118, 438, 0x4a3542 }, { 1309, 438, 0x312831 }, { 1501, 438, 0x4a313a }, },\
        { { 525, 575, 0x000000 }, { 724, 575, 0x3a2d4a }, { 925, 575, 0x4a3952 }, { 1124, 575, 0x292431 }, { 1327, 575, 0x312431 }, { 1527, 575, 0x422431 }, },\
        { { 504, 725, 0x000000 }, { 712, 725, 0x312842 }, { 922, 725, 0x31243a }, { 1133, 725, 0x312842 }, { 1343, 725, 0x312842 }, { 1554, 725, 0x191821 }, },\
        { { 480, 893, 0x000000 }, { 700, 893, 0x000000 }, { 921, 893, 0x000000 }, { 1142, 893, 0x000000 }, { 1363, 893, 0x000000 }, { 1583, 893, 0x000000 }, },\
      },\
      pointMap = {},\
    },\
    {\
      leftTop = nil,\
      rightTop = nil,\
      leftBotton = nil,\
      rightBotton = { 1756, 894 },\
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的\
      positionMap = {\
        false, false, false,\
        { false, false, false, false, false, { 1073, 439, 0x4a353a }, { 1264, 439, 0x634142 }, { 1456, 439, 0x63453a }, { 1650, 439, 0x000000 }, },\
        { false, false, false, false, false, { 1079, 576, 0x524d42 }, { 1279, 576, 0x523542 }, { 1479, 576, 0x734952 }, { 1685, 576, 0xf7c28c }, },\
        { false, false, false, false, false, { 1084, 726, 0x29203a }, { 1294, 726, 0x3a243a }, { 1504, 726, 0x5a3542 }, { 1717, 726, 0x000000 }, },\
        { false, false, false, false, false, { 1091, 894, 0x000000 }, { 1311, 894, 0x000000 }, { 1533, 894, 0x000000 }, { 1756, 894, 0x000000 }, },\
      },\
      pointMap = {},\
    },\
  }\
  for key = 1, #list do\
    local positionMap = list[key].positionMap\
    for rowNum, rol in ipairs(positionMap) do\
      if rol and positionMap[rowNum + 1] then\
        for colNum, col in ipairs(rol) do\
          if col and rol[colNum + 1] then\
            list[key].pointMap[rowNum .. '-' .. colNum] = col\
          end\
        end\
      end\
    end\
  end\
  return list\
end\
\
-- 获取地图棋盘和相关数据\
mapEvent.getMapChessboard = function()\
  return {\
    width = 8,\
    height = 6,\
    obstacle = {\
      { 1, 1 }, { 1, 2 }, { 1, 7 }, { 1, 8 },\
      { 2, 1 }, { 2, 2 }, { 2, 8 },\
      { 3, 1 }, { 3, 2 },\
      { 4, 1 }, { 4, 2 }, { 4, 5 },\
      { 5, 1 }, { 5, 2 }, { 5, 5 },\
    },\
    waitForBossPosition = { { 1, 3 }, { 6, 1 } },\
    bossPosition = {},\
    myFleetList = {},\
    enemyPositionList1 = {},\
    enemyPositionList2 = {},\
    enemyPositionList3 = {},\
    inBattleList = {},\
    selectedArrowList = {},\
    rewardBoxList = {},\
  }\
end\
\
return mapEvent" }


package.sourceCode = package.sourceCode or {}
package.sourceCode["./meta-operation/maps-options/map4-3.lua"] = { path = "./meta-operation/maps-options/map4-3.lua", name = "./meta-operation/maps-options/map4-3.lua", source = "local mapBase = require './map'\
local imgEvent = require './img4-3'\
local mapEvent = {}\
\
-- 从mapBase继承方法\
mapEvent = table.assign(mapEvent, mapBase)\
for key, value in pairs(mapBase) do\
  if type(value) == 'function' then\
    mapEvent[key] = function(...)\
      return value(imgEvent, ...)\
    end\
  end\
end\
\
-- 获取地图采样位置。由于地图可能超出一屏，所以这里可以定义多个采样位置。每次扫描都会对每个采样位置进行扫描\
-- 标志位为地图四个角。每个采样位置只需定义一个角的坐标即可。\
-- 还需要定义每个采样位置的地图矩阵与屏幕坐标的映射关系\
mapEvent.getCheckpositionList = function()\
  local list = {\
    {\
      leftTop = nil,\
      rightTop = { 1635, 594 },\
      leftBotton = nil,\
      rightBotton = nil,\
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的\
      positionMap = {\
        { { 402, 594, 0x212031 }, { 577, 594, 0x191c29 }, { 754, 594, 0x31283a }, { 930, 594, 0x3a3129 }, { 1106, 594, 0x292031 }, { 1283, 594, 0xad8673 }, { 1459, 594, 0x424142 }, { 1635, 594, 0x212029 }, },\
        { { 379, 725, 0x000000 }, { 562, 725, 0x4a354a }, { 745, 725, 0x6b4d52 }, { 929, 725, 0x6b4d52 }, { 1112, 725, 0x6b4542 }, { 1295, 725, 0x7b5552 }, { 1479, 725, 0x7b5d4a }, { 1665, 725, 0x000000 }, },\
        { { 354, 869, 0x000000 }, { 544, 869, 0x423542 }, { 736, 869, 0x735152 }, { 927, 869, 0x3a313a }, { 1118, 869, 0x422831 }, { 1310, 869, 0x633d42 }, { 1502, 869, 0x846952 }, { 1696, 869, 0x000000 }, },\
      },\
      pointMap = {},\
    },\
    {\
      leftTop = nil,\
      rightTop = { 1591, 332 },\
      leftBotton = nil,\
      rightBotton = nil,\
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的\
      positionMap = {\
        false, false,\
        { { 305, 584, 0x000000 }, { 495, 584, 0x4a354a }, { 686, 584, 0x845d63 }, { 878, 584, 0x3a2d42 }, { 1070, 584, 0x523142 }, { 1261, 584, 0x633d42 }, { 1453, 584, 0x8c6d5a }, { 1647, 584, 0x000000 }, },\
        { { 274, 728, 0x000000 }, { 473, 728, 0x84695a }, { 673, 728, 0x3a314a }, { 875, 728, 0x29243a }, { 1075, 728, 0x292031 }, { 1276, 728, 0x422d42 }, { 1475, 728, 0x6b4142 }, { 1679, 728, 0x212529 }, },\
        { { 241, 888, 0x000000 }, { 450, 888, 0x000000 }, { 660, 888, 0x000000 }, { 871, 888, 0x000000 }, { 1080, 888, 0x000000 }, { 1289, 888, 0x000000 }, { 1291, 888, 0x000000 }, { 1502, 888, 0x000000 }, { 1714, 888, 0x000000 }, },\
      },\
      pointMap = {},\
    },\
  }\
  for key = 1, #list do\
    local positionMap = list[key].positionMap\
    for rowNum, rol in ipairs(positionMap) do\
      if rol and positionMap[rowNum + 1] then\
        for colNum, col in ipairs(rol) do\
          if col and rol[colNum + 1] then\
            list[key].pointMap[rowNum .. '-' .. colNum] = col\
          end\
        end\
      end\
    end\
  end\
  return list\
end\
\
-- 获取地图棋盘和相关数据\
mapEvent.getMapChessboard = function()\
  return {\
    width = 7,\
    height = 4,\
    obstacle = {\
      { 3, 1 }, { 3, 2 },\
      { 4, 1 }, { 4, 2 },\
    },\
    waitForBossPosition = { { 1, 7 }, { 3, 6 }, { 4, 3 } },\
    bossPosition = {},\
    myFleetList = {},\
    enemyPositionList1 = {},\
    enemyPositionList2 = {},\
    enemyPositionList3 = {},\
    inBattleList = {},\
    selectedArrowList = {},\
    rewardBoxList = {},\
  }\
end\
\
return mapEvent" }


package.sourceCode = package.sourceCode or {}
package.sourceCode["./meta-operation/maps-options/map4-2.lua"] = { path = "./meta-operation/maps-options/map4-2.lua", name = "./meta-operation/maps-options/map4-2.lua", source = "local mapBase = require './map'\
local imgEvent = require './img4-2'\
local mapEvent = {}\
\
-- 从mapBase继承方法\
mapEvent = table.assign(mapEvent, mapBase)\
for key, value in pairs(mapBase) do\
  if type(value) == 'function' then\
    mapEvent[key] = function(...)\
      return value(imgEvent, ...)\
    end\
  end\
end\
\
-- 获取地图采样位置。由于地图可能超出一屏，所以这里可以定义多个采样位置。每次扫描都会对每个采样位置进行扫描\
-- 标志位为地图四个角。每个采样位置只需定义一个角的坐标即可。\
-- 还需要定义每个采样位置的地图矩阵与屏幕坐标的映射关系\
mapEvent.getCheckpositionList = function()\
  local list = {\
    {\
      leftTop = { 476, 469 },\
      rightTop = nil,\
      leftBotton = nil,\
      rightBotton = nil,\
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的\
      positionMap = {\
        { { 476, 469, 0x31313a }, { 644, 469, 0x191c29 }, { 813, 469, 0x212031 }, { 983, 469, 0x313129 }, { 1152, 469, 0x211c29 }, { 1321, 469, 0x292431 }, { 1490, 469, 0x3a3531 }, },\
        { { 455, 590, 0x000000 }, { 632, 590, 0x84556b }, { 808, 590, 0x84595a }, { 984, 590, 0x735152 }, { 1160, 590, 0x845d52 }, { 1336, 590, 0x846152 }, { 1513, 590, 0x000000 }, },\
        { { 434, 722, 0x000000 }, { 618, 722, 0x524152 }, { 801, 722, 0x5a454a }, { 985, 722, 0x6b494a }, { 1169, 722, 0x946d5a }, { 1352, 722, 0x7b5552 }, { 1536, 722, 0x000000 }, },\
        { { 411, 866, 0x000000 }, { 603, 866, 0x5a415a }, { 794, 866, 0x523942 }, { 986, 866, 0x422842 }, { 1177, 866, 0x523942 }, { 1369, 866, 0x734942 }, { 1562, 866, 0x000000 }, },\
      },\
      pointMap = {},\
    },\
    {\
      leftTop = nil,\
      rightTop = nil,\
      leftBotton = { 407, 914 },\
      rightBotton = nil,\
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的\
      positionMap = {\
        false, false, false,\
        { { 480, 456, 0x000000 }, { 670, 456, 0x523952 }, { 862, 456, 0x523942 }, { 1052, 456, 0x846963 }, { 1245, 456, 0x523942 }, { 1437, 456, 0x734942 }, { 1631, 456, 0x000000 }, },\
        { { 457, 594, 0xdeba10 }, { 657, 594, 0x4a355a }, { 858, 594, 0x423152 }, { 1058, 594, 0x3a243a }, { 1258, 594, 0x4a2d42 }, { 1459, 594, 0x63414a }, { 1662, 594, 0x000000 }, },\
        { { 434, 745, 0x000000 }, { 642, 745, 0x29243a }, { 852, 745, 0x292031 }, { 1062, 745, 0x212031 }, { 1273, 745, 0x312042 }, { 1483, 745, 0x42283a }, { 1696, 745, 0x000000 }, },\
        { { 407, 914, 0x000000 }, { 627, 914, 0x000000 }, { 847, 914, 0x000000 }, { 1068, 914, 0x000000 }, { 1289, 914, 0x000000 }, { 1510, 914, 0x100c10 }, { 1735, 914, 0x080c08 }, },\
      },\
      pointMap = {},\
    },\
  }\
  for key = 1, #list do\
    local positionMap = list[key].positionMap\
    for rowNum, rol in ipairs(positionMap) do\
      if rol and positionMap[rowNum + 1] then\
        for colNum, col in ipairs(rol) do\
          if col and rol[colNum + 1] then\
            list[key].pointMap[rowNum .. '-' .. colNum] = col\
          end\
        end\
      end\
    end\
  end\
  return list\
end\
\
-- 获取地图棋盘和相关数据\
mapEvent.getMapChessboard = function()\
  return {\
    width = 6,\
    height = 6,\
    obstacle = {\
      { 1, 1 }, { 1, 2 }, { 1, 3 },\
      { 5, 1 }, { 5, 2 },\
      { 6, 1 }, { 6, 2 },\
    },\
    waitForBossPosition = { { 4, 6 }, { 6, 4 } },\
    bossPosition = {},\
    myFleetList = {},\
    enemyPositionList1 = {},\
    enemyPositionList2 = {},\
    enemyPositionList3 = {},\
    inBattleList = {},\
    selectedArrowList = {},\
    rewardBoxList = {},\
  }\
end\
\
return mapEvent" }


package.sourceCode = package.sourceCode or {}
package.sourceCode["./meta-operation/maps-options/map4-1.lua"] = { path = "./meta-operation/maps-options/map4-1.lua", name = "./meta-operation/maps-options/map4-1.lua", source = "local mapBase = require './map'\
local imgEvent = require './img4-1'\
local mapEvent = {}\
\
-- 从mapBase继承方法\
mapEvent = table.assign(mapEvent, mapBase)\
for key, value in pairs(mapBase) do\
  if type(value) == 'function' then\
    mapEvent[key] = function(...)\
      return value(imgEvent, ...)\
    end\
  end\
end\
\
-- 获取地图采样位置。由于地图可能超出一屏，所以这里可以定义多个采样位置。每次扫描都会对每个采样位置进行扫描\
-- 标志位为地图四个角。每个采样位置只需定义一个角的坐标即可。\
-- 还需要定义每个采样位置的地图矩阵与屏幕坐标的映射关系\
mapEvent.getCheckpositionList = function()\
  local list = {\
    {\
      leftTop = nil,\
      rightTop = { 1576, 536 },\
      leftBotton = nil,\
      rightBotton = nil,\
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的\
      positionMap = {\
        { { 561, 536, 0xa47508 }, { 729, 536, 0x3a3131 }, { 899, 536, 0x292429 }, { 1068, 536, 0x292431 }, { 1237, 536, 0x322d32 }, { 1407, 536, 0x3a3531 }, { 1576, 536, 0x213921 }, },\
        { { 545, 660, 0x000000 }, { 720, 660, 0x73455a }, { 896, 660, 0x84595a }, { 1072, 660, 0x735152 }, { 1248, 660, 0x845d52 }, { 1424, 660, 0x846152 }, { 1603, 660, 0x000000 }, },\
        { { 528, 795, 0x000000 }, { 710, 795, 0x423542 }, { 893, 795, 0x63494a }, { 1077, 795, 0x6b4d4a }, { 1260, 795, 0x6b5142 }, { 1444, 795, 0x634d42 }, { 1630, 795, 0x000000 }, },\
        { { 509, 941, 0x000000 }, { 699, 941, 0x4a394a }, { 890, 941, 0x42353a }, { 1080, 941, 0x7b615a }, { 1274, 941, 0x4a353a }, { 1465, 941, 0x292021 }, { 1659, 941, 0x100c10 }, },\
      },\
      pointMap = {},\
    },\
    {\
      leftTop = nil,\
      rightTop = nil,\
      leftBotton = nil,\
      rightBotton = { 1725, 889 },\
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的\
      positionMap = {\
        false, false, false,\
        { { 473, 434, 0x000000 }, { 663, 434, 0x312431 }, { 855, 434, 0x4a3542 }, { 1044, 434, 0x846963 }, { 1237, 434, 0x523942 }, { 1430, 434, 0x73514a }, { 1623, 434, 0x000000 }, },\
        { { 450, 571, 0x000000 }, { 649, 571, 0x4a355a }, { 849, 571, 0x3a354a }, { 1050, 571, 0x212029 }, { 1250, 571, 0x3a2831 }, { 1451, 571, 0x6b414a }, { 1654, 571, 0x000000 }, },\
        { { 425, 721, 0x000000 }, { 634, 721, 0x29243a }, { 844, 721, 0x292031 }, { 1054, 721, 0x212031 }, { 1264, 721, 0x211c29 }, { 1475, 721, 0x42283a }, { 1688, 721, 0x000000 }, },\
        { { 398, 889, 0x000000 }, { 618, 889, 0x000000 }, { 838, 889, 0x000000 }, { 1059, 889, 0x000000 }, { 1281, 889, 0x000000 }, { 1501, 889, 0x000000 }, { 1725, 889, 0x000000 }, },\
      },\
      pointMap = {},\
    },\
  }\
  for key = 1, #list do\
    local positionMap = list[key].positionMap\
    for rowNum, rol in ipairs(positionMap) do\
      if rol and positionMap[rowNum + 1] then\
        for colNum, col in ipairs(rol) do\
          if col and rol[colNum + 1] then\
            list[key].pointMap[rowNum .. '-' .. colNum] = col\
          end\
        end\
      end\
    end\
  end\
  return list\
end\
\
-- 获取地图棋盘和相关数据\
mapEvent.getMapChessboard = function()\
  return {\
    width = 6,\
    height = 6,\
    obstacle = {\
      { 3, 3 }, { 3, 4 },\
      { 4, 4 },\
      { 6, 3 }, { 6, 4 }, { 6, 5 }, { 6, 6 },\
    },\
    waitForBossPosition = { { 4, 3 }, { 6, 2 } },\
    bossPosition = {},\
    myFleetList = {},\
    enemyPositionList1 = {},\
    enemyPositionList2 = {},\
    enemyPositionList3 = {},\
    inBattleList = {},\
    selectedArrowList = {},\
    rewardBoxList = {},\
  }\
end\
\
return mapEvent" }


package.sourceCode = package.sourceCode or {}
package.sourceCode["./meta-operation/maps-options/map3-4.lua"] = { path = "./meta-operation/maps-options/map3-4.lua", name = "./meta-operation/maps-options/map3-4.lua", source = "local mapBase = require './map'\
local imgEvent = require './img3-4'\
local mapEvent = {}\
\
-- 从mapBase继承方法\
mapEvent = table.assign(mapEvent, mapBase)\
for key, value in pairs(mapBase) do\
  if type(value) == 'function' then\
    mapEvent[key] = function(...)\
      return value(imgEvent, ...)\
    end\
  end\
end\
\
-- 获取地图采样位置。由于地图可能超出一屏，所以这里可以定义多个采样位置。每次扫描都会对每个采样位置进行扫描\
-- 标志位为地图四个角。每个采样位置只需定义一个角的坐标即可。\
-- 还需要定义每个采样位置的地图矩阵与屏幕坐标的映射关系\
mapEvent.getCheckpositionList = function()\
  local list = {\
    {\
      leftTop = { 290, 559 },\
      rightTop = nil,\
      leftBotton = nil,\
      rightBotton = nil,\
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的\
      positionMap = {\
        { { 290, 559, 0x19283a }, { 473, 559, 0x213d42 }, { 657, 559, 0x193142 }, { 840, 559, 0x193142 }, { 1024, 559, 0x213d4a }, { 1207, 559, 0x212442 }, { 1391, 559, 0x212842 }, { 1575, 559, 0x294152 }, { 1758, 559, 0x10203a }, },\
        { { 260, 695, 0x000000 }, { 452, 695, 0x197984 }, { 643, 695, 0x298194 }, { 835, 695, 0x218194 }, { 1027, 695, 0x217184 }, { 1218, 695, 0x19718c }, { 1410, 693, 0xd6657b }, { 1602, 694, 0x427d7b }, { 1794, 695, 0x000000 }, },\
        { { 228, 844, 0x000000 }, { 428, 844, 0x217d8c }, { 630, 844, 0xd6a608 }, { 829, 844, 0x106d84 }, { 1030, 844, 0x215984 }, { 1230, 844, 0x215184 }, { 1431, 844, 0x195d84 }, { 1631, 844, 0x19658c }, { 1833, 844, 0x000000 }, },\
      },\
      pointMap = {},\
    },\
    {\
      leftTop = nil,\
      rightTop = nil,\
      leftBotton = { 363, 862 },\
      rightBotton = nil,\
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的\
      positionMap = {\
        false,\
        false,\
        { { 418, 547, 0x000000 }, { 618, 547, 0x19798c }, { 819, 547, 0x318194 }, { 1019, 547, 0x217184 }, { 1220, 547, 0x085173 }, },\
        { { 391, 697, 0x000000 }, { 602, 697, 0x216184 }, { 812, 697, 0x19618c }, { 1022, 697, 0x08517b }, { 1233, 697, 0x21457b }, },\
        { { 363, 862, 0x000000 }, { 583, 862, 0x000000 }, { 804, 862, 0x000000 }, { 1025, 862, 0x000000 }, { 1246, 862, 0x000000 }, },\
      },\
      pointMap = {},\
    },\
    {\
      leftTop = nil,\
      rightTop = nil,\
      leftBotton = nil,\
      rightBotton = { 1736, 856, },\
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的\
      positionMap = {\
        false,\
        false,\
        { false, false, false, false, { 861, 542, 0x08597b }, { 1062, 542, 0x21518c }, { 1262, 542, 0x21618c }, { 1463, 542, 0x19658c }, { 1664, 542, 0x000000 }, },\
        { false, false, false, false, { 857, 691, 0x10457b }, { 1067, 691, 0x214984 }, { 1277, 691, 0x214d7c }, { 1487, 691, 0x314d7b }, { 1699, 691, 0x000000 }, },\
        { false, false, false, false, { 851, 856, 0x000000 }, { 1072, 856, 0x000000 }, { 1293, 856, 0x000000 }, { 1514, 856, 0x000000 }, { 1736, 856, 0x000000 }, },\
      },\
      pointMap = {},\
    },\
  }\
  for key = 1, #list do\
    local positionMap = list[key].positionMap\
    for rowNum, rol in ipairs(positionMap) do\
      if rol and positionMap[rowNum + 1] then\
        for colNum, col in ipairs(rol) do\
          if col and rol[colNum + 1] then\
            list[key].pointMap[rowNum .. '-' .. colNum] = col\
          end\
        end\
      end\
    end\
  end\
  return list\
end\
\
-- 获取地图棋盘和相关数据\
mapEvent.getMapChessboard = function()\
  return {\
    width = 8,\
    height = 4,\
    obstacle = {\
      { 1, 6 }, { 1, 7 }, { 1, 8 },\
      { 2, 7 }, { 2, 8 },\
      { 3, 1 },\
    },\
    waitForBossPosition = { { 3, 8 } },\
    bossPosition = {},\
    myFleetList = {},\
    enemyPositionList1 = {},\
    enemyPositionList2 = {},\
    enemyPositionList3 = {},\
    inBattleList = {},\
    selectedArrowList = {},\
    rewardBoxList = {},\
  }\
end\
\
return mapEvent\
" }


package.sourceCode = package.sourceCode or {}
package.sourceCode["./meta-operation/maps-options/map3-3.lua"] = { path = "./meta-operation/maps-options/map3-3.lua", name = "./meta-operation/maps-options/map3-3.lua", source = "local mapBase = require './map'\
local imgEvent = require './img3-3'\
local mapEvent = {}\
\
-- 从mapBase继承方法\
mapEvent = table.assign(mapEvent, mapBase)\
for key, value in pairs(mapBase) do\
  if type(value) == 'function' then\
    mapEvent[key] = function(...)\
      return value(imgEvent, ...)\
    end\
  end\
end\
\
-- 获取地图采样位置。由于地图可能超出一屏，所以这里可以定义多个采样位置。每次扫描都会对每个采样位置进行扫描\
-- 标志位为地图四个角。每个采样位置只需定义一个角的坐标即可。\
-- 还需要定义每个采样位置的地图矩阵与屏幕坐标的映射关系\
mapEvent.getCheckpositionList = function()\
  local list = {\
    {\
      leftTop = { 540, 476 },\
      rightTop = nil,\
      leftBotton = nil,\
      rightBotton = nil,\
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的\
      positionMap = {\
        { { 540, 476, 0x314152 }, { 702, 476, 0x21354a }, { 865, 476, 0x212842 }, { 1028, 476, 0x29314a }, { 1191, 476, 0x213542 }, { 1354, 476, 0x21354a }, { 1518, 476, 0x21314a }, },\
        { { 524, 593, 0x000000 }, { 692, 593, 0x19798c }, { 861, 593, 0x218194 }, { 1030, 593, 0x197984 }, { 1200, 593, 0x217d94 }, { 1369, 593, 0x298194 }, { 1540, 593, 0x000000 }, },\
        { { 506, 719, 0x000000 }, { 682, 719, 0x4a8a73 }, { 857, 719, 0x107d8c }, { 1033, 719, 0x196184 }, { 1209, 719, 0x196984 }, { 1386, 719, 0x196184 }, { 1564, 719, 0x000000 }, },\
        { { 487, 856, 0x000000 }, { 669, 856, 0x296d94 }, { 853, 856, 0x19658c }, { 1037, 856, 0x105173 }, { 1220, 856, 0x214984 }, { 1404, 856, 0x29618c }, { 1592, 856, 0x843908 }, },\
      },\
      pointMap = {},\
    },\
    {\
      leftTop = nil,\
      rightTop = nil,\
      leftBotton = { 450, 880 },\
      rightBotton = nil,\
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的\
      positionMap = {\
        false, false, false,\
        { { 493, 590, 0x000000 }, { 676, 590, 0x316d94 }, { 859, 590, 0x19658c }, { 1043, 590, 0x085173 }, { 1226, 590, 0x214d8c }, { 1410, 590, 0x29618c }, { 1595, 590, 0x000000 }, },\
        { { 473, 727, 0x000000 }, { 663, 727, 0x216994 }, { 855, 727, 0x215d8c }, { 1046, 727, 0x003d6b }, { 1238, 727, 0x10416b }, { 1429, 727, 0x214d7b }, { 1623, 727, 0x000000 }, },\
        { { 450, 880, 0x000000 }, { 649, 880, 0x000000 }, { 850, 880, 0x000000 }, { 1050, 880, 0x000000 }, { 1251, 880, 0x000000 }, { 1451, 880, 0x000000 }, { 1654, 880, 0x000000 }, },\
      },\
      pointMap = {},\
    },\
  }\
  for key = 1, #list do\
    local positionMap = list[key].positionMap\
    for rowNum, rol in ipairs(positionMap) do\
      if rol and positionMap[rowNum + 1] then\
        for colNum, col in ipairs(rol) do\
          if col and rol[colNum + 1] then\
            list[key].pointMap[rowNum .. '-' .. colNum] = col\
          end\
        end\
      end\
    end\
  end\
  return list\
end\
\
-- 获取地图棋盘和相关数据\
mapEvent.getMapChessboard = function()\
  return {\
    width = 7,\
    height = 4,\
    obstacle = {\
      { 1, 1 }, { 1, 2 }, { 1, 4 }, { 1, 5 },\
      { 2, 1 }, { 2, 2 }, { 3, 2 }\
    },\
    waitForBossPosition = { { 4, 1 } },\
    bossPosition = {},\
    myFleetList = {},\
    enemyPositionList1 = {},\
    enemyPositionList2 = {},\
    enemyPositionList3 = {},\
    inBattleList = {},\
    selectedArrowList = {},\
    rewardBoxList = {},\
  }\
end\
\
return mapEvent" }


package.sourceCode = package.sourceCode or {}
package.sourceCode["./meta-operation/maps-options/map3-2.lua"] = { path = "./meta-operation/maps-options/map3-2.lua", name = "./meta-operation/maps-options/map3-2.lua", source = "local mapBase = require './map'\
local imgEvent = require './img3-2'\
local mapEvent = {}\
\
-- 从mapBase继承方法\
mapEvent = table.assign(mapEvent, mapBase)\
for key, value in pairs(mapBase) do\
  if type(value) == 'function' then\
    mapEvent[key] = function(...)\
      return value(imgEvent, ...)\
    end\
  end\
end\
\
-- 获取地图采样位置。由于地图可能超出一屏，所以这里可以定义多个采样位置。每次扫描都会对每个采样位置进行扫描\
-- 标志位为地图四个角。每个采样位置只需定义一个角的坐标即可。\
-- 还需要定义每个采样位置的地图矩阵与屏幕坐标的映射关系\
mapEvent.getCheckpositionList = function()\
  local list = {\
    {\
      leftTop = { 348, 478 },\
      rightTop = nil,\
      leftBotton = nil,\
      rightBotton = nil,\
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的\
      positionMap = {\
        { { 348, 478, 0x29394a }, { 523, 478, 0x21314a }, { 699, 478, 0x213142 }, { 876, 478, 0x21314a }, { 1052, 478, 0x29394a }, { 1228, 478, 0x212842 }, { 1404, 478, 0x29394a }, { 1580, 478, 0x21354a }, { 1758, 478, 0x212842 }, },\
        { { 323, 605, 0x000000 }, { 505, 605, 0x217994 }, { 689, 605, 0x298194 }, { 872, 605, 0x19798c }, { 1055, 605, 0x10718c }, { 1239, 605, 0x19758c }, { 1422, 605, 0x197184 }, { 1606, 605, 0x197984 }, { 1792, 605, 0x000000 }, },\
        { { 295, 743, 0x000000 }, { 488, 743, 0x428673 }, { 677, 743, 0x318194 }, { 868, 743, 0x086984 }, { 1060, 743, 0x085173 }, { 1251, 743, 0x215184 }, { 1444, 743, 0xce5d73 }, { 1637, 745, 0x63a684 }, { 1828, 743, 0x000000 }, },\
        { { 264, 894, 0x000000 }, { 463, 894, 0x296194 }, { 664, 894, 0x29658c }, { 864, 894, 0x215d84 }, { 1065, 894, 0x004173 }, { 1265, 894, 0x104973 }, { 1466, 894, 0x21518c }, { 1666, 894, 0x31518c }, { 1868, 894, 0x000001 }, },\
      },\
      pointMap = {},\
    },\
    {\
      leftTop = nil,\
      rightTop = nil,\
      leftBotton = { 237, 880 },\
      rightBotton = nil,\
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的\
      positionMap = {\
        false, false, false,\
        { { 270, 721, 0x000000 }, { 470, 721, 0x216184 }, { 670, 721, 0x196184 }, { 871, 721, 0x105d84 }, { 1071, 721, 0x10417b }, { 1271, 721, 0x10497b }, { 1472, 721, 0x19497b }, { 1672, 721, 0x214573 }, { 1875, 721, 0x000000 }, },\
        { { 237, 880, 0x000000 }, { 446, 880, 0x000000 }, { 656, 880, 0x000000 }, { 866, 880, 0x000000 }, { 1077, 880, 0x000000 }, { 1287, 880, 0x000000 }, { 1497, 880, 0x000000 }, { 1707, 880, 0x000000 }, { 1919, 880, 0x000000 }, },\
      },\
      pointMap = {},\
    },\
  }\
  for key = 1, #list do\
    local positionMap = list[key].positionMap\
    for rowNum, rol in ipairs(positionMap) do\
      if rol and positionMap[rowNum + 1] then\
        for colNum, col in ipairs(rol) do\
          if col and rol[colNum + 1] then\
            list[key].pointMap[rowNum .. '-' .. colNum] = col\
          end\
        end\
      end\
    end\
  end\
  return list\
end\
\
-- 获取地图棋盘和相关数据\
mapEvent.getMapChessboard = function()\
  return {\
    width = 8,\
    height = 4,\
    obstacle = {\
      { 2, 1 }, { 2, 2 }, { 3, 2 },\
      { 2, 6 }, { 2, 7 }, { 2, 8 },\
      { 3, 7 }, { 3, 8 }, { 4, 8 },\
    },\
    waitForBossPosition = { { 1, 8 } },\
    bossPosition = {},\
    myFleetList = {},\
    enemyPositionList1 = {},\
    enemyPositionList2 = {},\
    enemyPositionList3 = {},\
    inBattleList = {},\
    selectedArrowList = {},\
    rewardBoxList = {},\
  }\
end\
\
return mapEvent" }


package.sourceCode = package.sourceCode or {}
package.sourceCode["./meta-operation/maps-options/map3-1.lua"] = { path = "./meta-operation/maps-options/map3-1.lua", name = "./meta-operation/maps-options/map3-1.lua", source = "local mapBase = require './map'\
local imgEvent = require './img3-1'\
local mapEvent = {}\
\
-- 从mapBase继承方法\
mapEvent = table.assign(mapEvent, mapBase)\
for key, value in pairs(mapBase) do\
  if type(value) == 'function' then\
    mapEvent[key] = function(...)\
      return value(imgEvent, ...)\
    end\
  end\
end\
\
-- 获取地图采样位置。由于地图可能超出一屏，所以这里可以定义多个采样位置。每次扫描都会对每个采样位置进行扫描\
-- 标志位为地图四个角。每个采样位置只需定义一个角的坐标即可。\
-- 还需要定义每个采样位置的地图矩阵与屏幕坐标的映射关系\
mapEvent.getCheckpositionList = function()\
  local list = {\
    {\
      leftTop = { 412, 434, },\
      rightTop = nil,\
      leftBotton = nil,\
      rightBotton = nil,\
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的\
      positionMap = {\
        { { 412, 434, 0x314552 }, { 594, 434, 0x3a4552 }, { 778, 434, 0x313d52 }, { 961, 434, 0x293d4a }, { 1145, 434, 0x21394a }, { 1329, 434, 0x21394a }, { 1512, 434, 0x313d52 }, { 1698, 434, 0x313d52 }, },\
        { { 388, 564, 0x000000 }, { 578, 564, 0x21799c }, { 770, 564, 0x218194 }, { 962, 564, 0x218194 }, { 1153, 564, 0x196d8c }, { 1345, 564, 0x197994 }, { 1536, 564, 0x297d94 }, { 1730, 564, 0x000000 }, },\
        { { 361, 707, 0x000000 }, { 561, 707, 0x19798c }, { 761, 707, 0x31818c }, { 962, 707, 0x00597b }, { 1162, 707, 0x104d7b }, { 1363, 707, 0x295584 }, { 1563, 707, 0x217d94 }, { 1766, 707, 0x000000 }, },\
        { { 332, 864, 0x000000 }, { 542, 864, 0x4a8a7b }, { 752, 864, 0x216994 }, { 962, 864, 0x215183 }, { 1172, 864, 0x21518c }, { 1382, 864, 0x215184 }, { 1592, 864, 0x31518c }, { 1805, 864, 0x000000 }, },\
      },\
      pointMap = {},\
    },\
    {\
      leftTop = nil,\
      rightTop = nil,\
      leftBotton = nil,\
      rightBotton = { 1709, 883 },\
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的\
      positionMap = {\
        false, false, false,\
        { { 200, 716, 0x000000 }, { 407, 716, 0x63b684 }, { 620, 716, 0x216994 }, { 830, 716, 0x215184 }, { 1040, 716, 0x21518c }, { 1250, 716, 0x215184 }, { 1460, 716, 0x31518c }, { 1673, 716, 0x000000 }, },\
        { { 161, 883, 0x000000 }, { 381, 883, 0x000000 }, { 602, 883, 0x000000 }, { 823, 883, 0x000000 }, { 1044, 883, 0x000000 }, { 1265, 883, 0x000000 }, { 1486, 883, 0x000000 }, { 1709, 883, 0x000000 }, },\
      },\
      pointMap = {},\
    },\
  }\
  for key = 1, #list do\
    local positionMap = list[key].positionMap\
    for rowNum, rol in ipairs(positionMap) do\
      if rol and positionMap[rowNum + 1] then\
        for colNum, col in ipairs(rol) do\
          if col and rol[colNum + 1] then\
            list[key].pointMap[rowNum .. '-' .. colNum] = col\
          end\
        end\
      end\
    end\
  end\
  return list\
end\
\
-- 获取地图棋盘和相关数据\
mapEvent.getMapChessboard = function()\
  return {\
    width = 7,\
    height = 4,\
    obstacle = {\
      { 3, 1 }, { 3, 2 }, { 4, 1 }, { 4, 2 },\
      { 4, 6 }, { 4, 7 },\
    },\
    waitForBossPosition = { { 1, 7 } },\
    bossPosition = {},\
    myFleetList = {},\
    enemyPositionList1 = {},\
    enemyPositionList2 = {},\
    enemyPositionList3 = {},\
    inBattleList = {},\
    selectedArrowList = {},\
    rewardBoxList = {},\
  }\
end\
\
return mapEvent" }


package.sourceCode = package.sourceCode or {}
package.sourceCode["./meta-operation/maps-options/map2-4.lua"] = { path = "./meta-operation/maps-options/map2-4.lua", name = "./meta-operation/maps-options/map2-4.lua", source = "local mapBase = require './map'\
local imgEvent = require './img2-4'\
local mapEvent = {}\
\
-- 从mapBase继承方法\
mapEvent = table.assign(mapEvent, mapBase)\
for key, value in pairs(mapBase) do\
  if type(value) == 'function' then\
    mapEvent[key] = function(...)\
      return value(imgEvent, ...)\
    end\
  end\
end\
\
-- 获取地图采样位置。由于地图可能超出一屏，所以这里可以定义多个采样位置。每次扫描都会对每个采样位置进行扫描\
-- 标志位为地图四个角。每个采样位置只需定义一个角的坐标即可。\
-- 还需要定义每个采样位置的地图矩阵与屏幕坐标的映射关系\
mapEvent.getCheckpositionList = function()\
  local list = {\
    {\
      leftTop = { 437, 493 },\
      rightTop = nil,\
      leftBotton = nil,\
      rightBotton = nil,\
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的\
      positionMap = {\
        { { 437, 493, 0x315152 }, { 614, 493, 0x213942 }, { 790, 493, 0x105d73 }, { 969, 493, 0x213d4a }, { 1146, 493, 0x193142 }, { 1324, 493, 0x212d3a }, { 1501, 493, 0x213142 }, { 1678, 493, 0x19283a }, },\
        { { 416, 632, 0x000000 }, { 601, 632, 0x197994 }, { 785, 632, 0x197d8c }, { 969, 632, 0x197d94 }, { 1153, 632, 0x196d8c }, { 1338, 632, 0x217d9c }, { 1522, 632, 0x217d94 }, { 1707, 632, 0x000000 }, },\
        { { 394, 783, 0x000000 }, { 586, 783, 0x19758c }, { 778, 783, 0x21798c }, { 969, 783, 0x105d84 }, { 1161, 783, 0x104d7b }, { 1353, 783, 0x215584 }, { 1544, 783, 0x197584 }, { 1737, 783, 0x000000 }, },\
      },\
      pointMap = {},\
    },\
    {\
      leftTop = nil,\
      rightTop = nil,\
      leftBotton = { 341, 888 },\
      rightBotton = nil,\
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的\
      positionMap = {\
        false, false,\
        { { 390, 565, 0x000000 }, { 581, 565, 0x21798c }, { 773, 565, 0x318194 }, { 965, 565, 0x215d84 }, { 1156, 565, 0x104d7b }, { 1348, 565, 0x195184 }, { 1539, 565, 0x217994 }, { 1732, 565, 0x000000 }, },\
        { { 366, 720, 0x000000 }, { 567, 720, 0xdeae00 }, { 765, 720, 0x19698c }, { 965, 720, 0x104d73 }, { 1165, 720, 0x10497b }, { 1364, 720, 0x21518c }, { 1562, 716, 0xada6a4 }, { 1765, 720, 0x63a684 }, },\
        { { 341, 888, 0x000000 }, { 548, 888, 0x000000 }, { 757, 888, 0x000000 }, { 965, 888, 0x000000 }, { 1173, 888, 0x000000 }, { 1382, 888, 0x000000 }, { 1590, 888, 0x000000 }, { 1799, 888, 0x000000 }, },\
      },\
      pointMap = {},\
    },\
  }\
  for key = 1, #list do\
    local positionMap = list[key].positionMap\
    for rowNum, rol in ipairs(positionMap) do\
      if rol and positionMap[rowNum + 1] then\
        for colNum, col in ipairs(rol) do\
          if col and rol[colNum + 1] then\
            list[key].pointMap[rowNum .. '-' .. colNum] = col\
          end\
        end\
      end\
    end\
  end\
  return list\
end\
\
-- 获取地图棋盘和相关数据\
mapEvent.getMapChessboard = function()\
  return {\
    width = 7,\
    height = 4,\
    obstacle = {\
      { 1, 2 }, { 1, 3 }, { 1, 4 },\
      { 3, 6 }, { 3, 7 }, { 4, 7 },\
    },\
    waitForBossPosition = { { 1, 7 } },\
    bossPosition = {},\
    myFleetList = {},\
    enemyPositionList1 = {},\
    enemyPositionList2 = {},\
    enemyPositionList3 = {},\
    inBattleList = {},\
    selectedArrowList = {},\
    rewardBoxList = {},\
  }\
end\
\
return mapEvent" }


package.sourceCode = package.sourceCode or {}
package.sourceCode["./meta-operation/maps-options/map2-3.lua"] = { path = "./meta-operation/maps-options/map2-3.lua", name = "./meta-operation/maps-options/map2-3.lua", source = "local mapBase = require './map'\
local imgEvent = require './img2-3'\
local mapEvent = {}\
\
-- 从mapBase继承方法\
mapEvent = table.assign(mapEvent, mapBase)\
for key, value in pairs(mapBase) do\
  if type(value) == 'function' then\
    mapEvent[key] = function(...)\
      return value(imgEvent, ...)\
    end\
  end\
end\
\
-- 获取地图采样位置。由于地图可能超出一屏，所以这里可以定义多个采样位置。每次扫描都会对每个采样位置进行扫描\
-- 标志位为地图四个角。每个采样位置只需定义一个角的坐标即可。\
-- 还需要定义每个采样位置的地图矩阵与屏幕坐标的映射关系\
mapEvent.getCheckpositionList = function()\
  local list = {\
    {\
      leftTop = { 493, 502 },\
      rightTop = nil,\
      leftBotton = nil,\
      rightBotton = nil,\
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的\
      positionMap = {\
        { { 493, 502, 0x21414a }, { 660, 502, 0x294552 }, { 830, 502, 0x314552 }, { 999, 502, 0x293d4a }, { 1168, 502, 0x294552 }, { 1338, 502, 0x314552 }, { 1509, 502, 0x213d4a }, },\
        { { 474, 624, 0x000000 }, { 649, 624, 0x5a6d4a }, { 825, 624, 0x197d94 }, { 1001, 624, 0x217994 }, { 1177, 624, 0x197594 }, { 1353, 624, 0x297d94 }, { 1531, 624, 0x000000 }, },\
        { { 453, 757, 0x000000 }, { 636, 757, 0x19758c }, { 819, 757, 0x107d8c }, { 1002, 757, 0x105d7b }, { 1186, 757, 0x106184 }, { 1371, 756, 0x5a9e7b }, { 1555, 757, 0x000000 }, },\
        { { 431, 903, 0x000000 }, { 621, 903, 0x296d94 }, { 812, 903, 0x196184 }, { 1004, 903, 0x084d73 }, { 1196, 903, 0x194173 }, { 1387, 903, 0x295d8c }, { 1582, 903, 0x000000 }, },\
      },\
      pointMap = {},\
    },\
    {\
      leftTop = nil,\
      rightTop = nil,\
      leftBotton = { 413, 902 },\
      rightBotton = nil,\
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的\
      positionMap = {\
        false, false, false,\
        { { 462, 597, 0x000000 }, { 652, 597, 0x21698c }, { 843, 597, 0x19698c }, { 1035, 597, 0x10517b }, { 1226, 597, 0x19416b }, { 1419, 597, 0x295d8c }, { 1612, 597, 0x000000 }, },\
        { { 439, 741, 0x000000 }, { 638, 741, 0x10698c }, { 838, 741, 0x085984 }, { 1038, 741, 0x003d63 }, { 1239, 741, 0x10417b }, { 1439, 741, 0x214d7b }, { 1642, 741, 0x000000 }, },\
        { { 413, 902, 0x000000 }, { 622, 902, 0x000000 }, { 833, 902, 0x000000 }, { 1042, 902, 0x000000 }, { 1252, 902, 0x000000 }, { 1462, 902, 0x000000 }, { 1676, 902, 0x000000 }, },\
      },\
      pointMap = {},\
    },\
  }\
  for key = 1, #list do\
    local positionMap = list[key].positionMap\
    for rowNum, rol in ipairs(positionMap) do\
      if rol and positionMap[rowNum + 1] then\
        for colNum, col in ipairs(rol) do\
          if col and rol[colNum + 1] then\
            list[key].pointMap[rowNum .. '-' .. colNum] = col\
          end\
        end\
      end\
    end\
  end\
  return list\
end\
\
-- 获取地图棋盘和相关数据\
mapEvent.getMapChessboard = function()\
  return {\
    width = 6,\
    height = 5,\
    obstacle = {\
      { 1, 6 },\
      { 2, 5 }, { 2, 6 },\
      { 3, 6 },\
      { 5, 1 }, { 5, 2 }, { 5, 3 },\
    },\
    waitForBossPosition = { { 1, 5 } },\
    bossPosition = {},\
    myFleetList = {},\
    enemyPositionList1 = {},\
    enemyPositionList2 = {},\
    enemyPositionList3 = {},\
    inBattleList = {},\
    selectedArrowList = {},\
    rewardBoxList = {},\
  }\
end\
\
return mapEvent" }


package.sourceCode = package.sourceCode or {}
package.sourceCode["./meta-operation/maps-options/map2-2.lua"] = { path = "./meta-operation/maps-options/map2-2.lua", name = "./meta-operation/maps-options/map2-2.lua", source = "local mapBase = require './map'\
local imgEvent = require './img2-2'\
local mapEvent = {}\
\
-- 从mapBase继承方法\
mapEvent = table.assign(mapEvent, mapBase)\
for key, value in pairs(mapBase) do\
  if type(value) == 'function' then\
    mapEvent[key] = function(...)\
      return value(imgEvent, ...)\
    end\
  end\
end\
\
-- 获取地图采样位置。由于地图可能超出一屏，所以这里可以定义多个采样位置。每次扫描都会对每个采样位置进行扫描\
-- 标志位为地图四个角。每个采样位置只需定义一个角的坐标即可。\
-- 还需要定义每个采样位置的地图矩阵与屏幕坐标的映射关系\
mapEvent.getCheckpositionList = function()\
  local list = {\
    {\
      leftTop = { 436, 498 },\
      rightTop = nil,\
      leftBotton = nil,\
      rightBotton = nil,\
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的\
      positionMap = {\
        { { 436, 498, 0x294552 }, { 604, 498, 0x293d52 }, { 773, 498, 0x21394a }, { 942, 498, 0x29354a }, { 1112, 498, 0x21354a }, { 1273, 498, 0x19aac5 }, { 1450, 498, 0x313d52 }, { 1621, 498, 0x294152 }, },\
        { { 415, 619, 0x000000 }, { 591, 619, 0x52967b }, { 766, 619, 0x427d73 }, { 941, 619, 0x218a9c }, { 1117, 619, 0x21718c }, { 1295, 619, 0xf7718c }, { 1470, 619, 0x4a8e73 }, { 1648, 619, 0x000000 }, },\
        { { 392, 753, 0x000000 }, { 574, 753, 0x4a4510 }, { 757, 753, 0x298194 }, { 941, 753, 0x318194 }, { 1124, 753, 0x10597b }, { 1308, 753, 0x19698c }, { 1491, 753, 0x19718c }, { 1677, 753, 0x000000 }, },\
        { { 366, 898, 0x000000 }, { 557, 898, 0x296d8c }, { 748, 898, 0x217594 }, { 938, 898, 0x1961a4 }, { 1131, 898, 0x084973 }, { 1323, 898, 0x294973 }, { 1515, 898, 0x295984 }, { 1709, 898, 0x000000 }, },\
      },\
      pointMap = {},\
    },\
    {\
      leftTop = nil,\
      rightTop = nil,\
      leftBotton = { 268, 903 },\
      rightBotton = nil,\
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的\
      positionMap = {\
        false, false, false,\
        { { 330, 598, 0x000000 }, { 520, 598, 0x3a719c }, { 712, 598, 0x3a798c }, { 903, 598, 0x084d73 }, { 1094, 598, 0x214d8c }, { 1286, 598, 0x29518c }, { 1478, 598, 0x31618c }, { 1672, 598, 0x000000 }, },\
        { { 301, 743, 0x000000 }, { 499, 743, 0x21719c }, { 700, 743, 0x196184 }, { 900, 743, 0x08496b }, { 1101, 743, 0x104173 }, { 1301, 743, 0x104d7b }, { 1502, 743, 0x21497b }, { 1705, 743, 0x000000 }, },\
        { { 268, 903, 0x000000 }, { 477, 903, 0x000000 }, { 687, 903, 0x000000 }, { 897, 903, 0x000000 }, { 1107, 903, 0x000000 }, { 1318, 903, 0x000000 }, { 1528, 903, 0x000000 }, { 1741, 903, 0x000000 }, },\
      },\
      pointMap = {},\
    },\
  }\
  for key = 1, #list do\
    local positionMap = list[key].positionMap\
    for rowNum, rol in ipairs(positionMap) do\
      if rol and positionMap[rowNum + 1] then\
        for colNum, col in ipairs(rol) do\
          if col and rol[colNum + 1] then\
            list[key].pointMap[rowNum .. '-' .. colNum] = col\
          end\
        end\
      end\
    end\
  end\
  return list\
end\
\
-- 获取地图棋盘和相关数据\
mapEvent.getMapChessboard = function()\
  return {\
    width = 7,\
    height = 5,\
    obstacle = {\
      { 1, 1 }, { 1, 2 }, { 1, 3 }, { 1, 5 }, { 1, 6 }, { 1, 7 },\
      { 2, 1 }, { 2, 2 }, { 2, 3 }, { 2, 6 }, { 2, 7 },\
    },\
    waitForBossPosition = { { 1, 4 } },\
    bossPosition = {},\
    myFleetList = {},\
    enemyPositionList1 = {},\
    enemyPositionList2 = {},\
    enemyPositionList3 = {},\
    inBattleList = {},\
    selectedArrowList = {},\
    rewardBoxList = {},\
  }\
end\
\
return mapEvent" }


package.sourceCode = package.sourceCode or {}
package.sourceCode["./meta-operation/maps-options/map2-1.lua"] = { path = "./meta-operation/maps-options/map2-1.lua", name = "./meta-operation/maps-options/map2-1.lua", source = "local mapBase = require './map'\
local imgEvent = require './img2-1'\
local mapEvent = {}\
\
-- 从mapBase继承方法\
mapEvent = table.assign(mapEvent, mapBase)\
for key, value in pairs(mapBase) do\
  if type(value) == 'function' then\
    mapEvent[key] = function(...)\
      return value(imgEvent, ...)\
    end\
  end\
end\
\
-- 获取地图采样位置。由于地图可能超出一屏，所以这里可以定义多个采样位置。每次扫描都会对每个采样位置进行扫描\
-- 标志位为地图四个角。每个采样位置只需定义一个角的坐标即可。\
-- 还需要定义每个采样位置的地图矩阵与屏幕坐标的映射关系\
mapEvent.getCheckpositionList = function()\
  local list = {\
    {\
      leftTop = { 462, 552 },\
      rightTop = nil,\
      leftBotton = nil,\
      rightBotton = nil,\
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的\
      positionMap = {\
        { { 462, 552, 0x21354a }, { 637, 552, 0x212d42 }, { 813, 552, 0x212842 }, { 990, 552, 0x21314a }, { 1166, 552, 0x21314a }, { 1342, 552, 0x21354a }, { 1520, 552, 0x293952 }, },\
        { { 442, 681, 0x000000 }, { 624, 681, 0x19798c }, { 807, 681, 0x197d8c }, { 990, 681, 0x106d84 }, { 1174, 681, 0x197584 }, { 1357, 681, 0x298194 }, { 1543, 681, 0x000000 }, },\
        { { 419, 823, 0x000000 }, { 609, 823, 0x217994 }, { 800, 823, 0x086d84 }, { 992, 823, 0x085173 }, { 1183, 823, 0x215d84 }, { 1375, 823, 0x216d8c }, { 1569, 823, 0x080c10 }, },\
      },\
      pointMap = {},\
    },\
    {\
      leftTop = nil,\
      rightTop = nil,\
      leftBotton = { 385, 905 },\
      rightBotton = nil,\
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的\
      positionMap = {\
        false, false,\
        { { 436, 599, 0x000000 }, { 626, 599, 0x19798c }, { 817, 599, 0x10718c }, { 1009, 599, 0x10597b }, { 1201, 599, 0x215984 }, { 1392, 599, 0x196984 }, { 1586, 599, 0x4a4d52 }, },\
        { { 412, 744, 0x000000 }, { 610, 744, 0x2171a4 }, { 811, 744, 0x085984 }, { 1011, 744, 0x084173 }, { 1212, 744, 0x214d8c }, { 1412, 744, 0x31518c }, { 1615, 744, 0x000000 }, },\
        { { 385, 905, 0x000000 }, { 594, 905, 0x000000 }, { 803, 905, 0x000000 }, { 1014, 905, 0x000000 }, { 1224, 905, 0x000000 }, { 1434, 905, 0x000000 }, { 1647, 905, 0x000000 }, },\
      },\
      pointMap = {},\
    },\
  }\
  for key = 1, #list do\
    local positionMap = list[key].positionMap\
    for rowNum, rol in ipairs(positionMap) do\
      if rol and positionMap[rowNum + 1] then\
        for colNum, col in ipairs(rol) do\
          if col and rol[colNum + 1] then\
            list[key].pointMap[rowNum .. '-' .. colNum] = col\
          end\
        end\
      end\
    end\
  end\
  return list\
end\
\
-- 获取地图棋盘和相关数据\
mapEvent.getMapChessboard = function()\
  return {\
    width = 6,\
    height = 4,\
    obstacle = {\
      { 2, 3 }, { 2, 4 },\
      { 3, 1 },\
      { 4, 1 }, { 4, 2 }, { 4, 3 }, { 4, 6 },\
    },\
    waitForBossPosition = { { 4, 4 } },\
    bossPosition = {},\
    myFleetList = {},\
    enemyPositionList1 = {},\
    enemyPositionList2 = {},\
    enemyPositionList3 = {},\
    inBattleList = {},\
    selectedArrowList = {},\
    rewardBoxList = {},\
  }\
end\
\
return mapEvent" }


package.sourceCode = package.sourceCode or {}
package.sourceCode["./meta-operation/maps-options/map1-4.lua"] = { path = "./meta-operation/maps-options/map1-4.lua", name = "./meta-operation/maps-options/map1-4.lua", source = "local mapBase = require './map'\
local imgEvent = require './img1-4'\
local mapEvent = {}\
\
-- 从mapBase继承方法\
mapEvent = table.assign(mapEvent, mapBase)\
for key, value in pairs(mapBase) do\
  if type(value) == 'function' then\
    mapEvent[key] = function(...)\
      return value(imgEvent, ...)\
    end\
  end\
end\
\
-- 获取地图采样位置。由于地图可能超出一屏，所以这里可以定义多个采样位置。每次扫描都会对每个采样位置进行扫描\
-- 标志位为地图四个角。每个采样位置只需定义一个角的坐标即可。\
-- 还需要定义每个采样位置的地图矩阵与屏幕坐标的映射关系\
mapEvent.getCheckpositionList = function()\
  local list = {\
    {\
      leftTop = nil,\
      rightTop = nil,\
      leftBotton = { 262, 902 },\
      rightBotton = nil,\
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的\
      positionMap = {\
        { { 350, 466, 0x3a4952 }, { 533, 466, 0x19283a }, { 717, 466, 0x4a4542 }, { 900, 466, 0x314531 }, { 1084, 466, 0x21394a }, { 1267, 466, 0x213931 }, { 1451, 466, 0x314531 }, { 1635, 466, 0x213542 }, },\
        { { 323, 598, 0x000000 }, { 514, 598, 0x31868c }, { 707, 598, 0x293121 }, { 898, 598, 0x218194 }, { 1089, 598, 0x216d8c }, { 1280, 598, 0x8c868c }, { 1472, 598, 0x4a8a73 }, { 1665, 598, 0x000000 }, },\
        { { 293, 742, 0x000000 }, { 492, 742, 0x3a616b }, { 694, 742, 0x297194 }, { 895, 742, 0x08557b }, { 1095, 742, 0x084d7b }, { 1296, 742, 0x295184 }, { 1496, 742, 0x526d9c }, { 1698, 742, 0x000000 }, },\
        { { 262, 902, 0x000000 }, { 471, 902, 0x000000 }, { 681, 902, 0x000000 }, { 892, 902, 0x000000 }, { 1102, 902, 0x000000 }, { 1312, 902, 0x000000 }, { 1522, 902, 0x000000 }, { 1733, 902, 0x000000 }, },\
      },\
      pointMap = {},\
    },\
  }\
  for key = 1, #list do\
    local positionMap = list[key].positionMap\
    for rowNum, rol in ipairs(positionMap) do\
      if rol and positionMap[rowNum + 1] then\
        for colNum, col in ipairs(rol) do\
          if col and rol[colNum + 1] then\
            list[key].pointMap[rowNum .. '-' .. colNum] = col\
          end\
        end\
      end\
    end\
  end\
  return list\
end\
\
-- 获取地图棋盘和相关数据\
mapEvent.getMapChessboard = function()\
  return {\
    width = 7,\
    height = 3,\
    obstacle = {\
      { 1, 5 }, { 1, 6 }, { 1, 7 },\
      { 2, 6 }, { 2, 7 },\
      { 2, 1 }, { 2, 2 }, { 3, 1 }, { 3, 2 }, { 3, 3 },\
    },\
    waitForBossPosition = { { 3, 7 } },\
    bossPosition = {},\
    myFleetList = {},\
    enemyPositionList1 = {},\
    enemyPositionList2 = {},\
    enemyPositionList3 = {},\
    inBattleList = {},\
    selectedArrowList = {},\
    rewardBoxList = {},\
  }\
end\
\
return mapEvent" }


package.sourceCode = package.sourceCode or {}
package.sourceCode["./meta-operation/maps-options/map1-3.lua"] = { path = "./meta-operation/maps-options/map1-3.lua", name = "./meta-operation/maps-options/map1-3.lua", source = "local mapBase = require './map'\
local imgEvent = require './img1-3'\
local mapEvent = {}\
\
-- 从mapBase继承方法\
mapEvent = table.assign(mapEvent, mapBase)\
for key, value in pairs(mapBase) do\
  if type(value) == 'function' then\
    mapEvent[key] = function(...)\
      return value(imgEvent, ...)\
    end\
  end\
end\
\
-- 获取地图采样位置。由于地图可能超出一屏，所以这里可以定义多个采样位置。每次扫描都会对每个采样位置进行扫描\
-- 标志位为地图四个角。每个采样位置只需定义一个角的坐标即可。\
-- 还需要定义每个采样位置的地图矩阵与屏幕坐标的映射关系\
mapEvent.getCheckpositionList = function()\
  local list = {\
    {\
      leftTop = { 518, 470 },\
      rightTop = nil,\
      leftBotton = nil,\
      rightBotton = nil,\
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的\
      positionMap = {\
        { { 518, 470, 0x293d52 }, { 694, 470, 0x63bece }, { 868, 470, 0x73be8c }, { 1045, 470, 0x293d3a }, { 1221, 470, 0x213142 }, { 1397, 470, 0x193142 }, { 1573, 470, 0x213542 }, },\
        { { 498, 597, 0x000000 }, { 682, 597, 0x197984 }, { 865, 597, 0x21819c }, { 1049, 597, 0x21718c }, { 1232, 597, 0x19798c }, { 1416, 597, 0x196d8c }, { 1600, 597, 0x000000 }, },\
        { { 478, 735, 0x000000 }, { 669, 735, 0x31719c }, { 861, 735, 0x196d8c }, { 1053, 735, 0x104d7b }, { 1244, 735, 0x19457b }, { 1436, 735, 0x215984 }, { 1628, 735, 0x000000 }, },\
        { { 456, 887, 0x000000 }, { 656, 887, 0x000000 }, { 856, 887, 0x000000 }, { 1057, 887, 0x000000 }, { 1257, 887, 0x000000 }, { 1458, 887, 0x000000 }, { 1659, 887, 0x000000 }, },\
      },\
      pointMap = {},\
    },\
  }\
  for key = 1, #list do\
    local positionMap = list[key].positionMap\
    for rowNum, rol in ipairs(positionMap) do\
      if rol and positionMap[rowNum + 1] then\
        for colNum, col in ipairs(rol) do\
          if col and rol[colNum + 1] then\
            list[key].pointMap[rowNum .. '-' .. colNum] = col\
          end\
        end\
      end\
    end\
  end\
  return list\
end\
\
-- 获取地图棋盘和相关数据\
mapEvent.getMapChessboard = function()\
  return {\
    width = 6,\
    height = 3,\
    obstacle = { { 1, 1 }, { 1, 2 }, { 1, 3 }, { 3, 3 } },\
    waitForBossPosition = { { 1, 5 } },\
    bossPosition = {},\
    myFleetList = {},\
    enemyPositionList1 = {},\
    enemyPositionList2 = {},\
    enemyPositionList3 = {},\
    inBattleList = {},\
    selectedArrowList = {},\
    rewardBoxList = {},\
  }\
end\
\
return mapEvent" }


package.sourceCode = package.sourceCode or {}
package.sourceCode["./meta-operation/maps-options/map1-2.lua"] = { path = "./meta-operation/maps-options/map1-2.lua", name = "./meta-operation/maps-options/map1-2.lua", source = "local mapBase = require './map'\
local imgEvent = require './img1-2'\
local mapEvent = {}\
\
-- 从mapBase继承方法\
mapEvent = table.assign(mapEvent, mapBase)\
for key, value in pairs(mapBase) do\
  if type(value) == 'function' then\
    mapEvent[key] = function(...)\
      return value(imgEvent, ...)\
    end\
  end\
end\
\
-- 获取地图采样位置。由于地图可能超出一屏，所以这里可以定义多个采样位置。每次扫描都会对每个采样位置进行扫描\
-- 标志位为地图四个角。每个采样位置只需定义一个角的坐标即可。\
-- 还需要定义每个采样位置的地图矩阵与屏幕坐标的映射关系\
mapEvent.getCheckpositionList = function()\
  local list = {\
    {\
      leftTop = nil,\
      rightTop = nil,\
      leftBotton = { 399, 837 },\
      rightBotton = nil,\
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的\
      positionMap = {\
        { { 462, 409, 0x31393a }, { 645, 409, 0x42494a }, { 828, 409, 0x313931 }, { 1012, 409, 0x293529 }, { 1196, 409, 0x212821 }, { 1380, 409, 0x424942 }, },\
        { { 440, 537, 0x000000 }, { 631, 537, 0x318e94 }, { 823, 537, 0x21868c }, { 1014, 537, 0x106184 }, { 1206, 537, 0x196984 }, { 1398, 537, 0x000000 }, },\
        { { 416, 679, 0x000000 }, { 613, 679, 0x316994 }, { 814, 679, 0x00517b }, { 1014, 679, 0x084173 }, { 1214, 679, 0x214d73 }, { 1419, 679, 0x000000 }, },\
        { { 389, 837, 0x000000 }, { 599, 837, 0x000000 }, { 809, 837, 0x000000 }, { 1020, 837, 0x000000 }, { 1230, 837, 0x000000 }, { 1441, 837, 0x000000 }, },\
      },\
      pointMap = {},\
    },\
  }\
  for key = 1, #list do\
    local positionMap = list[key].positionMap\
    for rowNum, rol in ipairs(positionMap) do\
      if rol and positionMap[rowNum + 1] then\
        for colNum, col in ipairs(rol) do\
          if col and rol[colNum + 1] then\
            list[key].pointMap[rowNum .. '-' .. colNum] = col\
          end\
        end\
      end\
    end\
  end\
  return list\
end\
\
-- 获取地图棋盘和相关数据\
mapEvent.getMapChessboard = function()\
  return {\
    width = 5,\
    height = 3,\
    obstacle = { { 2, 2 }, { 2, 5 }, { 3, 5 } },\
    waitForBossPosition = { { 1, 5 } },\
    bossPosition = {},\
    myFleetList = {},\
    enemyPositionList1 = {},\
    enemyPositionList2 = {},\
    enemyPositionList3 = {},\
    inBattleList = {},\
    selectedArrowList = {},\
    rewardBoxList = {},\
  }\
end\
\
return mapEvent" }


package.sourceCode = package.sourceCode or {}
package.sourceCode["./meta-operation/maps-options/map1-1.lua"] = { path = "./meta-operation/maps-options/map1-1.lua", name = "./meta-operation/maps-options/map1-1.lua", source = "local mapBase = require './map'\
local imgEvent = require './img1-1'\
local mapEvent = {}\
\
-- 从mapBase继承方法\
mapEvent = table.assign(mapEvent, mapBase)\
for key, value in pairs(mapBase) do\
  if type(value) == 'function' then\
    mapEvent[key] = function(...)\
      return value(imgEvent, ...)\
    end\
  end\
end\
\
-- 获取地图采样位置。由于地图可能超出一屏，所以这里可以定义多个采样位置。每次扫描都会对每个采样位置进行扫描\
-- 标志位为地图四个角。每个采样位置只需定义一个角的坐标即可。\
-- 还需要定义每个采样位置的地图矩阵与屏幕坐标的映射关系\
mapEvent.getCheckpositionList = function()\
  local list = {\
    {\
      leftTop = nil,\
      rightTop = nil,\
      leftBotton = { 352, 676 },\
      rightBotton = nil,\
      -- 地图棋盘映射到屏幕，后面的颜色没有用，只是取点的时候自动加上的\
      positionMap = {\
        { { 377, 540, 0x192842 }, { 559, 540, 0xbdbabd }, { 744, 540, 0x21354a }, { 927, 540, 0x21394a }, { 1111, 540, 0x21394a }, { 1294, 540, 0x213952 }, { 1478, 540, 0x21354a }, { 1662, 540, 0x21354a }, },\
        { { 352, 676, 0x000000 }, { 543, 676, 0x000000 }, { 734, 676, 0x000000 }, { 926, 676, 0x000000 }, { 1117, 676, 0x000000 }, { 1309, 676, 0x000000 }, { 1500, 676, 0x000000 }, { 1693, 676, 0x000000 }, }\
      },\
      pointMap = {},\
    },\
  }\
  for key = 1, #list do\
    local positionMap = list[key].positionMap\
    for rowNum, rol in ipairs(positionMap) do\
      if rol and positionMap[rowNum + 1] then\
        for colNum, col in ipairs(rol) do\
          if col and rol[colNum + 1] then\
            list[key].pointMap[rowNum .. '-' .. colNum] = col\
          end\
        end\
      end\
    end\
  end\
  return list\
end\
\
-- 获取地图棋盘和相关数据\
mapEvent.getMapChessboard = function()\
  return {\
    width = 7,\
    height = 1,\
    obstacle = {},\
    waitForBossPosition = { { 1, 7 } },\
    bossPosition = {},\
    myFleetList = {},\
    enemyPositionList1 = {},\
    enemyPositionList2 = {},\
    enemyPositionList3 = {},\
    inBattleList = {},\
    selectedArrowList = {},\
    rewardBoxList = {},\
  }\
end\
\
return mapEvent" }


package.sourceCode = package.sourceCode or {}
package.sourceCode["./utils/vibrator-promise.lua"] = { path = "./utils/vibrator-promise.lua", name = "./utils/vibrator-promise.lua", source = "if type(Promise) ~= 'table' then\
  error('SleepPromise need Promise module to work. Please require \\'Promise\\' as global variable.', 2)\
end\
if type(EventQuery) ~= 'table' then\
  error('SleepPromise need EventQuery module to work. Please require \\'EventQuery\\' as global variableß .', 2)\
end\
\
local sleepPromise = function(ms)\
  return Promise.new(function(resolve)\
    EventQuery.setTimeout(resolve, ms)\
  end)\
end\
\
local vibratorPromise = function(num, ms)\
  num = num or 1\
  ms = ms or 500\
  local res = Promise.resolve(1)\
  for key = 1, num do\
    res = res.andThen(function()\
      return vibrator()\
    end).andThen(function()\
      return sleepPromise(ms)\
    end)\
  end\
  return res\
end\
return vibratorPromise\
" }


package.sourceCode = package.sourceCode or {}
package.sourceCode["./meta-operation/maps-options/index.lua"] = { path = "./meta-operation/maps-options/index.lua", name = "./meta-operation/maps-options/index.lua", source = "local map1_1 = require './map1-1'\
local map1_2 = require './map1-2'\
local map1_3 = require './map1-3'\
local map1_4 = require './map1-4'\
local map2_1 = require './map2-1'\
local map2_2 = require './map2-2'\
local map2_3 = require './map2-3'\
local map2_4 = require './map2-4'\
local map3_1 = require './map3-1'\
local map3_2 = require './map3-2'\
local map3_3 = require './map3-3'\
local map3_4 = require './map3-4'\
local map4_1 = require './map4-1'\
local map4_2 = require './map4-2'\
local map4_3 = require './map4-3'\
local map4_4 = require './map4-4'\
local map5_1 = require './map5-1'\
local map5_2 = require './map5-2'\
local map5_3 = require './map5-3'\
local map5_4 = require './map5-4'\
local map6_1 = require './map6-1'\
local map6_2 = require './map6-2'\
local map6_3 = require './map6-3'\
local map6_4 = require './map6-4'\
local map7_1 = require './map7-1'\
local map7_2 = require './map7-2'\
local map7_3 = require './map7-3'\
local map7_4 = require './map7-4'\
local map8_1 = require './map8-1'\
local map8_2 = require './map8-2'\
local map8_3 = require './map8-3'\
local map8_4 = require './map8-4'\
local map9_1 = require './map9-1'\
local map9_2 = require './map9-2'\
local map9_3 = require './map9-3'\
local map9_4 = require './map9-4'\
local map10_1 = require './map10-1'\
local map10_2 = require './map10-2'\
local map10_3 = require './map10-3'\
local map10_4 = require './map10-4'\
local map11_1 = require './map11-1'\
local map11_2 = require './map11-2'\
local map11_3 = require './map11-3'\
local map12_1 = require './map12-1'\
local mapevent15_1_a2 = require './mapevent15-1-a2'\
local mapevent15_2_b2 = require './mapevent15-2-b2'\
\
return {\
  ['map1-1'] = map1_1,\
  ['map1-2'] = map1_2,\
  ['map1-3'] = map1_3,\
  ['map1-4'] = map1_4,\
  ['map2-1'] = map2_1,\
  ['map2-2'] = map2_2,\
  ['map2-3'] = map2_3,\
  ['map2-4'] = map2_4,\
  ['map3-1'] = map3_1,\
  ['map3-2'] = map3_2,\
  ['map3-3'] = map3_3,\
  ['map3-4'] = map3_4,\
  ['map4-1'] = map4_1,\
  ['map4-2'] = map4_2,\
  ['map4-3'] = map4_3,\
  ['map4-4'] = map4_4,\
  ['map5-1'] = map5_1,\
  ['map5-2'] = map5_2,\
  ['map5-3'] = map5_3,\
  ['map5-4'] = map5_4,\
  ['map6-1'] = map6_1,\
  ['map6-2'] = map6_2,\
  ['map6-3'] = map6_3,\
  ['map6-4'] = map6_4,\
  ['map7-1'] = map7_1,\
  ['map7-2'] = map7_2,\
  ['map7-3'] = map7_3,\
  ['map7-4'] = map7_4,\
  ['map8-1'] = map8_1,\
  ['map8-2'] = map8_2,\
  ['map8-3'] = map8_3,\
  ['map8-4'] = map8_4,\
  ['map9-1'] = map9_1,\
  ['map9-2'] = map9_2,\
  ['map9-3'] = map9_3,\
  ['map9-4'] = map9_4,\
  ['map10-1'] = map10_1,\
  ['map10-2'] = map10_2,\
  ['map10-3'] = map10_3,\
  ['map10-4'] = map10_4,\
  ['map11-1'] = map11_1,\
  ['map11-2'] = map11_2,\
  ['map11-3'] = map11_3,\
  ['map12-1'] = map12_1,\
  ['mapevent15-1-a2'] = mapevent15_1_a2,\
  ['mapevent15-2-b2'] = mapevent15_2_b2,\
}\
" }


package.sourceCode = package.sourceCode or {}
package.sourceCode["./meta-operation/home.lua"] = { path = "./meta-operation/home.lua", name = "./meta-operation/home.lua", source = "local home = {}\
\
-- 检测主页\
home.isHome = function()\
  local __keepScreenState = keepScreenState\
  if not __keepScreenState then keepScreen(true) end\
  local list = {\
    { 139, 30, 0x101010 }, { 625, 24, 0x212021 },\
    { 963, 16, 0x292d3a }, { 1033, 67, 0x3a3d3a },\
    { 1058, 31, 0xe6efef }, { 1339, 47, 0xefba42 },\
    { 1369, 32, 0xefebef }, { 1652, 39, 0xf74163 },\
    { 1675, 65, 0xefefef }, { 1775, 184, 0xa4cede },\
    { 1162, 179, 0xa4cade }, { 1276, 189, 0xa4cade },\
    { 1201, 582, 0x109eef }, { 1383, 582, 0x199ae6 },\
    { 1290, 571, 0xffffff }, { 1498, 585, 0xdeae10 },\
    { 1744, 597, 0xe6aa10 }, { 1591, 580, 0xffffff },\
    { 112, 990, 0xffffff }, { 190, 974, 0xe6e7e6 },\
  }\
  local result = multiColorS(list)\
  if (not __keepScreenState) then keepScreen(false) end\
  return result\
end\
\
return home" }


package.sourceCode = package.sourceCode or {}
package.sourceCode["./meta-operation/battle.lua"] = { path = "./meta-operation/battle.lua", name = "./meta-operation/battle.lua", source = "local battle = {}\
\
\
-- 点击出征\
battle.clickBattleBtn = function()\
  tap(1628, 599, 100)\
end\
\
-- 点击活动\
battle.clickEventBtn = function()\
  tap(1018, 249, 100)\
end\
\
--  是否在出击选择章节界面\
battle.isBattleChapterPage = function()\
  local __keepScreenState = keepScreenState\
  if not __keepScreenState then keepScreen(true) end\
  local list = {\
    { 9, 9, 0xefebf7 }, { 130, 8, 0x292829 },\
    { 443, 11, 0x4a494a }, { 489, 7, 0xeff3f7 },\
    { 929, 8, 0xeff3f7 }, { 890, 52, 0xdedfde },\
    { 12, 52, 0xd6d2d6 }, { 176, 60, 0x423942 },\
    { 98, 50, 0xd6ced6 }, { 38, 32, 0xffd74a },\
    { 250, 22, 0xffefbd }, { 259, 22, 0x31353a },\
    { 269, 22, 0xffebbd }, { 281, 22, 0x3a3d3a },\
    { 289, 22, 0xffebbd }, { 245, 45, 0xffbe10 },\
    { 257, 45, 0x3a393a }, { 265, 45, 0xffba10 },\
    { 274, 45, 0x293129 }, { 285, 45, 0xffbe08 },\
    { 302, 43, 0xffbe10 }, { 312, 43, 0x313531 },\
    { 322, 43, 0xffbe19 }, { 332, 43, 0x3a3d3a },\
    { 343, 43, 0xffc219 }, { 325, 25, 0xffe79c },\
    { 341, 27, 0x191819 }, { 301, 24, 0x080c08 },\
    { 306, 19, 0xfff3ce }, { 339, 11, 0x3a3d3a },\
  }\
  local result = multiColorS(list)\
  if not __keepScreenState then keepScreen(false) end\
  return result\
end\
\
-- 点击回港\
battle.clickBackToHomeBtn = function()\
  tap(98, 1016, 100)\
end\
\
--  是否在普通模式\
battle.isNormalMode = function()\
  local __keepScreenState = keepScreenState\
  if not __keepScreenState then keepScreen(true) end\
  local list = {\
    { 170, 1004, 0xc50808 }, { 201, 1008, 0xf7f7f7 },\
    { 230, 1021, 0xeff3ef }, { 281, 1034, 0x5a0c08 },\
  }\
  local result = multiColorS(list)\
  if not __keepScreenState then keepScreen(false) end\
  return result\
end\
\
--  是否在困难模式\
battle.isHardMode = function()\
  local __keepScreenState = keepScreenState\
  if not __keepScreenState then keepScreen(true) end\
  local list = {\
    { 180, 1007, 0x002d6b }, { 207, 1009, 0xf7f7f7 },\
    { 244, 1021, 0xf7f3f7 }, { 277, 1033, 0x102042 },\
  }\
  local result = multiColorS(list)\
  if not __keepScreenState then keepScreen(false) end\
  return result\
end\
\
-- 切换困难模式按钮\
battle.clickSwitchHardModeBtn = function()\
  tap(202, 1010, 100)\
end\
\
-- 移动到m章节\
battle.moveToChapter = function(chapter)\
  local chapter = chapter\
  local __keepScreenState = keepScreenState\
  if not __keepScreenState then keepScreen(true) end\
\
  local chapterArr = strSplit(chapter, \"-\")\
  local m = tonumber(chapterArr[1]) or 1\
\
  if string.sub(chapter, 1, 5) == 'event' then\
    m = tonumber(chapterArr[2]) or 1\
  end\
\
  local leftButton = {\
    { 97, 526, 0xe6e7e6 },\
    { 86, 539, 0xd6d7d6 },\
    { 109, 577, 0xdedbde },\
  }\
  -- 先移到第一章\
  for i = 1, 14 do\
    tap(90, 540, 100)\
    mSleep(80)\
    keepScreen(true)\
    if not multiColorS(leftButton) then\
      break\
    end\
  end\
  -- 再移到第m章\
  for i = 2, m do\
    tap(1826, 540, 100)\
    mSleep(200)\
  end\
  mSleep(200)\
  if not __keepScreenState then keepScreen(false) end\
  return true\
end\
\
-- 点击m章节\
battle.clickChapter = function(chapter)\
  local __keepScreenState = keepScreenState\
  if not __keepScreenState then keepScreen(true) end\
\
  if (chapter == '1-1') then\
    tap(227, 687, 100)\
  elseif (chapter == '1-2') then\
    tap(685, 409, 100)\
  elseif (chapter == '1-3') then\
    tap(984, 789, 100)\
  elseif (chapter == '1-4') then\
    tap(1366, 317, 100)\
  elseif (chapter == '2-1') then\
    tap(1221, 685, 100)\
  elseif (chapter == '2-2') then\
    tap(1121, 277, 100)\
  elseif (chapter == '2-3') then\
    tap(429, 406, 100)\
  elseif (chapter == '2-4') then\
    tap(572, 821, 100)\
  elseif (chapter == '3-1') then\
    tap(603, 320, 100)\
  elseif (chapter == '3-2') then\
    tap(344, 750, 100)\
  elseif (chapter == '3-3') then\
    tap(1364, 279, 100)\
  elseif (chapter == '3-4') then\
    tap(923, 540, 100)\
  elseif (chapter == '4-1') then\
    tap(355, 451, 100)\
  elseif (chapter == '4-2') then\
    tap(628, 701, 100)\
  elseif (chapter == '4-3') then\
    tap(1234, 818, 100)\
  elseif (chapter == '4-4') then\
    tap(1167, 430, 100)\
  elseif (chapter == '5-1') then\
    tap(363, 544, 100)\
  elseif (chapter == '5-2') then\
    tap(1285, 803, 100)\
  elseif (chapter == '5-3') then\
    tap(1104, 549, 100)\
  elseif (chapter == '5-4') then\
    tap(884, 318, 100)\
  elseif (chapter == '6-1') then\
    tap(1373, 746, 100)\
  elseif (chapter == '6-2') then\
    tap(1055, 515, 100)\
  elseif (chapter == '6-3') then\
    tap(632, 317, 100)\
  elseif (chapter == '6-4') then\
    tap(443, 643, 100)\
  elseif (chapter == '7-1') then\
    tap(308, 725, 100)\
  elseif (chapter == '7-2') then\
    tap(688, 270, 100)\
  elseif (chapter == '7-3') then\
    tap(1234, 425, 100)\
  elseif (chapter == '7-4') then\
    tap(1416, 674, 100)\
  elseif (chapter == '8-1') then\
    tap(824, 280, 100)\
  elseif (chapter == '8-2') then\
    tap(411, 535, 100)\
  elseif (chapter == '8-3') then\
    tap(507, 849, 100)\
  elseif (chapter == '8-4') then\
    tap(1168, 686, 100)\
  elseif (chapter == '9-1') then\
    tap(360, 359, 100)\
  elseif (chapter == '9-2') then\
    tap(569, 729, 100)\
  elseif (chapter == '9-3') then\
    tap(1179, 395, 100)\
  elseif (chapter == '9-4') then\
    tap(1375, 768, 100)\
  elseif (chapter == '10-1') then\
    tap(301, 362, 100)\
  elseif (chapter == '10-2') then\
    tap(694, 571, 100)\
  elseif (chapter == '10-3') then\
    tap(971, 806, 100)\
  elseif (chapter == '10-4') then\
    tap(1111, 336, 100)\
  elseif (chapter == '11-1') then\
    tap(453, 348, 100)\
  elseif (chapter == '11-2') then\
    tap(643, 779, 100)\
  elseif (chapter == '11-3') then\
    tap(1077, 255, 100)\
  elseif (chapter == '11-4') then\
    tap(1335, 665, 100)\
  elseif (chapter == '12-1') then\
    tap(296, 362, 100)\
  elseif (chapter == 'event4-1-sp1') then\
    tap(834, 312, 100)\
  elseif (chapter == 'event4-1-sp2') then\
    tap(417, 542, 100)\
  elseif (chapter == 'event4-1-sp3') then\
    tap(1392, 473, 100)\
  elseif (chapter == 'event5-1-a1') then\
    tap(655, 268, 100)\
  elseif (chapter == 'event5-1-a2') then\
    tap(1100, 781, 100)\
  elseif (chapter == 'event5-1-a3') then\
    tap(1340, 381, 100)\
  elseif (chapter == 'event5-2-b1') then\
    tap(532, 778, 100)\
  elseif (chapter == 'event5-2-b2') then\
    tap(1305, 744, 100)\
  elseif (chapter == 'event5-2-b3') then\
    tap(1058, 333, 100)\
  elseif (chapter == 'event6-1-sp1') then\
    tap(404, 414, 100)\
  elseif (chapter == 'event6-1-sp2') then\
    tap(569, 808, 100)\
  elseif (chapter == 'event6-1-sp3') then\
    tap(1240, 592, 100)\
  elseif (chapter == 'event7-1-a1') then\
    tap(498, 341, 100)\
  elseif (chapter == 'event7-1-a2') then\
    tap(748, 834, 100)\
  elseif (chapter == 'event7-1-a3') then\
    tap(1296, 410, 100)\
  elseif (chapter == 'event7-1-c1') then\
    tap(498, 341, 100)\
  elseif (chapter == 'event7-1-c2') then\
    tap(748, 834, 100)\
  elseif (chapter == 'event7-1-c3') then\
    tap(1296, 410, 100)\
  elseif (chapter == 'event8-1-sp1') then\
    tap(1368, 453, 100)\
  elseif (chapter == 'event8-1-sp2') then\
    tap(872, 791, 100)\
  elseif (chapter == 'event8-1-sp3') then\
    tap(587, 375, 100)\
  elseif (chapter == 'event9-1-sp1') then\
    tap(366, 339, 100)\
  elseif (chapter == 'event9-1-sp2') then\
    tap(1206, 282, 100)\
  elseif (chapter == 'event9-1-sp3') then\
    tap(286, 866, 100)\
  elseif (chapter == 'event9-1-sp4') then\
    tap(1070, 744, 100)\
  elseif (chapter == 'event11-1-a1') then\
    tap(653, 265, 100)\
  elseif (chapter == 'event11-1-a2') then\
    tap(1102, 786, 100)\
  elseif (chapter == 'event11-1-a3') then\
    tap(1342, 378, 100)\
  elseif (chapter == 'event11-2 -b1') then\
    tap(537, 775, 100)\
  elseif (chapter == 'event11-2-b2') then\
    tap(1307, 727, 100)\
  elseif (chapter == 'event11-2-b3') then\
    tap(1063, 325, 100)\
  elseif (chapter == 'event12-1-sp1') then\
    tap(1379, 457, 100)\
  elseif (chapter == 'event12-1-sp2') then\
    tap(875, 796, 100)\
  elseif (chapter == 'event12-1-sp3') then\
    tap(582, 370, 100)\
  elseif (chapter == 'event13-1-sp1') then\
    tap(407, 409, 100)\
  elseif (chapter == 'event13-1-sp2') then\
    tap(568, 804, 100)\
  elseif (chapter == 'event13-1-sp3') then\
    tap(1243, 590, 100)\
  elseif (chapter == 'event15-1-a1') then\
    tap(387, 367, 100)\
  elseif (chapter == 'event15-1-a2') then\
    tap(535, 690, 100)\
  elseif (chapter == 'event15-1-a3') then\
    tap(1345, 769, 100)\
  elseif (chapter == 'event15-1-a4') then\
    tap(1190, 421, 100)\
  elseif (chapter == 'event15-2-b1') then\
    tap(517, 655, 100)\
  elseif (chapter == 'event15-2-b2') then\
    tap(1257, 544, 100)\
  end\
  if not __keepScreenState then keepScreen(false) end\
end\
\
-- 检测是第几关\
battle.checkChapter = function(chapter)\
  local __keepScreenState = keepScreenState\
  if (not __keepScreenState) then keepScreen(true) end\
\
  local chapterArr = strSplit(chapter, \"-\")\
  local m = tonumber(chapterArr[1]) or 0\
\
  if string.find(chapter, 'sp') then\
    m = 'sp'\
  end\
\
  local list = {\
    [1] = {\
      { 73, 146, 0xf7df6b }, { 74, 159, 0xe6aa29 },\
      { 74, 166, 0xffbe31 }, { 67, 151, 0x292419 },\
      { 68, 143, 0x101810 }, { 79, 159, 0x212021 },\
      { 80, 171, 0x193131 }, { 68, 171, 0x101c19 },\
    },\
    [2] = {\
      { 67, 149, 0xe6be52 }, { 71, 148, 0x211808 },\
      { 71, 142, 0xc5ba5a }, { 74, 156, 0xe6a631 },\
      { 74, 163, 0x191808 }, { 78, 168, 0xffc629 },\
      { 65, 168, 0xf7c229 }, { 62, 167, 0x212008 },\
      { 80, 168, 0x292421 }, { 71, 171, 0x101010 },\
    },\
    [3] = {\
      { 67, 149, 0xe6c263 }, { 72, 147, 0x212000 },\
      { 78, 147, 0xe6ca63 }, { 72, 143, 0xefdb73 },\
      { 71, 154, 0xd6aa42 }, { 72, 165, 0x291800 },\
      { 72, 169, 0xf7c629 }, { 63, 164, 0x4a4521 },\
      { 79, 164, 0xcea229 }, { 75, 171, 0x312d19 },\
    },\
    [4] = {\
      { 74, 143, 0xefdf73 }, { 71, 158, 0x4a3519 },\
      { 65, 163, 0xd6aa31 }, { 81, 162, 0xce9e31 },\
      { 77, 169, 0xefc629 }, { 78, 152, 0xefbe52 },\
      { 71, 166, 0x4a3d10 }, { 66, 164, 0xbd9229 },\
      { 83, 163, 0x191410 },\
    },\
    [5] = {\
      { 71, 147, 0x524921 }, { 65, 143, 0xf7e77b },\
      { 78, 144, 0xf7e373 }, { 71, 140, 0x191c19 },\
      { 72, 165, 0x191408 }, { 72, 154, 0x5a4119 },\
      { 67, 161, 0xdeaa31 }, { 66, 154, 0xdeaa4a },\
      { 72, 169, 0xe6c242 }, { 72, 171, 0x5a4900 },\
    },\
    [6] = {\
      { 72, 142, 0xdebe63 }, { 77, 148, 0xe6c263 },\
      { 72, 147, 0x291400 }, { 65, 155, 0xe6aa31 },\
      { 72, 165, 0x191408 }, { 72, 156, 0x422021 },\
      { 72, 170, 0xbd9629 }, { 72, 169, 0xf7c231 },\
      { 79, 170, 0x211c10 }, { 79, 161, 0xe6aa29 },\
    },\
    [7] = {\
      { 66, 144, 0xdece73 }, { 78, 144, 0xffdb7b },\
      { 71, 169, 0xf7c229 }, { 70, 148, 0x313119 },\
      { 66, 168, 0x101410 }, { 77, 168, 0x101419 },\
      { 71, 171, 0x101010 }, { 71, 141, 0x423d29 },\
      { 79, 141, 0x292819 },\
    },\
    [8] = {\
      { 72, 142, 0xd6be6b }, { 72, 169, 0xefce29 },\
      { 72, 165, 0x210c00 }, { 72, 158, 0x4a3510 },\
      { 72, 151, 0x312400 }, { 72, 147, 0x100400 },\
      { 64, 153, 0x3a3108 }, { 80, 154, 0x191410 },\
      { 79, 160, 0xdeb229 }, { 65, 163, 0xe6ba29 },\
    },\
    [9] = {\
      { 72, 142, 0xd6c27b }, { 72, 147, 0x101000 },\
      { 72, 154, 0x191800 }, { 72, 165, 0x100c00 },\
      { 65, 164, 0xe6b629 }, { 63, 164, 0x312d10 },\
      { 66, 161, 0x292010 }, { 79, 157, 0xe6aa29 },\
      { 79, 169, 0x3a3110 }, { 72, 169, 0xefc629 },\
    },\
    [10] = {\
      { 54, 148, 0xefc663 }, { 55, 150, 0x5a4121 },\
      { 65, 160, 0x5a4119 }, { 72, 155, 0x3a3919 },\
      { 72, 154, 0x423d21 }, { 81, 147, 0x100c00 },\
      { 81, 156, 0x190800 }, { 85, 168, 0xf7be29 },\
      { 88, 159, 0xe6a621 }, { 70, 167, 0x081821 },\
    },\
    [11] = {\
      { 57, 147, 0xe6c663 }, { 67, 159, 0xce9229 },\
      { 64, 169, 0xe6c229 }, { 58, 151, 0x212010 },\
      { 76, 151, 0x212010 }, { 73, 159, 0x19313a },\
      { 77, 168, 0x101410 }, { 84, 169, 0xe6c229 },\
      { 86, 156, 0x5a4d21 }, { 83, 143, 0xf7e77b },\
    },\
    [12] = {\
      { 54, 148, 0xefc663 }, { 62, 143, 0xf7e373 },\
      { 61, 169, 0xefc229 }, { 72, 168, 0x5a5529 },\
      { 79, 167, 0xf7c629 }, { 80, 147, 0x311c10 },\
      { 75, 154, 0x192429 }, { 84, 155, 0xdea229 },\
      { 83, 164, 0x292408 }, { 87, 168, 0xf7c229 },\
    },\
    sp = {\
      { 48, 147, 0xffffff }, { 61, 147, 0xffffff },\
      { 55, 149, 0x10283a }, { 62, 154, 0x102031 },\
      { 47, 161, 0x082029 }, { 54, 159, 0xffffff },\
      { 55, 169, 0x082031 }, { 55, 176, 0xffffff },\
      { 62, 168, 0xffffff }, { 64, 177, 0x082029 },\
      { 72, 150, 0x102431 }, { 79, 149, 0xffffff },\
      { 86, 151, 0x19313a }, { 94, 151, 0xffffff },\
      { 88, 164, 0x102431 }, { 80, 174, 0xffffff },\
      { 89, 174, 0x082031 }, { 98, 175, 0xffffff },\
    },\
  }\
  local result = nil\
  if m == 0 or multiColorS(list[m]) then\
    result = true\
  end\
  if (not __keepScreenState) then keepScreen(false) end\
  return result\
end\
\
--  是否在章节信息面板\
battle.isChapterInfoPanel = function()\
  local __keepScreenState = keepScreenState\
  if not __keepScreenState then keepScreen(true) end\
  local list = {\
    { 468, 283, 0x292d29 }, { 829, 281, 0xeff3f7 },\
    { 1559, 277, 0xadaaad }, { 369, 786, 0x4a494a },\
    { 1553, 782, 0x3a3d42 }, { 1267, 715, 0xffca42 },\
    { 1310, 717, 0xffffff }, { 1344, 716, 0xffce3a },\
    { 1363, 716, 0xb5aa84 }, { 1389, 721, 0xffffff },\
    { 1406, 704, 0xf7f7ef }, { 1434, 718, 0xc5ae84 },\
    { 1464, 724, 0xf7f3ef }, { 1480, 721, 0xffffff },\
    { 1506, 719, 0xf7c231 }, { 1518, 725, 0xf7be29 },\
    { 1268, 624, 0x3a3d42 }, { 1286, 623, 0xf7f7f7 },\
    { 1327, 627, 0x424142 }, { 1526, 499, 0x292d29 },\
  }\
  local result = multiColorS(list)\
  if not __keepScreenState then keepScreen(false) end\
  return result\
end\
\
-- 前往选择舰队面板\
battle.clickGotoSelectFleedPanelBtn = function()\
  tap(1388, 720, 100)\
end\
\
--  是否在选择舰队面板\
battle.isSelectFleetPanel = function()\
  local __keepScreenState = keepScreenState\
  if not __keepScreenState then keepScreen(true) end\
  local list = {\
    { 155, 123, 0x292429 }, { 833, 127, 0xeff3f7 },\
    { 1604, 118, 0xeff3f7 }, { 1671, 120, 0x9caa9c },\
    { 1753, 121, 0xadaaad }, { 1699, 132, 0xf7db42 },\
    { 1720, 157, 0xf7ce42 }, { 1727, 143, 0xadaaad },\
    { 1708, 161, 0xadaaad }, { 1709, 145, 0xffd742 },\
    { 170, 150, 0xffc642 }, { 187, 154, 0xa47d10 },\
    { 212, 154, 0xe6b631 }, { 215, 154, 0x080c08 },\
    { 278, 144, 0x3a413a }, { 257, 168, 0x292d29 },\
    { 251, 163, 0xffba00 }, { 318, 148, 0xc5a63a },\
    { 295, 139, 0x292429 }, { 329, 179, 0x3a3d3a },\
\
    { 1533, 299, 0x6b2400 }, { 1544, 300, 0x633910 },\
    { 1551, 300, 0x633510 }, { 1564, 302, 0xffd24a },\
    { 1533, 316, 0x6b2d08 }, { 1547, 321, 0xffca42 },\
    { 1559, 314, 0xffc642 }, { 1580, 304, 0xffb242 },\
    { 1570, 307, 0xffc242 }, { 1592, 308, 0x6b3d21 },\
    { 1600, 307, 0xffaa29 }, { 1584, 293, 0xffc64a },\
    { 1598, 299, 0x633110 }, { 1590, 307, 0x733110 },\
    { 1591, 323, 0x632d10 }, { 1580, 321, 0xf7a229 },\
    { 1598, 321, 0xde8e29 }, { 1580, 331, 0xf7a229 },\
    { 1570, 324, 0xffaa3a }, { 1591, 316, 0x6b2800 },\
  }\
  local result = multiColorS(list)\
  if not __keepScreenState then keepScreen(false) end\
  return result\
end\
\
--  是否在困难选择舰队面板\
battle.isHardSelectFleetPanel = function()\
  local __keepScreenState = keepScreenState\
  if not __keepScreenState then keepScreen(true) end\
  local list = {\
    { 155, 123, 0x292429 }, { 833, 127, 0xeff3f7 },\
    { 1604, 118, 0xeff3f7 }, { 1671, 120, 0x9caa9c },\
    { 1753, 121, 0xadaaad }, { 1699, 132, 0xf7db42 },\
    { 1720, 157, 0xf7ce42 }, { 1727, 143, 0xadaaad },\
    { 1708, 161, 0xadaaad }, { 1709, 145, 0xffd742 },\
    { 170, 150, 0xffc642 }, { 187, 154, 0xa47d10 },\
    { 212, 154, 0xe6b631 }, { 215, 154, 0x080c08 },\
    { 278, 144, 0x3a413a }, { 257, 168, 0x292d29 },\
    { 251, 163, 0xffba00 }, { 318, 148, 0xc5a63a },\
    { 295, 139, 0x292429 }, { 329, 179, 0x3a3d3a },\
\
    { 1531, 308, 0xf7db52 }, { 1536, 302, 0x633910 },\
    { 1550, 305, 0xe6be52 }, { 1560, 305, 0xffd24a },\
    { 1559, 314, 0xffc252 }, { 1555, 318, 0x633110 },\
    { 1541, 322, 0xffc652 }, { 1541, 314, 0xf7c652 },\
    { 1536, 325, 0x633100 }, { 1554, 327, 0x632400 },\
    { 1572, 300, 0x732808 }, { 1595, 300, 0x633100 },\
    { 1577, 316, 0xf7a63a }, { 1574, 326, 0x733508 },\
    { 1596, 320, 0x6b3d21 }, { 1588, 324, 0xffa631 },\
    { 1585, 316, 0xf7a231 }, { 1604, 303, 0xf7a629 },\
    { 1583, 303, 0xffae3a }, { 1584, 329, 0xffaa21 },\
  }\
  local result = multiColorS(list)\
  if not __keepScreenState then keepScreen(false) end\
  return result\
end\
\
-- 困难进入战斗\
battle.clickHardGotoSelectFleedPanelBtn = function()\
  tap(1588, 934, 100)\
end\
\
-- 检查已经选择的舰队\
battle.checkSelectedFleet = function(needFleetList)\
  local __keepScreenState = keepScreenState\
  if __keepScreenState then keepScreen(false) end\
  keepScreen(true)\
  -- 需要选中的舰队，转换成索引\
  local needFleet = { false, false, false, false }\
  for _, v in ipairs(needFleetList) do\
    needFleet[v] = true\
  end\
\
  local list1 = { { 553, 835, 0xf7a23a } }\
  local list2 = { { 760, 838, 0xf7a242 } }\
  local list3 = { { 987, 839, 0xf7a242 } }\
  local list4 = { { 1203, 840, 0xefa23a } }\
  -- 已经选中的舰队索引\
  local nowSelectedFeeld = {\
    multiColorS(list1) and true or false,\
    multiColorS(list2) and true or false,\
    multiColorS(list3) and true or false,\
    multiColorS(list4) and true or false,\
  }\
  -- 已经选中的舰队\
  local nowSelectedFeeldList = {}\
  for key, value in ipairs(nowSelectedFeeld) do\
    if value then\
      table.insert(nowSelectedFeeldList, key)\
    end\
  end\
  -- 需要改变的舰队索引\
  local needChange = { false, false, false, false }\
  for key = 1, 4 do\
    if needFleet[key] ~= nowSelectedFeeld[key] then\
      if needFleet[key] then\
        needChange[key] = 'select'\
      else\
        needChange[key] = 'unselect'\
      end\
    end\
  end\
\
  -- 需要选中的舰队\
  local selectChangeList = {}\
  -- 需要取消的舰队\
  local unSelectChangeList = {}\
  -- 需要改变的舰队\
  local needChangeList = {}\
  for key, _ in ipairs(needChange) do\
    if (needChange[key]) then\
      table.insert(needChangeList, key)\
    end\
    if needChange[key] == 'select' then\
      table.insert(selectChangeList, key)\
    elseif needChange[key] == 'unselect' then\
      table.insert(unSelectChangeList, key)\
    end\
  end\
\
  if not __keepScreenState then keepScreen(false) end\
  return #needChangeList == 0, selectChangeList, unSelectChangeList, nowSelectedFeeldList\
end\
\
-- 点击舰队\
battle.clickFleet = function(clickFleetList)\
  if type(clickFleetList) ~= 'table' then\
    clickFleetList = { clickFleetList }\
  end\
  for _, fleet in ipairs(clickFleetList) do\
    if fleet == 1 then\
      tap(479, 842)\
    elseif fleet == 2 then\
      tap(689, 844)\
    elseif fleet == 3 then\
      tap(901, 843)\
    elseif fleet == 4 then\
      tap(1119, 845)\
    end\
    mSleep(50)\
  end\
end\
\
\
-- 前往地图\
battle.clickGotoMapBtn = function()\
  tap(1588, 934, 100)\
end\
\
--  是否在地图页面\
battle.isMapPage = function()\
  local __keepScreenState = keepScreenState\
  if not __keepScreenState then keepScreen(true) end\
  local list = {\
    { 16, 19, 0xdee3de }, { 824, 17, 0xeff3f7 },\
    { 1021, 35, 0x3a3d3a }, { 1332, 33, 0xffef5a },\
    { 1647, 35, 0xff4573 }, { 1074, 1021, 0xeff3ef },\
    { 1404, 998, 0xf7f7f7 }, { 1692, 1003, 0xf7fbf7 },\
    { 895, 993, 0xdedfde }, { 938, 1020, 0xbdbabd },\
    { 420, 47, 0x000000 }, { 447, 47, 0x000000 },\
    { 459, 44, 0xefefff }, { 516, 50, 0xefebff },\
    { 556, 44, 0xf7f3ff },\
  }\
  local result = multiColorS(list)\
  if not __keepScreenState then keepScreen(false) end\
  return result\
end\
\
-- 检测是第几队\
battle.scanMapCheckFleetNum = function()\
  local __keepScreenState = keepScreenState\
  keepScreen(true)\
  local list1 = {\
    { 301, 101, 0x424542 }, { 321, 94, 0xf7efbd },\
    { 329, 111, 0x424142 }, { 318, 123, 0xf7c642 },\
    { 311, 139, 0x424142 }, { 319, 152, 0x424142 },\
    { 329, 137, 0x424131 }, { 324, 148, 0xffba00 },\
    { 312, 109, 0xf7e39c },\
  }\
  local list2 = {\
    { 305, 112, 0xefdf9c }, { 319, 105, 0x42453a },\
    { 320, 95, 0xf7ebb5 }, { 324, 107, 0xf7df94 },\
    { 334, 112, 0xffdf7b }, { 316, 126, 0xf7c24a },\
    { 322, 136, 0xdeae21 }, { 301, 146, 0x424142 },\
    { 324, 138, 0x424142 }, { 337, 144, 0x424142 },\
  }\
  local list3 = {\
    { 302, 110, 0x524531 }, { 320, 106, 0x424542 },\
    { 326, 108, 0xffe39c }, { 312, 118, 0x4a4d4a },\
    { 316, 120, 0xffd763 }, { 308, 126, 0x424542 },\
    { 306, 130, 0xefc242 }, { 320, 150, 0xffb600 },\
    { 320, 140, 0x424542 }, { 338, 139, 0x424142 },\
  }\
  local list4 = {\
    { 315, 93, 0xf7e7b5 }, { 327, 90, 0x424142 },\
    { 333, 114, 0x635531 }, { 334, 127, 0x423d31 },\
    { 334, 133, 0xf7be21 }, { 326, 147, 0xefba19 },\
    { 302, 135, 0xefbe29 }, { 315, 125, 0x424542 },\
    { 316, 119, 0x5a513a }, { 325, 151, 0x424142 },\
  }\
  local result = 1\
  if multiColorS(list1) then\
    result = 1\
  elseif multiColorS(list2) then\
    result = 2\
  elseif multiColorS(list3) then\
    result = 3\
  elseif multiColorS(list4) then\
    result = 4\
  end\
  if not __keepScreenState then keepScreen(false) end\
  return result\
end\
\
-- 是否选中指定舰队\
battle.isSelectedFleed = function(fleet)\
  local __keepScreenState = keepScreenState\
  if not __keepScreenState then keepScreen(true) end\
  local list\
  if fleet == 1 then\
    list = {\
      { 301, 101, 0x424542 }, { 321, 94, 0xf7efbd },\
      { 329, 111, 0x424142 }, { 318, 123, 0xf7c642 },\
      { 311, 139, 0x424142 }, { 319, 152, 0x424142 },\
      { 329, 137, 0x424131 }, { 324, 148, 0xffba00 },\
      { 312, 109, 0xf7e39c },\
    }\
  elseif fleet == 2 then\
    list = {\
      { 305, 112, 0xefdf9c }, { 319, 105, 0x42453a },\
      { 320, 95, 0xf7ebb5 }, { 324, 107, 0xf7df94 },\
      { 334, 112, 0xffdf7b }, { 316, 126, 0xf7c24a },\
      { 322, 136, 0xdeae21 }, { 301, 146, 0x424142 },\
      { 324, 138, 0x424142 }, { 337, 144, 0x424142 },\
    }\
  elseif fleet == 3 then\
    list = {\
      { 302, 110, 0x524531 }, { 320, 106, 0x424542 },\
      { 326, 108, 0xffe39c }, { 312, 118, 0x4a4d4a },\
      { 316, 120, 0xffd763 }, { 308, 126, 0x424542 },\
      { 306, 130, 0xefc242 }, { 320, 150, 0xffb600 },\
      { 320, 140, 0x424542 }, { 338, 139, 0x424142 },\
    }\
  elseif fleet == 4 then\
    list = {\
      { 315, 93, 0xf7e7b5 }, { 327, 90, 0x424142 },\
      { 333, 114, 0x635531 }, { 334, 127, 0x423d31 },\
      { 334, 133, 0xf7be21 }, { 326, 147, 0xefba19 },\
      { 302, 135, 0xefbe29 }, { 315, 125, 0x424542 },\
      { 316, 119, 0x5a513a }, { 325, 151, 0x424142 },\
    }\
  end\
  local result = multiColorS(list)\
  if not __keepScreenState then keepScreen(false) end\
  return result\
end\
\
-- 地图点击切换舰队按钮\
battle.clickSwitchFleetBtn = function()\
  tap(1426, 1003, 100)\
end\
\
-- 地图点击迎击\
battle.clickAttackBtn = function()\
  tap(1740, 1005, 100)\
end\
\
-- 检测阵型面板是否打开\
battle.isFormationPanel = function()\
  local __keepScreenState = keepScreenState\
  if not __keepScreenState then keepScreen(true) end\
  local list = {\
    { 1593, 531, 0xffe739 }, { 1593, 574, 0xffe73a },\
    { 1612, 552, 0xffeb3a }, { 1827, 537, 0x08cea4 },\
    { 1834, 531, 0x08cea5 }, { 1856, 525, 0x00cfa5 },\
    { 1865, 566, 0x21a28c }, { 1834, 560, 0x21b294 },\
  }\
  local result = multiColorS(list)\
  if not __keepScreenState then keepScreen(false) end\
  return result\
end\
\
-- 关闭阵型面板\
battle.closeFormationPanel = function()\
  tap(1603, 553, 100)\
end\
\
-- 检测敌方伏击面板\
battle.isAmbushedPanel = function()\
  local __keepScreenState = keepScreenState\
  if not __keepScreenState then keepScreen(true) end\
  local list = {\
    { 369, 678, 0x527119 }, { 399, 671, 0x527521 },\
    { 428, 680, 0xfffbf7 }, { 803, 562, 0xf7ca3a },\
    { 955, 565, 0xffffff }, { 1055, 597, 0xffa619 },\
    { 1237, 540, 0xe6e7e6 }, { 1349, 568, 0xffffff },\
    { 1485, 593, 0xc5bebd }, { 1200, 685, 0x5a595a },\
  }\
  local result = multiColorS(list)\
  if not __keepScreenState then keepScreen(false) end\
  return result\
end\
\
-- 迎击伏击\
battle.ambushedPanelClickInterceptBtn = function()\
  tap(922, 571)\
end\
\
-- 躲避伏击\
battle.ambushedPanelClickAvoidBtn = function()\
  tap(1351, 564)\
end\
\
-- 检测信息弹窗\
battle.isInfomationModal = function()\
  local __keepScreenState = keepScreenState\
  if not __keepScreenState then keepScreen(true) end\
  local list = {\
    { 463, 250, 0xeff3f7 }, { 938, 261, 0xe6f3f7 },\
    { 1447, 255, 0xadaaad }, { 1391, 282, 0xf7ce42 },\
    { 845, 709, 0xffdf52 }, { 947, 707, 0xffdb52 },\
    { 1093, 708, 0x943d00 }, { 960, 778, 0xffba21 },\
    { 840, 775, 0xf7b219 }, { 1088, 776, 0xffb221 },\
    { 920, 726, 0xffffff }, { 954, 746, 0xffffff },\
    { 984, 746, 0xffffff }, { 998, 774, 0xffb221 },\
  }\
  local result = multiColorS(list)\
  if not __keepScreenState then keepScreen(false) end\
  return result\
end\
\
-- 关闭信息弹窗\
battle.infomationModalClickClose = function()\
  tap(1391, 281)\
end\
\
-- 移动到敌人\
battle.moveToEnemy = function(point)\
  tap(point[1], point[2])\
end\
\
-- 检测准备战斗面板\
battle.isReadyBattlePage = function()\
  local __keepScreenState = keepScreenState\
  if not __keepScreenState then keepScreen(true) end\
  local list = {\
    { 41, 34, 0xf7d242 }, { 14, 13, 0xdee3de },\
    { 169, 27, 0x293129 }, { 204, 29, 0x63593a },\
    { 244, 32, 0xb59e52 }, { 292, 39, 0x313531 },\
    { 330, 44, 0x94929c }, { 359, 49, 0x191c21 },\
    { 527, 13, 0xeff3f7 }, { 738, 16, 0xeff3f7 },\
    { 1305, 208, 0x080808 }, { 1269, 209, 0xefefef },\
    { 1893, 217, 0xefebef }, { 1267, 509, 0xefefef },\
    { 1284, 507, 0xdeebde }, { 1319, 506, 0xd6dbd6 },\
    { 1336, 510, 0x100c10 }, { 1389, 889, 0xd6f3f7 },\
    { 1752, 903, 0xceeff7 }, { 1589, 929, 0xfff794 },\
    { 1025, 31, 0x3a3d3a }, { 1070, 35, 0xd6d7d6 },\
    { 1333, 28, 0xfff363 }, { 1393, 30, 0xdedfde },\
    { 1644, 30, 0xff4973 }, { 1701, 31, 0xdedbde },\
  }\
  local result = multiColorS(list)\
  if not __keepScreenState then keepScreen(false) end\
  return result\
end\
\
-- 准备战斗面板点击出击\
battle.readyBattlePageClickBattle = function()\
  tap(1592, 952)\
end\
\
-- 检测是否在战斗中\
battle.isInBattlePage = function()\
  local __keepScreenState = keepScreenState\
  if not __keepScreenState then keepScreen(true) end\
  local list = {\
    { 91, 78, 0x313942 }, { 131, 51, 0x4a5963 },\
    { 307, 61, 0x4a5963 }, { 344, 47, 0xbdced6 },\
    { 312, 109, 0x313d42 }, { 1818, 40, 0xdedfde },\
    { 1835, 66, 0x3a353a }, { 1875, 92, 0xdedfd6 },\
    { 1860, 56, 0x292d29 },\
  }\
  local result = multiColorS(list)\
  if not __keepScreenState then keepScreen(false) end\
  return result\
end\
\
-- 检测是否自动战斗\
battle.isNotAutoBattle = function()\
  local __keepScreenState = keepScreenState\
  if not __keepScreenState then keepScreen(true) end\
  local list = {\
    { 144, 68, 0xffffff }, { 154, 67, 0xffffff },\
    { 154, 76, 0xe6e6e6 }, { 161, 84, 0xffffff },\
    { 168, 91, 0xffffff }, { 180, 68, 0xffffff },\
    { 180, 86, 0xffffff }, { 195, 78, 0xffffff },\
    { 207, 88, 0xffffff }, { 205, 71, 0xffffff },\
  }\
  local result = multiColorS(list)\
  if not __keepScreenState then keepScreen(false) end\
  return result\
end\
\
-- 检测是否自动战斗确认面板\
battle.isAutoBattleConfirmPanel = function()\
  local __keepScreenState = keepScreenState\
  if not __keepScreenState then keepScreen(true) end\
  local list = {\
    { 477, 232, 0x292829 }, { 1437, 227, 0xadaaad },\
    { 688, 329, 0xf7f7f7 }, { 785, 343, 0xe6e7e6 },\
    { 904, 346, 0xfffbff }, { 998, 337, 0xdeebde },\
    { 1127, 344, 0xeff3ef }, { 1206, 333, 0xeff3ef },\
    { 862, 754, 0xffdb4a }, { 928, 775, 0xffffff },\
  }\
  local result = multiColorS(list)\
  if not __keepScreenState then keepScreen(false) end\
  return result\
end\
\
-- 自动战斗确认面板点击知道了\
battle.autoBattleConfirmPanelClickOk = function()\
  tap(949, 779)\
end\
\
-- 战斗页面点击自动战斗\
battle.inBattlePageClickAutoBattle = function()\
  tap(208, 75)\
end\
\
-- 检测是否胜利界面\
battle.isVictoryPanel = function()\
  local __keepScreenState = keepScreenState\
  if not __keepScreenState then keepScreen(true) end\
  -- 大获全胜\
  local list = {\
    { 557, 442, 0xf7d24a }, { 614, 492, 0xfffb5a },\
    { 674, 555, 0xe67d31 }, { 853, 543, 0xef8a3a },\
    { 1076, 484, 0xffff5a }, { 1211, 539, 0xef9242 },\
    { 1350, 476, 0xffff5a }, { 523, 474, 0xffef9c },\
    { 699, 441, 0x5a1c10 }, { 961, 439, 0x632410 },\
    { 1132, 455, 0x632819 }, { 1299, 456, 0x5a2410 },\
    { 1386, 481, 0x521c10 },\
    { 257, 696, 0x423d42 }, { 563, 696, 0x423d42 },\
    { 976, 699, 0x3a3d3a }, { 1398, 698, 0x424142 },\
    { 1658, 698, 0x424142 },\
    { 932, 474, 0x8c8183 }, { 1187, 492, 0x8c8a84 },\
  }\
  -- 战术碾压\
  local list2 = {\
    { 611, 440, 0xf7d74a }, { 666, 500, 0xfff35a },\
    { 855, 479, 0xffff5a }, { 1110, 432, 0xffce52 },\
    { 1218, 529, 0xefa63a }, { 1395, 482, 0xfffb5a },\
    { 568, 468, 0x632419 }, { 902, 441, 0x5a2010 },\
    { 987, 448, 0x632010 }, { 1234, 442, 0x6b2819 },\
    { 537, 429, 0xfff394 }, { 1253, 565, 0x6b2410 },\
    { 1295, 426, 0x632010 }, { 1080, 495, 0x632819 },\
\
    { 294, 702, 0x424142 }, { 523, 697, 0x424142 },\
    { 967, 698, 0x423d42 }, { 1424, 697, 0x3a3d3a },\
  }\
  -- 完成任务\
  local list3 = {\
    { 556, 437, 0x6bc6de }, { 615, 438, 0x6bcede },\
    { 676, 472, 0xb5f3ff }, { 855, 472, 0xb5f3ff },\
    { 1092, 546, 0x31b2c5 }, { 1163, 508, 0x94e3ef },\
    { 1384, 430, 0x6bc6de }, { 647, 477, 0x10595a },\
    { 845, 488, 0x104552 }, { 1052, 459, 0x10555a },\
\
    { 309, 698, 0x424142 }, { 711, 701, 0x424142 },\
    { 1189, 698, 0x424142 }, { 1584, 701, 0x423d3a },\
  }\
  -- 旗舰大破\
  local list4 = {\
    { 563, 438, 0xe6a273 }, { 844, 495, 0xde965a },\
    { 1046, 479, 0xe6be9c }, { 1212, 461, 0xefc2a4 },\
    { 1370, 471, 0xe6aa7b }, { 536, 454, 0x521810 },\
    { 522, 467, 0xffebd6 }, { 863, 487, 0x5a1c10 },\
    { 1088, 447, 0x632819 }, { 1386, 457, 0x521c08 },\
    { 249, 698, 0x423d42 }, { 527, 696, 0x424142 },\
    { 907, 697, 0x424142 }, { 1389, 697, 0x424142 },\
    { 1636, 698, 0x424142 },\
  }\
  -- d 全军覆没\
  local list5 = {\
    { 550, 445, 0xde9e63 }, { 899, 476, 0xe6a273 },\
    { 1088, 466, 0xefc6ad }, { 1219, 489, 0xdea673 },\
    { 1420, 497, 0xe69e63 }, { 543, 422, 0x521808 },\
    { 855, 458, 0x5a1c08 }, { 1012, 455, 0x632819 },\
    { 1276, 463, 0x5a2410 }, { 1368, 480, 0x5a2010 },\
\
    { 279, 726, 0x423d42 }, { 525, 700, 0x423d42 },\
    { 955, 698, 0x423d42 }, { 1366, 698, 0x424142 },\
    { 1687, 734, 0x424142 },\
  }\
  -- c 作战超时\
  local list6 = {\
    { 553, 441, 0xe69e6b }, { 584, 440, 0xefba94 },\
    { 676, 439, 0xdeaa7b }, { 685, 534, 0xdea273 },\
    { 565, 549, 0xefaa7b }, { 852, 441, 0xe69663 },\
    { 844, 499, 0xde965a }, { 937, 484, 0xe6a67b },\
    { 1087, 473, 0xefc6a4 }, { 1186, 522, 0xefceb5 },\
    { 941, 533, 0xefaa7b }, { 997, 530, 0xdeb68c },\
    { 1090, 519, 0xefc2a4 }, { 1159, 542, 0xefc6ad },\
    { 1270, 507, 0xe6be9c }, { 1347, 504, 0xdeae84 },\
    { 1387, 487, 0xefa67b }, { 1416, 441, 0xe69e6b },\
    { 1423, 505, 0xe69e6b }, { 1391, 549, 0xe6a673 },\
\
    { 383, 714, 0xef5d63 }, { 755, 711, 0xef6163 },\
    { 1241, 713, 0xef6163 }, { 1327, 463, 0x632010 },\
  }\
  local result = false\
  if multiColorS(list) or multiColorS(list2)\
    or multiColorS(list3) or multiColorS(list4)\
    or multiColorS(list5) or multiColorS(list6) then\
    result = true\
  end\
  if not __keepScreenState then keepScreen(false) end\
  return result\
end\
\
-- 胜利面板点击继续\
battle.victoryPanelClickNext = function()\
  tap(952, 840)\
end\
\
-- 检测是否获得道具面板\
battle.isGetPropsPanel = function()\
  local __keepScreenState = keepScreenState\
  if not __keepScreenState then keepScreen(true) end\
  local list = {\
    { 763, 212, 0xf7ae63 }, { 854, 168, 0xffffff },\
    { 958, 174, 0x845131 }, { 1054, 167, 0xf7f384 },\
    { 764, 242, 0xffaa42 }, { 861, 232, 0x7b2408 },\
    { 944, 240, 0xffffff }, { 1006, 268, 0xffdf3a },\
    { 1098, 277, 0xf7b629 }, { 969, 809, 0xffffff },\
  }\
  local result = multiColorS(list)\
  if not __keepScreenState then keepScreen(false) end\
  return result\
end\
\
-- 获得道具面板点击继续\
battle.getPropsPanelClickNext = function()\
  tap(952, 840)\
end\
\
-- 检测是否获得船面板\
battle.isGetNewShipPanel = function()\
  local __keepScreenState = keepScreenState\
  if not __keepScreenState then keepScreen(true) end\
  local list = {\
    { 64, 504, 0xefefff }, { 108, 539, 0x7b7d8c },\
    { 86, 658, 0xe6c2c5 }, { 91, 787, 0xe6d7ce },\
    { 83, 906, 0x3acee6 }, { 88, 948, 0xcecece },\
    { 1496, 852, 0xefefef }, { 1572, 909, 0xc5c2bd },\
    { 1543, 938, 0xeff3ef },\
  }\
  local result = multiColorS(list)\
  if not __keepScreenState then keepScreen(false) end\
  return result\
end\
\
-- 获得船面板点击继续\
battle.getNewShipPanelClickNext = function()\
  tap(952, 840)\
end\
\
-- 检测是否获得经验面板\
battle.isGetExpPanel = function()\
  local __keepScreenState = keepScreenState\
  if not __keepScreenState then keepScreen(true) end\
  local list = {\
    { 548, 297, 0x63656b }, { 658, 277, 0x63656b },\
    { 984, 274, 0x6b696b }, { 1260, 278, 0x6b696b },\
    { 1374, 289, 0x636563 }, { 248, 734, 0x424142 },\
    { 1294, 922, 0xbdbabd }, { 1363, 911, 0x4a494a },\
    { 1533, 912, 0xd6d2d6 }, { 1681, 926, 0xbdbab5 },\
    { 1587, 884, 0xe6ebe6 }, { 1599, 916, 0xffffff },\
  }\
  local result = multiColorS(list)\
  if not __keepScreenState then keepScreen(false) end\
  return result\
end\
\
-- 获得经验面板点击继续\
battle.getExpPanelClickNext = function()\
  tap(1671, 914)\
end\
\
-- 点击返回主页\
battle.battlePageClickBackToHome = function()\
  tap(46, 37)\
end\
\
-- 检测是否紧急委托面板\
battle.isUrgentEntrustmentPanel = function()\
  local __keepScreenState = keepScreenState\
  if not __keepScreenState then keepScreen(true) end\
  local list = {\
    { 482, 289, 0x212821 }, { 493, 288, 0xffce3a },\
    { 534, 293, 0x080808 }, { 567, 292, 0xf7c23a },\
    { 752, 302, 0x000000 }, { 1047, 301, 0xdedfde },\
    { 835, 737, 0xffca3a }, { 919, 740, 0xffffff },\
    { 977, 745, 0xefb231 }, { 1002, 736, 0xfff7f7 },\
  }\
  local result = multiColorS(list)\
  if not __keepScreenState then keepScreen(false) end\
  return result\
end\
\
-- 紧急委托面板点击继续\
battle.urgentEntrustmentPanelClickOk = function()\
  tap(957, 739)\
end\
\
return battle" }


package.sourceCode = package.sourceCode or {}
package.sourceCode["./missions/utils.lua"] = { path = "./missions/utils.lua", name = "./missions/utils.lua", source = "local eq = require '../lib/event-query'\
local co = require '../lib/co'\
local c = coroutine\
\
local combineListener = function(target, ...)\
  local sources = { ... }\
  if (type(target) ~= 'table') then\
    target = {}\
  end\
  for k = 1, #sources do\
    local source = sources[k]\
    for key = 1, #source do\
      local value = source[key]\
      table.insert(target, value)\
    end\
  end\
  local targetReverse = table.reverse(target)\
  local resultIndex = {}\
  local result = {}\
  for key = 1, #targetReverse do\
    local value = targetReverse[key]\
    if (not resultIndex[value[3]]) then\
      resultIndex[value[3]] = value\
      table.insert(result, value)\
    end\
  end\
\
  local resultReverse = table.reverse(result)\
  return resultReverse\
end\
\
local setScreenListeners = function(...)\
  local firstArr = select('1', ...)\
\
  if type(firstArr) ~= 'table' then\
    return Promise.reject(error('the param 1 of \"setScreenListeners\" is nil.', 2))\
  end\
\
  local theArr = table.merge(...)\
\
  local errorList = {}\
  for key = 1, #theArr do\
    local value = theArr[key]\
    if not value[2] then\
      table.insert(errorList, value)\
    end\
  end\
  if #errorList > 0 then\
    local errorMsg = ''\
    for key = 1, #errorList do\
      local value = errorList[key]\
      if not value[2] then\
        errorMsg = errorMsg .. 'the function of \"' .. value[1] .. '\" is nil.' .. '\\n'\
      end\
    end\
    error(errorMsg, 2)\
  end\
\
  local theArrUnique = table.uniqueLast(theArr, 2)\
  for key = 1, #theArrUnique do\
    local value = theArrUnique[key]\
    value.isOnce = true\
  end\
  return co(c.create(function()\
    local newArr = {}\
    local ids = {}\
    local done = false\
    for key = 1, #theArrUnique do\
      local listenerEvent = theArrUnique[key]\
      if type(listenerEvent[3]) == 'number' and listenerEvent[3] > 0 then\
        table.insert(newArr,\
          Promise.new(function(resolve)\
            local id = eq.setTimeout(resolve, listenerEvent[3])\
            table.insert(ids, id)\
          end).andThen(function()\
            if (not done) then\
              return Promise.new(function(resolve)\
                local id = eq.setScreenListener(listenerEvent[2], function()\
                  resolve(listenerEvent[1])\
                end)\
                table.insert(ids, id)\
              end)\
            end\
          end))\
      else\
        table.insert(newArr, co(c.create(function()\
          return Promise.new(function(resolve)\
            local id = eq.setScreenListener(listenerEvent[2], function()\
              resolve(listenerEvent[1])\
            end)\
            table.insert(ids, id)\
          end)\
        end)))\
      end\
    end\
    local res = c.yield(Promise.race(newArr))\
    done = true\
    for key = 1, #ids do\
      eq.clearScreenListener(ids[key])\
      eq.clearTimeout(ids[key])\
    end\
    return res\
  end))\
end\
\
local makeAction = function(action)\
  if (type(action) == 'table') then\
    return action\
  end\
  return { type = action }\
end\
\
return {\
  combineListener = combineListener,\
  setScreenListeners = setScreenListeners,\
  makeAction = makeAction,\
}\
" }


package.sourceCode = package.sourceCode or {}
package.sourceCode["./missions/scan-map-type-1.lua"] = { path = "./missions/scan-map-type-1.lua", name = "./missions/scan-map-type-1.lua", source = "local co = require '../lib/co'\
local c = coroutine\
local stepLabel = require '../utils/step-label'\
local makeAction = (require './utils').makeAction\
local sleepPromise = require '../utils/sleep-promise'\
local moBattle = require '../meta-operation/battle'\
local moHome = require '../meta-operation/home'\
local moMap = require '../meta-operation/maps-options/index'\
local setScreenListeners = (require './utils').setScreenListeners\
local store = require '../store'\
\
-- type2 的过程：先让道中队走到 boss 点前，再让道中队走到 boss 队前，最后 boss 队打 boss\
\
-- 设置  store 的默认值\
store.scanMapType1 = store.scanMapType1 or {\
  selectFleedCount = 0,\
  isBossFleetInBossArea = false,\
  battleNum = 0,\
  battleWithConvoyNum = 0,\
  battleFromState = '',\
  checkpositionListForCheck = nil,\
  checkpositionListForMove = {},\
  oldMapChessboard = nil,\
  mapChessboard = {},\
  currentPosition = nil,\
  nextStepPoint = nil,\
  moveVectorForCheck = { -1, -1 },\
}\
\
local o = {\
  home = moHome,\
  battle = moBattle,\
  map = moMap,\
}\
\
local comparePoints = function(point1, point2)\
  return point1[1] == point2[1] and point1[2] == point2[2]\
end\
\
\
local battleListenerList = {\
  { '', o.home.isHome, 2000 },\
  { 'BATTLE_MAP_PAGE_AMBUSHED_PANEL_AVOID_AMBUSHED', o.battle.isAmbushedPanel, 2000 },\
  { 'BATTLE_BATTLE_CHAPTER_PAGE_BACK_TO_HOME', o.battle.isBattleChapterPage, 2000 },\
  { 'BATTLE_BATTLE_CHAPTER_PAGE_INFO_PANEL_CLICK_INTO', o.battle.isChapterInfoPanel, 2000 },\
  { 'BATTLE_BATTLE_CHAPTER_PAGE_SELECT_FLEET_PANEL_SELECT_FLEET', o.battle.isSelectFleetPanel, 2000 },\
  { 'BATTLE_BATTLE_CHAPTER_PAGE_HARD_SELECT_FLEET_PANEL_CLICK_INTO', o.battle.isHardSelectFleetPanel, 500 },\
  { 'BATTLE_MAP_PAGE', o.battle.isMapPage, 2000 },\
  { 'BATTLE_MAP_PAGE_CLOSE_FORMAT_PANEL', o.battle.isFormationPanel, 2000 },\
  { 'BATTLE_READY_BATTLE_PAGE_CLICK_BATTLE', o.battle.isReadyBattlePage, 2000 },\
  { 'BATTLE_IN_BATTLE_PAGE', o.battle.isInBattlePage, 2000 },\
  { 'BATTLE_VICTORY_PAGE', o.battle.isVictoryPanel, 2000 },\
  { 'BATTLE_GET_PROPS_PANEL', o.battle.isGetPropsPanel, 2000 },\
  { 'BATTLE_GET_NEW_SHIP_PANEL', o.battle.isGetNewShipPanel, 2000 },\
  { 'BATTLE_GET_EXP_PANEL', o.battle.isGetExpPanel, 2000 },\
}\
\
local mapsType2 = function(action)\
  local settings = store.settings;\
  local mapProxy = o.map['map' .. settings.battleChapter]\
  return co(c.create(function()\
    if action.type == 'SCAN_MAP_TYPE_1_PRE_INIT' then\
\
      -- 这部分流程只会在每次开启新的一局时才调用一次，而不是每次寻路就调用一次\
\
      stepLabel.setStepLabelContent('3-1.开局预备变量')\
      store.scanMapType1.selectFleedCount = 0\
      -- boss舰队是否在boss区域\
      store.scanMapType1.isBossFleetInBossArea = false\
      store.scanMapType1.battleNum = 0\
      store.scanMapType1.battleWithConvoyNum = 0\
      store.scanMapType1.battleFromState = ''\
      -- 切换船的次数，如果超过4次没切换成功表示舰队沉了。\
      store.scanMapType1.changeFleetNum = 0\
      -- 舰队移动的状态。\
      store.scanMapType1.missionStep = 'onWayFleetMoveToWaitBoss'\
      store.scanMapType1.checkpositionListForCheck = nil\
      store.scanMapType1.checkpositionListForMove = {}\
      store.scanMapType1.mapChessboard = mapProxy and mapProxy.getMapChessboard(settings.battleChapter) or {}\
      store.scanMapType1.newMapChessboard = mapProxy and mapProxy.getMapChessboard(settings.battleChapter) or {}\
\
      return makeAction('')\
\
    elseif action.type == 'SCAN_MAP_TYPE_1_INIT' then\
\
      -- 每次进入地图页面时就会执行一次\
\
      store.scanMapType1.checkpositionListForCheck = mapProxy.getCheckpositionList()\
      -- 先用 newMapChessboard 完成扫描，然后再与 mapChessboard 合并。这样就可以做新老版本的对比，避免被挡住的问题\
      store.scanMapType1.newMapChessboard = mapProxy.getMapChessboard(settings.battleChapter)\
      return makeAction('SCAN_MAP_TYPE_1_START')\
\
    elseif action.type == 'SCAN_MAP_TYPE_1_START' then\
\
      -- 检查上次移动舰队时所在的位置，并将其提前。有利于提高扫描速度\
      if #store.scanMapType1.checkpositionListForMove > 0 then\
        local cForMove = store.scanMapType1.checkpositionListForMove[1]\
        local index = table.findIndex(store.scanMapType1.checkpositionListForCheck, function(cForCheck)\
          if cForMove.leftTop and cForCheck.leftTop then\
            return cForMove.leftTop[1] == cForCheck.leftTop[1] and cForMove.leftTop[2] == cForCheck.leftTop[2]\
          elseif cForMove.rightTop and cForCheck.rightTop then\
            return cForMove.rightTop[1] == cForCheck.rightTop[1] and cForMove.rightTop[2] == cForCheck.rightTop[2]\
          elseif cForMove.leftBotton and cForCheck.leftBotton then\
            return cForMove.leftBotton[1] == cForCheck.leftBotton[1] and cForMove.leftBotton[2] == cForCheck.leftBotton[2]\
          elseif cForMove.rightBotton and cForCheck.rightBotton then\
            return cForMove.rightBotton[1] == cForCheck.rightBotton[1] and cForMove.rightBotton[2] == cForCheck.rightBotton[2]\
          end\
        end)\
        if index > 0 then\
          local cfm = store.scanMapType1.checkpositionListForCheck[index]\
          table.remove(store.scanMapType1.checkpositionListForCheck, index)\
          table.insert(store.scanMapType1.checkpositionListForCheck, 1, cfm)\
        end\
      end\
      return makeAction('SCAN_MAP_TYPE_1_MOVE_TO_CHECK_POSITION_FOR_CHECK')\
\
    elseif action.type == 'SCAN_MAP_TYPE_1_MOVE_TO_CHECK_POSITION_FOR_CHECK' then\
\
      stepLabel.setStepLabelContent('3-2.获取地图位置参数')\
      local targetPosition = store.scanMapType1.checkpositionListForCheck[1]\
      local currentPosition = mapProxy.getMapPosition(targetPosition)\
      console.log(currentPosition)\
      stepLabel.setStepLabelContent('3-3.计算移动向量')\
      local targetPosition = store.scanMapType1.checkpositionListForCheck[1]\
      local newMoveVector, effectiveStep = mapProxy.getMoveVector(currentPosition, targetPosition)\
      console.log(newMoveVector)\
      if effectiveStep and comparePoints(store.scanMapType1.moveVectorForCheck, newMoveVector) then\
        store.scanMapType1.moveVectorForCheck = newMoveVector\
        local newstateTypes = c.yield(setScreenListeners(battleListenerList, {\
          { 'SCAN_MAP_TYPE_1_SCAN_MAP', o.battle.isMapPage, 1000 },\
        }))\
        return makeAction(newstateTypes)\
      end\
\
      stepLabel.setStepLabelContent('3-3.移动地图')\
      local isCenter = mapProxy.moveMapToCheckPosition(newMoveVector)\
      if isCenter then\
        -- 地图已经移动到位\
        local newstateTypes = c.yield(setScreenListeners(battleListenerList, {\
          { 'SCAN_MAP_TYPE_1_SCAN_MAP', o.battle.isMapPage, 1000 },\
        }))\
        return makeAction(newstateTypes)\
      else\
        -- 地图没有移动到位\
        local newstateTypes = c.yield(setScreenListeners(battleListenerList, {\
          { 'SCAN_MAP_TYPE_1_MOVE_TO_CHECK_POSITION_FOR_CHECK', o.battle.isMapPage, 500 },\
        }))\
        return makeAction(newstateTypes)\
      end\
      console.log(newMoveVector)\
      store.scanMapType1.moveVectorForCheck = newMoveVector\
      local newstateTypes = c.yield(setScreenListeners(battleListenerList, {\
        { 'SCAN_MAP_TYPE_1_MOVE_TO_CHECK_POSITION_FOR_CHECK', o.battle.isMapPage, 500 },\
      }))\
      return makeAction(newstateTypes)\
\
    elseif action.type == 'SCAN_MAP_TYPE_1_SCAN_MAP' then\
\
      stepLabel.setStepLabelContent('3-5.扫描地图')\
      local targetPosition = store.scanMapType1.checkpositionListForCheck[1]\
      store.scanMapType1.newMapChessboard = mapProxy.scanMap(targetPosition, store.scanMapType1.newMapChessboard)\
      console.log(store.scanMapType1.newMapChessboard)\
      -- 地图没扫描完，继续扫描\
      if #store.scanMapType1.checkpositionListForCheck > 1 then\
        table.remove(store.scanMapType1.checkpositionListForCheck, 1)\
        local newstateTypes = c.yield(setScreenListeners(battleListenerList, {\
          { 'SCAN_MAP_TYPE_1_MOVE_TO_CHECK_POSITION_FOR_CHECK', o.battle.isMapPage },\
        }))\
        return makeAction(newstateTypes)\
      end\
\
      -- 扫描完毕，将 newMapChessboard 与 mapChessboard 合并\
      store.scanMapType1.mapChessboard = mapProxy.assignMapChessboard(store.scanMapType1.mapChessboard, store.scanMapType1.newMapChessboard)\
\
      -- 将道中队和boss队分位置别标记\
      if not store.scanMapType1.mapChessboard.myFleetList[2] then\
        store.scanMapType1.mapChessboard.bossFleet = store.scanMapType1.mapChessboard.myFleetList[1]\
        store.scanMapType1.mapChessboard.onWayFleet = store.scanMapType1.mapChessboard.myFleetList[1]\
      elseif o.battle.isSelectedFleed(settings.battleFleet[1]) then\
        store.scanMapType1.mapChessboard.bossFleet = store.scanMapType1.mapChessboard.myFleetList[1]\
        store.scanMapType1.mapChessboard.onWayFleet = store.scanMapType1.mapChessboard.myFleetList[2]\
      else\
        store.scanMapType1.mapChessboard.bossFleet = store.scanMapType1.mapChessboard.myFleetList[2]\
        store.scanMapType1.mapChessboard.onWayFleet = store.scanMapType1.mapChessboard.myFleetList[1]\
      end\
\
      console.log(store.scanMapType1.mapChessboard)\
      -- 如果扫描内容是空的，重新扫描\
      if #store.scanMapType1.mapChessboard.myFleetList == 0 then\
        local newstateTypes = c.yield(setScreenListeners(battleListenerList, {\
          { 'SCAN_MAP_TYPE_1_INIT', o.battle.isMapPage },\
        }))\
      end\
\
      -- 进入移动步骤\
      local newstateTypes = c.yield(setScreenListeners(battleListenerList, {\
        { 'BATTLE_MAP_PAGE_CHECK_MAP_MODE', o.battle.isMapPage },\
      }))\
      return makeAction(newstateTypes)\
    end\
\
    return nil\
  end))\
end\
\
return mapsType2\
\
" }


package.sourceCode = package.sourceCode or {}
package.sourceCode["./missions/maps-type-4.lua"] = { path = "./missions/maps-type-4.lua", name = "./missions/maps-type-4.lua", source = "local co = require '../lib/co'\
local c = coroutine\
local stepLabel = require '../utils/step-label'\
local makeAction = (require './utils').makeAction\
local sleepPromise = require '../utils/sleep-promise'\
local moBattle = require '../meta-operation/battle'\
local moHome = require '../meta-operation/home'\
local moMap = require '../meta-operation/maps-options/index'\
local setScreenListeners = (require './utils').setScreenListeners\
local store = require '../store'\
\
-- type2 的过程：先让道中队走到 boss 点前，再让道中队走到 boss 队前，最后 boss 队打 boss\
\
-- 设置  store 的默认值\
store.mapType4 = store.mapType4 or {\
  selectFleedCount = 0,\
  isBossFleetInBossArea = false,\
  battleNum = 0,\
  battleWithConvoyNum = 0,\
  battleFromState = '',\
  checkpositionListForCheck = nil,\
  checkpositionListForMove = {},\
  oldMapChessboard = nil,\
  mapChessboard = {},\
  currentPosition = nil,\
  nextStepPoint = nil,\
  nextStepFleed = nil,\
  moveVectorForAStep = { -1, -1 },\
  moveFailTimes = 0,\
}\
\
-- maps-type2 的行动流程\
local missionStepList = {\
  'onWayFleetMoveToWaitBoss',\
  'onWayFleetMoveToBossFleet',\
  'onWayFleetMoveToClosestEnemy',\
  'bossFleetMoveToWaitBoss',\
  'bossFleetMoveToBoss',\
  'randomMoveAStep',\
}\
\
local o = {\
  home = moHome,\
  battle = moBattle,\
  map = moMap,\
}\
\
local comparePoints = function(point1, point2)\
  if type(point1) ~= 'table' or type(point2) ~= 'table' then\
    local info = debug.getinfo(2, 'Sl')\
    local lineInfo = ''\
    if info.currentline then\
      lineInfo = info.source .. ': ' .. info.currentline .. ':\\n'\
    end\
    if type(point1) ~= 'table' then\
      lineInfo = lineInfo .. '\\n bad argument #1 \"point1\"(table excepted, got ' .. type(point1) .. ')'\
    end\
    if type(point2) ~= 'table' then\
      lineInfo = lineInfo .. '\\n bad argument #2 \"point2\"(table excepted, got ' .. type(point2) .. ')'\
    end\
    error(lineInfo)\
  end\
  return point1[1] == point2[1] and point1[2] == point2[2]\
end\
\
\
local battleListenerList = {\
  { '', o.home.isHome, 2000 },\
  { 'MAPS_TYPE_4_PAGE_AMBUSHED_PANEL_AVOID_AMBUSHED', o.battle.isAmbushedPanel, 2000 },\
  { 'BATTLE_BATTLE_CHAPTER_PAGE_BACK_TO_HOME', o.battle.isBattleChapterPage, 2000 },\
  { 'BATTLE_BATTLE_CHAPTER_PAGE_INFO_PANEL_CLICK_INTO', o.battle.isChapterInfoPanel, 2000 },\
  { 'BATTLE_BATTLE_CHAPTER_PAGE_SELECT_FLEET_PANEL_SELECT_FLEET', o.battle.isSelectFleetPanel, 2000 },\
  { 'BATTLE_BATTLE_CHAPTER_PAGE_HARD_SELECT_FLEET_PANEL_CLICK_INTO', o.battle.isHardSelectFleetPanel, 500 },\
  { 'BATTLE_MAP_PAGE', o.battle.isMapPage, 2000 },\
  { 'BATTLE_MAP_PAGE_CLOSE_FORMAT_PANEL', o.battle.isFormationPanel, 2000 },\
  { 'BATTLE_READY_BATTLE_PAGE_CLICK_BATTLE', o.battle.isReadyBattlePage, 2000 },\
  { 'BATTLE_IN_BATTLE_PAGE', o.battle.isInBattlePage, 2000 },\
  { 'BATTLE_VICTORY_PAGE', o.battle.isVictoryPanel, 2000 },\
  { 'BATTLE_GET_PROPS_PANEL', o.battle.isGetPropsPanel, 2000 },\
  { 'BATTLE_GET_NEW_SHIP_PANEL', o.battle.isGetNewShipPanel, 2000 },\
  { 'BATTLE_GET_EXP_PANEL', o.battle.isGetExpPanel, 2000 },\
}\
\
local mapsType2 = function(action)\
  local settings = store.settings;\
  local mapProxy = o.map['map' .. settings.battleChapter]\
  return co(c.create(function()\
    if action.type == 'MAPS_TYPE_4_PRE_INIT' then\
\
      -- 这部分流程只会在每次开启新的一局时才调用一次，而不是每次寻路就调用一次\
\
      stepLabel.setStepLabelContent('3-1.开局预备变量')\
      store.mapType4.selectFleedCount = 0\
      -- boss舰队是否在boss区域\
      store.mapType4.battleNum = 0\
      store.mapType4.battleWithConvoyNum = 0\
      store.mapType4.battleFromState = ''\
      -- 切换船的次数，如果超过4次没切换成功表示舰队沉了。\
      store.mapType4.changeFleetNum = 0\
      -- 舰队移动的状态。\
      store.mapType4.missionStep = 'onWayFleetMoveToWaitBoss'\
      store.mapType4.currentPosition = nil\
      -- 下一步行动的目标位置\
      store.mapType4.nextStepPoint = nil\
      -- 下一步行动的舰队，当前为 nil 'onWay' 或者 'boss'\
      store.mapType4.nextStepFleed = nil\
      store.mapType4.moveVectorForAStep = { -1, -1 }\
      store.mapType4.moveFailTimes = 0\
\
      return makeAction('')\
\
    elseif action.type == 'MAPS_TYPE_4_INIT' then\
\
      -- 每次进入地图页面时就会执行一次\
      -- 切换船的次数，如果超过4次没切换成功表示舰队沉了。\
      store.mapType3.changeFleetNum = 0\
      -- 舰队移动的状态。\
      store.mapType3.missionStep = 'onWayFleetMoveToWaitBoss'\
      store.mapType3.currentPosition = nil\
      -- 下一步行动的目标位置\
      store.mapType3.nextStepPoint = nil\
      -- 下一步行动的路径\
      store.mapType2.nextStepPath = nil\
      -- 下一步行动的舰队，当前为 nil 'onWay' 或者 'boss'\
      store.mapType3.nextStepFleed = nil\
      store.mapType4.moveVectorForAStep = { -1, -1 }\
      store.mapType4.moveFailTimes = 0\
      return makeAction('MAPS_TYPE_4_START')\
\
    elseif action.type == 'MAPS_TYPE_4_START' then\
\
      local newstateTypes = c.yield(setScreenListeners(battleListenerList, {\
        { 'MAPS_TYPE_4_GET_NEXT_STEP', o.battle.isMapPage },\
      }))\
      return makeAction(newstateTypes)\
\
    elseif action.type == 'MAPS_TYPE_4_GET_NEXT_STEP' then\
\
      stepLabel.setStepLabelContent('3-6.计算下一步往哪走')\
      local mapChessboard = store.scanMapType1.mapChessboard\
      local inBattleList = mapChessboard.inBattleList\
\
      local _ = (function()\
\
        stepLabel.setStepLabelContent('3-11.随机移动一步')\
        store.mapType4.missionStep = 'randomMoveAStep'\
        store.mapType4.nextStepFleed = 'onWay'\
        store.mapType4.nextStepPoint = mapProxy.getRandomMoveAStep(mapChessboard)\
        return\
      end)()\
      console.log(store.mapType4.nextStepPoint)\
      -- 如果还是没有移动目标，则可能是我方舰队挡住了敌人，此时需要随意移动一步\
      -- 尽可能避开敌人\
      if not store.mapType4.nextStepPoint then\
        stepLabel.setStepLabelContent('3-11.随机移动一步')\
        store.mapType4.nextStepPoint = mapProxy.getRandomMoveAStep(mapChessboard)\
      end\
      -- 如果还是没有移动目标，只好重新扫描\
      if not store.mapType4.nextStepPoint then\
        local newstateTypes = c.yield(setScreenListeners(battleListenerList, {\
          { 'MAPS_TYPE_4_START', o.battle.isMapPage },\
        }))\
        return makeAction(newstateTypes)\
      end\
\
      -- 查找目标点在哪个界面\
      store.mapType4.checkpositionListForMove = mapProxy.getCheckpositionList(settings.battleChapter)\
      for _, targetPosition in ipairs(store.mapType4.checkpositionListForMove) do\
        local nextRowNum = store.mapType4.nextStepPoint[1]\
        local nextColNum = store.mapType4.nextStepPoint[2]\
        if targetPosition.pointMap[nextRowNum .. '-' .. nextColNum] then\
          store.mapType4.checkpositionListForMove = { targetPosition }\
          break;\
        end\
      end\
\
      local newstateTypes = c.yield(setScreenListeners(battleListenerList, {\
        { 'MAPS_TYPE_4_PAGE_SELECT_FLEET', o.battle.isMapPage },\
      }))\
      return makeAction(newstateTypes)\
\
    elseif action.type == 'MAPS_TYPE_4_PAGE_SELECT_FLEET' then\
\
      if settings.battleFleet[2] then\
        stepLabel.setStepLabelContent('3-20.检查舰队')\
        if store.mapType4.nextStepFleed == 'boss' then\
          if (not o.battle.isSelectedFleed(settings.battleFleet[1])) and store.mapType4.changeFleetNum < 2 then\
            store.mapType4.changeFleetNum = store.mapType4.changeFleetNum + 1\
            stepLabel.setStepLabelContent('3-21.选择boss舰队')\
            o.battle.clickSwitchFleetBtn()\
            c.yield(sleepPromise(100))\
            o.battle.clickAttackBtn()\
            c.yield(sleepPromise(500))\
            if o.battle.isSelectedFleed(settings.battleFleet[1]) then\
              local myFleetList = store.scanMapType1.mapChessboard.myFleetList\
              store.scanMapType1.mapChessboard.myFleetList = { myFleetList[2], myFleetList[1] }\
            else\
              local newstateTypes = c.yield(setScreenListeners(battleListenerList, {\
                { 'MAPS_TYPE_4_PAGE_SELECT_FLEET', o.battle.isMapPage, 1000 },\
              }))\
              return makeAction(newstateTypes)\
            end\
          end\
        elseif store.mapType4.nextStepFleed == 'onWay'\
          or store.mapType4.missionStep == nil then\
          local res = o.battle.isSelectedFleed(settings.battleFleet[2])\
          if (not res) and (store.mapType4.changeFleetNum < 2) then\
            store.mapType4.changeFleetNum = store.mapType4.changeFleetNum + 1\
            stepLabel.setStepLabelContent('3-22.选择道中舰队')\
            o.battle.clickSwitchFleetBtn()\
            c.yield(sleepPromise(100))\
            o.battle.clickAttackBtn()\
            if o.battle.isSelectedFleed(settings.battleFleet[2]) then\
              local myFleetList = store.scanMapType1.mapChessboard.myFleetList\
              store.scanMapType1.mapChessboard.myFleetList = { myFleetList[2], myFleetList[1] }\
            else\
              local newstateTypes = c.yield(setScreenListeners(battleListenerList, {\
                { 'MAPS_TYPE_4_PAGE_SELECT_FLEET', o.battle.isMapPage, 1000 },\
              }))\
              return makeAction(newstateTypes)\
            end\
          end\
        end\
      end\
\
      store.mapType4.changeFleetNum = 0\
      local newstateTypes = c.yield(setScreenListeners(battleListenerList, {\
        { 'MAPS_TYPE_4_GET_MAP_POSITION_FOR_A_STEP', o.battle.isMapPage },\
      }))\
      return makeAction(newstateTypes)\
\
    elseif action.type == 'MAPS_TYPE_4_GET_MAP_POSITION_FOR_A_STEP' then\
\
      stepLabel.setStepLabelContent('3-11.获取地图位置参数')\
      local targetPosition = store.mapType4.checkpositionListForMove[1]\
      local currentPosition = mapProxy.getMapPosition(targetPosition)\
      console.log(currentPosition)\
      stepLabel.setStepLabelContent('3-12.计算移动向量')\
      local targetPosition = store.mapType4.checkpositionListForMove[1]\
      local newMoveVector, effectiveStep = mapProxy.getMoveVector(currentPosition, targetPosition)\
      if effectiveStep and comparePoints(store.mapType4.moveVectorForAStep, newMoveVector) then\
        store.mapType4.moveVectorForAStep = newMoveVector\
        local newstateTypes = c.yield(setScreenListeners(battleListenerList, {\
          { 'MAPS_TYPE_4_MOVE_A_STEP', o.battle.isMapPage, 500 },\
        }))\
        return makeAction(newstateTypes)\
      end\
      console.log(newMoveVector)\
      store.mapType4.moveVectorForAStep = newMoveVector\
      local newstateTypes = c.yield(setScreenListeners(battleListenerList, {\
        { 'MAPS_TYPE_4_MOVE_TO_CHECK_POSITION_FOR_A_STEP', o.battle.isMapPage },\
      }))\
      return makeAction(newstateTypes)\
\
    elseif action.type == 'MAPS_TYPE_4_MOVE_TO_CHECK_POSITION_FOR_A_STEP' then\
\
      stepLabel.setStepLabelContent('3-13.将地图移动到移动位置')\
      local isCenter = mapProxy.moveMapToCheckPosition(store.mapType4.moveVectorForAStep)\
      if isCenter then\
        local newstateTypes = c.yield(setScreenListeners(battleListenerList, {\
          { 'MAPS_TYPE_4_MOVE_A_STEP', o.battle.isMapPage, 500 },\
        }))\
        return makeAction(newstateTypes)\
      else\
        local newstateTypes = c.yield(setScreenListeners(battleListenerList, {\
          { 'MAPS_TYPE_4_GET_MAP_POSITION_FOR_A_STEP', o.battle.isMapPage, 1000 },\
        }))\
        return makeAction(newstateTypes)\
      end\
\
    elseif action.type == 'MAPS_TYPE_4_MOVE_A_STEP' then\
\
      stepLabel.setStepLabelContent('3-14.移动舰队位置')\
      local targetPosition = store.mapType4.checkpositionListForMove[1]\
      local nextRowNum = store.mapType4.nextStepPoint[1]\
      local nextColNum = store.mapType4.nextStepPoint[2]\
      console.log(store.mapType4.nextStepPoint)\
      if targetPosition.pointMap[nextRowNum .. '-' .. nextColNum] then\
        mapProxy.moveToPoint(targetPosition, store.mapType4.nextStepPoint)\
        o.battle.clickAttackBtn()\
      elseif #store.mapType4.checkpositionListForMove > 0 then\
        local newstateTypes = c.yield(setScreenListeners(battleListenerList, {\
          { 'MAPS_TYPE_4_GET_MAP_POSITION_FOR_A_STEP', o.battle.isMapPage },\
        }))\
        return makeAction(newstateTypes)\
      end\
\
      store.mapType4.checkpositionListForCheck = mapProxy.getCheckpositionList(settings.battleChapter)\
\
      if store.mapType4.moveFailTimes < 1 then\
        store.mapType4.moveFailTimes = store.mapType4.moveFailTimes + 1\
        local newstateTypes = c.yield(setScreenListeners(battleListenerList, {\
          { 'MAPS_TYPE_4_GET_MAP_POSITION_FOR_A_STEP', o.battle.isMapPage, 3000 } -- 如果移动后还是在地图页面，可能是遇到空隙。再次点击位置\
        }))\
        return makeAction(newstateTypes)\
      end\
      store.mapType4.moveFailTimes = 0\
\
      local newstateTypes = c.yield(setScreenListeners(battleListenerList, {\
        { 'SCAN_MAP_TYPE_1_INIT', o.battle.isMapPage, 3000 } -- 重新扫描\
      }))\
      return makeAction(newstateTypes)\
\
    elseif action.type == 'MAPS_TYPE_4_PAGE_AMBUSHED_PANEL_AVOID_AMBUSHED' then\
\
      stepLabel.setStepLabelContent('3.15.躲避伏击')\
      if settings.battleRoundabout then\
        o.battle.ambushedPanelClickAvoidBtn()\
      else\
        o.battle.ambushedPanelClickInterceptBtn()\
      end\
      local newstateTypes = c.yield(setScreenListeners(battleListenerList, {\
        { 'MAPS_TYPE_4_MOVE_TO_CHECK_POSITION_FOR_A_STEP', o.battle.isMapPage, 3000 },\
      }))\
      return makeAction(newstateTypes)\
    end\
\
    return nil\
  end))\
end\
\
return mapsType2\
\
" }


package.sourceCode = package.sourceCode or {}
package.sourceCode["./missions/maps-type-3.lua"] = { path = "./missions/maps-type-3.lua", name = "./missions/maps-type-3.lua", source = "local co = require '../lib/co'\
local c = coroutine\
local stepLabel = require '../utils/step-label'\
local makeAction = (require './utils').makeAction\
local sleepPromise = require '../utils/sleep-promise'\
local moBattle = require '../meta-operation/battle'\
local moHome = require '../meta-operation/home'\
local moMap = require '../meta-operation/maps-options/index'\
local setScreenListeners = (require './utils').setScreenListeners\
local store = require '../store'\
\
-- type2 的过程：先让道中队走到 boss 点前，再让道中队走到 boss 队前，最后 boss 队打 boss\
\
-- 设置  store 的默认值\
store.mapType3 = store.mapType3 or {\
  selectFleedCount = 0,\
  isBossFleetInBossArea = false,\
  battleNum = 0,\
  battleWithConvoyNum = 0,\
  checkpositionListForMove = {},\
  currentPosition = nil,\
  nextStepPoint = nil,\
  nextStepPath = nil,\
  nextStepFleed = nil,\
  moveVectorForAStep = { -1, -1 },\
  moveFailTimes = 0,\
}\
\
-- maps-type2 的行动流程\
local missionStepList = {\
  'onWayFleetMoveToWaitBoss',\
  'onWayFleetMoveToBossFleet',\
  'onWayFleetMoveToClosestEnemy',\
  'bossFleetMoveToWaitBoss',\
  'bossFleetMoveToBoss',\
  'randomMoveAStep',\
}\
\
local o = {\
  home = moHome,\
  battle = moBattle,\
  map = moMap,\
}\
\
local comparePoints = function(point1, point2)\
  if type(point1) ~= 'table' or type(point2) ~= 'table' then\
    local info = debug.getinfo(2, 'Sl')\
    local lineInfo = ''\
    if info.currentline then\
      lineInfo = info.source .. ': ' .. info.currentline .. ':\\n'\
    end\
    if type(point1) ~= 'table' then\
      lineInfo = lineInfo .. '\\n bad argument #1 \"point1\"(table excepted, got ' .. type(point1) .. ')'\
    end\
    if type(point2) ~= 'table' then\
      lineInfo = lineInfo .. '\\n bad argument #2 \"point2\"(table excepted, got ' .. type(point2) .. ')'\
    end\
    error(lineInfo)\
  end\
  return point1[1] == point2[1] and point1[2] == point2[2]\
end\
\
\
local battleListenerList = {\
  { '', o.home.isHome, 2000 },\
  { 'MAPS_TYPE_3_PAGE_AMBUSHED_PANEL_AVOID_AMBUSHED', o.battle.isAmbushedPanel, 2000 },\
  { 'BATTLE_BATTLE_CHAPTER_PAGE_BACK_TO_HOME', o.battle.isBattleChapterPage, 2000 },\
  { 'BATTLE_BATTLE_CHAPTER_PAGE_INFO_PANEL_CLICK_INTO', o.battle.isChapterInfoPanel, 2000 },\
  { 'BATTLE_BATTLE_CHAPTER_PAGE_SELECT_FLEET_PANEL_SELECT_FLEET', o.battle.isSelectFleetPanel, 2000 },\
  { 'BATTLE_BATTLE_CHAPTER_PAGE_HARD_SELECT_FLEET_PANEL_CLICK_INTO', o.battle.isHardSelectFleetPanel, 500 },\
  { 'BATTLE_MAP_PAGE', o.battle.isMapPage, 2000 },\
  { 'BATTLE_MAP_PAGE_CLOSE_FORMAT_PANEL', o.battle.isFormationPanel, 2000 },\
  { 'BATTLE_READY_BATTLE_PAGE_CLICK_BATTLE', o.battle.isReadyBattlePage, 2000 },\
  { 'BATTLE_IN_BATTLE_PAGE', o.battle.isInBattlePage, 2000 },\
  { 'BATTLE_VICTORY_PAGE', o.battle.isVictoryPanel, 2000 },\
  { 'BATTLE_GET_PROPS_PANEL', o.battle.isGetPropsPanel, 2000 },\
  { 'BATTLE_GET_NEW_SHIP_PANEL', o.battle.isGetNewShipPanel, 2000 },\
  { 'BATTLE_GET_EXP_PANEL', o.battle.isGetExpPanel, 2000 },\
}\
\
local mapsType2 = function(action)\
  local settings = store.settings;\
  local mapProxy = o.map['map' .. settings.battleChapter]\
  return co(c.create(function()\
    if action.type == 'MAPS_TYPE_3_PRE_INIT' then\
\
      -- 这部分流程只会在每次开启新的一局时才调用一次，而不是每次寻路就调用一次\
\
      stepLabel.setStepLabelContent('3-1.开局预备变量')\
      store.mapType3.selectFleedCount = 0\
      -- boss舰队是否在boss区域\
      store.mapType3.battleNum = 0\
      store.mapType3.battleWithConvoyNum = 0\
      -- 切换船的次数，如果超过4次没切换成功表示舰队沉了。\
      store.mapType3.changeFleetNum = 0\
      -- 舰队移动的状态。\
      store.mapType3.missionStep = 'onWayFleetMoveToWaitBoss'\
      store.mapType3.currentPosition = nil\
      -- 下一步行动的目标位置\
      store.mapType3.nextStepPoint = nil\
      -- 下一步行动的路径\
      store.mapType2.nextStepPath = nil\
      -- 下一步行动的舰队，当前为 nil 'onWay' 或者 'boss'\
      store.mapType3.nextStepFleed = nil\
      store.mapType3.moveVectorForAStep = { -1, -1 }\
      store.mapType3.moveFailTimes = 0\
\
      return makeAction('')\
\
    elseif action.type == 'MAPS_TYPE_3_INIT' then\
\
      -- 每次进入地图页面时就会执行一次\
      -- 切换船的次数，如果超过4次没切换成功表示舰队沉了。\
      store.mapType3.changeFleetNum = 0\
      -- 舰队移动的状态。\
      store.mapType3.missionStep = 'onWayFleetMoveToWaitBoss'\
      store.mapType3.currentPosition = nil\
      -- 下一步行动的目标位置\
      store.mapType3.nextStepPoint = nil\
      -- 下一步行动的路径\
      store.mapType2.nextStepPath = nil\
      -- 下一步行动的舰队，当前为 nil 'onWay' 或者 'boss'\
      store.mapType3.nextStepFleed = nil\
      store.mapType3.moveVectorForAStep = { -1, -1 }\
      store.mapType3.moveFailTimes = 0\
      return makeAction('MAPS_TYPE_3_START')\
\
    elseif action.type == 'MAPS_TYPE_3_START' then\
\
      local newstateTypes = c.yield(setScreenListeners(battleListenerList, {\
        { 'MAPS_TYPE_3_GET_NEXT_STEP', o.battle.isMapPage },\
      }))\
      return makeAction(newstateTypes)\
\
    elseif action.type == 'MAPS_TYPE_3_GET_NEXT_STEP' then\
\
      stepLabel.setStepLabelContent('3-6.计算下一步往哪走')\
      local mapChessboard = store.scanMapType1.mapChessboard\
      local inBattleList = mapChessboard.inBattleList\
\
      local _ = (function()\
        if table.findIndex(inBattleList, function(ele) return comparePoints(ele, mapChessboard.onWayFleet) end) > -1 then\
          store.mapType3.missionStep = 'onWayFleetMoveToClosestEnemy'\
          stepLabel.setStepLabelContent('3-7.道中队开始战斗')\
          store.mapType3.nextStepFleed = 'onWay'\
          store.mapType3.nextStepPoint = mapChessboard.onWayFleet\
          return\
        end\
\
        if #mapChessboard.enemyPositionList1 > 0 or #mapChessboard.enemyPositionList2 > 0 or #mapChessboard.enemyPositionList3 > 0 then\
          store.mapType3.missionStep = 'onWayFleetMoveToClosestEnemy'\
          stepLabel.setStepLabelContent('3-8.道中队移动到最近的敌人')\
          store.mapType3.nextStepFleed = 'onWay'\
          store.mapType3.nextStepPoint, store.mapType2.nextStepPath = mapProxy.findClosestEnemy(mapChessboard, mapChessboard.onWayFleet, mapChessboard.bossFleet)\
          return\
        end\
\
        if table.findIndex(inBattleList, function(ele) return comparePoints(ele, mapChessboard.bossFleet) end) > -1 then\
          stepLabel.setStepLabelContent('3-8.boss队开始战斗')\
          store.mapType3.missionStep = 'bossFleetMoveToBoss'\
          store.mapType3.nextStepFleed = 'boss'\
          store.mapType3.nextStepPoint = mapChessboard.bossFleet\
          return\
        end\
\
        if #mapChessboard.bossPosition > 0 then\
          stepLabel.setStepLabelContent('3-8.boss队移动到boss位置')\
          store.mapType3.missionStep = 'bossFleetMoveToBoss'\
          store.mapType3.nextStepFleed = 'boss'\
          store.mapType3.nextStepPoint, store.mapType2.nextStepPath = mapProxy.checkMoveToPointPath(mapChessboard, mapChessboard.bossFleet, mapChessboard.bossPosition[1])\
          return\
        end\
\
        if store.mapType3.missionStep == 'randomMoveAStep' then\
          stepLabel.setStepLabelContent('3-11.随机移动一步')\
          store.mapType3.missionStep = 'randomMoveAStep'\
          store.mapType3.nextStepFleed = 'onWay'\
          store.mapType3.nextStepPoint = mapProxy.getRandomMoveAStep(mapChessboard)\
          return\
        end\
\
        stepLabel.setStepLabelContent('3-8.道中移动到最近的敌人')\
        store.mapType3.missionStep = 'onWayFleetMoveToClosestEnemy'\
        store.mapType3.nextStepFleed = 'onWay'\
        store.mapType3.nextStepPoint, store.mapType2.nextStepPath = mapProxy.findClosestEnemy(mapChessboard, mapChessboard.onWayFleet, mapChessboard.bossFleet)\
        return\
      end)()\
      -- 如果还是没有移动目标，则可能是我方舰队挡住了敌人，此时需要随意移动一步\
      -- 尽可能避开敌人\
      if not store.mapType3.nextStepPoint then\
        stepLabel.setStepLabelContent('3-11.随机移动一步')\
        store.mapType3.nextStepPoint = mapProxy.getRandomMoveAStep(mapChessboard)\
      end\
      -- 如果还是没有移动目标，只好重新扫描\
      if not store.mapType3.nextStepPoint then\
        local newstateTypes = c.yield(setScreenListeners(battleListenerList, {\
          { 'MAPS_TYPE_3_START', o.battle.isMapPage },\
        }))\
        return makeAction(newstateTypes)\
      end\
\
      local newstateTypes = c.yield(setScreenListeners(battleListenerList, {\
        { 'MAPS_TYPE_3_PAGE_CHECK_NEXT_STEP_POSITION', o.battle.isMapPage },\
      }))\
      return makeAction(newstateTypes)\
\
    elseif action.type == 'MAPS_TYPE_3_PAGE_CHECK_NEXT_STEP_POSITION' then\
      -- 如果限制了步长，则需要计算一步移动到哪里\
      -- 如果限制步长，并且下一步路线不为0，並且下一步位置不是路线的终点\
      if settings.battleStepLength > 0\
        and store.mapType2.nextStepPath\
        and #store.mapType2.nextStepPath > 0 then\
        local stepNum = 0\
        while #store.mapType2.nextStepPath > 0 do\
          store.mapType2.nextStepPoint = table.remove(store.mapType2.nextStepPath, 1)\
          stepNum = stepNum + 1\
          if stepNum >= settings.battleStepLength then\
            break\
          end\
        end\
      end\
\
      -- 查找目标点在哪个界面\
      store.mapType3.checkpositionListForMove = mapProxy.getCheckpositionList(settings.battleChapter)\
      for _, targetPosition in ipairs(store.mapType3.checkpositionListForMove) do\
        local nextRowNum = store.mapType3.nextStepPoint[1]\
        local nextColNum = store.mapType3.nextStepPoint[2]\
        if targetPosition.pointMap[nextRowNum .. '-' .. nextColNum] then\
          store.mapType3.checkpositionListForMove = { targetPosition }\
          break;\
        end\
      end\
\
      local newstateTypes = c.yield(setScreenListeners(battleListenerList, {\
        { 'MAPS_TYPE_3_PAGE_SELECT_FLEET', o.battle.isMapPage },\
      }))\
      return makeAction(newstateTypes)\
\
    elseif action.type == 'MAPS_TYPE_3_PAGE_SELECT_FLEET' then\
\
      if settings.battleFleet[2] then\
        stepLabel.setStepLabelContent('3-20.检查舰队')\
        if store.mapType3.nextStepFleed == 'boss' then\
          if (not o.battle.isSelectedFleed(settings.battleFleet[1])) and store.mapType3.changeFleetNum < 2 then\
            store.mapType3.changeFleetNum = store.mapType3.changeFleetNum + 1\
            stepLabel.setStepLabelContent('3-21.选择boss舰队')\
            o.battle.clickSwitchFleetBtn()\
            c.yield(sleepPromise(100))\
            o.battle.clickAttackBtn()\
            c.yield(sleepPromise(500))\
            if o.battle.isSelectedFleed(settings.battleFleet[1]) then\
              local myFleetList = store.scanMapType1.mapChessboard.myFleetList\
              store.scanMapType1.mapChessboard.myFleetList = { myFleetList[2], myFleetList[1] }\
            else\
              local newstateTypes = c.yield(setScreenListeners(battleListenerList, {\
                { 'MAPS_TYPE_3_PAGE_SELECT_FLEET', o.battle.isMapPage, 1000 },\
              }))\
              return makeAction(newstateTypes)\
            end\
          end\
        elseif store.mapType3.nextStepFleed == 'onWay'\
          or store.mapType3.missionStep == nil then\
          local res = o.battle.isSelectedFleed(settings.battleFleet[2])\
          if (not res) and (store.mapType3.changeFleetNum < 2) then\
            store.mapType3.changeFleetNum = store.mapType3.changeFleetNum + 1\
            stepLabel.setStepLabelContent('3-22.选择道中舰队')\
            o.battle.clickSwitchFleetBtn()\
            c.yield(sleepPromise(100))\
            o.battle.clickAttackBtn()\
            if o.battle.isSelectedFleed(settings.battleFleet[2]) then\
              local myFleetList = store.scanMapType1.mapChessboard.myFleetList\
              store.scanMapType1.mapChessboard.myFleetList = { myFleetList[2], myFleetList[1] }\
            else\
              local newstateTypes = c.yield(setScreenListeners(battleListenerList, {\
                { 'MAPS_TYPE_3_PAGE_SELECT_FLEET', o.battle.isMapPage, 1000 },\
              }))\
              return makeAction(newstateTypes)\
            end\
          end\
        end\
      end\
\
      store.mapType3.changeFleetNum = 0\
      local newstateTypes = c.yield(setScreenListeners(battleListenerList, {\
        { 'MAPS_TYPE_3_GET_MAP_POSITION_FOR_A_STEP', o.battle.isMapPage },\
      }))\
      return makeAction(newstateTypes)\
\
    elseif action.type == 'MAPS_TYPE_3_GET_MAP_POSITION_FOR_A_STEP' then\
\
      stepLabel.setStepLabelContent('3-11.获取地图位置参数')\
      local targetPosition = store.mapType3.checkpositionListForMove[1]\
      local currentPosition = mapProxy.getMapPosition(targetPosition)\
      console.log(currentPosition)\
      stepLabel.setStepLabelContent('3-12.计算移动向量')\
      local targetPosition = store.mapType3.checkpositionListForMove[1]\
      local newMoveVector, effectiveStep = mapProxy.getMoveVector(currentPosition, targetPosition)\
      if effectiveStep and comparePoints(store.mapType3.moveVectorForAStep, newMoveVector) then\
        store.mapType3.moveVectorForAStep = newMoveVector\
        local newstateTypes = c.yield(setScreenListeners(battleListenerList, {\
          { 'MAPS_TYPE_3_MOVE_A_STEP', o.battle.isMapPage, 500 },\
        }))\
        return makeAction(newstateTypes)\
      end\
      console.log(newMoveVector)\
      store.mapType3.moveVectorForAStep = newMoveVector\
      local newstateTypes = c.yield(setScreenListeners(battleListenerList, {\
        { 'MAPS_TYPE_3_MOVE_TO_CHECK_POSITION_FOR_A_STEP', o.battle.isMapPage },\
      }))\
      return makeAction(newstateTypes)\
\
    elseif action.type == 'MAPS_TYPE_3_MOVE_TO_CHECK_POSITION_FOR_A_STEP' then\
\
      stepLabel.setStepLabelContent('3-13.将地图移动到移动位置')\
      local isCenter = mapProxy.moveMapToCheckPosition(store.mapType3.moveVectorForAStep)\
      if isCenter then\
        local newstateTypes = c.yield(setScreenListeners(battleListenerList, {\
          { 'MAPS_TYPE_3_MOVE_A_STEP', o.battle.isMapPage, 500 },\
        }))\
        return makeAction(newstateTypes)\
      else\
        local newstateTypes = c.yield(setScreenListeners(battleListenerList, {\
          { 'MAPS_TYPE_3_GET_MAP_POSITION_FOR_A_STEP', o.battle.isMapPage, 1000 },\
        }))\
        return makeAction(newstateTypes)\
      end\
\
    elseif action.type == 'MAPS_TYPE_3_MOVE_A_STEP' then\
\
      stepLabel.setStepLabelContent('3-14.移动舰队位置')\
      local targetPosition = store.mapType3.checkpositionListForMove[1]\
      local nextRowNum = store.mapType3.nextStepPoint[1]\
      local nextColNum = store.mapType3.nextStepPoint[2]\
      console.log(store.mapType3.nextStepPoint)\
      if targetPosition.pointMap[nextRowNum .. '-' .. nextColNum] then\
        mapProxy.moveToPoint(targetPosition, store.mapType3.nextStepPoint)\
        o.battle.clickAttackBtn()\
      elseif #store.mapType3.checkpositionListForMove > 0 then\
        local newstateTypes = c.yield(setScreenListeners(battleListenerList, {\
          { 'MAPS_TYPE_3_GET_MAP_POSITION_FOR_A_STEP', o.battle.isMapPage },\
        }))\
        return makeAction(newstateTypes)\
      end\
\
      if settings.battleStepLength > 0\
        and store.mapType2.nextStepPath\
        and #store.mapType2.nextStepPath > 0\
        and not comparePoints(store.mapType2.nextStepPath[#store.mapType2.nextStepPath], store.mapType2.nextStepPoint) then\
\
        local newstateTypes = c.yield(setScreenListeners(battleListenerList, {\
          { 'MAPS_TYPE_3_PAGE_CHECK_NEXT_STEP_POSITION', o.battle.isMapPage, settings.battleStepLength * 800 + 200 }\
        }))\
        return makeAction(newstateTypes)\
      end\
\
      if store.mapType3.moveFailTimes < 3 then\
        store.mapType3.moveFailTimes = store.mapType3.moveFailTimes + 1\
        local newstateTypes = c.yield(setScreenListeners(battleListenerList, {\
          { 'MAPS_TYPE_3_GET_MAP_POSITION_FOR_A_STEP', o.battle.isMapPage, 3000 } -- 如果移动后还是在地图页面，可能是遇到空隙。再次点击位置\
        }))\
        return makeAction(newstateTypes)\
      end\
      store.mapType3.moveFailTimes = 0\
\
      local newstateTypes = c.yield(setScreenListeners(battleListenerList, {\
        { 'SCAN_MAP_TYPE_1_INIT', o.battle.isMapPage, 3000 } -- 重新扫描\
      }))\
      return makeAction(newstateTypes)\
\
    elseif action.type == 'MAPS_TYPE_3_PAGE_AMBUSHED_PANEL_AVOID_AMBUSHED' then\
\
      stepLabel.setStepLabelContent('3.15.躲避伏击')\
      if settings.battleRoundabout then\
        o.battle.ambushedPanelClickAvoidBtn()\
      else\
        o.battle.ambushedPanelClickInterceptBtn()\
      end\
      local newstateTypes = c.yield(setScreenListeners(battleListenerList, {\
        { 'MAPS_TYPE_3_MOVE_TO_CHECK_POSITION_FOR_A_STEP', o.battle.isMapPage, 3000 },\
      }))\
      return makeAction(newstateTypes)\
    end\
\
    return nil\
  end))\
end\
\
return mapsType2\
\
" }


package.sourceCode = package.sourceCode or {}
package.sourceCode["./missions/maps-type-2.lua"] = { path = "./missions/maps-type-2.lua", name = "./missions/maps-type-2.lua", source = "local co = require '../lib/co'\
local c = coroutine\
local stepLabel = require '../utils/step-label'\
local makeAction = (require './utils').makeAction\
local sleepPromise = require '../utils/sleep-promise'\
local moBattle = require '../meta-operation/battle'\
local moHome = require '../meta-operation/home'\
local moMap = require '../meta-operation/maps-options/index'\
local setScreenListeners = (require './utils').setScreenListeners\
local store = require '../store'\
\
-- type2 的过程：先让道中队走到 boss 点前，再让道中队走到 boss 队前，最后 boss 队打 boss\
\
-- 设置  store 的默认值\
store.mapType2 = store.mapType2 or {\
  selectFleedCount = 0,\
  isBossFleetInBossArea = false,\
  battleNum = 0,\
  battleWithConvoyNum = 0,\
  checkpositionListForMove = {},\
  currentPosition = nil,\
  nextStepPoint = nil,\
  nextStepFleed = nil,\
  moveVectorForAStep = { -1, -1 },\
  moveFailTimes = 0,\
}\
\
-- maps-type2 的行动流程\
local missionStepList = {\
  'onWayFleetMoveToWaitBoss',\
  'onWayFleetMoveToBossFleet',\
  'onWayFleetMoveToClosestEnemy',\
  'bossFleetMoveToWaitBoss',\
  'bossFleetMoveToBoss',\
  'randomMoveAStep',\
}\
\
local o = {\
  home = moHome,\
  battle = moBattle,\
  map = moMap,\
}\
\
local comparePoints = function(point1, point2)\
  if type(point1) ~= 'table' or type(point2) ~= 'table' then\
    local info = debug.getinfo(2, 'Sl')\
    local lineInfo = ''\
    if info.currentline then\
      lineInfo = info.source .. ': ' .. info.currentline .. ':\\n'\
    end\
    if type(point1) ~= 'table' then\
      lineInfo = lineInfo .. '\\n bad argument #1 \"point1\"(table excepted, got ' .. type(point1) .. ')'\
    end\
    if type(point2) ~= 'table' then\
      lineInfo = lineInfo .. '\\n bad argument #2 \"point2\"(table excepted, got ' .. type(point2) .. ')'\
    end\
    error(lineInfo)\
  end\
  return point1[1] == point2[1] and point1[2] == point2[2]\
end\
\
\
local battleListenerList = {\
  { '', o.home.isHome, 2000 },\
  { 'MAPS_TYPE_2_PAGE_AMBUSHED_PANEL_AVOID_AMBUSHED', o.battle.isAmbushedPanel, 2000 },\
  { 'BATTLE_BATTLE_CHAPTER_PAGE_BACK_TO_HOME', o.battle.isBattleChapterPage, 2000 },\
  { 'BATTLE_BATTLE_CHAPTER_PAGE_INFO_PANEL_CLICK_INTO', o.battle.isChapterInfoPanel, 2000 },\
  { 'BATTLE_BATTLE_CHAPTER_PAGE_SELECT_FLEET_PANEL_SELECT_FLEET', o.battle.isSelectFleetPanel, 2000 },\
  { 'BATTLE_BATTLE_CHAPTER_PAGE_HARD_SELECT_FLEET_PANEL_CLICK_INTO', o.battle.isHardSelectFleetPanel, 500 },\
  { 'BATTLE_MAP_PAGE', o.battle.isMapPage, 2000 },\
  { 'BATTLE_MAP_PAGE_CLOSE_FORMAT_PANEL', o.battle.isFormationPanel, 2000 },\
  { 'BATTLE_READY_BATTLE_PAGE_CLICK_BATTLE', o.battle.isReadyBattlePage, 2000 },\
  { 'BATTLE_IN_BATTLE_PAGE', o.battle.isInBattlePage, 2000 },\
  { 'BATTLE_VICTORY_PAGE', o.battle.isVictoryPanel, 2000 },\
  { 'BATTLE_GET_PROPS_PANEL', o.battle.isGetPropsPanel, 2000 },\
  { 'BATTLE_GET_NEW_SHIP_PANEL', o.battle.isGetNewShipPanel, 2000 },\
  { 'BATTLE_GET_EXP_PANEL', o.battle.isGetExpPanel, 2000 },\
}\
\
local mapsType2 = function(action)\
  local settings = store.settings;\
  local mapProxy = o.map['map' .. settings.battleChapter]\
  return co(c.create(function()\
    if action.type == 'MAPS_TYPE_2_PRE_INIT' then\
\
      -- 这部分流程只会在每次开启新的一局时才调用一次，而不是每次寻路就调用一次\
\
      stepLabel.setStepLabelContent('3-1.开局预备变量')\
      store.mapType2.selectFleedCount = 0\
      -- boss舰队是否在boss区域\
      store.mapType2.battleNum = 0\
      store.mapType2.battleWithConvoyNum = 0\
      -- 切换船的次数，如果超过4次没切换成功表示舰队沉了。\
      store.mapType2.changeFleetNum = 0\
      -- 舰队移动的状态。\
      store.mapType2.missionStep = 'onWayFleetMoveToWaitBoss'\
      store.mapType2.currentPosition = nil\
      -- 下一步行动的目标位置\
      store.mapType2.nextStepPoint = nil\
      -- 下一步行动的路径\
      store.mapType2.nextStepPath = nil\
      -- 下一步行动的舰队，当前为 nil 'onWay' 或者 'boss'\
      store.mapType2.nextStepFleed = nil\
      store.mapType2.moveVectorForAStep = { -1, -1 }\
      store.mapType2.moveFailTimes = 0\
\
      return makeAction('')\
\
    elseif action.type == 'MAPS_TYPE_2_INIT' then\
\
      -- 每次进入地图页面时就会执行一次\
\
      -- 舰队移动的状态。\
      store.mapType2.missionStep = 'onWayFleetMoveToWaitBoss'\
      store.mapType2.currentPosition = nil\
      -- 下一步行动的目标位置\
      store.mapType2.nextStepPoint = nil\
      -- 下一步行动的路径\
      store.mapType2.nextStepPath = nil\
      -- 下一步行动的舰队，当前为 nil 'onWay' 或者 'boss'\
      store.mapType2.nextStepFleed = nil\
      store.mapType2.moveVectorForAStep = { -1, -1 }\
      store.mapType2.moveFailTimes = 0\
      return makeAction('MAPS_TYPE_2_START')\
\
    elseif action.type == 'MAPS_TYPE_2_START' then\
\
      local newstateTypes = c.yield(setScreenListeners(battleListenerList, {\
        { 'MAPS_TYPE_2_GET_NEXT_STEP', o.battle.isMapPage },\
      }))\
      return makeAction(newstateTypes)\
\
    elseif action.type == 'MAPS_TYPE_2_GET_NEXT_STEP' then\
\
      stepLabel.setStepLabelContent('3-6.计算下一步往哪走')\
      local mapChessboard = store.scanMapType1.mapChessboard\
      local inBattleList = mapChessboard.inBattleList\
\
      local _ = (function()\
        if table.findIndex(inBattleList, function(ele) return comparePoints(ele, mapChessboard.bossFleet) end) > -1 then\
          stepLabel.setStepLabelContent('3-8.boss队开始战斗')\
          store.mapType2.missionStep = 'bossFleetMoveToBoss'\
          store.mapType2.nextStepFleed = 'boss'\
          store.mapType2.nextStepPoint = mapChessboard.bossFleet\
          return\
        end\
\
        if table.findIndex(inBattleList, function(ele) return comparePoints(ele, mapChessboard.onWayFleet) end) > -1 then\
          store.mapType2.missionStep = 'onWayFleetMoveToClosestEnemy'\
          stepLabel.setStepLabelContent('3-7.开始战斗')\
          store.mapType2.nextStepFleed = 'onWay'\
          store.mapType2.nextStepPoint = mapChessboard.onWayFleet\
          return\
        end\
\
        if table.findIndex(store.mapType2.missionStep, { 'randomMoveAStep' }) <= 0\
          and #mapChessboard.bossPosition > 0 then\
          -- 判断boss队到boss中间能否通过\
          local bossTo = mapProxy.checkMoveToPointPath(mapChessboard, mapChessboard.bossFleet, mapChessboard.bossPosition[1])\
          if bossTo and comparePoints(bossTo, mapChessboard.bossPosition[1]) then\
            stepLabel.setStepLabelContent('3-8.boss队移动到boss位置')\
            store.mapType2.missionStep = 'bossFleetMoveToBoss'\
            store.mapType2.nextStepFleed = 'boss'\
            store.mapType2.nextStepPoint, store.mapType2.nextStepPath = mapProxy.checkMoveToPointPath(mapChessboard, mapChessboard.bossFleet, mapChessboard.bossPosition[1])\
            return\
          end\
\
          stepLabel.setStepLabelContent('3-8.道中队清理阻拦的敌人')\
          store.mapType2.missionStep = 'onWayFleetMoveToClosestEnemy'\
          store.mapType2.nextStepFleed = 'onWay'\
          store.mapType2.nextStepPoint, store.mapType2.nextStepPath = mapProxy.checkMoveToPointPath(mapChessboard, mapChessboard.onWayFleet, bossTo)\
          return\
        end\
\
        -- 道中队清理路线上的敌人\
        if table.findIndex(store.mapType2.missionStep, {\
          'onWayFleetMoveToWaitBoss',\
          'onWayFleetMoveToBossFleet',\
          'onWayFleetMoveToClosestEnemy',\
        }) <= 0 then\
          for _, waitForBossPositionItem in ipairs(mapChessboard.waitForBossPosition) do\
            local bossFleetToWaitBoss = mapProxy.checkMoveToPointPath(mapChessboard, mapChessboard.bossFleet, waitForBossPositionItem)\
            local onWayFleetToBossFleet, onWayFleetToBossFleetPath = mapProxy.checkMoveToPointPath(mapChessboard, mapChessboard.onWayFleet, mapChessboard.bossFleet)\
            local onWayFleetToWaitBoss, onWayFleetToWaitBossPath = mapProxy.checkMoveToPointPath(mapChessboard, mapChessboard.onWayFleet, waitForBossPositionItem)\
\
            if not bossFleetToWaitBoss or not comparePoints(bossFleetToWaitBoss, waitForBossPositionItem) then\
              if onWayFleetToBossFleet\
                and onWayFleetToWaitBoss\
                and not comparePoints(onWayFleetToBossFleet, mapChessboard.bossFleet)\
                and not comparePoints(onWayFleetToWaitBoss, waitForBossPositionItem) then\
                if #onWayFleetToBossFleetPath < #onWayFleetToWaitBossPath then\
                  stepLabel.setStepLabelContent('3-8.道中队移动到待命位置')\
                  store.mapType2.missionStep = 'onWayFleetMoveToWaitBoss'\
                  store.mapType2.nextStepFleed = 'onWay'\
                  store.mapType2.nextStepPoint, store.mapType2.nextStepPath = mapProxy.checkMoveToPointPath(mapChessboard, mapChessboard.onWayFleet, waitForBossPositionItem)\
                  return\
                else\
                  stepLabel.setStepLabelContent('3-8.道中移动到boss队旁边')\
                  store.mapType2.missionStep = 'onWayFleetMoveToBossFleet'\
                  store.mapType2.nextStepFleed = 'onWay'\
                  mapProxy.findClosestEnemy(mapChessboard, mapChessboard.onWayFleet, mapChessboard.bossFleet)\
                  store.mapType2.nextStepPoint, store.mapType2.nextStepPath = mapProxy.checkMoveToPointPath(mapChessboard, mapChessboard.onWayFleet, mapChessboard.bossFleet)\
                  return\
                end\
              end\
              if not comparePoints(mapChessboard.onWayFleet, waitForBossPositionItem)\
                and (onWayFleetToWaitBoss and not comparePoints(onWayFleetToWaitBoss, waitForBossPositionItem)) then\
                stepLabel.setStepLabelContent('3-8.道中队移动到待命位置')\
                store.mapType2.missionStep = 'onWayFleetMoveToWaitBoss'\
                store.mapType2.nextStepFleed = 'onWay'\
                store.mapType2.nextStepPoint, store.mapType2.nextStepPath = mapProxy.checkMoveToPointPath(mapChessboard, mapChessboard.onWayFleet, waitForBossPositionItem)\
                return\
              end\
              if onWayFleetToBossFleet and not comparePoints(onWayFleetToBossFleet, mapChessboard.bossFleet) then\
                stepLabel.setStepLabelContent('3-8.道中移动到boss队旁边')\
                store.mapType2.missionStep = 'onWayFleetMoveToBossFleet'\
                store.mapType2.nextStepFleed = 'onWay'\
                store.mapType2.nextStepPoint, store.mapType2.nextStepPath = mapProxy.checkMoveToPointPath(mapChessboard, mapChessboard.onWayFleet, mapChessboard.bossFleet)\
                return\
              end\
            end\
          end\
        end\
\
        if store.mapType2.missionStep == 'onWayFleetMoveToClosestEnemy' then\
          stepLabel.setStepLabelContent('3-8.道中移动到最近的敌人')\
          store.mapType2.nextStepFleed = 'onWay'\
          store.mapType2.nextStepPoint, store.mapType2.nextStepPath = mapProxy.findClosestEnemy(mapChessboard, mapChessboard.onWayFleet, mapChessboard.bossFleet)\
          return\
        end\
\
        if store.mapType2.missionStep == 'bossFleetMoveToBoss' then\
          stepLabel.setStepLabelContent('3-8.boss队移动到boss位置')\
          store.mapType2.missionStep = 'bossFleetMoveToBoss'\
          store.mapType2.nextStepFleed = 'boss'\
          store.mapType2.nextStepPoint, store.mapType2.nextStepPath = mapProxy.checkMoveToPointPath(mapChessboard, mapChessboard.bossFleet, mapChessboard.bossPosition[1])\
          return\
        end\
\
        if store.mapType2.missionStep == 'randomMoveAStep' then\
          stepLabel.setStepLabelContent('3-11.随机移动一步')\
          store.mapType2.missionStep = 'randomMoveAStep'\
          store.mapType2.nextStepFleed = 'onWay'\
          store.mapType2.nextStepPoint = mapProxy.getRandomMoveAStep(mapChessboard)\
          return\
        end\
\
        stepLabel.setStepLabelContent('3-8.道中移动到最近的敌人')\
        store.mapType2.missionStep = 'onWayFleetMoveToClosestEnemy'\
        store.mapType2.nextStepFleed = 'onWay'\
        store.mapType2.nextStepPoint, store.mapType2.nextStepPath = mapProxy.findClosestEnemy(mapChessboard, mapChessboard.onWayFleet, mapChessboard.bossFleet)\
        return\
      end)()\
      -- 如果还是没有移动目标，则可能是我方舰队挡住了敌人，此时需要随意移动一步\
      -- 尽可能避开敌人\
      if not store.mapType2.nextStepPoint then\
        stepLabel.setStepLabelContent('3-11.随机移动一步')\
        store.mapType2.nextStepPoint = mapProxy.getRandomMoveAStep(mapChessboard)\
      end\
      -- 如果还是没有移动目标，只好重新扫描\
      if not store.mapType2.nextStepPoint then\
        local newstateTypes = c.yield(setScreenListeners(battleListenerList, {\
          { 'MAPS_TYPE_2_START', o.battle.isMapPage },\
        }))\
        return makeAction(newstateTypes)\
      end\
\
      local newstateTypes = c.yield(setScreenListeners(battleListenerList, {\
        { 'MAPS_TYPE_2_PAGE_CHECK_NEXT_STEP_POSITION', o.battle.isMapPage },\
      }))\
      return makeAction(newstateTypes)\
\
    elseif action.type == 'MAPS_TYPE_2_PAGE_CHECK_NEXT_STEP_POSITION' then\
      -- 如果限制了步长，则需要计算一步移动到哪里\
      -- 如果限制步长，并且下一步路线不为0，並且下一步位置不是路线的终点\
      if settings.battleStepLength > 0\
        and store.mapType2.nextStepPath\
        and #store.mapType2.nextStepPath > 0 then\
        local stepNum = 0\
        while #store.mapType2.nextStepPath > 0 do\
          store.mapType2.nextStepPoint = table.remove(store.mapType2.nextStepPath, 1)\
          stepNum = stepNum + 1\
          if stepNum >= settings.battleStepLength then\
            break\
          end\
        end\
      end\
\
      -- 查找目标点在哪个界面\
      store.mapType2.checkpositionListForMove = mapProxy.getCheckpositionList(settings.battleChapter)\
      for _, targetPosition in ipairs(store.mapType2.checkpositionListForMove) do\
        local nextRowNum = store.mapType2.nextStepPoint[1]\
        local nextColNum = store.mapType2.nextStepPoint[2]\
        if targetPosition.pointMap[nextRowNum .. '-' .. nextColNum] then\
          store.mapType2.checkpositionListForMove = { targetPosition }\
          break;\
        end\
      end\
\
\
      local newstateTypes = c.yield(setScreenListeners(battleListenerList, {\
        { 'MAPS_TYPE_2_PAGE_SELECT_FLEET', o.battle.isMapPage },\
      }))\
      return makeAction(newstateTypes)\
\
    elseif action.type == 'MAPS_TYPE_2_PAGE_SELECT_FLEET' then\
\
      if settings.battleFleet[2] then\
        stepLabel.setStepLabelContent('3-20.检查舰队')\
        if store.mapType2.nextStepFleed == 'boss' then\
          if (not o.battle.isSelectedFleed(settings.battleFleet[1])) and store.mapType2.changeFleetNum < 2 then\
            store.mapType2.changeFleetNum = store.mapType2.changeFleetNum + 1\
            stepLabel.setStepLabelContent('3-21.选择boss舰队')\
            o.battle.clickSwitchFleetBtn()\
            c.yield(sleepPromise(100))\
            o.battle.clickAttackBtn()\
            c.yield(sleepPromise(500))\
            if o.battle.isSelectedFleed(settings.battleFleet[1]) then\
              local myFleetList = store.scanMapType1.mapChessboard.myFleetList\
              store.scanMapType1.mapChessboard.myFleetList = { myFleetList[2], myFleetList[1] }\
            else\
              local newstateTypes = c.yield(setScreenListeners(battleListenerList, {\
                { 'MAPS_TYPE_2_PAGE_SELECT_FLEET', o.battle.isMapPage, 1000 },\
              }))\
              return makeAction(newstateTypes)\
            end\
          end\
        elseif store.mapType2.nextStepFleed == 'onWay'\
          or store.mapType2.missionStep == nil then\
          local res = o.battle.isSelectedFleed(settings.battleFleet[2])\
          if (not res) and (store.mapType2.changeFleetNum < 2) then\
            store.mapType2.changeFleetNum = store.mapType2.changeFleetNum + 1\
            stepLabel.setStepLabelContent('3-22.选择道中舰队')\
            o.battle.clickSwitchFleetBtn()\
            c.yield(sleepPromise(100))\
            o.battle.clickAttackBtn()\
            if o.battle.isSelectedFleed(settings.battleFleet[2]) then\
              local myFleetList = store.scanMapType1.mapChessboard.myFleetList\
              store.scanMapType1.mapChessboard.myFleetList = { myFleetList[2], myFleetList[1] }\
            else\
              local newstateTypes = c.yield(setScreenListeners(battleListenerList, {\
                { 'MAPS_TYPE_2_PAGE_SELECT_FLEET', o.battle.isMapPage, 1000 },\
              }))\
              return makeAction(newstateTypes)\
            end\
          end\
        end\
      end\
\
      store.mapType2.changeFleetNum = 0\
      local newstateTypes = c.yield(setScreenListeners(battleListenerList, {\
        { 'MAPS_TYPE_2_GET_MAP_POSITION_FOR_A_STEP', o.battle.isMapPage },\
      }))\
      return makeAction(newstateTypes)\
\
    elseif action.type == 'MAPS_TYPE_2_GET_MAP_POSITION_FOR_A_STEP' then\
\
      stepLabel.setStepLabelContent('3-11.获取地图位置参数')\
      local targetPosition = store.mapType2.checkpositionListForMove[1]\
      local currentPosition = mapProxy.getMapPosition(targetPosition)\
      console.log(currentPosition)\
      stepLabel.setStepLabelContent('3-12.计算移动向量')\
      local targetPosition = store.mapType2.checkpositionListForMove[1]\
      local newMoveVector, effectiveStep = mapProxy.getMoveVector(currentPosition, targetPosition)\
      if effectiveStep and comparePoints(store.mapType2.moveVectorForAStep, newMoveVector) then\
        store.mapType2.moveVectorForAStep = newMoveVector\
        local newstateTypes = c.yield(setScreenListeners(battleListenerList, {\
          { 'MAPS_TYPE_2_MOVE_A_STEP', o.battle.isMapPage, 500 },\
        }))\
        return makeAction(newstateTypes)\
      end\
      console.log(newMoveVector)\
      store.mapType2.moveVectorForAStep = newMoveVector\
      local newstateTypes = c.yield(setScreenListeners(battleListenerList, {\
        { 'MAPS_TYPE_2_MOVE_TO_CHECK_POSITION_FOR_A_STEP', o.battle.isMapPage },\
      }))\
      return makeAction(newstateTypes)\
\
    elseif action.type == 'MAPS_TYPE_2_MOVE_TO_CHECK_POSITION_FOR_A_STEP' then\
\
      stepLabel.setStepLabelContent('3-13.将地图移动到移动位置')\
      local isCenter = mapProxy.moveMapToCheckPosition(store.mapType2.moveVectorForAStep)\
      if isCenter then\
        local newstateTypes = c.yield(setScreenListeners(battleListenerList, {\
          { 'MAPS_TYPE_2_MOVE_A_STEP', o.battle.isMapPage, 500 },\
        }))\
        return makeAction(newstateTypes)\
      else\
        local newstateTypes = c.yield(setScreenListeners(battleListenerList, {\
          { 'MAPS_TYPE_2_GET_MAP_POSITION_FOR_A_STEP', o.battle.isMapPage, 1000 },\
        }))\
        return makeAction(newstateTypes)\
      end\
\
    elseif action.type == 'MAPS_TYPE_2_MOVE_A_STEP' then\
\
      stepLabel.setStepLabelContent('3-14.移动舰队位置')\
      local targetPosition = store.mapType2.checkpositionListForMove[1]\
      local nextRowNum = store.mapType2.nextStepPoint[1]\
      local nextColNum = store.mapType2.nextStepPoint[2]\
      if targetPosition.pointMap[nextRowNum .. '-' .. nextColNum] then\
        mapProxy.moveToPoint(targetPosition, store.mapType2.nextStepPoint)\
        o.battle.clickAttackBtn()\
      elseif #store.mapType2.checkpositionListForMove > 0 then\
        local newstateTypes = c.yield(setScreenListeners(battleListenerList, {\
          { 'MAPS_TYPE_2_GET_MAP_POSITION_FOR_A_STEP', o.battle.isMapPage },\
        }))\
        return makeAction(newstateTypes)\
      end\
\
\
      if settings.battleStepLength > 0\
        and store.mapType2.nextStepPath\
        and #store.mapType2.nextStepPath > 0\
        and not comparePoints(store.mapType2.nextStepPath[#store.mapType2.nextStepPath], store.mapType2.nextStepPoint) then\
\
        local newstateTypes = c.yield(setScreenListeners(battleListenerList, {\
          { 'MAPS_TYPE_2_PAGE_CHECK_NEXT_STEP_POSITION', o.battle.isMapPage, settings.battleStepLength * 800 + 200 }\
        }))\
        return makeAction(newstateTypes)\
      end\
\
      if store.mapType2.moveFailTimes < 3 then\
        store.mapType2.moveFailTimes = store.mapType2.moveFailTimes + 1\
        local newstateTypes = c.yield(setScreenListeners(battleListenerList, {\
          { 'MAPS_TYPE_2_GET_MAP_POSITION_FOR_A_STEP', o.battle.isMapPage, 3000 } -- 如果移动后还是在地图页面，可能是遇到空隙。再次点击位置\
        }))\
        return makeAction(newstateTypes)\
      end\
      store.mapType2.moveFailTimes = 0\
\
      local newstateTypes = c.yield(setScreenListeners(battleListenerList, {\
        { 'SCAN_MAP_TYPE_1_INIT', o.battle.isMapPage, 3000 } -- 重新扫描\
      }))\
      return makeAction(newstateTypes)\
\
    elseif action.type == 'MAPS_TYPE_2_PAGE_AMBUSHED_PANEL_AVOID_AMBUSHED' then\
\
      stepLabel.setStepLabelContent('3.15.躲避伏击')\
      if settings.battleRoundabout then\
        o.battle.ambushedPanelClickAvoidBtn()\
      else\
        o.battle.ambushedPanelClickInterceptBtn()\
      end\
      local newstateTypes = c.yield(setScreenListeners(battleListenerList, {\
        { 'MAPS_TYPE_2_MOVE_TO_CHECK_POSITION_FOR_A_STEP', o.battle.isMapPage, 3000 },\
      }))\
      return makeAction(newstateTypes)\
    end\
\
    return nil\
  end))\
end\
\
return mapsType2\
\
" }


package.sourceCode = package.sourceCode or {}
package.sourceCode["./missions/maps-type-1.lua"] = { path = "./missions/maps-type-1.lua", name = "./missions/maps-type-1.lua", source = "local co = require '../lib/co'\
local c = coroutine\
local stepLabel = require '../utils/step-label'\
local makeAction = (require './utils').makeAction\
local sleepPromise = require '../utils/sleep-promise'\
local moBattle = require '../meta-operation/battle'\
local moHome = require '../meta-operation/home'\
local moMap = require '../meta-operation/maps-options/index'\
local setScreenListeners = (require './utils').setScreenListeners\
local store = require '../store'\
\
-- type1 的过程：先让 boss 队走到 boss 点，再让道中队清小怪，最后 boss 队打 boss\
\
-- 设置  store 的默认值\
store.mapType1 = store.mapType1 or {\
  selectFleedCount = 0,\
  isBossFleetInBossArea = false,\
  battleNum = 0,\
  battleWithConvoyNum = 0,\
  battleFromState = '',\
  checkpositionListForCheck = nil,\
  checkpositionListForMove = {},\
  oldMapChessboard = nil,\
  mapChessboard = {},\
  currentPosition = nil,\
  nextStepPoint = nil,\
  moveVectorForCheck = { -1, -1 },\
  moveVectorForAStep = { -1, -1 },\
}\
\
-- maps-type1 的行动流程\
local missionStepList = {\
  'moveToWaitBoss',\
  'moveToClosestEnemy',\
  'moveToBoss',\
  moveToWaitBoss = 'moveToWaitBoss',\
  moveToClosestEnemy = 'moveToClosestEnemy',\
  moveToBoss = 'moveToBoss',\
}\
\
local o = {\
  home = moHome,\
  battle = moBattle,\
  map = moMap,\
}\
\
local comparePoints = function(point1, point2)\
  return point1[1] == point2[1] and point1[2] == point2[2]\
end\
\
\
local battleListenerList = {\
  { '', o.home.isHome, 2000 },\
  { 'BATTLE_MAP_PAGE_AMBUSHED_PANEL_AVOID_AMBUSHED', o.battle.isAmbushedPanel, 2000 },\
  { 'BATTLE_BATTLE_CHAPTER_PAGE_BACK_TO_HOME', o.battle.isBattleChapterPage, 2000 },\
  { 'BATTLE_BATTLE_CHAPTER_PAGE_INFO_PANEL_CLICK_INTO', o.battle.isChapterInfoPanel, 2000 },\
  { 'BATTLE_BATTLE_CHAPTER_PAGE_SELECT_FLEET_PANEL_SELECT_FLEET', o.battle.isSelectFleetPanel, 2000 },\
  { 'BATTLE_BATTLE_CHAPTER_PAGE_HARD_SELECT_FLEET_PANEL_CLICK_INTO', o.battle.isHardSelectFleetPanel, 500 },\
  { 'BATTLE_MAP_PAGE', o.battle.isMapPage, 2000 },\
  { 'BATTLE_READY_BATTLE_PAGE_CLICK_BATTLE', o.battle.isReadyBattlePage, 2000 },\
  { 'BATTLE_IN_BATTLE_PAGE', o.battle.isInBattlePage, 2000 },\
  { 'BATTLE_VICTORY_PAGE', o.battle.isVictoryPanel, 2000 },\
  { 'BATTLE_GET_PROPS_PANEL', o.battle.isGetPropsPanel, 2000 },\
  { 'BATTLE_GET_NEW_SHIP_PANEL', o.battle.isGetNewShipPanel, 2000 },\
  { 'BATTLE_GET_EXP_PANEL', o.battle.isGetExpPanel, 2000 },\
}\
\
local mapsType1 = function(action)\
  local settings = store.settings;\
  local mapProxy = o.map['map' .. settings.battleChapter]\
\
  return co(c.create(function()\
    if action.type == 'MAPS_TYPE_1_PRE_INIT' then\
\
      -- 这部分流程只会在每次开启新的一局时才调用一次，而不是每次寻路就调用一次\
\
      stepLabel.setStepLabelContent('3-1.开局预备变量')\
      store.mapType1.selectFleedCount = 0\
      -- boss舰队是否在boss区域\
      store.mapType1.isBossFleetInBossArea = false\
      store.mapType1.battleNum = 0\
      store.mapType1.battleWithConvoyNum = 0\
      store.mapType1.battleFromState = ''\
      -- 切换船的次数，如果超过4次没切换成功表示舰队沉了。\
      store.mapType1.changeFleetNum = 0\
      -- 舰队移动的状态。一次关卡走地图会有3种状态\
      -- moveToWaitBoss : 移动到待命区\
      -- moveToClosestEnemy : 移动到最近的敌人\
      -- moveToBoss : 移动到 boss\
      store.mapType1.missionStep = 'moveToWaitBoss'\
      store.mapType1.checkpositionListForCheck = nil\
      store.mapType1.checkpositionListForMove = {}\
      store.mapType1.mapChessboard = mapProxy and mapProxy.getMapChessboard(settings.battleChapter) or {}\
      store.mapType1.newMapChessboard = mapProxy and mapProxy.getMapChessboard(settings.battleChapter) or {}\
      store.mapType1.currentPosition = nil\
      store.mapType1.nextStepPoint = nil\
      store.mapType1.moveVectorForCheck = { -1, -1 }\
      store.mapType1.moveVectorForAStep = { -1, -1 }\
\
      return makeAction('')\
\
    elseif action.type == 'MAPS_TYPE_1_INIT' then\
\
      -- 每次进入地图页面时就会执行一次\
\
      store.mapType1.checkpositionListForCheck = mapProxy.getCheckpositionList()\
      -- 先用 newMapChessboard 完成扫描，然后再与 mapChessboard 合并。这样就可以做新老版本的对比，避免被挡住的问题\
      store.mapType1.newMapChessboard = mapProxy.getMapChessboard(settings.battleChapter)\
      store.mapType1.currentPosition = nil\
      store.mapType1.nextStepPoint = nil\
      store.mapType1.moveVectorForCheck = { -1, -1 }\
      store.mapType1.moveVectorForAStep = { -1, -1 }\
      return makeAction('MAPS_TYPE_1_START')\
\
    elseif action.type == 'MAPS_TYPE_1_START' then\
\
      -- 检查上次移动舰队时所在的位置，并将其提前。有利于提高扫描速度\
      if #store.mapType1.checkpositionListForMove > 0 then\
        local cForMove = store.mapType1.checkpositionListForMove[1]\
        local index = table.findIndex(store.mapType1.checkpositionListForCheck, function(cForCheck)\
          if cForMove.leftTop and cForCheck.leftTop then\
            return cForMove.leftTop[1] == cForCheck.leftTop[1] and cForMove.leftTop[2] == cForCheck.leftTop[2]\
          elseif cForMove.rightTop and cForCheck.rightTop then\
            return cForMove.rightTop[1] == cForCheck.rightTop[1] and cForMove.rightTop[2] == cForCheck.rightTop[2]\
          elseif cForMove.leftBotton and cForCheck.leftBotton then\
            return cForMove.leftBotton[1] == cForCheck.leftBotton[1] and cForMove.leftBotton[2] == cForCheck.leftBotton[2]\
          elseif cForMove.rightBotton and cForCheck.rightBotton then\
            return cForMove.rightBotton[1] == cForCheck.rightBotton[1] and cForMove.rightBotton[2] == cForCheck.rightBotton[2]\
          end\
        end)\
        if index > 0 then\
          local cfm = store.mapType1.checkpositionListForCheck[index]\
          table.remove(store.mapType1.checkpositionListForCheck, index)\
          table.insert(store.mapType1.checkpositionListForCheck, 1, cfm)\
        end\
      end\
      return makeAction('MAPS_TYPE_1_MOVE_TO_CHECK_POSITION_FOR_CHECK')\
\
    elseif action.type == 'MAPS_TYPE_1_MOVE_TO_CHECK_POSITION_FOR_CHECK' then\
\
      stepLabel.setStepLabelContent('3-2.获取地图位置参数')\
      local targetPosition = store.mapType1.checkpositionListForCheck[1]\
      local currentPosition = mapProxy.getMapPosition(targetPosition)\
\
      stepLabel.setStepLabelContent('3-3.计算移动向量')\
      local targetPosition = store.mapType1.checkpositionListForCheck[1]\
      local newMoveVector, effectiveStep = mapProxy.getMoveVector(currentPosition, targetPosition)\
      if effectiveStep and comparePoints(store.mapType1.moveVectorForCheck, newMoveVector) then\
        store.mapType1.moveVectorForCheck = newMoveVector\
        local newstateTypes = c.yield(setScreenListeners(battleListenerList, {\
          { 'MAPS_TYPE_1_SCAN_MAP', o.battle.isMapPage, 500 },\
        }))\
        return makeAction(newstateTypes)\
      end\
\
      stepLabel.setStepLabelContent('3-3.移动地图')\
      local isCenter = mapProxy.moveMapToCheckPosition(newMoveVector)\
      if isCenter then\
        -- 地图已经移动到位\
        local newstateTypes = c.yield(setScreenListeners(battleListenerList, {\
          { 'MAPS_TYPE_1_SCAN_MAP', o.battle.isMapPage, 500 },\
        }))\
        return makeAction(newstateTypes)\
      else\
        -- 地图没有移动到位\
        local newstateTypes = c.yield(setScreenListeners(battleListenerList, {\
          { 'MAPS_TYPE_1_MOVE_TO_CHECK_POSITION_FOR_CHECK', o.battle.isMapPage },\
        }))\
        return makeAction(newstateTypes)\
      end\
\
      store.mapType1.moveVectorForCheck = newMoveVector\
      local newstateTypes = c.yield(setScreenListeners(battleListenerList, {\
        { 'MAPS_TYPE_1_MOVE_TO_CHECK_POSITION_FOR_CHECK', o.battle.isMapPage },\
      }))\
      return makeAction(newstateTypes)\
\
    elseif action.type == 'MAPS_TYPE_1_SCAN_MAP' then\
\
      stepLabel.setStepLabelContent('3-5.扫描地图')\
      local targetPosition = store.mapType1.checkpositionListForCheck[1]\
      store.mapType1.newMapChessboard = mapProxy.scanMap(targetPosition, store.mapType1.newMapChessboard)\
      -- 地图没扫描完，继续扫描\
      if #store.mapType1.checkpositionListForCheck > 1 then\
        table.remove(store.mapType1.checkpositionListForCheck, 1)\
        local newstateTypes = c.yield(setScreenListeners(battleListenerList, {\
          { 'MAPS_TYPE_1_MOVE_TO_CHECK_POSITION_FOR_CHECK', o.battle.isMapPage },\
        }))\
        return makeAction(newstateTypes)\
      end\
\
      -- 扫描完毕，将 newMapChessboard 与 mapChessboard 合并\
      store.mapType1.mapChessboard = mapProxy.assignMapChessboard(store.mapType1.mapChessboard, store.mapType1.newMapChessboard)\
      console.log(store.mapType1.mapChessboard)\
      -- 如果扫描内容是空的，重新扫描\
      if #store.mapType1.mapChessboard.myFleetList == 0 then\
        local newstateTypes = c.yield(setScreenListeners(battleListenerList, {\
          { 'MAPS_TYPE_1_INIT', o.battle.isMapPage },\
        }))\
      end\
\
      -- 进入移动步骤\
      local newstateTypes = c.yield(setScreenListeners(battleListenerList, {\
        { 'MAPS_TYPE_1_GET_NEXT_STEP', o.battle.isMapPage },\
      }))\
      return makeAction(newstateTypes)\
\
    elseif action.type == 'MAPS_TYPE_1_GET_NEXT_STEP' then\
\
      stepLabel.setStepLabelContent('3-6.计算下一步往哪走')\
      local mapChessboard = store.mapType1.mapChessboard\
      local myFleetList = mapChessboard.myFleetList\
      local inBattleList = mapChessboard.inBattleList\
      local waitForBossPosition = mapChessboard.waitForBossPosition[1]\
      if not waitForBossPosition then\
        store.mapType1.missionStep = 'moveToClosestEnemy'\
      end\
      if table.findIndex(inBattleList, function(ele) return comparePoints(ele, myFleetList[1]) end) > -1 then\
        stepLabel.setStepLabelContent('3-7.开始战斗')\
        o.battle.clickAttackBtn()\
      elseif #mapChessboard.bossPosition > 0 then\
        stepLabel.setStepLabelContent('3-8.移动到boss位置')\
        store.mapType1.missionStep = 'moveToBoss'\
        store.mapType1.nextStepPoint = mapProxy.checkMoveToPointPath(mapChessboard, mapChessboard.myFleetList[1], mapChessboard.bossPosition[1])\
      elseif store.mapType1.missionStep == 'moveToWaitBoss' and table.findIndex(myFleetList, function(ele) return comparePoints(ele, waitForBossPosition) end) > -1 then\
        store.mapType1.missionStep = 'moveToClosestEnemy'\
        local newstateTypes = c.yield(setScreenListeners(battleListenerList, {\
          { 'MAPS_TYPE_1_GET_NEXT_STEP', o.battle.isMapPage },\
        }))\
        return makeAction(newstateTypes)\
      elseif store.mapType1.missionStep == 'moveToWaitBoss' then\
        stepLabel.setStepLabelContent('3-9.移动待命位置')\
        store.mapType1.nextStepPoint = mapProxy.checkMoveToPointPath(mapChessboard, mapChessboard.myFleetList[1], mapChessboard.waitForBossPosition[1])\
      else\
        stepLabel.setStepLabelContent('3-10.移动到最近的敌人')\
        store.mapType1.missionStep = 'moveToClosestEnemy'\
        local closestEnemy = mapProxy.findClosestEnemy(mapChessboard)\
        store.mapType1.nextStepPoint = closestEnemy\
      end\
      -- 如果还是没有移动目标，则可能是我方舰队挡住了敌人，此时需要随意移动一步\
      -- 尽可能避开敌人\
      if not store.mapType1.nextStepPoint then\
        stepLabel.setStepLabelContent('3-11.随机移动一步')\
        store.mapType1.nextStepPoint = mapProxy.getRandomMoveAStep(mapChessboard)\
      end\
      -- 如果还是没有移动目标，只好重新扫描\
      if not store.mapType1.nextStepPoint then\
        local newstateTypes = c.yield(setScreenListeners(battleListenerList, {\
          { 'MAPS_TYPE_1_START', o.battle.isMapPage },\
        }))\
        return makeAction(newstateTypes)\
      end\
\
      -- 查找目标点在哪个界面\
      store.mapType1.checkpositionListForMove = mapProxy.getCheckpositionList(settings.battleChapter)\
      for _, targetPosition in ipairs(store.mapType1.checkpositionListForMove) do\
        local nextRowNum = store.mapType1.nextStepPoint[1]\
        local nextColNum = store.mapType1.nextStepPoint[2]\
        if targetPosition.pointMap[nextRowNum .. '-' .. nextColNum] then\
          store.mapType1.checkpositionListForMove = { targetPosition }\
          break;\
        end\
      end\
\
      local newstateTypes = c.yield(setScreenListeners(battleListenerList, {\
        { 'MAPS_TYPE_1_PAGE_SELECT_FLEET', o.battle.isMapPage },\
      }))\
      return makeAction(newstateTypes)\
\
    elseif action.type == 'MAPS_TYPE_1_PAGE_SELECT_FLEET' then\
\
      if settings.battleFleet[2] then\
        stepLabel.setStepLabelContent('3-20.检查舰队')\
        if store.mapType1.missionStep == 'moveToWaitBoss' or store.mapType1.missionStep == 'moveToBoss' then\
          local res = o.battle.isSelectedFleed(settings.battleFleet[1])\
          if (not res) and (store.mapType1.changeFleetNum < 2) then\
            store.mapType1.changeFleetNum = store.mapType1.changeFleetNum + 1\
            stepLabel.setStepLabelContent('3-21.选择boss舰队')\
            o.battle.clickSwitchFleetBtn()\
            c.yield(sleepPromise(100))\
            o.battle.clickAttackBtn()\
            local newstateTypes = c.yield(setScreenListeners(battleListenerList, {\
              { 'MAPS_TYPE_1_PAGE_SELECT_FLEET', o.battle.isMapPage, 1000 },\
            }))\
            return makeAction(newstateTypes)\
          end\
        elseif store.mapType1.missionStep == 'moveToClosestEnemy' then\
          local res = o.battle.isSelectedFleed(settings.battleFleet[2])\
          if (not res) and (store.mapType1.changeFleetNum < 2) then\
            store.mapType1.changeFleetNum = store.mapType1.changeFleetNum + 1\
            stepLabel.setStepLabelContent('3-22.选择道中舰队')\
            o.battle.clickSwitchFleetBtn()\
            c.yield(sleepPromise(100))\
            o.battle.clickAttackBtn()\
            local newstateTypes = c.yield(setScreenListeners(battleListenerList, {\
              { 'MAPS_TYPE_1_PAGE_SELECT_FLEET', o.battle.isMapPage, 1000 },\
            }))\
            return makeAction(newstateTypes)\
          end\
        end\
      end\
\
      store.mapType1.changeFleetNum = 0\
      local newstateTypes = c.yield(setScreenListeners(battleListenerList, {\
        { 'MAPS_TYPE_1_GET_MAP_POSITION_FOR_A_STEP', o.battle.isMapPage },\
      }))\
      return makeAction(newstateTypes), state\
\
    elseif action.type == 'MAPS_TYPE_1_GET_MAP_POSITION_FOR_A_STEP' then\
\
      stepLabel.setStepLabelContent('3-11.获取地图位置参数')\
      local targetPosition = store.mapType1.checkpositionListForMove[1]\
      local currentPosition = mapProxy.getMapPosition(targetPosition)\
\
      stepLabel.setStepLabelContent('3-12.计算移动向量')\
      local targetPosition = store.mapType1.checkpositionListForMove[1]\
      local newMoveVector, effectiveStep = mapProxy.getMoveVector(currentPosition, targetPosition)\
      if effectiveStep and comparePoints(store.mapType1.moveVectorForAStep, newMoveVector) then\
        store.mapType1.moveVectorForAStep = newMoveVector\
        local newstateTypes = c.yield(setScreenListeners(battleListenerList, {\
          { 'MAPS_TYPE_1_MOVE_A_STEP', o.battle.isMapPage, 500 },\
        }))\
        return makeAction(newstateTypes)\
      end\
      store.mapType1.moveVectorForAStep = newMoveVector\
      local newstateTypes = c.yield(setScreenListeners(battleListenerList, {\
        { 'MAPS_TYPE_1_MOVE_TO_CHECK_POSITION_FOR_A_STEP', o.battle.isMapPage },\
      }))\
      return makeAction(newstateTypes)\
\
    elseif action.type == 'MAPS_TYPE_1_GET_MOVE_VECTOR_FOR_A_STEP' then\
\
\
\
    elseif action.type == 'MAPS_TYPE_1_MOVE_TO_CHECK_POSITION_FOR_A_STEP' then\
\
      stepLabel.setStepLabelContent('3-13.将地图移动到移动位置')\
      local isCenter = mapProxy.moveMapToCheckPosition(store.mapType1.moveVectorForAStep)\
      if isCenter then\
        local newstateTypes = c.yield(setScreenListeners(battleListenerList, {\
          { 'MAPS_TYPE_1_MOVE_A_STEP', o.battle.isMapPage, 500 },\
        }))\
        return makeAction(newstateTypes), state\
      else\
        local newstateTypes = c.yield(setScreenListeners(battleListenerList, {\
          { 'MAPS_TYPE_1_GET_MAP_POSITION_FOR_A_STEP', o.battle.isMapPage, 1000 },\
        }))\
        return makeAction(newstateTypes)\
      end\
\
    elseif action.type == 'MAPS_TYPE_1_MOVE_A_STEP' then\
\
      stepLabel.setStepLabelContent('3-14.移动舰队位置')\
      local targetPosition = store.mapType1.checkpositionListForMove[1]\
      local nextRowNum = store.mapType1.nextStepPoint[1]\
      local nextColNum = store.mapType1.nextStepPoint[2]\
      if targetPosition.pointMap[nextRowNum .. '-' .. nextColNum] then\
        mapProxy.moveToPoint(targetPosition, store.mapType1.nextStepPoint)\
        o.battle.clickAttackBtn()\
      elseif #store.mapType1.checkpositionListForMove > 0 then\
        local newstateTypes = c.yield(setScreenListeners(battleListenerList, {\
          { 'MAPS_TYPE_1_GET_MAP_POSITION_FOR_A_STEP', o.battle.isMapPage },\
        }))\
        return makeAction(newstateTypes)\
      end\
\
      store.mapType1.checkpositionListForCheck = mapProxy.getCheckpositionList(settings.battleChapter)\
      local newstateTypes = c.yield(setScreenListeners(battleListenerList, {\
        { 'BATTLE_MAP_PAGE_CHECK_ASSISTANT_MODE', o.battle.isMapPage, 3000 }\
      }))\
      return makeAction(newstateTypes)\
    end\
\
    return nil\
  end))\
end\
\
return mapsType1\
" }


package.sourceCode = package.sourceCode or {}
package.sourceCode["./missions/battle.lua"] = { path = "./missions/battle.lua", name = "./missions/battle.lua", source = "local co = require '../lib/co'\
local c = coroutine\
local stepLabel = require '../utils/step-label'\
local makeAction = (require './utils').makeAction\
local sleepPromise = require '../utils/sleep-promise'\
local moBattle = require '../meta-operation/battle'\
local moHome = require '../meta-operation/home'\
local moMap = require '../meta-operation/maps-options/index'\
local setScreenListeners = (require './utils').setScreenListeners\
local store = require '../store'\
local vibratorPromise = require '../utils/vibrator-promise'\
\
store.battle = store.battle or {}\
\
local o = {\
  home = moHome,\
  battle = moBattle,\
  map = moMap,\
}\
\
local battleListenerList = {\
  { '', o.home.isHome, 2000 },\
  { 'BATTLE_BATTLE_CHAPTER_PAGE_BACK_TO_HOME', o.battle.isBattleChapterPage, 2000 },\
  { 'BATTLE_BATTLE_CHAPTER_PAGE_INFO_PANEL_CLICK_INTO', o.battle.isChapterInfoPanel, 2000 },\
  { 'BATTLE_BATTLE_CHAPTER_PAGE_SELECT_FLEET_PANEL_SELECT_FLEET', o.battle.isSelectFleetPanel, 2000 },\
  { 'BATTLE_BATTLE_CHAPTER_PAGE_HARD_SELECT_FLEET_PANEL_CLICK_INTO', o.battle.isHardSelectFleetPanel, 500 },\
  { 'BATTLE_MAP_PAGE_CLOSE_INFOMATION_MODAL', o.battle.isInfomationModal, 2000 },\
  { 'BATTLE_MAP_PAGE', o.battle.isMapPage, 2000 },\
  { 'BATTLE_READY_BATTLE_PAGE_CLICK_BATTLE', o.battle.isReadyBattlePage, 2000 },\
  { 'BATTLE_IN_BATTLE_PAGE', o.battle.isInBattlePage, 2000 },\
  { 'BATTLE_VICTORY_PAGE', o.battle.isVictoryPanel, 2000 },\
  { 'BATTLE_GET_PROPS_PANEL', o.battle.isGetPropsPanel, 2000 },\
  { 'BATTLE_GET_NEW_SHIP_PANEL', o.battle.isGetNewShipPanel, 2000 },\
  { 'BATTLE_GET_EXP_PANEL', o.battle.isGetExpPanel, 2000 },\
}\
\
local battle = function(action)\
  local settings = store.settings;\
  local mapProxy = o.map['map' .. settings.battleChapter]\
\
  return co(c.create(function()\
    if action.type == 'BATTLE_INIT' then\
\
      -- 是否自动模式，如果没有相应配置的话会自动从自动切换到手动\
      store.battle.battleAssistantMode = settings.battleAssistantMode\
\
      return {\
        makeAction('MAPS_TYPE_2_PRE_INIT'),\
        makeAction('MAPS_TYPE_3_PRE_INIT'),\
        makeAction('MAPS_TYPE_4_PRE_INIT'),\
        makeAction('SCAN_MAP_TYPE_1_PRE_INIT'),\
        makeAction('BATTLE_START'),\
      }\
\
    elseif action.type == 'BATTLE_START' then\
\
      stepLabel.setStepLabelContent('2.1.等待桌面')\
      local newstateTypes = c.yield(setScreenListeners(battleListenerList, {\
        { 'BATTLE_HOME_CLICK_BATTLE', o.home.isHome, 2000 },\
      }))\
      return makeAction(newstateTypes)\
\
    elseif action.type == 'BATTLE_HOME_CLICK_BATTLE' then\
\
      if settings.battleChapter ~= '0' then\
        stepLabel.setStepLabelContent('2.2.点击出击')\
        if string.sub(settings.battleChapter, 1, 5) == 'event' then\
          o.battle.clickEventBtn()\
        else\
          o.battle.clickBattleBtn()\
        end\
      end\
      local newstateTypes = c.yield(setScreenListeners(battleListenerList, {\
        { 'BATTLE_HOME_CLICK_BATTLE', o.home.isHome, 2000 },\
        { 'BATTLE_BATTLE_CHAPTER_PAGE_SELECT_MODE', o.battle.isBattleChapterPage },\
      }))\
      return makeAction(newstateTypes)\
\
    elseif action.type == 'BATTLE_BATTLE_CHAPTER_PAGE_SELECT_MODE' then\
\
      if settings.battleChapter ~= '0' then\
        stepLabel.setStepLabelContent('2.3.选择章节界面')\
        if settings.battleMode == 'normal' and o.battle.isHardMode() then\
          stepLabel.setStepLabelContent('2.4.切换为普通模式')\
        elseif settings.battleMode == 'hard' and o.battle.isNormalMode() then\
          stepLabel.setStepLabelContent('2.5.切换为困难模式')\
        end\
\
        if (settings.battleMode == 'normal' and o.battle.isHardMode())\
          or (settings.battleMode == 'hard' and o.battle.isNormalMode()) then\
          o.battle.clickSwitchHardModeBtn()\
          c.yield(sleepPromise(500))\
          local newstateTypes = c.yield(setScreenListeners(battleListenerList, {\
            { 'BATTLE_BATTLE_CHAPTER_PAGE_SELECT_MODE', o.battle.isBattleChapterPage },\
          }))\
          return makeAction(newstateTypes)\
        end\
      end\
\
      local newstateTypes = c.yield(setScreenListeners(battleListenerList, {\
        { 'BATTLE_BATTLE_CHAPTER_PAGE_MOVE_TO_CHAPTER', o.battle.isBattleChapterPage },\
      }))\
      return makeAction(newstateTypes)\
\
    elseif action.type == 'BATTLE_BATTLE_CHAPTER_PAGE_MOVE_TO_CHAPTER' then\
\
      if settings.battleChapter ~= '0' then\
        stepLabel.setStepLabelContent('2.6.移动到第' .. settings.battleChapter .. '章')\
        o.battle.moveToChapter(settings.battleChapter)\
      end\
      c.yield(sleepPromise(500))\
      -- 检查是否在所需的章节\
      if not o.battle.checkChapter(settings.battleChapter) then\
        stepLabel.setStepLabelContent('2.6.移动到第' .. settings.battleChapter .. '章失败，重新移动')\
        local newstateTypes = c.yield(setScreenListeners(battleListenerList, {\
          { 'BATTLE_BATTLE_CHAPTER_PAGE_MOVE_TO_CHAPTER', o.battle.isBattleChapterPage },\
        }))\
        return makeAction(newstateTypes)\
      end\
\
      -- 点击章节\
      o.battle.clickChapter(settings.battleChapter)\
\
      local newstateTypes = c.yield(setScreenListeners(battleListenerList, {\
        { 'BATTLE_BATTLE_CHAPTER_PAGE_MOVE_TO_CHAPTER', o.battle.isBattleChapterPage, 2000 },\
        { 'BATTLE_BATTLE_CHAPTER_PAGE_INFO_PANEL_CLICK_INTO', o.battle.isChapterInfoPanel },\
      }))\
      return makeAction(newstateTypes)\
\
    elseif action.type == 'BATTLE_BATTLE_CHAPTER_PAGE_INFO_PANEL_CLICK_INTO' then\
\
      stepLabel.setStepLabelContent('2.6.章节信息面板')\
      stepLabel.setStepLabelContent('2.6.点击继续')\
      o.battle.clickGotoSelectFleedPanelBtn()\
\
      local newstateTypes = c.yield(setScreenListeners(battleListenerList, {\
        { 'BATTLE_BATTLE_CHAPTER_PAGE_INFO_PANEL_CLICK_INTO', o.battle.isChapterInfoPanel, 2000 },\
        { 'BATTLE_BATTLE_CHAPTER_PAGE_SELECT_FLEET_PANEL_SELECT_FLEET', o.battle.isSelectFleetPanel },\
        { 'BATTLE_BATTLE_CHAPTER_PAGE_HARD_SELECT_FLEET_PANEL_CLICK_INTO', o.battle.isHardSelectFleetPanel },\
      }))\
      return makeAction(newstateTypes)\
\
    elseif action.type == 'BATTLE_BATTLE_CHAPTER_PAGE_SELECT_FLEET_PANEL_SELECT_FLEET' then\
      -- 1.7.19 版本后选择舰队方法变了，太复杂所以不做选择舰队了。\
      --      stepLabel.setStepLabelContent('2.7.选择舰队面板')\
      --      stepLabel.setStepLabelContent('2.8.检查已选择的舰队')\
      --      local res, selectList, unselectList, selectedFeeldList = o.battle.checkSelectedFleet(settings.battleFleet)\
      --      if not res then\
      --        stepLabel.setStepLabelContent('2-9.选择舰队 ' .. table.concat(settings.battleFleet, ','))\
      --        if #selectedFeeldList <= 1 then\
      --          o.battle.clickFleet(selectList)\
      --        else\
      --          o.battle.clickFleet(unselectList)\
      --        end\
      --        local newstateTypes = c.yield(setScreenListeners(battleListenerList, {\
      --          { 'BATTLE_BATTLE_CHAPTER_PAGE_SELECT_FLEET_PANEL_SELECT_FLEET', o.battle.isSelectFleetPanel, 500 },\
      --          { 'BATTLE_BATTLE_CHAPTER_PAGE_HARD_SELECT_FLEET_PANEL_CLICK_INTO', o.battle.isHardSelectFleetPanel, 500 }\
      --        }))\
      --        return makeAction(newstateTypes)\
      --      end\
\
      stepLabel.setStepLabelContent('2.10.点击进入章节')\
      o.battle.clickGotoMapBtn()\
      local newstateTypes = c.yield(setScreenListeners(battleListenerList, {\
        { 'BATTLE_BATTLE_CHAPTER_PAGE_SELECT_FLEET_PANEL_SELECT_FLEET', o.battle.isSelectFleetPanel, 2000 },\
        { 'BATTLE_BATTLE_CHAPTER_PAGE_HARD_SELECT_FLEET_PANEL_CLICK_INTO', o.battle.isHardSelectFleetPanel, 500 },\
        { 'BATTLE_MAP_PAGE', o.battle.isMapPage },\
      }))\
      return makeAction(newstateTypes)\
\
    elseif action.type == 'BATTLE_BATTLE_CHAPTER_PAGE_HARD_SELECT_FLEET_PANEL_CLICK_INTO' then\
\
      stepLabel.setStepLabelContent('2.11.困难选择舰队面板')\
      stepLabel.setStepLabelContent('2.12.点击立刻前往')\
      o.battle.clickHardGotoSelectFleedPanelBtn()\
      local newstateTypes = c.yield(setScreenListeners(battleListenerList, {\
        { 'BATTLE_MAP_PAGE', o.battle.isMapPage },\
      }))\
      return makeAction(newstateTypes)\
\
    elseif action.type == 'BATTLE_MAP_PAGE' then\
\
      if store.battle.battleAssistantMode == 'auto' and mapProxy then\
        local newstateTypes = c.yield(setScreenListeners(battleListenerList, {\
          { 'BATTLE_MAP_PAGE_CHECK_SCAN_MAP_MODE', o.battle.isMapPage },\
          { 'BATTLE_MAP_PAGE_CLOSE_FORMAT_PANEL', o.battle.isFormationPanel },\
          { 'BATTLE_MAP_PAGE_AMBUSHED_PANEL_AVOID_AMBUSHED', o.battle.isAmbushedPanel },\
          { 'BATTLE_READY_BATTLE_PAGE_CLICK_BATTLE', o.battle.isReadyBattlePage },\
        }))\
        return makeAction(newstateTypes)\
      else\
        store.battle.battleAssistantMode = 'manual'\
      end\
\
      -- 如果选择的关卡没有匹配任何关卡，那么也回到手动模式。\
      stepLabel.setStepLabelContent('2-13.等待用户移动')\
\
      if settings.battleAlertWhenManual then\
        vibratorPromise(3)\
      end\
\
      local newstateTypes = c.yield(setScreenListeners(battleListenerList, {\
        { 'BATTLE_MAP_PAGE', o.battle.isMapPage, 10000 },\
        { 'BATTLE_MAP_PAGE_CLOSE_FORMAT_PANEL', o.battle.isFormationPanel },\
        { 'BATTLE_MAP_PAGE_AMBUSHED_PANEL_AVOID_AMBUSHED', o.battle.isAmbushedPanel },\
        { 'BATTLE_READY_BATTLE_PAGE_CLICK_BATTLE', o.battle.isReadyBattlePage },\
      }))\
      return makeAction(newstateTypes)\
\
    elseif action.type == 'BATTLE_MAP_PAGE_CLOSE_FORMAT_PANEL' then\
\
      stepLabel.setStepLabelContent('2.14.关闭阵型面板')\
      o.battle.closeFormationPanel()\
      local newstateTypes = c.yield(setScreenListeners(battleListenerList, {\
        { 'BATTLE_MAP_PAGE', o.battle.isMapPage, 2000 },\
        { 'BATTLE_MAP_PAGE_CLOSE_FORMAT_PANEL', o.battle.isFormationPanel, 2000 },\
        { 'BATTLE_MAP_PAGE_AMBUSHED_PANEL_AVOID_AMBUSHED', o.battle.isAmbushedPanel },\
      }))\
      return makeAction(newstateTypes)\
\
    elseif action.type == 'BATTLE_MAP_PAGE_AMBUSHED_PANEL_AVOID_AMBUSHED' then\
\
      stepLabel.setStepLabelContent('2.15.躲避伏击')\
      if settings.battleRoundabout then\
        o.battle.ambushedPanelClickAvoidBtn()\
      else\
        o.battle.ambushedPanelClickInterceptBtn()\
      end\
      local newstateTypes = c.yield(setScreenListeners(battleListenerList, {\
        { 'BATTLE_MAP_PAGE', o.battle.isMapPage, 3000 },\
        { 'BATTLE_MAP_PAGE_CLOSE_FORMAT_PANEL', o.battle.isFormationPanel },\
        { 'BATTLE_MAP_PAGE_AMBUSHED_PANEL_AVOID_AMBUSHED', o.battle.isAmbushedPanel, 2000 },\
      }))\
      return makeAction(newstateTypes)\
\
    elseif action.type == 'BATTLE_MAP_PAGE_CLOSE_INFOMATION_MODAL' then\
\
      stepLabel.setStepLabelContent('2.15.关闭信息弹窗')\
      o.battle.infomationModalClickClose()\
      local newstateTypes = c.yield(setScreenListeners(battleListenerList, {\
        { 'BATTLE_MAP_PAGE', o.battle.isMapPage, 3000 },\
        { 'BATTLE_MAP_PAGE_CLOSE_FORMAT_PANEL', o.battle.isFormationPanel },\
        { 'BATTLE_MAP_PAGE_AMBUSHED_PANEL_AVOID_AMBUSHED', o.battle.isAmbushedPanel, 2000 },\
      }))\
      return makeAction(newstateTypes)\
\
    elseif (action.type == 'BATTLE_MAP_PAGE_WAIT_FOR_MOVE') then\
\
      stepLabel.setStepLabelContent('2-23.等待用户移动')\
      c.yield(sleepPromise(1000))\
\
      vibratorPromise(3)\
\
      local newstateTypes = c.yield(setScreenListeners(battleListenerList, {\
        { 'BATTLE_MAP_PAGE_WAIT_FOR_MOVE', o.battle.isMapPage, 10000 },\
      }))\
      return makeAction(newstateTypes)\
\
    elseif (action.type == 'BATTLE_MAP_PAGE_CHECK_SCAN_MAP_MODE') then\
\
      stepLabel.setStepLabelContent('2-19.检测是自动模式还是辅助模式')\
      if store.battle.battleAssistantMode == 'auto' then\
        local type1 = {\
          '1-1', '1-2', '1-3', '1-4',\
          '2-1', '2-2', '2-3', '2-4',\
          '3-1', '3-2', '3-3', '3-4',\
          '4-1', '4-2', '4-3', '4-4',\
          '5-1', '5-2', '5-3', '5-4',\
          '6-1', '6-2', '6-3', '6-4',\
          '7-1', '7-2', '7-3', '7-4',\
          '8-1', '8-2', '8-3', '8-4',\
          '9-1', '9-2', '9-3', '9-4',\
          '10-1', '10-2', '10-3', '10-4',\
          '11-1', '11-2', '11-3',\
          '12-1',\
          'event15-1-a2', 'event15-2-b2',\
        }\
        if table.findIndex(type1, settings.battleChapter) > -1 then\
          stepLabel.setStepLabelContent('2-19.scan-map-type-1')\
          local newstateTypes = c.yield(setScreenListeners(battleListenerList, {\
            { 'BATTLE_BATTLE_CHAPTER_PAGE_BACK_TO_HOME', o.battle.isBattleChapterPage, 2000 },\
            { 'BATTLE_MAP_PAGE_AMBUSHED_PANEL_AVOID_AMBUSHED', o.battle.isAmbushedPanel, 1000 },\
            { 'SCAN_MAP_TYPE_1_INIT', o.battle.isMapPage, 2000 },\
          }))\
          return makeAction(newstateTypes)\
        end\
      end\
      local newstateTypes = c.yield(setScreenListeners(battleListenerList, {\
        { 'BATTLE_BATTLE_CHAPTER_PAGE_BACK_TO_HOME', o.battle.isBattleChapterPage, 2000 },\
        { 'BATTLE_MAP_PAGE_AMBUSHED_PANEL_AVOID_AMBUSHED', o.battle.isAmbushedPanel, 1000 },\
        { 'BATTLE_MAP_PAGE_WAIT_FOR_MOVE', o.battle.isMapPage, 2000 },\
      }))\
      return makeAction(newstateTypes)\
\
    elseif action.type == 'BATTLE_MAP_PAGE_CHECK_MAP_MODE' then\
\
      stepLabel.setStepLabelContent('2-19.战斗模式')\
      if store.battle.battleAssistantMode == 'auto' then\
        local canAutoChapter = {\
          '1-1', '1-2', '1-3', '1-4',\
          '2-1', '2-2', '2-3', '2-4',\
          '3-1', '3-2', '3-3', '3-4',\
          '4-1', '4-2', '4-3', '4-4',\
          '5-1', '5-2', '5-3', '5-4',\
          '6-1', '6-2', '6-3', '6-4',\
          '7-1', '7-2', '7-3', '7-4',\
          '8-1', '8-2', '8-3', '8-4',\
          '9-1', '9-2', '9-3', '9-4',\
          '10-1', '10-2', '10-3', '10-4',\
          '11-1', '11-2', '11-3',\
          '12-1',\
          'event15-1-a2', 'event15-2-b2',\
        }\
        if table.findIndex(canAutoChapter, settings.battleChapter) > -1 then\
          if settings.mapsType == 'maps-type-2' then\
            stepLabel.setStepLabelContent('2-19.maps-type-2')\
            local newstateTypes = c.yield(setScreenListeners(battleListenerList, {\
              { 'BATTLE_BATTLE_CHAPTER_PAGE_BACK_TO_HOME', o.battle.isBattleChapterPage, 2000 },\
              { 'BATTLE_MAP_PAGE_AMBUSHED_PANEL_AVOID_AMBUSHED', o.battle.isAmbushedPanel, 1000 },\
              { 'MAPS_TYPE_2_INIT', o.battle.isMapPage, 2000 },\
            }))\
            return makeAction(newstateTypes)\
          elseif settings.mapsType == 'maps-type-3' then\
            stepLabel.setStepLabelContent('2-19.maps-type-3')\
            local newstateTypes = c.yield(setScreenListeners(battleListenerList, {\
              { 'BATTLE_BATTLE_CHAPTER_PAGE_BACK_TO_HOME', o.battle.isBattleChapterPage, 2000 },\
              { 'BATTLE_MAP_PAGE_AMBUSHED_PANEL_AVOID_AMBUSHED', o.battle.isAmbushedPanel, 1000 },\
              { 'MAPS_TYPE_3_INIT', o.battle.isMapPage, 2000 },\
            }))\
            return makeAction(newstateTypes)\
          elseif settings.mapsType == 'maps-type-4' then\
            stepLabel.setStepLabelContent('2-19.maps-type-4')\
            local newstateTypes = c.yield(setScreenListeners(battleListenerList, {\
              { 'BATTLE_BATTLE_CHAPTER_PAGE_BACK_TO_HOME', o.battle.isBattleChapterPage, 2000 },\
              { 'BATTLE_MAP_PAGE_AMBUSHED_PANEL_AVOID_AMBUSHED', o.battle.isAmbushedPanel, 1000 },\
              { 'MAPS_TYPE_4_INIT', o.battle.isMapPage, 2000 },\
            }))\
            return makeAction(newstateTypes)\
          end\
        end\
      end\
      local newstateTypes = c.yield(setScreenListeners(battleListenerList, {\
        { 'BATTLE_BATTLE_CHAPTER_PAGE_BACK_TO_HOME', o.battle.isBattleChapterPage, 2000 },\
        { 'BATTLE_MAP_PAGE_AMBUSHED_PANEL_AVOID_AMBUSHED', o.battle.isAmbushedPanel, 1000 },\
        { 'BATTLE_MAP_PAGE_WAIT_FOR_MOVE', o.battle.isMapPage, 2000 },\
      }))\
      return makeAction(newstateTypes)\
\
    elseif action.type == 'BATTLE_READY_BATTLE_PAGE_CLICK_BATTLE' then\
\
      stepLabel.setStepLabelContent('2.16.准备战斗')\
      c.yield(sleepPromise(1000))\
      o.battle.readyBattlePageClickBattle()\
      local newstateTypes = c.yield(setScreenListeners(battleListenerList, {\
        { 'BATTLE_MAP_PAGE', o.battle.isMapPage },\
        { 'BATTLE_READY_BATTLE_PAGE_CLICK_BATTLE', o.battle.isReadyBattlePage, 2000 },\
        { 'BATTLE_IN_BATTLE_PAGE', o.battle.isInBattlePage },\
      }))\
      return makeAction(newstateTypes)\
\
    elseif action.type == 'BATTLE_IN_BATTLE_PAGE' then\
\
      stepLabel.setStepLabelContent('2.17.战斗中检测是否自动战斗')\
      local newstateTypes = c.yield(setScreenListeners(battleListenerList, {\
        { 'BATTLE_IN_BATTLE_PAGE', o.battle.isInBattlePage, 86400000 },\
        { 'BATTLE_IN_BATTLE_PAGE_CLICK_AUTO_BATTLE', o.battle.isNotAutoBattle, 2000 },\
        { 'BATTLE_IN_BATTLE_PAGE_AUTO_BATTLE_CONFIRM_PANEL', o.battle.isAutoBattleConfirmPanel },\
      }))\
      return makeAction(newstateTypes)\
\
    elseif action.type == 'BATTLE_IN_BATTLE_PAGE_CLICK_AUTO_BATTLE' then\
\
      stepLabel.setStepLabelContent('2.18.点击自动战斗')\
      c.yield(sleepPromise(500))\
      o.battle.inBattlePageClickAutoBattle()\
      local newstateTypes = c.yield(setScreenListeners(battleListenerList, {\
        { 'BATTLE_IN_BATTLE_PAGE', o.battle.isInBattlePage, 2000 },\
        { 'BATTLE_IN_BATTLE_PAGE_AUTO_BATTLE_CONFIRM_PANEL', o.battle.isAutoBattleConfirmPanel },\
      }))\
      return makeAction(newstateTypes)\
\
    elseif action.type == 'BATTLE_IN_BATTLE_PAGE_AUTO_BATTLE_CONFIRM_PANEL' then\
\
      stepLabel.setStepLabelContent('2.19.自动战斗面板点击确认')\
      o.battle.autoBattleConfirmPanelClickOk()\
      local newstateTypes = c.yield(setScreenListeners(battleListenerList, {\
        { 'BATTLE_IN_BATTLE_PAGE', o.battle.isInBattlePage, 2000 },\
        { 'BATTLE_IN_BATTLE_PAGE_AUTO_BATTLE_CONFIRM_PANEL', o.battle.isAutoBattleConfirmPanel, 2000 },\
      }))\
      return makeAction(newstateTypes)\
\
    elseif action.type == 'BATTLE_VICTORY_PAGE' then\
\
      stepLabel.setStepLabelContent('2.20.胜利面板点击继续')\
      o.battle.victoryPanelClickNext()\
      local newstateTypes = c.yield(setScreenListeners(battleListenerList, {\
        { 'BATTLE_IN_BATTLE_PAGE', o.battle.isInBattlePage, 2000 },\
      }))\
      return makeAction(newstateTypes)\
\
    elseif action.type == 'BATTLE_VICTORY_PAGE' then\
\
      stepLabel.setStepLabelContent('2.21.胜利面板点击继续')\
      o.battle.victoryPanelClickNext()\
      local newstateTypes = c.yield(setScreenListeners(battleListenerList, {\
        { 'BATTLE_VICTORY_PAGE', o.battle.isGetPropsPanel, 2000 },\
        { 'BATTLE_GET_PROPS_PANEL', o.battle.isGetPropsPanel },\
      }))\
      return makeAction(newstateTypes)\
\
    elseif action.type == 'BATTLE_GET_PROPS_PANEL' then\
\
      stepLabel.setStepLabelContent('2.22.获得道具面板点击继续')\
      o.battle.getPropsPanelClickNext()\
      local newstateTypes = c.yield(setScreenListeners(battleListenerList, {\
        { 'BATTLE_GET_PROPS_PANEL', o.battle.isGetPropsPanel, 2000 },\
        { 'BATTLE_GET_NEW_SHIP_PANEL', o.battle.isGetNewShipPanel },\
      }))\
      return makeAction(newstateTypes)\
\
    elseif action.type == 'BATTLE_GET_NEW_SHIP_PANEL' then\
\
      stepLabel.setStepLabelContent('2.23.获得新船面板点击继续')\
      o.battle.getNewShipPanelClickNext()\
      local newstateTypes = c.yield(setScreenListeners(battleListenerList, {\
        { 'BATTLE_GET_NEW_SHIP_PANEL', o.battle.isGetNewShipPanel, 2000 },\
        { 'BATTLE_GET_EXP_PANEL', o.battle.isGetExpPanel },\
      }))\
      return makeAction(newstateTypes)\
\
\
    elseif action.type == 'BATTLE_GET_EXP_PANEL' then\
\
      stepLabel.setStepLabelContent('2.24.获得经验面板点击继续')\
      o.battle.getExpPanelClickNext()\
      local newstateTypes = c.yield(setScreenListeners(battleListenerList, {\
        { 'BATTLE_GET_EXP_PANEL', o.battle.isGetExpPanel, 2000 },\
        { '', o.home.isHome, 2000 },\
      }))\
      return makeAction(newstateTypes)\
\
    elseif action.type == 'BATTLE_BATTLE_CHAPTER_PAGE_BACK_TO_HOME' then\
\
      o.battle.battlePageClickBackToHome()\
      return makeAction('')\
    end\
\
    return nil\
  end))\
end\
\
return battle\
" }


package.sourceCode = package.sourceCode or {}
package.sourceCode["./lib/lfs.lua"] = { path = "./lib/lfs.lua", name = "./lib/lfs.lua", source = "local lfs = {}\
\
lfs.dir = function(path)\
  local res = io.popen('ls ' .. path);\
  local text = {};\
  for line in res:lines() do\
    table.insert(text, line)\
  end\
  return text\
end\
\
lfs.rm = function(path)\
  local res = io.popen('rm ' .. path);\
  local text = {};\
  for line in res:lines() do\
    table.insert(text, line)\
  end\
  local res = table.concat(text, '\\n')\
  return res\
end\
\
lfs.rmdir = function(path)\
  local res = io.popen('rm -rf' .. path);\
  local text = {};\
  for line in res:lines() do\
    table.insert(text, line)\
  end\
  local res = table.concat(text, '\\n')\
  return res\
end\
\
return lfs" }


package.sourceCode = package.sourceCode or {}
package.sourceCode["./utils/step-label.lua"] = { path = "./utils/step-label.lua", name = "./utils/step-label.lua", source = "local StepLable = {\
  originText = '',\
  text = '',\
  labelId = '',\
  prefix = '',\
}\
\
local fontSize = 16\
local tsver = getTSVer(); --获取触动精灵引擎版本\
local tsint = tonumber(string.sub(tsver, 1, 1) .. string.sub(tsver, 3, 3) .. string.sub(tsver, 5, 5));\
--转化为数字版本号\
if tsint >= 170 then\
  fontSize = 7\
end\
\
if tsint < 230 then\
  fwShowWnd('steplabel', 350, 50, 300, 100, 0)\
else\
  fwShowWnd('steplabel', 350, 50, 650, 150, 0)\
end\
\
StepLable.init = function(labelId)\
  StepLable.labelId = labelId\
  return StepLable\
end\
\
StepLable.setPrefix = function(prefix)\
  StepLable.prefix = prefix\
  local finalText = StepLable.prefix .. StepLable.text\
  fwShowButton('steplabel', StepLable.labelId, finalText, '90333333', '90FFFFFF', '', fontSize, 0, 0, 300, 100)\
  return StepLable\
end\
\
StepLable.setStepLabelContent = function(text, noNLog)\
  StepLable.originText = text\
  if ((type(runCount) == 'number') or (type(runCode) == 'string')) then\
    text = tostring(runCount) .. '.. ' .. text\
  end\
  StepLable.text = text\
  local finalText = StepLable.prefix .. text\
  fwShowButton('steplabel', StepLable.labelId, finalText, '90333333', '90FFFFFF', '', 7, 0, 0, 300, 100)\
  local dateStr = os.date('%Y-%m-%d %X')\
  if not noNLog then\
    local info = debug.getinfo(2, 'Sl')\
    local lineInfo = ''\
    if info.currentline then\
      lineInfo = info.source .. ': ' .. info.currentline .. ': '\
    end\
    wLog('azur_lane', '[DATE] ' .. lineInfo .. finalText);\
  end\
  if useNlog then\
    local info = debug.getinfo(2, 'Sl')\
    local lineInfo = ''\
    if info.currentline then\
      lineInfo = info.source .. ': ' .. info.currentline .. ':\\n'\
    end\
    nLog(lineInfo .. dateStr .. ' ' .. finalText .. '\\n')\
  end\
end\
\
StepLable.getText = function()\
  return StepLable.originText\
end\
\
return StepLable\
" }


package.sourceCode = package.sourceCode or {}
package.sourceCode["./store.lua"] = { path = "./store.lua", name = "./store.lua", source = "return {}\
" }


package.sourceCode = package.sourceCode or {}
package.sourceCode["./utils/sleep-promise.lua"] = { path = "./utils/sleep-promise.lua", name = "./utils/sleep-promise.lua", source = "if type(Promise) ~= 'table' then\
  error('SleepPromise need Promise module to work. Please require \\'Promise\\' as global variable.', 2)\
end\
if type(EventQuery) ~= 'table' then\
  error('SleepPromise need EventQuery module to work. Please require \\'EventQuery\\' as global variableß .', 2)\
end\
\
local sleepPromise = function(ms)\
  return Promise.new(function(resolve)\
    EventQuery.setTimeout(resolve, ms)\
  end)\
end\
return sleepPromise\
" }


package.sourceCode = package.sourceCode or {}
package.sourceCode["./missions/index.lua"] = { path = "./missions/index.lua", name = "./missions/index.lua", source = "local co = require '../lib/co'\
local battle = require './battle'\
local mapsType1 = require './maps-type-1'\
local mapsType2 = require './maps-type-2'\
local mapsType3 = require './maps-type-3'\
local mapsType4 = require './maps-type-4'\
local scanMapsType1 = require './scan-map-type-1'\
\
-- 将分散在各个文件的任务集合到一起\
local missions = {\
  battle,\
  mapsType1,\
  mapsType2,\
  mapsType3,\
  mapsType4,\
  scanMapsType1,\
}\
\
return missions\
" }


package.sourceCode = package.sourceCode or {}
package.sourceCode["./lib/mission-chain.lua"] = { path = "./lib/mission-chain.lua", name = "./lib/mission-chain.lua", source = "local socket = require 'socket'\
local co = require './co'\
local c = coroutine\
\
return {\
  createChain = function(missionStoreList)\
    assert(type(missionStoreList) == 'table', ' bad argument # 1 \"createChain\"(table excepted, got ' .. type(missionStoreList) .. ')')\
\
    local defaultOptions = {\
      runCount = 0,\
      missionsQuery = {},\
      beforeAction = function() end,\
      afterAction = function() end,\
    }\
    local chainObj\
    chainObj = {\
      runMission = function(options)\
        options = options or {}\
        options.runCount = options.runCount or defaultOptions.runCount\
        options.missionsQuery = options.missionsQuery or defaultOptions.missionsQuery\
        options.beforeAction = options.beforeAction or defaultOptions.beforeAction\
        options.afterAction = options.afterAction or defaultOptions.afterAction\
\
        local runStartTime = socket.gettime() * 1000\
        local missionsQuery = {}\
        table.insert(missionsQuery, { isBase = true, isStart = true })\
        for key = 1, #options.missionsQuery do\
          table.insert(missionsQuery, options.missionsQuery[key])\
        end\
        table.insert(missionsQuery, { isBase = true, isEnd = true })\
\
        while (#missionsQuery > 0 and not luaExisted) do\
          local action = missionsQuery[1]\
\
          if (action.isStart) then\
            runStartTime = socket.gettime() * 1000\
          end\
\
          c.yield(options.beforeAction({\
            action = action,\
            missionsQuery = missionsQuery,\
            runCount = options.runCount,\
            runStartTime = runStartTime,\
          }))\
\
          -- 如果是队列原有任务则将其加入队列末尾，以保证能一直循环\
          -- 如果是从原有任务衍生的下一步任务，则不加入队列末尾，会被新的下一步任务替换或者删除\
          if (action.isBase) then\
            table.insert(missionsQuery, action)\
          end\
\
          -- 执行一个 action\
          if action.type then\
            local nextAction = c.yield(chainObj.next(action))\
            if type(nextAction) == 'table' and type(nextAction[1]) == 'table' and nextAction[1].type then\
              -- 返回的是 action 列表，将列表插入到 missionsQuery 的开头\
              table.remove(missionsQuery, 1)\
              for key = #nextAction, 1, -1 do\
                table.insert(missionsQuery, 1, nextAction[key])\
              end\
            elseif type(nextAction) == 'table' and nextAction.type then\
              -- 返回的是单个 action\
              if nextAction.addToStart then\
                table.insert(missionsQuery, 1, nextAction)\
              else\
                missionsQuery[1] = nextAction\
              end\
            else\
              table.remove(missionsQuery, 1)\
            end\
          else\
            table.remove(missionsQuery, 1)\
          end\
\
          c.yield(options.afterAction({\
            action = action,\
            nextAction = missionsQuery[1],\
            missionsQuery = missionsQuery,\
            runCount = options.runCount,\
            runStartTime = runStartTime,\
          }))\
\
          if (action.isEnd) then\
            options.runCount = options.runCount + 1\
          end\
\
          -- 如果是任务队列结尾标志，则count+1\
        end\
      end,\
      next = function(action)\
        if type(action) ~= 'table' then\
          error(' bad argument #1 \"next\"(table excepted, got ' .. type(action) .. ')', 2)\
        end\
\
        return co(c.create(function()\
          if action.type and action.type ~= '' then\
            local nextAction\
            for key = 1, #missionStoreList do\
              local item = missionStoreList[key]\
              local theAction = c.yield(item(action))\
              if theAction then\
                nextAction = theAction\
              end\
            end\
            if not nextAction then\
              error('Action \"' .. action.type .. '\" not found')\
            end\
            return nextAction\
          end\
        end))\
      end,\
    }\
    return chainObj\
  end,\
}\
" }


package.sourceCode = package.sourceCode or {}
package.sourceCode["./options-label.lua"] = { path = "./options-label.lua", name = "./options-label.lua", source = "local sz = require 'sz'\
local json = sz.json\
\
local width, height = getScreenSize()\
-- 设置\
return function()\
  local settingTable = {\
    ['style'] = 'default',\
    ['width'] = height,\
    ['height'] = height,\
    ['config'] = 'save_azur_lane.dat',\
    ['timer'] = 5,\
    ['orient'] = 1,\
    ['pagetype'] = 'multi',\
    ['title'] = '选项',\
    ['cancelname'] = '取消',\
    ['okname'] = '开始',\
    ['rettype'] = 'table',\
    ['pages'] = {\
      {\
        {\
          ['type'] = 'Label',\
          ['text'] = '第一次设置建议在竖屏下设置，设置好后再切换到游戏界面',\
          ['size'] = 15,\
          ['align'] = 'left',\
          ['color'] = '0,0,0',\
        },\
        {\
          ['type'] = 'Label',\
          ['text'] = '向左滑动查看其他选项',\
          ['size'] = 15,\
          ['align'] = 'left',\
          ['color'] = '0,0,0',\
        },\
        {\
          ['type'] = 'Label',\
          ['text'] = '出击',\
          ['size'] = 15,\
          ['align'] = 'left',\
          ['color'] = '0,0,0',\
        },\
        {\
          ['id'] = 'battleEnable',\
          ['type'] = 'RadioGroup',\
          ['list'] = '开启,关闭',\
          ['select'] = '0',\
        },\
        {\
          ['type'] = 'Label',\
          ['text'] = '每一轮的间隔时间(秒)',\
          ['size'] = 15,\
          ['align'] = 'left',\
          ['color'] = '0,0,0',\
        },\
        {\
          ['id'] = 'missionsInterval',\
          ['type'] = 'Edit',\
          ['prompt'] = '最短间隔时间(秒)',\
          ['text'] = '1',\
          ['kbtype'] = 'number',\
        },\
        {\
          ['type'] = 'Label',\
          ['text'] = '多长时间画面不变则重启游戏(秒)最少60秒',\
          ['size'] = 15,\
          ['align'] = 'left',\
          ['color'] = '0,0,0',\
        },\
        {\
          ['id'] = 'restartInterval',\
          ['type'] = 'Edit',\
          ['prompt'] = '多长时间画面不变则重启游戏(秒)最少60秒',\
          ['text'] = '120',\
          ['kbtype'] = 'number',\
        },\
        {\
          ['type'] = 'Label',\
          ['text'] = ' \\n \\n \\n \\n \\n \\n \\n \\n \\n \\n',\
          ['size'] = 50,\
          ['align'] = 'left',\
          ['color'] = '0,0,0',\
        },\
      },\
      {\
        {\
          ['type'] = 'Label',\
          ['text'] = '出击设置',\
          ['size'] = 15,\
          ['align'] = 'left',\
          ['color'] = '0,0,0',\
        },\
        {\
          ['type'] = 'Label',\
          ['text'] = '章节(0章节表示不自动进入地图)',\
          ['size'] = 15,\
          ['align'] = 'left',\
          ['color'] = '0,0,0',\
        },\
        {\
          ['id'] = 'battleChapter',\
          ['type'] = 'RadioGroup',\
          ['list'] = '手动,1-1,1-2,1-3,1-4,2-1,2-2,2-3,2-4,3-1,3-2,3-3,3-4,4-1,4-2,4-3,4-4,'\
            .. '5-1,5-2,5-3,5-4,6-1,6-2,6-3,6-4,7-1,7-2,7-3,7-4,8-1,8-2,8-3,8-4,9-1,9-2,9-3,9-4,'\
            .. '10-1,10-2,10-3,10-4,11-1,11-2,11-3,11-4,12-1,12-2,12-3,12-4,'\
            .. 'event15-1-a1,event15-1-a2,event15-1-a3,event15-1-a4,event15-2-b1,event15-2-b2',\
          ['select'] = '0',\
        },\
        {\
          ['type'] = 'Label',\
          ['text'] = '难度',\
          ['size'] = 15,\
          ['align'] = 'left',\
          ['color'] = '0,0,0',\
        },\
        {\
          ['id'] = 'battleMode',\
          ['type'] = 'RadioGroup',\
          ['list'] = '普通,困难',\
          ['select'] = '0',\
        },\
        {\
          ['type'] = 'Label',\
          ['text'] = '自动(可以自动的关卡看最底下)',\
          ['size'] = 15,\
          ['align'] = 'left',\
          ['color'] = '0,0,0',\
        },\
        {\
          ['id'] = 'battleAssistantMode',\
          ['type'] = 'RadioGroup',\
          ['list'] = '手动过地图,自动过地图',\
          ['select'] = '0',\
        },\
        {\
          ['type'] = 'Label',\
          ['text'] = '1.7.19版本后选择舰队变很复杂，因此取消选择舰队功能。请使用默认的1、2舰队出击。这里的设置仅用于确定走地图时的boss舰队和道中舰队',\
          ['size'] = 15,\
          ['align'] = 'left',\
          ['color'] = '0,0,0',\
        },\
        {\
          ['type'] = 'Label',\
          ['text'] = 'boss舰队',\
          ['size'] = 15,\
          ['align'] = 'left',\
          ['color'] = '0,0,0',\
        },\
        {\
          ['id'] = 'battleFleetBoss',\
          ['type'] = 'RadioGroup',\
          --          ['list'] = '1队,2队,3队,4队',\
          ['list'] = '1队,2队',\
          ['select'] = '0',\
        },\
        {\
          ['type'] = 'Label',\
          ['text'] = '道中舰队',\
          ['size'] = 15,\
          ['align'] = 'left',\
          ['color'] = '0,0,0',\
        },\
        {\
          ['id'] = 'battleFleetOnWay',\
          ['type'] = 'RadioGroup',\
          --          ['list'] = '无,1队,2队,3队,4队',\
          ['list'] = '无,1队,2队',\
          ['select'] = '0',\
        },\
        {\
          ['type'] = 'Label',\
          ['text'] = '回避',\
          ['size'] = 15,\
          ['align'] = 'left',\
          ['color'] = '0,0,0',\
        },\
        {\
          ['id'] = 'battleRoundabout',\
          ['type'] = 'RadioGroup',\
          ['list'] = '是,否',\
          ['select'] = '0',\
        },\
        {\
          ['type'] = 'Label',\
          ['text'] = '行动方式',\
          ['size'] = 15,\
          ['align'] = 'left',\
          ['color'] = '0,0,0',\
        },\
        {\
          ['id'] = 'mapsType',\
          ['type'] = 'RadioGroup',\
          ['list'] = '打boss,打全图,无限伏击',\
          ['select'] = '0',\
        },\
        {\
          ['type'] = 'Label',\
          ['text'] = '不能出征则震动提示',\
          ['size'] = 15,\
          ['align'] = 'left',\
          ['color'] = '0,0,0',\
        },\
        {\
          ['id'] = 'battleAlertWhenNoHp',\
          ['type'] = 'RadioGroup',\
          ['list'] = '是,否',\
          ['select'] = '0',\
        },\
        {\
          ['type'] = 'Label',\
          ['text'] = '手动过图时震动提示',\
          ['size'] = 15,\
          ['align'] = 'left',\
          ['color'] = '0,0,0',\
        },\
        {\
          ['id'] = 'battleAlertWhenManual',\
          ['type'] = 'RadioGroup',\
          ['list'] = '是,否',\
          ['select'] = '0',\
        },\
        {\
          ['type'] = 'Label',\
          ['text'] = '限制移动步长',\
          ['size'] = 15,\
          ['align'] = 'left',\
          ['color'] = '0,0,0',\
        },\
        {\
          ['id'] = 'battleStepLength',\
          ['type'] = 'RadioGroup',\
          ['list'] = '不限制,1,2,3,4,5,6,7,8',\
          ['select'] = '0',\
        },\
        {\
          ['type'] = 'Label',\
          ['text'] = '阵型',\
          ['size'] = 15,\
          ['align'] = 'left',\
          ['color'] = '0,0,0',\
        },\
        {\
          ['id'] = 'battleFormation',\
          ['type'] = 'RadioGroup',\
          ['list'] = '单纵,复纵,轮型',\
          ['select'] = '1',\
        },\
        {\
          ['type'] = 'Label',\
          ['text'] = '可以自动过的关卡',\
          ['size'] = 15,\
          ['align'] = 'left',\
          ['color'] = '0,0,0',\
        },\
        {\
          ['type'] = 'Label',\
          ['text'] = ' 1-1, 1-2, 1-3, 1-4, \\n'\
            .. '2-1, 2-2, 2-3, 2-4, \\n'\
            .. '3-1, 3-2, 3-3, 3-4, \\n'\
            .. '4-1, 4-2, 4-3, 4-4, \\n'\
            .. '5-1, 5-2, 5-3, 5-4, \\n'\
            .. '6-1, 6-2, 6-3, 6-4, \\n'\
            .. '7-1, 7-2, 7-3, 7-4, \\n'\
            .. '8-1, 8-2, 8-3, 8-4, \\n'\
            .. '9-1, 9-2, 9-3, 9-4, \\n'\
            .. '10-1, 10-2, 10-3, 10-4, \\n'\
            .. '11-1,11-2, 11-3,11-4, \\n'\
            .. '12-1, 12-2, 12-3, 12-4, \\n',\
          ['align'] = 'left',\
          ['color'] = '0,0,0',\
        },\
        {\
          ['type'] = 'Label',\
          ['text'] = ' \\n \\n \\n \\n \\n \\n \\n \\n \\n \\n',\
          ['size'] = 50,\
          ['align'] = 'left',\
          ['color'] = '0,0,0',\
        },\
      },\
    }\
  }\
\
  local settingTableStr = json.encode(settingTable);\
  local ret, settings = showUI(settingTableStr);\
  -- --转换settings结果\
  function transStrToTable(str)\
    local list = {}\
    local strArr = {}\
    if (type(str) == 'string') then\
      strArr = strSplit(str, ',')\
    elseif (type(str) == 'table') then\
      strArr = str\
    end\
    for i, v in ipairs(strArr) do\
      list['' .. (i - 1)] = v\
    end\
    return list\
  end\
\
  if settings then\
    -- 出征\
    settings.battleEnable = (function(battleEnable)\
      local list = transStrToTable({ true, false, })\
      return list[battleEnable] or false\
    end)(settings.battleEnable)\
    -- 总循环间隔时间\
    settings.missionsInterval = tonumber(settings.missionsInterval) or 0\
    -- 多长时间界面不变则重启，最少60秒\
    settings.restartInterval = tonumber(settings.restartInterval) or 120\
    settings.restartInterval = math.max(settings.restartInterval, 60)\
\
    -- 选择关卡\
    settings.battleChapter = (function(battleChapter)\
      local list = transStrToTable({\
        '0',\
        '1-1', '1-2', '1-3', '1-4',\
        '2-1', '2-2', '2-3', '2-4',\
        '3-1', '3-2', '3-3', '3-4',\
        '4-1', '4-2', '4-3', '4-4',\
        '5-1', '5-2', '5-3', '5-4',\
        '6-1', '6-2', '6-3', '6-4',\
        '7-1', '7-2', '7-3', '7-4',\
        '8-1', '8-2', '8-3', '8-4',\
        '9-1', '9-2', '9-3', '9-4',\
        '10-1', '10-2', '10-3', '10-4',\
        '11-1', '11-2', '11-3', '11-4',\
        '12-1', '12-2', '12-3', '12-4',\
        --      'event4-1-sp1', 'event4-1-sp2', 'event4-1-sp3',\
        --      'event5-1-a1', 'event5-1-a2', 'event5-1-a3',\
        --      'event5-2-b1', 'event5-2-b2', 'event5-2-b3',\
        --      'event6-1-sp1', 'event6-1-sp2', 'event6-1-sp3',\
        --      'event7-1-c1',\
        --      'event8-1-sp1', 'event8-1-sp2', 'event8-1-sp3',\
        --      'event9-1-sp1', 'event9-1-sp2', 'event9-1-sp3', 'event9-1-sp4',\
        --      'event12-1-sp1', 'event12-1-sp2', 'event12-1-sp3',\
        --      'event11-1-b1', 'event11-1-b2', 'event11-1-b3',\
        --      'event12-1-sp1', 'event12-1-sp2', 'event12-1-sp3',\
        --      'event13-1-sp1', 'event13-1-sp2', 'event13-1-sp3',\
        'event15-1-a1', 'event15-1-a2', 'event15-1-a3', 'event15-1-a4',\
        'event15-2-b1', 'event15-2-b2',\
      })\
      return list[battleChapter] or '0'\
    end)(settings.battleChapter)\
    -- 选择模式\
    settings.battleMode = (function(battleMode)\
      local list = transStrToTable({\
        'normal', 'hard',\
      })\
      return list[battleMode] or 'normal'\
    end)(settings.battleMode)\
    -- 选择辅助模式\
    settings.battleAssistantMode = (function(battleAssistantMode)\
      local list = transStrToTable({\
        'manual', 'auto',\
      })\
      return list[battleAssistantMode] or 'manual'\
    end)(settings.battleAssistantMode)\
    -- 选择Boss舰队\
    settings.battleFleet = {}\
    settings.battleFleetBoss = (function(battleFleetBoss)\
      local list = transStrToTable({ 1, 2, 3, 4 })\
      return list[battleFleetBoss] or 1\
    end)(settings.battleFleetBoss)\
    settings.battleFleet = { settings.battleFleetBoss }\
    -- 选择道中舰队\
    settings.battleFleetOnWay = (function(battleFleetOnWay)\
      local list = transStrToTable({ 0, 1, 2, 3, 4 })\
      local result = list[battleFleetOnWay] or 0\
      if settings.battleFleetBoss == result then\
        result = 0\
      end\
      return result\
    end)(settings.battleFleetOnWay)\
    if settings.battleFleetOnWay > 0 then\
      settings.battleFleet = { settings.battleFleetBoss, settings.battleFleetOnWay }\
    end\
    -- 迂回战术\
    settings.battleRoundabout = (function(battleRoundabout)\
      local list = transStrToTable({ true, false, })\
      return list[battleRoundabout] or false\
    end)(settings.battleRoundabout)\
    -- 行动方式\
    settings.mapsType = (function(mapsType)\
      local list = transStrToTable({\
        'maps-type-2',\
        'maps-type-3',\
        'maps-type-4',\
      })\
      return list[mapsType] or 'maps-type-2'\
    end)(settings.mapsType)\
    -- 当无法出征时是否跳过出征\
    settings.battleAlertWhenNoHp = (function(battleAlertWhenNoHp)\
      local list = transStrToTable({ true, false, })\
      return list[battleAlertWhenNoHp] or false\
    end)(settings.battleAlertWhenNoHp)\
    -- 手动过图时震动提示\
    settings.battleAlertWhenManual = (function(battleAlertWhenManual)\
      local list = transStrToTable({ true, false, })\
      return list[battleAlertWhenManual] or false\
    end)(settings.battleAlertWhenManual)\
    -- 限制步长\
    settings.battleStepLength = (function(battleStepLength)\
      local list = transStrToTable({ 0, 1, 2, 3, 4, 5, 6, 7, 8 })\
      return list[battleStepLength] or false\
    end)(settings.battleStepLength)\
    -- 阵型\
    settings.battleFormation = (function(battleFormation)\
      local list = transStrToTable({ 1, 2, 3, 4, 5 })\
      return list[battleFormation] or 2\
    end)(settings.battleFormation)\
  end\
\
  return ret, settings\
end\
" }


package.sourceCode = package.sourceCode or {}
package.sourceCode["./lib/co.lua"] = { path = "./lib/co.lua", name = "./lib/co.lua", source = "-----------------------------------------------------------------------------\
-- ES6 co lib in lua 5.1\
-- Author: fgfg163@163.com\
-- Copyright (c) 2015.11\
--\
-- This is a lib porting from Co v4 in JavaScript\
-- It has some different before.\
-- to see https://github.com/tj/co\
-- Useage:\
-- co(coroutine.create(function()\
-- local v1 = coroutine.yield(Promise.resolve(123))\
-- local v2 = coroutine.yield({\
-- a = Promise.resolve(234),\
-- b = Promise.resolve(456),\
-- })\
-- console.log(v1)\
-- console.log(v2)\
-- end)):catch(function(err)\
-- print(err)\
-- end)\
\
-----------------------------------------------------------------------------\
\
\
local Promise = Promise\
\
if type(Promise) ~= 'table' then\
  error('Co need Promise module to work. Please add \\'Promise\\' and require it.', 2)\
end\
\
local unpack = unpack or table.unpack\
local isArray = table.isArray or function(tab)\
  if (type(tab) ~= \"table\") then\
    return false\
  end\
  local length = #tab\
  for k, v in pairs(tab) do\
    if ((type(k) ~= \"number\") or (k > length)) then\
      return false\
    end\
  end\
  return true\
end\
function tryCatch(cb)\
  return xpcall(cb, function(e)\
    return setStackTraceback and\
      (e .. '\\n' .. debug.traceback())\
      or (e)\
  end)\
end\
\
----------------------------------------------------------------------\
function new(gen, ...)\
  return Promise.new(function(resolve, reject)\
    if (type(gen) == 'function') then gen = coroutine.create(gen) end\
    if (type(gen) ~= 'thread') then return resolve(gen) end\
\
    local onResolved, onRejected, next\
\
    onResolved = function(res)\
      local done, ret\
      local coStatus = true\
      local xpcallRes, xpcallErr = tryCatch(function()\
        coStatus, ret = coroutine.resume(gen, res)\
      end)\
      if (not xpcallRes) then\
        return reject(xpcallErr)\
      end\
      if (not coStatus) then\
        return reject(ret)\
      end\
      done = (coroutine.status(gen) == 'dead')\
      next(done, ret)\
    end\
\
    onRejected = function(err)\
      local done, ret\
      local coStatus = true\
      local xpcallRes, xpcallErr = tryCatch(function()\
        coStatus, ret = coroutine.resume(gen, error(tostring(err)))\
      end)\
      if (not xpcallRes) then\
        return reject(xpcallErr)\
      end\
      if (not coStatus) then\
        return reject(xpcallErr)\
      end\
      done = (coroutine.status(gen) == 'dead')\
      next(done, ret)\
    end\
\
    next = function(done, ret)\
      if (done) then\
        return resolve(ret)\
      end\
      local value = toPromise(ret)\
      if (value and (isPromise(value))) then\
        return value.andThen(onResolved, onRejected)\
      end\
      return onResolved(value)\
      --       onRejected(error('You may only yield a function, promise, generator, array, or object, '\
      --          .. 'but the following object was passed: \"' .. type(ret) .. '\"'))\
    end\
\
    onResolved();\
  end)\
end\
\
\
-- Convert a `yield`ed value into a promise.\
--\
-- @param {Mixed} obj\
-- @return {Promise}\
-- @api private\
function toPromise(obj)\
  if (not obj) then return obj end\
\
  if (isPromise(obj)) then return obj end\
  if (isCoroutine(obj)) then return new(obj) end\
  if (type(obj) == 'function') then return thunkToPromise(obj) end\
\
  if (isArray(obj)) then\
    return arrayToPromise(obj)\
  elseif (type(obj) == 'table') then\
    return objectToPromise(obj)\
  end\
\
  return obj\
end\
\
-- Check if `obj` is a promise.\
--\
-- @param {Object} obj\
-- @return {Boolean}\
-- @api private\
function isPromise(obj)\
  if ((type(obj) == 'table') and (type(obj.andThen) == 'function')) then\
    return true\
  end\
  return false\
end\
\
-- Check if `obj` is a generator.\
--\
-- @param {Mixed} obj\
-- @return {Boolean}\
-- @api private\
function isCoroutine(obj)\
  if (type(obj) == 'thread') then\
    return true\
  end\
  return false\
end\
\
\
-- Convert a thunk to a promise.\
--\
-- @param {Function}\
-- @return {Promise}\
-- @api private\
function thunkToPromise(fn)\
  return Promise.new(function(resolve, reject)\
    fn(function(err, res)\
      if (err) then return reject(err) end\
      if (#res > 2) then\
        res = { res[2] }\
      end\
      resolve(res)\
    end)\
  end)\
end\
\
-- Convert an array of \"yieldables\" to a promise.\
-- Uses `Promise.all()` internally.\
--\
-- @param {Array} obj\
-- @return {Promise}\
-- @api private\
function arrayToPromise(obj)\
  local newArr = {}\
  for k, v in ipairs(obj) do\
    table.insert(newArr, toPromise(v))\
  end\
  return Promise.all(newArr);\
end\
\
-- Convert an object of \"yieldables\" to a promise.\
-- Uses `Promise.all()` internally.\
--\
-- @param {Object} obj\
-- @return {Promise}\
-- @api private\
function objectToPromise(obj)\
  local results = {}\
  local promises = {}\
\
  local function defer(promise, key)\
    results[key] = nil\
    table.insert(promises, promise.andThen(function(res)\
      results[key] = res\
    end))\
  end\
\
  for key, value in pairs(obj) do\
    local promise = toPromise(value)\
    if (promise and isPromise(promise)) then\
      defer(promise, key)\
    else\
      results[key] = obj[key]\
    end\
  end\
\
  return Promise.all(promises).andThen(function()\
    return results\
  end)\
end\
\
\
\
return setmetatable({\
  new = new,\
  Promise = Promise,\
}, {\
  __call = function(_, ...)\
    return new(...)\
  end\
})\
" }


package.sourceCode = package.sourceCode or {}
package.sourceCode["./lib/promise.lua"] = { path = "./lib/promise.lua", name = "./lib/promise.lua", source = "--------------------------------------------------------------------------------------\
-- es2015 Promise for lua 5.1 and 5.2\
\
--------------------------------------------------------------------------------------\
local PENDING = 0\
local RESOLVED = 1\
local REJECTED = 2\
\
-- 是否需要显示stack traceback里的错误信息\
-- stack traceback错误信息很长，所以这个功能作为可选项\
local stackTraceback = false\
-- 封装了xpcall方法\
function tryCatch(cb)\
  return xpcall(cb, function(e)\
    return stackTraceback and\
      (e .. '\\n' .. debug.traceback())\
      or (e)\
  end)\
end\
\
-- 绑定self到某个方法\
function bindSelf(fn, self)\
  return function(...)\
    return fn(self, ...)\
  end\
end\
\
-- 隔离函数，为了防止回调过多导致爆栈需要隔离回调操作\
function asap(callback)\
  local co = coroutine.wrap(callback)\
  co()\
end\
\
-- 类\
local Promise = {\
  setStackTraceback = function(value)\
    stackTraceback = value\
  end\
}\
\
-- 类方法 （静态方法）\
function Promise.new(resolver)\
  if (type(resolver) ~= 'function') then\
    error('Promise resolver ' .. type(resolver) .. ' is not a function')\
  end\
\
  local newPromise = {\
    PromiseStatus = PENDING,\
    PromiseValue = nil,\
    deferreds = {},\
  }\
  -- promise的主要方法，这么写是为了绑定self\
  newPromise.andThen = bindSelf(andThen, newPromise)\
  newPromise.catch = bindSelf(catch, newPromise)\
\
  -- 执行传入promise的方法\
  resolver(bindSelf(resolve, newPromise), bindSelf(reject, newPromise))\
\
  return newPromise\
end\
\
function Promise.isPromise(obj)\
  return (type(obj) == 'table') and type(obj.andThen) == 'function'\
end\
\
--- - Promise.resolve方法相当于实例化一个Promise对象，状态变为RESOLVED\
function Promise.resolve(value)\
  if (Promise.isPromise(value)) then return value end\
  return Promise.new(function(resolve, reject)\
    resolve(value)\
  end)\
end\
\
--- - Promise.reject方法相当于实例化一个Promise对象，状态变为REJECTED\
function Promise.reject(value)\
  return Promise.new(function(resolve, reject)\
    reject(value)\
  end)\
end\
\
function Promise.all(args)\
  if (type(args) ~= 'table') then args = {} end\
  return Promise.new(function(resolve, reject)\
    if (#args == 0) then return resolve({}) end\
    local remaining = #args\
    local function getRes(k, value)\
      if (Promise.isPromise(value)) then\
        value.andThen(function(res)\
          getRes(k, res)\
        end, function(err)\
          reject(err)\
        end)\
        return\
      end\
\
      args[k] = value\
      remaining = remaining - 1\
      if (remaining == 0) then\
        resolve(args)\
      end\
    end\
\
    for k = 1, #args do\
      getRes(k, args[k])\
    end\
  end)\
end\
\
function Promise.race(args)\
  if (type(args) ~= 'table') then args = {} end\
  return Promise.new(function(resolve, reject)\
    for k = 1, #args do\
      local value = args[k]\
      Promise.resolve(value).andThen(resolve, reject)\
    end\
  end)\
end\
\
-- 对象方法\
function resolve(self, value)\
  local xpcallRes, xpcallErr = tryCatch(function()\
    if (Promise.isPromise(value)) then\
      doResolve(self, value.andThen, resolve, reject)\
      return\
    end\
    self.PromiseStatus = RESOLVED\
    self.PromiseValue = value\
    finale(self)\
  end)\
  if (not xpcallRes) then\
    reject(self, xpcallErr)\
  end\
end\
\
function reject(self, value)\
  value = value or ''\
  self.PromiseStatus = REJECTED\
  self.PromiseValue = value\
  if (stackTraceback and (not string.find(value, '\\n'))) then\
    self.PromiseValue = value .. '\\n' .. debug.traceback()\
  end\
  finale(self)\
end\
\
function Handler(onResolved, onRejected, resolve, reject)\
  return {\
    -- 当前promise的状态转换事件处理函数\
    onResolved = type(onResolved) == 'function' and onResolved or nil,\
    -- 当前promise的状态转换事件处理函数\
    onRejected = type(onRejected) == 'function' and onRejected or nil,\
    resolve = resolve,\
    reject = reject,\
  }\
end\
\
-- promise的主要方法。由于lua中then是关键字，所以用andThen取代\
function andThen(self, onResolved, onRejected)\
  -- then本身也会返回一个promise，实现promise链\
  return Promise.new(function(resolve, reject)\
    local deferred = Handler(onResolved, onRejected, resolve, reject)\
    handle(self, deferred)\
  end)\
end\
\
\
function handle(self, deferred)\
  if (self.PromiseStatus == PENDING) then\
    table.insert(self.deferreds, deferred)\
    return\
  end\
\
  asap(function()\
    local cb\
    if (self.PromiseStatus == RESOLVED) then\
      cb = deferred.onResolved\
    else\
      cb = deferred.onRejected\
    end\
    if (type(cb) == 'nil') then\
      if (self.PromiseStatus == RESOLVED) then\
        deferred.resolve(self.PromiseValue)\
      else\
        deferred.reject(self.PromiseValue)\
      end\
      return\
    end\
\
    local ret\
    local xpcallRes, xpcallErr = tryCatch(function()\
      -- 执行当前promise的状态转换事件处理函数\
      ret = cb(self.PromiseValue)\
    end)\
    if (not xpcallRes) then\
      -- 修改promise链表中下一个promise对象的状态为rejected\
      deferred.reject(xpcallErr)\
      return\
    end\
    -- 修改promise链表中下一个promise对象的状态为resolved\
    deferred.resolve(ret)\
  end)\
end\
\
-- 对状态转换事件处理函数进行封装后，再传给执行函数\
function doResolve(self, andThenFn, onResolved, onRejected)\
  -- done作为开关以防止fn内同时调用resolve和reject方法\
  local done = false\
  local xpcallRes, xpcallErr = tryCatch(function()\
    andThenFn(function(value)\
      if (done) then return end\
      done = true\
      onResolved(self, value)\
    end, function(value)\
      if (done) then return end\
      done = true\
      onRejected(self, value)\
    end)\
  end)\
  if (not xpcallRes) then\
    if (done) then return end\
    done = true\
    onRejected(self, xpcallErr)\
  end\
end\
\
-- 移动到链表的下一个promise\
function finale(self)\
  local theDef = self.deferreds\
  for k = 1, #theDef do\
    handle(self, theDef[k]);\
  end\
  self.deferreds = {};\
  if self.PromiseStatus == REJECTED and #theDef == 0 then\
    local errStr = 'Uncatch error in Promise '\
    local resErr = tostring(self.PromiseValue)\
    error(errStr .. '\\n' .. resErr .. '\\n')\
  end\
end\
\
-- promise的主要方法\
function catch(self, onRejected)\
  -- then本身也会返回一个promise，实现promise链\
  self.andThen(nil, onRejected)\
end\
\
return Promise\
" }


package.sourceCode = package.sourceCode or {}
package.sourceCode["./lib/event-query.lua"] = { path = "./lib/event-query.lua", name = "./lib/event-query.lua", source = "local socket = require 'socket'\
\
-- get the time\
local gettimeFunc = function()\
  return socket.gettime() * 1000\
end\
-- sleep\
local mSleep = mSleep or function(n)\
  socket.select(nil, nil, n / 1000)\
end\
\
-- fwGetPressedButton\
-- keepScreen(true);\
\
local function isEmpty(tab)\
  for _, v in pairs(tab) do\
    return false\
  end\
  return true\
end\
\
\
\
\
\
\
\
local function tryCatch(cb)\
  return xpcall(cb, function(e)\
    return stackTraceback and\
      (e .. '\\n' .. debug.traceback())\
      or (e)\
  end)\
end\
\
local function bindSelf(func, self)\
  return function(...) return func(self, ...) end\
end\
\
local getEventId = (function()\
  local id = 0\
  return function()\
    id = id + 1\
    return id\
  end\
end)()\
\
-- main query\
local eventQuery = {}\
-- sub query\
local screenListenerQuery = {}\
local screenListenerQueryIndex = {}\
local buttonListenerQuery = {}\
local buttonListenerQueryIndex = {}\
local timerQuery = {}\
local timerQueryIndex = {}\
\
\
function getEventObj(func, time, isInterval, ms)\
  return {\
    id = getEventId() or 0,\
    time = time or 0,\
    func = func,\
    isInterval = isInterval or false,\
    ms = ms or 0,\
    drop = false,\
  }\
end\
\
function getScreenEventObj(checker, func)\
  return {\
    id = getEventId() or 0,\
    checker = checker,\
    func = func,\
    drop = false,\
  }\
end\
\
function getButtonEventObj(btnId, func)\
  return {\
    id = getEventId() or 0,\
    btnId = btnId,\
    func = func,\
    drop = false,\
  }\
end\
\
\
\
\
function setImmediate(func)\
  if (type(func) ~= 'function') then return 0 end\
  local eventObj = getEventObj(func)\
  table.insert(timerQuery, eventObj)\
  return eventObj.id\
end\
\
function setTimeout(func, ms)\
  if (type(func) ~= 'function') then return 0 end\
  if ((type(ms) ~= 'number') or (ms < 4)) then ms = 4 end\
  local time = gettimeFunc() + ms\
  local eventObj = getEventObj(func, time)\
  table.insert(timerQuery, eventObj)\
  timerQueryIndex[eventObj.id] = eventObj\
  return eventObj.id\
end\
\
function clearTimeout(id)\
  local theEventObj = timerQueryIndex[id]\
  if (theEventObj) then\
    theEventObj.drop = true\
    timerQueryIndex[id] = nil\
  end\
end\
\
function setInterval(func, ms)\
  if (type(func) ~= 'function') then return 0 end\
  if ((type(ms) ~= 'number') or (ms < 4)) then ms = 4 end\
  local time = gettimeFunc() + ms\
  local eventObj = getEventObj(func, time, true, ms)\
  table.insert(timerQuery, eventObj)\
  timerQueryIndex[eventObj.id] = eventObj\
  return eventObj.id\
end\
\
-- param: checker, func\
function setScreenListener(...)\
  local args = { ... }\
  local checker = table.remove(args, 1)\
  local func = table.remove(args, 1)\
\
  if (type(checker) ~= 'function') then return 0 end\
  if (type(func) ~= 'function') then return 0 end\
  local screenEventObj = getScreenEventObj(checker, func)\
  table.insert(screenListenerQuery, screenEventObj)\
  screenListenerQueryIndex[screenEventObj.id] = screenEventObj\
  return screenEventObj.id\
end\
\
function clearScreenListener(id)\
  local theEventObj = screenListenerQueryIndex[id]\
  if (theEventObj) then\
    theEventObj.drop = true\
  end\
end\
\
function setButotnListener(btnId, func)\
  if (type(func) ~= 'function') then return 0 end\
  local btnEventObj = getButtonEventObj(btnId, func)\
  table.insert(buttonListenerQuery, btnEventObj)\
  buttonListenerQueryIndex[btnEventObj.id] = btnEventObj\
  return btnEventObj.id\
end\
\
function clearButotnListener(id)\
  local theEventObj = buttonListenerQueryIndex[id]\
  if (theEventObj) then\
    theEventObj.drop = true\
  end\
end\
\
function clearListenersOnButton(btnId)\
  for key = 1, #buttonListenerQuery do\
    local value = buttonListenerQuery[key]\
    if (value.btnId ~= btnId) then\
      value.drop = true\
    end\
  end\
end\
\
function run()\
  local continue = 0\
  local thisTime = 0\
  local sleepTime = 3600000\
\
\
  repeat\
    continue = 0\
    sleepTime = 3600000\
\
    -- run eventQuery\
    if #eventQuery > 0 then\
      for key = 1, #eventQuery do\
        local value = eventQuery[key]\
        value.func()\
      end\
      eventQuery = {}\
    end\
\
\
    -- read event from other Query\
    thisTime = gettimeFunc()\
\
    -- timeQuery\
    if (#timerQuery > 0) then\
      continue = continue + 1\
      local hasDropEvent = false\
      for key = 1, #timerQuery do\
        local value = timerQuery[key]\
        if (not value.drop) then\
          if (value.time <= thisTime) then\
            table.insert(eventQuery, value)\
\
            -- setInterval event\
            if (value.isInterval) then\
              value.drop = false\
              repeat\
                value.time = value.time + value.ms\
              until (value.time > thisTime)\
              sleepTime = math.min(sleepTime, value.time - thisTime)\
            else\
              value.drop = true\
              hasDropEvent = true\
            end\
          else\
            sleepTime = math.min(sleepTime, value.time - thisTime)\
          end\
        else\
          hasDropEvent = true\
          timerQueryIndex[value.id] = nil\
        end\
      end\
\
      if hasDropEvent then\
        local newTimeQuery = {}\
        for key = 1, #timerQuery do\
          local value = timerQuery[key]\
          if not value.drop then\
            table.insert(newTimeQuery, value)\
          else\
            timerQueryIndex[value.id] = nil\
          end\
        end\
        timerQuery = newTimeQuery\
      end\
    end\
\
    -- screenListenerQuery\
    if #screenListenerQuery > 0 then\
      keepScreen(false);\
      if type(getDeviceOrient) == 'function' then getDeviceOrient() end\
      local hasDropEvent = false\
      continue = continue + 1\
      sleepTime = math.min(sleepTime, 200)\
      getColor(0, 0)\
      keepScreen(true);\
      for key = 1, #screenListenerQuery do\
        local value = screenListenerQuery[key]\
        if not value.drop then\
          if (value.checker()) then\
            table.insert(eventQuery, value)\
            if (value.isOnce) then\
              value.drop = true\
              hasDropEvent = true\
            end\
          end\
        else\
          hasDropEvent = true\
        end\
      end\
      keepScreen(false);\
\
      if (hasDropEvent) then\
        local newScreenListenerQuery = {}\
        for key = 1, #screenListenerQuery do\
          local value = screenListenerQuery[key]\
          if (not value.drop) then\
            table.insert(newScreenListenerQuery, value)\
          else\
            screenListenerQueryIndex[value.id] = nil\
          end\
        end\
        screenListenerQuery = newScreenListenerQuery\
      end\
    end\
\
    -- buttonListenerQuery\
    if (#buttonListenerQuery > 0) then\
      sleepTime = math.min(sleepTime, 200)\
      continue = continue + 1\
      local btnIdList = {}\
      local hasBtnClick = false\
      local hasDropEvent = false\
      while (true) do\
        local btnId = fwGetPressedButton()\
        if (type(btnId) ~= 'string') then break end\
        btnIdList[btnId] = btnId\
        hasBtnClick = true\
      end\
      if (hasBtnClick) then\
        for key = 1, #buttonListenerQuery do\
          local value = buttonListenerQuery[key]\
          if (not value.drop) then\
            if (btnIdList[value.btnId] == value.btnId) then\
              table.insert(eventQuery, value)\
            end\
          else\
            hasDropEvent = true\
          end\
        end\
\
        if (hasDropEvent) then\
          local newButtonListenerQuery = {}\
          for key = 1, #buttonListenerQuery do\
            local value = buttonListenerQuery[key]\
            if (not value.drop) then\
              table.insert(newButtonListenerQuery, value)\
            else\
              buttonListenerQueryIndex[value.id] = nil\
            end\
          end\
          buttonListenerQuery = newButtonListenerQuery\
        end\
      end\
    end\
\
    if (luaExisted) then\
      break\
    end\
    if (#eventQuery <= 0) then\
      mSleep(sleepTime)\
    end\
  until (false)\
end\
\
return {\
  setImmediate = setImmediate,\
  setTimeout = setTimeout,\
  clearTimeout = clearTimeout,\
  setInterval = setInterval,\
  clearInterval = clearTimeout,\
  setScreenListener = setScreenListener,\
  clearScreenListener = clearScreenListener,\
  setButotnListener = setButotnListener,\
  clearListenersOnButton = clearListenersOnButton,\
  clearButotnListener = clearButotnListener,\
  run = run,\
}" }


package.sourceCode = package.sourceCode or {}
package.sourceCode["./utils/clear-log.lua"] = { path = "./utils/clear-log.lua", name = "./utils/clear-log.lua", source = "-- 删除大于7天并且大于50条的log，避免日志过大\
local lfs = require '../lib/lfs'\
local logPath = userPath() .. '/log'\
local dirs = lfs.dir(logPath)\
local sevenDayBeforeTime = os.time() - (7 * 24 * 60 * 60)\
local theTime = os.time()\
\
local dirsLen = #dirs\
\
dirs = table.filter(dirs, function(e, index)\
  if (string.startWith(e, 'azur_lane_')) then\
    local res = string.match(e, 'azur_lane_(%d+)')\
    res = tonumber(res) or theTime\
    if ((index < (dirsLen - 50)) and (res < sevenDayBeforeTime)) then\
      return true\
    end\
  end\
  return false\
end)\
\
for k, v in ipairs(dirs) do\
  lfs.rm(logPath .. '/' .. v)\
end\
" }


package.sourceCode = package.sourceCode or {}
package.sourceCode["./utils/device-orient-hock.lua"] = { path = "./utils/device-orient-hock.lua", name = "./utils/device-orient-hock.lua", source = "local __init = init\
\
-- 0=竖屏，1=右旋（home键在右边），2=左旋（home键在左边），3=倒立\
__init(0)\
local w, h = getScreenSize()\
local m = math.max(w, h)\
local sideLength = math.min(w, h)\
local orient = 0;\
local nextUpdateTime = 0\
\
-- 计算方向辅助界面，一像素宽度的白色边界，一像素宽的黑色边界，用于检测方向\
fwShowWnd(\"orientwid1\", 0, 0, 2, m, 0)\
fwShowTextView(\"orientwid1\", \"text1\", \"\", \"center\", \"000000\", \"FEFEFE\", 15, 0, 0, 0, 1, m, 1)\
fwShowTextView(\"orientwid1\", \"text2\", \"\", \"center\", \"000000\", \"010101\", 15, 0, 1, 0, 2, m, 1)\
mSleep(100)\
\
-- 计算当前方向\
function calOrient(_orient)\
  local result = _orient\
  -- 寻找白色边界\
  __init(_orient)\
\
  local checkOrder = { 0, 1, 2 }\
  if (_orient == 0) then\
    checkOrder = { 1, 2 }\
  elseif (_orient == 1) then\
    checkOrder = { 0, 2 }\
  elseif (_orient == 2) then\
    checkOrder = { 0, 1 }\
  end\
\
  local checkPointList = {\
    { 0, math.floor(0.333 * sideLength), 0xfefefe },\
    { 0, math.floor(0.5 * sideLength), 0xfefefe },\
    { 0, math.floor(0.667 * sideLength), 0xfefefe },\
    { 0, math.floor(0.833 * sideLength), 0xfefefe },\
    { 1, math.floor(0.333 * sideLength), 0x010101 },\
    { 1, math.floor(0.5 * sideLength), 0x010101 },\
    { 1, math.floor(0.667 * sideLength), 0x010101 },\
    { 1, math.floor(0.833 * sideLength), 0x010101 },\
  }\
\
  -- 如果方向没变则不旋转\
  if (multiColorS(checkPointList)) then\
    return _orient\
  end\
  -- 如果方向变了则旋转\
  for k, v in ipairs(checkOrder) do\
    __init(v)\
    if (multiColorS(checkPointList)) then\
      return v\
    end\
  end\
  __init(_orient)\
  return _orient\
end\
\
local _orient = calOrient(orient)\
orient = _orient\
\
-- 获取当前方向\
getDeviceOrient = function()\
  local newOrient = orient\
  if (os.time() > nextUpdateTime) then\
    local _keepScreenState = keepScreenState\
    keepScreen(true)\
    newOrient = calOrient(orient)\
    nextUpdateTime = os.time() + 1\
    keepScreen(false)\
  end\
  return newOrient\
end\
\
\
-- 设置当前方向，当然只能设置init的方向\
setDeviceOrient = function(n)\
  orient = n\
  __init(n)\
  nextUpdateTime = os.time() + 1\
end\
init = setDeviceOrient\
" }


package.sourceCode = package.sourceCode or {}
package.sourceCode["./utils/multi-color-hock.lua"] = { path = "./utils/multi-color-hock.lua", name = "./utils/multi-color-hock.lua", source = "multiColorS = multiColorS or function(array, s)\
  s = s or 90\
\
  local __keepScreenState = keepScreenState\
  if not __keepScreenState then keepScreen(true) end\
\
  local result = true\
  for var = 1, #array do\
    local lr, lg, lb = getColorRGB(array[var][1], array[var][2])\
    local r = math.floor(array[var][3] / 0x10000)\
    local g = math.floor(array[var][3] % 0x10000 / 0x100)\
    local b = math.floor(array[var][3] % 0x100)\
    if math.abs(lr - r) > s or math.abs(lg - g) > s or math.abs(lb - b) > s then\
      result = false\
      break\
    end\
  end\
\
  if not __keepScreenState then keepScreen(false) end\
  return result\
end\
" }


package.sourceCode = package.sourceCode or {}
package.sourceCode["./utils/keep-screen-hock.lua"] = { path = "./utils/keep-screen-hock.lua", name = "./utils/keep-screen-hock.lua", source = "-- 全局函数生成，由于部分计算过程不想暴露所以用了闭包\
\
if (type(keepScreenState) == 'nil') then\
  local __tmp = (function()\
    local __keepScreen = keepScreen\
    keepScreen = nil\
    keepScreenState = false\
    keepScreen = function(...)\
      local arr = { ... }\
      keepScreenState = arr[1] or false\
      return __keepScreen(...)\
    end\
  end)()\
end\
" }


package.sourceCode = package.sourceCode or {}
package.sourceCode["./lib/table-polyfill.lua"] = { path = "./lib/table-polyfill.lua", name = "./lib/table-polyfill.lua", source = "-- table方法添加\
local myTable = {}\
do\
  for key, value in pairs(table) do\
    myTable[key] = table[key]\
  end\
end\
\
local function runTable(tab, space)\
  if (type(tab) == 'number') then\
    return { tostring(tab) }\
  end\
  if (type(tab) == 'string') then\
    return { '\"' .. tab .. '\"' }\
  end\
  if (type(tab) == 'boolean') then\
    if (tab) then\
      return { 'true' }\
    else\
      return { 'false' }\
    end\
  end\
  if (type(tab) ~= 'table') then\
    return { '(' .. type(tab) .. ')' }\
  end\
  if (type(space) == 'number') then\
    space = string.rep(' ', space)\
  end\
  if (type(space) ~= 'string') then\
    space = ''\
  end\
\
  local resultStrList = {}\
\
  local newTabPairs = {}\
  local tabIsArray = true\
  local tabLength = 0\
  local hasSubTab = false\
\
  for k = 1, #tab do\
    local v = tab[k]\
    tabLength = k\
    myTable.insert(newTabPairs, { k, runTable(v, space) })\
    if (type(v) == 'table') then\
      hasSubTab = true\
    end\
  end\
\
  for k, v in pairs(tab) do\
    if ((type(k) ~= 'number') or k > tabLength) then\
      tabIsArray = false\
      myTable.insert(newTabPairs, { k, runTable(v, space) })\
      if (type(v) == 'table') then\
        hasSubTab = true\
      end\
    end\
  end\
\
  if (tabIsArray) then\
    local newTabArr = newTabPairs\
\
    if (hasSubTab) then\
      myTable.insert(resultStrList, '[')\
      for k = 1, #newTabArr do\
        local v = newTabArr[k]\
        local v2Length = getLength(v[2])\
        v[2][v2Length] = v[2][v2Length] .. ','\
        for k2 = 1, #v[2] do\
          local v2 = v[2][k2]\
          myTable.insert(resultStrList, space .. v2)\
        end\
      end\
      myTable.insert(resultStrList, ']')\
    else\
      local theStr = {}\
      for k = 1, #newTabPairs do\
        local v = newTabPairs[k]\
        myTable.insert(theStr, v[2][1])\
      end\
      local childStr = myTable.concat(theStr, ', ')\
      myTable.insert(resultStrList, '[' .. childStr .. ']')\
    end\
  else\
    local newTabArr = newTabPairs\
\
    myTable.insert(resultStrList, '{')\
    for k = 1, #newTabArr do\
      local v = newTabArr[k]\
      v[2][1] = v[1] .. ': ' .. v[2][1]\
      local v2Length = getLength(v[2])\
      v[2][v2Length] = v[2][v2Length] .. ','\
      for k2 = 1, #v[2] do\
        local v2 = v[2][k2]\
        myTable.insert(resultStrList, space .. v2 .. '')\
      end\
    end\
    myTable.insert(resultStrList, '}')\
  end\
  return resultStrList\
end\
\
myTable.length = myTable.length or function(tab)\
  return #tab\
end\
\
myTable.isArray = myTable.isArray or function(tab)\
  if (type(tab) ~= 'table') then\
    return false\
  end\
  local length = myTable.length(tab)\
  for k, v in pairs(tab) do\
    if ((type(k) ~= 'number') or (k > length)) then\
      return false\
    end\
  end\
  return true\
end\
\
myTable.unpack = myTable.unpack or unpack\
\
myTable.slice = myTable.slice or function(tab, startIndex, endIndex)\
  local length = myTable.length(tab)\
  if ((type(endIndex) == 'nil') or (endIndex == 0)) then\
    endIndex = length\
  end\
  if (endIndex < 0) then\
    endIndex = length + 1 + endIndex\
  end\
  local newTab = {}\
\
  for i = startIndex, endIndex do\
    myTable.insert(newTab, tab[i])\
  end\
\
  return newTab\
end\
\
myTable.merge = myTable.merge or function(tab, ...)\
  local args = { ... }\
  for k = 1, #args do\
    local tabelement = args[k]\
    local length = myTable.length(tabelement)\
    for k2 = 1, #tabelement do\
      local value = tabelement[k2]\
      if ((type(k2) == 'number') and (k2 <= length)) then\
        myTable.insert(tab, value)\
      end\
    end\
    for k2 = 1, #tabelement do\
      local value = tabelement[k2]\
      if ((type(k2) == 'number') and (k2 <= length)) then\
      elseif (type(k2) == 'number') then\
        tab[tostring(k2)] = value\
      else\
        tab[k2] = value\
      end\
    end\
  end\
  return tab\
end\
\
myTable.assign = myTable.assign or function(target, ...)\
  local sources = { ... }\
  if (type(target) ~= 'table') then\
    target = {}\
  end\
  for key1 = 1, #sources do\
    local source = sources[key1]\
    for key2, value in pairs(source) do\
      target[key2] = value\
    end\
  end\
  return target\
end\
\
myTable.reverse = myTable.reverse or function(target)\
  local result = {}\
  local theLength = myTable.length(target)\
  for key = 1, #target do\
    local value = target[key]\
    result[theLength - key + 1] = value\
  end\
  return result\
end\
\
myTable.filter = myTable.filter or function(target, func)\
  local result = {}\
  local theLength = myTable.length(target)\
  for key = 1, #target do\
    local value = target[key]\
    if (func(value, key, target)) then\
      myTable.insert(result, value)\
    end\
  end\
  return result\
end\
\
myTable.unique = myTable.unique or function(target, path)\
  local theMap = {}\
  local result = {}\
  local pathType = type(path)\
  if (pathType == 'nil') then\
    for key = 1, #target do\
      local value = target[key]\
      if (type(theMap[value]) == 'nil') then\
        theMap[value] = { key = key, value = value }\
        myTable.insert(result, value)\
      end\
    end\
  elseif ((pathType == 'number') or (pathType == 'string')) then\
    for key = 1, #target do\
      local value = target[key]\
      if (type(theMap[value[path]]) == 'nil') then\
        theMap[value[path]] = { key = key, value = value }\
        myTable.insert(result, value)\
      end\
    end\
  elseif (pathType == 'function') then\
    for key = 1, #target do\
      local value = target[key]\
      if (type(theMap[path(value)]) == 'nil') then\
        theMap[path(value)] = { key = key, value = value }\
        myTable.insert(result, value)\
      end\
    end\
  end\
  return result\
end\
\
-- 后覆盖前的unique\
myTable.uniqueLast = myTable.uniqueLast or function(target, path)\
  local theMap = {}\
  local result = {}\
  local pathType = type(path)\
  local targetLength = myTable.length(target)\
  if (pathType == 'nil') then\
    for key = 1, #target do\
      local value = target[key]\
      theMap[value] = { key = key, value = value }\
    end\
    for key = 1, #target do\
      local value = target[key]\
      if (key == theMap[value].key) then\
        myTable.insert(result, value)\
      end\
    end\
  elseif ((pathType == 'number') or (pathType == 'string')) then\
    for key = 1, #target do\
      local value = target[key]\
      local res, err = pcall(function()\
        theMap[value[path]] = { key = key, value = value }\
      end)\
      if not res then\
        error(console.log(value))\
      end\
    end\
    for key = 1, #target do\
      local value = target[key]\
      if (key == theMap[value[path]].key) then\
        myTable.insert(result, value)\
      end\
    end\
  elseif (pathType == 'function') then\
    for key = 1, #target do\
      local value = target[key]\
      theMap[path(value)] = { key = key, value = value }\
    end\
    for key = 1, #target do\
      local value = target[key]\
      if (key == theMap[path(value)].key) then\
        myTable.insert(result, value)\
      end\
    end\
  end\
  return result\
end\
\
myTable.map = myTable.map or function(tab, callback)\
  local values = {}\
  for k, v in ipairs(tab) do\
    myTable.insert(values, callback(v, k, tab))\
  end\
  return values\
end\
\
myTable.values = myTable.values or function(tab)\
  local values = {}\
  for k, v in pairs(tab) do\
    myTable.insert(values, v)\
  end\
  return values\
end\
\
myTable.keys = myTable.keys or function(tab)\
  local keys = {}\
  for k in pairs(tab) do\
    myTable.insert(keys, k)\
  end\
  return keys\
end\
\
-- 对key排序后放入数组中再返回，结果类似entries\
myTable.sortByKey = myTable.sortByKey or function(tab, call)\
  local keys = myTable.keys(tab)\
  if (type(call) == 'function') then\
    myTable.sort(keys, call)\
  else\
    myTable.sort(keys)\
  end\
  local newTable = {}\
  for k = 1, #keys do\
    local key = keys[k]\
    myTable.insert(newTable, { key, tab[key] })\
  end\
  return newTable\
end\
\
myTable.findIndex = myTable.findIndex or function(tab, call)\
  local index = -1\
  if type(call) == 'function' then\
    if myTable.isArray(tab) then\
      for key = 1, #tab do\
        local value = tab[key]\
        if call(value) then\
          index = key\
        end\
      end\
    else\
      for key = 1, #tab do\
        local value = tab[key]\
        if call(value) then\
          index = key\
        end\
      end\
    end\
  else\
    if myTable.isArray(tab) then\
      for key = 1, #tab do\
        local value = tab[key]\
        if value == call then\
          index = key\
        end\
      end\
    else\
      for key = 1, #tab do\
        local value = tab[key]\
        if value == call then\
          index = key\
        end\
      end\
    end\
  end\
  return index\
end\
\
myTable.find = myTable.find or function(tab, call)\
  local result\
  if type(call) == 'function' then\
    if myTable.isArray(tab) then\
      for key = 1, #tab do\
        local value = tab[key]\
        if call(value) then\
          result = value\
        end\
      end\
    else\
      for _, value in pairs(tab) do\
        if call(value) then\
          result = value\
        end\
      end\
    end\
  else\
    if myTable.isArray(tab) then\
      for _, value in pairs(tab) do\
        if value == call then\
          result = tab[call]\
        end\
      end\
    else\
      for key = 1, #tab do\
        local value = tab[key]\
        if value == call then\
          result = tab[call]\
        end\
      end\
    end\
  end\
  return result\
end\
\
myTable.toString = myTable.toString or function(tab)\
  return myTable.concat(runTable(tab), '')\
end\
\
myTable.from = myTable.from or function(target)\
  if (type(target) ~= 'function') then\
    return target\
  end\
  local result = {}\
  for k, v in target do\
    result[k] = v\
  end\
  return result\
end\
\
myTable.toJsString = myTable.toJsString or function(tab, space)\
  space = space or '  '\
  return myTable.concat(runTable(tab, space), '\\n')\
end\
\
do\
  for key, value in pairs(myTable) do\
    table[key] = table[key] or myTable[key]\
  end\
end\
" }


package.sourceCode = package.sourceCode or {}
package.sourceCode["./lib/math-polyfill.lua"] = { path = "./lib/math-polyfill.lua", name = "./lib/math-polyfill.lua", source = "math.isNan = math.isNan or function(num)\
  if (num ~= num) then\
    return true\
  end\
  return false\
end\
\
math.isInf = math.isInf or function(num)\
  if (num == math.huge) then\
    return true\
  end\
  return false\
end\
\
math.trueNumber = math.trueNumber or function(num)\
  if (type(num) ~= 'number') then\
    return nil\
  end\
  if (math.isNan(num)) then\
    return nil\
  end\
  if (math.isInf(num)) then\
    return nil\
  end\
  return num\
end\
\
math.maxTable = math.maxTable or function(tab, path)\
  local maxNum\
  local maxTab\
  if not path then\
    return math.max(table.unpack(tab))\
  elseif type(path) == 'string' or type(path) == 'number' then\
    for key, item in pairs(tab) do\
      if not maxNum or maxNum < item[path] then\
        maxNum = item[path]\
        maxTab = item\
      end\
    end\
  elseif type(path) == 'function' then\
    for key, item in pairs(tab) do\
      local theNum = path(item, key, tab)\
      if not maxNum or maxNum < theNum then\
        maxNum = theNum\
        maxTab = item\
      end\
    end\
  end\
  return maxTab\
end\
\
math.minTable = math.minTable or function(tab, path)\
  local maxNum\
  local maxTab\
  if not path then\
    return math.max(table.unpack(tab))\
  elseif type(path) == 'string' or type(path) == 'number' then\
    for key, item in pairs(tab) do\
      if not maxNum or maxNum > item[path] then\
        maxNum = item[path]\
        maxTab = item\
      end\
    end\
  elseif type(path) == 'function' then\
    for key, item in pairs(tab) do\
      local theNum = path(item, key, tab)\
      if not maxNum or maxNum > theNum then\
        maxNum = theNum\
        maxTab = item\
      end\
    end\
  end\
  return maxTab\
end\
" }


package.sourceCode = package.sourceCode or {}
package.sourceCode["./lib/string-polyfill.lua"] = { path = "./lib/string-polyfill.lua", name = "./lib/string-polyfill.lua", source = "string.split = string.split or function(str, d)\
  if str == '' and d ~= '' then\
    return { str }\
  elseif str ~= '' and d == '' then\
    local lst = {}\
    for key = 1, string.len(str) do\
      table.insert(lst, string.sub(str, key, 1))\
    end\
    return lst\
  else\
    local lst = {}\
    local n = string.len(str) --长度\
    local start = 1\
    while start <= n do\
      local i = string.find(str, d, start) -- find 'next' 0\
      if i == nil then\
        table.insert(lst, string.sub(str, start, n))\
        break\
      end\
      table.insert(lst, string.sub(str, start, i - 1))\
      if i == n then\
        table.insert(lst, '')\
        break\
      end\
      start = i + 1\
    end\
    return lst\
  end\
end\
\
string.startWith = string.startWith or function(str, pattern)\
  if (type(str) ~= 'string') then\
    return false\
  end\
  if (type(pattern) ~= 'string') then\
    return false\
  end\
  if (string.sub(str, 1, string.len(pattern)) == pattern) then\
    return true\
  end\
  return false\
end\
\
string.endWith = string.endWith or function(str, pattern)\
  if (type(str) ~= 'string') then\
    return false\
  end\
  if (type(pattern) ~= 'string') then\
    return false\
  end\
  if (string.sub(str, 1, (0 - string.len(pattern))) == pattern) then\
    return true\
  end\
  return false\
end" }


package.preload["TSLib"] = assert(load("\27TS1R\0\1\4\4\4\8\0\25�\13\
\26\
\14\9\20 6\30�\11Fo<'Q�\30gIW.X�qqC�\2\24Ac�2V\8\9\20 �kV80\8t\25:\8t\25i\19�.hzN!b� g%��]=�vS���W��K({��5,��\\�`h$\24\9v\25\30\9v\25r�6)���b\24�At�\"]}R�\25C ��\7\1!\8\6 |a�<�\15�6\23�\5+��\5dB��\29a�3\3NBw'*��5\0\11\8\8 �7\16@R��F��Sn�pV4\18�&�\0151�\\!��7S3�\24c*�1ync�{�Y�\24Vu\17Vg\0\0\0�������\2\2�\5�B�E�B��Â����\3�\3����\3\3�C�����\0������\3\0�Ã����\1�\3����\3\1�C�����\6������\3\6�À����\7�\3����\3\7�C�\0\8\0\1�%\1\3\0\8\0��%A\3\0\8\0\1�%�\3\0\8\0��%�\3\0\8\0\1�%\1\4\0\8\0��%A\4\0\8\0\1�%�\4\0\8\0��%�\4\0\8\0\1�%\1\5\0\8\0��%A\5\0\8\0\1�%�\5\0\8\0��%�\5\0\8\0\1�%\1\6\0\8\0��%A\6\0\8\0\1�%�\6\0\8\0��%�\6\0\8\0\1�%\1\7\0\8\0��%A\7\0\8\0\1�%�\7\0\8\0��%�\7\0\8\0\1�%\1\8\0\8\0��%A\8\0\8\0\1�%�\8\0\8\0��%�\8\0\8\0\1�\6\1I\0\8\0��%\1\9\0\8\0\1�%A\9\0\8\0��%�\9\0F\1J\0J\1��e�\9\0\8@\1�e\1\
\0\8@��eA\
\0\8@\1�e�\
\0\8@��e�\
\0\8@\1�e\1\11\0\8@��eA\11\0\8@\1�e�\11\0\8@��e�\11\0\8@\1�\31\0�\0\5\7\21 u�\16\2�\30H\127!��\2��Rv�A�|sQ�E�Q'~\6\3\16I\25ﲠ\2�a�4\1\0\0\0\1\0\6\7!\25���f�Z�R\1\13�I\0�\29\14\
\16`\8�M�\127��-N3\0\0\0\4\8\0\0\0\2%\21>35=V\4\
\0\0\0009&\"\9 7:#3V\4\11\0\0\0\2\5\0003$%?98%V\4\4\0\0\0\"7&V\4\
\0\0\0$7829;\0027&V\4\11\0\0\0$7829;%\0027&V\4\7\0\0\0;9 3\0029V\4\12\0\0\0;9 3\0029!7$2%V\4\12\0\0\0;9 3\01299;\25#\"V\4\11\0\0\0;9 3\01299;\0318V\4\17\0\0\0;9 3\21?$5:3\02138\"3$V\4\17\0\0\0;9 3\21?$5:3\00698?\"%V\4\9\0\0\0?8\"\0029\00414V\4\9\0\0\0$14\0029\0318\"V\4\8\0\0\0?%\0219:9$V\4\11\0\0\0;#:\"?\0219:9$V\4\12\0\0\0;#:\"?\0219:\0027&V\4\9\0\0\0%\"$\5&:?\"V\4\12\0\0\0?%\16?:3\19.?%\"V\4\15\0\0\0$372\16?:3\5\"$?81V\4\9\0\0\0$372\16?:3V\4\
\0\0\0!$?\"3\16?:3V\4\16\0\0\0!$?\"3\16?:3\5\"$?81V\4\8\0\0\00023:\16?:3V\4\15\0\0\0%3\"\0183 ?53\23:?7%V\4\8\0\0\0:#7\19.?\"V\4\9\0\0\00013\"\0243\"\31\6V\4\4\0\0\0:91V\4\11\0\0\00013\"\23&&\0247;3V\4\11\0\0\00013\"\3%3$\23&&V\4\9\0\0\0>\"\"&\0069%\"V\4\8\0\0\0>\"\"&\0173\"V\4\9\0\0\0?8&#\"\5\"$V\4\16\0\0\0005:37$\0067%\"3497$2V\4\13\0\0\0005:37$\02199=?3%V\4\11\0\0\0005:37$\31\18\16\23\0V\4\15\0\0\0005:37$\23::\6>9\"9%V\4\12\0\0\0\0183:\23::\6>9\"9V\4\18\0\0\0005:37$\23::\0293/\21>7?8%V\4\
\0\0\00013\"\5\"$\24#;V\4\3\0\0\0\9\17V\4\
\0\0\00013\"\00482\24#;V\4\6\0\0\0\3\31\0243!V\4\12\0\0\0%87&\02382\0057 3V\4\14\0\0\000233&\0219&/\00274:3V\4\
\0\0\00013\"\0043823$V\4\6\0\0\0?%\0187/V\4\11\0\0\0005>35=\00274:3V\4#\0\0\0000?82\27#:\"?\0219:9$\0318\00431?98\16#,,/\20/\00274:3V\4\7\0\0\000839%\3\31V\4\8\0\0\00095$\031809V0\0\0\0\11\9\20 ��\22D_l\25Fm\3\9\20 4��fw�+=�ӅL\16��\20���+9��\"�o�E\8\13�;| !lM�\23'}\8t\0254\8t\25�Y{n&\25$\11�\7��mu\25\9v\25\18\9v\25���Z�>D3�\20�\11U�Y\30�5N f��0\25SZbgc�[\
�&)��\22O\0(\8\6 �b=m\0\0\8\8 \6��('Av\7S�\18|}�\
f�\20�Sc��\16�U�\17,\2�vHyV4\18�\"�b\31\0\0\0C�IH\14H\8HB\8H�\14\8\8HB\8��\14�\8HB\8H�\14�\8\0\
@��K�\0\0�\0A\0�@A\1J����\0A\0��A\1J�\0�\
@\0�K@\0\0��A\0�\0B\1J�\0�\
@��e\0\0\0�@\0\0�\0\0\11�\0\0\
���\
�\0�\
A��\31\1\0\1\31\0�\0\8\7\21 \127M�*��2^�$�!�@\0252\127��S[&�h:$�\12(��\6\1;�t��L+\5\2\16I\25h\26�%�9�\0138��\2\1\0\0\0\0\0\6\7!\25i�\\�'�}\8R�;���q���&/�cC��\0n\12\0\0\0\4\9\0\0\0\25\2\3\24\0\15\8\31m\4\5\0\0\0\25\20\29\8m\4\6\0\0\0\8\31\31\2\31m\4\7\0\0\0\30\8\1\8\14\25m\4\7\0\0\0\30\25\31\4\3\
m\4\7\0\0\0\11\2\31\0\12\25m\4\5\0\0\0\11\4\3\9m\4\6\0\0\0\9\8\15\24\
m\4\8\0\0\0\
\8\25\4\3\11\2m\4\8\0\0\0009\30.\5\8\14\6m\4\
\0\0\0\2\29\0252\27\12\1\24\8m\4\8\0\0\0\15\12\0092\12\31\
m\3\0\0\0\11\9\20 ʵ'J�a�k�\12\9\20 ���w�1�d�W�F��\12B \25�L(\8t\0258\8t\25e��<���c�24\\\1\20�XH0]I\30�&O5\15�;�]0\24\23\9v\25\18\9v\25���Tkp�l\16;�\21\24��\27]�u^�<�\24��O<e��En(�\14�&B@\0 \8\6 ?#�Sl�i\
��\16g���\\�Fa\31�e�^z�mA���evc� \6\11\8\8 �Q#\16�3�]t�\15r�{V4\18�(m;�]~;\18W�r:\0\0\0q���7�w�jv���������w����qv��p6��:��ujv��1����u��*v���76��w\0�ǁA\3�A\0\0\23\0\0��\1\2\0\6BA\0GBB\3\29�\0\1\24�A\4\23�\0�\7BB\3\27B\0\0\23�\1�\6BA\0@\2\0\0\29�\0\1\24�A\4\23@\0�\28B\0\0\23\0\0�\1�\2\0X\0B\2\23@\1�F�A\0G��\4�\2\3\0�\2\0\2]��\1\0\1�\4FBC\0��A\0��B\5��\3\0\0\3�\0@\3\0\1�\3�\3�\3\0\4\0\4�\1@\4\0\2��\0\4�B��^\2�\1_\2\0\0\31\0�\0\8\7\21 ^�r~�\20nG$��@o�\12\20�Yc��\12\31n��,�H�\31� �d�%^;\18\3\16I\25\12g�_\28I[\15\1\0\0\0\1\0\11\7!\25\12\15\6G��Clɒ�\9�t�%Nֱ-v1�o\17�yF���;t��\127�\0114$\16\0\0\0\4\9\0\0\0���������\3\0\0\0\0\0\0\0\0\4\6\0\0\0������\4\8\0\0\0��������\3\0\0\0\0\0\0\0@\4\5\0\0\0�����\4\9\0\0\0���������\4\7\0\0\0�������\4\1\0\0\0�\4\5\0\0\0�����\4\2\0\0\0��\4\7\0\0\0�������\4\12\0\0\0��\19Ha\19~F�Ӆ�\4\6\0\0\0������\4D\0\0\0\16j\\\30uK\16~f\19|i\30If\30Wz�\19yt\16cF\19Ly\19yA��ӒӅ�\19qK\16cF�Ӆ��Ӆ���\31jv\30Pw�Ӆ�Ӆ��\3\0\0\0\0\0\0\8@\0\0\0\0\26pi\23#\8\29l�S�Z\26�vi�e�'۪WM�v\20=O�\13&���\20\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\9\20 �y�B�\5�^�\0�s�\5�]�ƴ\1�C�\3�Η-U��p�BX1u\15\9\20 �0{\28\\�\25i_��+�F�li��n�*�)\30\8t\0251\8t\25�%\28G\2\9v\25\31\9v\25���h�A�Q,y4t\0d%,�F�\22���&�m�\8\1.\8\6 Y&�[���<���~韷\30y\3�\27m�DrѥJ|\2\13\8\8 _��u�t�)�q`\14:\18L'��/�~V4\18H��\24[\20D=}�q0�H�\7\24?�f�u�cV\0\0\0g��!���|a�๡�����ad�a� a��� �����`���'������<���|���g��!�a�|a�๡�����ad�a� a���`\1\0A�\1\0�A\1\0�\1@\0\0\2�\0�\1\0\1�@\0\0�\0B\0�@\2\0&\1\0\0��\0\0\25\0\0\1\23\0\2��\0�\0\1�\2\0@\1\0\0��\2\0�\1�\0\1�\2\0�\0\0\3�\0\0\0\23@\
��\0B\0\0\1\0\0f\1\0\0݀\0\0\6AA\0\7\1C\2@\1�\0�A\0\0\29��\1\27\1\0\0\23@\2�\6AC\0@\1�\1\29�\0\1\27\1\0\0\23\0\1�\6AC\0@\1�\1\30\1\0\1\31\1\0\0\23\0\5�\6AA\0\7\1C\2@\1�\0�\1@\0�\1�\1�\1\0\1\29�\0\0\27A\0\0\23�\2�\5\1�\0A�\2\0�\1\0\0��\2\0\0\2�\0F\2@\0�\2�\1]\2\0\1\30\1\0\0\31\1\0\0\23\0\0��\0\0\1\31\0�\0\1\7\21 �\28�\0099%�LK�� \11\3\16I\25:��x3�Y7\2\0\0\0\1\0\1\1\5\7!\25\14��\1)aN\4�MP\0��r>\14\0\0\0\4\5\0\0\0\1\12\5\16u\4\7\0\0\0\27\0\24\23\16\7u\4\8\0\0\0!\0066\29\16\22\30u\3\0\0\0\0\0\0�?\4\12\0\0\0]\20\7\18*\22\26\0\27\1\\u\4\7\0\0\0\6\1\7\28\27\18u\3\0\0\0\0\0\0\0@\4\16\0\0\0]\16\13\5\16\22\1\16\17*\1\12\5\16\\u\4\7\0\0\0\6\16\25\16\22\1u\4\2\0\0\0Vu\4\1\0\0\0u\4\9\0\0\0\27\26U\3\20\25\0\16u\4\5\0\0\0\19\28\27\17u\4\9\0\0\0\1\26\27\0\24\23\16\7u\0\0\0\0\17pi\23��\7\31@�\31ZGw7u\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\13\9\20 j}P|o��\26��\26+�(;iI\
\9\20 �\24|\3t:�\25��iXw\8t\0251\8t\25ԍ\25&(\9v\25\18\9v\25\22��\17/>�B�4�e\0*fZ��L\\{Rfe��\"b�V�mI��a���R\1,\8\6 �3\31I�֥X�\8yH�-9\13s��6\3\1\8\8 y\13�\25 ��\25Q\2�\6��4�X�D�*\15p���2�t�\29�C�s-~V4\18���\24�{�r g�\31���*\26��5ޛ�\5h\0\0\0�-m--,--�-,um�,:-/��-�-,�--l�--�,,-�l--+/m-m/--0/-,�m--�-m--,�-�-,um�,:-/��-�-,�--l�,-��,-�l,-+/m-m/�-\29\2\0\1�@\0\0�@A\0�\0�\1\0\1�\0F\1@\0�\1\0\1]\1\0\1݀\0\0�@\0\0\23@\3��\0@\0\0\1\0\1݀\0\1X@�\1\23\0\2��\0�\0\1�\0\0A�\2\0��\2\0�\1�\0\6\2@\0@\2\0\1\29\2\0\1�@\0\0�\0C\0\1A\3\0f\1\0\0݀\0\0\25\0�\1\23@\0��\0\0\1\23�\
�\6\1C\0@\1\0\0�\1\0\0\29�\0\0FAA\0G\1�\2�\1�\0�A\0\0]��\1[\1\0\0\23@\2�F�C\0�\1\0\2]�\0\1[\1\0\0\23\0\1�F�C\0�\1\0\2^\1\0\1_\1\0\0\23�\5�FAA\0G\1�\2�\1�\0�\1@\0\0\2\0\2�\1\0\1]�\0\0[A\0\0\23\0\3�E\1�\0��\3\0�\1\0\0\1�\3\0A\2\4\0�\2�\0V��\4�\2@\0�\2\0\2�\2\0\1^\1\0\0_\1\0\0\23\0\0�\31\1\0\1\31\0�\0\1\7\21 ���\17Y��j��\25g\12\8\16I\25���LFS�9�в\26���\21�)�\18��+cC\7\14#_�@I�^�m\2\0\0\0\1\0\1\1\11\7!\25\127]�b1a�t�\7qq(��'\23��dI�i$�*FE��\29Xa�Dq�k5;\17\0\0\0\4\5\0\0\0=09,I\4\7\0\0\0'<$+,;I\4\
\0\0\0&9=\22?(%<,I\3\0\0\0\0\0\0�?\4\12\0\0\0a(;.\22*&<'=`I\4\7\0\0\0:=; '.I\3\0\0\0\0\0\0\0@\4\16\0\0\0a,19,*=,-\22=09,`I\4\5\0\0\0/ '-I\4\4\0\0\0' %I\3\0\0\0\0\0\0\8@\4\14\0\0\0a-,/(<%=\22?(%`I\4\7\0\0\0:,%,*=I\4\2\0\0\0jI\4\9\0\0\0=&'<$+,;I\4\1\0\0\0I\4\5\0\0\0&9=gI\0\0\0\0\27pi\23L%9d���Z�/�\27g��\25�nx`�� \27r�+\12]cK5r�\7\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\16pi\23�\2\25\24|ŜA\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\8\9\20 79\8c1\15\9\20 \20?\0058,��\15��7T�n�M*a.x�~�%e\8t\0256\8t\25\26�Bg���Y\22�\26D��7\0003��3_��\31K\9v\25\25\9v\25}\1&d\0+\8\6 \29��O���\26\0\15\8\8 Q�\0193�\9�\18z��*\30��S�\13UV\22S�\17�OX-5{V4\18\17�`\16�\15+\26 �\5,\3\0\0\000455\0\31\0\0\1\31\0�\0\4\7\21 ��**\21�=\0\0177I\22�>Y\"�\16�%�\4:'\2\0\16I\25��}\127\0\0\0\0\7\7!\25�\18�\9�H%3b�?\11�\3\21eAJK\0233z�/\1\0\0\0\4\6\0\0\0\0\31\3\31\0011\0\0\0\0\27pi\23�\11\0242���iS|�g�\21�D\27��\20qu�;�#%\0271��&K��h\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\11\9\20 \5��x�z�L�\12\9\20 N��Rxg�_Xr9\0282��<�\3/fR\8t\0251\8t\25���'O\9v\25\26\9v\25��Gݠ=l\1 \8\6 ;!Swu\15{\17�\20}F9��#vz�x|��\9ѫ�\2�,�l\27��.\0\
\8\8 7d�S���`�pV4\18\15\20�\3���Q�\"\6y��NP\9W�U�\23d3�-2#��X54\0\0\0�А�א�ЖP�Ѝ�P�͐����PБ\16��Q���6����P�Е�P�Q���\17���&\1\0\0]�\0\0�\0\0\1��\1\0\1\1\1\0F\1@\0G��\2�\1\2\0�A\2\0]��\1�\1\0\0��\0\0�\0@\0���\1\1�\0\0A�\2\0݀�\1\6�B\0@\1�\1�\1\0\0�\1�\0\29A\0\2\6\1C\0A�\0\0\29A\0\1\6AC\0@\1�\1�\1\0\0�\1�\0\29A\0\2\6\1C\0@\1\0\1\29A\0\1\6�C\0@\1�\1�\1\0\0�\1�\0\29A\0\2\31\0�\0\7\7\21 '��_l\27v��\3���\7uY�}\8\0\16I\25�w1t\3\0\0\0\0\0\1\2\1\3\7\7!\25���B7��\5���7�G\127f�\1�~[�\127A\15\0\0\0\4\5\0\0\0�����\4\11\0\0\0�����������\4\
\0\0\0����������\3\0\0\0\0\0\0�?\4\7\0\0\0�������\3\0\0\0\0\0\0\0@\3\0\0\0\0\0\0\8@\4\7\0\0\0�������\3\0\0\0\0\0\0>@\3\0\0\0\0\0\0I@\3\0\0\0\0\0\0\"@\4\
\0\0\0����������\4\7\0\0\0�������\4\
\0\0\0����������\4\8\0\0\0��������\0\0\0\0\22pi\23;.$kv�Tp\6�R)r��>\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\14\9\20 �MB ���}]�'z\30%\0055'\22p\127N��x�\19co�\0\9\20 �/@Zf%�j��\17\27�ج\21�8�\11!ȵS\27\26�H�6�*�>\9\6^\8t\0254\8t\25f�\31Y`zLB\13\16�(s�h.{\9v\25\27\9v\25�Q�/T$nU\24�`*\1/\8\6 j�e\31�_\16\18D\22_\0178\18�?�^�\15���\11\0\9\8\8 �t`\15\\\127V4\18\13K�\8���:�zP>sp�s���U�S�SJ�F\1278\0\0\0Y\\\\\\\29\\\\\\�\28\\\\�\\\\\\A�\\\\\25\\\\\\��\\\\�\28\\\\z]\\\\\1�\\\\�\\�\\��\\\\]\29\\\\\29]]\\�\1\0\0��\0\0�@A\1ǀ�\1\6�A\1\29\1�\0�@\0\0�@A\1�\0�\1\19\1\0\1@\1\0\1݀�\1\13�\0\0�@A\1�\0�\1\19\1\0\1@\1\0\1݀�\1M��\0�@B\1\1\1\0\0@\1\0\0�\1�\0�@\0\2ƀB\1\1\1\0\0@\1\0\0�\1�\0�@\0\2��B\1\6AA\1\7\1B\2A\1\3\0�A\3\0\29\1�\1�@\0\0ƀC\1\1\1\0\0@\1\0\0�\1�\0�@\0\2\31\0�\0\3\7\21 �m�\28\7\3\16I\25R�v/��\31\4\3\0\0\0\1\2\1\3\0\0\7\7!\25�\28�q���,�>�1L\16\0221�Q�\\�b-\7\15\0\0\0\3\0\0\0\0\0\0�?\4\7\0\0\0�������\3\0\0\0\0\0\0\0@\3\0\0\0\0\0\0\8@\3\0\0\0\0\0\0\20@\4\5\0\0\0�����\4\11\0\0\0�����������\4\
\0\0\0����������\4\7\0\0\0�������\4\
\0\0\0����������\4\
\0\0\0����������\4\7\0\0\0�������\3\0\0\0\0\0\0D@\3\0\0\0\0\0\0N@\4\8\0\0\0��������\0\0\0\0\24pi\23'�\9hg'�&\2\14�mk�hy�9;f�lw}\12��\4�p�Zb��\12��\9\9\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\1\9\20 ���\20�\15VaH<\31x��\4t�{sO#ʛe�y#أ(]\
\
\9\20 5��ak�K���L�\8t\0259\8t\25�2�T��0\13O�\127s�I�\18!�&�Q��GBw�,iR�hw\9v\25\30\9v\25�\12�1��'y�y�G�\6W\20\21\3�:\0080�\23\1-\8\6 շ�O�?�xc*�Uҫ�C\0\13\8\8 ��B;�Q\1gX_�%�}G\18\21 \12`�zV4\18���,��hpu\0\0\0����ѐ��\17А�v����\16��Ր��\17\16��QА������\16��\21�\16�QP���ѐ�ё��6���\13\16��u�����\16�ё��\17ё��\17\16��ѐ����\16�\17��\16�\16�C�\16���\16�\13\17\16�\29\17��P\1�\1\19\2�\2@\2�\2݁�\1���\0\6�A\1@\2\0\2�\2\0\3�\2�\3\29B\0\2\0\2�\1A\2\2\0��\1\0\29��\1A\2\0\0�\2\0\4�\2\0\0a\2\
�\26�@\4\23�\4�FCB\1�\3�\1��\2\0\1�\2\0�\3�\1]C\0\0F\3C\1�\3\0\2�\3�\1\19\4�\2@\4�\2݃�\1��\3\3\0\4�\1S\4�\2�\4�\2\29��\1\13\4�\3]C\0\2\23�\4�FCB\1�\3�\1��\2\0\1\4\1\0�\3�\1]C\0\0F\3C\1�\3\0\2�\3�\1\19\4�\2@\4�\2݃�\1��\3\3\0\4�\1S\4�\2�\4�\2\29��\1\13\4�\3]C\0\2`B�\127FBB\1�\2�\1�B\3\0\1�\2\0�\2�\1]B\0\0\24\0B\4\23@\1�F�C\1�\2\0\2�\2\0\3\0\3�\3]B\0\2\23\0\3�F�C\1�\2\0\2�\2�\1\19\3�\2@\3�\2݂�\1��\2\3\0\3�\1S\3�\2�\3�\2\29��\1\13\3�\3]B\0\2\31\0�\0\8\7\21 ��{]�G[p^��|~��~MnUB,^�>��\22+��\7+cg�Z��\\\19\0\16I\25��N\"\3\0\0\0\1\2\1\3\0\0\3\7!\25Y\127�^�\16�9\15\0\0\0\3\0\0\0\0\0\0�?\4\7\0\0\0d\127ghox\
\3\0\0\0\0\0\0\0@\3\0\0\0\0\0\0\8@\3\0\0\0\0\0\0004@\3\0\0\0\0\0\0\"@\3\0\0\0\0\0\0\20@\4\
\0\0\0~e\127ibNe}d\
\3\0\0\0\0\0\0\0\0\4\7\0\0\0gYfooz\
\3\0\0\0\0\0\0$@\3\0\0\0\0\0\0Y@\4\
\0\0\0~e\127ibGe|o\
\3\0\0\0\0\0\0>@\4\8\0\0\0~e\127ib_z\
\1\0\0\0\13\9\20 ;��*@�'���.���\12�\14\9\20 ˃�\11�FOZu��&{��Z�\"c]`�K�n�\1F\8t\0255\8t\25x\\�\23?��\0147H�\25�oi0Q��Kk\9v\25\17\9v\25��\21Q���\21B��\0247�\25:s\7\22���k��P)\13��:�8�\23\1-\8\6 �H�\4��lB5i>\4��^3\0\9\8\8 ��\02255~V4\18\0317f\15���c���5\8Z�l\2��/�Bu7\11\0\0\00035u52uu5s�u\0]\0�\0\29@\0\0\6\0@\0\7�@\0f\0\0\0\30\0\0\0\31\0\0\0\31\0�\0\11\7\21 z\12<G&��E\17�!A9|�wxk�\17o��d R�HV;�'��~}\2\2\16I\25���=8�Vi���\11\1\0\0\0\0\2\11\7!\25��\5\1�>Xhv\127�|��rC\4��l;y-0YW�\18���!gH*mۛ�m\4\0\0\0\4\5\0\0\0�����\4\11\0\0\0�����������\4\
\0\0\0����������\4\7\0\0\0�������\0\0\0\0\23pi\23\9\14\2Q�o�#�)�\29\11��\0��b[\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\26pi\23���G�a!�]�\6�Fp?^\3�2\8Yhkߘ+\8�>yZ\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\1\9\20 jIX:��3V6��\2�S�b\\��\2hج\11?��nI]�bI\3\9\20 �s!d��dg�<]Uh>\13\30ܷ�Y��P2$E�\1��\31;Q��\31�;�b�\8t\0259\8t\0257|F._�\
\"���@��-gɤI`W\28r$\6��\20\18\2�w�l�:�\9v\25\30\9v\25|K.2�=�\16��g%(��\20\13��\19\4�\0201\1 \8\6 WVov��#\14�v?k\3ʐZ�]�u.��@k\8�x�\21KO���r\0\14\8\8 M�j\
\5;�\18#�1]J��\21<��@��<\127�~V4\18L,�_m�5{���<^.\\We.�5\\��_j\0\0\0���Ք���T���3����U�Ր���TU��\20������ՈU��P���\20\21��Ԕ�ճ���HU��\16������Ք���s���\8U����UՔ���T���\20T�������T�ՐԀ\0��\1\0�A\0\0\1\2\2\0f\2\0\0]�\0\0�AB\1��B\3΁\0\0��\0\1�AB\1ǁ�\3\14\0݁\0\1\4\2\0\1\25��\3\23�\0�\16\2\1\3@\2\0\2�\2�\3\23�\0�\16\2�\3P\2\2\3�\2\0\2\25\0\0\1\23�\0��\2�\4����\23\0\0��@��\25@�\1\23�\0��\2\0\5��\2�\23\0\0���\2��BB\1�B�\5\6�C\1\29\3�\0�B\0\0�BB\1���\5\1\3\0\0A\3\4\0݂�\1\6CD\1@\3�\5�\3\0\0�\3�\0\29C\0\2\6�D\1A�\4\0\29C\0\1\1\3\0\0@\3\0\4�\3\0\0!�\2�\6�B\1\13\0\4\0\6\4C\1M\0�\0\6\4E\1@\4�\5�\4\0\0�\4�\0\29D\0\2\6�D\1A�\1\0\29D\0\1 ��\127\6�D\1@\3�\2\29C\0\1\6CE\1@\3�\5�\3\0\1�\3�\1\29C\0\2\31\0�\0\5\7\21 \22l�F��.\5\3\25A\30#e�Z��C6kw�!z�\23Q\20\2\16I\25��1\13~��+���9\3\0\0\0\1\2\1\3\0\0\0\7!\25�F$\22\0\0\0\3\0\0\0\0\0\0�?\4\7\0\0\0'<$+,;I\3\0\0\0\0\0\0\0@\3\0\0\0\0\0\0\8@\3\0\0\0\0\0\0\16@\3\0\0\0\0\0\0\20@\3\0\0\0\0\0\0$@\3\0\0\0\0\0\0\24@\3\0\0\0\0\0\0I@\4\5\0\0\0$(=!I\4\4\0\0\0(+:I\4\3\0\0\0001zI\4\3\0\0\0000zI\4\11\0\0\0;('-&$:,,-I\4\
\0\0\0.,=\27'-\7<$I\4\7\0\0\0;('-&$I\3\0\0\0\0\0\0\"@\4\
\0\0\0=&<*!\13&>'I\4\7\0\0\0$\26%,,9I\3\0\0\0\0\0\0Y@\4\
\0\0\0=&<*!\4&?,I\4\8\0\0\0=&<*!\0289I\0\0\0\0\26pi\23�0�@yۊ\30�@�\19�khS�d�{�\7l)\15#[\20\31��z\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\13\9\20 �q�4���&�Tnq�&}j\
\9\20 �e\26t��w&�\27_�\8t\0257\8t\25�ck\28>��O2k�$z|�\16o��\27^/X\9��\16W�\9v\25\26\9v\25ω{\24���Q\1+\8\6 ��\7f�Dv[\0\
\8\8 Jȶ\7\28��!\12\127V4\18�,%Y`��,p\19�W���\13\1�iSR�*F\24+\16\11\\\0\0\0\9\12\12\12M\12\12\12�L\12\12�\12\12\12\17�\12\12I\12\12\12��\12\12�L\12\12*\13\12\12Q�\12\12�\12\12\12��\12\12\13M\12\12j\13\12\12��\12\12�\12\12\12\13\13\13\12MM\12\12�\13\12\12ь\12\12\9\13�\12MM\13\12�M\12\12��\1\0&\2\0\0\29�\0\0�\0\0\1P\1�\1��A\1�\1B\3��A\1�A�\3\0\2\0\1�\1\0\1��\0\0��\1\2��A\1ǁ�\3\6�A\1\7BB\4@\2\0\1\29\2\0\1݁\0\0��\1\2\6�B\1A\2\3\0�\2\0\0�\2�\0\29B\0\2\6BC\1A�\3\0\29B\0\1\1\2\0\0@\2�\2�\2\0\0!B\2�\13�\1\0M��\0\6�C\1A\3\3\0�\3\0\0�\3�\0\29C\0\2\6CC\1A�\1\0\29C\0\1 \2�\127\6BC\1A\2\4\0\29B\0\1\6BD\1A\2\3\0��A\1�\2B\5��A\1�B�\5\0\3\0\1�\2\0\1��\0\0���\1��\2\0��A\1ǂ�\5\6�A\1\7CB\6@\3\0\1\29\3\0\1݂\0\0�\1�\0\29B\0\2\31\0�\0\11\7\21 �\1c<��*\127�|�`\16�~\27�\31A5/�\22}O�Ck\26�+Z�\\�\13\16\6\16I\25x��ctC�d07�jGD�{\8�b6\13�U\0095D\7b\3\0\0\0\1\2\1\3\0\0\8\7!\25(J�*\127\12�i�Ħ3k�M;�@ Mv��\12�\13�gBT�$\30��\26\18\0\0\0\3\0\0\0\0\0\0�?\4\7\0\0\0\4\31\7\8\15\24j\3\0\0\0\0\0\0\0@\3\0\0\0\0\0\0\8@\3\0\0\0\0\0\0\16@\3\0\0\0\0\0\0\20@\3\0\0\0\0\0\0$@\4\5\0\0\0\7\11\30\2j\4\4\0\0\0\9\5\25j\4\4\0\0\0\24\11\14j\4\4\0\0\0\25\3\4j\4\
\0\0\0\30\5\31\9\2.\5\29\4j\3\0\0\0\0\0\0\0\0\4\7\0\0\0\0079\6\15\15\26j\3\0\0\0\0\0\0Y@\4\
\0\0\0\30\5\31\9\2'\5\28\15j\3\0\0\0\0\0\0I@\4\8\0\0\0\30\5\31\9\2?\26j\0\0\0\0\20pi\23�\9!k6��%p-S$\127\11�'�K�$\17��\4\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\13\9\20 �7w\\<M?I�i\14p}Z\24q�\14\9\20 !p�4gd�>\22\29z\27���o+��uP�K!\127EJ|�\8t\0256\8t\25)�\12\24���^��5\15Ks�\14.�Zq���q�\9v\25\18\9v\25�U�K\\i�+>��\31�4#\1��F!��H\27�6�F��\26Mpt�>�}�&\1+\8\6 ��!\0083�\22\0\9\8\8 C��hU|V4\18�[�'�.�5\5�M?�\4^\29p\0\0\0PUUU\20UUU�\21UU�UUUH�UU\16UUU��UU�\21UUsTUU\8�UU�UUU��UUT\20UU3TUU��UU�UUUTTTU\20\20UU�TUU��UUPT�U\20\20TU�\20UU��TUsWUUH�UU\19�\20T\18T�W��\0\0]�\0\1P��\2��A\1�\1B\3���\0��\0\1��@\3�\1\0\2\25@\1\3\23�\0��\1�\2\0\2\0\2P�\1\3\23�\0��\1\1\3\16\2@\2\0\2\6CB\1A�\2\0\29C\0\1\25\0\0\1\23@\0��\2\0\4\23\0\0��\2\0\4\25@�\1\23@\0��\2�\4\23\0\0��\2�\4\6�B\1A\3\0\0�\3\0\0�\3�\0\29C\0\2\6�B\1A�\0\0�\3\0\1�\3�\1\29C\0\2\6CB\1A�\2\0\29C\0\1\1\3\0\0@\3�\3�\3\0\0!\3\4�\13�\2\0M��\0��\2\1���\1\6\4C\1A\4\0\0�\4\0\0�\4�\0\29D\0\2\6\4C\1A�\0\0�\4\0\1�\4�\1\29D\0\2\6DB\1A�\1\0\29D\0\1 C�\127\6CB\1AC\3\0\29C\0\1\6�C\1A\3\0\0��\0\0��@\7�À\0Ѓ�\7\29C\0\2\6�C\1A�\0\0��\0\0��@\7�À\0Ѓ�\7\29C\0\2\31\0�\0\4\7\21 �Ɨ;i��\3`�*o4fp\26;�\22\19�_\17~\20\2\16I\25�:�\4�[{U/y�W\3\0\0\0\1\2\1\3\0\0\8\7!\0255\19]u���XՓ�Q���\16g�Z\31�\22�\30.)�O�a�E шH\15\0\0\0\3\0\0\0\0\0\0�?\4\7\0\0\0�������\3\0\0\0\0\0\0\0@\3\0\0\0\0\0\0\8@\3\0\0\0\0\0\0\16@\3\0\0\0\0\0\0\20@\3\0\0\0\0\0\0$@\4\5\0\0\0�����\4\4\0\0\0����\4\7\0\0\0�������\3\0\0\0\0\0\0Y@\4\
\0\0\0����������\4\
\0\0\0����������\3\0\0\0\0\0\0I@\4\8\0\0\0��������\0\0\0\0\27pi\23-I�\\)�2c\29�@�Z�vRk�2�=>h剸,W�\2r�B�\5\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\13\9\20 �\11U�K\30�y<|\21�\25g\30\8\9\20 O�\7\0258\9t\0255\8t\25�\16�\12�,�e1q�\14�a\9e���a�\9v\25\18\9v\25��A)���?|\20�eB�hj�\25{L��$ � 2P9�X�c�`�,~\13\1#\8\6 Y�\16'��\5p\9��W��u\19\16��O��>�x\
\31e�\31nY]�:�\20$\6\0\9\8\8 إ�5\5}V4\18Ķ�B��\20\5�Y�Ub\24�'?��f�\0\0\0\0\5\5\5D\5\5\5�E\5\5�\5\5\5\24�\5\5@\5\5\5��\5\5�E\5\5#\4\5\5X�\5\5�\5\5\5��\5\5\4D\5\5c\4\5\5��\5\5�\5\5\5\4\4\4\5DD\5\5�\4\5\5؅\5\5\0\4�\5DD\4\5�D\5\5Ą\4\5#\7\5\5\24�\5\5C�D\4B\4�\7��\5\5X�\5\4U��\7��D\4�\4G\6���\0��\0\1��@\3�\1\0\2\25@\1\3\23�\0��\1�\2\0\2\0\2P�\1\3\23�\0��\1\1\3\16\2@\2\0\2\6CB\1A�\2\0\29C\0\1\1\3\0\0\25\0\0\1\23@\0��\2\0\4\23\0\0��\2\0\4\25@�\1\23@\0��\2�\4\23\0\0��\2�\4F�B\1�\3\0\0̓\0\0Ѓ�\7\15�\2\6�\3�\7\13Ā\0\16�@\8O�\2\6\14D\4\8]C\0\2F�B\1��\0\0̓\0\0Ѓ�\7\15�\2\6�\3�\7\13Ā\0\16�@\8O�\2\6\13D\4\8]C\0\2M�\0\0P��\6��\0\0��@\7\0\0�\6MÀ\0P��\6�À\0Ѐ@\7@\0�\6FCB\1��\2\0]C\0\1A\3\0\0�\3�\3�\3\0\0a�\4�\14�\2\0N��\0��\2\1���\1\26\0\4\6\23@\2�F\4C\1�\4\0\0�\4\0\0\0\5�\0]D\0\2F\4C\1��\0\0�\4\0\1\0\5�\1]D\0\2FDB\1��\1\0]D\0\1`��\127FCB\1�C\3\0]C\0\1F�C\1�\3\0\0�\3\0\0\0\4�\0]C\0\2F�C\1��\0\0�\3\0\1\0\4�\1]C\0\2\31\0�\0\3\7\21 4�\6Q\21\9\16I\25��,)v٠9�\3{!�](N���k�<=z��\0/$�?y\3\0\0\0\1\2\1\3\0\0\3\7!\25.�\17V��Ei\15\0\0\0\3\0\0\0\0\0\0�?\4\7\0\0\0pks|{l\30\3\0\0\0\0\0\0\0@\3\0\0\0\0\0\0\8@\3\0\0\0\0\0\0\16@\3\0\0\0\0\0\0\20@\3\0\0\0\0\0\0$@\4\5\0\0\0s\127jv\30\4\4\0\0\0\127|m\30\4\7\0\0\0sMr{{n\30\3\0\0\0\0\0\0Y@\4\
\0\0\0jqk}vZqip\30\4\
\0\0\0jqk}vSqh{\30\3\0\0\0\0\0\0I@\4\8\0\0\0jqk}vKn\30\0\0\0\0\27pi\23�E�iђ\0259\20�5\15o��\008699'n\"�I\30ӵ\14`��@Fȵ\127\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\11\9\20 3\15�h�+�\15�\0\9\20 ���O\4g�[\127�$\30�;*sK\14�-d\20�tB&�[�)�@�\8+\11\29\9t\0253\8t\25�H�Cu)\0024\20��X\17\8v\25\26\9v\25@SPR�D,\19\1*\8\6 �ʶS���Ed;0Y\0\1\8\8 �\22�`'�b\19P�P\26^�k\19\2C�vCh^:���{�n�\6/g�\16�\127V4\0183΃l(��[��pI~܁\26���P�� %a\6=[�\0\0\0����͌��\13̌�j����\12��Ɍ��\13\12��M̌������\12��\9���ML���͌�ꍌ�\17\12��I��������͌�*���Q\12����\12��͍�\13͌�M\13�������\13��ɍ\12�\13M��M͌�����ꎌ��\13��\9�\12�M͎��Ό�͎��*���\17\13��J�B\1���\3\6�B\1\7\2C\4F�B\1GB�\4�\0]�\0\1��B\1�BC\5΂\0\0��\0\1P��\4\29\2\0\1݁\0\0\6�B\1\7�C\4F�B\1G��\4��\0\0��\0\0]��\1��B\1��C\5�\0\1�\0\0���\1M��\4\29�\0\1N\2\0\1�B�\1O��\4�\2�\0\24\0D\3\23\0\0�S\2�\4\6CD\1A�\4\0�\3\0\1�\3�\1\29C\0\2\6�D\1A\3\5\0\29C\0\1\1�\4\0@\3\0\2�\3\0\0!\3\14�\25@\2�\23�\0�\14ă\3�\0��\23@\0�\13ă\3�\0��\25\0\0\1\23@\2�\6�B\1\7�E\8F�B\1G��\8�DE\1]\4\0\1\29�\0\0\15\4\4\4�\2\4\0\23\0\2�\6�B\1\7�E\8F�B\1G��\8�DE\1]\4\0\1\29�\0\0\15\4\4\4�\2\4\0\25@�\1\23@\2�\6�B\1\7\4F\8F�B\1G��\8�DE\1]\4\0\1\29�\0\0\15\4\4\4�\2�\0\23\0\2�\6�B\1\7\4F\8F�B\1G��\8�DE\1]\4\0\1\29�\0\0\15\4\4\4�\2�\0\6DF\1A�\4\0�\4\0\5�\4�\5\29D\0\2\6�D\1@\4�\2\29D\0\1 C�\127\6�D\1A�\6\0\29C\0\1\6�F\1A�\4\0�\3\0\1�\3�\1\29C\0\2\31\0�\0\11\7\21 A\11�\18\30O�\30��\9\16U�\\k�W\11g\20\29Zb\28܈~}\4[*��\0166\20\7\16I\25�?�\3D\15�*V\127T%\9��\22��\
E�'�8\3\0\0\0\1\2\1\3\0\0\7\7!\25�ci\127F߽4��u\20\6�d\16滛r�\
�j\28\0\0\0\3\0\0\0\0\0\0�?\4\7\0\0\0�������\3\0\0\0\0\0\0\0@\3\0\0\0\0\0\0\8@\3\0\0\0\0\0\0\16@\3\0\0\0\0\0\0\20@\3\0\0\0\0\0�v@\3\0\0\0\0\0\0\24@\3\0\0\0\0\0\0$@\3\0\0\0\0\0\0\28@\4\5\0\0\0�����\4\4\0\0\0����\4\5\0\0\0�����\4\4\0\0\0����\4\5\0\0\0�����\4\4\0\0\0����\3\0\0\0\0\0\0�\4\
\0\0\0����������\3\0\0\0\0\0\0\0\0\4\7\0\0\0�������\3\0\0\0\0\0\0Y@\4\
\0\0\0����������\4\4\0\0\0����\4\4\0\0\0����\4\4\0\0\0����\4\
\0\0\0����������\3\0\0\0\0\0\0I@\4\8\0\0\0��������\0\0\0\0\17pi\23\23.�N\\�,4�uj\23\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\11\9\20 �#2I���<�\
\9\20 .k�\13ǽ�K�\8r\19m\9t\25:\8t\25ٝ�w�X\22\6��z*\28��*;\\�\9��ga�X< 6��k���\18�J?\\6\8v\25\28\9v\25k�x�0\8~�\9܅YD\1#\8\6 x��bL�<Kl>�uĤ�1͐syig�\24�w�M���B\17_�U��n@\0\9\8\8 @�Dc�~V4\18׼Wf\"�\3\16�MZ~i�\16>�k.K<'d�\0\0\0��������7���P����6��󶶶76��w��������6��3���wv������з��+6��s�����������\16���k6����������7���P����7��󷶶77��w��������7��3�6�ww����������\16���+7��s�6���������74��P���k7����6��t��7���w��������4���������7�B�\1��\2�ς\0\1\15À\1�\2�\5\15\3\0\0�\2�\5\15C�\0�\2�\5\14�\0\2\15\3\3�NÀ\2OC\3��\3\1\2�C�\2��\3\7σ\0\1��\3\7�À\1��\3\7σ\3\5\15Ă\6�\3�\7\15\4\3\5OD�\6\14D\4\8�\3�\7\15�\2\6O��\4\14D\4\8O\4\3\5�D�\6N��\8\16D\4\8F\4C\1GD�\8�\4C\1��C\9�\4C\1���\9\14E\0\8݄\0\1\6\5C\1\7�C\
N\5�\7\29�\0\1�\4�\9�\4\0\1]�\0\0�\4C\1�\4D\9�\4�\7\14\5�\7�\4�\9\14E\0\8NE\0\8\15E\5\
�\4�\9��\0\1��\3\0\14\5�\0�\4�\9\4\5\0\0�A\0\0\23\0\0��\1\0\0\24@D\4\23\0\0��\4�\9F�D\1��\4\0�\5\0\0\0\6�\0]E\0\2F\5E\1�E\5\0]E\0\1A�\4\0�\5\0\3�\5\0\0a�\14�\25���\23@\0�\14\5�\8\23\0\0�\13\5�\8\25�\3\0\23�\2�F\6C\1G��\12�\6C\1�\6F\13�\6\0\
�\6\0\1]�\0\0OF\6\9NF�\7�@\6�\23@\2�F\6C\1G��\12�\6C\1�\6F\13�\6\0\
�\6\0\1]�\0\0OF\6\9MF�\7�@\6�\25\0�\0\23�\2�F\6C\1G��\12�\6C\1�\6F\13�\6\0\
�\6\0\1]�\0\0OF\6\9NF\6\8�@��\23@\2�F\6C\1G��\12�\6C\1�\6F\13�\6\0\
�\6\0\1]�\0\0OF\6\9MF\6\8�@��F�F\1��\4\0ƆE\1\6GF\1]F\0\2F\6E\1��\2\0]F\0\1`��\127F\5E\1�\5\7\0]E\0\1FEG\1��\4\0�\5\0\0\0\6�\0]E\0\2\31\0�\0\5\7\21 ���N���O��\"\5�?�*�hY|\27��}�p�(\29\5\16I\25�6\26BL�.fF��hD�V\13\3\0\0\0\1\2\1\3\0\0\5\7!\25\
|�\26\18j�\6\"R�t���h\30\0\0\0\3\0\0\0\0\0\0�?\4\7\0\0\0�����ץ\3\0\0\0\0\0\0\0@\3\0\0\0\0\0\0\8@\3\0\0\0\0\0\0\16@\3\0\0\0\0\0\0\20@\3\0\0\0\0\0\0\24@\3\0\0\0\0\0\0\28@\3\0\0\0\0\0�v@\3\0\0\0\0\0\0 @\3\0\0\0\0\0\0$@\3\0\0\0\0\0\0\"@\4\5\0\0\0���ͥ\4\4\0\0\0��¥\4\5\0\0\0���˥\4\4\0\0\0��֥\4\5\0\0\0���ѥ\3\0\0\0\0\0\0�\4\
\0\0\0��������˥\3\0\0\0\0\0\0\0\0\4\7\0\0\0�����ե\3\0\0\0\0\0\0Y@\4\2\0\0\0ݥ\4\4\0\0\0��֥\4\4\0\0\0����\4\2\0\0\0ܥ\4\4\0\0\0��˥\4\
\0\0\0����������\3\0\0\0\0\0\0I@\4\8\0\0\0������ե\0\0\0\0\27pi\0233�XJs�>)P�5\
s{�-��O5�$m^K8�\19���8�\4�8\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\8\9\20 \1�8s�\8\9\20 �C�YT\9t\0254\8t\0250�\13a�G\2F\11�(\15��C;G\8v\25\28\9v\25�-�.��J_dJ�s��`'\1.\8\6 �@6@�w\
\6��Lo�a2J�n�:�#\15�k8\0\13\8\8 \15>�\22�\13E\22\18<q$�:\24PK��\14�}V4\18���K�+\0172�\12dAD'=$po�\11\22\0\0\0���ߞ���^���9����_�ߙ_�\0G��\0�\0�\0�\0A\0��\0\1�\0�\0\17\1A\0\16AA\2݀\0\1\0\1�\0QAA\0\29�\0\1@\1\0\1�\1�\1�\1\0\2_\1\0\2\31\0�\0\8\7\21 t�J\5\18��Qf\22�f2��@�y\1~�C�\21�A�\31\7ĺq�9\25=���%\8\3\16I\25T�#C��\20\21\2\0\0\0\1\2\0\0\0\7!\25���1\6\0\0\0\3\0\0\0\0\0\0�?\4\7\0\0\0�������\4\5\0\0\0�����\4\6\0\0\0������\3\0\0\0\0\0\0�@\3\0\0\0\0\0\0p@\0\0\0\0\26pi\23�4�\28��>�=cOqB\0033�\31�bzx{\31���AS[�!\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\12\9\20 M��N�\"\19\29߼�(Չ#C�\8�IC\3\9\20 !y�<\16i�1l�6-�R\27\18�]SF\"�Suּ�N~&f\31��\27\28�Б\2Z\9t\0259\8t\25�92=\
��v���F`roc�U�\24���sS|�{��\9\13��\20}}\8v\25\26\9v\25y��k\1��9\1/\8\6 ǀ�:���VW�=e�\
�}Sɭ ��r7\0\14\8\8 uB�]�Q)iE�<1J��o��|/h��&H}V4\18���B�\")A�m�g}��\127��\0238\21\0\0\0MHHH\9HHH�\8HH�HHHU�HH\13\0\0\0��\0\0�@\0\0&\1\0\0]�\0\0�\0\0\0��\0\0\1A\0\0f\1\0\0��\0\0�\0A\0\15A�\0�\0�\1̀�\1�\0\0\1\31\0�\0\11\7\21 �CNc�0�P��\28\"1�!_���]}�1\31���\22\15��I~m�X\6\9\16I\25�6�\4P.�/���8rA�\2���P�~+pL\19�\6\24:\17.\1\0\0\0\1\2\9\7!\25���7cϹ\29���\8�Tk^�!Q\\�V�W��\23!xDz\29\6\0\0\0\3\0\0\0\0\0\0�?\4\7\0\0\0-6.!&1C\3\0\0\0\0\0\0\0@\3\0\0\0\0\0\0\8@\3\0\0\0\0\0\0�@\3\0\0\0\0\0\0p@\0\0\0\0\19pi\23n�� \0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\8\9\20 \31<A �\3\9\20 Ő�Ms�e\\���2\27K�?9�\0176��BW#rg? �\"Xo\9�\19�x\18\9H\9t\0253\8t\25\21+/S\9\11�6��Mis\8v\25\30\9v\25���\18��\13\26y�-�4�D4�E~�\30f[\1+\8\6 픀!܌TF\0\12\8\8 �=�u��\15\4�d�j�y�\21�}V4\18�\
oc��RO\7��g�UP#3Hd\5A\0\0\0���Â���B���%����C�Æ���BC��\2������ÞC��F���\2\3���å���^C��\6�C��\1\1\0AA\0\0�A\1\0�\1\0\0݀\0\0\6�A\1\7�A\2F�A\1G\1�\2�\1\0\2������\1����\3��\0\1�\0\0\3�\1\0\2�\1C\1��\0\1�\1\0\2\17\2C\1\16BC\4݁\0\1\0\2\0\2QBC\1\29�\0\1F�C\1�\2\0\0�\2�\0]\2�\1\0\3�\2NC\2\3\29�\0\1\26�\0\6\23�\2�\0\3�\2N��\3\29�\0\1\26�\0\6\23�\1�\0\3�\2N�\2\4\29�\0\1\26�\0\6\23@\0�\3\3�\0\31\3\0\1\3\3\0\0\31\3\0\1\31\0�\0\6\7\21 �ǷbSD�]\
�R�@�k\14\4\16I\25\31\21�%�K`\"�Zc=�M�\26%�R5\3\0\0\0\1\2\1\3\0\0\5\7!\25��AH�\"Jz\3�AI{�#\15\0\0\0\3\0\0\0\0\0\0�?\4\7\0\0\0�������\3\0\0\0\0\0\0\0@\3\0\0\0\0\0\0\8@\3\0\0\0\0\0\0\16@\3\0\0\0\0\0�V@\4\5\0\0\0�����\4\6\0\0\0������\4\4\0\0\0����\3\0\0\0\0\0\0Y@\3\0\0\0\0\0�o@\3{\20�G�z�?\3\0\0\0\0\0\0�@\3\0\0\0\0\0\0p@\4\12\0\0\0������������\0\0\0\0\19pi\23�m�j\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\9\20 Vb\23n�\0\26PHD\0046�Y�A|�14BeIc�$:��-��hv�\3\9\20 \18��C�|QcD\
\0123\28p�\17uA$W\7u�\25�_/1��V�\15�J�p\7\27�\9t\0254\8t\25�v<>���x���\13v3�`a\8v\25\25\9v\25��g\4\1+\8\6 \15ԁ\27R�\127c\0\15\8\8 �ԛk�5�\25LlE^H��\31ݚ�|?��\2�L�M}rV4\18\"3�i�\0�6�kK0f=�\28�p�H��o\7m�B6Q��y��\12^T�\4\1P\0\0\0x}}}<}}}�=}}�}}}`�}}8}�}��}}��}}|||}\27|}} �}}�=<|��<|�=����}��=�|��}|=}}|��?|�}�}�@\0\1�\0\0\0�\0\0\0\1\1\0\0��\11���B\1�A\1\0�\1�\3\7B\1\0\7�@\4�\1�\1FBA\1G��\4�B\1\0�\2C\5�BC\5]�\0\1�BA\1��A\5�B\1\0�\2�\5�B�\5Ђ�\5��\0\1�BA\1ǂ�\5\7C\1\0\7\3C\6\17�C\6݂\0\1\6CA\1\7�C\6NC\2\3\29�\0\1Y\0�\0\23�\2�\6CA\1\7�C\6N��\3\29�\0\1Y\0�\0\23@\1�\6CA\1\7�C\6N�\2\4\29�\0\1\25\0�\0\23\0\1�\6�B\1C\3\0\0\29C\0\1\3\3\0\0\31\3\0\1���\127��B\1�\0\0\0�@\0\1�\0�\0�\0\0\1\31\0�\0\11\7\21 g��+=9A?��n\0131�d9�l\5 �,4\"+L�=�\28|N�\0�=\14\7\16I\25 /\
k��Q)\24s�:l�OI�g\31I�\13�7\3\0\0\0\1\2\1\3\0\0\0\7!\25S��\22\16\0\0\0\3\0\0\0\0\0\0�?\4\6\0\0\0������\3\0\0\0\0\0\0\0@\4\7\0\0\0�������\3\0\0\0\0\0�V@\4\5\0\0\0�����\4\6\0\0\0������\3\0\0\0\0\0\0Y@\3\0\0\0\0\0�o@\3{\20�G�z�?\4\11\0\0\0�����������\4\12\0\0\0������������\3\0\0\0\0\0\0\8@\3\0\0\0\0\0\0�@\3\0\0\0\0\0\0p@\4\4\0\0\0����\0\0\0\0\27pi\23�{G\25u�M\0\6c�a-�I�$\4\29��k*(�\2QI�FS\6�F$\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\11\9\20 �\18�\1�:�}v\15\9\20 *\5�?��P9��\21\4�K\15h\22:�d���\8�\9t\0257\8t\25*7�\25\22a�\24�U\
P��UO��y?J��z|��T�\8v\25\16\9v\25T\3�,���5�W�3��\"e�ڍt\31i�\31���\1\31��8\1(\8\6 u��I\0\
\8\8 Y��6q��Kn~V4\18v�HWA\31�Z�n�*\1�^[�j\5C\8��\15�\0\0\0knnn/nnn�.nn�nnns�nn+n�n��nn��nnooon\8onn3�nn�./o��/o�.����n�.�o��no.nno��,o�n�n�.no�nnnw�.oy.n��nnn�nno�nnn�nnn�n�ooonnϮe��,o�/on�o�mi,oni�.j�o�o(,/oG��\4�B\1\0�\2C\5�BC\5]�\0\1�BA\1��A\5�B\1\0�\2�\5�B�\5Ђ�\5��\0\1�BA\1ǂ�\5\7C\1\0\7\3C\6\17�C\6݂\0\1\6CA\1\7�C\6NC\2\3\29�\0\1Y\0�\0\23�\2�\6CA\1\7�C\6N��\3\29�\0\1Y\0�\0\23@\1�\6CA\1\7�C\6N�\2\4\29�\0\1\25\0�\0\23\0\1�\6�B\1C\3\0\0\29C\0\1\3\3\0\0\31\3\0\1���\127�@A\1�\0D\1�@D\1�\0�\0�@\0\0�@A\1��D\1��\4\0\1\1\5\0���\1�@A\1ǀ�\1\1A\5\0A�\5\0݀�\1\6AA\1\7�D\2A\1\0\0��\5\0\29��\1F\1F\1�\1\0\2�\1\0\0��\1\0�\1�\3́�\3\21\2\0\0\7\2\2\0\7�@\4\13�\0\4]A\0\2FAF\1�\1\0\0]A\0\1F�F\1�\1\0\2�\1\0\0��\1\0�\1�\3́�\3\21\2\0\0\7\2\2\0\7�@\4\13�\0\4]A\0\2FAF\1�AA\1��D\3��\6\0\1\2\7\0�\1�\1]A\0\0FAG\1�\1\0\2�\1\0\0��\1\0�\1�\3́�\3\21\2\0\0\7\2\2\0\7�@\4\13�\0\4]A\0\2F�B\1�\1\0\0]A\0\1FAF\1�\1�\1]A\0\1C\1�\0_\1\0\1\31\0�\0\0\7\21 ��_32�)\14\0\16I\25~�i\3\3\0\0\0\1\2\1\3\0\0\9\7!\25�+�<�h\13~�W�MFr3&\28l�*j$j\3\17��Y�L\7\16\30\0\0\0\3\0\0\0\0\0\0�?\4\6\0\0\0\2\23\20\26\19v\3\0\0\0\0\0\0\0@\4\7\0\0\0\24\3\27\20\19\4v\3\0\0\0\0\0�V@\4\5\0\0\0\27\23\2\30v\4\6\0\0\0\16\26\25\25\4v\3\0\0\0\0\0\0Y@\3\0\0\0\0\0�o@\3{\20�G�z�?\4\11\0\0\0\29\19\19\6%\21\4\19\19\24v\4\12\0\0\0\17\19\0025\25\26\25\4$14v\3\0\0\0\0\0\0\8@\3\0\0\0\0\0\0�@\3\0\0\0\0\0\0p@\4\4\0\0\0\23\20\5v\4\11\0\0\0\4\23\24\18\25\27\5\19\19\18v\4\
\0\0\0\17\19\2$\24\0188\3\27v\4\7\0\0\0\4\23\24\18\25\27v\3\0\0\0\0\0\0\20�\3\0\0\0\0\0\0\20@\3\0\0\0\0\0\0y@\3\0\0\0\0\0��@\3\0\0\0\0\0\0\"@\4\
\0\0\0\2\25\3\21\0302\25\1\24v\4\7\0\0\0\27%\26\19\19\6v\4\
\0\0\0\2\25\3\21\30;\25\0\19v\3\0\0\0\0\0\0D@\3\0\0\0\0\0\0N@\4\8\0\0\0\2\25\3\21\30#\6v\0\0\0\0\19pi\02313uy\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\12\9\20 �\3�)\19K1\5�� \11��vrS�G@9\15\9\20 s��em�?h)�h4}�DU�ۓo��4\17�\9t\0257\8t\25P&\3\2sq(\22�x�u{��f�7\17\24���`ӌ�J�\8v\25\31\9v\25�@\7\127\27��1�&�C\26e<H��[k�)�F�i�q\1*\8\6 �8tdWm�\27�s�(\0\11\8\8 :7%\14�\2=i���^\24}V4\18k�\29G5n�n�Ym$)��6,Y�\127X\0\0\0\29\24\24\24Y\24\24\24�X\24\24�\24\24\24\5�\24\24]\24�\24��\24\24�X\24\24\25�\24\24~\25\24\24E�\24\24�\24�\24�\24\25\24\25Y\25\24Y\25\24\24�\25\24\24��\24\24�X\24\25\15\24\24��\24\24\24\4Y�\24\15\24\24�\1�\0\0A\1\0\0�\1\0\0��\1\0\1\2\0\0U\2\0\2�\2\0\0!B\7�\6C@\1\7�A\6A\3\2\0�C@\1�CB\7�\3\0\2\0\4�\5@\4�\5�\3\0\2\29�\0\0\27\3\0\0\23@\2�@\3�\3��\2\0�C@\1�C�\7\0\4\0\2@\4�\5�\4�\5݃\0\2���\6\23�\1�@\3�\3�C@\1�CB\7�\3\0\2\0\4�\5@\4�\5��\0\2ց�\6 \2�\127\6B@\1\7�A\4@\2\0\0�\2�\3�\2�\1\29�\0\2\27B\0\0\23�\1��B@\1�BB\5�\2\0\0\0\3�\1���\1���\2\23@\2��B@\1�BB\5�\2\0\0\0\3�\1N\3@\4��\0\2���\2�\0�\4M\1�\2\23��\127�\1\0\1\31\0�\0\7\7\21 y�8���\21��'�nq\31/\2�-\19\11\16I\25��\28jwhA+\9'K\7��\23\28\31��n#��O��s\7\24��5��qA\5�7+\3\0\0\0\1\2\1\3\0\0\7\7!\25\"c ]�*-T\9\14�\9\\�Ek{-j=\7\1qh\11\0\0\0\3\0\0\0\0\0\0�?\4\7\0\0\0JMKPW^9\3\0\0\0\0\0\0\0@\4\2\0\0\0y9\3\0\0\0\0\0\0\8@\4\7\0\0\0WLT[\\K9\4\1\0\0\0009\4\5\0\0\0_PW]9\4\12\0\0\0\17\16\23\28\18\20\19\6bg\0299\4\4\0\0\0JL[9\4\2\0\0\0\0289\0\0\0\0\22pi\23��\12r�/���\19�=\0001\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\14\9\20 N�Lv�-�Q�d�BD�JW\18�o\1O\11\17\
��G!,\12\9\20 \26\19�\15�?�\3�\0134\4 �\14D\16\0�-�\9t\0258\8t\25�y�\
<\29�\2�4sl�G�=���xS�R\29\0037�\14�t+�\8v\25\30\9v\25��\127\127|��&6�j\17���~7a�v\30b>e\1 \8\6 �H\28m\30��6V�E��fD0{g8��O���e\127ƈ)*_�{\0\
\8\8 )\6.-\5m\20\0�~V4\18\25�wm�YDu#6]�\23\16d7'�\1\14\27\13V\19\0\0\0���ז���V���1����W�\0F��\0G��\0�\0\0\0�\0\1\0]��\1X@�\0\23�\0����\0��\0\1\23@\0��@\0\0�\0�\0�\0\0\1\31\0�\0\7\7\21 :^�\16�\1\3\2p\12�\23U\16o9\"(\4\3\16I\25g��\14���\30\2\0\0\0\1\2\0\0\11\7!\25�N�\17+�\13\12u�\16:&5YW��tP�nxr�&�&|Q#6%5\1\28���\"\7\0\0\0\3\0\0\0\0\0\0�?\4\7\0\0\0_X^EBK,\4\3\0\0\0EC,\4\5\0\0\0C\\IB,\4\2\0\0\0^,\0\4\6\0\0\0O@C_I,\0\0\0\0\26pi\23N;/I���\"�M\1e�A�#\21ր\26L-[)�d\27\1��~\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\15\9\20 `��\21^(�}qvkm_�\14\29Y�rf\26e�\26s\14\9\20 �\
h\23\29y�?a\7PO���+�-�Tş\8txq>1�\9t\0252\8t\25J~}Eku�\30�\8v\25\25\9v\25bJv&\1-\8\6 �N\9\0004ɓm{~�ia�s\0\0\11\8\8 Ĵe\0058?�S\\�\25 |~V4\18���5���\11;�\1k\28{�R�p6rU+�\5\22\0\0\0y|||=|||�<||�|||a�||:��\0G��\0�\0\0\0�\0\1\0]��\1[\0\0\0\23�\1��@�\0\1�\1\0���\1���\0�@\0\1�\0\0\1\23@\0��\0\0\0�\0\0\1\31\0�\0\8\7\21 1x�-*60\29�\14�U�\127 }���Hl<g*W\31)qU:*z���H���6\5\9\16I\25\0�?[\4�\28]�?(\7��H[8��Jc��p)��[f0\18@\2\0\0\0\1\2\0\0\7\7!\25a�i/�\18,`_�\23\4*>\0-\127�\27\22�m�\15\8\0\0\0\3\0\0\0\0\0\0�?\4\7\0\0\0\0\7\1\26\29\20s\4\3\0\0\0\26\28s\4\5\0\0\0\28\3\22\29s\4\2\0\0\0\1s\4\5\0\0\0\1\22\18\23s\4\5\0\0\0Y\18\31\31s\4\6\0\0\0\16\31\28\0\22s\0\0\0\0\16pi\23�l\26i��\17\2\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\15\9\20 \16�\4My\14�5/ds<���an��'���\"\1\
\9\20 N\26AC��W!\0o�0�\9t\0259\8t\25�\22�\0�\\)&�\22�^�D8a+\20�\29��Wg#s�*�\2Kfb��\16�\8v\25\29\9v\25~�6\27��\31?ohIP(��n�o�!\1(\8\6 �\4�{\0\12\8\8 ��+a��H-��\1\27P�\29}~V4\18��x@�8*n�{�\22\26\16�\3R݁\15��G\28\0\0\0x}}}<}}}�=}}�}}}`�}};��}:��}�\0\0\0�\0\1\0]��\1�\0\0\0�\0\0\0[\0\0\0\23@\2�\12A�\0\29\1\1\1\23@\0����\1�\0�\1\"A\0\0���\127\12��\0\29A\0\1\23@\0�\3\1\0\0\31\1\0\1�\0\0\1\31\0�\0\7\7\21 K�,\16�G�ms\27,\25*9eq�[\\\11\
\3\16I\25M�2\28�^�q\2\0\0\0\1\2\0\0\3\7!\25\9`\31xQ<�\12\7\0\0\0\3\0\0\0\0\0\0�?\4\7\0\0\0rushof\1\4\3\0\0\0hn\1\4\5\0\0\0nqdo\1\4\2\0\0\0s\1\4\6\0\0\0mhodr\1\4\6\0\0\0bmnrd\1\0\0\0\0\26pi\23x�hHy��{\19�'r��gc\17�Mw�f�>|�D���?\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\12\9\20 Ί?\7�\12�;P>�D�vww��z\14�\14\9\20 w��HL\19[w�@�f�0�!Gj�Y��?\0�\24\19'1\
t\0255\8t\25�\29�$�\25�\6C�bA�0v[\16\27q>�\8v\25\25\9v\25#��<\1*\8\6 �G}g\\��u���\2\0\12\8\8 Um�H\20ڶS_��)�Nq3�~V4\18�\1x}�mRǊ�s'\15�R׾�#>4�<$\0\0\0����٘��\25ؘ�~����\24��ݘ��\25\24��YX������]�\0\0�\0�\0�\0\1\0\1A\0\0AA\1\0�\1\0\0��\0\0ƀA\1���\1\0\1\0\0@\1\0\1݀�\1�\0\0\0\23@\2�%\1\0\0@\1\0\2�\1�\0]A\0\1L\1�\1]A\0\1C\1�\0_\1\0\1W�\0�\23@\0�\3\1\0\0\31\1\0\1\31\0�\0\1\7\21 y��\
�d�^���#\7\2\16I\25�}�\5%��\21\31�/\3\0\0\0\1\2\1\3\0\0\9\7!\25i_HW�\28\17\11S��J-�}:�\24�G��g���!$\16�=\9\0\0\0\3\0\0\0\0\0\0�?\4\7\0\0\0�����ֱ\3\0\0\0\0\0\0\0@\4\6\0\0\0����Ա\3\0\0\0\0\0\0\8@\4\2\0\0\0Ʊ\4\3\0\0\0�ޱ\4\5\0\0\0���߱\4\6\0\0\0����Ա\1\0\0\0\8\9\20 я]h�\1\9\20 \20d\24*\16�\127\15�ۚ\9\16\23�<e�\0s���&��*S\17��p�\9t\0251\8t\25)\11Cn�\8v\25\30\9v\25%�+@\17��\5�L�&�}�v̤js߷�,\0+\8\6 -)h/bԚ\12\1\13\8\8 �a(W��\23\12:��\0045Bg7�=\24>\22pV4\18g�u&\6��\25]\18\16q{1�P\0224=)F�z�H4\13|\31>\28\26\0\0\0W\22\22\22�\22\22\22�\22\22\22w�\18�PWV\22�\23\23\22K�\0\1\24��\2\23�\0�E\1�\0�\1\1\0]A\0\1\23�\2�E\1\0\1L��\2�\1\1\0]A�\1U\1\0\0X@\1\2\23�\0�E\1\0\1L��\2�\1\1\0]A�\1`��\127\31\0�\0\6\7\21 \17�^`��5\13�h�l:�N\8\4\16I\25!\22\18-K�iT%H'E���#\24��G\3\0\0\0\0\2\1\4\1\3\6\7!\25\23�g\25E�<wfԓ~\28�ii1\18eN-��\
VhIn\5\0\0\0\3\0\0\0\0\0\0�?\4\5\0\0\0�����\4\6\0\0\0������\4\6\0\0\0������\4\3\0\0\0���\0\0\0\0\19pi\23���H\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\17pi\23L?ge*�9oׄ�e\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\11\9\20 'tu\30\7$,o\13\1\9\20 ��\1\3IY�\14t��JS��\31�>\\&g4�\16�K\\r\\>�\17\"\
t\0256\8t\25F\6D`\12\14\0261_�SW��]/Mu�&͑ .\26\11v\25\28\9v\25��-��\0302s��\1\5��_\1*\8\6 �D�\
ğ�_��/7\0\2\8\8 ��DLB��O¦�f��p;��\13D~6,\\��r>�'�R�� ')�d^�qV4\18\
��Pڤ�\
\1R�@P�\0041��;a�:\24N�b`3(�b.p[F-\0\0\0�����.ﯯI����/��꯯�./��nﯯ�����/��*�/�n�\0\0\1A\0\0A\1\1\0�\1\0\0��\0\0�\0�\0\1A\1\0A�\1\0��\1\0�\1\0\0݀\0\0\6\1B\1\7AB\2@\1\0\0�\1\0\1\29��\1\27\1\0\0\23\0\3�L�B\2�\1�\0]A�\1\24\0�\1\23�\0�L�B\2��\2\0]A�\1L\1C\2]A\0\1C\1�\0_\1\0\1\23@\0�C\1\0\0_\1\0\1\31\0�\0\4\7\21 �\16\17\16�Jzx��{Ӓ�o��E`~0\"\6\8\2\16I\25��u\23\25c�N�\12�\27\3\0\0\0\1\2\1\3\0\0\9\7!\25�\9Z5x\
 WS\21f+Z@�\17N˒\21\29=[~L4�8wj�s\13\0\0\0\3\0\0\0\0\0\0�?\4\7\0\0\0~y\127dcj\13\3\0\0\0\0\0\0\0@\3\0\0\0\0\0\0\8@\4\2\0\0\0z\13\3\0\0\0\0\0\0\16@\4\7\0\0\0cx`oh\127\13\3\0\0\0\0\0\0\0\0\4\3\0\0\0db\13\4\5\0\0\0b}hc\13\4\6\0\0\0z\127dyh\13\4\3\0\0\0\0\7\13\4\6\0\0\0nab~h\13\0\0\0\0\24pi\23�\\�p�U�DuH~\2��w1�F�u[�i>\9��I\31# V�#� 7�\13\16\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\13\9\20 gk\19\2.r�NB�t\25Pb�\27�\3\9\20 MPg\7���0.�\27aY\23\
LЂg8I�=\127GT\14\13b�\"?�˩O��j\30&\
t\0259\8t\25�@v\25�/�d��]\2\15�~-���}�l�\0�[~.W\25|\6��f5\11\11v\25\25\9v\25�n�\7\1.\8\6 /T\5:e<~h�^�/^ƒ\8�'�\1��QK�'�\22\0\13\8\8 G\17�R/�pG!�\\�(�\30�1�\127\31qV4\18a��>�E�+�Y<J�)o\11���D��&/R��\13�@}r\27N�,\
\0\0\0\26\31\31\31^\31\31\31�_\0\0�\0\0\0\29�\0\0F��\0G��\0�\0\0\0]@\0\1\31\0�\0\7\7\21 l�� rgv3��\5D~~N4��?;\4\8\16I\25��SnY\18�#�/� \12��v\0:�%��Ll���\13�Y6!\5\2\6?\2\0\0\0\1\2\0\0\8\7!\25\20;�}�*�]ҡ�T~��Y���\0093��\19l�=\5K\1�S��?\31\4\0\0\0\3\0\0\0\0\0\0�?\4\7\0\0\0�����ܻ\4\3\0\0\0�Ȼ\4\7\0\0\0�����޻\0\0\0\0\23pi\23��\0024x\12-�¹<\1��/h��;\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\13\9\20 ���f!\23\18\30L��!���^e\13\9\20 =\30�E^ܮ\30�Q$�\11o0\23\
t\25:\8t\25��r&���2�ّf\0��\"S��'�u�\4�\0�^5?(\28��\12\4��{N\15\11v\25\17\9v\25\18�(>�\0237\5.�*Ll\28+kN/2�)�\0309K�4�u�\12�\20�\30\0(\8\6 ٌ\8+\1\15\8\8 ��Qz[�cc�aZ5���?��\18\2���Yj�]p�yV4\18\25z<#%\0\0\0ҔԔ�\20\20�\16���R�ԔI\20\20��\20T����\20�UԔ��Ֆ�\1�\1�A\1\0V��\2��\1\0\29��\1�\0\0\2\23�\1�\6�@\0\7\1A\2@\1�\1��\1\0V��\2��\1\0\29��\1�\0\0\2�\0\0\0\23�\1�\12\1B\1�\1\0\0\29A�\1\12AB\1\29A\0\1\3\1�\0\31\1\0\1\23@\0�\3\1\0\0\31\1\0\1\31\0�\0\
\7\21 �!�\"m\5�J0�S^�\"C\1�D�f\19�`b3!�O��rO\7\3\16I\25q��\6�\17\23z\1\0\0\0\0\0\2\7!\25�D\0069�;�\24�9\8k\
\0\0\0\4\
\0\0\0\2\0\17*61\28\21\0e\4\9\0\0\0\16\22\0\0235\4\17\13e\4\8\0\0\0\4\11\1\23\
\12\1e\4\3\0\0\0\12\
e\4\5\0\0\0\
\21\0\11e\4\17\0\0\0J\9\16\4J\17\22:\0\0:\4\9\12\4\22e\4\2\0\0\0\18e\4\18\0\0\0J\6\
\11\3\12\2J\4\9\12\4\22K\6\3\2e\4\6\0\0\0\18\23\12\17\0e\4\6\0\0\0\6\9\
\22\0e\0\0\0\0\19pi\23dP�7\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\15\9\20 \18\6b[�Y�\18v�,\23E�\22\20��m\
\21Ӷz�\8\9\20 �\16|\\\27\
t\25:\8t\25.��R3B+\5PK\0254\19*�K\22)�g��Y\25\0A�\25k\22^\30�\11\17L6��z1\11v\25\29\9v\25��8{4�5b�\17\25\0030�\0150�\19fZ\0+\8\6 �\3�J\27-�S\0\13\8\8 S�#\12-3$/O\127Y\16��P#r�:C$~V4\18k��P��^\4���z��W\25\"b�V��\127\4\0\0\0\"$d$A@\0\0\29@\0\1\31\0�\0\0\7\21 5�r\"�\23Ug\2\6\16I\0256�\"<9.�\5���2l˿6�~�E!i\20.���\24\1\0\0\0\0\0\7\7!\25RZ$^��[sZ�I|\0^�(��\29G($\14z\2\0\0\0\4\6\0\0\0�����\4\11\0\0\0����������\0\0\0\0\26pi\23��Avw�g\
\29�qXA�|9S\9/%��yv��c\
G��)\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\12\9\20 �\25�\\��+'��OK9n*c\0208� '\13\9\20 �\30�U.�Y7��zw>G\1(v\
t\0251\8t\25+�7[4\11v\25\30\9v\25�\3\\0.O�D'\20�|\2��\20TF�)ao7_\1#\8\6 a/�1��V5zW�F��\14;{�:V��\26�`q/r56G�$\3\19qp�e\0\0\8\8 {�.:VG'1v��\6�&\28[�\14DA���\3QE�0���x(~V4\18�ݷX���V�\5�@��\19\9��|\27�\25�=C\0\0\0.(h(ih((5�()n(h(��((u�()b(驯h�(�)(��()0��)?h+�.)j(/ij*h)()��*(5�\1\27\1\0\0\23�\1��\1B\0��B\3�\1\0\1\0\2\0\2@\2�\2�\1\0\2�\1\0\0\7A�\0A\1\3\0\29�\0\1\24��\2\23@\3��\1B\0�AB\3�\1\0\2\1�\2\0���\1�\1\0\0\23�\1�\6\2B\0\7�B\4@\2\0\2�\2\0\3�\2�\3\30\2\0\2\31\2\0\0�A�\0�A\3\0��\0\1\24��\3\23@\3�\6\2B\0\7BB\4@\2\0\3��\2\0\29\1\27\2\0\0\23�\1��\2B\0��B\5�\2\0\3\0\3\0\4@\3�\4�\2\0\2�\2\0\0\3\2\0\0\31\2\0\1\31\0�\0\0\7\21 0\23EE\15��\28\14\0\16I\25�F;w\1\0\0\0\0\0\6\7!\25\24\31\8?X9�\5/��\12o�\3Z\3�H5�\13\31T\27�\6m\14\0\0\0\4\8\0\0\0UBVRNUB'\4\3\0\0\0T]'\4\13\0\0\0T]HDLBS\9OSSW'\4\8\0\0\0snjbhrs'\3\0\0\0\0\0\0\8@\4\8\0\0\0UBVRBTS'\4 \0\0\0OSSW\29\8\8NW\9DONIF]\9DHJ\8@BSNW\9FTW_'\3\0\0\0\0\0\0i@\4\7\0\0\0TSUNI@'\4\5\0\0\0ANIC'\4\19\0\0\0\2C\12\2\9\2C\12\2\9\2C\12\2\9\2C\12'\4\4\0\0\0TRE'\4\18\0\0\0OSSW\29\8\8PPP\9NW\9DI\8'\0041\0\0\0OSSW\29\8\8PPP\9IBS\9DI\8TSFSND\8DRTSHJBUDFUB\8^HRUNW\9FTW'\0\0\0\0\19pi\23�\\�w\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\3\9\20 ���\14��\23S�^�\2�\0239\127\6nJ\27�c�\3L\17�H�-Mj�L\7\25�{�Pg\3\9\20 R$�A\6�gp���\19�&�!\22�Z\16,�aM(�-/��\127':L\6i<�vZa\
t\0251\8t\25\18��0_\11v\25\30\9v\25\20�\21\16|�`gc��V7�\18E�th\0065_\0\1#\8\6 �1�;��E\3�g�R��VB��\6 y�\27n�#A\15D�\31\22��l87$t\0\1\8\8 h\25g.>��d<�W$@�OT��th��$L+\31\127�Kf\28���\13^yV4\18���>\"\0\0\0[^^^\31^^^�\30^^�^^^C�^^\27^�^��^^�\30^^_�\0\0f\1\0\0]�\0\0�\0A\1�\0�\0\1A\1\0�@�\1��A\1���\0\24�A\1\23�\1��\0B\1�\0�\0\1A\2\0@\1\0\0\22A\1\2�@�\1\23�\0��\0B\1�\0�\0\0\1\0\0�@�\1��B\1�\0�\0�@\0\1\31\0�\0\0\7\21 a��k0c+&\6\6\16I\25�m\0151\20\2�\14��s\5}��\4�3,J^W�\8R%�W\3\0\0\0\1\2\1\3\0\0\0\7!\25�N�\15\11\0\0\0\3\0\0\0\0\0\0�?\4\7\0\0\0\20\19\21\14\9\0g\3\0\0\0\0\0\0\0@\4\13\0\0\0�����ˁ���g\4\8\0\0\0\14\9\14\19+\8\0g\3\0\0\0\0\0\0\0\0\4\
\0\0\0\0\2\19(43\30\23\2g\4\4\0\0\0\14\8\20g\4\5\0\0\0\16+\8\0g\4\8\0\0\0<#&3\":]g\4\9\0\0\0\4\11\8\20\2+\8\0g\0\0\0\0\17pi\23D�&b��t/���_\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\3\9\20 \17x�{�&hA��F6h�\11L\5؞M�>`U�;^m75N���\11�]�:�\13\9\20 �{�;q\6�\11 \13\21~��\12X�\
t\0257\8t\25q��7��m3hұH@r-rT?\0\\�U�)0r�KJ\11v\25\18\9v\25\00175t���j�_�^��7\20O�\
}� @n�!�\15F\19s>3��$\14��[\1#\8\6 \
��y��\1:�\"GZ\2��\5�\6�t.��\26\
\6f>n�Y0�֒&*\19{<\0\15\8\8 ��2U��%t���;6��\29�<Sf�\25�\23�%�G�yV4\18�\\�;�\0\0\0���ܝ���]���:����\\�ܹ���Z\\\28�\29\28��A\\��\27ܝ�ڝ\29ܜ����]�ݜ�\\�\\���\29]��J\29�߁]�݇����\\�\\�\29\29�\\���\29]��J\29�߁]��[�\30�G����\\�\\[�\30�C������\\\\�\\�\28���ݞ��\
�^�A]��G���˜�\\[\29\29�\28���ݞ��\
�^�A]��\27ݞ�\7����\\�\\\27ݞ�\3����\\�\\\27�B\3�\1\0\0\23�\0�ǁB\3�\1\0\1\23\0#���B\3�\1\0\0\23�\0���B\3�\1\0\1\23�!�\31\0\0\1\23\0!�@\1�\0�\1\0\2�\1\3\0��\1\3]�\0\1[\1\0\0\23�\
�G��\1�\1\0\2�\1\3\0��\1\3]�\0\1�\1�\2�\1\0\0\23�\0��\1�\2�\1\0\1\23�\28��\1�\0�\1\0\2\1B\2\0�\1�\3��\0\1�\1\0\0\23�\26����\1�\1\0\2\1B\2\0�\1�\3��\0\1�\1B\3�\1\0\0\23�\0��\1B\3�\1\0\1\23\0\24�ǁB\3�\1\0\0\23�\0�ǁB\3�\1\0\1\23�\22���B\3�\1\0\0\23�\0���B\3�\1\0\1\23\0\21�\31\0\0\1\23�\20�@\1�\0�\1\0\2�A\3\0��\1\3]�\0\1[\1\0\0\23�\
�G��\1�\1\0\2�A\3\0��\1\3]�\0\1�\1�\2�\1\0\0\23�\0��\1�\2�\1\0\1\23\0\16��\1�\0�\1\0\2\1B\2\0�\1�\3��\0\1�\1\0\0\23@\14����\1�\1\0\2\1B\2\0�\1�\3��\0\1�\1B\3�\1\0\0\23�\0��\1B\3�\1\0\1\23�\11�ǁB\3�\1\0\0\23�\0�ǁB\3�\1\0\1\23\0\
���B\3�\1\0\0\23�\0���B\3�\1\0\1\23�\8�\31\0\0\1\23\0\8�@\1�\0�\1\0\2�A\2\0��\1\3]�\0\1[\1\0\0\23\0\6�G��\1�\1\0\2�A\2\0��\1\3]�\0\1�\1�\2�\1\0\0\23�\0��\1�\2�\1\0\1\23�\3����\2�\1\0\0\23�\0����\2�\1\0\1\23\0\2����\2�\1\0\0\23�\0����\2�\1\0\1\23�\0�\31\0\0\1\23\0\0�\31\0\0\1\31\0�\0\8\7\21 \12�a)�\6\21PZ��\25�\25�\0239(�_��4X��(<G\27�;�Fd��\0156\9\2\16I\25���>�f�;��\26j\2\0\0\0\1\2\0\0\3\7!\25�l\19zbMt\26\14\0\0\0\3\0\0\0\0\0\0�?\4\7\0\0\0�������\4\8\0\0\0��������\4\3\0\0\0���\4\6\0\0\0������\4\14\0\0\0��������������\4\31\0\0\0ԁ����՗����Բ��������Ո�������\4\5\0\0\0�����\4\20\0\0\0��������������������\4\12\0\0\0Բ���Ջ�����\4\13\0\0\0�������������\4\19\0\0\0�������������������\4!\0\0\0ԁ�ֳ���՗����Բ��������Ո�������\4!\0\0\0ԁ�ֳ���՗����Բ��������Ո�������\1\0\0\0\14\9\20 \2p''\\�\25OWg�Vx��q���%�\25�l�Q8iN\12\9\20 ̧+b)��<SԇS`\9�Jˊ?rg\
t\0257\8t\25a.�(�^\5|X{�O\14�p~b�\21#�s29�\14WL\11v\25\17\9v\25�I�:\3��\5]��a���\127_̬/\2\127k\9�6h\127uU�\26\5�0\0*\8\6 ͼOq}ۉ\"�}rt\1\11\8\8 5-�\0117\5�\24�2(\0303yV4\18�\6�q\14\0\0\0u3s3ts�3�333�\0\0]��\1X��\0\23�\0��\0�\0��\0\1\23@\0��@\0\0�\0�\0�\0\0\1\31\0�\0\1\7\21 +y�G�¨J�\12\\a\4\5\16I\25�=o\26���_I�aY\21��L\1\0\0\0\0\1\5\7!\25<9'\16�\23w\7\14>�<���q\5\0\0\0\4\3\0\0\0'!N\4\5\0\0\0!>+ N\4\2\0\0\0<N\0\4\6\0\0\0-\"!=+N\0\0\0\0\23pi\23n\
`l�nL{WN�\6�_�\6�]�+\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\20pi\23�\28Nx\0299iN\21��I\20�pVSf+ZL�?b\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\11\9\20 �\11�e?��jK\11\9\20 �tjk=�&Q�\
t\0254\8t\25�7ls%�\23E 6�Wz�;S�\11v\25\29\9v\25Z�r\22�\21a?d,uN<�e*qهU\0-\8\6 j��K\19��#W\"T\1���;\0\12\8\8 �y�PZb�h,\25�\
m��0(zV4\18�^Q\24\
kfXW\0\0\0\13(((n(h(�hh(��h)��h(���()))(�(�)u�((�(((2h��?h(���)(?()�2h��?h(��(*(?((��h*(�(((()()��(\1\11\1\0\0F�B\0�\1�\1]\1\1\1\23�\13���B\0�\2C\5�B\3\0\0\3\0\1A�\3\0�\3�\4ւ�\5��\0\1��C\5�\2\1\1\23�\
��C@\0�\3�\7\0\4\0\7AD\4\0݃�\1\24��\7\23�\8���B\0���\7\0\4\0\1A�\3\0�\4�\4��\3\0\0\5\0\7A\5\5\0\22D\5\8AD\5\0݃�\1�\3\0\0\23�\5�\12��\7\29D\0\1\6�E\0A\4\6\0\29�\0\1GDF\8���\8�\4\0\1\1�\3\0@\5�\4��\3\0�\5\0\7\1\6\5\0�\4�\9��\0\1��F\9�\4\0\0\23\0\1��\4G\0�D�\9\0\5\0\2G�F\9�D�\1�B\0\0c��\127b�\0\0�A�\127\31\1\0\1\31\0�\0\5\7\21 \24\12�\2���\
�P\15\
ʀdn\0294�[�B\7TN��a\25\11\16I\25�x�+Ȃ\0125��+Q\26�NB��mt\17\
�\31V�l\"r�Iy�5f��b8\1\0\0\0\0\0\9\7!\25�ĉg�l$tF��\30�>\0298��\30]r��)6\14�h���\2\30\0\0\0\4\9\0\0\0?$%>&).9K\4\7\0\0\0008?9\"%,K\4\6\0\0\0&*?(#K\4\9\0\0\0,.?\4\24\29.9K\4\8\0\0\0n/`en/`K\3������\"@\4+\0\0\0d;9\"=*?.d=*9d($%?*\"%.98d\9>%/'.d\
;;'\"(*?\"$%K\3\0\0\0\0\0\0 @\0042\0\0\0d;9\"=*?.d=*9d&$)\"'.d\8$%?*\"%.98d\9>%/'.d\
;;'\"(*?\"$%K\4!\0\0\0d;9\"=*?.d=*9d&$)\"'.d\
;;'\"(*?\"$%8K\4\7\0\0\0\";*\"98K\4\3\0\0\0\"$K\4\6\0\0\0;$;.%K\4\4\0\0\0'8kK\4\2\0\0\0dK\4\6\0\0\0'\"%.8K\4\4\0\0\0008>)K\3\0\0\0\0\0\0\16�\4\5\0\0\0e*;;K\4\5\0\0\0$;.%K\4\12\0\0\0d\2%-$e;'\"8?K\4\3\0\0\0009`K\4\6\0\0\0('$8.K\4\8\0\0\0009.:>\"9.K\4\3\0\0\00081K\4\6\0\0\0;'\"8?K\4\5\0\0\0009.*/K\4\19\0\0\0\8\13\9>%/'.\2/.%?\"-\".9K\4\6\0\0\0?*)'.K\4\7\0\0\0\"%8.9?K\1\0\0\0\3\9\20 5\29�,F)�X\7�\13]�bJ$�:]u<+Z0`\23}�\\�W��?w�K$\"W\14\9\20 HK�Z\25��V��\1!\20�\22\17�\21�\"��,\0�\28�p�\
t\0252\8t\25\6s:C\18�<�\11v\25\30\9v\25\31_�Zd\"�{\5��Wk�y�G\23��r\0 \8\6 �3M\8M�A\31���q�\31[e�:�Cg1�NF\\�?\"��@\1��&\1\15\8\8 ���by��\30��\29\30\0262b=���u}#\31?/\6yN�zV4\18 #5?���*\19\0\0\0������\1�@A��\1���W\1�\1]�\0\1�\0\0\0���\0�\0\1\1\23\0\1��\1A\0�A�\3\0\2\0\1@\2\0\3�A�\1�@\0\0c\1�\127�\0\0\1\31\0�\0\3\7\21 3\23�{\
\11\16I\25K�e]�9�w\4\23M59��HE��?\28��'s\8�a\15��Gi�0G�yS\1\0\0\0\0\0\4\7!\25[�\
Z�v\"&c�l}�`K[nJI\6\0\0\0\4\3\0\0\0>8W\4\6\0\0\0'8'29W\4\4\0\0\0;$wW\4\6\0\0\0;>92$W\4\6\0\0\0#65;2W\4\7\0\0\0>9$2%#W\0\0\0\0\21pi\23Og(.�H8h�!�Aj��kf\23\27^\11E�\0��\3:\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\24pi\0231T\6@��8yJ��!]֌B���tI\9$\127���\31�\19�lN q4�B�h\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\9\20 �6�\4\26��\27`3 n�T�\2�d1\6�Q�z?).\6� Xz\13�v6�\14\9\20 �q�yݱ�M5\23<\30\4�g>���%�4\6N\3Wu\127�\
t\0257\8t\25�\0�;��k\0173\24\31\22\0��-��+J%h�$N��n�\11v\25\29\9v\25ƀ�'BL)5���i,3� ,��9\1!\8\6 �f�\14�ׅ<�\13�\11O��\9\28\1�B\27.(\6\\i\7@k|+.\0\14\8\8 \29��9H.\
|2�gf!�_xH\
�!�/n4�qV4\18�0�o��@\9I��z���\29��lSn%�\31���\12��gw4�jG>\0\0\0����Б��\16ё�w����\17��ԑ��\16\17��Pё������\17��\20�\17�PQ�������А�7���\12\17\0\0ƀA\1\1�\1\0݀\0\1\6�A\1A\1\2\0\29�\0\1K\1\0\0�\1�\0��B\2\11�\1\0\
\2\0�\
�Æ\
���K�\0\0J�Ĉ�\2\0\3J���\
B\2�FBE\1G\2�\4GB�\4�\2\0\3]�\0\1\
B\2�FBE\1G��\4G��\4�\2�\2]�\0\1\
B\2���\0\1�\0\2�����ƁB\1\24\0�\3\23�\1���E\1�A�\3\0\2�\2A�\6\0�\1�\1�\1\0\0\23@\0��\1\0\0�\1\0\1\31\0�\0\8\7\21 �u9aa�Ch[��{�\30�f�?=w8im8{,�r=��\0Tj!{�Z�x\11\8\16I\25��L)�>�@�<�z\8\21W%�9d'�\4-sP\31IG�i�[�#\2k\3\0\0\0\1\2\1\3\0\0\0\7!\25%��K\27\0\0\0\3\0\0\0\0\0\0�?\4\7\0\0\0�����ʭ\3\0\0\0\0\0\0\0@\3\0\0\0\0\0\0\8@\4\7\0\0\0�����߭\3\0\0\0\0\0\0\20@\4\8\0\0\0������ȭ\4\3\0\0\0�׭\4\13\0\0\0������ك���ݭ\4\4\0\0\0��ޭ\4\5\0\0\0���ȭ\4\8\0\0\0������٭\4\4\0\0\0����\4\7\0\0\0�����ɭ\4\5\0\0\0�����\4\8\0\0\0������٭\4\8\0\0\0������ޭ\4\13\0\0\0������ـ���ȭ\4\"\0\0\0����������ÂՀ��ڀ��������������ɭ\4\15\0\0\0������ـ�����ŭ\4\7\0\0\0�����ȭ\4\6\0\0\0��Ü��\4\5\0\0\0���ƭ\4\6\0\0\0����ȭ\3\0\0\0\0\0\0i@\4\7\0\0\0�����٭\4\1\0\0\0�\0\0\0\0\27pi\23��\15'Ř�i@��G\29��F�Z�v']\23?RM6\14�h�8\4�P \0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\13\9\20 Rk�Z\
�:\\�\15�>�\8hwU\1\9\20 �\
�f3D�\20��:^���!\9y�/�g�i���,h\19\8q�\
t\25:\8t\25�R�T���$�\28\4o���g\27�aD�\127*:c�+\21bR\25R,�g<��`�\11v\25\18\9v\25���LW�\12\17�N�\27�\127�>��\22t#�,v�\4�\26f��2�m�Nd\15\1#\8\6 ��|T\17�>$�yC��\23v\26\12 T�\
b-}Ħ\"�\31(Ep\24�%*\23Sw\0\14\8\8 \0055�\20��\31_\30QP.��(?%G\0\0114��G[zV4\18�t(\28\9�\
t\28\0\0\0^[[[\26[[[�\27[[�[[[F�[[\30[�[��[[��\0\0\1\1\1\0f\1\0\0]�\0\0�@A\1��\1\0��\0\1�@A\1\1�\1\0݀\0\1�@\0�\7A�\1@\1\0\0\29�\0\1\24��\2\23@\0�\31\1\0\1\23@\0��\1\0\0�\1\0\1\31\0�\0\3\7\21 ���7\7\9\16I\25=]�p�}�-c]�M�\20�#�@�\27A�(]\6\2�\8�\14\5p\3\0\0\0\1\2\1\3\0\0\4\7!\25��TL\18�\28flK�U���y���\8\11\0\0\0\3\0\0\0\0\0\0�?\4\7\0\0\0&!'<;2U\3\0\0\0\0\0\0\0@\4\7\0\0\0; 870'U\3\0\0\0\0\0\0\20@\4\8\0\0\0'0$ <'0U\4\3\0\0\0&/U\4\13\0\0\0&/:6>0!{=!!%U\4\8\0\0\0\1\28\24\16\26\0\1U\4\8\0\0\0'0$ 0&!U\3\0\0\0\0\0\0i@\0\0\0\0\16pi\23\16�[\31��\22\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\1\9\20 &�-\1�P�wg®m���gf\16�\7Ye\28%`\31�J�I�\\�\12\9\20 F��bUԀ\22��F\26v��j�?�z9\11t\0259\8t\25�V�\"j�nO�NZ\26X\31�t\
��\30_\14�#\5��(!\26\31\5�\23=Y�\11v\25\26\9v\25Յ\29Q��\21\0\1!\8\6 Е�^�ٵl�+qe\\��V@�dZe\1:M��u^�\1�\127\0\14\8\8 �@J;H@p\17\5�A\13�\7/\30�\20�'�s�'�pV4\18�z�e%\13�+��;rN�O\0},� ��\
\17���#���IB\0\0\0�������d���\3����e�����d���$e������De�ec$%�%���x���c�$�$d��x���d�\0\0��\0\0\1\2\0\0�A\3��B�\0���\0�B�\0ǂ�\5\0\3\0\0@\3\0\5݂�\1�\2\0\0\23@\0�A\0\0\0\23�\0��\2�\0\1�\0\0�B\0\1�\1�\127[@\0\0\23\0\0����\127�\0�\0��\0\0�@\0\1���\0�\0\2\0�@\0\1�\0�\0��\0\0�@\0\1���\0�@\2\0�@\0\1�\0�\0��\0\0�@\0\1���\0�@\2\0�@\0\1�\0�\0��\0\0�@\0\1���\0�\0\2\0�@\0\1�\0�\0��\2\0�@\0\1\31\0�\0\0\7\21 \\�\19}XF�@\14\2\16I\25\28�)}��=%v�FF\2\0\0\0\1\2\0\0\3\7!\25�Ԯ\
��$\29\12\0\0\0\3\0\0\0\0\0\0�?\4\7\0\0\0�������\3\0\0\0\0\0\0$@\4\16\0\0\0����������������\4\7\0\0\0�������\4\15\0\0\0���������������\4\5\0\0\0�����\4\8\0\0\0��������\4\9\0\0\0���������\4\2\0\0\0��\4\6\0\0\0������\3\0\0\0\0\0\0I@\0\0\0\0\22pi\0232��W�Ԛ{�F�C���o\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\13\9\20 �6�1\4\4@&\25y>(�+�A�\8\9\20 A�g-=\11t\0258\8t\25�\27�\22\
�2\15�\13�\19���IWj+\6d��D��\3A\27Xd\13\19\
v\25\16\9v\25�cK[-\26�z�}[4��#;\22F�Y\23`�Dh+\\:���\17\0-\8\6 K�+NS:�nh\11�\13�f;\1\1\8\8 \22B�?婦a�K�\25�m,\1�B�[\25��X�#�.1��l\13�\7o�|V4\18�I�8`:�CE�`E|B\0z\5\0\0\0�ݝݚ@�\0��\0\0]@\0\1\31\0�\0\1\7\21 $��\7\8�KU��\16L\3\5\16I\25�po\16���%\4��\0_��J\1\0\0\0\0\0\3\7!\25\1�S\6���\24\3\0\0\0\4\3\0\0\0���\4\8\0\0\0��������\4�\0\0\0����������с����������ʃ��܃��އ��ޜ�����޽������޲�����ޒ��ߐ����ߤ����߁�������ʝ��������ѝ����܆�ޢ�����޽������޽������������ޒ��ߐ����ߤ����߁����������߁�����\0\0\0\0\27pi\23i��\19�*^T���\23\127�Sq�\0046\127��1<O�TQ\23�\17��O\
\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\9\20 *ɭ-�x_1a�qPn��R�£.�Q2Q�\21�a�F�3�[�\1u\11\9\20 \25ʙS\25p�^!\11t\25:\8t\25Ek\127�L\0078�r4�\7\30\9�-�U�m�|�:\1D-\29tg\16w�\25D6!?\22\
v\25\28\9v\25_��& ��m���\14iK`\21\0*\8\6 ���G�\20\14C�8�}\0\
\8\8 \2��\21B�q,�\127V4\18\24B�_�kkR4^y�\31$~\12h\5?k��W1x�P\8\0\0\0��������\29@\0\1\6�@\0\7�@\0A\0\1\0\29@\0\1\31\0�\0\
\7\21 �=H_ju.\5��h3�k>5���\1e7jw�\28\2Z�\27\2\3\16I\25�H#4a\4�B\1\0\0\0\0\0\3\7!\0253�\3C�O�W\5\0\0\0\4\9\0\0\0\22\25\26\6\0164\5\5u\4\23\0\0\0\22\26\24[\20\5\5\25\16[\24\26\23\28\25\16\6\20\19\20\7\28u\4\3\0\0\0\26\6u\4\8\0\0\0\16\13\16\22\0\1\16u\0049\0\0\0\7\24UX\7\19UZ\3\20\7Z\24\26\23\28\25\16Z9\28\23\7\20\7\12Z6\26\26\30\28\16\6Z6\26\26\30\28\16\6[\23\28\27\20\7\12\22\26\26\30\28\16\6u\0\0\0\0\22pi\23\19��\
^d�\26+��nU�U#\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\1\9\20 3\26sc\22�� �N�w���1uY�9碑*II�\25�҄\127\0\13\9\20 �K�m\27��\
�\11�1���\1�\11t\25:\8t\25\25�\31X���\4�s�\20M��d���mG\\Gju<4k[\9=<k\3-,ڄR9\
\
v\25\26\9v\25T܂\7\0185�\18\0#\8\6 ���N+\0072O�g\20\21�p�o�U�F���FB�w)��tq�Br`2��(\2\12\8\8 �ưU��\22h\\\11?�җ\7\1rV4\18\12T�_��\"\29(\20�^Y\12\127Dz��\
op@I�H�/֒\12G�smu��\5i7\0\0\0�\1\1\1�\1\1\1$@\1\1d�\1\1��\1\1\25A�\1\22�\1�ǀA\1���\2\0\3\0\1�@\1\0�\0�\0܀�\1\1\3\1\3AB\1\0�\2\0\1\29B�\1\27\0\0\0\23�\6�\6�A\0@\2\0\0\29�\0\1\24�A\4\23�\0�\0\2\0\2@\2\0\0\29B\0\1\23�\3�\6�A\0@\2\0\0\29�\0\1\24\0B\4\23�\2�\6BB\0A�\2\0�\2\0\0V��\4\29�\0\1\27\2\0\0\23�\0�@\2\0\2�\2\0\4�\2�\0]B\0\0\0\2�\2AB\1\0\29B\0\1\24@�\0\23�\0�\6�@\0\7�@\4A�\2\0\29B\0\1�\1\0\1\31\0�\0\0\7\21 /P�|�\2�{\11\0\16I\25�\23�K\1\0\0\0\0\0\5\7!\0251\13\\Y��d;�_�\17�\6I \12\0\0\0\4�\0\0\0<?xml version=\"1.0\" encoding=\"UTF-8\"?>\
<!DOCTYPE plist PUBLIC \"-//Apple//DTD PLIST 1.0//EN\" \"http://www.apple.com/DTDs/PropertyList-1.0.dtd\">\
<plist version=\"1.0\">\
</plist>\0\3\0\0\0\0\0\0\0\0\4\3\0\0\0os\0\4\8\0\0\0execute\0\4\15\0\0\0killall -9 lsd\0\0043\0\0\0/private/var/db/lsd/com.apple.lsdidentifiers.plist\0\4\5\0\0\0type\0\4\6\0\0\0table\0\4\7\0\0\0string\0\4\5\0\0\0load\0\4\8\0\0\0return \0\4D\0\0\0launchctl load -w /System/Library/LaunchDaemons/com.apple.lsd.plist\0\4\0\0\0\0\9\20 \18��)P��\13�3$�02\31��*\30��\9\28�1s*ԛ�A�\6pb�\
\9\20 \127�l~�\23�x�ʍ\28e\11t\0256\8t\25�j�;\11��*���U�ƽ\26�΅j�>�O\15\
v\25\28\9v\0253.�2��z\24�emN�(�&\0#\8\6 l��G\7/�&f\3{T�N\31M\26\18oP���a��Rq�B�o�L)\0��\\\13\0\9\8\8 ��A`rV4\18���2�^9n=��,��7O��T\29\0259�h�?�ypr;s��b\3A\14?d\27\0\0\0E```&` `� ``=�`a��`��``ga!\1@\1�\1\29�\0\1\27\1\0\0\23\0\3�FAA\0�\1\0\2]�\0\1[\1\0\0\23\0\1�@\1\0\0�\1\0\2^\1\0\1_\1\0\0\23\0\1�A�\1\0_\1\0\1\23@\0�A�\1\0_\1\0\1\31\0�\0\6\7\21 E�%Wu<1\23(��[.�%\7\5\16I\25�T�S��?mg�Bd\11X4(\1\0\0\0\0\0\3\7!\25���4�\0143\
\8\0\0\0\4\8\0\0\0������̩\4\3\0\0\0�ө\4\6\0\0\0����ݩ\0043\0\0\0�������̆��ۆ�ˆ��͆��ć����̇�������������ڇ����ݩ\4\5\0\0\0���ͩ\4\5\0\0\0���ݩ\3\0\0\0\0\0\0�?\3\0\0\0\0\0\0\0\0\1\0\0\0\0\9\20 �\20�\20 jB\19\9\"�Q��4\6Q\23)y��]\30J\30�!�\19�9g��=E\0\9\20 0#�$��\0275\24i.'\0064\3g���[|\16#+i%e3���mP��Zw\11t\0253\8t\25���K�k#(Q\21A<\0\
v\25\31\9v\25�w�c�\3!7�vp8�_\6_G�\\5\28�\20��8\27\0 \8\6 ?>�f��m!�� i�\1\26\5ιZC���\"7��B� �=c�hY\1\1\8\8 C��r{M�\0nF�N�n�N�]�+�k�\1��{<G��\6���}\9zV4\18\20�\15:���\23\23\0\0\0l\9\9\9�\9I\9�\9\9\9��\9\8QII\8\30I\9��\0\0\0�\0\0\1��\0\0�\0\0\0��@\0\0\1\0\1@\1�\0�\1\0\0�\1�\1\1\2\1\0]�\0\2�@\1\2\0\1\0\1AA\1\0�@\1\2�\0\0\1\31\0�\0\1\7\21 ��0q�[a\8%�\21\25\9\8\16I\25�w6\29\23�N4���=3��\3�a�U���&\3�\12\9j\27\23\25R��I\1\0\0\0\0\0\0\7!\25\28<�V\6\0\0\0\4\5\0\0\0001<5 E\4\6\0\0\0001$') E\4\3\0\0\0>OE\4\11\0\0\0007**1e1$') E\3\0\0\0\0\0\0�?\4\2\0\0\0008E\1\0\0\0\12\9\20 \4�St\6\19�T�K{\28���V\24�}2�\0\9\20 e�TP-2�Z���T4��R@f�d\21�H}�\11�,��r�GzD\13\11t\0257\8t\25\26O�v@�l\9�{\14\9b�+o��an���$\30|�~\1\
v\25\25\9v\25\29�VT\0#\8\6 J\8�z�\25�VV�\26eҙZ\31���J\\�\14:���;@\\�!t��l���h\3\15\8\8 �t�<��rC�}\1w\14lg\15�WA(�TJt�w�;�qV4\18l.�p�0�\17�C1B,��yS0�\0��0˗B\30r��\127�E*Y|\0\0\0\23���З���W�ԗ\23��V����WVאח�V��֋����\22�VP���\22���KT��Ζ���V�VWT��M������VW���\22�V����ԗ\21��V���\16Ք�����\11U�����ӗ���\0�R�\16�����V�݂\0\1\24��\5\23\0\7��B�\0�\2\0\0\23�\1�\0\3�\1F\3B\0�\3�\4]�\0\1��\2\0ր\3\6\23@\9�\6\3B\0@\3\0\4\29�\0\1J\0�\4\0\3�\1A\3\3\0�@\3\6\0\3�\1E\3�\0�\3�\4�\3�\0\13DC\1]�\0\2�@\3\6\0\3�\1@\3\0\2��\3\0ր\3\6\23�\4��BA\0\0\3�\4݂\0\1\24@�\5\23�\1��\2�\1\1�\1\0F\3B\0�\3�\4]�\0\1��\3\0ր�\5\23@\1��\2�\1\6\3B\0@\3�\4\29�\0\1A�\2\0�@�\5b�\0\0�A�\127F\1D\0�\1\0\0]�\0\1[\1\0\0\23\0\8��\1�\1��\2\0��\1\3�A�\0�\1�\1\0\2\0\2AB\4\0�@�\3�\1\0\0\23\0\2��\1�\1\6\2B\0@\2�\2\29�\0\1A�\4\0�\2\0\3��\4\0���\3\23@\3��\1�\1\1\2\3\0�\0�\3�\1�\1\5\2�\0@\2�\2�\2�\0�BC\1\29�\0\2�\0�\3�\1�\1\0\2\0\2A�\3\0�@�\3�\0\0\1\31\0�\0\
\7\21 �&\6\1>N\20T�5EI\11\12!f\17�ns2\9E\20h\0040 ��D/\18\6\16I\25ܕ�\12_�!\24|\24\16X�\
�I\16\127�[d�\17O�v\5Y\2\0\0\0\0\0\1\1\8\7!\25b�[Cw�\1\21ٸ�\30\3� |�\28�\5��0��Q>\16�.\127\30\26�1\20\0\0\0\4\1\0\0\0�\4\7\0\0\0�������\4\4\0\0\0����\4\2\0\0\0��\4\6\0\0\0������\4\5\0\0\0�����\4\2\0\0\0��\4\2\0\0\0��\4\9\0\0\0���������\4\5\0\0\0�����\4\6\0\0\0������\4\2\0\0\0��\4\3\0\0\0���\3\0\0\0\0\0\0�?\4\4\0\0\0����\4\4\0\0\0����\4\13\0\0\0�������������\4\15\0\0\0���������������\4\9\0\0\0��������\4\4\0\0\0���\0\0\0\0\27pi\23�^q\29��61��\14H�z\
\16E�<2�H#\28P�OYP�]\24\0021�\15\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\17pi\23���8���>�\30o#\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\24pi\23=��Vp7\127{K��\14M\11�2�͐J\16\21�gO�b67��\13�\3�|(�;U\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\9\20 o�FO��wT�HD\8%��\25\24\27�)���|��G\20�\
V\24���j\16\1\9\20 \26\30}d��UM�.)O�3r\3c�&6���]\6��E�\15,;P\11t\0251\8t\25�KoMN\
v\25\31\9v\25�\25�nϹ\18\8�>vxm6G!��\\!�8N/��w:\0+\8\6 Xs�V(��\9\1\9\8\8 �5_R{V4\18��[\3��7H�de\20\0\0\0\20R\18R�\18RR\15�RS�ҒR��RR\11\1\0\0G\1A\0[\1\0\0\23@\1�G\1A\0\
A\1�GAA\1�\1�\1�\1\0\2]A�\1GAA\1�\1�\1�\1\0\0]A�\1\31\0�\0\0\7\21 ���\19W>�)\8\11\16I\25BLRa\22m�x�x�.�\13y\23�S�V�\7�t>\29�R���^�S B%(�\20\1\0\0\0\0\0\2\7!\25Q\0133J�fp\13��jn\6\0\0\0\4\8\0\0\0buaeybu\16\4\3\0\0\0cj\16\4\6\0\0\0`|ycd\16\0043\0\0\0?`byfqdu?fqb?tr?|ct?s\127}>q``|u>|ctytu~dyvyubc>`|ycd\16\4\23\0\0\0\\CQtfubdycubYtu~dyvyub\16\4\6\0\0\0gbydu\16\0\0\0\0\16pi\23���<���(\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\14\9\20 \"V\15\11`\14P'I��Jl%�F\26��`���R��CWE\8\9\20 �B�\2L\11t\0255\8t\25,x=+���\17yG�l�\\�\8��P y\
v\25\25\9v\25��\30\0#\8\6 ,^�\15\"=\\v�6�Hd�\22\"��01\11#\12?�\15�\26\3�J\"o,~]�ݨ\30\1\2\8\8 `��\29�3�)?\5\4[�\28�h8Y<pZ��;Q��;��\127GY\13�x���ahpV4\18�\26/\13s�\17\\���k�w\19\22.�b|g4�d\18h�4c`\127uI\0\0\0.h(h/(�h�hhh��hh5��i�hhh3hhh\127hn褨�h�hii\127(l�i)h�)�khjhk)�ih���i�ihh\127(i�\1A\0���\3\0\2\0\3A\2\2\0݁�\1�\1�\3�AB\0ǁ�\3\0\2\0\1@\2\0\3�A�\1�@\0\0c��\127���\0�@\0\1�\0\0\1\24\0�\1\23@\0��\0\0\0�\0\0\1�\0@\0�@�\1\0\1\0\0AA\3\0݀�\1�\0\0\0\23�\6�\21\1\0\1X�C\2\23\0\4�\1�\3\0U\1\0\1N��\2��\3\0!A\1�\12��\1��\1\1\29B�\1\12��\1�\2\4\0\29B�\1 \1�\127\12��\1�\1\0\1��\1\1\29A�\1\23�\0�\12��\1��C\1\29A�\1\12��\1\29A\0\1\6AD\0\31\1\0\1\31\0�\0\6\7\21 4�\14+��y>�a�\22�j?\\\11\4\16I\25�q[1�E�~o�\3[1O\4P�<>2\1\0\0\0\0\0\5\7!\25���y�AB\13x��a5��i\18\0\0\0\4\3\0\0\0,*E\4\5\0\0\0*5 +E\4\2\0\0\0007E\4\6\0\0\0),+ 6E\4\7\0\0\000617,+\"E\4\5\0\0\0#,+!E\4\2\0\0\0LE\4\4\0\0\00060'E\3\0\0\0\0\0\0\0@\4\6\0\0\0001$') E\4\7\0\0\0,+6 71E\4\6\0\0\0&)*6 E\3\0\0\0\0\0\0\0\0\4\2\0\0\0002E\3\0\0\0\0\0\0�?\4\6\0\0\00027,1 E\4\2\0\0\0OE\4\6\0\0\0#,761E\0\0\0\0\27pi\23Ɏ!\29.�x1�'�A�1\19\127�\22�{̕�@kLB\12f\18�W�K�,\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\8\9\20 \17�z^g\
\9\20 �=�\15�ދ\3´\20/�\11t\0257\8t\25�R(R�PXL-�\9)���J\15'\18W�OY*䍸Ne\
v\25\18\9v\25R�\3Z*��\17\0�0\6\17��\2��hI4x�\127z��\15�\26�sc|�*��\20\25\0!\8\6 �#~6�Ag\19���:\17\29\26.k�\6\24��#\25y�Ye�N�\13\2\2\8\8 \5��h�\3�<R\4�#��\13;\19T$\9\127�L���\5\"{6`\0291\25w�[{T�pV4\18��Zf\
ڰ+���S���/>RG+�<�cI�n#��\26V\15\0\0\0i��h���/����n�\0���\1�\0\0\0\23�\1���@\1@\1�\0�@�\1�\0A\1�@\0\1�\0�\0�\0\0\1\31\0�\0\3\7\21 ܴ\19J\6\9\16I\25yw@\16r��\4v\15�:�OG(\26~�\29�\12 ���5���F\1\0\0\0\0\0\3\7!\25)��r��<j\5\0\0\0\4\3\0\0\0\14\8g\4\5\0\0\0\8\23\2\9g\4\2\0\0\0\16g\4\6\0\0\0\16\21\14\19\2g\4\6\0\0\0\4\11\8\20\2g\0\0\0\0\21pi\23<��{to�6���I^q%\\��\21.L9>\30h��\1\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\20pi\23\28\26�\4r�V-�\22\26S��\\4�ݝX~S�6\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\15\9\20 c|�\0H�N\29���9��^[ʓ|:���1s\11\9\20 �g=N\12j�\18�\11t\0251\8t\25D��}�\
v\25\25\9v\25���e\0#\8\6 Pۜ\23E\8�\31\24�\30z\20��(��SO%�%\30ϻ�SӰ)\16\12��y�/�\22\1\14\8\8 g��d\12�X���y?\7+W���p$\16�zApV4\18���UR_�.6\22�[��*\1\15\\�i,~/*�:\31\20Q\24 \0%\0\0\0$AAA�\1AA�A�A@@AA�\1A@Y\1\1AV�A��AA@@�AA�@\0\1\23�\0���@\0�\0�\1\1A\1\0�@\0\1ƀA\0\1�\1\0݀\0\1\7\1�\1GAB\2��\2\0]�\0\1���\2\1\2\3\0�A�\1���\2\1B\3\0�A�\1���\2\1�\3\0�A�\1���\2\1�\3\0�A�\1�\1�\2�A\0\1\31\0�\0\
\7\21 \12��*��e���{\\яB)��\5���up\127�k�~\4U\9\6\16I\25@;b?�/.e�\25\19\14\5k�U^��S3��r\17Y�.\1\0\0\0\0\0\5\7!\25r��I��\31\31C*�G��]>\17\0\0\0\4\23\0\0\0\\\5\18\1\\\30\28\17\26\31\22\\>\22\23\26\18\\70:>s\3\0\0\0\0\0\0\0\0\4'\0\0\0\\\5\18\1\\\30\28\17\26\31\22\\>\22\23\26\18\\#\27\28\7\0287\18\7\18\\'\27\6\30\17\29\18\26\31\0s\4\3\0\0\0\28\0s\4\8\0\0\0\22\11\22\16\6\7\22s\0041\0\0\0\1\30S^\1\21S\\\5\18\1\\\30\28\17\26\31\22\\>\22\23\26\18\\#\27\28\7\0287\18\7\18\\'\27\6\30\17\29\18\26\31\0\\%As\4\8\0\0\0\1\22\2\6\26\1\22s\4\3\0\0\0\0\9s\4\8\0\0\0\0\2\31\26\7\22@s\4\5\0\0\0\28\3\22\29s\4*\0\0\0\\\5\18\1\\\30\28\17\26\31\22\\>\22\23\26\18\\#\27\28\7\0287\18\7\18\\#\27\28\7\28\0]\0\2\31\26\7\22s\4\5\0\0\0\22\11\22\16s\4'\0\0\0\23\22\31\22\7\22S\21\1\28\30S)277:':<=2?2  6'2''!:1&'6 s\4\31\0\0\0\23\22\31\22\7\22S\21\1\28\30S)2  6''<2?1&><!76!s\4\26\0\0\0\23\22\31\22\7\22S\21\1\28\30S)46=6!:02  6's\4\23\0\0\0\23\22\31\22\7\22S\21\1\28\30S),BE2  6' s\4\6\0\0\0\16\31\28\0\22s\2\0\0\0\
\9\20 �\23\24�ŮX��[<�\15\9\20 \\��|�R\16|\5�W\22�\30W>�jJ%�gxr�\11t\0251\8t\25p-(H�\
v\25\30\9v\25�m\17h��\16&��er\6\21\7u\19�jm�4US\0+\8\6 =�F\27��Ye\1\12\8\8 '\21corB�\
�\19�%�|M\26�\127V4\18��\18\30�/\11w!U�\21��nZ\
xUq��z7�F�V\27\0\0\0ωɉ��I�\8\9��I���\31I���\9��\5II\0�\0\1\1\23�\3��\1A\0�AA\3�\1�\2\1�\1\0���\1\24�A\3\23�\1��\1B\0�AB\3��\2\0\0\2\0\0A�\2\0�\2�\2ց�\3�A\0\1�@\0\0#��\127\31\0�\0\1\7\21 \4_�M�eT\21s5�\18\11\0\16I\0250O�[\1\0\0\0\0\0\3\7!\25b�W\3缟C\12\0\0\0\4\3\0\0\0��\4\6\0\0\0�����\4\4\0\0\0����\4\6\0\0\0������\4\7\0\0\0������\4\5\0\0\0����\4\3\0\0\0���\0\4\3\0\0\0���\4\8\0\0\0�������\4\8\0\0\0�ୠ�뭍\4\2\0\0\0��\0\0\0\0\20pi\23�0�u�Ѧ8��Snle\18I�4�c���\9\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\13\9\20 d�))�I�{���\5��\23\14\6\11\9\20 \2�Uf\18\31�7�\11t\0253\8t\25O��\21�q}g\4�\24�\
v\25\26\9v\25\0��k`�\1n\0,\8\6 \21[�V�\9\16�r\28^mB�\18�9�V\1\11\8\8 ]�d\20v��\0289�\0&�qV4\18\127`�\6:7\11\127\20\\\24uZ�PY��4(Х�pN��^6wL6W��?\20\0\0\0בё��Q�\16\17��Q���\7Q��]�\0\1���\0�\0\1\1\23�\1��\1A\0�AA\3��\1\0\0\2\0\0A�\1\0�\2�\2ց�\3�A\0\1�@\0\0#A�\127\31\0�\0\11\7\21 8\28�\28i��wD�\7`���2\13n\27_H��x\13kov\13U�J�_�f\11\7\16I\25#��!�\9�v\30s8p��\0254[CXM�x�x\1\0\0\0\0\0\11\7!\25�*/j\1\27�\30\22z�7�H�E�{w%P��6���:�\14�~�~)_�J�+\8\0\0\0\4\3\0\0\0oi\6\4\6\0\0\0vivch\6\4\4\0\0\0ju&\6\4\6\0\0\0johcu\6\4\3\0\0\0iu\6\4\8\0\0\0c~cesrc\6\4\8\0\0\0tk&+t`&\6\4\2\0\0\0)\6\0\0\0\0\26pi\23%�u\21�'�k\13�\11X]\18\0242Q$9cQ�\0198�\11�d^�TB\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\26pi\23�v\28[k�2\13By&\23�w8m���.т�\13��p]\30��b\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\11\9\20 �M�\12���%�\3\9\20 �\"�`\5�/)-;\26b��e\18��q7^\0051S�g�_d��w\11��9Vr\0180�\11t\0257\8t\25�_\0251v��l��+$/l�\3�\1�2,�Bm���/�\
v\25\31\9v\25�O#4�9Sk-\5Zz�¨pг&\26�\12\17!۞\9\0#\8\6 ���\29���/�\11�<�!Ljs�w\16�\6�e�\\fLb��\"��V\29Wb�\31\0\1\8\8 \12vP\21cCqYnj�2xf\26\11���\
�\27?\31��E/*\0152\14�\29�Qq|V4\18�@�<\14��PJ�|)\7F�6\25\0\0\0wq1q01qql�qp6�1q���q�qpq�\0\1�@A\1A�\1\0�@�\1�@A\1A�\1\0�@�\1�@A\1A\1\2\0�@�\1�@A\1AA\2\0�@�\1�@A\1A�\2\0�@�\1��B\1�@\0\1\31\0�\0\5\7\21 \26��C���G-��J\1p�\\��e�6�z�{r\25\6\0\16I\25C��\
\1\0\0\0\0\0\8\7!\25r`m\28���-tG�\28��\4<���0���1,\6v\21,�@c�#\25=\12\0\0\0\4\8\0\0\0��������\4\3\0\0\0���\4\8\0\0\0��������\4\5\0\0\0�����\4\29\0\0\0߆��߻��������ߛ���������ޔ��\4\5\0\0\0�����\4%\0\0\0������ж���З���Ч����Б�����ב������\0043\0\0\0������ж���Г���Ч����Б�����ל�������ݙ�����������\0043\0\0\0������ж���Л���Ч����Б�����ל�������ݙ�����������\4\17\0\0\0������ж���Й����\4\28\0\0\0������ж���Ѓ���������������\4\6\0\0\0������\0\0\0\0\20pi\23\17\11�\2�\27_lQ�2.�(XT\26��\8�d\\l\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\3\9\20 �8�\127S\127y\26w�W-}\4QVё�><�\127Zh�C-�$ 7G�>u\24�T\3v\3\9\20 �2�\24�q�K��T\29\28�k\8vz�{���\2�Kr'U��T���H}�\15j�\11t\0259\8t\0258��3��IykN\22aD:\9*2��r�\3�_�Ԏ0\27��%�<�_�\
v\25\28\9v\25�l?S\
A!6\14�\2\
���-\1 \8\6 �\
#A\23��\"���f.��1���\
��p\127\7\21�}:� (�p�\7\0\
\8\8 �9�*S�N/�|V4\18б^\25�u�\22\21޸'�K�\18\24\0\0\0����㢢�#⢢D����\"��Ǣ����\0\0�\0\0\0\21\1\0\0\26\0�\1\23�\2�\6A�\0\7�@\2@\1\0\0�\1�\1\29��\1@\1�\0�\1\0\2]�\0\1�@�\1�\0@\1\23@�\127�\0\0\1\31\0�\0\1\7\21 Y\24�Q��\5\2ȯW\7\3\16I\25Φm+�\4�7\2\0\0\0\1\2\0\0\4\7!\25a\19�~�E�m�'\\W0\9l,\11r\6Q\4\0\0\0\3\0\0\0\0\0\0�?\4\7\0\0\0\5\2\4\31\24\17v\3\0\0\0\0\0\0\0\0\4\5\0\0\0\20\15\2\19v\1\0\0\0\11\9\20 �\19�o�5\1\20\28\14\9\20 ��P*\22�Bk8��~'5�\1\27��\25���G9_MR�\11t\0254\8t\25�\24iz-?l8W$p\16\14\0024\22�\
v\25\27\9v\25H�\20:f^�\17�6�4\0.\8\6 ��{3��\"\\@\28\8o\127�\25\24�r�(�n\23�´[\1\9\8\8 \6��@\27}V4\18��T@�w\21<A�]R��~Vֺ\0\23\0\0\0\0[\27\27\12�\27�Z\27\27\27D\27\27\26\12\27\31�\2\27��\23�\0�A�\0\0_\0\0\1\23�\2�\25\0��\23�\0�A\0\1\0_\0\0\1\23�\1�\25\0��\23�\0�A�\1\0_\0\0\1\23@\0�A�\1\0_\0\0\1\31\0�\0\4\7\21 zޙ\0r�\127\26\27�\\$�=�R1�\23pߴ�\30\2\2\16I\25��\0���4���G\0\0\0\0\5\7!\25S\21�F�ʑ|\29�9\25�Oz\8\0\0\0\3\0\0\0\0\0\0\0\0\3\0\0\0\0\0\0n@\3\0\0\0\0\0\0\16@\3\0\0\0\0\0 l@\3\0\0\0\0\0\0\8@\3\0\0\0\0\0\0h@\3\0\0\0\0\0\0\0@\3\0\0\0\0\0\0�?\0\0\0\0\26pi\23]�A\8i�i\18��H\1HW�\31�X\30n+[pcN\7;`ٕ�.\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\16pi\23���4\25\127OD\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\
\9\20 p�F~l�\8$��\28�\
\9\20 ���h�p3\3�q�\13�\11t\0255\8t\25�5\21\31(Z�,fOF~�^�F�\17�W�\
v\25\30\9v\25�Av\24�\29�(�*�~��\7\"\12ׂx\15��t\0-\8\6 �\11�xpk\
u\0D�\5�<\0\0\8\8 %>�}T��j�\26\\^%��]�ì1R��fI��z�zl\16FrV4\18z�\19h��cC��>\15!�2��\16�\27*=�\127~y1\1qh\0��O���\17e\0\0\0@F\6FA\6\6F]FFFQ\6G�@F\6F\0F\6F\1\6�F\11ƆFL\6��Q�M�@�\6F\7FGF[�FG\1\6\7F\1ƇF\27��FǆGF\29FFFQ�@Ƈ�FFSG�F\7�FF�FCƀG\4F@\4\4FA�B\4@\2�\0�\2\0\3�\2\0\3\29\2\0\2݁\0\0�\1\0\0\23�\2��\1\0\1\6BB\0\7�B\4@\2�\0�\2\0\3�\2\0\3\29�\0\2�\0�\3�\1\0\1Z���\23�\0��@�\127\23\0\0��\0\3\0�\0\0\1\25���\23@\1��\0@\0\6\1B\0@\1\0\1\29�\0\1�\0��\23@\0��\0@\0ʀ��\1�\1\0A�\3\0�\0\0\0�\0@\0���\1\6\1B\0F\1D\0�\1@\0�A@\3]�\0\1�\1D\0�AD\0ǁ�\3�\1�\0��\0\0��D\3��\0\1V��\2\29\1\0\1�@\0\0��\0\0\1\1\5\0A�\0\0�\0\3��\1@\0�A�\3\1\2\5\0݁\0\1�\0�\3�\1\0\0\6BB\0\7�B\4@\2�\0�\2\0\1�\2\0\1\29�\0\2\22\0�\3�@�\127�\0B\0\0\1\0\0�\0\0\1�\0\0\0\31\0�\0\1\7\21 ���N`d�3���\9\12\11\16I\25���:��h\21�U\15/�\24�~6�?R���-�V\\|��:=u��\11\20IUZ\1\0\0\0\0\0\11\7!\25�5�r]��T0�S\127�Y�H('A8���\18���,k�$w�̨Ez�i=\22\0\0\0\4\5\0\0\0�����\4\5\0\0\0�����\3\0\0\0\0\0\0�?\4\8\0\0\0��������\4\3\0\0\0���\4\7\0\0\0�������\4\5\0\0\0�����\4\1\0\0\0�\4\9\0\0\0���������\4\7\0\0\0�������\4\4\0\0\0����\3\0\0\0\0\0\0\8@\4\2\0\0\0��\3\0\0\0\0\0\0\0\0\4\11\0\0\0�����������\4\11\0\0\0�����������\4\9\0\0\0���������\4\3\0\0\0���\4\5\0\0\0�����\4\8\0\0\0��������\3\0\0\0\0\0\0$@\4\7\0\0\0�������\0\0\0\0\21pi\23sL'?���%\20�0\4\20\14\28Q^�\0097ë�Rtr\24\5\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\3\9\20 9�\23Dϸ�:�!t,܇�t\\��\127\19#�k�g\3#\2Q�\15l_�\18��#oT\13\9\20 .�rY���dx�?U[\1�\14�\14t\0251\8t\25\14�y\1\26\13v\25\26\9v\25�S0'%άM\1#\8\6 ��~\6p��C\3�X\8\9\\�,��Iq�\18�Z�K\14H0��T�\16�\1\28\24&\12\1\2\8\8 �2\27.���\0[*�\15�U\1\26�\7�#]{C\31\6��,���\18��u\4�:�t'}V4\18*3(J.��z\12Q�\0188&�K\11�?Z:\1\0\0l'''/g'�a'g'�'''m���a'g'�'''m�'�a'g'�'''m���l'''�'g'�'''��'��'g'�g''�秥�'g'§''��'���f'�'''��'&?'e&0g+��g&'�'''!�e':&�'�g''���&�秣�'''!�e':&�'�g''�g�&��'���d��gc��'''��'�g''&��c'�'''�'&&0''�m��%��''\4&�X�'�'�'''0�%���%'�'�'&�%'�'&��&e'�fb$��',%''�f�&�g�X0�&�m�e�m�b��'e'�gb&��',&''�g�&mga�m'e�m��0�\17���f'�'''��\0\1\24\0G\1\23@\28��\0�\0��\2\0\1A\7\0A�\7\0�\1\0\0��\0\0�\0�\0\1A\3\0AA\7\0��\3\0�\1\0\0݀\0\0\5\1�\0A�\7\0�A\7\0�A\4\0&\2\0\0\29�\0\0E\1�\0�\1\8\0�A\7\0\1B\8\0f\2\0\0]�\0\0�\1�\0��\8\0\1\2\7\0A�\8\0�\2\0\0��\0\0�\1�\0\1\2\9\0A\2\7\0�B\9\0�\2\0\0݁\0\0Y�H\3\23@\0�\25���\23�\0�\6�I\0A�\9\0�B\3\0\29B�\1\4\2�\0\24�H\3\23\0\1���B\0�\0@\2�\5\0\2\0\5\23�\0���B\0�\0\0\2�\5@\2\0\5�\2�\0�\2\
\0\1\3\7\0@\3\0\4�\3\0\0��\0\0�\2�\0\1C\
\0A\3\7\0�\3�\4�\3\0\0݂\0\0\5\3�\0A�\
\0�C\7\0��\
\0&\4\0\0\29�\0\0E\3�\0�\3\11\0�C\7\0\1�\
\0f\4\0\0]�\0\0��\3\0��ō�\3B��CF������C\1�����������\2���\1��\3\1��\3���C\3���\0��\3\0\0��\3�@\0\0\7\25�B\0\23�\0���I\0��\12\0\1D\3\0�C�\1��\2\0�\3\0\0\1�\2\0�\3\1��\4B\0�DE\9Ǆ�\0\11\5\0\0�D�\1�C�\127\23�\24��\0\0\0\27\0\0\0\23@\0��\0\0\0\23\0\0���\7\0�\0�\0\1�\2\0AA\7\0��\3\0�\1\0\0݀\0\0\5\1�\0AA\3\0�A\7\0�A\4\0&\2\0\0\29�\0\0E\1�\0��\7\0�A\7\0\1B\8\0f\2\0\0]�\0\0�\1�\0�\1\8\0\1\2\7\0A�\8\0�\2\0\0��\0\0�\1�\0\1�\8\0A\2\7\0�B\9\0�\2\0\0݁\0\0Y�H\3\23@\0�\25���\23�\0�\6�I\0A�\9\0�B\3\0\29B�\1\4\2�\0\24�H\3\23\0\1���B\0�\0@\2�\5\0\2\0\5\23�\0���B\0�\0\0\2�\5@\2\0\5�\2�\0�\2\9\0\1\3\7\0@\3\0\4�\3\0\0��\0\0�\2�\0\1\3\
\0A\3\7\0�\3�\4�\3\0\0݂\0\0\5\3�\0AC\
\0�C\7\0��\
\0&\4\0\0\29�\0\0E\3�\0��\
\0�C\7\0\1�\
\0f\4\0\0]�\0\0��\3\0��ō�\3B��CF���E������C\1�����������\2���\1��\3\1��\3���C\3���\0��\3�\0\11\4\0\0�C�\0��\3�@\0\0\7��\0\0\8�\0��\0\1\0\8����@\1\0\8�\0���\1\0\8�����\1\0\8�\0��\0\2\0\8����@\2\0\8�\0���\2\0\8�����\2\0\8�\0�\31\0�\0\8\7\21 ^�N\25�&�\20�\\�@Π\31]կ?\29Ƹ�mz~iN^�4x�\4�5�l.#\21\9\16I\25�\28�A�\19�2�\5�'��{B\4>yB@[�Al�5fb��a\3\0\0\0\0\0\1\3\1\2\8\7!\25\16w\19y\12�2f�J�c�\14deV[�O\"~�-\17�N`c�lbZ��y=\0\0\0\4\
\0\0\00031 \1\29\7<;#T\4\13\0\0\0'=:381\0061'!8 T\4\12\0\0\0009! =8\0061'!8 T\4\13\0\0\0&185 1\0061'!8 T\4\7\0\0\0;$ =;:T\4\8\0\0\0;$ =;:'T\4\
\0\0\0;$ =;:\0068 T\4\5\0\0\0 -$1T\4\6\0\0\0 5681T\4\6\0\0\0#=0 <T\4\14\0\0\00031 \0077&11:\7=.1T\3\0\0\0\0\0\0�?\4\7\0\0\0<1=3< T\3\0\0\0\0\0\0\0@\4\7\0\0\0;?:591T\4\7\0\0\0��Ա��T\4\11\0\0\00075:718:591T\4\7\0\0\0��²��T\4\6\0\0\0$531'T\4\6\0\0\0$5=&'T\4\4\0\0\0:!9T\4\7\0\0\0=:'1& T\4\12\0\0\0$531:!9 -$1T\4\8\0\0\0000125!8 T\4\9\0\0\0$531 -$1T\4\6\0\0\0009!8 =T\4\8\0\0\0&1  -$1T\4\6\0\0\0' -81T\4\7\0\0\0:!961&T\4\7\0\0\0' &=:3T\4\13\0\0\0��β����ٳ��T\3\0\0\0\0\0\0\8@\3\0\0\0\0\0\0\16@\4\13\0\0\0!=7;:2=3z05 T\3\0\0\0\0\0\0\20@\3\0\0\0\0\0\0\0\0\3\0\0\0\0\0\0\24@\3\0\0\0\0\0\0^@\4\6\0\0\0001&&;&T\4J\0\0\0\1\29\0261#|}�������c�����ֲ����\1\29���������ű�ʲ��������������d���e���fT\3\0\0\0\0\0\0\28@\3\0\0\0\0\0\0 @\3\0\0\0\0\0\0\"@\4\1\0\0\0T\3\0\0\0\0\0\0$@\4\7\0\0\0 = 81'T\4\7\0\0\0007;:2=3T\4\7\0\0\0;&=1: T\4\6\0\0\0 =91&T\4\8\0\0\000637;8;&T\4\11\0\0\0006 :6?7;8;&T\4&\0\0\0��ν������������������������dT\4\8\0\0\0\1\29\0245618T\4\8\0\0\0\1\29\00650=;T\4\7\0\0\0\1\29\0170= T\4\8\0\0\0\1\29\23<17?T\4\8\0\0\0\1\29\23;96;T\4\11\0\0\0\1\29\23;96;\0068 T\4\12\0\0\0\1\29\23;96;\0068 'T\4\8\0\0\0\1\29\0299531T\4\7\0\0\0\1\29\7<;#T\12\0\0\0\13\9\20 ��B*�S8\13#�,\12v8*\7\1\9\20 ��\16X�<cqR�f���j\19,�X@��Y\\�V\\���3$\12t\0253\8t\25}�R-*�!{��$,\16\13v\25\17\9v\25��%D�GW/k��K�O�W.��\3*\4�_\5��\127�;�k܎�7\0*\8\6 \11�d~\9�X\0��r\0\14\8\8 ,��,�a�\0282�\25W��L;j&�t\7�|H�zV4\18\26\24p!9\127�{!\0\0\0�Ǉǁ��ǀG\7��������G�\6��G���\6��ǚ��\1\0\1�\2U\1\0\2\25@��\23\0\4�AA\1\0�\1\0\2��A\3��\1\0a�\2�F�A\0�\2B\0��\0\5]�\0\1\24\0�\4\23\0\1�F\2B\0��A\4��\2\2J��\1\23\0\0�`��\127\"�\0\0�\0�\127\31\0�\0\
\7\21 ��CU�\127'`\8�ii҂ePK\127L\12&�\14\28_O�\20\22ǣ;\11\8\16I\25E�ylE�F?�RoGJGvl�\1�*��\23\127Z��4ӭS)�zp\127\1\0\0\0\0\0\2\7!\25v��4�\6p,��\9D\9\0\0\0\4\6\0\0\0wfnut\7\4\
\0\0\0`bsRNTohp\7\4\13\0\0\0tni`kbUbtrks\7\4\9\0\0\0tsuTwkns\7\4\2\0\0\0+\7\3\0\0\0\0\0\0\0\0\3\0\0\0\0\0\0�?\4\9\0\0\0shirjebu\7\4\3\0\0\0X@\7\0\0\0\0\17pi\23t��g@\4�8�H�T\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\13\9\20 æ\28x\15��P0��T�#�~\22\8\9\20 ��%C\19\12t\0258\8t\25\9�E~ޜ\31{L��-�By\20V7*^��}\15\28��c�H�J\13\13v\25\18\9v\25kݽ2-�\31,�=tm��\6M��C'bY^P���\21A\
5G�b�g�U�p\0 \8\6 t\28F\9��\9Q��L[7�b\1�L�!�gB0\15�(\0�JQb��Vo\0\0\8\8 ���]�m�Vn>���\11��\21\2!��\28�w\18\27���e~~V4\18\16a�\24�\19���\24�U�e�I�:M:�hC\0\0\0x~>~8>>~9��~c~\127\127i�p�8�>~�\127~|�\127\127~#��\127~\127�|8??~��>~�\127�\127\127|\127~���\127��?}9��\2��\1\0�\1�\2\1�\1\0V\1\2\3�\1\2\0�\1\0\2΁�\3\1�\1\0��\4��BB\0��B\5�\2�\2\1�\1\0@\3�\4��\1\0\22�\3\6���\1X�B\5\23@\2��BA\0��@\0\0\3�\1A\3\1\0݂�\1\13��\4�\2�\5\13��\4\7\3\3\2�\2�\5���\127�AA\0��@\0\0\2�\1A\2\1\0݁�\1ǁ�\3��\1\3ǁA\2X�\1\3\23�\1��AA\0��@\0\0\2�\1A\2\1\0݁�\1ǁ�\3���\3\"�\0\0���\127\31\0�\0\3\7\21 �S\21\2\15\5\16I\25\25�`l��\19C�\9Z�;j=\1\0\0\0\0\0\8\7!\25z|l[?�=_-\26/\31�c�[3ӎA\23݅\14v\29�\30��,\31\11�\"|\12\0\0\0\4\6\0\0\0fw\127de\22\4\
\0\0\0qsbC_E~ya\22\4\12\0\0\0{cb\127zDseczb\22\4\9\0\0\0ebdEfz\127b\22\4\2\0\0\0:\22\4\3\0\0\0IQ\22\3\0\0\0\0\0\0�?\4\2\0\0\0V\22\3\0\0\0\0\0\0\0\0\4\7\0\0\0ebd\127xq\22\4\5\0\0\0p\127xr\22\0\0\0\0\0\16pi\23�u�*�y8~\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\8\9\20 v8�~k\13\9\20 \9q�D\31�Jv���\15>��O\7\12t\0251\8t\25��b\24<\13v\25\27\9v\25\20��~ż�8\12O\9\23\0 \8\6 �9�?�eBR\26L2\20¯�5r�Vt�4�4�\12�2O�V0��6(\0\15\8\8 �g\2Y���\
2\6�\2?\3<e� =\27B\22�AEP�\30�~V4\18��w\11o��^t\21�t:[5\27�V�.�6K\6W\0\0\0�ёї��іQ\17������Q�Q�\16��Q���\16��ьPQЖ�\16�W\16��\17�Q��S��LPQБ���W\16��\17�������LPQ�V\16��\23\16�����\3A\2\2\0݁�\1�\1�\3�A\2\0\21\2�\2\14BA\4AB\1\0�\1\13�ƂB\0\6�B\0F�@\0�\3�\1��\1\0]��\1GC�\6\7C\3\6݂\0\1\24��\5\23@\
���B\0\6�@\0@\3�\1��\1\0\29��\1\7CA\6MCA\5GC�\2�B\3\6�BA\5��\2\3��@\0\0\3\0\3A�\1\0݂�\1�\1�\5�B\2\0\21\3\0\3\14CA\6AC\1\0��\4�ƃB\0\6�B\0F�@\0�\4�\1��\1\0]��\1G��\8\7D\4\8݃\0\1\24��\7\23\0\2���B\0\6�@\0@\4�\1��\1\0\29��\1\7�A\8MDA\7GD\4\3�C\4\8���\127�A�\127\"�\0\0���\127\31\0�\0\5\7\21 ���\127��\9\5��\127l�5�\22\20G=q��\16,G�\17i\20\7\16I\25P�\5b�|h]��h:��\20\8o�\13�ğb\1\0\0\0\0\0\5\7!\25���fN\127Ym\3�zy7��K\12\0\0\0\4\6\0\0\0\27\
\2\25\24k\4\
\0\0\0\12\14\31>\"8\3\4\28k\4\13\0\0\0\25\14\7\
\31\0149\14\24\30\7\31k\4\9\0\0\0\24\31\0258\27\7\2\31k\4\3\0\0\0++k\3\0\0\0\0\0\0�?\4\2\0\0\0Gk\3\0\0\0\0\0\0\0@\4\2\0\0\0Hk\3\0\0\0\0\0\0\0\0\4\9\0\0\0\31\4\5\30\6\9\14\25k\4\3\0\0\0004,k\0\0\0\0\19pi\23F�\30;\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\15\9\20 NZ�{t�dr\1��6\14rW\26��g\2\26�\22.\11\11\9\20 <ٱIS;\127?�\12t\0255\8t\25�6�2E��[\
($bo�z\30�ݫ(�\13v\25\26\9v\25l-�E\6V;b\1-\8\6 �\6�\0045\28�:���2���)\1\1\8\8 ��\17XR�Fq\30L�9+��\"\\�G#b-T\\y\15�\30Ё�\21c��\18<yV4\18}5\2A�\0\0\0z<|<�<<<a�<=$|�<+|;�w<<<v�|��<}<�<<<�<==+<<�v��>��<<\31=�Cv|}����<���<�<�=%��=+�=���}<�<><:��<)=<>�<�==}><�|�=�||<��~=���<;��<�<�=<=�<�|�=+�\"�z<|<�<<<a�<=$��<+<,�E\0\0\1��\0\0�\0\3\0&\1\0\0]�\0\0�\0�\1�@\2\0\1�\2\0AA\3\0�\1\0\0��\0\0�\0�\1\1�\3\0A\1\3\0��\3\0�\1\0\0݀\0\0\5\1�\1A\1\4\0�\1\3\0�A\4\0&\2\0\0\29�\0\0E\1�\1��\4\0��\2\0\1�\4\0f\2\0\0]�\0\0�\1�\1�\1\5\0\1�\2\0AB\5\0�\2\0\0��\0\0��\1\0�AA��A\0�ʁ����\0��\1��ʁ\1��A��\24��\2\23@\0��\1G��\1Ǎ\6��\0\21\2\0\4\25\0\0\4\23�\1�\6�A\0A\2\2\0���\0�\2\0\5V��\4�B\2\0\29B�\1\6B@\0\7�B\4F��\0G\2�\4�\2�\3\29B�\1\23\0\13�F\0@\0�\0\0\0]�\0\1\24\0�\0\23�\11�E\0�\1��\0\0��\2\0\1A\3\0f\1\0\0]�\0\0�\0�\1�@\2\0\1\1\3\0A�\3\0�\1\0\0��\0\0�\0�\1\1�\3\0A\1\3\0�A\4\0�\1\0\0݀\0\0\5\1�\1A\1\4\0��\2\0��\4\0&\2\0\0\29�\0\0E\1�\1��\4\0��\2\0\1B\5\0f\2\0\0]�\0\0��\1\0�AA��\1\0��A����\0������A\1��\1��\24�D\2\23@\0��\1G��\1Ǎ�A@\0ǁ�\3\6��\0\7�@\4@\2\0\3�A�\1\31\0�\0\0\7\21 uD�&�\14�\
\11\11\16I\25�_@\22�EA=�,�U��dx���[�\
�~\22\0133Z[)�!�`�`o\7zL\4\0\0\0\0\0\1\1\0\2\0\1\11\7!\25�|�\27D�Y\127*��OK#�{�kW|??Ajo�5\13H-z�\5�d̜�\17\29\0\0\0\4\5\0\0\0\127r{n\11\4\6\0\0\0\127jign\11\4\4\0\0\0e~f\11\3\0\0\0\0\0\0�?\4\6\0\0\0{jbyx\11\4\6\0\0\0Gjing\11\4\6\0\0\0{jlnx\11\4\6\0\0\0nyydy\11\0044\0\0\0㤼헂힃⪾ힻ턙'^B헋⪾ힻ퓤\11\3\0\0\0\0\0\0\0@\4\7\0\0\0bexny\127\11\4\7\0\0\0e~finy\11\4\7\0\0\0x\127ybel\11\3\0\0\0\0\0\0.@\3\0\0\0\0\0\0\8@\4\5\0\0\0gnm\127\11\3\0\0\0\0\0\0\16@\4\8\0\0\0;';'9>>\11\3\0\0\0\0\0\0\20@\3\0\0\0\0\0\0�\3\0\0\0\0\0\0\24@\3\0\0\0\0\0\0\0\0\4\5\0\0\0\127ns\127\11\4\5\0\0\0xbqn\11\4\6\0\0\0jgble\11\4\6\0\0\0hdgdy\11\4\7\0\0\0ed|yj{\11\4\6\0\0\0|bo\127c\11\0\0\0\0\0\17pi\23��3z/N�$\14��Q\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\12\9\20 ���;5\"�<wp\4\26�f#\31$��n�\12\9\20 �v�\8*msW\"�8\8~�~v$��7\26\13t\0251\8t\25�8!T�\13v\25\30\9v\25r9�;\"�sNk�Y\20ϓ�i���\0088;nE\1!\8\6 헢*b��a�\1�Z$�\18F��\0252��@\25�J7l��$8\1\14\8\8 V�5(���tvo\
\24\3SYG\17�gcy��x�rV4\18�h'P�\31�He�\127b��\"\8P�\0124X�6\7\0�T�\4�o{\127\20\5r�\2i�\0\0\0۝ݝ\29����\29����]��\29�\29֝���]�\28\27�ܝ]���\0������\29�\29\28�?\29����b����\29\26\29]�[\29\\�H�\29��\29\29��\29�\29\27]ܝ\\����\28\\�����K�\28��ܟ�\0�\29�\27�ݝ\26\29ߜ[\29\\��\28]�Z�\28���\29�\0�\29�\27]ߝ\26�ޜZ�^��\28^�\23�\28��ݻ\29۝ݝ\29����\29���]^��]�\29؝��\28]��\\������\0]�\0\0�\0\0\1�@\2\0\1\1\4\0f\1\0\0��\0\0�\0�\1\1A\4\0A\1\4\0��\4\0�\1\0\0݀\0\0\5\1�\1A�\4\0��\3\0�\1\5\0&\2\0\0\29�\0\0E\1�\1�A\5\0��\3\0\1�\5\0f\2\0\0]�\0\0�\1�\1��\5\0\1\2\4\0A\2\6\0�\2\0\0��\0\0�\1�\1\1B\6\0A�\3\0��\0\0�\2\0\0݁\0\0\11\2\2\0\
B��\
BA�\
�\0�\
�\0�\
���\
�\1�\
\2��\
B\1�\24\0E\2\23@\0�\
�G�\
�ǎ\24\0F\3\23@\0�\
�Ǎ\
�G�F��\0U\2�\4\25\0�\4\23�\1�F�A\0�\2\2\0Ƃ�\0�\2�\5��\2\5�B\2\0]B�\1FB@\0G��\4���\0�\2\0\5�\2\0\4]B�\1F�B\0G\2�\4�BC\4ǂC\4J�\2\5\23\0\17�F\0@\0�\0\0\0]�\0\1\24\0�\0\23�\15�@\0\0\0�\0\0\1��\0\0\1\1\4\0f\1\0\0��\0\0�\0�\1\1A\2\0A\1\4\0��\4\0�\1\0\0݀\0\0\5\1�\1AA\4\0��\3\0�\1\5\0&\2\0\0\29�\0\0E\1�\1��\4\0��\3\0\1�\5\0f\2\0\0]�\0\0�\1�\1�A\5\0\1\2\4\0A\2\6\0�\2\0\0��\0\0�\1�\1\1�\5\0A�\3\0��\0\0�\2\0\0݁\0\0\11\2\2\0\
B��\
BA�\
�\0�\
�\0�\
���\
�\1�\
\2��\
B\1�\24\0E\2\23@\0�\
�G�\
�ǎ\24\0F\3\23@\0�\
�Ǎ\
�G�FB@\0G��\4���\0��@\5�\2\0\4]B�\1F�B\0G\2�\4�BC\4ǂC\4J�\2\5\31\0�\0\8\7\21 7\6\16\14�6q.3\29�j%��8\13\17?\16�\30sEI��~�\11YB�\15�^\9��j\12\9\16I\25�\14�\\_�2\19|3Vo0~�tb\25�Z�սR�yxm0O�\26\4\0\0\0\0\0\1\1\0\2\0\1\6\7!\25L�= oycڠ>!\19��Ep:�\0232��W\26�k\26 \0\0\0\4\5\0\0\0�����\4\6\0\0\0������\4\4\0\0\0����\3\0\0\0\0\0\0�?\4\6\0\0\0�����\4\11\0\0\0����������\4\6\0\0\0�����\4\6\0\0\0�����\0044\0\0\0p7/}\0040~\4\17~\13\16q9-~\13(}\30\29~\23\
}\29=�}%\11}\17\21��~\4\24}<?q9-~\13(~\0007�\3\0\0\0\0\0\0\0@\4\7\0\0\0������\4\
\0\0\0���������\4\13\0\0\0������������\4\3\0\0\0���\4\5\0\0\0����\4\7\0\0\0������\4\7\0\0\0�������\3\0\0\0\0\0\0\8@\4\2\0\0\0��\3\0\0\0\0\0\0\16@\3\0\0\0\0\0\0�\3\0\0\0\0\0\0\20@\3\0\0\0\0\0\0\0\0\3\0\0\0\0\0\0\24@\4\1\0\0\0�\3\0\0\0\0\0\0\28@\4\7\0\0\0������\4\7\0\0\0������\4\6\0\0\0������\4\6\0\0\0�����\4\7\0\0\0������\0\0\0\0\0\20pi\23�\11�\\��n\3��8a�\17\4k8\13�1��\26L\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\11\9\20 �љ}\20s'Wn\14\9\20 \22��;�K\27\16DW�\4+X�2_4\":�\0<\28�w�pA\13t\0255\8t\25�i){�(�\
^��M\3;�QC0Vi3\12v\25\29\9v\25A�g,S\30�\26D�B\"\5~X4U\24�;\1,\8\6 �\21�7� �\127I�U\29=��/�(�\6\1\
\8\8 �I\24k(��\4�|V4\18�(�507�\14f��\27.�\17:�\0\0\0���3����3����s���3�����s�25��s���.������3�32�\0173����L����343s�u3r�f�3��33��3�35s�r����2r�����e�2���.�3�5��43�u3r��2s�t�2���3�.�3���3���3����3���sq��s�3����2s��r��������3��6���r󱳲���ղ��.3\0\0�\0\0\1\1A\3\0A\1\3\0�\1\0\0݀\0\0\5\1�\1A�\3\0��\2\0��\3\0&\2\0\0\29�\0\0E\1�\1�\1\4\0�\1\3\0\1B\4\0f\2\0\0]�\0\0�\1�\1��\4\0\1\2\3\0A�\4\0�\2\0\0��\0\0�\1�\1\1\2\5\0A\2\3\0�B\5\0�\2\0\0݁\0\0\5\2�\1A�\5\0��\2\0��\5\0&\3\0\0\29�\0\0E\2�\1�\2\6\0��\2\0\1C\6\0f\3\0\0]�\0\0��\2\0�B\0��BA�������\0����\2\1��B����\1��B���\2\2�\24�E\4\23@\0���Ȑ��H�Ƃ�\0�\2�\5\25\0�\5\23�\1���A\0\1\3\2\0F��\0U\3�\6\22C\3\6AC\2\0�B�\1�B@\0ǂ�\5\6��\0\7\3\0\6@\3\0\5�B�\1\23\0\18�F\0@\0�\0\0\0]�\0\1\24\0�\0\23�\16�@\0\0\0�\0\0\1��\0\0\1\1\3\0f\1\0\0��\0\0�\0\0\1\1A\2\0A\1\3\0�\1\0\0݀\0\0\5\1�\1AA\3\0��\2\0��\3\0&\2\0\0\29�\0\0E\1�\1��\3\0�\1\3\0\1B\4\0f\2\0\0]�\0\0�\1�\1�\1\4\0\1\2\3\0A�\4\0�\2\0\0��\0\0�\1�\1\1�\4\0A\2\3\0�B\5\0�\2\0\0݁\0\0\5\2�\1A\2\5\0��\2\0��\5\0&\3\0\0\29�\0\0E\2�\1��\5\0��\2\0\1C\6\0f\3\0\0]�\0\0��\2\0�B\0��BA�������\0����\2\1��B����\1��B���\2\2�\24�E\4\23@\0���Ȑ��H��B@\0ǂ�\5\6��\0\7�@\6@\3\0\5�B�\1\31\0�\0\4\7\21 ���UMV\1\7�1瓙LR�vQ�/�<\14\7\16I\25U%X#\30`�%3a�m�\26�Oq~�@w�/\16\4\0\0\0\0\0\1\1\0\2\0\1\6\7!\25Ɩ\22|�M \20���;Q��{+)v1�@�k�ߣ\2$\0\0\0\4\5\0\0\0\26\23\30\11n\4\6\0\0\0\26\15\12\2\11n\4\4\0\0\0\0\27\3n\3\0\0\0\0\0\0�?\4\6\0\0\0\30\15\7\28\29n\4\5\0\0\0+\
\7\26n\4\6\0\0\0\30\15\9\11\29n\4\6\0\0\0\11\28\28\1\28n\0044\0\0\0��ً�ƈ�����ۈ�ދ�������B������;'����ɇ�ۈ�ވ��n\3\0\0\0\0\0\0\0@\4\7\0\0\0\7\0\29\11\28\26n\4\7\0\0\0\0\27\3\12\11\28n\4\7\0\0\0\29\26\28\7\0\9n\3\0\0\0\0\0\0\8@\3\0\0\0\0\0\0\16@\3\0\0\0\0\0\0.@\3\0\0\0\0\0\0\20@\4\5\0\0\0\2\11\8\26n\3\0\0\0\0\0\0\24@\4\8\0\0\0^B^B\\[[n\3\0\0\0\0\0\0\28@\4\8\0\0\0\
\11\8\15\27\2\26n\3\0\0\0\0\0\0 @\3\0\0\0\0\0\0�\3\0\0\0\0\0\0\"@\3\0\0\0\0\0\0\0\0\4\3\0\0\0\7\
n\4\7\0\0\0\30\28\1\3\30\26n\4\5\0\0\0\26\11\22\26n\4\7\0\0\0\5\12\26\23\30\11n\4\5\0\0\0\29\7\20\11n\4\6\0\0\0\15\2\7\9\0n\4\6\0\0\0\13\1\2\1\28n\4\7\0\0\0\0\1\25\28\15\30n\4\6\0\0\0\25\7\
\26\6n\0\0\0\0\0\23pi\23ʊ�V\1�%\7I��\127{�]b�\2�<\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\11\9\20 q��5'\0110\28�\12\9\20 Ӊ�a�6�\27KH�r���\5\19��!�\13t\0259\8t\25Y��o�\5�'�s�\0263�mElS�\21��nw��fe�֦\20�f�aj\12v\25\27\9v\25�\11�\2$�\2$�(\23\1!\8\6 ���'�A�Xb\16\8x���\28N�$:��\30U\31d�j���o\1\
\8\8 F�~)�J\14O�}V4\18%��Ak\17�X\17�3g���UĥhH\3\1\0\0ٟߟ\31����\31����_����\31ԟ���_�\30\25�ޟ_���\2������\31�\31\30�=\31����`����\31\25\31ޟX_^�����\2\31\31�\
���Y\31ޟ��]�ޞ��B\31\31�J�\31��_���_�\31\25\31ݟ^_������\2�\31�\25�ܟ\24\31ܞX_^���]�\21�\30�\25\31ޟX_^�����\2\31\31�\24_ߞ�\31\31\28\24\31_�Y_\\�J�\31��\31\31��\31�\31\25\31ݟ^����^\\�����I�\30�����\2�\31�\25�ߟ\24�۞Y_\\��\30_�X�\30���\31�\2�\31��_�\31ٟߟ\31����\31�\1\24��\0\23\0\25�E\0\0\1��\0\0��\4\0&\1\0\0]�\0\0�\0\0\1�\0\3\0\1�\4\0f\1\0\0��\0\0�\0�\1\1\1\5\0A�\4\0�A\5\0�\1\0\0݀\0\0\5\1�\1A�\5\0��\4\0��\5\0&\2\0\0\29�\0\0E\1�\1�\1\6\0��\4\0\1B\6\0f\2\0\0]�\0\0�\1�\1��\6\0\1�\4\0A�\6\0�\2\0\0��\0\0�\1�\1\1\2\7\0A�\4\0��\0\0�\2\0\0݁\0\0\6�A\0@\2�\0�\2\2\0\29��\1\21\2\0\4F�A\0�\2\0\1�\2\2\0]��\1U\2�\4X@\2\4\23�\0�\6�B\0A�\2\0�\2\3\0\29B�\1\11\2\2\0F�A\0�\2�\0�\2\2\0]��\1G��\4\
B��\
BA�\
���\
�\
�\1�\
�\
\2\1�\
B��\24�E\2\23@\0�\
�Ȑ\
�H�F�H\0\24��\4\23@\0�\
�H�\
�ȏF��\0U\2�\4\25\0�\4\23�\1�F�B\0�\2\4\0���\0�\2�\5��\2\5�\2\3\0]B�\1FB@\0GB�\4���\0�\2\0\5�\2\0\4]B�\1FBC\0G��\4�BB\4J��\0\23@\22�F\0@\0�\0\0\0]�\0\1\24��\0\23\0\21�@\0\0\0�\0\0\1��\0\0\1�\4\0f\1\0\0��\0\0�\0�\1\1\1\3\0A�\4\0�A\5\0�\1\0\0݀\0\0\5\1�\1A\1\5\0��\4\0��\5\0&\2\0\0\29�\0\0E\1�\1��\5\0��\4\0\1B\6\0f\2\0\0]�\0\0�\1�\1�\1\6\0\1�\4\0A�\6\0�\2\0\0��\0\0�\1�\1\1�\6\0A�\4\0��\0\0�\2\0\0݁\0\0\6�A\0@\2�\0�\2\2\0\29��\1\21\2\0\4F�A\0�\2\0\1�\2\2\0]��\1U\2�\4X@\2\4\23�\0�\6�B\0A�\2\0�\2\3\0\29B�\1\11\2\2\0F�A\0�\2�\0�\2\2\0]��\1G��\4\
B��\
BA�\
���\
�\
�\1�\
�\
\2\1�\
B��\24�E\2\23@\0�\
�Ȑ\
�H�F�H\0\24��\4\23@\0�\
�H�\
�ȏFB@\0GB�\4���\0��@\5�\2\0\4]B�\1FBC\0G��\4�BB\4J��\0\31\0�\0\6\7\21 ;H�p�n�\13\\�|$��]h\12\3\16I\0250�#9�=�I\4\0\0\0\0\0\1\1\0\2\0\1\7\7!\25\28�\12<�\19�mY�67Xy�~���\21�#\3\16$\0\0\0\4\5\0\0\0���ҷ\4\6\0\0\0����ҷ\4\4\0\0\0��ڷ\3\0\0\0\0\0\0�?\4\6\0\0\0����ķ\4\14\0\0\0������������Ƿ\4\9\0\0\0�������÷\4\3\0\0\0�ӷ\4\2\0\0\0��\4\5\0\0\0���÷\4\6\0\0\0����ŷ\4<\0\0\0�R8/^08^#._\24\24�_\24\0P\22\25_\25\19R\19-^7>Q\0221P-3R8/^08S\0159^7>^\22\14^08P,\15R';�\3\0\0\0\0\0\0\0@\4\
\0\0\0����������\4\12\0\0\0����������÷\4\6\0\0\0����ķ\0044\0\0\0_\24\0R+\31Q+>Q\"?^\22\2Q\"\7R12Q8%R2\18�R\
$R>:��Q+7R\19\16^\22\2Q\"\7Q/\24�\4\7\0\0\0�����÷\4\7\0\0\0�����ŷ\4\7\0\0\0�����з\3\0\0\0\0\0\0\8@\4\2\0\0\0��\3\0\0\0\0\0\0\16@\3\0\0\0\0\0\0�\3\0\0\0\0\0\0\20@\3\0\0\0\0\0\0\0\0\3\0\0\0\0\0\0\24@\4\1\0\0\0�\3\0\0\0\0\0\0\28@\4\7\0\0\0�����÷\4\7\0\0\0�����ķ\4\6\0\0\0����ҷ\4\6\0\0\0����߷\4\7\0\0\0�����Ƿ\0\4\6\0\0\0���Å�\0\0\0\0\23pi\23�ݝ2F\
(J�r\13L�A@\29\5��9\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\9\20 ��F>�\22!\0097�<\01891y\5e�%\20�\3\26\31\4h\8�;Nc]\127E;�\15\9\20 ��7)��\
�G�\11Cw�L\26��$E��%�\13t\0256\8t\25�\20�4#��\0117ϗ.ݯ�?r��|���6�\12v\25\30\9v\25&\31�_�J\27\15t$\0H�\9�R�\31�Ub\3�O\1,\8\6 ���vk:a\12��u\
�(�\28\127\19e&\1\13\8\8 �d\19\0ܒ�a,e.\12�+v\5b1�\
�}V4\18���W��Q;r� 7�];\22�\8�o�\0\0\0�Ȉ�H��ȕH��Ј\8��H�H���Ȃ\8�INȉ�\8���U������H�HI�jH����7����HOH\8�\14H\9�\29�H��HH��H�HN\8��\9����I\9�����\30�I�ɉ��U�H�N���OH��\14H\9��I\8�\15�I���H�U�H�N\8��Oȋ�\15�\11��I\11�B�I�߈ՀF\0@\0�\0\0\0]�\0\1\24��\0\23@\15�E\0\0\1��\0\0�\0\4\0&\1\0\0]�\0\0�\0\0\1�@\2\0\1\1\4\0f\1\0\0��\0\0�\0�\1\1A\4\0A\1\4\0��\4\0�\1\0\0݀\0\0\5\1�\1A�\4\0��\3\0�\1\5\0&\2\0\0\29�\0\0E\1�\1�A\5\0��\3\0\1�\5\0f\2\0\0]�\0\0��\1\0�A���AA���\0������A\1��\1��\24\0E\2\23@\0���F���ƌƁ�\0�\1�\3\25\0�\3\23�\1���A\0\1\2\2\0F��\0U\2�\4\22B\2\4AB\2\0�A�\1�A@\0ǁ�\3\6��\0\7\2\0\4@\2\0\3�A�\1��B\0�\1�\3\7BC\3G�C\3�A\2\4\23�\12�F\0@\0�\0\0\0]�\0\1\24\0�\0\23@\11�@\0\0\0�\0\0\1��\0\0\1\1\4\0f\1\0\0��\0\0�\0�\1\1A\2\0A\1\4\0��\4\0�\1\0\0݀\0\0\5\1�\1AA\4\0��\3\0�\1\5\0&\2\0\0\29�\0\0E\1�\1��\4\0��\3\0\1�\5\0f\2\0\0]�\0\0��\1\0�A���AA���\0������A\1��\1��\24\0E\2\23@\0���F���ƌ�A@\0ǁ�\3\6��\0\7�@\4@\2\0\3�A�\1��B\0�\1�\3\7BC\3G�C\3�A\2\4\31\0�\0\6\7\21 $-�D���/\7'�?���{\
\11\16I\25-Fp\31�\0�\
\25W]q\5Pnr\127 m`|Z\19Aw��\3T�7W�tM��(\14\4\0\0\0\0\0\1\1\0\2\0\1\5\7!\25g��s��\6!�q\16tC;�U\27\0\0\0\4\5\0\0\0�����\4\6\0\0\0������\4\4\0\0\0����\3\0\0\0\0\0\0�?\4\6\0\0\0������\4\9\0\0\0���������\4\6\0\0\0������\4\6\0\0\0������\0044\0\0\0<{c1H|2H]2A\\=ua2Ad1RQ2[F1Qq�1iG1]Y��2HT1ps=ua2Ad2L{�\3\0\0\0\0\0\0\0@\4\7\0\0\0�������\4\
\0\0\0����������\4\13\0\0\0�������������\4\3\0\0\0���\4\5\0\0\0�����\4\7\0\0\0�������\4\7\0\0\0�������\3\0\0\0\0\0\0\8@\4\2\0\0\0��\3\0\0\0\0\0\0\16@\3\0\0\0\0\0\0�\3\0\0\0\0\0\0\20@\3\0\0\0\0\0\0\0\0\4\7\0\0\0�������\4\7\0\0\0�������\4\6\0\0\0������\0\0\0\0\0\22pi\23;��y�lf`|h�Ch\16�\
\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\
\9\20 �k�I\29[�I [C\4�\15\9\20 (�4rzP�\18t\15�?���\16M�iS���Cx\14t\0252\8t\25��\25Q}scb\24\15v\25\26\9v\25��d`ǥzF\1*\8\6 %2.u���\14��\11\30\1\13\8\8 �/$~��A?de\3{!��y�j\\\\:~V4\18uCm\23�wS\127_�}\31��,a�Җ\3v��\8�\0\0\0|:z:�:::g�:;\"z�:-�0�q:::p�z��:{:�:::�:;;-::�p��8��::\25;�Epz{���{:��{;�:x:={�:{�8:���:,�;8�:�;�zy:�:�:;�9:���;��z;p�:����:���:�:�;#��;-�;��:~:�z>:<��:/;:8�:�;;�>:�z�;�zz:��~;���:=��:�:�;:;�:�z�;-z\22�|:z:�:::g�:;\":�:-�,�\127::;��::�z?:&\1\0\0]�\0\0�\0\0\1��\4\0\1A\5\0f\1\0\0��\0\0�\0\0\1\1�\5\0AA\5\0�\1\0\0݀\0\0\5\1\0\1A�\5\0�A\5\0�\1\0\0\29�\0\0E\1�\1�\1\6\0�A\5\0\1B\6\0f\2\0\0]�\0\0�\1�\1��\6\0\1\2\5\0A�\6\0�\2\0\0��\0\0�\1�\1\1\2\7\0A\2\5\0�B\7\0�\2\0\0݁\0\0\6BC\0@\2�\0��\3\0\29��\1\21\2\0\4X�D\4\23�\0�\6\2D\0A�\7\0��\4\0\29B�\1\11\2\2\0FBC\0�\2�\0��\3\0]��\1G��\4\
B\2�\
BA�\
���\
\2��\
�\1�\
B��\
�\
�\1�\24�F\3\23@\0�\
�H�\
�H�F��\0U\2�\4\25\0�\4\23�\1�F\2D\0�B\4\0���\0�\2�\5��\2\5��\4\0]B�\1FB@\0G��\4���\0�\2\0\5�\2\0\4]B�\1F�A\0G��\4�BB\4��\2\0\7�B\4�\2\3\5J��\0\23\0\20�F\0@\0�\0\0\0]�\0\1\24@�\0\23�\18�@\0\0\0�\0\0\1��\0\0\1A\5\0f\1\0\0��\0\0�\0\0\1\1�\4\0AA\5\0�\1\0\0݀\0\0\5\1\0\1A�\5\0�A\5\0�\1\0\0\29�\0\0E\1�\1��\5\0�A\5\0\1B\6\0f\2\0\0]�\0\0�\1�\1�\1\6\0\1\2\5\0A�\6\0�\2\0\0��\0\0�\1�\1\1�\6\0A\2\5\0�B\7\0�\2\0\0݁\0\0\6BC\0@\2�\0��\3\0\29��\1\21\2\0\4X�D\4\23�\0�\6\2D\0A�\7\0��\4\0\29B�\1\11\2\2\0FBC\0�\2�\0��\3\0]��\1G��\4\
B\2�\
BA�\
���\
\2��\
�\1�\
B��\
�\
�\1�\24�F\3\23@\0�\
�H�\
�H�FB@\0G��\4���\0��@\5�\2\0\4]B�\1F�A\0G��\4�BB\4��\2\0\7�B\4�\2\3\5J��\0\31\0�\0\11\7\21 ڃ�u�\8G\27��Z\14~Ca\6=��nY�TRׄv\4�/�?���4\13\0\16I\25�\14/ \4\0\0\0\0\0\1\1\0\2\0\1\6\7!\25 ԭP�@]\21��\30\
Դ�n�TK`G�B\8nV�-$\0\0\0\4\5\0\0\0����\4\6\0\0\0�����\4\4\0\0\0���\3\0\0\0\0\0\0�?\4\6\0\0\0������\4\9\0\0\0���������\4\
\0\0\0���������\4\13\0\0\0������������\4\5\0\0\0����\4\5\0\0\0����\4\3\0\0\0�Ɔ\4\5\0\0\0����\4\3\0\0\0��\4\9\0\0\0��������\4\2\0\0\0��\4\6\0\0\0������\4\6\0\0\0�����\0044\0\0\0n)1c\26.`\26\15`\19\14o'3`\0196c\0\3`\9\20c\3#�c;\21c\15\11��`\26\6c\"!o'3`\0196`\30)�\3\0\0\0\0\0\0\0@\4\7\0\0\0������\4\7\0\0\0������\4\7\0\0\0������\3\0\0\0\0\0\0\8@\3\0\0\0\0\0\0\16@\3\0\0\0\0\0\0\20@\4\2\0\0\0��\3\0\0\0\0\0\0\24@\3\0\0\0\0\0\0�\3\0\0\0\0\0\0\28@\3\0\0\0\0\0\0\0\0\4X\0\0\0�c\9\30o\1\9o\18\31n))�n)1a'(n(\"n\7\18c\12.`'\0`\26\15b>\"b>,c\9\30o\1\9�c\9 c\"\16b>\6b>,c\9\30o\1\9b><c\0035n\7\18`'\0a\28\2c\9\30o\1\9�\4\7\0\0\0������\4\7\0\0\0�������\4\7\0\0\0������\4\6\0\0\0�����\0\0\0\0\0\24pi\23iZ\29\2\23�W\
���}���W�\4�!��\13}X�yw ��\2?Ҥ\0Η>\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\13\9\20 \28u�m�:xw���v���y0\12\9\20 ww�5�P�\25.��|�t\27\17g��\16O\14t\0251\8t\25�o�dQ\15v\25\26\9v\25��T0�\0305b\1#\8\6 Ƹkh��\19\2p�BR�\\P\0��G7��T\
OX�n+V�L0�\31v؀�;\1\
\8\8 X٥u\23��&�pV4\18�� \30��\14\16s\24t]a'$y7\30�\20�N\19Zx�\18f��\17�\0\0\0����;����;����{����;𻻻�{�:=���{���&������;�;:�\25;����D����;<;{�};z�n�;��;;��;�;={��z����:z�����m�:�����&�;�=���<;��};z��:{�|�:���;�&�;��{�;�����\0\0\0]�\0\1\24��\0\23\0\14�E\0\0\1��\0\0�\0\3\0&\1\0\0]�\0\0�\0\0\1�@\2\0\1\1\3\0f\1\0\0��\0\0�\0�\1\1A\3\0A\1\3\0��\3\0�\1\0\0݀\0\0\5\1�\1A�\3\0��\2\0�\1\4\0&\2\0\0\29�\0\0E\1�\1�A\4\0��\2\0\1�\4\0f\2\0\0]�\0\0��\1\0�A���AA���\0������A\1��\1��\24\0D\2\23@\0��\1F��\1ƋƁ�\0�\1�\3\25\0�\3\23�\1���A\0\1\2\2\0F��\0U\2�\4\22B\2\4AB\2\0�A�\1�A@\0ǁ�\3\6��\0\7\2\0\4@\2\0\3�A�\1\23@\11�F\0@\0�\0\0\0]�\0\1\24\0�\0\23\0\
�@\0\0\0�\0\0\1��\0\0\1\1\3\0f\1\0\0��\0\0�\0�\1\1A\2\0A\1\3\0��\3\0�\1\0\0݀\0\0\5\1�\1AA\3\0��\2\0�\1\4\0&\2\0\0\29�\0\0E\1�\1��\3\0��\2\0\1�\4\0f\2\0\0]�\0\0��\1\0�A���AA���\0������A\1��\1��\24\0D\2\23@\0��\1F��\1Ƌ�A@\0ǁ�\3\6��\0\7�@\4@\2\0\3�A�\1\31\0�\0\1\7\21 �K�#R��\6\4tb\9\
\0\16I\25Q>Q7\4\0\0\0\0\0\1\1\0\2\0\1\11\7!\25)f�\4\23��\31B<�m�'�V�S\13 @��$E�\27a&��\14k\23�qu�;W\25\0\0\0\4\5\0\0\0DI@U0\4\6\0\0\0DQR\\U0\4\4\0\0\0^E]0\3\0\0\0\0\0\0�?\4\6\0\0\0@QYBC0\4\9\0\0\0s_]R_r_H0\4\6\0\0\0@QWUC0\4\6\0\0\0UBB_B0\0044\0\0\0؟�լ�֬�֥�ّ�֥�ն�ֿ�յ�\28Ս�չ�ey֬�Ք�ّ�֥�֨�0\3\0\0\0\0\0\0\0@\4\7\0\0\0Y^CUBD0\4\7\0\0\0^E]RUB0\4\7\0\0\0CDBY^W0\3\0\0\0\0\0\0\8@\4\2\0\0\0\0000\3\0\0\0\0\0\0\16@\3\0\0\0\0\0\0�\3\0\0\0\0\0\0\20@\3\0\0\0\0\0\0\0\0\4\3\0\0\0YT0\4\11\0\0\0TQDQc_EBSU0\4\7\0\0\0CU\\USD0\4\7\0\0\0^_GBQ@0\4\6\0\0\0GYTDX0\0\0\0\0\0\26pi\23�=�H͜�L\22��q3\12�aB�W0\18h�\15���q�\3�\13\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\1\9\20 | ;9N�Cw͝�5�(!7-��0��|\24�\27�F�3\8C�\13\9\20 \4C�\
�Z�T֘9X�\11\20c�\14t\0259\8t\0250\17\28<G(e\0188=�k�*�;.R�1\23\18\6\24�\
\27G7�0q�\21�E�\15v\25\29\9v\25��qj��a���\29�с\24�l�D\1,\8\6 ;�Q�[�;\127}�\2\5\27�\8\0X�l\1\1\8\8 �6yO؋�/�|?+J~y*��a:|��\127 \23�\2��u\29\15��\"�yV4\18G�c\14�\0\0\0��Ɔ\6����\6����F��Ɓ\6͆���F�\7\0�ǆF���\27������\6�\6\7�$\6����y����\6\1\6F�@\6G�S�\6��\6\6��\6�\6\0FǆG����\7G�����P�\7��Ǆ�\27�\6�\0�Ɔ\1\6ć@\6G��\7F�A�\7���\6�\27�\6��Ɲ\6��Ɔ\6�\0\0]�\0\1\24��\0\23@\14�E\0\0\1��\0\0�\0\3\0&\1\0\0]�\0\0�\0�\1�@\2\0\1\1\3\0AA\3\0�\1\0\0��\0\0�\0�\1\1�\3\0A�\2\0��\0\0�\1\0\0݀\0\0\5\1�\1A�\3\0��\2\0�\1\4\0&\2\0\0\29�\0\0E\1�\1�A\4\0��\2\0\1�\4\0f\2\0\0]�\0\0��\1\0�AA��A����\0������A\1��\1��\24\0D\2\23@\0��\1F��\1ƋƁ�\0�\1�\3\25\0�\3\23�\1���A\0\1\2\2\0F��\0U\2�\4\22B\2\4AB\2\0�A�\1�A@\0ǁ�\3\6��\0\7\2\0\4@\2\0\3�A�\1\23�\11�F\0@\0�\0\0\0]�\0\1\24\0�\0\23@\
�@\0\0\0�\0�\1��\0\0\1\1\3\0AA\3\0�\1\0\0��\0\0�\0�\1\1A\2\0A�\2\0��\0\0�\1\0\0݀\0\0\5\1�\1A�\3\0��\2\0�\1\4\0&\2\0\0\29�\0\0E\1�\1��\3\0��\2\0\1�\4\0f\2\0\0]�\0\0��\1\0�AA��A����\0������A\1��\1��\24\0D\2\23@\0��\1F��\1Ƌ�A@\0ǁ�\3\6��\0\7�@\4@\2\0\3�A�\1\31\0�\0\6\7\21 \22U�a_�i&�]�ANڱR\
\11\16I\25b�\22!ڤ#=���M1a\22?�v�U4_�\18�@c\12�hb'\6��Nb�J\15\4\0\0\0\0\0\1\1\0\2\0\1\7\7!\25\6\19=;ܽ�*���\127ߞ�j�:�U�83*\25\0\0\0\4\5\0\0\0���Ϋ\4\6\0\0\0����Ϋ\4\4\0\0\0��ƫ\3\0\0\0\0\0\0�?\4\6\0\0\0����ث\4\6\0\0\0����Ϋ\4\6\0\0\0����ث\4\6\0\0\0����٫\0044\0\0\0C\4\28N7\3M7\"M>#B\
\30M>\27N-.M$9N.\14�N\0228N\"&��M7+N\15\12B\
\30M>\27M3\4�\3\0\0\0\0\0\0\0@\4\7\0\0\0�����߫\4\7\0\0\0�����٫\4\7\0\0\0�����̫\4\7\0\0\0�����٫\3\0\0\0\0\0\0\8@\3\0\0\0\0\0\0\16@\3\0\0\0\0\0\0�\3\0\0\0\0\0\0\20@\3\0\0\0\0\0\0\0\0\4\4\0\0\0��ȫ\4\6\0\0\0����ū\4\6\0\0\0����Ϋ\4\7\0\0\0�����۫\4\6\0\0\0����ë\0\0\0\0\0\19pi\23\22\18�U\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\13\9\20 �+\22\15@�4\8\12&�\13�ԇ\21�\14\9\20 \17`�_�,\16a&p�bbE�1E��5�˓=�ڞ8�\14t\0251\8t\25���v�\15v\25\31\9v\25%�\11\19�N\15e�HL'��9!�US\11�\24\11T���v\0#\8\6 \
�E\17\27׽{k��0���bG!� Z��cw�\4|�L�/���k���\9\1\11\8\8 \18��g\"��\28��\127%�yV4\18��\18W/\0\0\0ÅŅ\4Ņ��\5��\2\5E�BEń��\5�X\5������Äą\3\4ąE�\5�\24D�\1J���\0\1\0\3\24�A\2\23�\5�F\1B\0�\1A\0�AA\3]\1\1\1\23@\0��BB\0�B\2\4b�\0\0���\127F\1A\0G��\2]A�\0F\1A\0G��\2]A�\0F\1A\0G\1�\2]A�\0\24@C\0\23@\2�A�\1\0_\1\0\1\23�\1�\24@C\0\23�\0�AA\3\0_\1\0\1\23@\0�F�C\0]A�\0\31\0�\0\8\7\21 8�y=~��\15�c�8\25b�3\6�jU#S�Kϰ\14\25�\9�|�J�l[\6b$\11\4\16I\25P2�c�VsVt�\7bk\9�_\20��\6\2\0\0\0\0\0\1\1\0\7!\25�*}\0\15\0\0\0\4\8\0\0\0��������\4\3\0\0\0���\4\5\0\0\0�����\4\7\0\0\0�������\4\
\0\0\0����������\4\7\0\0\0�������\4\7\0\0\0�������\3\0\0\0\0\0\0�?\4\6\0\0\0������\4\3\0\0\0���\4\7\0\0\0�������\4\8\0\0\0��������\4\
\0\0\0����������\3\0\0\0\0\0\0\0\0\4\9\0\0\0���������\0\0\0\0\22pi\23m/�@�wu0\9L@V��FJ\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\24pi\23\28�\13>\19x7g�\26u\27�|�\6\\y\29gw�r���\5�F�$��9\2�Y<>\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\1\9\20 y,�{1��b�m)\6��r\24\16�^zF�'3A�\17r3�\
�\3\9\20 \7��\0271�{*�4�N�\30O\12\24��\\�=�\21��G\31�6Ksq\8(M���%�\14t\0252\8t\25٪3V�L�A�\15v\25\16\9v\25���!4��\"��\11K���S�\25e7�\3�R�w�s(F\0133\0/\8\6 Z��y�2�%��p\20�+�!�s�7l�m\31\4\14\8\8 \4\28�\27s�8;���u�P�j�ȇGԅ�R�rV4\18��\4F7��Mp1�\12�q4\17B�#�}$N�\12f8�5�E&8�p\30�q\3.\0\0\0�͌��\13L�J���KM��QML�\12����\14��\26�N��΍��NL̍���L΀\3\22�\2\4e\2\0\0X�A\0\23@\1�X��\0\23�\0�X�A\1\23@\0�\24��\1\23�\1���\1\0��\1\0\14\3B\2�\0�\2�\0\0\6@\0�\5\0\0\0\5�BB\0�\2�\3\0\3\0\0@\3�\0�\3\0\1�\3�\1�B\0\3��B\0�\2�\3�B\0\1��B\0�\2\3\0�B\0\1�\2�\4�\2\0\4�B\0\1\31\0�\0\4\7\21 �Q`(ϩ\"V�,\13��m[�G�\11B��\6\16\9\16I\25��. \22��(�>�8\22ל?���s�Z�T���z]��i\1\0\0\0\0\0\0\7!\25�J]B\13\0\0\0\4\14\0\0\0��������������\4\3\0\0\0��\4\5\0\0\0�����\4\5\0\0\0�����\4\9\0\0\0��������\4\6\0\0\0���궙\0\3\0\0\0\0\0\0\0\0\3\0\0\0\0\0\0�?\4\9\0\0\0��������\4\17\0\0\0�����������������\4\7\0\0\0������\3\0\0\0\0\0\0I@\1\0\0\0\3\9\20 [r�Jȃ\15\5��t{���r�E_es��\11�Ј%g�&4�\3{\14ϛI\1]\0\9\20 \"�\7Nҡh\"\4�\8S<��i�g�b�[�\8��\24+\31��?�3�>�\14t\0259\8t\25\8�O*L?MP�֙\17(\22�\127���Q�O>e��?W���\25���d�\15v\25\30\9v\25�$\1\31aS4`�)�\20,j`\4���k��W:\0+\8\6 [�iz���;\1\
\8\8 ��\11r�`�\9UqV4\18\0155�s\9_�\7�\13�M\14��\30(Z^G)A�\12�\15b80A�qu��\\\5\0\0\0\19U\21U\18@�\0�\0�\0]@\0\1\31\0�\0\
\7\21 YW�q�#�.\0316:/�:�H�ĚH���\19���j7�g\3\8\16I\25���\127dS�k\3\23\29`ݵ\7:�y�$^��Z�L�u���&L�L\2\0\0\0\0\0\1\8\9\7!\25$ǎK>��\17n��r.&.SӲn_|��\17V��\26���k\2\0\0\0\4\3\0\0\0002.]\4\7\0\0\0/802+8]\0\0\0\0\23pi\23��:\12rt�H�\27\20�\24�}l�sw\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\24pi\23�S�F!]\14@ҷOW��1YF�'\0�}KڟW1���\19\3\11�+�U_k\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\11\9\20 ��Gv\21�x\3U\1\9\20 ��xT*��\30�T\1*���V��\22\1\6K�_� �?���{�\14t\0259\8t\25�E�\
\15��\4�;�)l�YX\30;\28s���1˜\27\23��W\4+L�\15�\15v\25\17\9v\25\29P�zd\6e:��#*�c�za��r5?�G#��\6\24Qa\28\28\8�=\1,\8\6 ]��\3�^�\18�\20s^�r�\"���<\0\11\8\8 H9�#��\127\28���t\28~V4\18�\20�\127M��$^Z=\28���Wk��\23O\27�M\12\0\0\0\25\28\28\28]\28\28\28�\\\28\28�\0\0\0\29�\0\0K\0\0\0�\0\0\0�\0\0\1\0\1\0\0�\0\0\1�\0\0\0\31\0�\0\11\7\21 D�\6\28{g�]��l^a&�\22�m�\23A��\8�,\17@��\
w�BP\5\0\16I\25YL\6'\2\0\0\0\1\2\0\0\3\7!\25F��!���*\2\0\0\0\3\0\0\0\0\0\0�?\4\6\0\0\0!4790U\1\0\0\0\13\9\20 \14�S]za7/o\127o\11ء_L{\12\9\20 n\6� \11�kVH��I��\2!Р\127^�\14t\25:\8t\25��B{̘�\16�\17�,.T�P\2�\0;5%�i�F�O| Y\11\"��zf��H�\15v\25\26\9v\25�X\6-*�jj\0,\8\6 _��A~'\0121���@��\31(��Z\7\1\12\8\8 +\7WWD]�\18u\0�j�7�a�yV4\18��j8#\0\0\0���f���f�羦&���f�������f��f���\0\23@\0�F\0�\0_\0\0\1K\0\0\0H@\0\0��@\0�\0\0\0�\0\1\1\23�\1��\1\0\1\0\2�\2݁\0\1\5\2\0\1@\2\0\3\29�\0\1J\0�\3��\0\0#��\127��@\0�\0�\0\6\1A\0@\1\0\0\29\1\0\1�\0\0\0�\0\0\0\31\0�\0\5\7\21 ٹ�,�m�\22\6��\
ֲ�'k\6z'ͩ�7\4\7nx\
\6\16I\25\2�z!�M�G���m%�\12\28JH�\16a��b��\18I\3\0\0\0\0\1\1\1\1\2\4\7!\25}\28�v<�\
�\24C,\12��72\5\0\0\0\4\5\0\0\0\15\2\11\30{\4\6\0\0\0\15\26\25\23\30{\4\6\0\0\0\11\26\18\9\8{\4\13\0\0\0\8\30\15\22\30\15\26\15\26\25\23\30{\4\13\0\0\0\28\30\15\22\30\15\26\15\26\25\23\30{\0\0\0\0\22pi\23�\17�U\25�\20\
\12ThF\30\18�@\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\22pi\23��6\2\25KL��~$�ytp\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\
\9\20 e��X�J�!�M�\27;\12\9\20 ��H9�3.\22U*V\6;�E`�c�$�\14t\0255\8t\25�\21�\3h��\127��#1eQ�rD0\22k�\15v\25\16\9v\25��\31\24IPM\28�p�r�K//��F|\0035c2�_\0063�f\14T\0!\8\6 �B�\127C\26T\1�EDp,�+v�\"�e!\16\13I\24\16�\23�p�\1\0\13\8\8 n� J�7�:u��\15�\6wP�+ \27�{V4\18�A�\30��:4œc<\13\0\0\0��������j*�e��\0\24��\1\23@\0�\1�\0\0\23�\0�\24\0�\1\23\0\0�\1@\1\0\31\0\0\1\31\0�\0\
\7\21 �\19Q\31���d\5g�)*d�;B��W���X�O�7E.,\
\4\5\16I\25���\0110(q};U�\11��G\13\1\0\0\0\0\0\0\7!\25g\26\13\2\6\0\0\0\3\0\0\0\0\0\0\0@\4\14\0\0\0\\^OhXI^^UhRA^;\3\0\0\0\0 �DA\3\0\0\0\0\0\0\8@\3\0\0\0\0\0\0(A\3\0\0\0\0\0\0�?\0\0\0\0\27pi\23\13~�6�*�\25Vdzt��\"0�\6�c�T/\19c�?�\13X4��tJ\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\11\9\20 \15_Lrv��9 \11\9\20 3�BX\127[�>3\15t\0254\8t\25��*\6�pnqȼ�#=��0�\15v\25\25\9v\25�\28�7\1+\8\6 ��\30A�\1p\0\2\8\8 ��\14|�\27�$�#�\"�P�\3+Ƈ\6�z�ctؐW3©n:�({��\9B�rV4\18\4v�M���\17 &�wzt�\7�׾\29�\4AB�\28�_53�\\���Hj��e%\0\0\0����ࡡ� ᡡG����!���!a��aa�!����!��'��\0�\0A\1�@\1\0��\0\1ƀ�\0���\1\11�\1\0G�A\1\
A\1�G�A\1\
A��G\1B\1\
A\1�\
�\
�\
�B�݀\0\1\26@�\1\23@\1�\13A�\1\25\0�\0\23�\0�\3\1�\0\31\1\0\1\23@\0�\3\1\0\0\31\1\0\1\31\0�\0\7\7\21 mH�l�Qx\22R�qS&ex$�\31]9\6\4\16I\25g\15z\20\12��%��\9nW+\0259�\7lH\2\0\0\0\1\2\0\0\5\7!\25��?���+־ I��J.\14\0\0\0\3\0\0\0\0\0\0�?\4\6\0\0\0TABLE \4\3\0\0\0OS \4\5\0\0\0TIME \4\5\0\0\0DATE \4\3\0\0\0\
T \4\4\0\0\0DAY \4\6\0\0\0MONTH \4\5\0\0\0YEAR \4\5\0\0\0HOUR \3\0\0\0\0\0\0\0\0\4\7\0\0\0MINUTE \4\7\0\0\0SECOND \3\0\0\0\0\0\24�@\0\0\0\0\16pi\23��*\11��W\16\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\11\9\20 j�%$���HX\11\9\20 >H�\"���F\28\15t\0258\8t\25к%zo��\20\\e�kH�cL*x�\\�\1�J\25�tyL\28�\6\28\14v\25\29\9v\25�m�\15�C�I���{$�YB�\21�%\1+\8\6 ��B\9�\21�5\0\12\8\8 �\6)\21v��\21-�9>\31��:qqV4\18���^�\29�6M\1275rf؉j�ejY\6o&9]�D3� �Su6�M�\0\0\0tqqq0qqq�1qq�qqql�qq7�q�qq,�qp�q�q�qqqTpqq\0200qq�00q�pqqf�s��pqs�00qp�pq���p�pqqfqq�fqp��0�q��0r�p�ppssq�0�p�03q�pqqf�s��pqs�03qp�sq���p�pqqfqq�fqp��0�q��0r�\1�\1\1�\2\0�A�\1�\1C\0�\1\0\0\23�\2��\1\0\2�\1C\0\1�\2\0���\1�\1\0\0\23\0\0�\23\0\1��A�\0��A\3�\1�\1\1B\3\0�A�\1��C\0�\1\0\0\23�\2��\1\0\2ǁC\0\1�\2\0���\1�\1\0\0\23\0\0�\23\0\1��A�\0��A\3�\1�\1\1�\3\0�A�\1�\1D\0�\1\0\0\23�\2��\1\0\2�\1D\0\1�\1\0���\1�\1\0\0\23\0\0�\23\0\1��A�\0��A\3�\1�\1\1B\4\0�A�\1��D\0�\1\0\0\23�\2��\1\0\2ǁD\0\1�\1\0���\1�\1\0\0\23\0\0�\23\0\1��A�\0��A\3�\1�\1\1�\4\0�A�\1�\1E\0�\1\0\0\23�\2��\1\0\2�\1E\0\1�\1\0���\1�\1\0\0\23\0\0�\23\0\1��A�\0��A\3�\1�\1\1B\5\0�A�\1�\1\0\0ǁE\0�\1�\3\1\2\0\0�A\3��\2\0\0ǂE\0�B�\5�\2�\5\1\3\0\0��\1��\3�\2ǃE\0�C�\7�C�\7\0\4�\4@\4�\6�C\0\2���\127�\1�\127�\1�\1�\1\0\0\23�\2��A�\0�\1F\3�\1�\1\1B\6\0���\1H������\0���\0\1�\6\0�A�\1\23�\0��\1G\1�\1\0\0�\1\0\1�\1\0\0\31\0�\0\
\7\21 ���\31���*�\0�i\15�h\25���1���$\12\17�(�\14�{\18\5\16I\0250�Kk�$S!4\20�Z\1��t\2\0\0\0\1\2\0\0\0\7!\25C��\28\29\0\0\0\3\0\0\0\0\0\0�?\4\6\0\0\0,9:4=X\4\8\0\0\0*=)-1*=X\4\3\0\0\0+\"X\4\5\0\0\0002+76X\4\6\0\0\0+,!4=X\4\7\0\0\0+,*16?X\4\7\0\0\00016+=*,X\4\19\0\0\0����ؽ�ƾ��b+,!4=X\4\6\0\0\0/1<,0X\4\7\0\0\0006-5:=*X\4\19\0\0\0����ؽ�ƾ��b/1<,0X\4\7\0\0\0000=1?0,X\4\20\0\0\0����ؽ�ƾ��b0=1?0,X\4\7\0\0\0007*1=6,X\4\20\0\0\0����ؽ�ƾ��b7*1=6,X\4\6\0\0\0,1,4=X\4\19\0\0\0����ؽ�ƾ��b,1,4=X\4\11\0\0\0;96;=4695=X\4\24\0\0\0����ؽ�ƾ��b;96;=4695=X\4\7\0\0\00073695=X\4\20\0\0\0����ؽ�ƾ��b73695=X\4\6\0\0\0(9?=+X\4\13\0\0\0=**7*5=++9?=X\4\7\0\0\0;76;9,X\4\2\0\0\0tX\4\6\0\0\0=**7*X\3\0\0\0\0\0\0\0\0\4\7\0\0\0=6;7<=X\2\0\0\0\11\9\20 ��$x\5S�\
~\11\9\20 �-�\7+#\22<;\15t\0258\8t\25�)�4v��)�C**Kl1\23��W]�P�t5�\4�kZ<\17\14v\25\18\9v\25%$�(M��\5��\16G�5�\27\31�\21V��\31o\23р\\)�\0002���\14�YV\1\0,\8\6 \19��\22��5%�żh�\26,I�TZ\29\2\
\8\8 \13�L\4��{\28|}V4\18PH�O?p*0���i\9��y��[G\11\0\0\0�|<|�|||��|\1\24@\0\1\23�\0��\0�\0�\0\0\1\23@\0��\0\0\0�\0\0\1\31\0�\0\
\7\21 ���n��\20L\18ʤ\3�\3\26\14���t_��\9{\0+U�\28�\16\4\6\16I\0253�JD��\7m�:�\17�{�R�G^n��90\16S�i\1\0\0\0\0\1\3\7!\25���\24�m�2\1\0\0\0\4\5\0\0\0\
\7\14\27~\0\0\0\0\21pi\23G̃\12�TB7#�iM�\18�\7\11_�wt67\29�\0038\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\
\9\20 B@�!\0�\21\11^�;D.\11\9\20 �6dkT��y,\15t\0252\8t\25#��<Z�XT\20\14v\25\17\9v\25�Wg\29�\1�NpKE%\18Ki/�O�v��YTW��\24VzIf�C�=\0/\8\6 Rp�\21��4\18��s$�\4�\15vaQcl��1\3\1\8\8 �s\27$���\25T��;\8�\4Fك\2%���\127��#\23�'\6,E�;k�zV4\18i{.(FHSe�\0\0\0Y�ޞ��^��^�\30Y\30ޞE������\30[����\31ޞ�_��C\30\30�E������\30�ޜ\30X�_�Y�_������\31��\30�\30�__������ߜ����\28�C�\30�Y�ܞE������\30[�����ܞ�\31��C\30\30�E������\30�ޜ\30X�_�Y�_������\31��\30�\30�_�\1\0\0\2\0\1A�\2\0VA�\2�@�\1�\0C\0�\0\0\0\23\0\4��\0\0\0\7\1C\0A�\0\0݀�\1�\0\0\0\23\0\0�\23@\2��\0�\0�@�\1\5\1\0\1A�\1\0�\1�\0��\1\0\0\2\0\1A\2\2\0VA�\2�@�\1�@C\0�\0\0\0\23\0\4��\0\0\0\7AC\0A�\0\0݀�\1�\0\0\0\23\0\0�\23@\2��\0�\0�@�\1\5\1\0\1A�\1\0�\1�\0��\1\0\0\2\0\1A�\3\0VA�\2�@�\1�\0@\0\24��\1\23�\4��\0D\0�\0\0\0\23\0\4��\0\0\0\7\1D\0A�\0\0݀�\1�\0\0\0\23\0\0�\23@\2��\0�\0�@�\1\5\1\0\1A�\1\0�\1�\0��\1\0\0\2\0\1AB\4\0VA�\2�@�\1�\0@\0\24��\1\23�\4��\0D\0�\0\0\0\23\0\4��\0\0\0\7\1D\0A�\0\0݀�\1�\0\0\0\23\0\0�\23@\2��\0�\0�@�\1\5\1\0\1A�\1\0�\1�\0��\1\0\0\2\0\1AB\4\0VA�\2�@�\1�\0@\0\24��\1\23�\4��\0D\0�\0\0\0\23\0\4��\0\0\0\7\1D\0A�\0\0݀�\1�\0\0\0\23\0\0�\23@\2��\0�\0�@�\1\5\1\0\1A�\1\0�\1�\0��\1\0\0\2\0\1AB\4\0VA�\2�@�\1\31\0�\0\0\7\21 LӕE!J�3\
\11\16I\25^\30�tԙ�*��!\18�\13�\13+\20�\16 1�O\27\15\
w}��&�&�a��}\27\3\0\0\0\1\4\0\1\1\3\3\7!\25M�BEY�#M\20\0\0\0\4\5\0\0\0ZW^K.\4\6\0\0\0bOLKB.\4\5\0\0\0ZKVZ.\4\7\0\0\0]Z\\G@I.\4\6\0\0\0ZOLBK.\4\7\0\0\0G@]K\\Z.\4\4\0\0\0ɂ�.\4\7\0\0\0Ǐ�ɂ�.\4\26\0\0\0ʖ�Ƞ�ʕ�ZKVZ˟�Ȯ�Ǻ�Ɓ�.\4\5\0\0\0]GTK.\4\7\0\0\0@[CLK\\.\4\26\0\0\0ʖ�Ƞ�ʕ�]GTK˟�Ȯ�Ǻ�Ɓ�.\4\6\0\0\0OBGI@.\4\6\0\0\0MABA\\.\4\27\0\0\0ʖ�Ƞ�ʕ�MABA\\˟�Ȯ�Ǻ�Ɓ�.\4\11\0\0\0|OJGAi\\A[^.\4\7\0\0\0]KBKMZ.\4\28\0\0\0ʖ�Ƞ�ʕ�]KBKMZ˟�Ȯ�Ǻ�Ɓ�.\4\14\0\0\0mFKMElAVi\\A[^.\4\9\0\0\0mACLAlAV.\0\0\0\0\24pi\23\19�]i3c\16g\25^�+\27�b/\12�\18\12�\23h+���F�\14\0258\17\8�\22�8�W\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\27pi\23z��>��<���u�Vh\4\6��pô�3$ugy�d�\27V��E\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\14\9\20 ��b\127��[I�a�Q�U�e2�F,��\8D�ܝF\24\1\9\20 \2�\17~�0-g;$�\5s\1�j�ŠcD��\"�\19�+��\2\3\
\15t\0257\8t\25V��{\1l=:uJ�^�\27\4J�?x\11w\19\"]���\0305\14v\25\31\9v\25�Q�Tw]J\28D��^\9\"\21\5\8��#\12��]\4�pN\1.\8\6 \7/�C6��z�\3c9�\11�\
��A5\127E\\���\8\0\15\8\8 q�\19b\5�xs(��\12�g\6\5�\15J\31�V�\15\21^�Ik~V4\18��W(�*�dm\2rU\1�y\5s%�\3�0�@I\0\0\0nkkk*kkk�+kk�kkkv�kk.kkk��kk��kkMjkk6�kk�kkk�kjkj�kk\13jkk��kk�kkkj*jk*�kk�\1\0\0݀\0\0\5\1\0\0A�\1\0��\0\0�\1\0\0\29�\0\0E\1\0\0��\1\0��\0\0&\2\0\0]�\0\0�\1@\0�\1A\3�\1\0\0\1�\0\0U\2\0\0�\2\0\0!�\4�\6C�\0\7\3B\6@\3�\3�C�\0��B\7��\2\0\7�\2\0\7\4@\8G\4@\0G\4�\8\14D\4\8G�\2\0G��\8�\4@\0��@\9N��\8��\2\0�\4A\9�\3�\2\29C\0\0 ��\127\6\2�\0@\2\0\3�B�\0�BC\5�\2�\3\1�\3\0���\1�\2�\0\0\3\0\1@\3�\1�\3\0\2�\3�\2\30\2\0\4\31\2\0\0\31\0�\0\3\7\21 ��\31\19\11\16I\25�/i_�;�C�\2j}���-�V�8�1SA���((Z^ro=�K�A}j\2\0\0\0\1\2\0\0\3\7!\25\0018sT�\14�\19\15\0\0\0\3\0\0\0\0\0\0�?\4\6\0\0\0lyzt}\24\3\0\0\0\0\0\0\0@\4\7\0\0\0vmuz}j\24\3\0\0\0\0\0\0\8@\3\0\0\0\0\0\0\16@\3\0\0\0\0\0\0\20@\3\0\0\0\0\0\0\24@\4\7\0\0\0qvk}jl\24\4\7\0\0\0kljqv\127\24\4\7\0\0\0~wjuyl\24\4\13\0\0\0=kd=kd(`=(.`\24\4\28\0\0\0~qv|Umtlq[wtwjQvJ}\127qwv^mbba\24\4\7\0\0\0{wv{yl\24\4\2\0\0\0004\24\0\0\0\0\21pi\23\0074�G��O ��5�C6gl�\0110�BH\127JS+\2\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\8\9\20 kN4f\21\1\9\20 �(\0171���+�e�\"��_O�N�\7&U�\31�kq3\15J.\19�\15t\0253\8t\25�J�=���\2u)3<#\14v\25\27\9v\25\22k\8'\31��\8v�dG\1*\8\6 ^\3�T�\0170h���r\0\2\8\8 {}sM�^\23\0X�M4l�P\"\6��i���.&��Fr\9�OT�}q�\\�{\18}V4\18i�2\30��&P���$�\23\30>�,�\3B\1\0\0\23\18\18\18S\18\18\18�R\18\18�\18\18\18\15�\18\18W\18\18\18��\18\18�R\18\0184\19\18\18O�\18\18�\18\18\18��R\18�\18�\19\19\19\18\18T\19�\18�S\19\18O�\18\19���\16�\19\18\0187\16\18\18S\16\18\18�\16�\19�\16\18\18s�2�S\17\18\18��R\18�\17\17\21�\17\18\21�\17\18\18s\17\13�U�R\18U\22�\26U\22�\26U��\26\
\18�\26\5\18\21�U�R\18U\22�\26U\22�\26UV�\26I\22\18\18\5�\17�U�R\18U\22�\26U\22�\26U��\26IV\18\18\5\18\16�TV�\18U��\26�\22\18\19��R\18�\22�\27�\22�\27�V�\27OV�\19\5�\19�TV�\18U��\26�\22\18\19��R\18�\22�\27�\22�\27Ֆ�\27OV�\19U�R\18U\22�\26U\22�\26U��\26\
\18�\26\5\18\21�U�R\18U\22�\26U\22�\26UV�\26I\22\18\18\5�\17�U�R\18U\22�\26U\22�\26U��\8[D\0\0\23\0\2�FD�\0G��\8�\4\0\1��@\0�\4�\9�\4�\9�D�\9]D�\1\23�\1�FD�\0G��\8�\4\0\1��@\0�\4�\9�\4�\9Ǆ�\9]D�\1G�@\0G\4�\8G\4�\8G��\8\24@�\8\23\0\1�FD�\0G��\8�\4\0\1��\3\0]D�\1G�@\0G\4�\8G\4�\8G��\8\24��\8\23@\9�G�@\0G\4�\8G\4�\8G��\8[\4\0\0\23�\7�G�@\0G\4�\8G\4�\8G\4�\8[\4\0\0\23\0\4�FD�\0G��\8�\4\0\1��@\0�\4�\9�\4�\9Ǆ�\9]D�\1FD�\0G��\8�\4\0\1��@\0�\4�\9�\4�\9�\4�\9]D�\1\23\0\2�FD�\0G��\8�\4\0\1��@\0�\4�\9�\4�\9Ǆ�\9]D�\1\23��\127`C�\127`��\127[@\0\0\23�\2�K\2\0\0@\0�\4A\2\0\0�\2\0\1�\2\0\0a�\0�AC\4\0�\3\0\6V��\6J@\3\6`��\127U\2�\0�\2\0\1\25��\4\23�\5�F��\0��\4\0�\2\5\0]B�\1U\2\0\1�\2�\0N��\4�B�\0�\2�\4\1\3\5\0�B�\1�\2\0\0�\2�\4\1\3\0\0��\1��C�\0��B\7�\3�\0\1D\4\0@\4�\6\22D\4\8�C�\1���\127K\2\0\0���\0�\2F\3\0\3\0\0�\2\0\1�\2\0\0dB\0\0H@\2�F��\0G\2�\4\24\0�\4\23�\26�A�\0\0���\0�\2\0\5�\2\0\0a\2\25�\1\1\0\0FC�\0G��\6���\0�\3\3\7��\6\0]��\1[\3\0\0\23�\6�@\3\0\4���\0�\3\3\7��\6\0]��\1�\3\0\4�\3@\6��\3\1\1\4\7\0���\1�\3\0\0\1\4\0\0U\4�\6�\4\0\0!D\1�\6E�\0Gń\6\29�\0\1\13\5@\
\7\5\5\7�\3�\9 \4�\127\6��\0N\4@\6GD�\0\
ă\8\1\1\5\0\23�\15�N\3@\6GC\3\1\24��\6\23�\1�F��\0�\3@\6���\0ƃ�\0�\3�\7J�\3\7\1\1\5\0FC�\0G��\6�\3@\6��\3\1��\7\0]��\1[\3\0\0\23�\6�@\3\0\4�\3@\6��\3\1��\7\0]��\1�C�\0ƃ�\0\14\4@\6�\3�\7��\0\1�\3@\7���\6�\3\0\4\0\4\0\7A\4\7\0݃�\1\6D�\0F��\0G\4�\8\29�\0\1\13\4@\8\7\4�\7F��\0�\4@\6���\0J\4\4\9\1\1\5\0\24\0@\2\23�\3�@\3\0\4�\3@\6��\3\1�\3\7\0]��\1�C�\0ƃ�\0�\3�\7��\0\1�\3@\7���\6ƃ�\0\14\4@\6\7\4�\0ʃ\3\8\1\1\5\0`B�\127\23@\0�A\2\5\0_\2\0\1A\2\0\0_\2\0\1\31\0�\0\8\7\21 �\19�\8�w&A���:o=�DAJ/S�+�a�\29bM�\0�\0269̦-� `\"\22\2\16I\25�O~ ��X\6\23�7P\2\0\0\0\1\2\0\0\0\7!\25\4i�: \0\0\0\3\0\0\0\0\0\0�?\4\6\0\0\0atwyp\21\3\0\0\0\0\0\0\0@\4\6\0\0\0etrpf\21\4\8\0\0\0gpd`|gp\21\4\3\0\0\0fo\21\4\5\0\0\0\127fz{\21\4\5\0\0\0alep\21\4\11\0\0\0Gtq|zRgz`e\21\4\7\0\0\0|xtrpf\21\4\5\0\0\0y|fa\21\4\7\0\0\0|{fpga\21\4\14\0\0\0V}pv~WzmRgz`e\21\4\5\0\0\0Pq|a\21\4\6\0\0\0Jpq|a\21\4\9\0\0\0VzxwzWzm\21\4\5\0\0\0qtat\21\4\4\0\0\0ctg\21\4\6\0\0\0pggzg\21\0045\0\0\0��Pmey|fa�������������������\21\3\0\0\0\0\0\0\0\0\4\7\0\0\0q|tyzr\21\4\
\0\0\0xlJgpa`g{\21\4\7\0\0\0f}zb@\\\21\4\7\0\0\0p{vzqp\21\4\7\0\0\0fag|{r\21\4\5\0\0\0s|{q\21\4\2\0\0\0U\21\4\2\0\0\0009\21\4\9\0\0\0az{`xwpg\21\4\3\0\0\0JR\21\4\2\0\0\0006\21\1\0\0\0\3\9\20 �\19�y���^�<\28\30�$:l�\7�#`�Z[IA�}��T��\13o�\11�fN\12\9\20 �~�\18�|�(;��\17�R.n�\30�\5d\15t\0256\8t\25UoS\11�(;\\�R�Y\9�ar���\9a\"�}\\\14v\25\25\9v\25\127X\9|\0!\8\6 3�5s\14sA&�~�6�[E~��\30 �<T\21��a\28b�X\12\3\9\8\8 �8�w�|V4\18i'�f���pc�Xh�9�O+\0\0\0IՕ����\21T�����\21����\21�ԕ�Ԕ��\30���S\20ՕRTU����\0@\2\0\2�\2�\1݁\0\2�A\0\0\23�\2�\6�@\0\7\2A\4@\2\0\0�\2�\1Ƃ@\0�B�\5\0\3\0\0�\2\0\1\29�\0\0�\1�\2\23@\3�\6�@\0\7\2A\4@\2\0\0�\2�\1�\2�\3\29�\0\2�\1�\2\6�@\0\7BA\4@\2\0\2\29�\0\1�\0�\3M\1�\2\23��\127�\1\0\1\31\0�\0\6\7\21 �N�\16�\13�a'ʬq�m�\22\13\0\16I\25|9\0}\1\0\0\0\0\1\4\7!\25�ɶ\5�8bo\0074r|/�\3d]� \6\0\0\0\3\0\0\0\0\0\0�?\4\2\0\0\0\14N\4\7\0\0\0=:<' )N\4\5\0\0\0(' *N\4\4\0\0\0=;,N\4\4\0\0\0\"+ N\0\0\0\0\17pi\23^_/(�A�\19���\30\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\21pi\0238�+\18F��>U\27\30t�5�.�14KD`M-�nI&\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\
\9\20 ��\26A\0225&\16�a�>k\0\9\20 ���\0P�l���\5F��x_,�!��DK��@U��\15\25ܽ@�\2t\0259\8t\25�s�w�\
\24�%5�X�1���pn�\8/\0��ir�@\5\19x\24W�\14v\25\30\9v\25��)Yl��SD��n�\20-B,��\27(\127\8|\1/\8\6 Bּ+���:MS9<>\31\12w�Ę;�A�(\0\1\8\8 �G�4�m�J��WA6>=uQ$zZ��\21\2>��M%� R�6�\12�yV4\18D\5�}S\0\0\0����ㅅ������ą���E��\5�\5\4ą�`\4��\13E�\4`D��\13E\4\4`���\13E�\7`Ą�\13E\4\7Rĕ\5���\5�\5D��\5�\5 \4��`D�\0\1�\1\0@\2\0\3]��\0�\2\2\0��\2��B\2\0������\2\0��\2���\2\0�����\1\12�\23�\11�\24\0�\0\23�\6��\1\3\0�A\3\0\1B\2\0A�\2\0�\2�\3�\2�\4\0\3�\3@\3�\3�\3\0\1]�\0\1�\3�\3�\3�\1��\0\1V��\6\29�\0\1�\2�\5��\0\1�\3\0��\2���\3\0�����\2\4\0��\2��B\4\0������\4�\23�\4�\24��\0\23\0\4���\4\0��\4\0%\2\5\0A\2\3\0�B\3\0�\2�\3\0\3�\1݂\0\1%C\5\0�\0\3�%�\5\0�\0��%�\5\0�\0\3�%\3\6\0�\0�����\127\31\0�\0\7\7\21 ���m���\2�.=\9�\13�\9��\19\\\16\2\16I\0253ۖx��@\30px\4\0\0\0\1\2\1\3\0\0\1\4\3\7!\25Kz�!��[$\14\0\0\0\4\
\0\0\0\26\26\8\3\
\4\25\14\5k\4\6\0\0\0^ZZX[k\4\11\0\0\0\4\8\25)\
\7\
\5\8\14k\4\
\0\0\0\4\8\0258\8\25\14\14\5k\4\9\0\0\0\4\8\25\"\6\
\12\14k\4\15\0\0\0\4\8\0259\14\27\4\25\31.\25\25\4\25k\4\7\0\0\0\3\
\4\2YXk\4\22\0\0\0ZZZ^\23/SSX-^(.S(X*/^SSk\4\6\0\0\0\15\
\6\
Yk\3\0\0\0\0\0\26�@\4!\0\0\0RZ\9\\\13\14[\14\8\14RXSZ\\\\]\8\13Y[^Z\8\
XS\
\13\8\9[k\4\8\0\0\0\25\30\4\0\30\
\2k\4\6\0\0\0SSY[\\k\4!\0\0\0\14^\13^R_\13\
\
ZSR__R\9S^]\15^\9\13Y\13[\15Z\\_\15\14k\25\0\0\0\11\9\20 \15F�a�V<\29�\8\9\20 �\2�t�\15t\0254\8t\25D\15h=��\0282�K\"{�k�b�\14v\25\26\9v\25�\"J\7��*\20\1#\8\6 {\24�LG�C!x\0vB?,aB�{�*�\12\5\14�\22�\0154\28\25+�\127�8�ݩw\0\2\8\8 � i\\��jl�\5�H�0w\27�+�_�q�\23�v\31}��\19}m��;e�\21\13CqV4\18��}J_[�#Rs�n�^\20-\20x\22\31\20��uC�>AC�*o���B7\0\0\0FCCC\2CCC�\3CC�CCC^�CC\6CCC��CC�\3CCeBCC\30�CC�C�C��CCBBBC\2\2B\0�\1\0\0��\0\0ƀA\1\1�\1\0݀\0\1\6�A\1A\1\2\0\29�\0\1K\1\0\0�\1�\0�AB\2\11�\1\0\
\2\0�\
\2Å\
���K�\0\0J\2ć�\2\0\3J���\
B\2�F�D\1G��\4GB�\4�\2\0\3]�\0\1\
B\2�F�D\1G\2�\4GB�\4�\2�\2]�\0\1\
B\2���\0\1\24�E\4\23�\0�G\2�\2_\2\0\1\23@\0�C\2\0\0_\2\0\1\31\0�\0\5\7\21 ���1��J\5H�\17\13���?���\20|\6+8P96x\11\7\16I\25�1�w\12Z�T;�\9y�7t@ڊ\22p���X\3\0\0\0\0\0\0\1\0\2\8\7!\25�\0016m�L�U��8\20\28�Kz&��G���\7���D�-�k�/_v\23\0\0\0\3\0\0\0\0\0\0�?\4\7\0\0\0�������\3\0\0\0\0\0\0\0@\3\0\0\0\0\0\0\8@\4\7\0\0\0�������\3\0\0\0\0\0\0N@\4\8\0\0\0��������\4\3\0\0\0���\4\13\0\0\0�������������\4\8\0\0\0��������\4\4\0\0\0����\4\7\0\0\0�������\4\5\0\0\0�����\4\8\0\0\0��������\4\8\0\0\0��������\4\13\0\0\0�������������\4\"\0\0\0����������������������������������\4\15\0\0\0���������������\4\7\0\0\0�������\4\6\0\0\0������\4\5\0\0\0�����\4\6\0\0\0������\3\0\0\0\0\0\0i@\0\0\0\0\17pi\23���\
��Ml� \0293\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\11\9\20 'm�\19�]I,m\12\9\20 U�}:�L\8;\31 �\5�3�C�<�F�\15t\25:\8t\25��\11L���nB�~\2X�g\8��\127h�J�\3)�\22/��*o�Py;B2�N�\14v\25\16\9v\25>&�`���\4���\4h��,��0\24�\"\25[HcF[$D|4\0.\8\6 �ө+K�=H�,�sf\28\30n��\17]\20�\0.\24i&)\1\
\8\8 \15\27�q���o\\~V4\18�'�^\7ONP5�%FV\26\8G֙6T^�<u'\0\0\0009\\\\\\�\\\28\\�\28\\\\��\\]��\28\\���]\\]\\\\\29]]\\���]\29\29]\0\24�A\2\23�\5���A\0���\0\24\0B\3\23@\2��\1@\0\1B\0\0݁\0\1\12B�\1��\2\0\29��\1\12�B\4\29�\0\1@\1\0\4\23@\1��\1�\0\12B�\1��\2\0\29\2�\1݁\0\0@\1�\3�\1�\1�A\0\1_\1\0\1\23@\0��A\1\0�\1\0\1\31\0�\0\1\7\21 \127�\15���C�I\20\22\11\7\16I\25$p�H\27�\9\27%�[\29\31G\12a�\15#vm;�x\1\0\0\0\0\2\4\7!\25��\\=e\15L$�<�]V\11�0�+j\18\13\0\0\0\4\8\0\0\0\31\8\28\24\4\31\8m\4\3\0\0\0\30\23m\4\3\0\0\0\4\2m\4\5\0\0\0\2\29\8\3m\4\3\0\0\0\31\15m\4\1\0\0\0m\0\4\
\0\0\0\
\8\25\">9\20\29\8m\4\4\0\0\0\4\2\30m\4\5\0\0\0\31\8\12\9m\4\3\0\0\0G\12m\4\6\0\0\0\25\2\5\8\21m\4\6\0\0\0\14\1\2\30\8m\1\0\0\0\15\9\20  \29�T�\5�}\31��\
)6�\127{��X\23\22~?\14\14\9\20 �L�s���\0127�A\11�U�i4��E���\14YE�D�\15t\0253\8t\25M-�[���;�D�\14v\25\16\9v\25旅}E\2�\26/f�bvr�W���f�j\26H�p�\5���z\0/\8\6 ��\12\23J\11]\12��/���\20i�,\23\15�g/\1\2\8\8 ���V�\
�.\27��6T\14eJ{��;S,�A�c�3�_�\1ճ�P3��x%zV4\18��l41�'g\9\0\0\0c%e%be�%�\0\0\0��\0\0%\1\0\0]�\0\2\0\0�\0\31\0\0\1\31\0�\0\11\7\21 �H�1w��\1�\25\127G\31�z\9\
��h.��\15�+P\15�R�c�\12�j\5\8\16I\25\28^�oڲ�\26C�Z;�\9\13\7�5J|�=)\6˷]Ù2y�6�_\1\0\0\0\0\0\0\7!\25?0\0205\3\0\0\0\4\7\0\0\0}z|g`i\14\4\5\0\0\0i}{l\14\4\4\0\0\0& '\14\1\0\0\0\14\9\20 S�\14\9�Jwdp<v3v!�6.\
�4\28+WmEO�$G\
\9\20 \6�`\13j��\31f\16x\\�\15t\25:\8t\25s��\12��\22\127��\8w$��|)��\19\1�\21\24\16\28�@0@�#\5*k3x5EQ�\14v\25\30\9v\25)�`b\13#�a���]jN�\4\15��\1Q��$\0!\8\6 b7�\
\29�M\9��d7�XPAL�0>���$\29�\12fw4�m\1\11\8\8 #Fms�I\13�S\\\127v}V4\18�Js~]�#vy1�\22\3#K\18_�9\14\
\0\0\0000v6v16�v��\0\0�\0@\0���\1\0\1\0\0�\0\0\1^\0\0\0_\0\0\0\31\0�\0\
\7\21 3c\0216d�A\1�\14)��>*��\5$\15��\
�s4\8���(\5\4\16I\25��\
-\27B�,�h\18\23\0�X6��4d\1\0\0\0\0\0\2\7!\25L��t^��\8uio>\4\0\0\0\4\7\0\0\000435.) G\4\7\0\0\0!(5*&3G\4\5\0\0\0bwu?G\4\5\0\0\0%>3\"G\0\0\0\0\26pi\23���+���1���o�\0311+f��0�\
�\9�j�)ü\27'\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\27pi\23���;\"}U5���x��\4r�g�v�\12�!w�C\28\20\
\0\27\12�:,\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\17pi\23\12��C*�8���Q\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\
\9\20 �1X�c�w`Y�+�\14\9\20 \24��\19ԓ�8��-3\28��Jt@A-�|�{�\"�f�\15t\0252\8t\0254�\
B�>�\27�\14v\25\30\9v\25SD0\14N�\\~�]E4�G�\0G��\20\20�a\127\0!\8\6 v��B�R]K�\11�\"��\21r8S1Y\\g�Tv�^E�\6\19R\0\1\8\8 sY\\=\"`�}m$\15\18�\28�):�]\17A��J��\22]W�6\\���w\4pV4\18��-i���\26\20��^��=\7\12'\2)b�)]�V�;�n�)&\0\0\0\2\4D\4\3DD\4\25��\4A\4�\4��\4\4��\4\4\1\5\4\5E\5\5\4�\5�\5҄�\1]��\1[\0\0\0\23�\3��\0\0\0�@A\0\1�\1\0݀\0\1\7��\1\7\1B\2@\1�\0\29�\0\1�\0\0\2\3\1�\0FAB\0��B\1]\1\0\1\31\1\0\0\23��\127�\0@\0�@@\1���\0�\0\0\1\26���\23\0�\127�\0\0\0�\0\0\1\23@�\127\31\0�\0\
\7\21 �.�:�!y\13 ��4��B\6�-E0���&��s_8��\4\7\6\16I\25�ۆ1�}�1�/�)�;</��C�L�S�:�@\4\0\0\0\0\2\1\0\1\2\1\3\2\7!\25H.�0L��\28�R�\6\12\0\0\0\4\3\0\0\0���\4\5\0\0\0�����\4*\0\0\0������˅���ʗ����ʊ�����ˣ����������ʅ����\4\20\0\0\0�ك���������������\4\11\0\0\0���������\4\8\0\0\0��������\4\3\0\0\0���\4\5\0\0\0�����\4\7\0\0\0�������\4\9\0\0\0���������\4\5\0\0\0�����\3\0\0\0\0\0\0\8@\0\0\0\0\22pi\23���_nJ�o�oS$���>\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\14\9\20 pU�MM\14\0261�\2\0286��F\8x�\15#��Y_�W�fF\8\9\20 ���(!\0t\0255\8t\25��.c��QS֭�a�p\31)M�)\1�\14v\25\25\9v\0254��W\1-\8\6 ���F\\E�:!-L\24`�1{\0\15\8\8 �\1K&:Vd2���\
�\
,{�\30�v�&N\26��\1279�~V4\18\8\1�o\26\11�L��wn���N�b�3iKK&g\0\0\0�����ʋ����\11ʊ��\16ʋ����\11\
ʋ�O����\9ˋ�\9\11��Kˏ�\11�\11͉ʋ\
Ɋ�K�����\11�ˈ��\11�\11�K�����\11��\9ʋ\
I���ɋ�Ή\11�\13�ɋ\22\9\11\0�B\2\0��\2\5]�\0\1�\1�\4\23\0\4�F\2A\0��\2\0�\2\0\0\0\3�\0@\3\0\1�\3�\1]B\0\3F�A\0��\1\0]B\0\1E\2�\0�\2B\0���\0��\2\0��\2\5]�\0\1�\1�\4F\2C\0GB�\4�\2�\3]�\0\1\25@��\23\0\11�E\2\0\1��\3\0��\3\0\5\3�\1A\3\4\0�\3\0\2�C\4\0\5\4�\2A�\4\0�\4�\3ւ�\5\0\3�\2]�\0\2[\2\0\0\23�\6��\2\0\0��D\0\1\3\5\0݂\0\1\7C�\5\7�E\6@\3�\4\29�\0\1�\2\0\6\7�E\5\24@@\6\23@\2�\7\3F\5\9\3\0\3\6CF\0G�F\5\29�\0\1FCF\0�\3F\5]\3\0\1\31\3\0\0\23\0\1�\4\3\0\0FCF\0��E\5]\3\0\1\31\3\0\0�\2\0\0�\2\0\1\23�\0�D\2\0\0��\6\0_\2�\1\31\0�\0\7\7\21 �>o\\[��w`�*K�3�/1�HY\19\9\16I\25��0s*{bC*\14Lِ�:h�\14)�o�\6���Rȩ@$\7\0\0\0\0\2\1\5\1\0\1\2\1\3\1\6\1\4\2\7!\25��%y\2\0�V��Ix\28\0\0\0\3\0\0\0\0\0\0>@\3\0\0\0\0\0\0�?\4\
\0\0\0!#2\9\21\18?6#F\4\4\0\0\0/)5F\4\9\0\0\0005('65.)2F\4\14\0\0\0)%4\25/+'!#h,6!F\4\7\0\0\0+\21*##6F\3\0\0\0\0\0@\127@\4\9\0\0\00035#4\22'2.F\4\19\0\0\0i4#5i)%4\25/+'!#h,6!F\4\14\0\0\0)%4\25/+'!#h6(!F\4\19\0\0\0i4#5i)%4\25/+'!#h6(!F\4\7\0\0\000524/(!F\4\4\0\0\0*#(F\4'\0\0\0.226|ii'6/th5<q~\127h(#2|~~i\20#%0\4?2#h'5.>F\4\
\0\0\00035#4('+#{F\4\11\0\0\0`6'551)4\"{F\4\9\0\0\0`5) 2/\"{F\4\
\0\0\0`/+!\"'2'{F\4\8\0\0\0004#73/4#F\4\3\0\0\0005<F\4\5\0\0\0,5)(F\4\7\0\0\0\"#%)\"#F\4\5\0\0\0/( )F\4\6\0\0\0/+!\15\"F\4\9\0\0\0002)524/(!F\4\7\0\0\0004#53*2F\4\19\0\0\0����������֯�߮��F\0\0\0\0\20pi\23�\30�M�ۗ\0183��-f��\17-\17\0^;�m\29\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\
\9\20 \0301^&\
��:\"I�-a\15\9\20 �eEm�\2�x�\
�>\22��Ae��^�U'+\27\0t\0256\8t\25Q\1�\29�}�i���Q~۲F<I&:�N\17Q\11\1v\25\28\9v\25^r�{��I\0024��\7�S�>\1-\8\6 ��s:�3�\26�\26AA�#\27\0\
\8\8 ��a-�6*�rV4\18O�3XĄ�&Nς\29$_yEu�F\31\6�:\\;XR\7�x$~�/b\7�*�NJ\0\0\0����\\������GF���\1���\0G\7����ǆ\6��\26GG���\6����G\1���\26GG��F�Ǉ���чF�\2�G�����\26G\0\1\6A@\0\7�A\2@\1�\1\29�\0\1\25\0\1�\23\0\11�\5\1\0\1AA\2\0��\2\0�\1�\1\1�\2\0E\2\0\2�\2\3\0�\2�\2\1C\3\0@\3�\1�A\3\3�\1\0\1\29�\0\2\27\1\0\0\23�\6�K\1\0\0��C\0��\3\0��\0\1�\1D\3�A�\3\0\2\0\2݁\0\1@\1�\3ǁ�\2\24\0�\3\23@\2����\2�\1\0\3�\1E\0\7B�\2݁\0\1\6\2E\0G��\2\29\2\0\1�\1\0\0\23\0\1��\1\0\0\6\2E\0G��\2\29\2\0\1�\1\0\0C\1\0\0_\1\0\1\23�\0�\4\1\0\0A�\5\0\31\1�\1\31\0�\0\6\7\21 <�Sq�\16� �U�bx�y+\14\5\16I\25+V\8F�hr'\27\
\"t_<�M\7\0\0\0\0\2\1\5\1\0\1\2\1\3\1\6\1\4\11\7!\25z {n\0�G\8\13��\0]��/A�k#�~�uHHo\17nA�M�>�\16>�A.\23\0\0\0\3\0\0\0\0\0\0>@\4\7\0\0\0\18\21\19\8\15\6a\4\5\0\0\0\7\8\15\5a\4\2\0\0\0Na\0\4\9\0\0\0\20\18\4\0191\0\21\9a\4\6\0\0\0N\19\4\18Na\4\4\0\0\0\13\4\15a\3\0\0\0\0\0\0�?\4'\0\0\0\9\21\21\17[NN\0\17\8SO\18\27VYXO\15\4\21[YYN3\4\2\23#\24\21\4O\0\18\9\25a\4\
\0\0\0\20\18\4\19\15\0\12\4\\a\4\11\0\0\0G\17\0\18\18\22\14\19\5\\a\4\9\0\0\0G\18\14\7\21\8\5\\a\4\
\0\0\0G\8\12\6\5\0\21\0\\a\4\8\0\0\0\19\4\16\20\8\19\4a\4\3\0\0\0\18\27a\4\5\0\0\0\11\18\14\15a\4\7\0\0\0\5\4\2\14\5\4a\4\5\0\0\0\8\15\7\14a\4\6\0\0\0\8\12\6(\5a\4\9\0\0\0\21\14\18\21\19\8\15\6a\4\7\0\0\0\19\4\18\20\13\21a\4\19\0\0\0��߆����������a\0\0\0\0\22pi\23b�s7�i�K�Ok�J�V\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\
\9\20 �Ɍ\9�\16&��\
\13M\12\9\20 ���\0063\27�t�,YI�r3Uq\24<g\13\0t\0251\8t\25�{S+5\1v\25\17\9v\25iJ�)ӘS6�)�'P��kp�@\9�!�\17�\3f\22��F�p[z\1,\8\6 �u\2j���H\27*\0�lu��\25>\0\1\8\8 U�b^{�\3\20�K|#?ws\4\2~\14!���[Q�F6�M�'\29�\127PdpV4\18�\11�7�Kx\"�<y(\\,�\\M�\7L���^#V�\4�?�7.\0\0\0Bdde\127$ddsdd�adddmdddaddd\127dddsdm�ad�d%ddd�$dd�d\0\1\1�\0\0E\1�\1��\0\0�\1\0\0��\1\1\29��\1\27\0\0\0\23�\5�K\0\0\0�\0A\2�@\1\0��\0\1ǀA\1���\1\0\1\0\0݀\0\1@\0�\1�\0�\0\24@�\1\23@\1��\0�\0\6�B\2G\1�\0\29\1\0\1�\0\0\0\23\0\1��\0\0\0\6�B\2G\1�\0\29\1\0\1�\0\0\0C\0\0\0_\0\0\1\31\0�\0\0\7\21 \6x1\22�CGN\8\11\16I\25��\16iiO-���\24X�>Y�+�W�oJ\14�lX\23٭�q\9)�lX\9\\+\5\0\0\0\1\4\1\0\1\2\1\3\0\2\3\7!\25H� qZ�jL\11\0\0\0\4*\0\0\0%99=wbb,=$\127c>7zutc#(9wuub\31(=\"?9\8??\"?c,>%5M\4\
\0\0\0008>(?#, (pM\4\11\0\0\0k=,>>:\"?)pM\4\8\0\0\0k$ *$)pM\4\8\0\0\0?(<8$?(M\4\3\0\0\0>7M\4\5\0\0\0'>\"#M\4\7\0\0\0)(.\")(M\4\5\0\0\0$#+\"M\4\12\0\0\0>8..(>>+8!!M\4\9\0\0\0009\">9?$#*M\0\0\0\0\24pi\23��g'V�\\t���A��\7'?��qLЍy�\3�I\1��\25���V홇\21\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\
\9\20 \26\22�+\25W�\19�\"�h�\12\9\20 ��deA��^�y@h:um\12�\31\21\11S\0t\0258\8t\25M\127\31\0020YE$�P�\24v�\28}m��j���\2��.\21T�>?'\1v\25\18\9v\25�R�\17���,���l�-\2,�\18<e��G\20�Z�j~S�?�E%J�$�6\0/\8\6 �[�u�{�J�#�n\29�d:�V<d��_T\0\2\8\8 ��|L�M�`?�2$!\7\
]\22��bo<xH�W�u��\9`���2�U�xvqV4\18+��1���\6�\17�\30)=�\30�\"\0023U$\14\4�:�2\24}�\29�w�CS\0\0\0pv6vq66vk��v0�6v��vv+�vw-vvva�s��v7v�67w�v�vw�wv7�wv��vt6vvw�v7v�v4w�v�vw7tv���w�vv\0\23�\1���B\0�\0�\0\1�\2\0���\1@\0\0\1�\0�\0�\0\0\1\23\0\0�_\0\0\1�\0@\0�@@\1���\0�\0\0\1Y���\23\0\0�\23\0�\127F\0@\0G@�\0]��\0��@\0��\3\0��\0\1�\0\0\0\23�\5��\0A\0�@�\1\0\1\0\1A�\1\0��\1\0݀\0\2�\0�\1�\0A\0�\0�\1\0\1\0\1AA\2\0݀�\1�\0\0\0\23�\1�ƀB\0\0\1\0\1A�\2\0݀�\1�\0�\1�\0C\1�\0\0\1\23\0\0��\0\0\1�\0@\0�@�\1݀�\0�@�\1\25���\23@�\127�\0D\0\1A\4\0A�\4\0�@�\1\23��\127\23��\127\23@�\127\31\0�\0\4\7\21 ���T�x\19J\6��r�\29[\31��\0149#�B-\7\6\16I\25+un\13�k`F�D\20P��;n�N�j\22L\30-\11�(Q\1\0\0\0\0\2\4\7!\25\14��\"�;21\12Q\9f��|\27��j&\19\0\0\0\4\3\0\0\0���\4\5\0\0\0�����\4\8\0\0\0��������\4 \0\0\0��������������������������������\4\7\0\0\0�������\4\4\0\0\0����\3\0\0\0\0\0\0\16@\3\0\0\0\0\0\0\16�\4\5\0\0\0�����\4\5\0\0\0�����\4\9\0\0\0���������\4\3\0\0\0���\3\0\0\0\0\0\0�?\3\0\0\0\0\0\0$@\4 \0\0\0��������������������������������\3\0\0\0\0\0�r@\4\7\0\0\0�������\4d\0\0\0=}e?Pi>QK?xY=PE=\127S=TN=|i0l}7dT0wo?yv=vB>Dt=Dh?eI?cD>PN=}e?Pi=v@>Na>DU=Ry0gF>V}>u{=``7dT=Uk=h^1_U0wM�\3\0\0\0\0\0\0\20@\0\0\0\0\20pi\23ۋqM��j-��\23w\4�!l\"�l`G\20&{\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\15\9\20 #�U�\22\
q\21D�/�N�zV@�4<��Mv\1\9\20 ��\0287�T�:\28WR%�}QJ#\9iD\9\26b��wXG��\21^\0t\0252\8t\25r�8]��\28T|\1v\25\27\9v\25���a��\15b��\4@\0-\8\6 FS�\23�\"�O���_$�\22'\1\9\8\8 �E�\21[rV4\18�\\�\6[\20�\28���\25�x;�ݭj��\19\23\23S�(���!-%�Q3�6N\28\0\0\0\26[[[�\27[[�[[[]�\27[\\�\27Y\30Z�[\6Z�[\29A\0\0\1\1\1\0@\1\0\0�\1\1\0!\1\3�\6�@\0\7BA\4A�\1\0\29�\0\1�\0\0\4\0\2�\0F�A\0G\2�\4�\2\0\1�\2�\1\0\3�\1]�\0\2V@\2\4 A�\127_\0\0\1\31\0�\0\5\7\21 wH�:w�P0e\20�K��P�K\26׫�(Aw�$\13\9\16I\25�U�\
�P�\6D��(���\0065�P\30?օx~��fYQgE\2\0\0\0\0\2\0\3\9\7!\25!�4|�!?2�!�`�4�\2�5�N�\11�z��e>�\19�9\9\0\0\0\4\1\0\0\0v\4%\0\0\0\23\20\21\18\19\16\17\30\15\28\29\26\27\24\25\6\7\4\5\2\3\0\1\14\15\12FGDEBC@ANOv\4\5\0\0\0\27\23\2\30v\4\11\0\0\0\4\23\24\18\25\27\5\19\19\18v\3\0\0\0\0\0\0�?\4\7\0\0\0\4\23\24\18\25\27v\3\0\0\0\0\0\0B@\4\7\0\0\0\5\2\4\31\24\17v\4\4\0\0\0\5\3\20v\0\0\0\0\24pi\23�$Jg(�o[�\1fc�΀5���N�I\27\30l��e\17\17x\26�1�nY\17\29\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\1\9\20 ŋ�\1\18��K��(Q��W�DcWꃯ\"�A�.�� W\15\15\9\20 ���\
�Q�~zV�>�V\27t��>\127*��eL\0t\25:\8t\25\4<�k��9/�[\18�\28WES�\
d�|�\9c��N�\0\14(e��5=\19�zj\1v\25\18\9v\25�e�^�1CE�<�dR�b`���\16�$X\13��@8Z\8Ph{�\0070��\12g\0.\8\6 ��/n�^\9\0203�dJ�5�l-��R\15\31�>@�-l\0\12\8\8 \3�(tD(\19X�+Nr2m�\6�zV4\18��<\16y��k$\0\0\0�������d�a� ���!a�`a��$���� ���a��\1\1\0]�\0\1�@\1\1\29��\1\27\0\0\0\23@\4�F@A\2G��\0�\0\0\0��\1\0]��\1[@\0\0\23@\0�\24\0B\0\23�\0�D\0\0\0�\0\0\0_\0�\1\23\0\1�C\0�\0�@B\2�\0\0\0�\0\0\1_\0\0\0C\0\0\0_\0\0\1\31\0�\0\4\7\21 9��E�ۘf\28&�\22�Fj$V\13�+�be{\7\4\16I\25\8��<n��\8��\13=b�\24%�/�8\5\0\0\0\1\0\1\9\1\3\1\7\0\2\4\7!\25���d�\19�&\0156$8�o�.pI�\19\
\0\0\0\4\8\0\0\0g{{\1275  \15\4\15\0\0\0 Hj{_`fa{!n|\127w\15\4\6\0\0\0Z|j}2\15\4\4\0\0\0)}2\15\3\0\0\0\0\0\0$@\4\7\0\0\0|{}fah\15\4\5\0\0\0ifak\15\4\2\0\0\0,\15\4\1\0\0\0\15\4\9\0\0\0{`|{}fah\15\0\0\0\0\22pi\23�nm�5\18\0�*�C�N�a\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\8\9\20 \28��\"�\8\9\20 �h[K�\0t\25:\8t\25�)�y�~�j\23��9\12�\1P�؅6�\23#,���pKBTb��+{�ߟ\2f\1v\25\16\9v\25Q�%Z�g�!�I��\28<\24�\9o�R+7-�\7?q_�!\1#\8\6 \\�J\26�O� ���,U�vB�3�%�Ժ\24q�\24e���_�o�\9_�s0\0\11\8\8 ,�=\3-w.\27�I�BA\127V4\18Ka\19o��$D��\0084)`?j���F.�{%z$eD�\0\0\0gAAE\26\0AAVAA�\0@AA�\0AAVAA��\0AA�@AAG�\1A\\��AY�\1EV�E�\7C\0A�\3@A�CAAAB�A\1BA@�B�@�BAB\28\3�B\7�\0A��@A\28\3A@\4C�A�C\3A���A�\3CA׃CD\28�A@�@�EVAE�\7C\0A��CA�CAAAB�A\1BA@�B�@\28\3AB\7�\0A��@A\28\3\0\1E\2�\0�\2B\0���\0��\2\0��\2\5]�\0\1�\1�\4F\2C\0GB�\4�\2�\3]�\0\1\25@��\23�\25�F�C\0G��\4]��\0�\2\0\1�\2\4\0\5\3�\1AC\4\0�B�\5\1�\4\0E\3\0\2��\4\0�\3\0\2\1\4\5\0@\4�\2�D\5\0�\4�\2\1�\5\0E\5\0\3��\5\0]�\0\1�\5\6\0�\5�\3\22�\5\6@\3�\2��\0\2�\2\0\0\23@\5��\2C\0�B�\5\0\3\0\5A�\6\0݂�\1�B\0\0\23\0\2�X�F\5\23�\1��\2C\0�B�\5\0\3\0\5A\3\7\0݂�\1�\2\0\0\23�\0��\2\0\0\0\3\0\5�\2�\1\23�\0��\2�\3\23@\0��\2\0\0�\2\0\1ƂC\0���\5݂�\0\5\3\0\1A\3\4\0�\3�\1�C\7\0VÃ\6��\7\0�\3�\3\1�\7\0E\4\0\3��\5\0]�\0\1�C\4\7\29��\1�\2\0\6�\2\0\0\23\0\5�\6\3C\0\7CF\6@\3\0\5��\6\0\29��\1\27C\0\0\23@\0�\24�F\5\23�\0�\4\3\0\0@\3\0\5\31\3�\1\23�\3�\6\3H\0@\3\0\5\29�\0\1F\3H\0�\3�\3]\3\0\1\31\3\0\0\23�\1�\6�C\0\7�C\6\29��\0\14�\2\6\26\0�\2\23@\0�\3\3\0\0\31\3\0\1\6�A\0AC\8\0\29C\0\1\23��\127\23�\0�D\2\0\0��\8\0_\2�\1\31\0�\0\
\7\21 \7�to4ρ\0��\29���&aV�?\11F\30?��Q\14�C�Y\24\6\16I\25N� ;\19*K\28���\5\8��S��c\1�e�e�1e]\8\0\0\0\0\2\1\5\1\0\1\9\1\3\1\8\1\7\1\4\5\7!\25>��n�ʢ`\16)\6M\4\8�1#\0\0\0\3\0\0\0\0\0\0>@\3\0\0\0\0\0\0�?\4\
\0\0\0����������\4\4\0\0\0���\4\9\0\0\0��������\4\14\0\0\0��������������\4\7\0\0\0������\3\0\0\0\0\0@\127@\4\9\0\0\0���������\4\19\0\0\0������������������\4\14\0\0\0��������������\4\19\0\0\0������������������\4\7\0\0\0�������\4\4\0\0\0����\4\3\0\0\0��\4\5\0\0\0�����\4\8\0\0\0���᫾��\4\15\0\0\0��������������\4\9\0\0\0������㬑\4\9\0\0\0���������\4\
\0\0\0�������嬑\4\9\0\0\0���������\4:\0\0\0��������������䬡������䬴����������������������謑\3\0\0\0\0\0\0$@\4\6\0\0\0������\4\5\0\0\0�����\4\2\0\0\0��\4\1\0\0\0�\4\2\0\0\0��\4\16\0\0\0��������������\4\4\0\0\0�լ�\4\4\0\0\0�㬑\4\9\0\0\0���������\3\0\0\0\0\0@�@\4\19\0\0\0t\
/v\24\22y62w\15\1x\5\8y>>�\0\0\0\0\27pi\23�x�\30Oi� �7\7x�\
�Rx��\
�\15�>�>x��DO\30oFm\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\11\9\20 �)�V�F*\22k\15\9\20 \20��)�E�\8f�E\14�� )\25�[=m\\do�\0t\0258\8t\25�]\19#�Y�\31�/�$iB\12}��V-�=r\29�\0,^l\13\1U�\1v\25\26\9v\25�̉_��W\31\1.\8\6 U��\8Tz�\17���:�\0�\30��+R�^@\127�o#b\0\12\8\8 ֈ�Us�Mx\22�<y!�\22(�yV4\18��\\6�\0\0\0����t������on���)���(o/�����.��2oo���.����o)���2oo��n�������n�*�o�����2o��鮯��.����o��n�����k���o�����j�o�.n��.n�n.��*�����\3\0@\2�\0�B\3\0�\2\0\1\1�\3\0E\3�\2��\3\0�\3\0\3\1\4\4\0݃\0\1\1D\4\0@\4�\1�A\4\3�\1\0\1\29�\0\2\27\1\0\0\23@\5�FA@\0G��\2�\1\0\2��\4\0]��\1[A\0\0\23\0\2�X�D\2\23�\1�FA@\0G��\2�\1\0\2�\1\5\0]��\1[\1\0\0\23�\0�D\1\0\0�\1\0\2_\1�\1\23�\0�\9\1�\3\23@\0�C\1\0\0_\1\0\1FAE\0G��\2]��\0�\1\0\1�A\2\0\5\2�\1A�\5\0�A�\3\1\2\6\0E\2�\3�B\6\0�\2\0\3\1\3\4\0݂\0\1\22�\2\4���\1\0\1\0\3\27\1\0\0\23\0\5��A@\0��@\3�\1\0\2\1�\4\0���\1�A\0\0\23@\0�\24�D\2\23�\0��\1\0\0�\1\0\2�\1�\1\23�\3���F\0�\1\0\2��\0\1ƁF\0\5\2�\3�\1\0\1�\1\0\0\23�\1��AE\0��E\3���\0�A\1\3\26�\1\1\23@\0��\1\0\0�\1\0\1��F\0�\1\7\0�A\0\1\23��\127\23�\0�\4\1\0\0AA\7\0\31\1�\1\31\0�\0\0\7\21 ��\27?�\24�%\18\0\16I\25�?/b\8\0\0\0\0\2\1\5\1\0\1\9\1\3\1\8\1\7\1\4\2\7!\25�'\127W\6�;_�:�r\30\0\0\0\3\0\0\0\0\0\0>@\4\7\0\0\0\24\31\25\2\5\12k\4\5\0\0\0\13\2\5\15k\4\2\0\0\0Dk\0\4\9\0\0\0\30\24\14\25;\
\31\3k\4\6\0\0\0D\25\14\24Dk\4\4\0\0\0\7\14\5k\3\0\0\0\0\0\0�?\4\8\0\0\0\3\31\31\27QDDk\4\15\0\0\0D\30\27\7\4\
\15Z]E\
\24\27\19k\4\9\0\0\0\30\24\14\25\24\31\25Vk\4\9\0\0\0M\12\
\6\14\2\15Vk\4\
\0\0\0M\31\2\6\14\4\30\31Vk\4\9\0\0\0M9\14\9\
\31\14Vk\4:\0\0\0M/\
\2'\2V\3\
\4\2M\0\4\30V[M\9\14\2\17\3\30VN\14^N\
^N\9\15N\14\\NSSN\9ZM\29\14\25V\28\14\9YM\0\14\18Vk\3\0\0\0\0\0\0$@\4\6\0\0\0M\2\6\12Vk\4\2\0\0\0Hk\4\1\0\0\0k\4\2\0\0\0Wk\4\3\0\0\0\4\24k\4\5\0\0\0\31\2\6\14k\4\16\0\0\0D,\14\31*\5\24\28\14\25E\
\24\27\19k\4\4\0\0\0\"/Vk\4\4\0\0\0M\25Vk\4\9\0\0\0\31\4\24\31\25\2\5\12k\4\7\0\0\0\0068\7\14\14\27k\3\0\0\0\0\0@�@\4\19\0\0\0��Ռ���ȍ�������k\0\0\0\0\22pi\23ʂg=\9H�G(��=eO�\28\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\9\20 �\"�}���/�{�5�\127�\30�}�E���j?�I=�-G\11���C@\14\9\20 ��}0\5��j�&\7\
P+>\20�A�I��<'�G$V�\0t\0251\8t\25]\9�@�\1v\25\18\9v\25�l�\27�p/�\0198w��\17'\22��0���(���=�O_\127W$�@G/MH\1#\8\6 ��Kp۪>~���\27�Y76rz\15i4�\15Y��~A\18L�,�R�\15Wk�G\0\
\8\8 ���zT��Q�{V4\18\11G�x議G��E8*\0\0\0�����Ą����\4�������������������\4��\4�ń��\1�\0\1�@\0\0V��\0��\0\0�\0\0\0\1�\0\0E\1�\1�\1\1\0]�\0\1�@\1\1\29��\1\27\0\0\0\23�\3�F@A\2G��\0�\0\0\0��\1\0]��\1[@\0\0\23@\0�\24\0B\0\23�\0�D\0\0\0�\0\0\0_\0�\1\23�\0�C\0�\0�\0\0\0_\0�\1C\0\0\0_\0\0\1\31\0�\0\5\7\21 ;\20� 89�SU�3i\11(�\23�&\5{k��\25���@\7\5\16I\25\0\26F\25��\12\1�M4\0016�%\22\5\0\0\0\1\4\1\0\1\9\1\7\0\2\6\7!\25��r\127+~�1�\5�',s�h_\\�\
u�\14i>�R\21\9\0\0\0\4\8\0\0\0(440zoo@\4\16\0\0\0o\19%.$\00522/2n!308@\4\4\0\0\0\9\4}@\4\4\0\0\0f2}@\3\0\0\0\0\0\0$@\4\7\0\0\000342).'@\4\5\0\0\0&).$@\4\2\0\0\0c@\4\1\0\0\0@\0\0\0\0\26pi\23���0\13��rM��\21!�h\2-`-d���Y,�U{\22\14�+\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\12\9\20 !�$\17�\12<\12u�llɟ�_4\6Vr\21\3\9\20 \19�MuF�{\6�6�o\
~Hl���\15A�4\16v��?��k5`�ZE�j|v�\0t\0251\8t\25:�1c�\1v\25\29\9v\25{�0O���zp\6�\21�\13�( \0�\28\0(\8\6 �n�s\1\9\8\8 ��\21>~V4\18���&oePUh��F�j�\6�k�G\24�?b\19\0\0\0x>~>y~�>�>>>��>>c��\1��\0\0\24\0A\1\23�\1�\12A�\0��\1\0\29��\1�\0\0\2\12��\0\29A\0\1�\0\0\1\23@\0�\1�\0\0\31\1\0\1\31\0�\0\0\7\21 �\9�<^W�h\7\0\16I\25��<)\1\0\0\0\0\2\2\7!\25h\4\"A7?�h���-\8\0\0\0\4\3\0\0\0|z\21\4\5\0\0\0zep{\21\4\3\0\0\0gw\21\4\1\0\0\0\21\0\4\5\0\0\0gptq\21\4\3\0\0\0?t\21\4\6\0\0\0vyzfp\21\0\0\0\0\23pi\23ũV_���[\2��i��\24+)@/+\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\12\9\20 \23DW\127�C�\9+;JV>d�B}8�r+\12\9\20 �\02227�\21�EO�\1,�=\5[�\20r\21�\0t\0256\8t\25�\0\24\13���K��'*�}rY\30:\127a,\3�k�\1v\25\31\9v\25��m\5dk�*!�D#���>�.T\11;O�:��\9\30\0!\8\6 nGD9��\9N��zq���8���W\22\15�G��;{\9\4~J\1\9\8\8 �O�\24�~V4\18G٭D�X�\\\17��eP�i�Y�i�N�1\21\0\0\0����@����@����@��������\0\24��\0\23�\1���@\0�\0\1\0��\0\1�@A\0݀\0\1\0\0�\1\23�\0��@A\0�\0\0\0��\0\1\0\0\0\1\31\0\0\1\31\0�\0\3\7\21 (�?C\5\7\16I\25\24r�\127lK�g_]s\24|�w*���\
�>:W\1\0\0\0\0\2\6\7!\25�=�E�;Du��Eq8�\17\127-�MC���b�\16�7\6\0\0\0\4\9\0\0\0_DX_YBEL+\4\
\0\0\0LN_dx\127R[N+\4\4\0\0\0BDX+\4\8\0\0\0YNZ^BYN+\4\3\0\0\0XQ+\4\4\0\0\0FO\30+\0\0\0\0\26pi\23���*�\0�2Ò�e\\\2:5{P�K��Tgف~\5�)C\16\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\1\9\20 f\30�Vx�$ pS�U�S�V�G�U0|�z�[Z\5\23�cb�\12\9\20 됉n\2P�'�J,o0w�Us/Ej?\1t\0256\8t\25��yI=a�+\16Q\1\28林^i�\25_�O�4\26\0v\25\31\9v\25�rs\127�>/K\24��g��\
\30?O�0�\8�G\6�\14u\0!\8\6 \\'>\30~�3\21c��<%{\25uA�j�\21!7\25�szX�\25M\0\13\8\8 B�GrD+�;�0�)�\6tat��\17G}V4\18o)\25[I�{?-Ǝ=UȰ9�z�\0300\0\0\0AG\7G@\7\7G\2G�G�GGF�G�FчGF\26�GF��GG��GGZ�GE\2GGE�GFG�@\1\0\5\1�\2A�\1\0�\1�\1��\1\0\5\2\0\3A\2\2\0�\2\0\0ր�\1]��\1[\0\0\0\23\0\5��@B\0��\2\0��\0\1��B\1�\0�\1\0\1�\0݀\0\1\7A�\1\24�C\2\23@\1�\3\1�\0F�C\0�\1�\1]\1\0\1\31\1\0\0\23\0\1�\4\1\0\0F�C\0�A�\1]\1\0\1\31\1\0\0�\0\0\0�\0\0\1\31\0�\0\11\7\21 yk�\0022�\8\30\29U�=�\"sj�\19<]�Hn�+#2�\"1P�;U\11\3\16I\25i&VF���\17\7\0\0\0\0\2\1\7\1\9\1\2\1\0\1\8\1\
\0\7!\25�\14\0121\17\0\0\0\4\7\0\0\0�������\4\4\0\0\0��Ħ\3\0\0\0\0\0\0�?\3\0\0\0\0\0\0 @\4(\0\0\0���֜����ψ���ǔ���˜�������։������æ\4\7\0\0\0����⛦\4\7\0\0\0����ԛ�\4\6\0\0\0����\4\7\0\0\0����ț�\4\8\0\0\0������æ\4\3\0\0\0�ܦ\4\5\0\0\0���Ȧ\4\7\0\0\0�����æ\4\4\0\0\0��Ҧ\3\0\0\0\0\0\0\0\0\4\9\0\0\0���������\4\8\0\0\0������æ\0\0\0\0\21pi\23\"��?\3�%~�y�Jda62G��9u�\14t9h�\19\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\
\9\20 �+�A�\"�E�!\14M{\8\9\20 \6�+\4u\1t\0254\8t\25*��7J� _\20t�H\12�\26\28\9\0v\25\25\9v\25��q\1.\8\6 �>�z�( \19�\29�H��3\3GM�Nx�U\7U�'2\0\9\8\8 ۥ�3\31yV4\18\8\1�\127�\0\0\0009\31\31\27D^\31\31\8\31\31�^\30\31\31�^\31\31\8\31\31��^\31\31�\30\31\30��_\31���\31\7�_\26\8\31\23��\29^\31\30\\\30\31_\28\31\31�\28�\31�\28\31\30\31\27�\30_\27\31\28�]�\28ٝ^\31\30�\30\31�]\31\30�\29�\31\25\28]\31\2��\31^\\\29\31\9\\\28\25\31\30�\30�\26�\29\31\30\25\28]\31\2��\31^\\\29\31\9\\\28\25\31\30\31\29�\26�\29�\30\26\28\31\29Z\28�\29�\28\31\27\9�\28\25\31\30_\29�\26\8\31\19��\29^\31\30�\29\31_\28\31\31�\28�\31�\28\31\30\31\27�\30�]\31\28ٝA\0\1�\1\0�B\0\1�\2�\0\6\3B\0\29��\0A�\2\0\22C\3\6݂\0\1�\1�\5�\2\0\1\6\3B\0\29��\0A�\2\0\22C\3\6݂\0\1\0\2�\5�\2C\0\0\3\0\0݂\0\1\24@�\5\23\0\2�ƂC\0\0\3\0\0A�\3\0�\3\0\2�\3�\2��\3\7݂\0\2@\2�\5\23�\2�ƂC\0\6\3B\0\29��\0A�\2\0\22C\3\6A�\3\0�\3\0\2�\3�\2��\3\7݂\0\2@\2�\5�BC\0�\2�\5\0\3�\3݂\0\1\25���\23@\26��\2\0\3\1C\4\0A�\4\0�\3�\3��\4\0\5\4�\2A\4\5\0�\4\0\4�D\5\0\0\5\0\2A�\5\0�\5�\3��\5\0\0\6�\4A\6\6\0�\6�\2V��\6�\3�\2݂\0\2�\2\0\0\23@\20�\11\3\0\0FCF\0��\6\0]�\0\1���\6�\3G\7�\3�\5��\0\1\0\3\0\7�CG\6\24�G\7\23�\2���G\0�\3H\6��\0\1�\3�\4��G\0�CH\6��\0\1��G\0\7\4H\6�\3\0\1�\3\0\0\23@\14��CG\6\24�H\7\23@\12���G\0�\3H\6��\0\1�\3�\4�CC\0��H\7�\3�\1\5\4\0\2E\4�\2�\4�\4\22�\4\8݃\0\1\1D\0\0A\4\9\0��\0\2�\3\0\3\1D\9\0A�\4\0�\4�\3��\4\0\5\5�\2A\5\5\0�\5\0\4��\9\0\5\6�\4A�\5\0�\6\0\7V��\8�\4�\2݃\0\2\11\4\0\0FDF\0��\6\0]�\0\1���\8�\4G\9�\4�\7��\0\1\0\4\0\9�DG\8\24�G\9\23\0\3���G\0�DH\8��\0\1��G\0\5\5�\4�\4\0\1�\4\0\0\23\0\1��\3\0\0��G\0\7DG\6�\3\0\1�\3\0\0\3\3\0\0\31\3\0\1\23�\0��\2\0\0\1�\9\0�\2�\1\31\0�\0\11\7\21 Z��]0&Y\28�>xa���9�Q)^�ar'Z��\6Q\8Cw���\3\27\6\16I\25�c9P�M;�:\13j�׼\24��hW�AiUܖ�\
\
\0\0\0\0\2\1\5\1\6\1\7\1\9\1\2\1\0\1\8\1\
\1\4\3\7!\25��3P}��\29(\0\0\0\3\0\0\0\0\0\0$@\3\0\0\0\0\0\0�?\4\
\0\0\0\28\30\0154(/\2\11\30{\4\4\0\0\0\18\20\8{\4\9\0\0\0\8\21\26\11\8\19\20\15{\4\14\0\0\0\20\24\9$\18\22\26\28\30U\17\11\28{\4\7\0\0\0\22(\23\30\30\11{\3\0\0\0\0\0@\127@\4\9\0\0\0\14\8\30\9+\26\15\19{\4\19\0\0\0T\9\30\8T\20\24\9$\18\22\26\28\30U\17\11\28{\4\14\0\0\0\20\24\9$\18\22\26\28\30U\11\21\28{\4\19\0\0\0T\9\30\8T\20\24\9$\18\22\26\28\30U\11\21\28{\4\5\0\0\0\15\2\11\30{\4\7\0\0\0\8\15\9\18\21\28{\4\4\0\0\0\22\31N{\3\0\0\0\0\0\0�\4\4\0\0\0\23\30\21{\4%\0\0\0\19\15\15\11ATT\26\11\18U\31\26\22\26IU\24\20\22ALLMMT\26\11\11T\31I=\18\23\30{\4\7\0\0\0\26\11\0112?F{\4\7\0\0\0]\14\8\30\9F{\4\6\0\0\0]\11\12\31F{\4\7\0\0\0]\15\2\11\30F{\4\11\0\0\0]\29\18\23\30?\26\15\26F{\4\7\0\0\0]\8\18\28\21F{\4\
\0\0\0]\15\18\22\30\20\14\15F{\4\8\0\0\0\9\30\
\14\18\9\30{\4\3\0\0\0\8\1{\4\5\0\0\0\17\8\20\21{\4\7\0\0\0\31\30\24\20\31\30{\4\4\0\0\0\9\30\15{\3\0\0\0\0\0\0\0\0\4\9\0\0\0\15\20\8\15\9\18\21\28{\4\3\0\0\0\18\31{\4\7\0\0\0\9\30\8\14\23\15{\3\0\0\0\0\0�r�\4\4\0\0\0\8\14\25{\3\0\0\0\0\0\0 @\4'\0\0\0\19\15\15\11ATT\26\11\18U\31\26\22\26IU\24\20\22ALLMMT\26\11\11T\31I)\30\8\14\23\15{\4\5\0\0\0]\18\31F{\4\19\0\0\0��Ŝ����؝������{\0\0\0\0\19pi\23-\27gS\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\12\9\20 ��m\21J�f$'�V+1�\1277d�!I�\0\9\20 /ztP�\0226EM�C,�v�'��i�\22a?���a\27\23�C\30�T\17E\1t\0253\8t\25���t�>fS�H><_\0v\25\25\9v\25�&�9\1.\8\6 *\7�Gs7�}PK�\9=p�v�\\3Fqσi�@�\
\0\13\8\8 K��~65\19/F\22sh|dq6��4x�~V4\18�x�H�:sF��Q%i�vp�,\0110x�d�\0\0\0����\0ۛ����\27\26���]�ۛ\\\27[������Z��F\27\27���Z����\27]�ڛF\27\27��\26��ۚ����\26�^�\27�����F\27������ۚ���\26��ߚ��\29Zڛ\6\26\27���٘�[�\27^�\27�����ޙ\27�\27����\25��F\26��ۚ\27����\27]�ٛ�\25ٛF\26����[����\27]Zٛ�\25ٛڙ��\30����\2�\2��\2\5݁\0\2@\1�\3\23�\2���B\0\6BA\0\29��\0AB\3\0\22B\2\4A\2\3\0�\2\0\2�\2�\2��\2\5݁\0\2@\1�\3�A@\0ǁ�\3\0\2�\1݁\0\1\25���\23@\26��\1\0\3\1\2\4\0AB\4\0�\2�\3��\4\0\5\3�\2A�\4\0�\3\0\4�\3\5\0\0\4�\0AD\5\0�\4�\1��\5\0\0\5�\2A�\5\0�\5\0\1V��\4�\2\0\1݁\0\2�\1\0\0\23@\20�\11\2\0\0F\2F\0�B\6\0]�\0\1���\4��F\5�\2�\3��\0\1\0\2\0\5�\2G\4\24@G\5\23�\2���G\0��G\4��\0\1�\2�\4��G\0�\2H\4��\0\1ƂG\0\7�G\4�\2\0\1�\2\0\0\23@\14��\2G\4\24@H\5\23@\12���G\0��G\4��\0\1�\2�\4�B@\0��H\5�\2�\1\5\3\0\2E\3�\2�\3�\4\22�\3\6݂\0\1\1�\3\0A�\8\0��\0\2�\2\0\3\1\3\9\0AC\4\0�\3�\3��\4\0\5\4�\2A�\4\0�\4\0\4�D\9\0\5\5�\4A�\5\0�\5\0\5V��\6�\3\0\1݂\0\2\11\3\0\0F\3F\0�C\6\0]�\0\1���\6��F\7�\3�\5��\0\1\0\3\0\7�\3G\6\24@G\7\23\0\3���G\0�\3H\6��\0\1ƃG\0\5\4�\4�\3\0\1�\3\0\0\23\0\1��\2\0\0ƂG\0\7\3G\4�\2\0\1�\2\0\0\3\2\0\0\31\2\0\1\23�\0��\1\0\0\1�\9\0�\1�\1\31\0�\0\6\7\21 �C�s��\7v\20�\0150G�Kh\23\11\16I\25��Ml���p�J6\3K�p/��`8h�\9\1�Cg9\23A\5/&�<G\12\19�\"\
\0\0\0\0\2\1\5\1\6\1\7\1\9\1\2\1\0\1\8\1\
\1\4\9\7!\25E\7Y\4W��!:��h�\29�l�*NXԵ�`�A\9ns�\\Q'\0\0\0\3\0\0\0\0\0\0$@\4\7\0\0\0�������\4\5\0\0\0�����\4\2\0\0\0��\0\4\9\0\0\0���������\4\6\0\0\0̑����\4\
\0\0\0����������\4\4\0\0\0����\4\5\0\0\0�����\4\3\0\0\0���\4\4\0\0\0����\3\0\0\0\0\0\0�\4\19\0\0\0̑��̌��������͉���\4\4\0\0\0����\3\0\0\0\0\0\0�?\4%\0\0\0������̂��͇����̀�������̂��̇ѥ����\4\7\0\0\0�������\4\7\0\0\0Ŗ�����\4\6\0\0\0œ����\4\7\0\0\0ŗ�����\4\11\0\0\0Ņ���������\4\7\0\0\0Ő�����\4\
\0\0\0ŗ��������\4\8\0\0\0��������\4\3\0\0\0���\4\5\0\0\0�����\4\7\0\0\0�������\4\4\0\0\0����\3\0\0\0\0\0\0\0\0\4\9\0\0\0���������\4\3\0\0\0���\4\7\0\0\0�������\3\0\0\0\0\0�r�\4\4\0\0\0����\3\0\0\0\0\0\0 @\4'\0\0\0������̂��͇����̀�������̂��̇ѱ������\4\5\0\0\0Ŋ���\4\19\0\0\0\6x]\4jd\11D@\5}s\
wz\11LL�\0\0\0\0\27pi\23�||4_Z�v\8\30\26\26O��d�Ia[�Վl��\30Xn/iQ\19v�\28\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\15\9\20 CϮj��dG85�N\9`ON\17s\29Mޠ�\12�\1\9\20 �s�od�,��MO3\8�\19�+{9PԷ@\19�\15UŦ\"\4�\1t\0258\8t\25�w�cZ�{\30��\9y\6\\Sp2�s�I\3\14-C,@�!�{o\0v\25\31\9v\25L\30�\18�be\31\19\12�K\25f\4P�0KbWہ6�3i\23\1 \8\6 `;�\4���d�\6�=�5�v�DH`ez�-`\29B#;ٕ/���A\0\12\8\8 ��Mp�\27�\22���`\1n\23/�\127V4\18�V�8��Mp\2�r:��F\20��\13�#�n\12��R=\0\0\0�����������c�����������������#�c��#�䣣����f�c�&�������u��⾀\0\1��\0\0��\0\0\29�\0\2E\0�\2�\0\1\0�@\1\0\5\1\0\3A�\1\0�\1\0\2��\1\0\5\2�\3A\2\2\0�\2\0\0�B\2\0\0\3\0\0�\0�\1]��\1[\0\0\0\23�\5��\0\0\0ƀ�\0\1�\2\0݀\0\1\7\1�\1\7AC\2@\1�\0\29�\0\1�\0\0\2\7�C\1\24�C\2\23@\1�\3\1�\0F\1�\0��C\1]\1\0\1\31\1\0\0\23\0\1�\4\1\0\0F\1�\0��C\1]\1\0\1\31\1\0\0�\0\0\0�\0\0\1\31\0�\0\
\7\21 ��\"\14 \7�\30za\127p\30�mpw�.U\30��\7�\28a!�\29\0Z\13\11\16I\25�#H_�S�Pc��L�\5\0132q�s�YM|� �N\19��P)\7�l,<xe\8\0\0\0\1\4\0\2\1\7\1\9\1\2\1\0\1\8\1\
\9\7!\25*u�\27���_�y�0��\\T�i�-*|�#\15l\
\27�F�;\17\0\0\0\4\7\0\0\0�������\4\4\0\0\0����\3\0\0\0\0\0\0�?\3\0\0\0\0\0\0 @\4,\0\0\0������Ȇ��Ƀ����Ʉ�������Ȇ��ȃյ�����������\4\7\0\0\0�������\4\7\0\0\0�������\4\6\0\0\0������\4\5\0\0\0�����\4\7\0\0\0�������\4\8\0\0\0��������\4\3\0\0\0���\4\5\0\0\0�����\4\7\0\0\0�������\4\4\0\0\0����\3\0\0\0\0\0\0\0\0\4\9\0\0\0���������\0\0\0\0\21pi\23\28g�m�A\14\\�&� <n�\12q��L��\28\17�P�a\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\13\9\20 A\0173<�\18�\19\30�\30\8���o�\
\9\20 op�Eg\14\25s�(d~�\1t\0253\8t\0251�7g\24\12p\19v�3�\0v\25\16\9v\25�p�l\16\12�1Z[�G-��~�w�\\\\�m\6͌�]ҍy\24\0(\8\6 �=�a\1\1\8\8 ��\"\2>�Qh�tj=�/�/��#_��+�@�k|\13\0s\17v�3�yV4\18�\12�K\19\0\0\0��ৠ �`���!`�� `\1��\0\0\24\0A\1\23�\1�\12A�\0��\1\0\29��\1�\0\0\2\12��\0\29A\0\1�\0\0\1\23@\0�\1�\0\0\31\1\0\1\31\0�\0\0\7\21 A��\30Y5)J\7\7\16I\25rP�\5qA�]�F�M�^kj3� J\15S[\127\1\0\0\0\0\2\4\7!\25`G�H��$\\��g8-�K&�X�t\8\0\0\0\4\3\0\0\0�ɦ\4\5\0\0\0���Ȧ\4\3\0\0\0�Ħ\4\1\0\0\0�\0\4\5\0\0\0���¦\4\3\0\0\0�Ǧ\4\6\0\0\0����æ\0\0\0\0\21pi\23�\17=\8��\23;��E18\8�p�_�x\23\25�`�\2�O\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\14\9\20 �څ*j�EQM\27�1\28��\18���xV�\2?�;�hk\8\9\20 ���4�\1t\0259\8t\25k��\24�є\8���q\3�-\2\26ݪVi�jn'\13q�\8;%��5_�\0v\25\16\9v\25/��\8)\22�D\3��v�p�4]\"�8�aq\17�l�}�Ś\19\0 \8\6 �\\\30B�� >�3�s\6x�s�~�P<\1�l\\��2K��9��za\1\11\8\8 ���n\29�T7ċ_\8�|V4\18�d�\
\9A�M6u�\0195��{\21\0\0\0���c���c����c㥣�㾀�\0\24��\0\23�\1���@\0�\0\1\0��\0\1�@A\0݀\0\1\0\0�\1\23�\0��@A\0�\0\0\0��\0\1\0\0\0\1\31\0\0\1\31\0�\0\7\7\21 �\15�r'�[\14���{�%\1277*�\2\5\5\9\16I\25DH;p��s\22�5.�\13�\3\22s\0099�\23Tpg��A���,\1\0\0\0\0\2\11\7!\25\19-�\18ᧃ\25���\22^�L�M�zSz�\6Uy\21;�)S2\23\6\6\15D�.2\6\0\0\0\4\9\0\0\0\31\4\24\31\25\2\5\12k\4\
\0\0\0\12\14\31$8?\18\27\14k\4\4\0\0\0\2\4\24k\4\8\0\0\0\25\14\26\30\2\25\14k\4\3\0\0\0\24\17k\4\4\0\0\0\6\15^k\0\0\0\0\23pi\23�j�\25M\30�\127�0So\20�-\21\13h�r\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\14\9\20 lX\20E���5\27��Xl.�\21��\5\0074�Pp�f�7\6\0\9\20 \0060�1��Qg9Krs�J�\28�b\5\17\17\29\19\20\23,�O�\27�d�\24C[�\1t\0258\8t\25ʰj\13\6�vEaƏc\7�\17\24�U�\18\127_�\13���YW�6\127�\0v\25\26\9v\25�8[+�%5!\1(\8\6 *�op\0\2\8\8 O��Y��*\6��\20^�_\20Js&\7>i�$\27f��~yV�o*@v\2��pr~}V4\18��\6\24ͤ\\U�tx�\5�a\11��0:\0\0\0{~~~?~~~�>~~�~~~c�~~;~~~��~~�>~~X\127~~#�~~�~�~��~~\127\127\127~??\127~�\127\0\0��\0\0ƀA\1\1�\1\0݀\0\1\6�A\1A\1\2\0\29�\0\1K\1\0\0�\1�\0�AB\2\11�\1\0\
\2\0�\
\2Å\
���KB\1\0J\2ćJ�ĈJ\2ŉJ�Ŋ�\2\0\3J���\
B\2�FBF\1G\2�\4GB�\4�\2\0\3]�\0\1\
B\2�FBF\1G��\4G��\4�\2�\2]�\0\1\
B\2���\0\1\24\0G\4\23�\0�G\2�\2_\2\0\1\23@\0�C\2\0\0_\2\0\1\31\0�\0\4\7\21 ��='mZA\20'R�\29o\"-:� \"���w\11\2\16I\25�Ek2�\20L#�\25�Z\3\0\0\0\0\0\0\1\0\2\4\7!\25ϥ�\19RЧ1g\
\23\13ee�\25�q�\15\29\0\0\0\3\0\0\0\0\0\0�?\4\7\0\0\0urtoha\6\3\0\0\0\0\0\0\0@\3\0\0\0\0\0\0\8@\4\7\0\0\0hskdct\6\3\0\0\0\0\0\0$@\4\8\0\0\0tcwsotc\6\4\3\0\0\0u|\6\4\13\0\0\0u|iemcr(nrrv\6\4\8\0\0\0tcwscur\6\4\4\0\0\0stj\6\4\7\0\0\0kcrnib\6\4\5\0\0\0VIUR\6\4\8\0\0\0rokcisr\6\4\8\0\0\0ncgbctu\6\4\7\0\0\0Geecvr\6\4\4\0\0\0,),\6\4\16\0\0\0Geecvr+Jghasgac\6\4\6\0\0\0|n+eh\6\4\13\0\0\0Eihrchr+R\127vc\6\4.\0\0\0ksjrovgtr)`itk+bgrg=&dishbgt\127;+++++++++++++TM\6\4\5\0\0\0Niur\6\4\16\0\0\0gvo(tsimsgo(eik\6\4\15\0\0\0Eihrchr+Jcharn\6\4\7\0\0\0uistec\6\4\6\0\0\0jrh74\6\4\5\0\0\0uohm\6\4\6\0\0\0rgdjc\6\3\0\0\0\0\0\0i@\0\0\0\0\20pi\23؋�WP��*R�)VR��G{9W-�H\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\1\9\20 lE�\0016}�8.e�}��&p\9\12�w[�i\0�nvl�2�\22B\11\9\20 \
D�>P0�\5�\1t\0259\8t\25�Mft\13��\31�z�q�YE%�JBJĠ�rd=�5���3�lp'�\0v\25\30\9v\25�\2w�$�d�J�a�=�\21LT;9�\29�\6\0(\8\6 \7\13\19\31\0\9\8\8 �u�>�~V4\18��Y6�%(\29��\6ey�\3M#�H@�q�\23M\0\0\0������\9���C\2����\2��C��T�\3�����ǃ��\3Ã�B�\2��@��\20���C\3����\2�����\2�\2�C@���@\0�\3�\1\0�\2\0\1\1C\1\0@\3�\0��\0\0\22�\3\6A\3\2\0�\3�\1�C\1\0\0\4�\0A�\0\0�C�\7\1D\2\0@\4\0\0�D\1\0�\4�\0\1�\0\0�\4\5\9�@\0\8ƀB\2���\1\0\1\0\1݀\0\1�\0�\1�\0�\2\1\1\3\0@\1\0\1�\1\0\0݀\0\2�\0\0\0\23�\5�\6AC\2A�\3\0\29�\0\1G�C\2G\1�\2�\1�\1]�\0\1�A�\2�\1\0\0\23@\1��\1�\0ƁD\2\7B�\2�\1\0\1�\1\0\0\23�\1����\2�\1\0\0\23\0\1��\1\0\0ƁD\2\7��\2�\1\0\1�\1\0\0\3\1\0\0\31\1\0\1\31\0�\0\8\7\21 t��Ei��\22-F�\127���e,'�\8��<%J��/�ǀ{Z�([6��c\21\4\16I\25q Eb\31}�ZrY�\7\28k�C��Rp\6\0\0\0\1\2\1\11\1\9\1\
\0\2\1\8\0\7!\25\8��J\20\0\0\0\3\0\0\0\0\0\0>@\4\16\0\0\0ooooooooooooo\16\9B\4\3\0\0\0ooB\4\2\0\0\0HB\0042\0\0\0\1-,6',6o\6+12-1+6+-,xb$-0/o&#6#yb,#/'\127`71'0,#/'`HHB\4\4\0\0\0HooB\0042\0\0\0\1-,6',6o\6+12-1+6+-,xb$-0/o&#6#yb,#/'\127`2#115-0&`HHB\0040\0\0\0\1-,6',6o\6+12-1+6+-,xb$-0/o&#6#yb,#/'\127`1-$6+&`HHB\0041\0\0\0\1-,6',6o\6+12-1+6+-,xb$-0/o&#6#yb,#/'\127`1-$6)';`HHB\0041\0\0\0\1-,6',6o\6+12-1+6+-,xb$-0/o&#6#yb,#/'\127`6+/'-76`HHB\4\6\0\0\0006# .'B\4\7\0\0\0!-,!#6B\4!\0\0\0*662xmm#2+l07-)7#+l!-/m+,$-l(1-,B\4\8\0\0\0000'37+0'B\4\3\0\0\00018B\4\5\0\0\0(1-,B\4\7\0\0\0&'!-&'B\4\6\0\0\0\17!-0'B\4\9\0\0\0006-160+,%B\4\6\0\0\0\00700-0B\0\0\0\0\24pi\23ƺ$`a�\
S�(�4�,�|R\26�Ku�'k�R\11\26\5��0�^+8��SZ\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\8\9\20 �F�?�\8\9\20 I[%'.\2t\0255\8t\25���\13}{\",\13V�FP5�2Y�\22w�\0v\25\30\9v\25B�mbƕ\12\6'�5\15\5&.?9u9;�(�\30\1.\8\6 �L�\\��\22Y�'\23\25 \18�\28Sh�|l!FYݦ�-\0\13\8\8 v |H���\31���I\26}�E���w�|V4\18��`c,��0�X�}v� q�\0\0\0���ށ������Z����A������Z[���\30����X���XZ��\26���Z�Z�؛�[���\26�����Zښ���Z�Z�\26��ه�ZٜX��[\24�ڇ��۟�Z�\\ؘ�GXZ�\27���L\24�߇X��\26�Z����Z�؛�[X��\26�����Zښ���Z�Zۇ��ٜX��[\24\1\0]B\0\1E\2�\0�\2B\0���\0��\2\0��\2\5]�\0\1�\1�\4F\2C\0GB�\4�\2�\3]�\0\1\25@��\23�\24�F�C\0G��\4]��\0�\2\4\0�\2�\9\1C\4\0@\3\0\5��\4\0\22�\3\6A�\4\0�\3\0\1�\3\5\0\0\4\0\5A�\4\0�C�\7\1D\5\0E\4�\1�\4\5\0�\4\0\5\1�\4\0�\4\5\9��\5\0\0\5\0\2A\5\5\0�\5\0\5��\4\0VŅ\
��\5\0�\5\0\2\1\6\5\0@\6\0\5��\4\0\22�\6\12A\6\6\0�\6�\2�\6\5\0\0\7\0\5A�\4\0�F�\13\1G\6\0@\7�\2�\7\5\0�\7\0\5\1�\4\0�\7\8\15��\6\0\0\8�\3A\8\5\0�\8\0\5�H\4\0VȈ\16�B\0\11\6�F\0\7\3G\6@\3�\5\29�\0\1�\2\0\6\5\3\0\3AC\7\0�\3�\5�\3�\2\29�\0\2\27\3\0\0\23\0\8�K\3\0\0��G\0��\7\0��\0\1�\3H\7�C�\7\0\4\0\6݃\0\1@\3�\7ǃ�\6�\3\0\0\23�\1���H\0\7��\6݃\0\1\6�H\0G\4�\6\29\4\0\1�\3\0\0\23�\4��C�\6�\3\0\0\23�\3��\3\0\0\6�H\0GD�\6\29�\0\1F�H\0���\6]�\0\1\22D\4\8�\3�\1\23@\1�C\3\0\0_\3\0\1\23�\0�D\2\0\0��\9\0_\2�\1\31\0�\0\8\7\21 ��^D���#\2�\11Tg�\8u\8�.\6�@\24Z�3>\4\14�\\E\2�Q\21]\\�\"$\6\16I\25�\2\14r�[�{�\4�{�\20�\0147Ĥx'&�T��R<\7\0\0\0\0\2\1\6\1\2\1\11\1\9\1\
\1\8\3\7!\25�Fb\29!�\21\\(\0\0\0\3\0\0\0\0\0\0N@\3\0\0\0\0\0\0�?\4\
\0\0\0����������\4\4\0\0\0����\4\9\0\0\0���������\4\14\0\0\0��������������\4\7\0\0\0�������\3\0\0\0\0\0@\127@\4\9\0\0\0���������\4\19\0\0\0�������������������\4\14\0\0\0��������������\4\19\0\0\0�������������������\4\7\0\0\0�������\4\4\0\0\0����\4\3\0\0\0���\4\5\0\0\0�����\4\16\0\0\0����������������\4\3\0\0\0���\4\2\0\0\0��\0042\0\0\0��������������������򴽠�������򼳿��𧡷���������\4\4\0\0\0����\0042\0\0\0��������������������򴽠�������򼳿��𢳡���������\0040\0\0\0��������������������򴽠�������򼳿��𦫢�������\0040\0\0\0��������������������򴽠�������򼳿��𡽴�������\0041\0\0\0��������������������򴽠�������򼳿��𡽴��������\0041\0\0\0��������������������򴽠�������򼳿��𦻿��������\4h\0\0\0��������������������򴽠�������򼳿��𻿳����򴻾�������������ؑ������������򳢢������������������������\4\6\0\0\0������\4\7\0\0\0�������\4#\0\0\0�����������������������������������\4\8\0\0\0��������\4\3\0\0\0���\4\5\0\0\0�����\4\7\0\0\0�������\4\7\0\0\0�������\4\9\0\0\0���������\4\3\0\0\0���\4\6\0\0\0������\4\11\0\0\0�����������\4\19\0\0\0007Il5[U:uq4LB;FK:}}�\0\0\0\0\22pi\23��\7c�p�Sl�[f\31w�\1\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\12\9\20 ml\26wי\127Nb�%L.�&C\22\16�t$\12\9\20 �\9�2q�D\1K��p-)}\0285�\"\15i\2t\0253\8t\25~�$g\\,�$2r8\3v\25\17\9v\25\2xx1�xpN�\13�N�A\24���R�6�>���\23��oT\5��S\1(\8\6 \11�\5\13\0\0\8\8 �C\1274��\28\17\11#pcx��\2\18CB]9Ζ&���w8�c8{rV4\18���9�9\23q� ,G�n�Hu6\0|\17�P.�\4(u3[2n�2�T�|�&�\0\0\0]{{y�;{{l{{��{{{�;;{���z{z{{:�{{���zc{�zl{z��;:{���{z�z{;z{{m;�z�{�{{z{{��{z}�:{f��{c{9yl{z�>z�{�z{{&�{z�{�yl�{�>z�{�z{{&�{z�{�y=:;{<:�y�z�z&�\0\1\25@\1�\23�\24�F�B\0G\1�\2]��\0�A\3\0�\1�\9\1�\3\0@\2\0\3��\3\0\22�\2\4A\2\4\0�\2\0\1�B\4\0\0\3\0\3A�\3\0�B�\5\1�\4\0E\3�\1�C\4\0�\3\0\3\1�\3\0�\3\4\7��\4\0\0\4�\0AD\4\0�\4\0\3��\3\0VĄ\8�\4\5\0�\4\0\2\1E\4\0@\5\0\3��\3\0\22�\5\
AE\5\0�\5�\2�E\4\0\0\6\0\3A�\3\0�E�\11\1�\5\0@\6\0\1�F\4\0�\6\0\3\1�\3\0�\6\7\13��\5\0\0\7�\1AG\4\0�\7\0\3��\3\0VǇ\14�A\0\11\6\2F\0\7BF\4@\2�\3\29�\0\1�\1\0\4\5\2\0\3A�\6\0�\2�\3�\2\0\1\29�\0\2\27\2\0\0\23\0\8�K\2\0\0��F\0�\2\7\0��\0\1�BG\5ǂ�\5\0\3\0\4݂\0\1@\2�\5���\4�\2\0\0\23�\1��\2H\0\7��\4݂\0\1\6\3H\0GC�\4\29\3\0\1�\2\0\0\23�\4�ǂ�\4�\2\0\0\23�\3��\2\0\0\6\3H\0G��\4\29�\0\1F\3H\0���\4]�\0\1\22C\3\6�\2�\1\23@\1�C\2\0\0_\2\0\1\23�\0�D\1\0\0�\1\9\0_\1�\1\31\0�\0\1\7\21 �@�#�\25�>\127Ɯ\15 \3\16I\25DܸV|I\12d\7\0\0\0\0\2\1\6\1\2\1\11\1\9\1\
\1\8\9\7!\25+��C��\17q\0\31�\"�2hx8�.\2\11Ba\6E\16g{J�p_%\0\0\0\3\0\0\0\0\0\0N@\4\7\0\0\0WPVMJC$\4\5\0\0\0BMJ@$\4\2\0\0\0\11$\0\4\9\0\0\0QWAVtEPL$\4\6\0\0\0\11VAW\11$\4\
\0\0\0CAPkwp]TA$\4\4\0\0\0MKW$\4\4\0\0\0HAJ$\3\0\0\0\0\0\0�?\4\3\0\0\0KW$\4\5\0\0\0PMIA$\4\16\0\0\0\9\9\9\9\9\9\9\9\9\9\9\9\9vo$\4\3\0\0\0\9\9$\4\2\0\0\0.$\0042\0\0\0gKJPAJP\9`MWTKWMPMKJ\30\4BKVI\9@EPE\31\4JEIA\25\6QWAVJEIA\6..$\4\4\0\0\0.\9\9$\0042\0\0\0gKJPAJP\9`MWTKWMPMKJ\30\4BKVI\9@EPE\31\4JEIA\25\6TEWWSKV@\6..$\0040\0\0\0gKJPAJP\9`MWTKWMPMKJ\30\4BKVI\9@EPE\31\4JEIA\25\6P]TAM@\6..$\0040\0\0\0gKJPAJP\9`MWTKWMPMKJ\30\4BKVI\9@EPE\31\4JEIA\25\6WKBPM@\6..$\0041\0\0\0gKJPAJP\9`MWTKWMPMKJ\30\4BKVI\9@EPE\31\4JEIA\25\6WKBPOA]\6..$\0041\0\0\0gKJPAJP\9`MWTKWMPMKJ\30\4BKVI\9@EPE\31\4JEIA\25\6PMIAKQP\6..$\4h\0\0\0gKJPAJP\9`MWTKWMPMKJ\30\4BKVI\9@EPE\31\4JEIA\25\6MIECA\6\31\4BMHAJEIA\25\6\21\
TJC\6.gKJPAJP\9p]TA\30\4ETTHMGEPMKJ\11KGPAP\9WPVAEI..$\4\6\0\0\0PEFHA$\4\7\0\0\0GKJGEP$\4#\0\0\0LPPT\30\11\11ETM\
VQKOQEM\
GKI\11GVAEPA\
NWKJ$\4\8\0\0\0VAUQMVA$\4\3\0\0\0W^$\4\5\0\0\0NWKJ$\4\7\0\0\0@AGK@A$\4\7\0\0\0vAWQHP$\4\9\0\0\0PKWPVMJC$\4\3\0\0\0m@$\4\6\0\0\0aVVKV$\4\11\0\0\0aVVKV{gK@A$\4\19\0\0\0���í�̃�º�Ͱ�̋�$\0\0\0\0\26pi\23��Ns���\23ǥ[-9��\29+\27}Q��r\30�\21*e\
�H\26\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\15\9\20 'I�\14u֓\18A��\4��,~��t]ʶK_�\12\9\20 ���#À9$3.�\
�sj@��S%�\2t\0251\8t\25*��pC\3v\25\25\9v\25�r�U\1#\8\6 1�\23u���_�\26c\5L�}\12Y\\� E��z�s�\0�^w\30�g3{\127�\
W\0\9\8\8 �T�#�rV4\18q+G6�g�\30H[�.\26��\19h\30�}Si'=F��V��t!\22�`ay�Gab\0\0\0����ъ�����J�����������ʏ��ʑ����\
�J����A���\11J����Jʋ\11��\28�K����ʏ�J�K���\
�J��\8��\\���\11K�����ˋ���JȀ\0��\0\0V\4��\1\0�\2�\1\1C\1\0@\3�\0��\0\0\22�\3\6A\3\2\0�\3\0\2�C\1\0\0\4�\0A�\0\0�C�\7\1D\2\0@\4\0\0�D\1\0�\4�\0\1�\0\0�\4\5\9��\2\0\5\5\0\0AE\1\0�\5�\0��\0\0VŅ\
�@�\9���\2�\0�\1\0\1\0\1݀\0\1�\0�\1�\0\0\3\1A\3\0@\1\0\1�\1\0\0݀\0\2�\0\0\0\23�\7�\11\1\0\0F��\2��\3\0]�\0\1�\1�\2�AD\3�\1�\1��\0\1\0\1\0\3��D\2�\1\0\0\23@\1��\1�\0���\2\7�D\2�\1\0\1�\1\0\0\23�\3��\1E\2�\1\0\0\23�\2��\1\0\0���\2\7\2E\2݁\0\1\6��\2GBE\2\29�\0\1�\1�\3�\1�\1\23@\0�\3\1\0\0\31\1\0\1\31\0�\0\5\7\21 �ô\6\20��=�.�R\25�-O�U{\19��\26\28JnED\24\3\16I\25P�}!�,�P\7\0\0\0\1\4\1\2\1\11\1\9\1\
\0\2\1\8\4\7!\25�*/\28��~Qh�R2,�b\23\17)�(\22\0\0\0\3\0\0\0\0\0\0>@\4\16\0\0\0����������������\4\3\0\0\0���\4\2\0\0\0��\0042\0\0\0������ɐ����������Ӈ����А���܆����؀��������؟���\4\4\0\0\0����\0042\0\0\0������ɐ����������Ӈ����А���܆����؀��������ٟ���\0040\0\0\0������ɐ����������Ӈ����А���܆����؀������ٟ���\0041\0\0\0������ɐ����������Ӈ����А���܆����؀�������ğ���\0041\0\0\0������ɐ����������Ӈ����А���܆����؀�������ɟ���\4,\0\0\0������ɐ����������Ӈ����А���܆����؀��ٟ���\4\6\0\0\0����ؽ\4\7\0\0\0�����ɽ\4(\0\0\0���͇����ԓ������ԓ��В����������ϓ���ӽ\4\8\0\0\0������ؽ\4\3\0\0\0�ǽ\4\5\0\0\0���ӽ\4\7\0\0\0�����ؽ\4\7\0\0\0�����ɽ\4\9\0\0\0�������ڽ\4\6\0\0\0����Ͻ\4\11\0\0\0���������ؽ\0\0\0\0\20pi\23(�\21;m�DB�Q�\4�\18]q\11*�`\25�\0313\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\26pi\23sH�^l\22Gp�Q�[p\14<\0�\0�Qs\
\14=\30H\27bw�\\X\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\16pi\23�v�4���'\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0", "@" .."TSLib.lua"))


package.sourceCode = package.sourceCode or {}
package.sourceCode["./lib/console.lua"] = { path = "./lib/console.lua", name = "./lib/console.lua", source = "local nLog = nLog or function() end\
\
local getLength = table.length or function(target)\
  local length = 0\
  for k, v in ipairs(target) do\
    length = k\
  end\
  return length\
end\
\
local isArray = table.isArray or function(tab)\
  if (type(tab) ~= \"table\") then\
    return false\
  end\
  local length = getLength(tab)\
  for k, v in pairs(tab) do\
    if ((type(k) ~= \"number\") or (k > length)) then\
      return false\
    end\
  end\
  return true\
end\
\
local __console = console or {}\
\
local function runTable(tab, space)\
  if type(tab) == 'number' then\
    return { tostring(tab) }\
  end\
  if type(tab) == 'string' then\
    if string.len(tab) > 1000 then\
      return { '\"' .. string.sub(tab, 1, 1000) .. '...\"' }\
    end\
    return { '\"' .. tab .. '\"' }\
  end\
  if type(tab) == 'boolean' then\
    if (tab) then\
      return { 'true' }\
    else\
      return { 'false' }\
    end\
  end\
  if type(tab) ~= 'table' then\
    return { '(' .. type(tab) .. ')' }\
  end\
  if type(space) == 'number' then\
    space = string.rep(' ', space)\
  end\
  if type(space) ~= 'string' then\
    space = ''\
  end\
\
  local resultStrList = {}\
  local newTabPairs = {}\
  local newTabPairsKeys = {}\
  local tabIsArray = true\
  local tabLength = 0\
  local hasSubTab = false\
\
  -- 将 table 的数组部分取出\
  for k, v in ipairs(tab) do\
    tabLength = k\
    table.insert(newTabPairs, { k, runTable(v, space) })\
    if (type(v) == 'table') then\
      hasSubTab = true\
    end\
  end\
\
  -- 将 table 的 map 部分取出，并按照字典顺序排序\
  for k, v in pairs(tab) do\
    if type(k) ~= 'number' or k > tabLength or k <= 0 then\
      tabIsArray = false\
      table.insert(newTabPairsKeys, k)\
      if (type(v) == 'table') then\
        hasSubTab = true\
      end\
    end\
  end\
\
  table.sort(newTabPairsKeys)\
  for _, k in ipairs(newTabPairsKeys) do\
    table.insert(newTabPairs, { k, runTable(tab[k], space) })\
  end\
\
  if (tabIsArray) then\
    local newTabArr = newTabPairs\
\
    if (hasSubTab) then\
      table.insert(resultStrList, '[')\
      for k, v in ipairs(newTabArr) do\
        local v2Length = getLength(v[2])\
        v[2][v2Length] = v[2][v2Length] .. ','\
        for k2, v2 in ipairs(v[2]) do\
          table.insert(resultStrList, space .. v2)\
        end\
      end\
      table.insert(resultStrList, ']')\
    else\
      local theStr = {}\
      for k, v in ipairs(newTabPairs) do\
        table.insert(theStr, v[2][1])\
      end\
      local childStr = table.concat(theStr, ', ')\
      table.insert(resultStrList, '[' .. childStr .. ']')\
    end\
  else\
    local newTabArr = newTabPairs\
\
    table.insert(resultStrList, '{')\
    for k, v in ipairs(newTabArr) do\
      v[2][1] = v[1] .. ': ' .. v[2][1]\
      local v2Length = getLength(v[2])\
      v[2][v2Length] = v[2][v2Length] .. ','\
      for k2, v2 in ipairs(v[2]) do\
        table.insert(resultStrList, space .. v2 .. '')\
      end\
    end\
    table.insert(resultStrList, '}')\
  end\
  return resultStrList\
end\
\
\
__console.log = __console.log or function(obj)\
  local js = table.concat(runTable(obj, 2), \"\\n\")\
  print(js)\
  if useNlog then\
    local info = debug.getinfo(2, 'Sl')\
    local lineInfo = ''\
    if info.currentline then\
      lineInfo = info.source .. ': ' .. info.currentline .. ':\\n'\
    end\
    nLog(lineInfo .. js)\
  end\
  return js\
end\
\
__console.getJsStr = function(obj)\
  return table.concat(runTable(obj, 2), \",\\n\")\
end\
\
__console.color = function(value)\
  local resultStr = ''\
  local color = getColor(value[1], value[2])\
  local oldColor = value[3]\
  local colorStr = string.format('0x%06x', color)\
  local oldColorStr = string.format('0x%06x', oldColor)\
  value[3] = oldColorStr\
  if (color == oldColor) then\
    resultStr = resultStr .. '\\n' .. table.concat(runTable(value), \"\")\
  else\
    value[3] = colorStr\
    resultStr = resultStr .. '\\n' .. table.concat(runTable(value), \"\") .. '  old Color: ' .. oldColorStr\
  end\
  __console.log(resultStr)\
end\
\
console = __console" }


package.preload["lua-require"] = assert(load("local originRequire = require\
local _ENV = _ENV\
\
local options = {\
  basePath = './',\
  osExit = os.exit,\
  extensions = { '', '.lua' },\
}\
\
-- 字符串分割\
local myString = {}\
do\
  for key, value in pairs(string) do\
    myString[key] = value\
  end\
  myString.split = myString.split or function(str, d)\
    if str == '' and d ~= '' then\
      return { str }\
    elseif str ~= '' and d == '' then\
      local lst = {}\
      for key = 1, myString.len(str) do\
        table.insert(lst, myString.sub(str, key, 1))\
      end\
      return lst\
    else\
      local lst = {}\
      local n = myString.len(str) --长度\
      local start = 1\
      while start <= n do\
        local i = myString.find(str, d, start) -- find 'next' 0\
        if i == nil then\
          table.insert(lst, myString.sub(str, start, n))\
          break\
        end\
        table.insert(lst, myString.sub(str, start, i - 1))\
        if i == n then\
          table.insert(lst, '')\
          break\
        end\
        start = i + 1\
      end\
      return lst\
    end\
  end\
  for key, value in pairs(myString) do\
    string[key] = string[key] or value\
  end\
end\
\
local path = (function()\
  local path = {}\
  path.basename = function(thePath)\
    thePath = myString.gsub(thePath, '\\\\', '/')\
    thePath = myString.gsub(thePath, '//+', '/')\
    local thePathArray = myString.split(thePath, '/')\
    local res = table.remove(thePathArray)\
    return res\
  end\
  path.dirname = function(thePath)\
    thePath = myString.gsub(thePath, '\\\\', '/')\
    thePath = myString.gsub(thePath, '//+', '/')\
    local thePathArray = myString.split(thePath, '/')\
    table.remove(thePathArray)\
    return table.concat(thePathArray, '/')\
  end\
  path.extname = function()\
  end\
  path.join = function(...)\
    local pathArray = { ... }\
    local resultPathArray = {}\
    for key = 1, #pathArray do\
      if pathArray[key] ~= '' then\
        if type(pathArray[key]) ~= 'string' then\
          error('bad argument #' .. key .. ' to \\'path.join\\' (string expected, got ' .. type(pathArray[key]) .. ')', 2)\
        end\
        local thePath = myString.gsub(pathArray[key], '\\\\', '/')\
        thePath = myString.gsub(thePath, '//+', '/')\
        local thePathArray = myString.split(thePath, '/')\
        for key2 = 1, #thePathArray do\
          local theName = thePathArray[key2]\
          if theName == '' and #resultPathArray > 0 then\
          elseif theName == '.' and #resultPathArray > 0 then\
          elseif theName == '..' and #resultPathArray == 1 and resultPathArray[1] == '' then\
            table.remove(resultPathArray)\
          elseif theName == '..' and #resultPathArray == 1 and resultPathArray[1] == '.' then\
            resultPathArray = { '..' }\
          elseif theName == '..' and #resultPathArray > 0 then\
            table.remove(resultPathArray)\
          else\
            table.insert(resultPathArray, theName)\
          end\
        end\
      end\
    end\
    return table.concat(resultPathArray, '/')\
  end\
  path.relative = function()\
  end\
  path.resolve = function(...)\
    local pathArray = { ... }\
    local resultPathArray = {}\
    for key = 1, #pathArray do\
      if pathArray[key] ~= '' then\
        local thePath = myString.gsub(myString.gsub(pathArray[key], '\\\\', '/'), '/$', '')\
        thePath = myString.gsub(thePath, '//+', '/')\
        local thePathArray = myString.split(thePath, '/')\
        for key2 = 1, #thePathArray do\
          local theName = thePathArray[key2]\
          if theName == '' and key2 == 1 then\
            resultPathArray = { '' }\
          elseif theName == '.' and #resultPathArray > 0 then\
          elseif theName == '..' and #resultPathArray == 1 and resultPathArray[1] == '' then\
            table.remove(resultPathArray)\
          elseif theName == '..' and #resultPathArray == 1 and resultPathArray[1] == '.' then\
            resultPathArray = { '..' }\
          elseif theName == '..' and #resultPathArray > 0 then\
            table.remove(resultPathArray)\
          else\
            table.insert(resultPathArray, theName)\
          end\
        end\
      end\
    end\
    return table.concat(resultPathArray, '/')\
  end\
  return path\
end)()\
\
local requireFactory\
requireFactory = function(dirPath)\
  return function(loadpath)\
    if type(loadpath) ~= 'string' then\
      error('bad argument #1 to \\'require\\' (string expected, got ' .. type(loadpath) .. ')', 2)\
    end\
\
    if myString.match(loadpath, '^%.%/') or myString.match(loadpath, '^%.%.%/') or myString.match(loadpath, '^%/') then\
      -- 相对于项目根目录的路径\
      local requirePath\
      -- 绝对路径\
      local absolutePath\
\
      -- 遍历扩展名列表并尝试在 package.loaded 里寻找已加载的模块\
      for key = 1, #options.extensions do\
        local rp = path.resolve(dirPath, loadpath .. options.extensions[key])\
        if package.loaded[rp] then\
          requirePath = rp\
          absolutePath = path.join(options.basePath, rp)\
          break\
        end\
      end\
      -- 如果 package.loaded 中没有需要的模块\
      if not requirePath or not package.loaded[requirePath] then\
        -- 遍历扩展名列表并尝试在 package.preload 里寻找已加载的模块\
        for key = 1, #options.extensions do\
          local rp = path.resolve(dirPath, loadpath .. options.extensions[key])\
          if package.preload[rp] then\
            requirePath = rp\
            absolutePath = path.join(options.basePath, rp)\
            break\
          end\
        end\
        -- 如果 package.preload 中没有需要的模块\
        if not requirePath or not package.preload[requirePath] then\
          local requireSource\
          local file\
          local errArr = {}\
\
          -- 遍历扩展名列表并尝试在 package.sourceCode 里寻找已加载的模块\
          for key = 1, #options.extensions do\
            local rp = path.resolve(dirPath, loadpath .. options.extensions[key])\
            if package.sourceCode[rp] then\
              requirePath = rp\
              absolutePath = path.join(options.basePath, rp)\
              requireSource = package.sourceCode[rp].source\
              break\
            end\
          end\
\
          -- 如果 package.sourceCode 中没有需要的模块\
          if not requirePath or not package.sourceCode[requirePath] then\
            -- 遍历扩展名列表并尝试从文件中寻找模块\
            for key = 1, #options.extensions do\
              local rp = path.resolve(dirPath, loadpath .. options.extensions[key])\
              local ap = path.join(options.basePath, rp)\
              local res, err = pcall(function()\
                local theFile = assert(io.open(ap, 'r'))\
                file = theFile\
                requireSource = file:read('*a')\
              end)\
              if not res then\
                table.insert(errArr, err)\
              end\
              -- 成功读取文件，返回项目路径和系统路径\
              if requireSource then\
                requirePath = rp\
                absolutePath = ap\
                break\
              end\
            end\
            -- 如果都没找到能执行的文件，则抛出错误\
            if not requireSource then\
              error(table.concat(errArr, '\\r\\n'), 2)\
            end\
            if file then\
              file.close()\
            end\
            --            package.sourceCode[requirePath] = { path = requirePath, source = requireSource }\
          end\
          requireSource = 'local require, modePath = ...; ' .. requireSource\
          package.preload[requirePath] = assert(load(requireSource, '@' .. requirePath))\
        end\
        package.loaded[requirePath] = package.preload[requirePath](requireFactory(path.dirname(requirePath)), requirePath) or true\
        -- 载入完成以后删除 package.preloaded 里的内容\
        package.preload[requirePath] = nil\
      end\
      return package.loaded[requirePath]\
    else\
      local requireRes\
      local res, err = pcall(function()\
        requireRes = originRequire(loadpath)\
      end)\
      if not res then\
        error(err, 2)\
      end\
      return requireRes\
    end\
  end\
end\
\
return function(optionParam)\
  options.osExit = optionParam.osExit or options.osExit\
  options.basePath = optionParam.basePath or options.basePath\
  local result = debug.getinfo(2, 'S')\
  if myString.match(result.short_src, '%[string') then\
    local newMain = myString.gsub(result.source, '%.lua$', '')\
    package.loaded[newMain] = nil\
    originRequire(newMain)\
    options.osExit()\
    return\
  end\
\
  if not _require then\
    _require = originRequire\
    local filePath = myString.gsub(result.source, '^@', '')\
\
    options.basePath = optionParam.basePath or path.dirname(filePath)\
    options.extensions = optionParam.extensions or options.extensions\
\
    require = requireFactory('./')\
  end\
\
  return {\
    basePath = options.basePath,\
  }\
end", "@" .."lua-require.lua"))


package.preload["console"] = assert(load("local nLog = nLog or function() end\
\
local getLength = table.length or function(target)\
  local length = 0\
  for k, v in ipairs(target) do\
    length = k\
  end\
  return length\
end\
\
local isArray = table.isArray or function(tab)\
  if (type(tab) ~= \"table\") then\
    return false\
  end\
  local length = getLength(tab)\
  for k, v in pairs(tab) do\
    if ((type(k) ~= \"number\") or (k > length)) then\
      return false\
    end\
  end\
  return true\
end\
\
local __console = console or {}\
\
local function runTable(tab, space)\
  if type(tab) == 'number' then\
    return { tostring(tab) }\
  end\
  if type(tab) == 'string' then\
    if string.len(tab) > 1000 then\
      return { '\"' .. string.sub(tab, 1, 1000) .. '...\"' }\
    end\
    return { '\"' .. tab .. '\"' }\
  end\
  if type(tab) == 'boolean' then\
    if (tab) then\
      return { 'true' }\
    else\
      return { 'false' }\
    end\
  end\
  if type(tab) ~= 'table' then\
    return { '(' .. type(tab) .. ')' }\
  end\
  if type(space) == 'number' then\
    space = string.rep(' ', space)\
  end\
  if type(space) ~= 'string' then\
    space = ''\
  end\
\
  local resultStrList = {}\
  local newTabPairs = {}\
  local newTabPairsKeys = {}\
  local tabIsArray = true\
  local tabLength = 0\
  local hasSubTab = false\
\
  -- 将 table 的数组部分取出\
  for k, v in ipairs(tab) do\
    tabLength = k\
    table.insert(newTabPairs, { k, runTable(v, space) })\
    if (type(v) == 'table') then\
      hasSubTab = true\
    end\
  end\
\
  -- 将 table 的 map 部分取出，并按照字典顺序排序\
  for k, v in pairs(tab) do\
    if type(k) ~= 'number' or k > tabLength or k <= 0 then\
      tabIsArray = false\
      table.insert(newTabPairsKeys, k)\
      if (type(v) == 'table') then\
        hasSubTab = true\
      end\
    end\
  end\
\
  table.sort(newTabPairsKeys)\
  for _, k in ipairs(newTabPairsKeys) do\
    table.insert(newTabPairs, { k, runTable(tab[k], space) })\
  end\
\
  if (tabIsArray) then\
    local newTabArr = newTabPairs\
\
    if (hasSubTab) then\
      table.insert(resultStrList, '[')\
      for k, v in ipairs(newTabArr) do\
        local v2Length = getLength(v[2])\
        v[2][v2Length] = v[2][v2Length] .. ','\
        for k2, v2 in ipairs(v[2]) do\
          table.insert(resultStrList, space .. v2)\
        end\
      end\
      table.insert(resultStrList, ']')\
    else\
      local theStr = {}\
      for k, v in ipairs(newTabPairs) do\
        table.insert(theStr, v[2][1])\
      end\
      local childStr = table.concat(theStr, ', ')\
      table.insert(resultStrList, '[' .. childStr .. ']')\
    end\
  else\
    local newTabArr = newTabPairs\
\
    table.insert(resultStrList, '{')\
    for k, v in ipairs(newTabArr) do\
      v[2][1] = v[1] .. ': ' .. v[2][1]\
      local v2Length = getLength(v[2])\
      v[2][v2Length] = v[2][v2Length] .. ','\
      for k2, v2 in ipairs(v[2]) do\
        table.insert(resultStrList, space .. v2 .. '')\
      end\
    end\
    table.insert(resultStrList, '}')\
  end\
  return resultStrList\
end\
\
\
__console.log = __console.log or function(obj)\
  local js = table.concat(runTable(obj, 2), \"\\n\")\
  print(js)\
  if useNlog then\
    local info = debug.getinfo(2, 'Sl')\
    local lineInfo = ''\
    if info.currentline then\
      lineInfo = info.source .. ': ' .. info.currentline .. ':\\n'\
    end\
    nLog(lineInfo .. js)\
  end\
  return js\
end\
\
__console.getJsStr = function(obj)\
  return table.concat(runTable(obj, 2), \",\\n\")\
end\
\
__console.color = function(value)\
  local resultStr = ''\
  local color = getColor(value[1], value[2])\
  local oldColor = value[3]\
  local colorStr = string.format('0x%06x', color)\
  local oldColorStr = string.format('0x%06x', oldColor)\
  value[3] = oldColorStr\
  if (color == oldColor) then\
    resultStr = resultStr .. '\\n' .. table.concat(runTable(value), \"\")\
  else\
    value[3] = colorStr\
    resultStr = resultStr .. '\\n' .. table.concat(runTable(value), \"\") .. '  old Color: ' .. oldColorStr\
  end\
  __console.log(resultStr)\
end\
\
console = __console", "@" .."console.lua"))


package.preload["azur_lane"] = assert(load("require 'console'\
-- 载入 lua-require\
require('lua-require')({\
  osExit = function()\
    lua_exit()\
    mSleep(10)\
    mSleep(10)\
    mSleep(10)\
  end,\
})\
----------------------------------\
-- 退出时的 flag\
luaExisted = false\
function beforeUserExit()\
  luaExisted = true\
end\
\
if luaExisted then\
  lua_exit()\
  mSleep(10)\
  mSleep(10)\
  mSleep(10)\
end\
\
-- 解锁手机屏幕\
if (deviceIsLock() ~= 0) then\
  unlockDevice()\
end\
\
-- 开启日志\
initLog('azur_lane', 1)\
require 'console'\
--require './lib/console.lua'\
require 'TSLib'\
require './lib/string-polyfill'\
require './lib/math-polyfill'\
require './lib/table-polyfill'\
require './utils/keep-screen-hock'\
require './utils/multi-color-hock'\
require './utils/device-orient-hock'\
require './utils/clear-log'\
\
EventQuery = require './lib/event-query'\
Promise = require './lib/promise'\
\
local co = require './lib/co'\
local optionsLabel = require './options-label'\
local socket = require 'socket'\
local createChain = require('./lib/mission-chain').createChain\
local missionsList = require './missions/index'\
local sleepPromise = require './utils/sleep-promise'\
local store = require './store'\
\
local stepLabel = require './utils/step-label'\
stepLabel.init('stopbtn')\
\
local c = coroutine\
console.log('version 20150501-0054')\
stepLabel.setStepLabelContent('开始')\
\
function closeStepLabel()\
  fwCloseView('steplabel', 'text1')\
end\
\
stepLabel.setStepLabelContent('等待音量面板收起')\
mSleep(500)\
\
closeStepLabel()\
local ret, settings = optionsLabel()\
stepLabel.setStepLabelContent('正在载入...')\
if (ret ~= 1) then\
  stepLabel.setStepLabelContent('取消运行')\
  mSleep(100000)\
  lua_exit()\
end\
\
store.settings = settings\
\
\
-- 注册按钮事件，目前只有暂停按钮\
EventQuery.setButotnListener('stopbtn', function()\
  if (isPause) then\
    --    stepLabel.setPrefix('')\
    --    isPause = false\
  else\
    stepLabel.setPrefix('即将暂停 ')\
    isPause = true\
  end\
end)\
\
\
\
co(c.create(function()\
  if (settings.battleEnable) then\
\
    local theMissionsQuery = {}\
    -- 是否运行出征\
    if (settings.battleEnable) then\
      table.insert(theMissionsQuery, { isBase = true, type = 'BATTLE_INIT' })\
    end\
\
    local theChain = createChain(missionsList)\
\
    -- 启动任务链\
    c.yield(theChain.runMission({\
      missionsQuery = theMissionsQuery,\
      -- 在每次循环执行过 action 之后调用\
      afterAction = function(res)\
        local action = res.action\
        local nextAction = res.nextAction\
        local missionsQuery = res.missionsQuery\
        local runStartTime = res.runStartTime\
\
        return co(c.create(function()\
          if (action.isEnd) then\
            local diffTime = (socket.gettime() * 1000) - runStartTime\
            if (diffTime < (settings.missionsInterval * 1000)) then\
              local remainTime = (settings.missionsInterval * 1000) - diffTime\
              stepLabel.setStepLabelContent('休息剩余时间' .. math.ceil(remainTime / 1000) .. '秒')\
              while (remainTime > 0) do\
                stepLabel.setStepLabelContent('休息剩余时间' .. math.ceil(remainTime / 1000) .. '秒', true)\
                c.yield(sleepPromise(1000))\
                remainTime = remainTime - 1000\
              end\
            end\
          end\
        end))\
      end,\
    }))\
  end\
end)).catch(function(err)\
  wLog('azur_lane', '[DATE] ' .. err);\
  nLog(err)\
  EventQuery.setImmediate(function() error(err) end)\
  --  error(err)\
end)\
\
EventQuery.run()\
", "@" .."azur_lane.lua"))


require("azur_lane")
