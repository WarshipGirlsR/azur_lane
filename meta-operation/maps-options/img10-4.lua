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
          { 466, 525, 0x081c19 }, { 478, 525, 0x000c10 },
          { 489, 525, 0x080c19 }, { 498, 525, 0x000c10 },
          { 515, 526, 0x312d63 }, { 504, 526, 0x3a3963 },
          { 496, 526, 0x3a3963 }, { 488, 526, 0x3a3963 },
        })
        return { basePoint[3], posandcolor, 93, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
      -- 1-9的上边
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 1484, 519, 0x081019 }, { 1494, 519, 0x081419 },
          { 1512, 519, 0x081419 }, { 1527, 519, 0x101421 },
          { 1546, 520, 0x6b75b5 }, { 1531, 520, 0x6b71ad },
          { 1519, 520, 0x6b71ad }, { 1506, 520, 0x6b75b5 },
        })
        return { basePoint[3], posandcolor, 93, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
      -- 1-8的上边
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 1289, 519, 0x081421 }, { 1298, 519, 0x081019 },
          { 1307, 519, 0x101421 }, { 1315, 519, 0x101421 },
          { 1328, 520, 0x5a65a4 }, { 1318, 520, 0x5a65a4 },
          { 1312, 520, 0x5a61a4 }, { 1304, 520, 0x5a61a4 },
        })
        return { basePoint[3], posandcolor, 93, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
      -- 1-7的上边
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 1072, 519, 0x000c10 }, { 1082, 519, 0x000c10 },
          { 1091, 519, 0x101019 }, { 1098, 519, 0x000c10 },
          { 1107, 520, 0x3a4173 }, { 1100, 520, 0x424573 },
          { 1091, 520, 0x3a416b }, { 1082, 520, 0x3a416b },
        })
        return { basePoint[3], posandcolor, 93, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
      -- 1-3的上边
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 785, 525, 0x293142 }, { 795, 525, 0x21283a },
          { 803, 525, 0x192431 }, { 808, 525, 0x192029 },
          { 823, 526, 0x3a3163 }, { 815, 526, 0x3a3163 },
          { 807, 526, 0x3a3163 }, { 798, 526, 0x423963 },
        })
        return { basePoint[3], posandcolor, 93, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
      -- 1-5的上边
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 1140, 525, 0x081019 }, { 1149, 525, 0x101419 },
          { 1156, 525, 0x081019 }, { 1166, 525, 0x001019 },
          { 1177, 526, 0x3a396b }, { 1169, 526, 0x3a396b },
          { 1163, 526, 0x3a396b }, { 1152, 526, 0x3a416b },
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
          { 359, 966, 0x000000 }, { 370, 966, 0x000000 },
          { 384, 966, 0x000000 }, { 397, 966, 0x000000 },
          { 407, 968, 0x000000 }, { 398, 968, 0x000000 },
          { 391, 968, 0x000000 }, { 396, 965, 0x212042 },
          { 386, 965, 0x212042 }, { 380, 965, 0x212042 },
        })
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
      -- 6-6 的下面
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022 }
        local basePoint, posandcolor = transRelativePoint({
          { 916, 940, 0x000000 }, { 927, 940, 0x000000 },
          { 938, 940, 0x000000 }, { 947, 940, 0x000000 },
          { 962, 939, 0x29284a }, { 954, 939, 0x29284a },
          { 946, 939, 0x29244a }, { 940, 939, 0x29244a },
          { 940, 942, 0x000000 }, { 931, 942, 0x000000 },
        })
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
      -- 6-4 的下面
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022 }
        local basePoint, posandcolor = transRelativePoint({
          { 472, 940, 0x000000 }, { 481, 940, 0x000000 },
          { 492, 940, 0x000000 }, { 502, 940, 0x000000 },
          { 510, 939, 0x29204a }, { 502, 939, 0x29204a },
          { 495, 939, 0x31204a }, { 488, 939, 0x292442 },
          { 488, 942, 0x000000 }, { 495, 943, 0x000000 },
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
          { 422, 557, 0x000000 }, { 423, 557, 0x312d5a },
          { 422, 556, 0x000000 }, { 423, 556, 0x31285a },
          { 421, 558, 0x000000 }, { 422, 558, 0x31315a },
          { 421, 559, 0x000000 }, { 422, 559, 0x31285a },
        })
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
      -- 2-1 的左边
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 397, 700, 0x000000 }, { 398, 700, 0x313552 },
          { 397, 699, 0x000000 }, { 398, 699, 0x292852 },
          { 396, 701, 0x000000 }, { 397, 701, 0x312d52 },
          { 396, 702, 0x000000 }, { 397, 702, 0x312852 },
        })
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
      -- 6-1 的左边
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 330, 849, 0x000000 }, { 331, 849, 0x29204a },
          { 330, 848, 0x000400 }, { 331, 848, 0x29204a },
          { 329, 850, 0x000000 }, { 330, 850, 0x29204a },
          { 329, 851, 0x000000 }, { 330, 851, 0x29204a },
        })
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
    },
    -- 地图右边界
    rightLineList = {
      -- 1-9 的右边
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 1554, 525, 0x000000 }, { 1553, 525, 0x6b71ad },
          { 1554, 524, 0x000000 }, { 1553, 524, 0x6b71ad },
          { 1555, 526, 0x000000 }, { 1554, 526, 0x6b71b5 },
          { 1555, 527, 0x000000 }, { 1554, 527, 0x636dad },
        })
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
      -- 2-9 的右边
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 1588, 699, 0x000000 }, { 1587, 699, 0x6355a4 },
          { 1588, 698, 0x000000 }, { 1587, 698, 0x5a55a4 },
          { 1589, 700, 0x000000 }, { 1588, 700, 0x6359a4 },
          { 1589, 701, 0x000000 }, { 1588, 701, 0x5a559c },
        })
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
      -- 6-9 的右边
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 1727, 800, 0x000000 }, { 1726, 800, 0x3a3963 },
          { 1727, 799, 0x000000 }, { 1726, 799, 0x3a315a },
          { 1728, 801, 0x000000 }, { 1727, 801, 0x3a315a },
          { 1728, 802, 0x000000 }, { 1727, 802, 0x3a315a },
        })
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
      -- 5-9 的右边
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 1696, 666, 0x000000 }, { 1695, 666, 0x3a3563 },
          { 1696, 665, 0x000000 }, { 1695, 665, 0x3a3563 },
          { 1697, 667, 0x000000 }, { 1696, 667, 0x3a3163 },
          { 1697, 668, 0x000000 }, { 1696, 668, 0x423d6b },
        })
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
      -- 5-8 的右边
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 1664, 663, 0x000000 }, { 1663, 663, 0x3a3563 },
          { 1664, 662, 0x000000 }, { 1663, 662, 0x3a3563 },
          { 1665, 664, 0x000000 }, { 1664, 664, 0x423d6b },
          { 1665, 665, 0x000000 }, { 1664, 665, 0x3a3563 },
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