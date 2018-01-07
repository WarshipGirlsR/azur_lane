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
      -- 1-5的上边
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 889, 467, 0x213142 }, { 927, 467, 0x213142 },
          { 967, 467, 0x213542 }, { 1007, 467, 0x213542 },
          { 1022, 468, 0x31bade }, { 979, 468, 0x42ceef },
          { 941, 468, 0x31b6de }, { 900, 468, 0x3ab6de },
        })
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
      -- 1-7的上边
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 1422, 467, 0x293942 }, { 1459, 467, 0x29414a },
          { 1502, 467, 0x293942 }, { 1534, 467, 0x293942 },
          { 1556, 468, 0x3ac6de }, { 1517, 468, 0x3ac6de },
          { 1476, 468, 0x3acade }, { 1441, 468, 0x3ac6de },
        })
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
    },
    -- 地图下边界
    bottonLineList = {
      -- 5-2 的下面
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022 }
        local basePoint, posandcolor = transRelativePoint({
          { 614, 884, 0x000000 }, { 660, 884, 0x000000 },
          { 693, 884, 0x000000 }, { 726, 884, 0x000000 },
          { 751, 883, 0x2171b5 }, { 701, 883, 0x2175bd },
          { 674, 883, 0x1971b5 }, { 630, 883, 0x1971b5 },
        })
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
      -- 6-6 的下面
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022 }
        local basePoint, posandcolor = transRelativePoint({
          { 1109, 881, 0x000000 }, { 1158, 881, 0x000000 },
          { 1207, 881, 0x000000 }, { 1242, 881, 0x000000 },
          { 1265, 880, 0x1959ac }, { 1219, 880, 0x1059ac },
          { 1166, 880, 0x195db4 }, { 1128, 880, 0x1959ac },
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
    -- 奖励箱的位置
    rewardBoxList = imgBase.map.rewardBoxList,
  },
}