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
          { 579, 505, 0x19203a }, { 589, 505, 0x19243a },
          { 595, 505, 0x19203a }, { 602, 505, 0x102031 },
          { 609, 506, 0x3a496b }, { 602, 506, 0x424973 },
          { 592, 506, 0x3a456b }, { 584, 506, 0x3a4563 },
        })
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
      -- 1-3的上边
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 939, 505, 0x3a2d3a }, { 950, 505, 0x312831 },
          { 964, 505, 0x312831 }, { 974, 505, 0x312831 },
          { 983, 506, 0x3a4d73 }, { 974, 506, 0x424d73 },
          { 962, 506, 0x424d73 }, { 952, 506, 0x3a4d73 },
        })
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
      -- 1-4的上边
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 1133, 505, 0x423942 }, { 1146, 505, 0x3a3131 },
          { 1156, 505, 0x42393a }, { 1164, 505, 0x423942 },
          { 1172, 506, 0x425584 }, { 1157, 506, 0x3a517b },
          { 1147, 506, 0x3a517b }, { 1137, 506, 0x3a517b },
        })
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
      -- 1-6的上边
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 1450, 505, 0x212019 }, { 1461, 505, 0x292021 },
          { 1472, 505, 0x291c21 }, { 1485, 505, 0x4a3131 },
          { 1500, 506, 0x42557b }, { 1489, 506, 0x3a557b },
          { 1433, 506, 0x425984 }, { 1473, 506, 0x425984 },
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
          { 578, 946, 0x000000 }, { 590, 946, 0x000000 },
          { 604, 946, 0x000000 }, { 619, 946, 0x000000 },
          { 630, 945, 0x29314a }, { 618, 945, 0x29314a },
          { 608, 945, 0x29314a }, { 597, 945, 0x29354a },
        })
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
      -- 7-3 的下面
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022 }
        local basePoint, posandcolor = transRelativePoint({
          { 992, 946, 0x000000 }, { 1005, 946, 0x000000 },
          { 1018, 946, 0x000000 }, { 1030, 946, 0x000000 },
          { 1042, 945, 0x31416b }, { 1030, 945, 0x31416b },
          { 1017, 945, 0x3a456b }, { 1005, 945, 0x3a456b },
        })
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
    },
    -- 地图左边界
    leftLineList = {
      -- 1-1 的左边
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 571, 537, 0x000000 }, { 572, 537, 0x314163 },
          { 571, 536, 0x000000 }, { 572, 536, 0x42456b },
          { 570, 538, 0x000000 }, { 571, 538, 0x3a456b },
          { 570, 539, 0x000000 }, { 571, 539, 0x3a456b },
        })
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
      -- 2-1 的左边
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 561, 673, 0x000000 }, { 562, 673, 0x3a4973 },
          { 561, 672, 0x000000 }, { 562, 672, 0x424d7b },
          { 560, 674, 0x000000 }, { 561, 674, 0x424d73 },
          { 560, 675, 0x000000 }, { 561, 675, 0x424d73 },
        })
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
      -- 3-1 的左边
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 546, 876, 0x000000 }, { 547, 876, 0x3a4d73 },
          { 546, 875, 0x000000 }, { 547, 875, 0x424d73 },
          { 545, 877, 0x000000 }, { 546, 877, 0x3a496b },
          { 545, 878, 0x000000 }, { 546, 878, 0x424d73 },
        })
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
      -- 4-1 的左边
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 569, 412, 0x000000 }, { 570, 412, 0x42517b },
          { 569, 411, 0x000000 }, { 570, 411, 0x424d73 },
          { 568, 413, 0x000000 }, { 569, 413, 0x424d73 },
          { 568, 414, 0x000000 }, { 569, 414, 0x424d73 },
        })
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
      -- 5-1 的左边
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 556, 583, 0x000000 }, { 557, 583, 0x4a5984 },
          { 556, 582, 0x000000 }, { 557, 582, 0x4a5984 },
          { 555, 584, 0x000000 }, { 556, 584, 0x4a5984 },
          { 555, 585, 0x000000 }, { 556, 585, 0x425984 },
        })
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
      -- 7-1 的左边
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 533, 886, 0x000000 }, { 534, 886, 0x424163 },
          { 533, 885, 0x000000 }, { 534, 885, 0x313d5a },
          { 532, 887, 0x000000 }, { 533, 887, 0x3a4163 },
          { 532, 888, 0x000000 }, { 533, 888, 0x3a4163 },
        })
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
    },
    -- 地图右边界
    rightLineList = {
      -- 1-7 的右边
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 1447, 545, 0x000000 }, { 1446, 545, 0x5a7184 },
          { 1447, 544, 0x000000 }, { 1446, 544, 0x5a758c },
          { 1448, 546, 0x000000 }, { 1447, 546, 0x5a7184 },
          { 1448, 547, 0x000000 }, { 1447, 547, 0x5a758c },
        })
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
      -- 2-7 的右边
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 1460, 686, 0x000000 }, { 1459, 686, 0x5a6984 },
          { 1460, 685, 0x000000 }, { 1459, 685, 0x5a6984 },
          { 1461, 687, 0x000000 }, { 1460, 687, 0x5a6984 },
          { 1461, 688, 0x000000 }, { 1460, 688, 0x636d8c },
        })
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
      -- 4-7 的右边
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 1605, 800, 0x000000 }, { 1604, 800, 0x42496b },
          { 1605, 799, 0x000000 }, { 1604, 799, 0x314963 },
          { 1606, 801, 0x000000 }, { 1605, 801, 0x3a496b },
          { 1606, 802, 0x000000 }, { 1605, 802, 0x3a496b },
        })
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
      -- 6-7 的右边
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 1497, 678, 0x000000 }, { 1496, 678, 0x4a5573 },
          { 1497, 677, 0x000000 }, { 1496, 677, 0x42516b },
          { 1498, 679, 0x000000 }, { 1497, 679, 0x4a556b },
          { 1498, 680, 0x000000 }, { 1497, 680, 0x4a516b },
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