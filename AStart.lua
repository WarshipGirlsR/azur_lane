local function isPointInList(point, list)
  for k = 1, #list do
    local v = list[k]
    if point[1] == v[1] and point[2] == v[2] then
      return true
    end
  end
  return false
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
  local obstacle = mapObj.obstacle
  -- 开列表和关列表
  local openList = {}
  local closeList = {}

  -- 将起始点插入开列表
  local theStartPoint = { startPoint[1], startPoint[2] }
  theStartPoint.G = 0
  theStartPoint.H = math.abs(endPoint[1] - theStartPoint[1]) + math.abs(endPoint[2] - theStartPoint[2])
  theStartPoint.F = theStartPoint.G + theStartPoint.H
  theStartPoint.lastPoint = nil

  table.insert(openList, theStartPoint)

  while #openList > 0 do
    -- 从开列表选出F值最小的点，如果F值大小相同就选靠后的
    local thePoint, thePointIndex = findMinFPoint(openList)
    table.remove(openList, thePointIndex)
    table.insert(closeList, thePoint)

    -- 左边
    local leftPoint = { thePoint[1], thePoint[2] - 1 }
    if leftPoint[2] >= 1
      and not isPointInList(leftPoint, closeList)
      and not isPointInList(leftPoint, obstacle) then
      leftPoint.G = thePoint.G + 1
      leftPoint.H = math.abs(endPoint[1] - leftPoint[1]) + math.abs(endPoint[2] - leftPoint[2])
      leftPoint.F = leftPoint.G + leftPoint.H
      leftPoint.lastPoint = thePoint
      table.insert(openList, leftPoint)
      if leftPoint.H == 0 then
        break
      end
    end
    -- 右边
    local rightPoint = { thePoint[1], thePoint[2] + 1 }
    if rightPoint[2] <= width
      and not isPointInList(rightPoint, closeList)
      and not isPointInList(rightPoint, obstacle) then
      rightPoint.G = thePoint.G + 1
      rightPoint.H = math.abs(endPoint[1] - rightPoint[1]) + math.abs(endPoint[2] - rightPoint[2])
      rightPoint.F = rightPoint.G + rightPoint.H
      rightPoint.lastPoint = thePoint
      table.insert(openList, rightPoint)
      if rightPoint.H == 0 then
        break
      end
    end
    -- 上边
    local topPoint = { thePoint[1] - 1, thePoint[2] }
    if topPoint[1] >= 1
      and not isPointInList(topPoint, closeList)
      and not isPointInList(topPoint, obstacle) then
      topPoint.G = thePoint.G + 1
      topPoint.H = math.abs(endPoint[1] - topPoint[1]) + math.abs(endPoint[2] - topPoint[2])
      topPoint.F = topPoint.G + topPoint.H
      topPoint.lastPoint = thePoint
      table.insert(openList, topPoint)
      if topPoint.H == 0 then
        break
      end
    end
    -- 下边
    local bottonPoint = { thePoint[1] + 1, thePoint[2] }
    if bottonPoint[1] <= height
      and not isPointInList(bottonPoint, closeList)
      and not isPointInList(bottonPoint, obstacle) then
      bottonPoint.G = thePoint.G + 1
      bottonPoint.H = math.abs(endPoint[1] - bottonPoint[1]) + math.abs(endPoint[2] - bottonPoint[2])
      bottonPoint.F = bottonPoint.G + bottonPoint.H
      bottonPoint.lastPoint = thePoint
      table.insert(openList, bottonPoint)
      if bottonPoint.H == 0 then
        break
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
