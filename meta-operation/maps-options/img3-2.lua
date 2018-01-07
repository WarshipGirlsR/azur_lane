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
      (function()
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
      -- 1-5上方
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 1040, 378, 0x3a3d42 }, { 1086, 378, 0x3a3942 },
          { 1133, 378, 0x31393a }, { 1168, 378, 0x313942 },
          { 1190, 379, 0x29bade }, { 1148, 379, 0x29b2d6 },
          { 1107, 379, 0x31b6de }, { 1067, 379, 0x31bade },
        })
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
      -- 1-8上方
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 1572, 378, 0x42454a }, { 1616, 378, 0x31393a },
          { 1666, 378, 0x292831 }, { 1695, 378, 0x212429 },
          { 1720, 379, 0x29b2d6 }, { 1688, 379, 0x31bade },
          { 1634, 379, 0x31bade }, { 1590, 379, 0x31bed6 },
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
          { 482, 918, 0x000000 }, { 554, 918, 0x000000 },
          { 615, 918, 0x000000 }, { 658, 918, 0x000000 },
          { 636, 917, 0x1971b4 }, { 596, 917, 0x2171b4 },
          { 560, 917, 0x2171b4 }, { 518, 917, 0x1971ac },
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
          { 455, 458, 0x000000 }, { 456, 458, 0x31bade },
          { 455, 457, 0x000000 }, { 456, 457, 0x31b6de },
          { 454, 459, 0x000000 }, { 455, 459, 0x31bade },
          { 454, 460, 0x000000 }, { 455, 460, 0x31bade },
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
          { 1609, 304, 0x000000 }, { 1608, 304, 0x29a2e6 },
          { 1609, 303, 0x000000 }, { 1608, 303, 0x219ede },
          { 1610, 305, 0x000000 }, { 1609, 305, 0x299ee6 },
          { 1610, 306, 0x000000 }, { 1609, 306, 0x299ede },
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