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
          { 880, 519, 0x081421 }, { 893, 519, 0x101829 },
          { 904, 519, 0x081421 }, { 917, 519, 0x101829 },
          { 926, 520, 0x3a3963 }, { 916, 520, 0x423963 },
          { 906, 520, 0x3a3963 }, { 897, 520, 0x3a3163 },
        })
        return { basePoint[3], posandcolor, 93, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
      -- 1-6的上边
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 1427, 529, 0x192031 }, { 1415, 529, 0x192431 },
          { 1403, 529, 0x192431 }, { 1395, 529, 0x192031 },
          { 1403, 530, 0x525594 }, { 1413, 530, 0x525994 },
          { 1421, 530, 0x525d94 }, { 1431, 530, 0x5a5d9c },
        })
        return { basePoint[3], posandcolor, 93, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
      -- 1-3的上边
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 984, 519, 0x081421 }, { 992, 519, 0x081421 },
          { 1001, 519, 0x101829 }, { 1011, 519, 0x191829 },
          { 1022, 520, 0x3a3963 }, { 1011, 520, 0x3a3163 },
          { 1001, 520, 0x3a3163 }, { 990, 520, 0x3a3d63 },
        })
        return { basePoint[3], posandcolor, 93, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
      -- 1-4的上边
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 1160, 519, 0x081821 }, { 1171, 519, 0x191831 },
          { 1183, 519, 0x191831 }, { 1196, 519, 0x081821 },
          { 1213, 520, 0x3a3163 }, { 1203, 520, 0x3a3163 },
          { 1192, 520, 0x423d63 }, { 1183, 520, 0x3a3163 },
        })
        return { basePoint[3], posandcolor, 93, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
      -- 1-8的上边
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 1397, 526, 0x101c29 }, { 1412, 526, 0x192031 },
          { 1434, 526, 0x212042 }, { 1454, 526, 0x212042 },
          { 1469, 527, 0x6b71b5 }, { 1453, 527, 0x6b71b5 },
          { 1438, 527, 0x636db5 }, { 1422, 527, 0x636dad },
        })
        return { basePoint[3], posandcolor, 93, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
      -- 1-7的上边
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 1234, 526, 0x211c31 }, { 1249, 526, 0x101829 },
          { 1264, 526, 0x191c31 }, { 1281, 526, 0x101829 },
          { 1293, 527, 0x5a619c }, { 1284, 527, 0x525d94 },
          { 1270, 527, 0x4a598c }, { 1252, 527, 0x4a558c },
        })
        return { basePoint[3], posandcolor, 93, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
      -- 1-6的上边
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 1032, 526, 0x191829 }, { 1046, 526, 0x211831 },
          { 1063, 526, 0x101429 }, { 1075, 526, 0x101429 },
          { 1085, 527, 0x3a3d6b }, { 1067, 527, 0x3a396b },
          { 1044, 527, 0x31396b }, { 1030, 527, 0x31396b },
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
          { 570, 939, 0x000000 }, { 592, 939, 0x000000 },
          { 613, 939, 0x000000 }, { 634, 939, 0x000000 },
          { 651, 938, 0x29204a }, { 635, 938, 0x29204a },
          { 623, 938, 0x29204a }, { 611, 938, 0x212042 },
          { 610, 941, 0x000000 }, { 629, 941, 0x000000 },
        })
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
      -- 6-3 的下面
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022 }
        local basePoint, posandcolor = transRelativePoint({
          { 1002, 939, 0x000000 }, { 1019, 939, 0x000000 },
          { 1034, 939, 0x000000 }, { 1048, 939, 0x000000 },
          { 1062, 938, 0x312452 }, { 1049, 938, 0x31244a },
          { 1033, 938, 0x31244a }, { 1019, 938, 0x31244a },
          { 1021, 941, 0x000000 }, { 1040, 941, 0x000000 },
        })
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
      -- 6-5 的下面
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022 }
        local basePoint, posandcolor = transRelativePoint({
          { 792, 934, 0x000000 }, { 804, 934, 0x000000 },
          { 815, 934, 0x000000 }, { 828, 934, 0x000000 },
          { 836, 933, 0x29244a }, { 820, 933, 0x31244a },
          { 811, 933, 0x31244a }, { 800, 933, 0x31244a },
          { 799, 936, 0x000000 }, { 816, 936, 0x000000 },
        })
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
      -- 6-7 的下面
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022 }
        local basePoint, posandcolor = transRelativePoint({
          { 1199, 934, 0x000000 }, { 1213, 934, 0x000000 },
          { 1228, 934, 0x000000 }, { 1240, 934, 0x000000 },
          { 1252, 933, 0x29284a }, { 1241, 933, 0x312d52 },
          { 1230, 933, 0x29284a }, { 1219, 933, 0x292d52 },
          { 1218, 936, 0x000000 }, { 1236, 936, 0x000000 },
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
          { 582, 734, 0x000000 }, { 583, 734, 0x312d52 },
          { 582, 733, 0x000000 }, { 583, 733, 0x312d52 },
          { 581, 735, 0x000000 }, { 582, 735, 0x312852 },
          { 581, 736, 0x000000 }, { 582, 736, 0x31355a },
        })
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
      -- 4-1 的左边
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 556, 959, 0x000000 }, { 557, 959, 0x29244a },
          { 556, 958, 0x000000 }, { 557, 958, 0x29244a },
          { 555, 960, 0x000000 }, { 556, 960, 0x312452 },
          { 555, 961, 0x000000 }, { 556, 961, 0x29204a },
        })
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
      -- 6-1 的左边
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 513, 907, 0x000000 }, { 514, 907, 0x212042 },
          { 513, 906, 0x000000 }, { 514, 906, 0x29244a },
          { 512, 908, 0x000000 }, { 513, 908, 0x212042 },
          { 512, 909, 0x000000 }, { 513, 909, 0x29204a },
        })
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
    },
    -- 地图右边界
    rightLineList = {
      -- 1-8 的右边
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 1520, 565, 0x000000 }, { 1519, 565, 0x636db5 },
          { 1520, 564, 0x000000 }, { 1519, 564, 0x6369ad },
          { 1521, 566, 0x000000 }, { 1520, 566, 0x636db5 },
          { 1521, 567, 0x000000 }, { 1520, 567, 0x6369ad },
        })
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
      -- 2-8 的右边
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 1543, 692, 0x000000 }, { 1542, 692, 0x6359a4 },
          { 1543, 691, 0x000000 }, { 1542, 691, 0x5a559c },
          { 1544, 693, 0x000000 }, { 1543, 693, 0x5a55a4 },
          { 1544, 694, 0x000000 }, { 1543, 694, 0x5a55a4 },
        })
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
      -- 5-8 的右边
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 1560, 660, 0x000000 }, { 1559, 660, 0x3a3563 },
          { 1560, 659, 0x000000 }, { 1559, 659, 0x3a3563 },
          { 1561, 661, 0x000000 }, { 1560, 661, 0x3a3163 },
          { 1561, 662, 0x000000 }, { 1560, 662, 0x423d6b },
        })
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
      -- 6-8 的右边
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 1591, 825, 0x000000 }, { 1590, 825, 0x312d5a },
          { 1591, 824, 0x000000 }, { 1590, 824, 0x3a3963 },
          { 1592, 826, 0x000000 }, { 1591, 826, 0x3a2d63 },
          { 1592, 827, 0x000000 }, { 1591, 827, 0x3a3163 },
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