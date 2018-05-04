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
      -- 1-9的上边
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 1567, 510, 0x21203a }, { 1579, 510, 0x191829 },
          { 1587, 510, 0x101429 }, { 1598, 510, 0x212042 },
          { 1604, 511, 0x6371ad }, { 1593, 511, 0x6b75b5 },
          { 1581, 511, 0x6b75ad }, { 1569, 511, 0x6b6dad },
        })
        return { basePoint[3], posandcolor, 95, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
      -- 1-8的上边
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 1399, 510, 0x191c31 }, { 1408, 510, 0x21203a },
          { 1417, 510, 0x191c31 }, { 1429, 510, 0x191c31 },
          { 1431, 511, 0x636dad }, { 1420, 511, 0x52659c },
          { 1406, 511, 0x5a659c }, { 1394, 511, 0x5a619c },
        })
        return { basePoint[3], posandcolor, 95, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
      -- 1-2的上边
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 777, 515, 0x212031 }, { 793, 515, 0x212031 },
          { 807, 515, 0x191c31 }, { 822, 515, 0x101829 },
          { 837, 516, 0x3a3163 }, { 825, 516, 0x3a315a },
          { 813, 516, 0x3a3163 }, { 802, 516, 0x3a3963 },
        })
        return { basePoint[3], posandcolor, 95, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
      -- 1-4的上边
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 1119, 515, 0x191831 }, { 1132, 515, 0x101829 },
          { 1147, 515, 0x191831 }, { 1160, 515, 0x101829 },
          { 1171, 516, 0x312d5a }, { 1160, 516, 0x423963 },
          { 1148, 516, 0x423963 }, { 1136, 516, 0x423963 },
        })
        return { basePoint[3], posandcolor, 95, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
      -- 1-5的上边
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 823, 510, 0x191831 }, { 837, 510, 0x191429 },
          { 850, 510, 0x211831 }, { 864, 510, 0x211831 },
          { 879, 511, 0x424173 }, { 866, 511, 0x3a3d73 },
          { 853, 511, 0x3a4173 }, { 837, 511, 0x3a3d6b },
        })
        return { basePoint[3], posandcolor, 95, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
      -- 1-2的上边
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 803, 240, 0x21283a }, { 816, 240, 0x293542 },
          { 833, 240, 0x212842 }, { 850, 240, 0x213542 },
          { 867, 241, 0x3a3163 }, { 855, 241, 0x3a3163 },
          { 840, 241, 0x3a3163 }, { 829, 241, 0x3a3163 },
        })
        return { basePoint[3], posandcolor, 95, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
      -- 1-4的上边
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 1140, 240, 0x212842 }, { 1158, 240, 0x212842 },
          { 1175, 240, 0x19243a }, { 1191, 240, 0x19243a },
          { 1208, 241, 0x3a315a }, { 1192, 241, 0x312d5a },
          { 1176, 241, 0x312d5a }, { 1163, 241, 0x313163 },
        })
        return { basePoint[3], posandcolor, 95, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
      -- 1-5的上边
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 716, 246, 0x212842 }, { 730, 246, 0x212842 },
          { 747, 246, 0x21283a }, { 764, 246, 0x212842 },
          { 779, 247, 0x424173 }, { 766, 247, 0x3a3d6b },
          { 752, 247, 0x31396b }, { 741, 247, 0x3a396b },
        })
        return { basePoint[3], posandcolor, 95, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
      -- 1-9的上边
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 1486, 246, 0x293d52 }, { 1501, 246, 0x19283a },
          { 1513, 246, 0x212d3a }, { 1519, 246, 0x212d42 },
          { 1519, 247, 0x6b75b5 }, { 1508, 247, 0x636d9c },
          { 1496, 247, 0x5a6d9c }, { 1484, 247, 0x5a6d9c },
        })
        return { basePoint[3], posandcolor, 95, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
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
      -- 7-1 的下面
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022 }
        local basePoint, posandcolor = transRelativePoint({
          { 443, 944, 0x000000 }, { 456, 944, 0x000000 },
          { 470, 944, 0x000000 }, { 482, 944, 0x000000 },
          { 489, 943, 0x29204a }, { 476, 943, 0x211c42 },
          { 464, 943, 0x212042 }, { 455, 943, 0x29204a },
          { 455, 946, 0x000000 }, { 473, 946, 0x000000 },
        })
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
      -- 7-4的下面
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022 }
        local basePoint, posandcolor = transRelativePoint({
          { 1107, 944, 0x000000 }, { 1123, 944, 0x000000 },
          { 1138, 944, 0x000000 }, { 1158, 944, 0x000000 },
          { 1170, 943, 0x29204a }, { 1155, 943, 0x29244a },
          { 1140, 943, 0x292042 }, { 1127, 943, 0x29244a },
          { 1135, 946, 0x000000 }, { 1157, 946, 0x000000 },
        })
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
      -- 7-7 的下面
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022 }
        local basePoint, posandcolor = transRelativePoint({
          { 1028, 913, 0x000000 }, { 1048, 913, 0x000000 },
          { 1067, 913, 0x000000 }, { 1081, 913, 0x000000 },
          { 1097, 912, 0x31284a }, { 1079, 912, 0x29284a },
          { 1062, 912, 0x312852 }, { 1048, 912, 0x312452 },
          { 1052, 915, 0x000000 }, { 1069, 915, 0x000000 },
        })
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
    },
    -- 地图左边界
    leftLineList = {
      -- 2-1 的左边
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 573, 390, 0x000000 }, { 574, 390, 0x312852 },
          { 573, 389, 0x000000 }, { 574, 389, 0x29244a },
          { 572, 391, 0x000000 }, { 573, 391, 0x312852 },
          { 572, 392, 0x000000 }, { 573, 392, 0x312452 },
        })
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
      -- 3-1 的左边
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 555, 526, 0x000000 }, { 556, 526, 0x31395a },
          { 555, 525, 0x000000 }, { 556, 525, 0x312d52 },
          { 554, 527, 0x000000 }, { 555, 527, 0x312d5a },
          { 554, 528, 0x000000 }, { 555, 528, 0x312d52 },
        })
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
      -- 6-1 的左边
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 537, 661, 0x000000 }, { 538, 661, 0x29244a },
          { 537, 660, 0x000000 }, { 538, 660, 0x312852 },
          { 536, 662, 0x000000 }, { 537, 662, 0x292452 },
          { 536, 663, 0x000000 }, { 537, 663, 0x292852 },
        })
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
      -- 7-1 的左边
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 388, 879, 0x000000 }, { 389, 879, 0x212042 },
          { 388, 878, 0x000000 }, { 389, 878, 0x212042 },
          { 387, 880, 0x000000 }, { 388, 880, 0x29204a },
          { 387, 881, 0x000000 }, { 388, 881, 0x212042 },
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
          { 1611, 539, 0x000000 }, { 1610, 539, 0x636dad },
          { 1611, 538, 0x000000 }, { 1610, 538, 0x6b71b5 },
          { 1612, 540, 0x000000 }, { 1611, 540, 0x636dad },
          { 1612, 541, 0x000000 }, { 1611, 541, 0x636db5 },
        })
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
      -- 2-9 的右边
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 1547, 383, 0x000000 }, { 1546, 383, 0x5a59a4 },
          { 1547, 382, 0x000000 }, { 1546, 382, 0x635dad },
          { 1548, 384, 0x000000 }, { 1547, 384, 0x5a599c },
          { 1548, 385, 0x000000 }, { 1547, 385, 0x5a59a4 },
        })
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
      -- 7-9 的右边
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 1676, 848, 0x000000 }, { 1675, 848, 0x3a3163 },
          { 1676, 847, 0x000000 }, { 1675, 847, 0x3a3563 },
          { 1677, 849, 0x000000 }, { 1676, 849, 0x3a3163 },
          { 1677, 850, 0x000000 }, { 1676, 850, 0x3a3d63 },
        })
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
      -- 5-9 的右边
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 1594, 462, 0x000000 }, { 1593, 462, 0x42396b },
          { 1594, 461, 0x000000 }, { 1593, 461, 0x42396b },
          { 1595, 463, 0x000000 }, { 1594, 463, 0x42396b },
          { 1595, 464, 0x000000 }, { 1594, 464, 0x424173 },
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