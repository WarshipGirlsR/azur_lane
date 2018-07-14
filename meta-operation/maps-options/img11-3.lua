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
          { 793, 548, 0x212031 }, { 808, 548, 0x292442 },
          { 820, 548, 0x292042 }, { 835, 548, 0x211c29 },
          { 847, 549, 0x3a3163 }, { 838, 549, 0x312d5a },
          { 826, 549, 0x312d5a }, { 813, 549, 0x3a3163 },
        })
        return { basePoint[3], posandcolor, 97, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
      -- 1-2的上边
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 985, 548, 0x191429 }, { 1000, 548, 0x211831 },
          { 1012, 548, 0x211831 }, { 1025, 548, 0x191429 },
          { 1040, 549, 0x312d5a }, { 1029, 549, 0x3a3163 },
          { 1016, 549, 0x3a315a }, { 1006, 549, 0x312d5a },
        })
        return { basePoint[3], posandcolor, 97, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
      -- 1-5的上边
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 1322, 548, 0x211c31 }, { 1333, 548, 0x191831 },
          { 1343, 548, 0x191c31 }, { 1353, 548, 0x191c31 },
          { 1365, 549, 0x42417b }, { 1355, 549, 0x3a3d6b },
          { 1342, 549, 0x313963 }, { 1333, 549, 0x3a396b },
        })
        return { basePoint[3], posandcolor, 97, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
      -- 1-5的上边
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 830, 508, 0x211c31 }, { 842, 508, 0x211c31 },
          { 852, 508, 0x211c31 }, { 861, 508, 0x191429 },
          { 872, 509, 0x424573 }, { 861, 509, 0x42497b },
          { 853, 509, 0x424573 }, { 844, 509, 0x3a3d73 },
        })
        return { basePoint[3], posandcolor, 97, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
      -- 1-9的上边
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 1267, 548, 0x211c31 }, { 1274, 548, 0x29203a },
          { 1283, 548, 0x191c31 }, { 1290, 548, 0x29203a },
          { 1302, 549, 0x636d9c }, { 1298, 549, 0x636d9c },
          { 1291, 549, 0x6b71ad }, { 1282, 549, 0x5a6d9c },
        })
        return { basePoint[3], posandcolor, 97, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
      -- 1-7的上边
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 1374, 253, 0x19243a }, { 1383, 253, 0x212842 },
          { 1394, 253, 0x19243a }, { 1403, 253, 0x192842 },
          { 1413, 254, 0x3a416b }, { 1406, 254, 0x424173 },
          { 1398, 254, 0x424173 }, { 1390, 254, 0x424173 },
        })
        return { basePoint[3], posandcolor, 97, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
      -- 1-9的上边
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 1467, 513, 0x31314a }, { 1477, 513, 0x293142 },
          { 1486, 513, 0x212d3a }, { 1494, 513, 0x212d3a },
          { 1503, 514, 0x6b75ad }, { 1492, 514, 0x6b75b5 },
          { 1484, 514, 0x6b75ad }, { 1473, 514, 0x6b6d9c },
        })
        return { basePoint[3], posandcolor, 97, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
      -- 1-9的上边
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 1244, 368, 0x29284a }, { 1250, 368, 0x213542 },
          { 1258, 368, 0x212842 }, { 1264, 368, 0x292842 },
          { 1273, 369, 0x636dad }, { 1264, 369, 0x5a65a4 },
          { 1254, 369, 0x5a659c }, { 1247, 369, 0x6369ad },
        })
        return { basePoint[3], posandcolor, 97, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
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
          { 502, 684, 0x000000 }, { 512, 684, 0x000000 },
          { 523, 684, 0x000000 }, { 534, 684, 0x000000 },
          { 544, 683, 0x212042 }, { 537, 683, 0x212042 },
          { 529, 683, 0x212042 }, { 520, 683, 0x212042 },
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
      -- 7-1 的左边
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 469, 640, 0x000000 }, { 470, 640, 0x29244a },
          { 469, 639, 0x000000 }, { 470, 639, 0x212042 },
          { 468, 641, 0x000000 }, { 469, 641, 0x29204a },
          { 468, 642, 0x000000 }, { 469, 642, 0x212042 },
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