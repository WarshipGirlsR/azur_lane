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
      -- 1-5 上边
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 1214, 409, 0x212d21 }, { 1231, 409, 0x424131 },
          { 1255, 409, 0x293929 }, { 1276, 409, 0x212d21 },
          { 1293, 409, 0x293531 }, { 1297, 410, 0x31bede },
          { 1277, 410, 0x31bede }, { 1256, 410, 0x3ac6de },
          { 1239, 410, 0x3ac6de }, { 1223, 410, 0x3ac6de },
        })
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
      -- 1-3 上边
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 851, 409, 0x314132 }, { 872, 409, 0x314131 },
          { 891, 409, 0x424942 }, { 912, 409, 0x4a4942 },
          { 923, 410, 0x31bade }, { 903, 410, 0x3abede },
          { 879, 410, 0x4aceef }, { 852, 410, 0x3abade },
        })
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
    },
    -- 地图下边界
    bottonLineList = {
      -- 3-1 下边
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022 }
        local basePoint, posandcolor = transRelativePoint({
          { 410, 837, 0x000000 }, { 424, 837, 0x000000 },
          { 445, 837, 0x000000 }, { 469, 837, 0x000000 },
          { 481, 836, 0x197dbd }, { 459, 836, 0x197dbd },
          { 442, 836, 0x2181c5 }, { 421, 836, 0x2181c5 },
        })
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
      -- 3-5 下边
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022 }
        local basePoint, posandcolor = transRelativePoint({
          { 1260, 837, 0x000000 }, { 1285, 837, 0x000000 },
          { 1305, 837, 0x000000 }, { 1326, 837, 0x000000 },
          { 1341, 836, 0x3169bd }, { 1316, 836, 0x3169bd },
          { 1295, 836, 0x2965b5 }, { 1269, 836, 0x2965b5 },
        })
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
    },
    -- 地图左边界
    leftLineList = {
      -- 2-1 左边
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022 }
        local basePoint, posandcolor = transRelativePoint({
          { 436, 561, 0x000000 }, { 437, 561, 0x29bade },
          { 436, 560, 0x000000 }, { 437, 560, 0x29bade },
          { 435, 562, 0x000000 }, { 436, 562, 0x29bade },
          { 435, 563, 0x000000 }, { 436, 563, 0x29b6d6 },
        })
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
      -- 3-1 左边
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022 }
        local basePoint, posandcolor = transRelativePoint({
          { 410, 714, 0x000000 }, { 411, 714, 0x218ac5 },
          { 410, 713, 0x000000 }, { 411, 713, 0x298ac5 },
          { 409, 715, 0x000000 }, { 410, 715, 0x218ec5 },
          { 409, 716, 0x000000 }, { 410, 716, 0x298ec5 },
        })
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
    },
    -- 地图右边界
    rightLineList = {
      -- 1-5 右边
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022 }
        local basePoint, posandcolor = transRelativePoint({
          { 1386, 454, 0x000000 }, { 1385, 454, 0x299ade },
          { 1386, 453, 0x000000 }, { 1385, 453, 0x299ee6 },
          { 1387, 455, 0x000000 }, { 1386, 455, 0x299ade },
          { 1387, 456, 0x000000 }, { 1386, 456, 0x299ee6 },
        })
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
      -- 3-5 右边
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022 }
        local basePoint, posandcolor = transRelativePoint({
          { 1423, 713, 0x000001 }, { 1422, 713, 0x3175bd },
          { 1423, 712, 0x000000 }, { 1422, 712, 0x3a79c5 },
          { 1424, 714, 0x000000 }, { 1423, 714, 0x3a75c5 },
          { 1424, 715, 0x000000 }, { 1423, 715, 0x4275c5 },
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