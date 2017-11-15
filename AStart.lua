local function setPointInMap(p, map)
  map[p[1] .. ',' .. p[2]] = p
end

local function deletePointInMap(p, map)
  map[p[1] .. ',' .. p[2]] = nil
end

local function getPointInMap(p, map)
  return map[p[1] .. ',' .. p[2]]
end

local function pointGenerator(startPoint, endPoint, weight, lastPoint)
  weight = weight or 1
  local point = { startPoint[1], startPoint[2], lastPoint = lastPoint }
  point.G = lastPoint and (lastPoint.G + weight) or 0
  point.H = math.abs(endPoint[1] - startPoint[1]) + math.abs(endPoint[2] - startPoint[2])
  point.F = point.G + point.H
  return point
end

-- 找到F值最小的点，如果F值相同则取靠后的
local function findMinFPoint(list)
  list = list or {}
  local minF
  local minPoint
  local minPointIndex
  for k = 1, #list do
    local v = list[k]
    if not minF or minF >= v.F then
      minF = v.F
      minPoint = v
      minPointIndex = k
    end
  end
  return minPoint, minPointIndex
end

-- 主函数
local AStart = function(startPoint, endPoint, mapObj)
  -- 棋盘宽高
  local width = mapObj.width
  local height = mapObj.height
  -- 障碍物列表
  local obstacleMap = {}
  for key = 1, #mapObj.obstacle do
    setPointInMap(mapObj.obstacle[key], obstacleMap)
  end

  -- 开列表和关列表
  local openList = {}
  local openListMap = {}
  local closeListMap = {}

  -- 将起始点插入开列表
  local theStartPoint = pointGenerator(startPoint, endPoint)
  table.insert(openList, theStartPoint)
  setPointInMap(theStartPoint, openList)

  while #openList > 0 do
    -- 从开列表选出F值最小的点，如果F值大小相同就选靠后的
    openList = table.filter(openList, function(e) return not e.isClosed end)
    local thePoint = findMinFPoint(openList)
    thePoint.isClosed = true
    openList = table.filter(openList, function(e) return not e.isClosed end)
    deletePointInMap(thePoint, openListMap)
    setPointInMap(thePoint, closeListMap)

    -- 左边
    local leftPoint = { thePoint[1], thePoint[2] - 1 }
    if leftPoint[2] >= 1
        and not getPointInMap(leftPoint, closeListMap)
        and not getPointInMap(leftPoint, obstacleMap) then
      local oldOpenPoint = getPointInMap(leftPoint, openListMap)
      local newPoint = pointGenerator(leftPoint, endPoint, 1, thePoint)
      if oldPoint and oldOpenPoint.F > newPoint.F then
        oldOpenPoint.isClosed = true
        openList = table.filter(openList, function(e) return not e.isClosed end)
        deletePointInMap(oldOpenPoint, openListMap)
      end
      if not oldPoint or oldOpenPoint.F > newPoint.F then
        table.insert(openList, newPoint)
        setPointInMap(newPoint, openListMap)
        if newPoint.H == 0 then
          break
        end
      end
    end
    -- 右边
    local rightPoint = { thePoint[1], thePoint[2] + 1 }
    if rightPoint[2] <= width
        and not getPointInMap(rightPoint, closeListMap)
        and not getPointInMap(rightPoint, obstacleMap) then
      local oldOpenPoint = getPointInMap(rightPoint, openListMap)
      local newPoint = pointGenerator(rightPoint, endPoint, 1, thePoint)
      if oldPoint and oldOpenPoint.F > newPoint.F then
        oldOpenPoint.isClosed = true
        openList = table.filter(openList, function(e) return not e.isClosed end)
        deletePointInMap(oldOpenPoint, openListMap)
      end
      if not oldPoint or oldOpenPoint.F > newPoint.F then
        table.insert(openList, newPoint)
        setPointInMap(newPoint, openListMap)
        if newPoint.H == 0 then
          break
        end
      end
    end
    -- 上边
    local upPoint = { thePoint[1] - 1, thePoint[2] }
    if upPoint[1] >= 1
        and not getPointInMap(upPoint, closeListMap)
        and not getPointInMap(upPoint, obstacleMap) then
      local oldOpenPoint = getPointInMap(upPoint, openListMap)
      local newPoint = pointGenerator(upPoint, endPoint, 1, thePoint)
      if oldPoint and oldOpenPoint.F > newPoint.F then
        oldOpenPoint.isClosed = true
        openList = table.filter(openList, function(e) return not e.isClosed end)
        deletePointInMap(oldOpenPoint, openListMap)
      end
      if not oldPoint or oldOpenPoint.F > newPoint.F then
        table.insert(openList, newPoint)
        setPointInMap(newPoint, openListMap)
        if newPoint.H == 0 then
          break
        end
      end
    end
    -- 下边
    local downPoint = { thePoint[1] + 1, thePoint[2] }
    if downPoint[1] <= height
        and not getPointInMap(downPoint, closeListMap)
        and not getPointInMap(downPoint, obstacleMap) then
      local oldOpenPoint = getPointInMap(upPoint, openListMap)
      local newPoint = pointGenerator(upPoint, endPoint, 1, thePoint)
      if oldPoint and oldOpenPoint.F > newPoint.F then
        oldOpenPoint.isClosed = true
        openList = table.filter(openList, function(e) return not e.isClosed end)
        deletePointInMap(oldOpenPoint, openListMap)
      end
      if not oldPoint or oldOpenPoint.F > newPoint.F then
        table.insert(openList, newPoint)
        setPointInMap(newPoint, openListMap)
        if newPoint.H == 0 then
          break
        end
      end
    end
  end

  -- 如果列表最后一个点是终点，说明已找到路线。否则说明无法到达目标
  if #openList > 0 and openList[#openList].H == 0 then
    local path = {}
    local p = openList[#openList]
    while p.lastPoint do
      table.insert(path, p)
      p = p.lastPoint
    end
    for i = 1, #path do
      path[i].lastPoint = nil
    end
    -- 反转table
    local newPath = {}
    for i = #path, 1, -1 do
      table.insert(newPath, path[i])
    end
    return newPath
  end
end

return AStart;
