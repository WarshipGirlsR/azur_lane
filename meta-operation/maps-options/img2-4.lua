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
      -- 1-1 上边
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 418, 309, 0x213d42 }, { 432, 309, 0x213d42 },
          { 450, 309, 0x213d42 }, { 472, 309, 0x213d42 },
          { 484, 310, 0x31aae6 }, { 462, 310, 0x319ee6 },
          { 445, 310, 0x299ede }, { 427, 310, 0x299ede },
        })
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
      -- 1-5 上边
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 1207, 309, 0x213142 }, { 1222, 309, 0x192d3a },
          { 1238, 309, 0x192d3a }, { 1256, 309, 0x212d42 },
          { 1267, 310, 0x3ac2de }, { 1246, 310, 0x3ac2de },
          { 1226, 310, 0x3abee6 }, { 1202, 310, 0x31bade },
        })
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
      -- 1-7 上边
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 1480, 309, 0x19253a }, { 1496, 309, 0x19243a },
          { 1513, 309, 0x212842 }, { 1529, 309, 0x212842 },
          { 1539, 310, 0x31bede }, { 1522, 310, 0x3abee6 },
          { 1502, 310, 0x3ac2de }, { 1482, 310, 0x3ac6e6 },
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
          { 613, 859, 0x000000 }, { 643, 859, 0x000000 },
          { 668, 859, 0x000000 }, { 699, 859, 0x000000 },
          { 717, 858, 0x1965ad }, { 676, 858, 0x1969b5 },
          { 646, 858, 0x1965b5 }, { 625, 858, 0x1965ad },
        })
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
    },
    -- 地图左边界
    leftLineList = {
      -- 1-1 左边
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022 }
        local basePoint, posandcolor = transRelativePoint({
          { 384, 344, 0x000000 }, { 385, 344, 0x31a2e6 },
          { 384, 343, 0x000000 }, { 385, 343, 0x31a2e6 },
          { 383, 345, 0x000000 }, { 384, 345, 0x29a2de },
          { 383, 346, 0x000000 }, { 384, 346, 0x31a2e6 },
        })
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
      -- 4-1 左边
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022 }
        local basePoint, posandcolor = transRelativePoint({
          { 309, 794, 0x000000 }, { 310, 794, 0x2992ce },
          { 309, 793, 0x000000 }, { 310, 793, 0x218ebd },
          { 308, 795, 0x000000 }, { 309, 795, 0x298ece },
          { 308, 796, 0x000000 }, { 309, 796, 0x298ec5 },
        })
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
    },
    -- 地图右边界
    rightLineList = {
      -- 1-7 右边
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022 }
        local basePoint, posandcolor = transRelativePoint({
          { 1637, 337, 0x000000 }, { 1636, 337, 0x29aede },
          { 1637, 336, 0x000000 }, { 1636, 336, 0x31aede },
          { 1638, 338, 0x000000 }, { 1637, 338, 0x29aede },
          { 1638, 339, 0x000000 }, { 1637, 339, 0x31aede },
        })
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
      -- 2-7 右边
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022 }
        local basePoint, posandcolor = transRelativePoint({
          { 1667, 490, 0x000000 }, { 1666, 490, 0x31bee6 },
          { 1667, 489, 0x000000 }, { 1666, 489, 0x29bade },
          { 1668, 491, 0x000000 }, { 1667, 491, 0x31bee6 },
          { 1668, 492, 0x000000 }, { 1667, 492, 0x29bade },
        })
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
      -- 4-7 右边
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022 }
        local basePoint, posandcolor = transRelativePoint({
          { 1738, 851, 0x000000 }, { 1737, 851, 0x3a75c5 },
          { 1738, 850, 0x000000 }, { 1737, 850, 0x3a75c5 },
          { 1739, 852, 0x000000 }, { 1738, 852, 0x3a79c5 },
          { 1739, 853, 0x000000 }, { 1738, 853, 0x3175bd },
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