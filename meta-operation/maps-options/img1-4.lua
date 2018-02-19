-- 存储图像信息，用于界面找色、找图。取代图片搜索，因为找色搜索的像素点更少
local imgBase = require './img'

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
          { 285, 897, 0x000000 }, { 301, 897, 0x000000 },
          { 313, 897, 0x000000 }, { 326, 897, 0x000000 },
          { 339, 896, 0x1981c5 }, { 322, 896, 0x2083c2 },
          { 307, 896, 0x2080c2 }, { 297, 896, 0x2181c5 },
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
          { 275, 796, 0x000000 }, { 276, 796, 0x288bca },
          { 275, 795, 0x000000 }, { 276, 795, 0x2087ba },
          { 274, 797, 0x000000 }, { 275, 797, 0x298ec5 },
          { 274, 798, 0x000000 }, { 275, 798, 0x298ac5 },
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
    -- 奖励箱的位置
    rewardBoxList = imgBase.map.rewardBoxList,
  },
}