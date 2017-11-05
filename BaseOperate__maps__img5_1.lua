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
      -- 1-3的上边
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 655, 471, 0x29414a }, { 691, 471, 0x29414a },
          { 736, 471, 0x21313a }, { 768, 471, 0x212d3a },
          { 798, 472, 0x3ab2de }, { 756, 472, 0x31b2de },
          { 709, 472, 0x31a6e6 }, { 673, 472, 0x29a2de },
        })
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
      -- 1-7的上边
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 1340, 471, 0x19283a }, { 1372, 471, 0x19283a },
          { 1409, 471, 0x213142 }, { 1446, 471, 0x19283a },
          { 1464, 472, 0x42c6de }, { 1432, 472, 0x3ac6de },
          { 1398, 472, 0x3acade }, { 1357, 472, 0x3ac6de },
        })
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
    },
    -- 地图下边界
    bottonLineList = {
      -- 6-3 的下面
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022 }
        local basePoint, posandcolor = transRelativePoint({
          { 806, 885, 0x000000 }, { 849, 885, 0x000000 },
          { 891, 885, 0x000000 }, { 930, 885, 0x000000 },
          { 957, 884, 0x1965b5 }, { 916, 884, 0x1969bd },
          { 880, 884, 0x1969b5 }, { 841, 884, 0x1969b5 },
        })
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
      -- 6-6 的下面
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022 }
        local basePoint, posandcolor = transRelativePoint({
          { 1008, 886, 0x000000 }, { 1069, 886, 0x000000 },
          { 1115, 886, 0x000000 }, { 1151, 886, 0x000000 },
          { 1175, 885, 0x1959ad }, { 1140, 885, 0x1055ad },
          { 1102, 885, 0x1055ad }, { 1065, 885, 0x2155ad },
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
          { 273, 608, 0x000000 }, { 274, 608, 0x31aede },
          { 273, 607, 0x000000 }, { 274, 607, 0x29aade },
          { 272, 609, 0x000000 }, { 273, 609, 0x31aede },
          { 272, 610, 0x000000 }, { 273, 610, 0x29aede },
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
          { 1722, 752, 0x000000 }, { 1721, 752, 0x29b2de },
          { 1722, 751, 0x000000 }, { 1721, 751, 0x29b6de },
          { 1723, 753, 0x000000 }, { 1722, 753, 0x21b2de },
          { 1723, 754, 0x000000 }, { 1722, 754, 0x29b6e6 },
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