local ImgInfo = require 'BaseOperate__ImgInfo'

local utils = {}

utils.getPositionToPointMap = function(baseMap)
  local positionToPointMap = {}
  local topW = baseMap.rightTop[1] - baseMap.leftTop[1]
  local bottonW = baseMap.rightBotton[1] - baseMap.LeftBotton[1]
  for x = 1, baseMap.col do
    -- 求上点坐标
    local topP = {}
    topP[1] = baseMap.leftTop[1] + topW * (x - 0.5)
    topP[2] = baseMap.leftTop[2]
    -- 求下点坐标
    local bottonP = {}
    bottonP[1] = baseMap.LeftBotton[1] + bottonW * (x - 0.5)
    bottonP[2] = baseMap.LeftBotton[2]

    for y = 1, baseMap.row do
      -- 求格子中心坐标
      local centerP = {}
      centerP[2] = (baseMap.cellHeight[y][2] + baseMap.cellHeight[y + 1][2]) / 2
      if topP[2] == bottonP[2] then
        -- 如果两点连接的直线是水平的，则取第一个点的x坐标
        centerP[1] = topP[1]
      else
        -- 直线方程求中心坐标
        centerP[1] = ((centerP[2] - topP[2]) / (bottonP[2] - topP[2])) * (bottonP[1] - topP[1]) + topP[1]
      end
      positionToPointMap[x .. '-' .. y] = centerP
    end
  end
  return positionToPointMap
end

utils.positionToPoint = function(position, positionToPointMap)
  local x = position[1] or -1
  local y = position[2] or -1
  return positionToPointMap[x .. '-' .. y]
end

utils.pointToPosition = function(point, baseMap)
  local theX = 0
  local theY = 0
  -- 求y坐标
  for y = 1, (baseMap.row + 1) do
    if point[2] < baseMap.cellHeight[y][2] then
      break
    end
    theY = y
  end
  -- 求x坐标
  for x = 1, (baseMap.col + 1) do
    -- 求上点坐标
    local topW = baseMap.rightTop[1] - baseMap.leftTop[1]
    local topP = {}
    topP[1] = baseMap.leftTop[1] + topW * (x - 1)
    topP[2] = baseMap.leftTop[2]
    -- 求下点坐标
    local bottonW = baseMap.rightBotton[1] - baseMap.LeftBotton[1]
    local bottonP = {}
    bottonP[1] = baseMap.LeftBotton[1] + bottonW * (x - 1)
    bottonP[2] = baseMap.LeftBotton[2]
    -- 求点是否在点的左边，是的话就停止
    if topP[2] == bottonP[2] then
      if point[1] < topP[1] then
        break
      end
    elseif (((point[2] - bottonP[2]) / (topP[2] - bottonP[2])) * (topP[1] - bottonP[1]) + bottonP[1]) > point[1] then
      break
    end
    theX = x
  end
  return { theX, theY }
end

utils.scanMap = function()
end

return utils
