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
      -- 1-4的上边
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 991, 393, 0x3a2021 }, { 1001, 393, 0x312021 },
          { 1012, 393, 0x291c21 }, { 1026, 393, 0x3a2419 },
          { 1036, 394, 0x6b3129 }, { 1026, 394, 0x8c3942 },
          { 1016, 394, 0x7b3529 }, { 1005, 394, 0x6b2821 },
        })
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
      -- 1-5的上边
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 1182, 393, 0x080400 }, { 1195, 393, 0x100808 },
          { 1206, 393, 0x100400 }, { 1217, 393, 0x190808 },
          { 1231, 394, 0x732821 }, { 1219, 394, 0x8c2421 },
          { 1206, 394, 0x842829 }, { 1195, 394, 0x632019 },
        })
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
      -- 1-3的上边
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 947, 393, 0x3a2429 }, { 954, 393, 0x3a2421 },
          { 962, 393, 0x3a2421 }, { 972, 393, 0x312421 },
          { 974, 394, 0x8c3931 }, { 968, 394, 0x8c3929 },
          { 960, 394, 0x733121 }, { 949, 394, 0x732d21 },
        })
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
      -- 1-6的上边
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 1270, 393, 0x190400 }, { 1278, 393, 0x190800 },
          { 1285, 393, 0x210808 }, { 1293, 393, 0x190808 },
          { 1304, 394, 0x6b2421 }, { 1295, 394, 0x6b2419 },
          { 1286, 394, 0x732821 }, { 1274, 394, 0x7b2821 },
        })
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
      -- 1-7的上边
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 1570, 393, 0x210c08 }, { 1582, 393, 0x210c00 },
          { 1590, 393, 0x290c08 }, { 1594, 393, 0x290c08 },
          { 1594, 394, 0x632021 }, { 1584, 394, 0x5a2019 },
          { 1578, 394, 0x5a2021 }, { 1572, 394, 0x5a2019 },
        })
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
      -- 1-1的上边
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 505, 393, 0x190810 }, { 512, 393, 0x100408 },
          { 518, 393, 0x100400 }, { 526, 393, 0x100400 },
          { 536, 394, 0x4a1810 }, { 528, 394, 0x4a1810 },
          { 519, 394, 0x421810 }, { 511, 394, 0x4a1810 },
        })
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
    },
    -- 地图下边界
    bottonLineList = {
      -- 4-1 的下面
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022 }
        local basePoint, posandcolor = transRelativePoint({
          { 426, 906, 0x000000 }, { 435, 906, 0x000000 },
          { 443, 906, 0x000000 }, { 451, 906, 0x000000 },
          { 462, 905, 0x3a1810 }, { 455, 905, 0x3a1810 },
          { 449, 905, 0x3a1410 }, { 442, 905, 0x311408 },
        })
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
      -- 4-4 的下面
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022 }
        local basePoint, posandcolor = transRelativePoint({
          { 1009, 906, 0x000000 }, { 1019, 906, 0x000000 },
          { 1029, 906, 0x000000 }, { 1037, 906, 0x000000 },
          { 1050, 905, 0x310c08 }, { 1040, 905, 0x3a1410 },
          { 1033, 905, 0x3a1819 }, { 1025, 905, 0x3a1819 },
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
          { 468, 522, 0x000000 }, { 469, 522, 0x421408 },
          { 468, 521, 0x000000 }, { 469, 521, 0x421408 },
          { 467, 523, 0x000000 }, { 468, 523, 0x421008 },
          { 467, 524, 0x000000 }, { 468, 524, 0x421008 },
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
          { 1597, 403, 0x000000 }, { 1596, 403, 0x521c10 },
          { 1597, 402, 0x000000 }, { 1596, 402, 0x5a2019 },
          { 1598, 404, 0x000000 }, { 1597, 404, 0x5a2019 },
          { 1598, 405, 0x000000 }, { 1597, 405, 0x5a2019 },
        })
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
      -- 2-7 的右边
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 1639, 554, 0x000000 }, { 1638, 554, 0x5a2021 },
          { 1639, 553, 0x000000 }, { 1638, 553, 0x521c10 },
          { 1640, 555, 0x000000 }, { 1639, 555, 0x522019 },
          { 1640, 556, 0x000000 }, { 1639, 556, 0x522019 },
        })
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
      -- 3-7 的右边
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 1665, 648, 0x000000 }, { 1664, 648, 0x632421 },
          { 1665, 647, 0x000000 }, { 1664, 647, 0x5a2019 },
          { 1666, 649, 0x000000 }, { 1665, 649, 0x632421 },
          { 1666, 650, 0x000000 }, { 1665, 650, 0x632819 },
        })
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
      -- 4-7 的右边
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 1706, 796, 0x000000 }, { 1705, 796, 0x421410 },
          { 1706, 795, 0x000000 }, { 1705, 795, 0x421410 },
          { 1707, 797, 0x000000 }, { 1706, 797, 0x421408 },
          { 1707, 798, 0x000000 }, { 1706, 798, 0x4a1810 },
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