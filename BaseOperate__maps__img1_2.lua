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
        { 929, 437, 0x424552 }, { 957, 437, 0x52494a },
        { 978, 437, 0x3a4531 }, { 993, 437, 0x31454a },
        { 1005, 438, 0x29bade }, { 974, 438, 0x31bade },
        { 943, 438, 0x31b6de }, { 916, 438, 0x31b6de },
      })
      return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
    end)(),
    -- 地图下边界
    bottonLine = (function()
      local leftTop = { 185, 155 }
      local rightBotton = { 1899, 1022 }
      local basePoint, posandcolor = transRelativePoint({
        { 703, 870, 0x000000 }, { 732, 870, 0x000000 },
        { 777, 870, 0x000000 }, { 812, 870, 0x000000 },
        { 830, 869, 0x1965ad }, { 799, 869, 0x1969b5 },
        { 771, 869, 0x196db5 }, { 745, 869, 0x2171b5 },
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