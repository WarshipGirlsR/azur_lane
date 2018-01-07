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
      -- 1-7的上边 (在屏幕上面位置)
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 1418, 289, 0x192019 }, { 1439, 289, 0x212429 },
          { 1463, 289, 0x292429 }, { 1480, 289, 0x212421 },
          { 1487, 290, 0xd69a5a }, { 1466, 290, 0xde9e6b },
          { 1444, 290, 0xde9a6b }, { 1422, 290, 0xd69263 },
        })
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
      -- 1-7的上边 (在屏幕中间位置)
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 1281, 605, 0x211410 }, { 1295, 605, 0x311c10 },
          { 1318, 605, 0x100c00 }, { 1344, 605, 0x080408 },
          { 1357, 606, 0xd69a5a }, { 1339, 606, 0xd69a63 },
          { 1315, 606, 0xd69663 }, { 1297, 606, 0xce8e5a },
        })
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
      -- 1-7的上边
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 1356, 722, 0x100c10 }, { 1374, 722, 0x100c10 },
          { 1385, 722, 0x080808 }, { 1403, 722, 0x080808 },
          { 1405, 723, 0xd69e5a }, { 1388, 723, 0xd69e5a },
          { 1373, 723, 0xd6a25a }, { 1358, 723, 0xd69a5a },
        })
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
      -- 1-7的上边 (右上角被舰队挡住的时候)
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 1834, 542, 0x100808 }, { 1845, 542, 0x100800 },
          { 1855, 542, 0x080808 }, { 1864, 542, 0x191010 },
          { 1859, 543, 0xd6a25a }, { 1852, 543, 0xd69e5a },
          { 1839, 543, 0xd6a263 }, { 1834, 543, 0xd69e5a },
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
          { 325, 908, 0x000000 }, { 348, 908, 0x000000 },
          { 372, 908, 0x000000 }, { 394, 908, 0x000000 },
          { 399, 907, 0x4a3d4a }, { 382, 907, 0x423152 },
          { 364, 907, 0x423152 }, { 340, 907, 0x3a3163 },
        })
        return { basePoint[3], posandcolor, 95, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
      -- 7-4 的下面
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022 }
        local basePoint, posandcolor = transRelativePoint({
          { 983, 908, 0x000000 }, { 1010, 908, 0x000000 },
          { 1041, 908, 0x000000 }, { 1071, 908, 0x000000 },
          { 1087, 907, 0x313142 }, { 1056, 907, 0x29283a },
          { 1022, 907, 0x312842 }, { 994, 907, 0x312d3a },
        })
        return { basePoint[3], posandcolor, 95, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
      -- 7-7 的下面
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022 }
        local basePoint, posandcolor = transRelativePoint({
          { 1642, 908, 0x000000 }, { 1670, 908, 0x000000 },
          { 1698, 908, 0x000000 }, { 1719, 908, 0x000000 },
          { 1730, 907, 0x634152 }, { 1701, 907, 0x524152 },
          { 1675, 907, 0x524052 }, { 1646, 907, 0x4a3d4a },
        })
        return { basePoint[3], posandcolor, 95, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
    },
    -- 地图左边界
    leftLineList = {
      -- 1-1 的左边
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 442, 268, 0x000000 }, { 443, 268, 0x3a3d42 },
          { 442, 267, 0x000000 }, { 443, 267, 0x42414a },
          { 441, 269, 0x000000 }, { 442, 269, 0x3a3d42 },
          { 441, 270, 0x000000 }, { 442, 270, 0x42414a },
        })
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
      -- 4-1 的左边
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 375, 629, 0x000000 }, { 376, 629, 0x3a393a },
          { 375, 628, 0x000000 }, { 376, 628, 0x3a3942 },
          { 374, 630, 0x000000 }, { 375, 630, 0x3a393a },
          { 374, 631, 0x000000 }, { 375, 631, 0x424142 },
        })
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
      -- 6-1 的左边
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 305, 629, 0x000000 }, { 306, 629, 0x3a3529 },
          { 305, 628, 0x000000 }, { 306, 628, 0x423531 },
          { 304, 630, 0x000000 }, { 305, 630, 0x423531 },
          { 304, 631, 0x000000 }, { 305, 631, 0x423931 },
        })
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
      -- 7-1 的左边
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 321, 790, 0x000000 }, { 322, 790, 0x3a3531 },
          { 321, 789, 0x000000 }, { 322, 789, 0x313129 },
          { 320, 791, 0x000000 }, { 321, 791, 0x3a3531 },
          { 320, 792, 0x000000 }, { 321, 792, 0x3a3131 },
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
          { 1598, 512, 0x000000 }, { 1597, 512, 0xd69e63 },
          { 1598, 511, 0x000000 }, { 1597, 511, 0xd6a263 },
          { 1599, 513, 0x000000 }, { 1598, 513, 0xd69e5a },
          { 1599, 514, 0x000000 }, { 1598, 514, 0xdea263 },
        })
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
      -- 2-7 的右边
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 1622, 626, 0x010100 }, { 1621, 626, 0xce8a52 },
          { 1622, 625, 0x000000 }, { 1621, 625, 0xce8a5a },
          { 1623, 627, 0x000000 }, { 1622, 627, 0xc58652 },
          { 1623, 628, 0x000000 }, { 1622, 628, 0xce8a5a },
        })
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
      -- 4-7 的右边
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 1686, 698, 0x000000 }, { 1685, 698, 0x5a514a },
          { 1686, 697, 0x000000 }, { 1685, 697, 0x63514a },
          { 1687, 699, 0x000000 }, { 1686, 699, 0x5a514a },
          { 1687, 700, 0x000000 }, { 1686, 700, 0x5a554a },
        })
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
      -- 6-7 的右边
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 1730, 607, 0x000000 }, { 1729, 607, 0x424142 },
          { 1730, 606, 0x000000 }, { 1729, 606, 0x424142 },
          { 1731, 608, 0x000000 }, { 1730, 608, 0x42414a },
          { 1731, 609, 0x000000 }, { 1730, 609, 0x3a3d42 },
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