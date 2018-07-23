local utils = require './utils'
local AStart = require '../../utils/a-start'
local _sWidth, _sHeight = getScreenSize()
local sWidth = math.max(_sWidth, _sHeight)
local sHeight = math.min(_sWidth, _sHeight)

local map = {}


-- 舰队坐标修正向量
local myFleetListCorrectionValue = (function()
  local point = {
    { 1328, 343, 0xd68142 },
    { 1277, 528, 0xb5b6b5 },
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
    { 846, 438, 0xdeaa00 },
    { 899, 500, 0xcebe94 },
  }
  return { point[2][1] - point[1][1], point[2][2] - point[1][2] }
end)()
-- 奖励点坐标修正向量
local rewardBoxListCorrectionValue = (function()
  local point = {
    { 1126, 859, 0x8cffef },
    { 1122, 939, 0x000810 },
  }
  return { point[2][1] - point[1][1], point[2][2] - point[1][2] }
end)()
-- 坐标修正偏差方法，因为搜索的图像并不在它所在的棋盘格子里
local corrected = function(list, deviationValue, deviation)
  local deviationX = 0
  local deviationY = 0
  if type(deviation) == 'table' then
    deviationX = deviation[1] or 0
    deviationY = deviation[2] or 0
  end
  local res = {}
  for key = 1, #list do
    local item = list[key]
    table.insert(res, { item[1] + deviationValue[1] + deviationX, item[2] + deviationValue[2] + deviationY })
  end
  return res
end


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
local function transListToMap(list)
  local result = {}
  for _, item in pairs(list) do
    result[item[1] .. '-' .. item[2]] = item
  end
  return result
end

-- 将点按照相邻分组，连成一片的就分为一组
local function listAdjacentGroups(list)
  local theList = table.assign({}, list)
  local theListMap = transListToMap(theList)
  local group = {}
  while #theList > 0 do
    local groupItem = {}
    table.insert(groupItem, theList[1])
    theListMap[theList[1][1] .. '-' .. theList[1][2]] = nil
    local theIndex = 1
    while theIndex <= #groupItem do
      local item = groupItem[theIndex]
      -- 将相邻的点都加入队列
      if theListMap[(item[1] + 1) .. '-' .. item[2]] then
        local index = (item[1] + 1) .. '-' .. item[2]
        table.insert(groupItem, theListMap[index])
        theListMap[index] = nil
      elseif theListMap[(item[1] - 1) .. '-' .. item[2]] then
        local index = (item[1] - 1) .. '-' .. item[2]
        table.insert(groupItem, theListMap[index])
        theListMap[index] = nil
      elseif theListMap[item[1] .. '-' .. (item[2] + 1)] then
        local index = item[1] .. '-' .. (item[2] + 1)
        table.insert(groupItem, theListMap[index])
        theListMap[index] = nil
      elseif theListMap[item[1] .. '-' .. (item[2] - 1)] then
        local index = item[1] .. '-' .. (item[2] - 1)
        table.insert(groupItem, theListMap[index])
        theListMap[index] = nil
      elseif theListMap[(item[1] - 1) .. '-' .. (item[2] - 1)] then
        local index = (item[1] - 1) .. '-' .. (item[2] - 1)
        table.insert(groupItem, theListMap[index])
        theListMap[index] = nil
      elseif theListMap[(item[1] + 1) .. '-' .. (item[2] - 1)] then
        local index = (item[1] + 1) .. '-' .. (item[2] - 1)
        table.insert(groupItem, theListMap[index])
        theListMap[index] = nil
      elseif theListMap[(item[1] - 1) .. '-' .. (item[2] + 1)] then
        local index = (item[1] - 1) .. '-' .. (item[2] + 1)
        table.insert(groupItem, theListMap[index])
        theListMap[index] = nil
      elseif theListMap[(item[1] + 1) .. '-' .. (item[2] + 1)] then
        local index = (item[1] + 1) .. '-' .. (item[2] + 1)
        table.insert(groupItem, theListMap[index])
        theListMap[index] = nil
      end

      theIndex = theIndex + 1
    end
    table.insert(group, groupItem)
    theList = table.values(theListMap)
  end
  return group
end

-- 检查坐标点在直线的左边还是右边，直线用两点表示
local function checkPointPosition(checkPoint, topPoint, bottomPoint)
  if topPoint[2] == bottomPoint[2] then
    if checkPoint[1] < topPoint[1] then
      return -1
    elseif checkPoint[1] > topPoint[1] then
      return 1
    end
    return 0
  end
  local x = (checkPoint[2] - topPoint[2]) * (bottomPoint[1] - topPoint[1]) / (bottomPoint[2] - topPoint[2]) + topPoint[1]
  if checkPoint[1] < x then
    return -1
  elseif checkPoint[1] > x then
    return 1
  end
  return 0
end

-- 将屏幕坐标列表转换为地图棋盘坐标列表
local function transPointListToChessboardPointList(positionMap, positionList)
  local result = {}
  -- 因为有可能有空的坐标，所以需要处理
  -- 计算出地图棋盘的宽度
  local height = #positionMap
  local width = 0
  for _, row in ipairs(positionMap) do
    if row then
      width = math.max(width, #row)
    end
  end
  for i = 1, #positionList do
    local theRow = -1
    local theCol = -1
    local item = positionList[i]
    -- 匹配点在第几行。
    -- 保证匹配的点在检查的棋盘里，棋盘之外的目标不放入棋盘
    for rowNum, row in ipairs(positionMap) do
      if row then
        local theRowPoint = nil
        for _, col in ipairs(row) do
          if col then
            theRowPoint = col
            break
          end
        end
        if theRowPoint[2] < item[2] then
          theRow = rowNum
        else
          break
        end
      end
    end
    if theRow > #positionMap - 1 then
      theRow = -1
    end

    if theRow > 0 then
      -- 匹配点在第几列
      -- 保存最左边那条线的两个点，匹配目標必須在第1条线和第n条线的中间
      -- 避免匹配到第1条线左边的点
      local firstTopPoint = nil
      local firstBottomPoint = nil
      for col = 1, width do
        -- 寻找这一列最高和最低的两个点，做直线
        local topPoint
        local bottomPoint
        for row = 1, height do
          if positionMap[row] and positionMap[row][col] then
            if not topPoint then
              topPoint = positionMap[row][col]
            else
              bottomPoint = positionMap[row][col]
            end
          end
        end
        if topPoint and bottomPoint then
          if checkPointPosition(item, topPoint, bottomPoint) > 0 then
            theCol = col
          else
            break
          end
        end
      end
      if theCol > width - 1 then
        theCol = -1
      end
      if theCol > 0 then
        table.insert(result, { theRow, theCol })
      end
    end
  end
  return result
end

-- 将地图棋盘坐标列表转换为屏幕坐标列表
local function transChessboardPointListToPositionList(positionMap, pointList)
  local result = {}
  for _, item in pairs(pointList) do
    local leftTop = positionMap[item[1]][item[2]]
    local rightTop = positionMap[item[1]][item[2] + 1]
    local leftBottom = positionMap[item[1] + 1][item[2]]
    local rightBottom = positionMap[item[1] + 1][item[2] + 1]
    local theLeft = (leftTop[1] + rightTop[1] + leftBottom[1] + rightBottom[1]) / 4
    local theTop = (leftTop[2] + rightTop[2] + leftBottom[2] + rightBottom[2]) / 4
    theLeft = math.floor(theLeft)
    theTop = math.floor(theTop)
    table.insert(result, { theLeft, theTop })
  end
  return result
end


-- 搜索一个颜色列表
local function findMultiColorList(ImgInfo, list, simpleMode)
  local res = {}
  for key = 1, #list do
    local myFleet = list[key]
    res = table.merge(res, findMultiColorInRegionFuzzyExt(table.unpack(myFleet)))
    if simpleMode and #res > 0 then
      break
    end
  end
  return ImgInfo.toPoint(res)
end

-- 将列表转换成索引方便查询
local function makePointMap(list)
  local theMap = {}
  for key = 1, #list do
    local point = list[key]
    theMap[point[1] .. '-' .. point[2]] = point
  end
  return theMap
end

-- ----------------------------------------------------------------------------------------------------------

-- 获取地图采样位置。由于地图可能超出一屏，所以这里可以定义多个采样位置。每次扫描都会对每个采样位置进行扫描
-- 标志位为地图四个角。每个采样位置只需定义一个角的坐标即可。
-- 还需要定义每个采样位置的地图矩阵与屏幕坐标的映射关系
map.getCheckpositionList = function()
  error('章节尚未适配')
end

-- 处理原始地图数据，生成程序需要的数据
map.calCheckpositionList = function(list)
  -- 补全列表中空余的数据
  for key = 1, #list do
    local positionMap = list[key].positionMap
    for rowNum, rol in ipairs(positionMap) do
      if rol then
        -- 分别从左右向中间夹紧获取需要补全的范围
        local left = 1
        for i = 1, #rol do
          left = i
          if rol[i] then break end
        end
        local right = #rol
        for i = #rol, left, -1 do
          right = i
          if rol[i] then break end
        end
        -- 补全坐标点
        if left + 2 <= right then
          local leftX = rol[left][1]
          local leftY = rol[left][2]
          local width = rol[right][1] - rol[left][1]
          local itemNum = right - left
          for i = left + 1, right - 1 do
            positionMap[rowNum][i] = positionMap[rowNum][i] or {
              math.floor(leftX + width / itemNum * (i - left)),
              leftY,
              0x000000,
            }
          end
        end
      end
    end
  end

  -- 获取地图每行交点的索引
  for key = 1, #list do
    list[key].pointMap = list[key].pointMap or {}
    local positionMap = list[key].positionMap or {}
    for rowNum, rol in ipairs(positionMap) do
      if rol and positionMap[rowNum + 1] then
        for colNum, col in ipairs(rol) do
          if col and rol[colNum + 1] then
            list[key].pointMap[rowNum .. '-' .. colNum] = col
          end
        end
      end
    end
  end
  return list
end

-- 获取地图棋盘和相关数据
map.getMapChessboard = function()
  error('章节尚未适配')
end

-- 检查地图在屏幕中的位置，返回地图四个角的坐标
map.getMapPosition = function(ImgInfo, targetPosition)
  local __keepScreenState = keepScreenState
  if __keepScreenState then keepScreen(false) end
  getColor(0, 0)
  keepScreen(true)
  local isCenter = false
  -- 扫描边界
  local topLinePointList = {}
  local bottomLinePointList = {}
  local leftLinePointList = {}
  local rightLinePointList = {}

  -- 地图3条边是黑色，上边是半透明色，所以先用黑色找到左右下边框
  local blackLineList = ImgInfo.filterNoUsePoint(ImgInfo.toPoint(findMultiColorInRegionFuzzyExt(0x000000, '', 100, 184, 160, 1885, 1004)))

  -- 寻找底边
  -- 按照y坐标分组
  local blackLineGroup = {}
  for key = 1, #blackLineList do
    local value = blackLineList[key]
    blackLineGroup[value[2]] = blackLineGroup[value[2]] or {}
    table.insert(blackLineGroup[value[2]], value)
  end
  -- 横向坐标点超过200个点的组
  local bottomHorizontalLineGroup = {}
  for key, value in pairs(blackLineGroup) do
    if #value > 200 then
      table.insert(bottomHorizontalLineGroup, value)
    end
  end

  bottomLinePointList = math.minTable(bottomHorizontalLineGroup, function(item) return item[1][2] end) or {}

  -- 寻找左右纵向黑线的坐标
  -- 将横向黑线移除
  local tmpGroup = table.assign({}, blackLineGroup)
  for key, value in pairs(bottomHorizontalLineGroup) do
    tmpGroup[value[1][2]] = nil
  end
  local verticalLineList = {}
  for _, value in pairs(tmpGroup) do
    for key2 = 1, #value do
      local value2 = value[key2]
      table.insert(verticalLineList, value2)
    end
  end
  --  分别找到左边黑线和右边黑线
  local leftLineList = {}
  local rightLineList = {}
  for key = 1, #verticalLineList do
    local value = verticalLineList[key]
    if value[1] < 1000 then
      table.insert(leftLineList, value)
    else
      table.insert(rightLineList, value)
    end
  end

  -- 左边黑线进行精简，使其变成宽度为1的细线
  local leftLinePointList = {}
  if #leftLineList > 0 then
    local leftLineAdjacentGroup = listAdjacentGroups(leftLineList)
    local leftLineAdjacentMaxList = math.maxTable(leftLineAdjacentGroup, function(item) return #item end)
    local leftTopPoint = math.minTable(leftLineAdjacentMaxList, 2)
    local leftBottomPoint = math.maxTable(leftLineAdjacentMaxList, 2)
    local leftLineMap = makePointMap(leftLineAdjacentMaxList)
    local point = leftTopPoint
    for key = leftTopPoint[1], leftTopPoint[1] + 100 do
      if leftLineMap[key .. '-' .. leftTopPoint[2]] then
        point = leftLineMap[key .. '-' .. leftTopPoint[2]]
      else
        break
      end
    end
    table.insert(leftLinePointList, point)
    while point[2] <= leftBottomPoint[2] do
      local lastPoint = point
      local _ = (function()
        for theY = (point[2] + 1), point[2] + 20 do
          for theX = point[1], (point[1] - 10), -1 do
            if leftLineMap[theX .. '-' .. theY] then
              point = leftLineMap[theX .. '-' .. theY]
              table.insert(leftLinePointList, point)
              return
            end
          end
        end
      end)()
      if lastPoint[1] == point[1] and lastPoint[2] == point[2] then
        break
      end
    end
  end
  -- 如果左边集合小于10个点，则认为做边黑线不存在
  if #leftLinePointList < 10 then
    leftLinePointList = {}
  end
  -- 右边黑线进行精简，使其变成宽度为1的细线
  local rightLinePointList = {}
  if #rightLineList > 0 then
    local rightLineAdjacentGroup = listAdjacentGroups(rightLineList)
    local rightLineAdjacentMaxList = math.maxTable(rightLineAdjacentGroup, function(item) return #item end)
    local rightTopPoint = math.minTable(rightLineAdjacentMaxList, 2)
    local rightBottomPoint = math.maxTable(rightLineAdjacentMaxList, 2)
    local rightLineMap = makePointMap(rightLineList)
    local point = rightTopPoint
    for key = rightTopPoint[1], rightTopPoint[1] - 100, -1 do
      if rightLineMap[key .. '-' .. rightTopPoint[2]] then
        point = rightLineMap[key .. '-' .. rightTopPoint[2]]
      else
        break
      end
    end
    table.insert(rightLinePointList, point)
    while point[2] <= rightBottomPoint[2] do
      local lastPoint = point
      local _ = (function()
        for theY = (point[2] + 1), point[2] + 20 do
          for theX = point[1], (point[1] + 10) do
            if rightLineMap[theX .. '-' .. theY] then
              point = rightLineMap[theX .. '-' .. theY]
              table.insert(rightLinePointList, point)
              return
            end
          end
        end
      end)()
      if lastPoint[1] == point[1] and lastPoint[2] == point[2] then
        break
      end
    end
  end
  -- 如果右边集合小于10个点，则认为做边黑线不存在
  if #rightLinePointList < 10 then
    rightLinePointList = {}
  end

  -- 上边界用白色字母作为参考点
  local whiteCharacterList = ImgInfo.filterNoUsePoint(ImgInfo.toPoint(findMultiColorInRegionFuzzyExt(0xffffff, '', 100, 184, 160, 1885, 1004)))
  -- 寻找上边
  -- 按照y坐标分组
  local whiteCharacterGroup = {}
  for key = 1, #whiteCharacterList do
    local value = whiteCharacterList[key]
    whiteCharacterGroup[value[2]] = whiteCharacterGroup[value[2]] or {}
    table.insert(whiteCharacterGroup[value[2]], value)
  end
  -- 位置高于所有的黑线
  local leftLineAndRightLinePointList = table.merge({}, leftLinePointList, rightLinePointList)
  local topBlackPoint = math.minTable(leftLineAndRightLinePointList, function(item) return item[2] end)
  local topHorizontalLineGroupTmp = {}
  if topBlackPoint then
    for key, value in pairs(whiteCharacterGroup) do
      if value and #value > 0 and value[1][2] < topBlackPoint[2] then
        table.insert(topHorizontalLineGroupTmp, value)
      end
    end
  end
  -- 横向坐标点超过40个点的组
  local topHorizontalLineGroupTmp2 = {}
  for key, value in pairs(topHorizontalLineGroupTmp) do
    if #value > 40 then
      table.insert(topHorizontalLineGroupTmp2, value)
    end
  end
  -- 横向宽度超过700的组
  local topHorizontalLineGroupTmp3 = {}
  for key, value in ipairs(topHorizontalLineGroupTmp2) do
    local leftPoint = math.minTable(value, 1)
    local rightPoint = math.maxTable(value, 1)
    if rightPoint[1] - leftPoint[1] > 700 then
      table.insert(topHorizontalLineGroupTmp3, value)
    end
  end
  -- 白点间隔不超过450的组
  local topHorizontalLineGroup = {}
  for key, value in ipairs(topHorizontalLineGroupTmp3) do
    local sortValue = table.assign({}, value)
    table.sort(sortValue, function(a, b) return a[1] < b[1] end)
    local flag = true
    for key2 = 1, #sortValue - 1 do
      local a = sortValue[key2]
      local b = sortValue[key2 + 1]
      if math.abs(b[1] - a[1]) >= 450 then
        flag = false
        break
      end
    end
    if flag then
      table.insert(topHorizontalLineGroup, value)
    end
  end
  -- 寻找最靠下的一个组
  topLinePointList = math.minTable(topHorizontalLineGroup, function(item) return item[1][2] end)
  -- 白字下方13像素才是上边界
  local topLinePoint = { -1, -1 }
  if topLinePointList and #topLinePointList > 0 then
    topLinePoint = { topLinePointList[1][1], topLinePointList[1][2] + 13 }
  end
  local bottomLinePoint = bottomLinePointList[1] or { -1, -1 }

  function getTopAndBottomPoint(topLinePoint, bottomLinePoint, pointList)
    -- 获取左右边界的上下两点(就是算四个叫的坐标)
    -- 这个函数求一条斜边的上点和下点，需要2次才能计算出四个角
    -- 结果第一个是上点，第二个是下点
    local result = { false, false }
    if pointList and #pointList > 0 then
      local point1 = math.minTable(pointList, 2) or { -1, -1 }
      local point2 = math.maxTable(pointList, 2) or { -1, -1 }
      if topLinePoint and topLinePoint[1] > 0 then
        local Y1 = math.floor(topLinePoint[2])
        local X1 = (Y1 - point1[2]) / (point2[2] - point1[2]) * (point2[1] - point1[1]) + point1[1] or -1
        X1 = math.trueNumber(X1) or -1
        X1 = math.floor(X1)
        if X1 > 0 then
          result[1] = { X1, Y1 }
        end
      end
      if bottomLinePoint and bottomLinePoint[1] > 0 then
        local Y2 = math.floor(bottomLinePoint[2])
        local X2 = (Y2 - point1[2]) / (point2[2] - point1[2]) * (point2[1] - point1[1]) + point1[1] or -1
        X2 = math.trueNumber(X2) or -1
        X2 = math.floor(X2)
        if X2 > 0 then
          result[2] = { X2, Y2 }
        end
      end
    end
    return result
  end

  local leftPoint = getTopAndBottomPoint(topLinePoint, bottomLinePoint, leftLinePointList)
  local rightPoint = getTopAndBottomPoint(topLinePoint, bottomLinePoint, rightLinePointList)
  if not __keepScreenState then keepScreen(false) end
  return {
    leftTop = leftPoint[1],
    rightTop = rightPoint[1],
    leftBottom = leftPoint[2],
    rightBottom = rightPoint[2],
  }
end

-- 检查地图位置与预设位置的偏差
map.getMoveVector = function(ImgInfo, currentPosition, targetPosition)
  local __keepScreenState = keepScreenState
  if __keepScreenState then keepScreen(false) end
  getColor(0, 0)
  keepScreen(true)

  -- 计算偏差
  local moveVector = { 0, 0 }
  local effectiveStep = false
  if targetPosition.leftTop then
    if not currentPosition.leftTop then
      moveVector = { sWidth / 3, sHeight / 3 }
    else
      effectiveStep = true
      moveVector[1] = targetPosition.leftTop[1] - currentPosition.leftTop[1]
      moveVector[2] = targetPosition.leftTop[2] - currentPosition.leftTop[2]
    end
  elseif targetPosition.rightTop then
    if not currentPosition.rightTop then
      moveVector = { (0 - sWidth) / 3, sHeight / 3 }
    else
      effectiveStep = true
      moveVector[1] = targetPosition.rightTop[1] - currentPosition.rightTop[1]
      moveVector[2] = targetPosition.rightTop[2] - currentPosition.rightTop[2]
    end
  elseif targetPosition.leftBottom then
    if not currentPosition.leftBottom then
      moveVector = { sWidth / 3, (0 - sHeight) / 3 }
    else
      effectiveStep = true
      moveVector[1] = targetPosition.leftBottom[1] - currentPosition.leftBottom[1]
      moveVector[2] = targetPosition.leftBottom[2] - currentPosition.leftBottom[2]
    end
  elseif targetPosition.rightBottom then
    if not currentPosition.rightBottom then
      moveVector = { (0 - sWidth) / 3, (0 - sHeight) / 3 }
    else
      effectiveStep = true
      moveVector[1] = targetPosition.rightBottom[1] - currentPosition.rightBottom[1]
      moveVector[2] = targetPosition.rightBottom[2] - currentPosition.rightBottom[2]
    end
  end

  if moveVector[1] > 25 then
    moveVector[1] = math.floor(moveVector[1] * 0.6)
  else
    moveVector[1] = math.floor(moveVector[1] * 0.8)
  end
  if moveVector[2] > 25 then
    moveVector[2] = math.floor(moveVector[2] * 0.6)
  else
    moveVector[2] = math.floor(moveVector[2] * 0.8)
  end

  if not __keepScreenState then keepScreen(false) end
  return moveVector, effectiveStep
end

-- 将地图移动到指定位置
map.moveMapToCheckPosition = function(ImgInfo, moveVector)
  local isCenter = false
  local minLength = 5
  -- 将地图移动到中心
  local moveStep
  if (math.abs(moveVector[1]) > minLength) or (math.abs(moveVector[2]) > minLength) then
    -- 因为屏幕滑动和画面滚动不一致，所以需要减少移动幅度
    moveStep = math.max(math.abs(moveVector[1]), math.abs(moveVector[2]))
    moveStep = math.abs(moveStep)
    moveStep = moveStep / 8
    moveStep = math.min(25, moveStep)
    moveStep = math.max(1, moveStep)
    moveStep = math.floor(moveStep)
    moveTo(sWidth / 2, sHeight / 2, sWidth / 2 + moveVector[1], sHeight / 2 + moveVector[2], moveStep)
  else
    isCenter = true
  end
  return isCenter, moveStep
end

-- 扫描地图
map.scanMap = function(ImgInfo, targetPosition, mapChessboard, deviation)
  local __keepScreenState = keepScreenState
  if __keepScreenState then keepScreen(false) end
  getColor(0, 0)
  keepScreen(true)
  local positionMap = targetPosition.positionMap

  -- 扫描屏幕上的对象
  local myFleetPositionList = ImgInfo.filterNoUsePoint(findMultiColorList(ImgInfo, ImgInfo.map.myFleetList))
  myFleetPositionList = corrected(myFleetPositionList, myFleetListCorrectionValue, deviation)

  local selectedArrowPositionList = ImgInfo.filterNoUsePoint(findMultiColorList(ImgInfo, ImgInfo.map.selectedArrow))
  selectedArrowPositionList = corrected(selectedArrowPositionList, selectedArrowCorrectionValue, deviation)
  local enemyList1 = ImgInfo.filterNoUsePoint(findMultiColorList(ImgInfo, ImgInfo.map.enemyList1))
  enemyList1 = corrected(enemyList1, enemyListCorrectionValue, deviation)
  local enemyList2 = ImgInfo.filterNoUsePoint(findMultiColorList(ImgInfo, ImgInfo.map.enemyList2))
  enemyList2 = corrected(enemyList2, enemyListCorrectionValue, deviation)
  local enemyList3 = ImgInfo.filterNoUsePoint(findMultiColorList(ImgInfo, ImgInfo.map.enemyList3))
  enemyList3 = corrected(enemyList3, enemyListCorrectionValue, deviation)
  local rewardBoxPointList = ImgInfo.filterNoUsePoint(findMultiColorList(ImgInfo, ImgInfo.map.rewardBoxList))
  rewardBoxPointList = corrected(rewardBoxPointList, rewardBoxListCorrectionValue, deviation)
  local bossPointList = ImgInfo.filterNoUsePoint(findMultiColorList(ImgInfo, ImgInfo.map.bossPointList))
  local inBattlePointList = ImgInfo.filterNoUsePoint(findMultiColorList(ImgInfo, ImgInfo.map.inBattleList))

  local inBattleList = utils.unionList(mapChessboard.inBattleList, transPointListToChessboardPointList(positionMap, inBattlePointList))
  local selectedArrowList = utils.unionList(mapChessboard.selectedArrowList, transPointListToChessboardPointList(positionMap, selectedArrowPositionList))
  local myFleetList = utils.unionList(selectedArrowList, transPointListToChessboardPointList(positionMap, myFleetPositionList))
  -- 假如舰队和敌方重合了，我方标记会偏下一格，导致扫描结果有偏差。进行修正
  local inBattleMap = makePointMap(inBattleList)
  for key = 1, #myFleetList do
    local point = myFleetList[key]
    if inBattleMap[(point[1] - 1) .. '-' .. point[2]] then
      myFleetList[key][1] = point[1] - 1
    end
  end
  myFleetList = utils.unionList(myFleetList, mapChessboard.myFleetList)
  local enemyPositionList1 = utils.unionList(mapChessboard.enemyPositionList1, transPointListToChessboardPointList(positionMap, enemyList1))
  local enemyPositionList2 = utils.unionList(mapChessboard.enemyPositionList2, transPointListToChessboardPointList(positionMap, enemyList2))
  local enemyPositionList3 = utils.unionList(mapChessboard.enemyPositionList3, transPointListToChessboardPointList(positionMap, enemyList3))
  local rewardBoxList = utils.unionList(mapChessboard.rewardBoxList, transPointListToChessboardPointList(positionMap, rewardBoxPointList))
  local enemyPositionList = utils.unionList(enemyPositionList1, enemyPositionList2, enemyPositionList3)
  local bossPosition = utils.unionList(mapChessboard.bossPosition, transPointListToChessboardPointList(positionMap, bossPointList))
  -- 只有一个boss，如果出现多个boss的情况取最后一个
  bossPosition = #bossPosition > 1 and { bossPosition[#bossPosition] } or bossPosition
  -- 如果boss出现在敌人列表里，那么说明这个位置不是boss
  bossPosition = utils.subtractionList(bossPosition, enemyPositionList)
  -- 如果我方舰队在敌人列表里但是不在战斗中列表里，说明这个位置的敌人已经消灭了
  local myFleetListNotInBattle = utils.subtractionList(myFleetList, inBattleList)
  enemyPositionList1 = utils.subtractionList(enemyPositionList1, myFleetListNotInBattle)
  enemyPositionList2 = utils.subtractionList(enemyPositionList2, myFleetListNotInBattle)
  enemyPositionList3 = utils.subtractionList(enemyPositionList3, myFleetListNotInBattle)

  local newMapChessboard = table.assign({}, mapChessboard, {
    inBattleList = inBattleList,
    selectedArrowList = selectedArrowList,
    myFleetList = myFleetList,
    rewardBoxList = rewardBoxList,
    enemyPositionList1 = enemyPositionList1,
    enemyPositionList2 = enemyPositionList2,
    enemyPositionList3 = enemyPositionList3,
    bossPosition = bossPosition,
  })

  if not __keepScreenState then keepScreen(false) end
  return newMapChessboard
end

-- 合并新老版本的地图数据
map.assignMapChessboard = function(ImgInfo, mapChessboard, newMapChessboard)
  -- 将我方舰队上方和右上方和右边的敌人找到，并保存下来。因为扫描时会被遮挡，所以从上次敌人列表中寻找
  local checkMyFleetList = utils.subtractionList(newMapChessboard.myFleetList, newMapChessboard.inBattleList)
  function findMyFleetTopRightEnemy(myFleetList, oldMap)
    local res = {}
    for key, item in ipairs(myFleetList) do
      if oldMap[(item[1] + 1) .. '-' .. item[2]]
        or oldMap[(item[1] + 1) .. '-' .. (item[2] - 1)]
        or oldMap[(item[1]) .. '-' .. (item[2] - 1)] then
        table.insert(res, item)
      end
    end
    return res
  end

  local theMapChessBoard = table.assign({}, newMapChessboard, {
    rewardBoxList = utils.unionList(newMapChessboard.rewardBoxList, findMyFleetTopRightEnemy(checkMyFleetList, mapChessboard.rewardBoxList)),
    enemyPositionList1 = utils.unionList(newMapChessboard.enemyPositionList1, findMyFleetTopRightEnemy(checkMyFleetList, mapChessboard.enemyPositionList1)),
    enemyPositionList2 = utils.unionList(newMapChessboard.enemyPositionList2, findMyFleetTopRightEnemy(checkMyFleetList, mapChessboard.enemyPositionList2)),
    enemyPositionList3 = utils.unionList(newMapChessboard.enemyPositionList3, findMyFleetTopRightEnemy(checkMyFleetList, mapChessboard.enemyPositionList3)),
    bossPosition = utils.unionList(newMapChessboard.bossPosition, mapChessboard.bossPosition),
  })
  return theMapChessBoard
end

map.moveToPoint = function(ImgInfo, targetPosition, point, deviation)
  local deviationX = 0
  local deviationY = 0
  if type(deviation) == 'table' then
    deviationX = deviation[1] or 0
    deviationY = deviation[2] or 0
  end
  local positionMap = targetPosition.positionMap
  local tapPointList = transChessboardPointListToPositionList(positionMap, { point })
  RTap({ tapPointList[1][1] + deviationX, tapPointList[1][2] + deviationY }, 100)
end

map.checkMoveToPointPath = function(ImgInfo, mapChessboard, start, target)
  local enemyPositionList = utils.unionList(mapChessboard.enemyPositionList1, mapChessboard.enemyPositionList2, mapChessboard.enemyPositionList3)
  local enemyPositionListExceptTarget = utils.subtractionList(enemyPositionList, { target })
  local theObstacle = utils.unionList(mapChessboard.obstacle, enemyPositionListExceptTarget)
  local thePath = AStart(start, target, {
    width = mapChessboard.width,
    height = mapChessboard.height,
    obstacle = theObstacle,
  })
  -- 如果到达不了目标，说明道路被其他敌人堵死了，
  -- 那么就不考虑敌人，只寻找到目标的路径，然后在寻找路径上的敌人一路打过去
  if not thePath or #thePath == 0 then
    thePath = AStart(start, target, {
      width = mapChessboard.width,
      height = mapChessboard.height,
      obstacle = mapChessboard.obstacle,
    })
  end
  local targetPath = {}

  -- 检查路径上是否有其他敌方舰队，如果有就点击
  if thePath and #thePath > 0 then
    local enemyPositionMap = transListToMap(enemyPositionList)
    for key = 1, #thePath do
      local p = thePath[key]
      table.insert(targetPath, p)
      if enemyPositionMap[p[1] .. '-' .. p[2]] then
        return p, targetPath, thePath
      end
    end
  end

  local target = thePath and thePath[#thePath]
  return target, thePath, thePath
end

map.findClosestEnemy = function(ImgInfo, mapChessboard, myFleed, myFleed2)
  -- 除了3种敌人的位置，还会考虑奖励点的位置，方便获取额外奖励
  local myField = myFleed or mapChessboard.myFleetList[1]
  local myField2 = myFleed2 or mapChessboard.myFleetList[2]
  local rewardBoxList = table.map(mapChessboard.rewardBoxList, function(enemy)
    return table.assign({}, enemy, { weight = 0 })
  end)
  local enemyPositionList1 = table.map(mapChessboard.enemyPositionList1, function(enemy)
    return table.assign({}, enemy, { weight = 5 })
  end)
  local enemyPositionList2 = table.map(mapChessboard.enemyPositionList2, function(enemy)
    return table.assign({}, enemy, { weight = 7 })
  end)
  local enemyPositionList3 = table.map(mapChessboard.enemyPositionList3, function(enemy)
    return table.assign({}, enemy, { weight = 10 })
  end)
  -- 所有敌人的列表
  local enemyPositionList = utils.unionList(rewardBoxList, enemyPositionList1, enemyPositionList2, enemyPositionList3)
  local enemyPositionMap = {}
  for key = 1, #enemyPositionList do
    local value = enemyPositionList[key]
    enemyPositionMap[value[1] .. '-' .. value[2]] = value
  end
  local theObstacle = utils.unionList(mapChessboard.obstacle, enemyPositionList)

  local inBattleList = mapChessboard.inBattleList
  local minCoast = nil
  local minCoastEnemy = nil
  local minCoastPath = nil

  for _, enemy in ipairs(enemyPositionList) do
    if not myField2 or enemy[1] ~= myField2[1] or enemy[2] ~= myField2[2] then
      -- 这里将敌人视为高权重方块，因为1.4.77版本之后我方舰队会绕过路途中的敌人走向目标。
      local thePath = AStart(myField, enemy, {
        width = mapChessboard.width,
        height = mapChessboard.height,
        obstacle = theObstacle,
      })
      if thePath and #thePath > 0 then
        -- 将权重也加入到coast里以便让结果倾向选择小型舰队
        local weight = enemy.weight or 0
        local theCoast = thePath[#thePath].G + weight
        if not minCoast or minCoast > theCoast then
          minCoast = theCoast
          minCoastEnemy = enemy
          minCoastPath = thePath
          -- 如果此时路线还是穿过别的舰队了，说明穿过别的舰队是必经之路，所以我们先走到最近的一个敌人上
          for _, value in ipairs(thePath) do
            if enemyPositionMap[value[1] .. '-' .. value[2]] then
              minCoastEnemy = value
              break
            end
          end
        end
      end
    end
  end

  return minCoastEnemy, minCoastPath
end

-- 向四周随意移动一步
map.getRandomMoveAStep = function(ImgInfo, mapChessboard)
  local myFleet = mapChessboard.myFleetList[1]
  local width = mapChessboard.width
  local height = mapChessboard.height
  -- 尽可能选择空地
  local enemyList1Map = transListToMap(mapChessboard.enemyPositionList1)
  local enemyList2Map = transListToMap(mapChessboard.enemyPositionList2)
  local enemyList3Map = transListToMap(mapChessboard.enemyPositionList3)
  local obstacleMap = transListToMap(mapChessboard.obstacle)
  local checkList = {
    { myFleet[1] - 1, myFleet[2], coast = nil }, -- topPoint
    { myFleet[1] + 1, myFleet[2], coast = nil }, -- bottomPoint
    { myFleet[1], myFleet[2] - 1, coast = nil }, -- leftPoint
    { myFleet[1], myFleet[2] + 1, coast = nil }, -- rightPoint
  }
  local canUseList = {}
  for key, point in ipairs(checkList) do
    if point[1] >= 1 and point[1] <= width and point[2] >= 1 and point[2] <= height
      and not obstacleMap[point[1] .. '-' .. point[2]] then
      if enemyList3Map[point[1] .. '-' .. point[2]] then
        checkList[key].coast = 3
      elseif enemyList2Map[point[1] .. '-' .. point[2]] then
        checkList[key].coast = 2
      elseif enemyList1Map[point[1] .. '-' .. point[2]] then
        checkList[key].coast = 1
      end
      table.insert(canUseList, checkList[key])
    end
  end

  local minCoast
  for _, point in ipairs(canUseList) do
    if not minCoast then
      minCoast = point.coast
    elseif point.coast then
      minCoast = math.min(minCoast, point.coast)
    end
  end

  local resultPoint = table.find(canUseList, function(point)
    return point.coast == minCoast
  end)

  return resultPoint and { resultPoint[1], resultPoint[2] } or nil
end

return map