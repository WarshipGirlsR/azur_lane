local sWidth, sHeight = getScreenSize();

local map = {}

-- 舰队坐标修正向量
local myFleetListCorrectionValue = (function()
  local point = {
    { 965, 474, 0xded28c },
    { 909, 689, 0x313531 },
  }
  return { point[2][1] - point[1][1], point[2][2] - point[1][2] }
end)()
-- 选中的舰队头上的绿色箭头的坐标修正向量
local selectedArrowCorrectionValue = (function()
  local point = {
    { 455, 272, 0x3aff84 },
    { 456, 568, 0xa49ead },
  }
  return { point[2][1] - point[1][1], point[2][2] - point[1][2] }
end)()
-- 敌人坐标修正向量
local enemyListCorrectionValue = (function()
  local point = {
    { 1029, 632, 0xde9a00 },
    { 1097, 714, 0xef796b },
  }
  return { point[2][1] - point[1][1], point[2][2] - point[1][2] }
end)()

-- 将数组形式的棋盘坐标列表转换为索引形式的，为了方便去重和查找
-- 例如：
-- local list = {
--   { 1, 2 },
--   { 3, 4 },
-- }
-- 转换为
-- local list = {
--   ['1-2'] = { 1, 2 }
--   ['3-4'] = { 3, 4 }
-- }
function transListToMap(list)
  local result = {}
  for _, item in pairs(list) do
    result[item[1] .. '-' .. item[2]] = item
  end
  return result
end

-- 检查坐标点在直线的左边还是右边，直线用两点表示
function checkPointPosition(checkPoint, topPoint, bottonPoint)
  if topPoint[2] == bottonPoint[2] then
    if checkPoint[1] < topPoint[1] then
      return -1
    elseif checkPoint[1] > topPoint[1] then
      return 1
    end
    return 0
  end
  local x = (checkPoint[2] - topPoint[2]) * (bottonPoint[1] - topPoint[1]) / (bottonPoint[2] - topPoint[2]) + topPoint[1]
  if checkPoint[1] < x then
    return -1
  elseif checkPoint[1] > x then
    return 1
  end
  return 0
end

-- 将屏幕坐标列表转换为地图棋盘坐标列表
function transPointListToChessboardPointList(positionMap, positionList)
  local result = {}
  for i = 1, #positionList do
    local theRow = -1
    local theCol = -1
    local item = positionList[i]
    for row = 1, #positionMap do
      if positionMap[row][1][2] > item[2] then
        theRow = row - 1
        break
      end
    end
    for col = 1, #positionMap[1] do
      if checkPointPosition(item, positionMap[1][col], positionMap[#positionMap][col]) <= 0 then
        theCol = col - 1
        break
      end
    end
    table.insert(result, { theRow, theCol })
  end
  return result
end

-- 将地图棋盘坐标列表转换为屏幕坐标列表
function transChessboardPointListToPositionList(positionMap, pointList)
  local result = {}
  for _, item in pairs(pointList) do
    local leftTop = positionMap[item[1]][item[2]]
    local rightTop = positionMap[item[1]][item[2] + 1]
    local leftBotton = positionMap[item[1] + 1][item[2]]
    local rightBotton = positionMap[item[1] + 1][item[2] + 1]
    local theLeft = (leftTop[1] + rightTop[1] + leftBotton[1] + rightBotton[1]) / 4
    local theTop = (leftTop[2] + rightTop[2] + leftBotton[2] + rightBotton[2]) / 4
    theLeft = math.floor(theLeft)
    theTop = math.floor(theTop)
    table.insert(result, { theLeft, theTop })
  end
  return result
end

-- 获取地图采样位置。由于地图可能超出一屏，所以这里可以定义多个采样位置。每次扫描都会对每个采样位置进行扫描
-- 标志位为地图四个角。每个采样位置只需定义一个角的坐标即可。
-- 还需要定义每个采样位置的地图矩阵与屏幕坐标的映射关系
map.getCheckpositionList = function()
  return {}
end

-- 获取地图棋盘和相关数据
map.getMapChessboard = function()
  return {}
end

-- 检查地图在屏幕中的位置，返回地图四个角的坐标
map.getMapPosition = function(ImgInfo)
  local __keepScreenState = keepScreenState
  if not __keepScreenState then keepScreen(true) end

  local isCenter = false
  -- 扫描边界
  keepScreen(true)
  -- 地图上边界2，由于上边界颜色并不清晰，所以准备2个上边界扫描工具
  local topLinePointList = ImgInfo.toPoint(findMultiColorInRegionFuzzyExt(table.unpack(ImgInfo.map.topLine)))
  local bottonLinePointList = ImgInfo.toPoint(findMultiColorInRegionFuzzyExt(table.unpack(ImgInfo.map.bottonLine)))
  local leftLinePointList = ImgInfo.toPoint(findMultiColorInRegionFuzzyExt(table.unpack(ImgInfo.map.leftLine)))
  local rightLinePointList = ImgInfo.toPoint(findMultiColorInRegionFuzzyExt(table.unpack(ImgInfo.map.rightLine)))

  local topLinePoint = topLinePointList[1] or { -1, -1 }
  local bottonLinePoint = bottonLinePointList[1] or { -1, -1 }

  function getTopAndBottonPoint(topLinePoint, bottonLinePoint, pointList)
    -- 获取左右边界的上下两点(就是算四个叫的坐标)
    -- 这个函数求一条斜边的上点和下点，需要2次才能计算出四个角
    -- 结果第一个是上点，第二个是下点
    local result = { false, false }
    if pointList and #pointList > 0 then
      if topLinePoint and topLinePoint[1] > 0 then
        local Y1 = math.floor(topLinePoint[2])
        local point1 = pointList[1] or { -1, -1 }
        local point2 = pointList[#pointList] or { -1, -1 }
        local X1 = (Y1 - point1[2]) / (point2[2] - point1[2]) * (point2[1] - point1[1]) + point1[1] or -1
        X1 = math.trueNumber(X1) or -1
        X1 = math.floor(X1)
        result[1] = { X1, Y1 }
      end
      if bottonLinePoint and bottonLinePoint[1] > 0 then
        local Y2 = math.floor(bottonLinePoint[2])
        local point1 = pointList[1] or { -1, -1 }
        local point2 = pointList[#pointList] or { -1, -1 }
        local X2 = (Y2 - point1[2]) / (point2[2] - point1[2]) * (point2[1] - point1[1]) + point1[1] or -1
        X2 = math.trueNumber(X2) or -1
        X2 = math.floor(X2)
        result[2] = { X2, Y2 }
      end
    end
    return result
  end

  local leftPoint = getTopAndBottonPoint(topLinePoint, bottonLinePoint, leftLinePointList)
  local rightPoint = getTopAndBottonPoint(topLinePoint, bottonLinePoint, rightLinePointList)

  if not __keepScreenState then keepScreen(false) end
  return {
    leftTop = leftPoint[1],
    rightTop = rightPoint[1],
    leftBotton = leftPoint[2],
    rightBotton = rightPoint[2],
  }
end

-- 检查地图位置与预设位置的偏差
map.getMoveVector = function(ImgInfo, currentPosition, targetPosition)
  local __keepScreenState = keepScreenState
  if not __keepScreenState then keepScreen(true) end

  local isCenter = false;

  -- 计算偏差
  local moveVector = { 0, 0 }
  if targetPosition.leftTop then
    if not currentPosition.leftTop then
      moveVector = { sWidth / 10, sHeight / 10 }
    else
      moveVector[1] = targetPosition.leftTop[1] - currentPosition.leftTop[1];
      moveVector[2] = targetPosition.leftTop[2] - currentPosition.leftTop[2];
    end
  elseif targetPosition.rightTop then
    if not currentPosition.rightTop then
      moveVector = { (0 - sWidth) / 10, sHeight / 10 }
    else
      moveVector[1] = targetPosition.rightTop[1] - currentPosition.rightTop[1];
      moveVector[2] = targetPosition.rightTop[2] - currentPosition.rightTop[2];
    end
  elseif targetPosition.leftBotton then
    if not currentPosition.leftBotton then
      moveVector = { sWidth / 10, (0 - sHeight) / 10 }
    else
      moveVector[1] = targetPosition.leftBotton[1] - currentPosition.leftBotton[1];
      moveVector[2] = targetPosition.leftBotton[2] - currentPosition.leftBotton[2];
    end
  elseif targetPosition.rightBotton then
    if not currentPosition.rightBotton then
      moveVector = { (0 - sWidth) / 10, (0 - sHeight) / 10 }
    else
      moveVector[1] = targetPosition.rightBotton[1] - currentPosition.rightBotton[1];
      moveVector[2] = targetPosition.rightBotton[2] - currentPosition.rightBotton[2];
    end
  end

  if not __keepScreenState then keepScreen(false) end
  return moveVector
end

-- 将地图移动到指定位置
map.moveMapToCheckPosition = function(ImgInfo, moveVector)
  local __keepScreenState = keepScreenState
  if not __keepScreenState then keepScreen(true) end

  local isCenter = false;

  -- 将地图移动到中心
  local moveStep
  if (math.abs(moveVector[1]) > 4) or (math.abs(moveVector[2]) > 4) then
    -- 因为屏幕滑动和画面滚动不一致，所以需要减少移动幅度
    moveStep = math.max(math.abs(moveVector[1]), math.abs(moveVector[2]))
    moveStep = math.min(10, moveStep)
    moveStep = math.abs(moveStep)
    moveStep = math.floor(moveStep)
    moveStep = math.max(1, moveStep)
    moveTo(sWidth / 2, sHeight / 2, sWidth / 2 + moveVector[1], sHeight / 2 + moveVector[2], moveStep, 100)
    -- 如果moveStep总是相同说明是移动距离太小滑动屏幕失效。
  else
    isCenter = true
  end
  if not __keepScreenState then keepScreen(false) end
  return isCenter, moveStep
end

map.scanMap = function(ImgInfo, targetPosition, mapChessboard)
  local positionMap = targetPosition.positionMap

  -- 坐标修正偏差，因为搜索的图像并不在它所在的棋盘格子里
  function corrected(list, correctionValue)
    local res = {}
    for _, item in ipairs(list) do
      table.insert(res, { item[1] + correctionValue[1], item[2] + correctionValue[2] })
    end
    return res
  end

  -- 扫描屏幕上的对象
  local myFleetList = ImgInfo.toPoint(findMultiColorInRegionFuzzyExt(table.unpack(ImgInfo.map.myFleet)))
  myFleetList = corrected(myFleetList, myFleetListCorrectionValue)
  local selectedArrowList = ImgInfo.toPoint(findMultiColorInRegionFuzzyExt(table.unpack(ImgInfo.map.selectedArrow)))
  selectedArrowList = corrected(selectedArrowList, selectedArrowCorrectionValue)
  local enemyList1 = ImgInfo.toPoint(findMultiColorInRegionFuzzyExt(table.unpack(ImgInfo.map.enemyList1)))
  enemyList1 = corrected(enemyList1, enemyListCorrectionValue)
  local enemyList2 = ImgInfo.toPoint(findMultiColorInRegionFuzzyExt(table.unpack(ImgInfo.map.enemyList2)))
  enemyList2 = corrected(enemyList2, enemyListCorrectionValue)
  local enemyList3 = ImgInfo.toPoint(findMultiColorInRegionFuzzyExt(table.unpack(ImgInfo.map.enemyList3)))
  enemyList3 = corrected(enemyList3, enemyListCorrectionValue)
  local enemyList = table.merge(enemyList1, enemyList2, enemyList3)
  local bossList1 = ImgInfo.toPoint(findMultiColorInRegionFuzzyExt(table.unpack(ImgInfo.map.bossPoint1)))
  local bossList2 = ImgInfo.toPoint(findMultiColorInRegionFuzzyExt(table.unpack(ImgInfo.map.bossPoint2)))
  local bossList = table.merge(bossList1, bossList2)
  local selectedArrowList = transPointListToChessboardPointList(positionMap, selectedArrowList)
  mapChessboard.myFleetList = table.merge(selectedArrowList, transPointListToChessboardPointList(positionMap, myFleetList))
  mapChessboard.myFleetList = table.unique(mapChessboard.myFleetList, function(item)
    return item[1] .. '-' .. item[2]
  end)
  mapChessboard.enemyPositionList = table.merge(mapChessboard.enemyPositionList, transPointListToChessboardPointList(positionMap, enemyList))
  mapChessboard.enemyPositionList = table.unique(mapChessboard.enemyPositionList, function(item)
    return item[1] .. '-' .. item[2]
  end)
  -- 假如舰队和敌方重合了，我方标记会向下移动一格，导致扫描结果有偏差。
  -- 目前无法区分是舰队与敌方重合还是舰队在地方下面。

  mapChessboard.bossPosition = table.merge(mapChessboard.bossPosition, transPointListToChessboardPointList(positionMap, bossList))
  mapChessboard.bossPosition = table.unique(mapChessboard.bossPosition, function(item)
    return item[1] .. '-' .. item[2]
  end)
  console.log(mapChessboard)
  return mapChessboard
end

map.moveToPoint = function(ImgInfo, targetPosition, point)
  local positionMap = targetPosition.positionMap
  local tapPointList = transChessboardPointListToPositionList(positionMap, { point })
  tap(tapPointList[1][1], tapPointList[1][2], 100)
end

map.findClosestEnemy = function(ImgInfo, mapChessboard)
  function calCoast(currentPoint, targetPoint)
    return math.abs(targetPoint[1] - currentPoint[1]) + math.abs(targetPoint[2] - currentPoint[2])
  end

  local myField = mapChessboard.myFleetList[1]
  local enemyPositionList = mapChessboard.enemyPositionList
  local minCoast = 100000
  local minCoastEnemy
  for _, enemy in ipairs(enemyPositionList) do
    local theCoast = calCoast(myField, enemy)
    if minCoast > theCoast then
      minCoast = theCoast
      minCoastEnemy = enemy
      break
    end
  end

  return minCoastEnemy
end

return map