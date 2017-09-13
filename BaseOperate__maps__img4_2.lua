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
        { 997, 469, 0x423129 }, { 1013, 469, 0x423129 },
        { 1046, 469, 0x3a3129 }, { 1072, 469, 0x292429 },
        { 1095, 470, 0xb58173 }, { 1066, 470, 0xbd817b },
        { 1038, 470, 0xbd817b }, { 1016, 470, 0xc59684 },
      })
      return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
    end)(),
    -- 地图下边界
    bottonLine = (function()
      local leftTop = { 185, 155 }
      local rightBotton = { 1899, 1022 }
      local basePoint, posandcolor = transRelativePoint({
        { 449, 899, 0x000000 }, { 466, 899, 0x000000 },
        { 494, 899, 0x000000 }, { 527, 899, 0x000000 },
        { 547, 898, 0x312d52 }, { 518, 898, 0x3a2d5a },
        { 479, 898, 0x3a315a }, { 453, 898, 0x3a3563 },
      })
      return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
    end)(),
    -- 地图左边界
    leftLine = (function()
      local leftTop = { 185, 155 }
      local rightBotton = { 1899, 1022, }
      local basePoint, posandcolor = transRelativePoint({
        { 483, 288, 0x000001 }, { 484, 288, 0x5a518c },
        { 483, 287, 0x000000 }, { 484, 287, 0x524d84 },
        { 482, 289, 0x000000 }, { 483, 289, 0x525184 },
        { 482, 290, 0x000000 }, { 483, 290, 0x525184 },
      })
      return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
    end)(),
    -- 地图右边界
    rightLine = (function()
      local leftTop = { 185, 155 }
      local rightBotton = { 1899, 1022, }
      local basePoint, posandcolor = transRelativePoint({
        { 1586, 348, 0x010000 }, { 1585, 348, 0xb5816b },
        { 1586, 347, 0x000000 }, { 1585, 347, 0xb5866b },
        { 1587, 349, 0x000000 }, { 1586, 349, 0xad7d63 },
        { 1587, 350, 0x000000 }, { 1586, 350, 0xb5816b },
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