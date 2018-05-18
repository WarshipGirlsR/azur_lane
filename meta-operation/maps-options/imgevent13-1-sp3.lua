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
      -- 1-1的上边
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 459, 531, 0x213942 }, { 472, 531, 0x193542 },
          { 486, 531, 0x193542 }, { 495, 531, 0x213942 },
          { 503, 532, 0x299ede }, { 490, 532, 0x319ee6 },
          { 478, 532, 0x29a2de }, { 464, 532, 0x319ee6 },
        })
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
      -- 1-9的上边
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 1502, 529, 0x103942 }, { 1516, 529, 0x193942 },
          { 1528, 529, 0x193942 }, { 1547, 529, 0x193d4a },
          { 1556, 530, 0x31b6de }, { 1543, 530, 0x31b6de },
          { 1527, 530, 0x31bade }, { 1515, 530, 0x31bade },
        })
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
      -- 1-2的上边
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 636, 531, 0x193942 }, { 652, 531, 0x193542 },
          { 662, 531, 0x193542 }, { 673, 531, 0x29414a },
          { 684, 532, 0x31b6e6 }, { 677, 532, 0x29b2d6 },
          { 666, 532, 0x31aede }, { 655, 532, 0x31aede },
        })
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
      -- 1-8的上边
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 1322, 529, 0x193542 }, { 1337, 529, 0x19394a },
          { 1350, 529, 0x193542 }, { 1366, 529, 0x193542 },
          { 1382, 530, 0x42c6e6 }, { 1367, 530, 0x3ac2de },
          { 1352, 530, 0x42c6de }, { 1342, 530, 0x42c6e6 },
        })
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
      -- 1-5的上边
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 780, 529, 0x213942 }, { 791, 529, 0x213d4a },
          { 802, 529, 0x193942 }, { 815, 529, 0x213d4a },
          { 829, 530, 0x31bade }, { 820, 530, 0x31b6de },
          { 800, 530, 0x4ac6d6 }, { 786, 530, 0x31bade },
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
          { 385, 949, 0x000000 }, { 404, 949, 0x000000 },
          { 424, 949, 0x000000 }, { 441, 949, 0x000000 },
          { 456, 948, 0x2181c5 }, { 440, 948, 0x2181c5 },
          { 422, 948, 0x2186c5 }, { 400, 948, 0x2986ce },
          { 400, 951, 0x000000 }, { 430, 951, 0x000000 },
        })
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
      -- 7-3 的下面
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022 }
        local basePoint, posandcolor = transRelativePoint({
          { 851, 948, 0x1071b5 }, { 872, 948, 0x2171bd },
          { 885, 948, 0x1971b5 }, { 902, 948, 0x196db5 },
          { 918, 949, 0x000000 }, { 905, 949, 0x000000 },
          { 885, 949, 0x000000 }, { 864, 949, 0x000000 },
          { 864, 951, 0x000000 }, { 888, 951, 0x000000 },
        })
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
      -- 7-5 的下面
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022 }
        local basePoint, posandcolor = transRelativePoint({
          { 450, 937, 0x10559c }, { 464, 937, 0x1051a4 },
          { 477, 937, 0x1051a4 }, { 492, 937, 0x104da4 },
          { 503, 938, 0x000000 }, { 494, 938, 0x000000 },
          { 476, 938, 0x000000 }, { 461, 938, 0x000000 },
          { 462, 940, 0x000000 }, { 493, 940, 0x000000 },
        })
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
      -- 7-7 的下面
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022 }
        local basePoint, posandcolor = transRelativePoint({
          { 883, 938, 0x000000 }, { 894, 938, 0x000000 },
          { 905, 938, 0x000000 }, { 917, 938, 0x000000 },
          { 928, 937, 0x1055ad }, { 918, 937, 0x1055ad },
          { 904, 937, 0x1055ad }, { 883, 937, 0x1955ad },
          { 882, 940, 0x000000 }, { 894, 940, 0x000000 },
        })
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
    },
    -- 地图左边界
    leftLineList = {
      -- 7-1 的左边
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 359, 930, 0x000000 }, { 360, 930, 0x2986c5 },
          { 359, 929, 0x000000 }, { 360, 929, 0x2181c5 },
          { 358, 931, 0x000000 }, { 359, 931, 0x2986c5 },
          { 358, 932, 0x000000 }, { 359, 932, 0x217dbd },
        })
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
      -- 5-1 的左边
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 432, 510, 0x000000 }, { 433, 510, 0x3a92d6 },
          { 432, 509, 0x000000 }, { 433, 509, 0x3a92d6 },
          { 431, 511, 0x000000 }, { 432, 511, 0x3192d6 },
          { 431, 512, 0x000000 }, { 432, 512, 0x4296de },
        })
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
      -- 4-1 的左边
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 293, 809, 0x000000 }, { 294, 809, 0x21aed6 },
          { 293, 808, 0x000000 }, { 294, 808, 0x29b2d6 },
          { 292, 810, 0x000000 }, { 293, 810, 0x29b2d6 },
          { 292, 811, 0x000000 }, { 293, 811, 0x29b2d6 },
        })
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
      -- 1-1 的左边
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 429, 559, 0x000000 }, { 430, 559, 0x299ede },
          { 429, 558, 0x000000 }, { 430, 558, 0x31a2de },
          { 428, 560, 0x000000 }, { 429, 560, 0x299ede },
          { 428, 561, 0x000000 }, { 429, 561, 0x31a2de },
        })
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
      -- 2-1 的左边
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 404, 705, 0x000000 }, { 405, 705, 0x31aede },
          { 404, 704, 0x000000 }, { 405, 704, 0x31aede },
          { 403, 706, 0x000000 }, { 404, 706, 0x31aede },
          { 403, 707, 0x000000 }, { 404, 707, 0x29aad6 },
        })
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
    },
    -- 地图右边界
    rightLineList = {
      -- 7-9 的右边
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 1491, 822, 0x000000 }, { 1490, 822, 0x4275ce },
          { 1491, 821, 0x000000 }, { 1490, 821, 0x3a75bd },
          { 1492, 823, 0x000000 }, { 1491, 823, 0x3a75c5 },
          { 1492, 824, 0x000000 }, { 1491, 824, 0x3a75bd },
        })
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
      -- 4-9 的右边
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 1418, 363, 0x000000 }, { 1417, 363, 0x31aade },
          { 1418, 362, 0x000000 }, { 1417, 362, 0x31aad6 },
          { 1419, 364, 0x000000 }, { 1418, 364, 0x31aede },
          { 1419, 365, 0x000000 }, { 1418, 365, 0x29aad6 },
        })
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
      -- 1-9 的右边
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 1577, 560, 0x000000 }, { 1576, 560, 0x31b2e6 },
          { 1577, 559, 0x000000 }, { 1576, 559, 0x29aede },
          { 1578, 561, 0x000000 }, { 1577, 561, 0x31aede },
          { 1578, 562, 0x000000 }, { 1577, 562, 0x29aede },
        })
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
      -- 2-9 的右边
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 1629, 820, 0x000000 }, { 1628, 820, 0x31c2e6 },
          { 1629, 819, 0x000000 }, { 1628, 819, 0x29bede },
          { 1630, 821, 0x000000 }, { 1629, 821, 0x31bee6 },
          { 1630, 822, 0x000000 }, { 1629, 822, 0x29bede },
        })
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
      -- 6-9 的右边
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 1460, 627, 0x000000 }, { 1459, 627, 0x3a79c5 },
          { 1460, 626, 0x000000 }, { 1459, 626, 0x3a79c5 },
          { 1461, 628, 0x000000 }, { 1460, 628, 0x4279ce },
          { 1461, 629, 0x000000 }, { 1460, 629, 0x3a75c5 },
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