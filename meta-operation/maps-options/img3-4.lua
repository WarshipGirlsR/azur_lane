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
          { 398, 334, 0x314152 }, { 429, 334, 0x293d4a },
          { 471, 334, 0x293d4a }, { 501, 334, 0x213d4a },
          { 485, 335, 0x31aade }, { 463, 335, 0x31a6de },
          { 439, 335, 0x319ede }, { 409, 335, 0x29a2de },
        })
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
      -- 1-6 上方
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 1229, 559, 0x212431 }, { 1277, 559, 0x212431 },
          { 1314, 559, 0x192429 }, { 1344, 559, 0x192421 },
          { 1362, 560, 0x42cade }, { 1329, 560, 0x3ac2de },
          { 1292, 560, 0x3ac2de }, { 1248, 560, 0x3abede },
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
          { 271, 652, 0x000000 }, { 272, 652, 0x3ab2e6 },
          { 271, 651, 0x000000 }, { 272, 651, 0x31aad6 },
          { 270, 653, 0x000000 }, { 271, 653, 0x31aede },
          { 270, 654, 0x000000 }, { 271, 654, 0x31aede },
        })
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
      -- 4-1 的左边
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022 }
        local basePoint, posandcolor = transRelativePoint({
          { 342, 803, 0x000000 }, { 343, 803, 0x218ec5 },
          { 342, 802, 0x080408 }, { 343, 802, 0x218ec5 },
          { 341, 804, 0x000000 }, { 342, 804, 0x298ec5 },
          { 341, 805, 0x000000 }, { 342, 805, 0x218abd },
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
      -- 4-8 的右边
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022 }
        local basePoint, posandcolor = transRelativePoint({
          { 1733, 831, 0x000000 }, { 1732, 831, 0x296dbd },
          { 1733, 830, 0x000000 }, { 1732, 830, 0x316dc5 },
          { 1734, 832, 0x000000 }, { 1733, 832, 0x316dbd },
          { 1734, 833, 0x000000 }, { 1733, 833, 0x316dbd },
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