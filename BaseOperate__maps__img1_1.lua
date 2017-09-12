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
    topLine = imgBase.map.topLine,
    -- 地图下边界
    bottonLine = imgBase.map.bottonLine,
    -- 地图左边界
    leftLine = (function()
      local leftTop = { 185, 155 }
      local rightBotton = { 1899, 1022, }
      local basePoint, posandcolor = transRelativePoint({
        { 285, 362, 0x000000 }, { 286, 362, 0x31b6de },
        { 285, 363, 0x000000 }, { 286, 363, 0x31b2d6 },
        { 284, 364, 0x000000 }, { 285, 364, 0x31b2de },
        { 284, 365, 0x000000 }, { 285, 365, 0x31b6de },
      })
      return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
    end)(),
    -- 地图右边界
    rightLine = (function()
      local leftTop = { 185, 155 }
      local rightBotton = { 1899, 1022, }
      local basePoint, posandcolor = transRelativePoint({
        { 1800, 297, 0x299ade }, { 1801, 297, 0x000000 },
        { 1800, 298, 0x299ee6 }, { 1801, 298, 0x000000 },
        { 1801, 299, 0x299ae6 }, { 1802, 299, 0x000000 },
        { 1801, 300, 0x299ae6 }, { 1802, 300, 0x000408 },
      })
      return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
    end)(),
    -- 我方舰队位置
    myFleet = imgBase.map.myFleet,
    -- 我放舰队被选中的舰队的绿色的选中箭头的位置
    selectedArrow = imgBase.map.selectedArrow,
    -- 敌方舰队位置(1星)
    enemyList1 = imgBase.map.enemyList1,
    -- 敌方舰队位置(2星)
    enemyList2 = imgBase.map.enemyList2,
    -- 敌方舰队位置(3星)
    enemyList3 = imgBase.map.enemyList3,
    -- boss位置
    bossPoint1 = imgBase.map.bossPoint1,
    -- boss位置第二种形态
    bossPoint2 = imgBase.map.bossPoint2,
  },
}