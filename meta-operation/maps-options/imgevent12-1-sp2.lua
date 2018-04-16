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
          { 1523, 528, 0x080c10 }, { 1530, 528, 0x101019 },
          { 1539, 528, 0x080c10 }, { 1548, 528, 0x101021 },
          { 1558, 529, 0x636dad }, { 1550, 529, 0x636dad },
          { 1544, 529, 0x636dad }, { 1533, 529, 0x636dad },
        })
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
      -- 1-8的上边
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 1387, 528, 0x080c10 }, { 1395, 528, 0x080c10 },
          { 1405, 528, 0x080c10 }, { 1413, 528, 0x080c10 },
          { 1422, 529, 0x52619c }, { 1413, 529, 0x5a619c },
          { 1405, 529, 0x525d9c }, { 1397, 529, 0x525d94 },
        })
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
      -- 1-6的上边
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 1055, 528, 0x080c10 }, { 1069, 528, 0x080c10 },
          { 1085, 528, 0x080c10 }, { 1101, 528, 0x080c10 },
          { 1111, 529, 0x3a3d6b }, { 1099, 529, 0x3a396b },
          { 1084, 529, 0x3a3d6b }, { 1069, 529, 0x3a3d73 },
        })
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
      -- 1-4的上边
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 741, 528, 0x080c10 }, { 747, 528, 0x080c10 },
          { 752, 528, 0x101021 }, { 765, 528, 0x080c10 },
          { 773, 529, 0x3a3163 }, { 767, 529, 0x3a3163 },
          { 759, 529, 0x313163 }, { 751, 529, 0x313163 },
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
          { 430, 899, 0x000000 }, { 444, 899, 0x000000 },
          { 453, 899, 0x000000 }, { 472, 899, 0x000000 },
          { 487, 898, 0x21204a }, { 476, 898, 0x29204a },
          { 463, 898, 0x29204a }, { 452, 898, 0x29204a },
        })
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
      -- 7-4 的下面
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022 }
        local basePoint, posandcolor = transRelativePoint({
          { 1032, 899, 0x000000 }, { 1046, 899, 0x000000 },
          { 1062, 899, 0x000000 }, { 1077, 899, 0x000000 },
          { 1090, 898, 0x29244a }, { 1078, 898, 0x29244a },
          { 1066, 898, 0x31204a }, { 1055, 898, 0x29244a },
        })
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
      -- 7-7 的下面
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022 }
        local basePoint, posandcolor = transRelativePoint({
          { 1118, 890, 0x000000 }, { 1134, 890, 0x000000 },
          { 1150, 890, 0x000000 }, { 1169, 890, 0x000000 },
          { 1185, 889, 0x312852 }, { 1168, 889, 0x29284a },
          { 1155, 889, 0x29284a }, { 1138, 889, 0x29244a },
        })
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
    },
    -- 地图左边界
    leftLineList = {
      -- 7-1 的左边
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 375, 872, 0x000000 }, { 376, 872, 0x29244a },
          { 375, 871, 0x000000 }, { 376, 871, 0x212042 },
          { 374, 873, 0x000000 }, { 375, 873, 0x212442 },
          { 374, 874, 0x000000 }, { 375, 874, 0x212042 },
        })
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
      -- 4-1 的左边
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 455, 407, 0x000000 }, { 456, 407, 0x29244a },
          { 455, 406, 0x000000 }, { 456, 406, 0x313552 },
          { 454, 408, 0x000400 }, { 455, 408, 0x29244a },
          { 454, 409, 0x000000 }, { 455, 409, 0x29244a },
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
          { 1666, 427, 0x000000 }, { 1665, 427, 0x6371ad },
          { 1666, 426, 0x000000 }, { 1665, 426, 0x6371ad },
          { 1667, 428, 0x000000 }, { 1666, 428, 0x6b71b5 },
          { 1667, 429, 0x000000 }, { 1666, 429, 0x636dad },
        })
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
      -- 2-9 的右边
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 1697, 556, 0x000000 }, { 1696, 556, 0x6359ad },
          { 1697, 555, 0x000000 }, { 1696, 555, 0x5a599c },
          { 1698, 557, 0x000000 }, { 1697, 557, 0x6359a4 },
          { 1698, 558, 0x000000 }, { 1697, 558, 0x5a599c },
        })
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
      -- 4-9 的右边
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 1599, 361, 0x000000 }, { 1598, 361, 0x423d73 },
          { 1599, 360, 0x000000 }, { 1598, 360, 0x4a417b },
          { 1600, 362, 0x000000 }, { 1599, 362, 0x4a417b },
          { 1600, 363, 0x000000 }, { 1599, 363, 0x4a417b },
        })
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
      -- 7-9 的右边
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 1708, 853, 0x000000 }, { 1707, 853, 0x3a3163 },
          { 1708, 852, 0x000000 }, { 1707, 852, 0x3a3163 },
          { 1709, 854, 0x000000 }, { 1708, 854, 0x3a3963 },
          { 1709, 855, 0x000000 }, { 1708, 855, 0x31315a },
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