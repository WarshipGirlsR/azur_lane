-- 存储图像信息，用于界面找色、找图。取代图片搜索，因为找色搜索的像素点更少
require 'TableLib'
local imgBase = require 'BaseOperate__maps__img'

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
          { 1499, 515, 0x21414a }, { 1511, 515, 0x21414a },
          { 1532, 515, 0x103942 }, { 1556, 515, 0x103942 },
          { 1564, 516, 0x3ac2de }, { 1544, 516, 0x42cae6 },
          { 1527, 516, 0x3ac6d6 }, { 1506, 516, 0x3ac6de },
        })
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
      -- 1-5的上边
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 941, 515, 0x193d4a }, { 958, 515, 0x193542 },
          { 979, 515, 0x213d4a }, { 998, 515, 0x193542 },
          { 1016, 516, 0x31bae6 }, { 994, 516, 0x31bade },
          { 972, 516, 0x3abede }, { 952, 516, 0x31bade },
        })
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
      -- 1-1的上边
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 284, 515, 0x103542 }, { 304, 515, 0x103542 },
          { 323, 515, 0x213d4a }, { 340, 515, 0x103542 },
          { 353, 516, 0x299ede }, { 335, 516, 0x299ede },
          { 314, 516, 0x31a2de }, { 293, 516, 0x31a2de },
        })
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
      -- 1-9的上边
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 1589, 515, 0x19414a }, { 1605, 515, 0x19414a },
          { 1626, 515, 0x103942 }, { 1639, 515, 0x21414a },
          { 1653, 516, 0x31bee6 }, { 1634, 516, 0x31bee6 },
          { 1618, 516, 0x3abee6 }, { 1599, 516, 0x31bede },
        })
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
    },
    -- 地图下边界
    bottonLineList = {
      -- 7-3 的下面
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022 }
        local basePoint, posandcolor = transRelativePoint({
          { 814, 912, 0x000000 }, { 835, 912, 0x000000 },
          { 854, 912, 0x000000 }, { 873, 912, 0x000000 },
          { 891, 911, 0x2171b5 }, { 869, 911, 0x1971bd },
          { 849, 911, 0x1071b5 }, { 830, 911, 0x1071b5 },
        })
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
      -- 7-6 的下面
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022 }
        local basePoint, posandcolor = transRelativePoint({
          { 849, 915, 0x000000 }, { 865, 915, 0x000000 },
          { 883, 915, 0x000000 }, { 905, 915, 0x000000 },
          { 926, 914, 0x1951ad }, { 906, 914, 0x194dad },
          { 886, 914, 0x194dad }, { 865, 914, 0x104da4 },
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
          { 258, 554, 0x000000 }, { 259, 554, 0x29a2de },
          { 258, 553, 0x000000 }, { 259, 553, 0x299ede },
          { 257, 555, 0x000000 }, { 258, 555, 0x29a2d6 },
          { 257, 556, 0x000000 }, { 258, 556, 0x31a2de },
        })
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
      -- 3-1 的左边
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 202, 799, 0x000000 }, { 203, 799, 0x31bade },
          { 202, 798, 0x000000 }, { 203, 798, 0x31bade },
          { 201, 800, 0x000000 }, { 202, 800, 0x31bade },
          { 201, 801, 0x000000 }, { 202, 801, 0x29b6de },
        })
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
      -- 5-1 的左边
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 278, 795, 0x000000 }, { 279, 795, 0x4296d6 },
          { 278, 794, 0x000000 }, { 279, 794, 0x3a96d6 },
          { 277, 796, 0x000000 }, { 278, 796, 0x3a96d6 },
          { 277, 797, 0x000000 }, { 278, 797, 0x3196ce },
        })
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
      -- 7-1 的左边
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 368, 846, 0x000000 }, { 369, 846, 0x298ec5 },
          { 368, 845, 0x000000 }, { 369, 845, 0x298ece },
          { 367, 847, 0x000000 }, { 368, 847, 0x218ebd },
          { 367, 848, 0x000000 }, { 368, 848, 0x2992ce },
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
          { 1739, 540, 0x000000 }, { 1738, 540, 0x31b2e6 },
          { 1739, 539, 0x000000 }, { 1738, 539, 0x31aede },
          { 1740, 541, 0x000000 }, { 1739, 541, 0x31b2de },
          { 1740, 542, 0x000000 }, { 1739, 542, 0x31aede },
        })
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
      -- 3-9 的右边
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 1802, 788, 0x000000 }, { 1801, 788, 0x29bede },
          { 1802, 787, 0x000000 }, { 1801, 787, 0x29bede },
          { 1803, 789, 0x000000 }, { 1802, 789, 0x29bede },
          { 1803, 790, 0x000000 }, { 1802, 790, 0x31c2e6 },
        })
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
      -- 4-9 的右边
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 1591, 379, 0x000000 }, { 1590, 379, 0x29aede },
          { 1591, 378, 0x000000 }, { 1590, 378, 0x31b2de },
          { 1592, 380, 0x000000 }, { 1591, 380, 0x29b2de },
          { 1592, 381, 0x000000 }, { 1591, 381, 0x31b2de },
        })
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
      -- 5-9 的右边
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 1615, 490, 0x000000 }, { 1614, 490, 0x318ece },
          { 1615, 489, 0x000000 }, { 1614, 489, 0x298abd },
          { 1616, 491, 0x000000 }, { 1615, 491, 0x318ece },
          { 1616, 492, 0x000000 }, { 1615, 492, 0x318ace },
        })
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
      -- 7-9 的右边
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 1684, 807, 0x000000 }, { 1683, 807, 0x4275c5 },
          { 1684, 806, 0x000000 }, { 1683, 806, 0x3a75c5 },
          { 1685, 808, 0x000000 }, { 1684, 808, 0x4279ce },
          { 1685, 809, 0x000000 }, { 1684, 809, 0x3a75c5 },
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