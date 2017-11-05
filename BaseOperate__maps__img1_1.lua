-- 存储图像信息，用于界面找色、找图。取代图片搜索，因为找色搜索的像素点更少
require 'TableLib'
local imgBase = require 'BaseOperate__maps__img'

local transRelativePoint = imgBase.transRelativePoint

return {
  transRelativePoint = transRelativePoint,
  -- 基本方法
  toPoint = imgBase.toPoint,
  -- 过滤被右下角按钮挡住的部分的点，因为右下角按钮也是黑色的容易与边界识别混淆
  filterNoUsePoint = imgBase.filterNoUsePoint,
  -- 图片数据
  -- 地图扫描
  map = {
    -- 地图上边界
    topLineList = {
      -- 1-2 上边
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 644, 576, 0x21354a }, { 663, 576, 0x213142 },
          { 681, 576, 0x213142 }, { 699, 576, 0x213142 },
          { 716, 576, 0x29354a }, { 725, 577, 0x31a2de },
          { 699, 577, 0x29a6de }, { 683, 577, 0x29a6de },
          { 664, 577, 0x29a6de }, { 644, 577, 0x31aade },
        })
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
      -- 1-4 上边
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 971, 576, 0x21394a }, { 993, 576, 0x29394a },
          { 1013, 576, 0x21394a }, { 1033, 576, 0x21394a },
          { 1054, 576, 0x213952 }, { 1067, 577, 0x31bade },
          { 1045, 577, 0x31bede }, { 1025, 577, 0x31b6de },
          { 1005, 577, 0x31b6de }, { 982, 577, 0x29b6d6 },
        })
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
    },
    -- 地图下边界
    bottonLineList = {
      -- 1-2 下边
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022 }
        local basePoint, posandcolor = transRelativePoint({
          { 573, 715, 0x000000 }, { 600, 715, 0x000000 },
          { 620, 715, 0x000000 }, { 642, 715, 0x000000 },
          { 662, 714, 0x195d9c }, { 639, 714, 0x105994 },
          { 612, 714, 0x21619c }, { 588, 714, 0x21619c },
        })
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
    },
    -- 地图左边界
    leftLineList = {
      (function()
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
    },
    -- 地图右边界
    rightLineList = {
      (function()
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
    },
    -- 我方舰队位置
    myFleetList = imgBase.map.myFleetList,
    -- 我放舰队被选中的舰队的绿色的选中箭头的位置
    selectedArrow = imgBase.map.selectedArrow,
    -- 敌方舰队位置(小型舰队)
    enemyList1 = imgBase.map.enemyList1,
    -- 敌方舰队位置(中型舰队)
    enemyList2 = imgBase.map.enemyList2,
    -- 敌方舰队位置(大型舰队)
    enemyList3 = imgBase.map.enemyList3,
    -- boss位置
    bossPointList = imgBase.map.bossPointList,
    -- 战斗中的位置
    inBattleList = imgBase.map.inBattleList,
  },
}