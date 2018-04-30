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
      -- 1-8的上边
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 1558, 509, 0x192031 }, { 1565, 509, 0x212442 },
          { 1576, 509, 0x212031 }, { 1588, 509, 0x191c31 },
          { 1598, 510, 0x3abee6 }, { 1586, 510, 0x3ac2e6 },
          { 1570, 510, 0x31c2de }, { 1559, 510, 0x31bede },
        })
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
      -- 1-7的上边
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 1390, 509, 0x192031 }, { 1405, 509, 0x212442 },
          { 1421, 509, 0x212442 }, { 1435, 509, 0x212431 },
          { 1448, 510, 0x3acade }, { 1428, 510, 0x3acade },
          { 1413, 510, 0x3ac6d6 }, { 1396, 510, 0x42dbe6 },
        })
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
      -- 1-4的上边
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 898, 509, 0x101c31 }, { 918, 509, 0x191c31 },
          { 935, 509, 0x19203a }, { 950, 509, 0x191c31 },
          { 959, 510, 0x31b6de }, { 938, 510, 0x3ab6e6 },
          { 924, 510, 0x31b2de }, { 909, 510, 0x31b2de },
        })
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
      -- 1-1的上边
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 395, 523, 0x3a353a }, { 408, 523, 0x292829 },
          { 417, 523, 0x312d31 }, { 426, 523, 0x292829 },
          { 438, 524, 0x31a2e6 }, { 428, 524, 0x319ee6 },
          { 418, 524, 0x319ee6 }, { 408, 524, 0x319ee6 },
        })
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
      -- 1-2的上边
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 554, 523, 0x292829 }, { 567, 523, 0x312d31 },
          { 581, 523, 0x312d31 }, { 592, 523, 0x292829 },
          { 601, 524, 0x31aede }, { 588, 524, 0x31aee6 },
          { 577, 524, 0x31b2e6 }, { 566, 524, 0x31b2de },
        })
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
    },
    -- 地图下边界
    bottonLineList = {
      -- 7-1 的下面
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022 }
        local basePoint, posandcolor = transRelativePoint({
          { 572, 906, 0x000000 }, { 589, 906, 0x000000 },
          { 604, 906, 0x000000 }, { 617, 906, 0x000000 },
          { 631, 905, 0x2181c5 }, { 608, 905, 0x197dc5 },
          { 591, 905, 0x2181c5 }, { 574, 905, 0x217dbd },
        })
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
      -- 6-3 的下面
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022 }
        local basePoint, posandcolor = transRelativePoint({
          { 1009, 906, 0x000000 }, { 1029, 906, 0x000000 },
          { 1043, 906, 0x000000 }, { 1055, 906, 0x000000 },
          { 1066, 905, 0x1965b5 }, { 1049, 905, 0x2169b5 },
          { 1034, 905, 0x1969b5 }, { 1020, 905, 0x1969ad },
        })
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
      -- 6-5 的下面
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022 }
        local basePoint, posandcolor = transRelativePoint({
          { 1444, 906, 0x000000 }, { 1461, 906, 0x000000 },
          { 1475, 906, 0x000000 }, { 1488, 906, 0x000000 },
          { 1501, 905, 0x1049a4 }, { 1481, 905, 0x104da4 },
          { 1465, 905, 0x1049a4 }, { 1452, 905, 0x104da4 },
        })
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
      -- 6-8 的下面
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022 }
        local basePoint, posandcolor = transRelativePoint({
          { 1549, 905, 0x000000 }, { 1566, 905, 0x000000 },
          { 1581, 905, 0x000000 }, { 1595, 905, 0x000000 },
          { 1607, 904, 0x3a6dbd }, { 1587, 904, 0x3169b5 },
          { 1572, 904, 0x3169bd }, { 1557, 904, 0x3169bd },
        })
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
    },
    -- 地图左边界
    leftLineList = {
      -- 1-7 的左边
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 544, 784, 0x000000 }, { 545, 784, 0x218ec5 },
          { 544, 783, 0x000000 }, { 545, 783, 0x218ec5 },
          { 543, 785, 0x000000 }, { 544, 785, 0x218ec5 },
          { 543, 786, 0x000000 }, { 544, 786, 0x2992ce },
        })
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
      -- 1-5 的左边
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 581, 489, 0x000000 }, { 582, 489, 0x3192d6 },
          { 581, 488, 0x000000 }, { 582, 488, 0x3a96de },
          { 580, 490, 0x000000 }, { 581, 490, 0x3196d6 },
          { 580, 491, 0x000000 }, { 581, 491, 0x3a96d6 },
        })
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
      -- 1-3 的左边
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 614, 227, 0x000101 }, { 615, 227, 0x31bad6 },
          { 614, 226, 0x000000 }, { 615, 226, 0x29bad6 },
          { 613, 228, 0x000000 }, { 614, 228, 0x31bad6 },
          { 613, 229, 0x000000 }, { 614, 229, 0x29b6d6 },
        })
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
      -- 1-1 的左边
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 337, 601, 0x000000 }, { 338, 601, 0x31aade },
          { 337, 600, 0x000000 }, { 338, 600, 0x3aaede },
          { 336, 602, 0x000000 }, { 337, 602, 0x31aede },
          { 336, 603, 0x000000 }, { 337, 603, 0x31aede },
        })
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
    },
    -- 地图右边界
    rightLineList = {
      -- 7-8 的右边
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 1724, 850, 0x000000 }, { 1723, 850, 0x3171c5 },
          { 1724, 849, 0x000000 }, { 1723, 849, 0x3175c5 },
          { 1725, 851, 0x000000 }, { 1724, 851, 0x3171bd },
          { 1725, 852, 0x000000 }, { 1724, 852, 0x3a75ce },
        })
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
      -- 4-8 的右边
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 1617, 378, 0x000000 }, { 1616, 378, 0x31b2de },
          { 1617, 377, 0x000000 }, { 1616, 377, 0x29b2d6 },
          { 1618, 379, 0x000000 }, { 1617, 379, 0x31b2de },
          { 1618, 380, 0x000000 }, { 1617, 380, 0x31b2de },
        })
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
      -- 1-8 的右边
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 1672, 290, 0x000000 }, { 1671, 290, 0x31aede },
          { 1672, 289, 0x000000 }, { 1671, 289, 0x31b2de },
          { 1673, 291, 0x000000 }, { 1672, 291, 0x29aede },
          { 1673, 292, 0x000000 }, { 1672, 292, 0x31b2e6 },
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