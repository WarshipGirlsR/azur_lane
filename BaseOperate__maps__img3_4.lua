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
        { 398, 334, 0x314152 }, { 429, 334, 0x293d4a },
        { 471, 334, 0x293d4a }, { 501, 334, 0x213d4a },
        { 485, 335, 0x31aade }, { 463, 335, 0x31a6de },
        { 439, 335, 0x319ede }, { 409, 335, 0x29a2de },
      })
      return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
    end)(),
    -- 地图下边界
    bottonLine = (function()
      local leftTop = { 185, 155 }
      local rightBotton = { 1899, 1022 }
      local basePoint, posandcolor = transRelativePoint({
        { 482, 918, 0x000000 }, { 554, 918, 0x000000 },
        { 615, 918, 0x000000 }, { 658, 918, 0x000000 },
        { 636, 917, 0x1971b4 }, { 596, 917, 0x2171b4 },
        { 560, 917, 0x2171b4 }, { 518, 917, 0x1971ac },
      })
      return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
    end)(),
    -- 地图左边界
    leftLine = imgBase.map.leftLine,
    -- 地图右边界
    rightLine = imgBase.map.rightLine,
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