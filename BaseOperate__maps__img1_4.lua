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
    topLineList = {
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 1089, 466, 0x213542 }, { 1109, 466, 0x192d3a },
          { 1153, 466, 0x213542 }, { 1185, 466, 0x29414a },
          { 1218, 466, 0x424d52 }, { 1238, 467, 0x31bede },
          { 1207, 467, 0x31bede }, { 1175, 467, 0x31b6de },
          { 1146, 467, 0x29b6de }, { 1117, 467, 0x29b2de },
        })
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
    },
    -- 地图下边界
    bottonLineList = {
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022 }
        local basePoint, posandcolor = transRelativePoint({
          { 693, 902, 0x000000 }, { 723, 902, 0x000000 },
          { 761, 902, 0x000000 }, { 797, 902, 0x000000 },
          { 836, 902, 0x000000 }, { 871, 901, 0x1961b5 },
          { 818, 901, 0x1961ad }, { 778, 901, 0x1969b5 },
          { 742, 901, 0x1965ad }, { 708, 901, 0x1965b5 },
        })
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
    },
    -- 地图左边界
    leftLineList = {
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022 }
        local basePoint, posandcolor = transRelativePoint({
          { 301, 706, 0x000000 }, { 302, 706, 0x3a96de },
          { 301, 705, 0x000000 }, { 302, 705, 0x3192ce },
          { 300, 707, 0x000000 }, { 301, 707, 0x3196d6 },
          { 300, 708, 0x000000 }, { 301, 708, 0x3196d6 },
        })
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
    },
    -- 地图右边界
    rightLineList = {
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022 }
        local basePoint, posandcolor = transRelativePoint({
          { 1669, 617, 0x000000 }, { 1668, 617, 0x29aed6 },
          { 1669, 616, 0x000000 }, { 1668, 616, 0x29b2de },
          { 1670, 618, 0x000000 }, { 1669, 618, 0x29aad6 },
          { 1670, 619, 0x000000 }, { 1669, 619, 0x29aade },
        })
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
    },
    -- 我方舰队位置
    myFleetList = imgBase.map.myFleetList,
    -- 我放舰队被选中的舰队的绿色的选中箭头的位置
    selectedArrow = imgBase.map.selectedArrow,
    -- 敌方舰队位置
    enemyList = imgBase.map.enemyList,
    -- boss位置
    bossPointList = imgBase.map.bossPointList,
    -- 战斗中的位置
    inBattleList = imgBase.map.inBattleList,
  },
}