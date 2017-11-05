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
          { 1632, 497, 0x21252a }, { 1648, 497, 0x101421 },
          { 1665, 497, 0x211921 }, { 1675, 497, 0x191d21 },
          { 1687, 498, 0x6371ad }, { 1671, 498, 0x6371ad },
          { 1655, 498, 0x6b71ad }, { 1641, 498, 0x6371ad },
        })
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
      -- 1-7的上边
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 1469, 497, 0x212542 }, { 1481, 497, 0x212542 },
          { 1496, 497, 0x191d2a }, { 1507, 497, 0x192132 },
          { 1513, 498, 0x5a65a4 }, { 1499, 498, 0x5a65a4 },
          { 1488, 498, 0x6365a4 }, { 1478, 498, 0x5a61a4 },
        })
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
      -- 1-4的上边
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 864, 497, 0x101421 }, { 877, 497, 0x211821 },
          { 890, 497, 0x111419 }, { 902, 497, 0x111419 },
          { 914, 498, 0x3a3563 }, { 900, 498, 0x3a3563 },
          { 885, 498, 0x3a315a }, { 872, 498, 0x3a3163 },
        })
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
    },
    -- 地图下边界
    bottonLineList = {
      -- 6-1 的下面
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022 }
        local basePoint, posandcolor = transRelativePoint({
          { 573, 895, 0x000000 }, { 586, 895, 0x000000 },
          { 597, 895, 0x000000 }, { 607, 895, 0x000000 },
          { 614, 894, 0x29204a }, { 600, 894, 0x29204a },
          { 589, 894, 0x29204a }, { 576, 894, 0x29204a },
        })
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
      -- 6-3 的下面
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022 }
        local basePoint, posandcolor = transRelativePoint({
          { 1014, 895, 0x000000 }, { 1032, 895, 0x000000 },
          { 1052, 895, 0x000000 }, { 1071, 895, 0x000000 },
          { 1082, 894, 0x312452 }, { 1063, 894, 0x29244a },
          { 1047, 894, 0x31244a }, { 1029, 894, 0x29204a },
        })
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
      -- 6-5 的下面
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022 }
        local basePoint, posandcolor = transRelativePoint({
          { 837, 897, 0x312452 }, { 855, 897, 0x31244a },
          { 873, 897, 0x312452 }, { 888, 897, 0x31244a },
          { 900, 898, 0x000000 }, { 881, 898, 0x000000 },
          { 865, 898, 0x000000 }, { 851, 898, 0x000000 },
        })
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
      -- 6-8 的下面
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022 }
        local basePoint, posandcolor = transRelativePoint({
          { 1549, 898, 0x000000 }, { 1560, 898, 0x000000 },
          { 1572, 898, 0x000000 }, { 1584, 898, 0x000000 },
          { 1592, 897, 0x312d52 }, { 1578, 897, 0x312852 },
          { 1566, 897, 0x292852 }, { 1558, 897, 0x292d4a },
        })
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
    },
    -- 地图左边界
    leftLineList = {
      -- 1-6 的左边
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 517, 790, 0x000000 }, { 518, 790, 0x29204a },
          { 517, 789, 0x000000 }, { 518, 789, 0x212042 },
          { 516, 791, 0x000000 }, { 517, 791, 0x29204a },
          { 516, 792, 0x000000 }, { 517, 792, 0x29204a },
        })
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
      -- 1-4 的左边
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 558, 483, 0x000000 }, { 559, 483, 0x312452 },
          { 558, 482, 0x000000 }, { 559, 482, 0x29244a },
          { 557, 484, 0x000000 }, { 558, 484, 0x312452 },
          { 557, 485, 0x000000 }, { 558, 485, 0x29204a },
        })
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
      -- 1-5 的左边
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 540, 618, 0x000000 }, { 541, 618, 0x29204a },
          { 540, 617, 0x000000 }, { 541, 617, 0x292052 },
          { 539, 619, 0x000000 }, { 540, 619, 0x21204a },
          { 539, 620, 0x000000 }, { 540, 620, 0x292052 },
        })
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
      -- 1-1 的左边
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 337, 382, 0x000000 }, { 338, 382, 0x3a2d5a },
          { 337, 381, 0x000000 }, { 338, 381, 0x312d52 },
          { 336, 383, 0x000000 }, { 337, 383, 0x31315a },
          { 336, 384, 0x000000 }, { 337, 384, 0x312d5a },
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
          { 1696, 506, 0x000000 }, { 1695, 506, 0x6b71b5 },
          { 1696, 505, 0x000000 }, { 1695, 505, 0x6b71b5 },
          { 1697, 507, 0x000000 }, { 1696, 507, 0x636dad },
          { 1697, 508, 0x000000 }, { 1696, 508, 0x6b71b5 },
        })
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
      -- 2-8 的右边
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 1731, 650, 0x000001 }, { 1730, 650, 0x6359a4 },
          { 1731, 649, 0x000000 }, { 1730, 649, 0x5a559c },
          { 1732, 651, 0x000000 }, { 1731, 651, 0x6355a4 },
          { 1732, 652, 0x000000 }, { 1731, 652, 0x5a559c },
        })
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
      -- 3-8 的右边
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 1652, 643, 0x000000 }, { 1651, 643, 0x4a417b },
          { 1652, 642, 0x000000 }, { 1651, 642, 0x4a417b },
          { 1653, 644, 0x000000 }, { 1652, 644, 0x4a4184 },
          { 1653, 645, 0x000000 }, { 1652, 645, 0x4a3d7b },
        })
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
      -- 6-8 的右边
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 1658, 789, 0x000000 }, { 1657, 789, 0x423563 },
          { 1658, 788, 0x000000 }, { 1657, 788, 0x3a2d63 },
          { 1659, 790, 0x000000 }, { 1658, 790, 0x3a3163 },
          { 1659, 791, 0x000000 }, { 1658, 791, 0x312d5a },
        })
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
      -- 4-8 的右边
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 1594, 486, 0x000000 }, { 1593, 486, 0x42417b },
          { 1594, 485, 0x000000 }, { 1593, 485, 0x42417b },
          { 1595, 487, 0x000000 }, { 1594, 487, 0x424173 },
          { 1595, 488, 0x000000 }, { 1594, 488, 0x4a417b },
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