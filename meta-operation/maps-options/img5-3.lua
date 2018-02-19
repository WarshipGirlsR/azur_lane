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
          { 474, 477, 0x193d21 }, { 483, 477, 0x214531 },
          { 495, 477, 0x214131 }, { 505, 477, 0x29493a },
          { 513, 478, 0x299ede }, { 500, 478, 0x319edd },
          { 489, 478, 0x299ede }, { 478, 478, 0x319ee6 },
        })
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
      -- 1-4的上边
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 1007, 474, 0x212d42 }, { 1015, 474, 0x212d42 },
          { 1023, 474, 0x212d42 }, { 1032, 474, 0x21354a },
          { 1044, 475, 0x29b6de }, { 1033, 475, 0x31bade },
          { 1022, 475, 0x31bade }, { 1009, 475, 0x31bede },
        })
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
      -- 1-7的上边
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 1505, 474, 0x213542 }, { 1512, 474, 0x293d4a },
          { 1519, 474, 0x21354a }, { 1526, 474, 0x313d4a },
          { 1534, 475, 0x31bade }, { 1526, 475, 0x31bede },
          { 1516, 475, 0x31bede }, { 1509, 475, 0x3ac2de },
        })
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
    },
    -- 地图下边界
    bottonLineList = {
      -- 5-1 的下面
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022 }
        local basePoint, posandcolor = transRelativePoint({
          { 422, 850, 0x010203 }, { 433, 850, 0x010203 },
          { 445, 850, 0x010203 }, { 455, 850, 0x010203 },
          { 468, 849, 0x217ebd }, { 456, 849, 0x217ebd },
          { 444, 849, 0x2181c5 }, { 433, 849, 0x2985c5 },
        })
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
      -- 5-7 的下面
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
      -- 1-1 的左边
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 652, 739, 0x000000 }, { 653, 739, 0x29a2de },
          { 652, 738, 0x000000 }, { 653, 738, 0x299ede },
          { 651, 740, 0x000000 }, { 652, 740, 0x31a2e6 },
          { 651, 741, 0x000000 }, { 652, 741, 0x299ede },
        })
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
      -- 1-1 的左边
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 451, 492, 0x000000 }, { 452, 492, 0x31a2de },
          { 451, 491, 0x000000 }, { 452, 491, 0x29a2de },
          { 450, 493, 0x000000 }, { 451, 493, 0x31a2de },
          { 450, 494, 0x000000 }, { 451, 494, 0x29a2de },
        })
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
      -- 1-4 的左边
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 447, 536, 0x010203 }, { 448, 536, 0x4296d6 },
          { 447, 535, 0x010203 }, { 448, 535, 0x3196ce },
          { 446, 537, 0x010203 }, { 447, 537, 0x3993d2 },
          { 446, 538, 0x010203 }, { 447, 538, 0x3296d6 },
        })
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
    },
    -- 地图右边界
    rightLineList = {
      -- 7-4 的右边
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 1453, 623, 0x000400 }, { 1452, 623, 0x3175c5 },
          { 1453, 622, 0x000000 }, { 1452, 622, 0x3978c2 },
          { 1454, 624, 0x000000 }, { 1453, 624, 0x3974c2 },
          { 1454, 625, 0x000000 }, { 1453, 625, 0x3a79c5 },
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