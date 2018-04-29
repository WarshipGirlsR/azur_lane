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
      -- 1-2的上边
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 513, 539, 0x212442 }, { 522, 539, 0x19243a },
          { 533, 539, 0x212442 }, { 541, 539, 0x212442 },
          { 550, 540, 0x31aede }, { 544, 540, 0x31aee6 },
          { 530, 540, 0x31aede }, { 521, 540, 0x31b2e6 },
        })
        return { basePoint[3], posandcolor, 93, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
      -- 1-5的上边
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 1001, 539, 0x212442 }, { 1017, 539, 0x212442 },
          { 1028, 539, 0x19243a }, { 1046, 539, 0x19243a },
          { 1058, 540, 0x31b6de }, { 1048, 540, 0x31b6e6 },
          { 1034, 540, 0x31b6de }, { 1018, 540, 0x31c2de },
        })
        return { basePoint[3], posandcolor, 93, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
      -- 1-6的上边
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 1173, 539, 0x212442 }, { 1191, 539, 0x212442 },
          { 1203, 539, 0x212442 }, { 1214, 539, 0x19243a },
          { 1232, 540, 0x42c6de }, { 1218, 540, 0x3ac2de },
          { 1204, 540, 0x42bede }, { 1190, 540, 0x3abede },
        })
        return { basePoint[3], posandcolor, 93, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
      -- 1-8的上边
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 1585, 539, 0x192031 }, { 1596, 539, 0x101829 },
          { 1609, 539, 0x191c31 }, { 1620, 539, 0x101829 },
          { 1632, 540, 0x31b6e6 }, { 1626, 540, 0x31b6de },
          { 1617, 540, 0x31b6de }, { 1594, 540, 0x31bade },
        })
        return { basePoint[3], posandcolor, 93, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
    },
    -- 地图下边界
    bottonLineList = {
      -- 6-1 的下面
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022 }
        local basePoint, posandcolor = transRelativePoint({
          { 512, 956, 0x000000 }, { 523, 956, 0x000000 },
          { 538, 956, 0x000000 }, { 554, 956, 0x000000 },
          { 566, 955, 0x197dbd }, { 555, 955, 0x2181c5 },
          { 535, 955, 0x2181c5 }, { 515, 955, 0x2181c5 },
        })
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
      -- 6-2 的下面
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022 }
        local basePoint, posandcolor = transRelativePoint({
          { 732, 956, 0x000000 }, { 754, 956, 0x000000 },
          { 769, 956, 0x000000 }, { 783, 956, 0x000000 },
          { 794, 955, 0x1971b5 }, { 785, 955, 0x2171bd },
          { 772, 955, 0x1971b5 }, { 752, 955, 0x1971b5 },
        })
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
      -- 6-4 的下面
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022 }
        local basePoint, posandcolor = transRelativePoint({
          { 514, 954, 0x000000 }, { 529, 954, 0x000000 },
          { 546, 954, 0x000000 }, { 563, 954, 0x000000 },
          { 574, 953, 0x1059ad }, { 562, 953, 0x105dad },
          { 547, 953, 0x1961b5 }, { 533, 953, 0x1961b5 },
        })
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
      -- 6-5 的下面
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022 }
        local basePoint, posandcolor = transRelativePoint({
          { 718, 954, 0x000000 }, { 730, 954, 0x000000 },
          { 750, 954, 0x000000 }, { 765, 954, 0x000000 },
          { 778, 953, 0x10499c }, { 758, 953, 0x10499c },
          { 741, 953, 0x104da4 }, { 725, 953, 0x1049a4 },
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
          { 284, 557, 0x000000 }, { 285, 557, 0x31a2de },
          { 284, 556, 0x000000 }, { 285, 556, 0x29a2de },
          { 283, 558, 0x000000 }, { 284, 558, 0x31a2de },
          { 283, 559, 0x000000 }, { 284, 559, 0x299ace },
        })
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
      -- 2-1 的左边
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 249, 717, 0x000000 }, { 250, 717, 0x29b2d6 },
          { 249, 716, 0x000000 }, { 250, 716, 0x31b6de },
          { 248, 718, 0x000000 }, { 249, 718, 0x31b6d6 },
          { 248, 719, 0x000000 }, { 249, 719, 0x31b6de },
        })
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
      -- 3-1 的左边
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 222, 840, 0x000000 }, { 223, 840, 0x29bade },
          { 222, 839, 0x000000 }, { 223, 839, 0x31bade },
          { 221, 841, 0x000000 }, { 222, 841, 0x29b6d6 },
          { 221, 842, 0x000000 }, { 222, 842, 0x31bade },
        })
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
      -- 6-1 的左边
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 476, 845, 0x000000 }, { 477, 845, 0x218ec5 },
          { 476, 844, 0x000000 }, { 477, 844, 0x218ac5 },
          { 475, 846, 0x000000 }, { 476, 846, 0x218ec5 },
          { 475, 847, 0x000000 }, { 476, 847, 0x218abd },
        })
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
    },
    -- 地图右边界
    rightLineList = {
      -- 5-8 的右边
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 1540, 812, 0x000000 }, { 1539, 812, 0x4275bd },
          { 1540, 811, 0x000000 }, { 1539, 811, 0x4275ce },
          { 1541, 813, 0x000000 }, { 1540, 813, 0x4275c5 },
          { 1541, 814, 0x000000 }, { 1540, 814, 0x4275ce },
        })
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
      -- 4-8 的右边
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 1491, 530, 0x000000 }, { 1490, 530, 0x319ad6 },
          { 1491, 529, 0x000000 }, { 1490, 529, 0x2996ce },
          { 1492, 531, 0x000000 }, { 1491, 531, 0x319ad6 },
          { 1492, 532, 0x000000 }, { 1491, 532, 0x299ad6 },
        })
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
      -- 2-8 的右边
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 1675, 688, 0x000000 }, { 1674, 688, 0x31aee6 },
          { 1675, 687, 0x000000 }, { 1674, 687, 0x29aade },
          { 1676, 689, 0x000000 }, { 1675, 689, 0x31aede },
          { 1676, 690, 0x000000 }, { 1675, 690, 0x31aade },
        })
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
      -- 1-8 的右边
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 1650, 576, 0x000000 }, { 1649, 576, 0x29aade },
          { 1650, 575, 0x000000 }, { 1649, 575, 0x29aade },
          { 1651, 577, 0x000000 }, { 1650, 577, 0x29aade },
          { 1651, 578, 0x000000 }, { 1650, 578, 0x31aee6 },
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