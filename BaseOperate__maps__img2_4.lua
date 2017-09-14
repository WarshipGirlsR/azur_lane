-- 存储图像信息，用于界面找色、找图。取代图片搜索，因为找色搜索的像素点更少
require 'TableLib'
local imgBase = require 'BaseOperate__maps__img'

local transRelativePoint = imgBase.transRelativePoint

return {
  transRelativePoint = transRelativePoint,
  -- 基本方法
  toPoint = imgBase.toPoint,
  -- 检测点是否在两个点围围成的区域里
  inArea = imgBase.inArea,
  -- 图片数据
  -- 地图扫描
  map = {
    -- 地图上边界
    topLine = (function()
      local leftTop = { 185, 155 }
      local rightBotton = { 1899, 1022, }
      local basePoint, posandcolor = transRelativePoint({
        { 1016, 267, 0x192d3a }, { 1040, 267, 0x192d3a },
        { 1070, 267, 0x192d42 }, { 1093, 267, 0x213542 },
        { 1106, 268, 0x31bade }, { 1084, 268, 0x3ab6de },
        { 1058, 268, 0x31bade }, { 1032, 268, 0x31b6e6 },
      })
      return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
    end)(),
    -- 地图下边界
    bottonLine = (function()
      local leftTop = { 185, 155 }
      local rightBotton = { 1899, 1022 }
      local basePoint, posandcolor = transRelativePoint({
        { 613, 859, 0x000000 }, { 643, 859, 0x000000 },
        { 668, 859, 0x000000 }, { 699, 859, 0x000000 },
        { 717, 858, 0x1965ad }, { 676, 858, 0x1969b5 },
        { 646, 858, 0x1965b5 }, { 625, 858, 0x1965ad },
      })
      return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
    end)(),
    -- 地图左边界
    leftLine = imgBase.map.leftLine,
    -- 地图右边界
    rightLine = imgBase.map.rightLine,
    -- 我方舰队位置
    myFleetList = imgBase.map.myFleetList,
    -- 我放舰队被选中的舰队的绿色的选中箭头的位置
    selectedArrow = imgBase.map.selectedArrow,
    -- 敌方舰队位置
    enemyList = imgBase.map.enemyList,
    -- boss位置
    bossPointList = imgBase.map.bossPointList,
  },
}