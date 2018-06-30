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
          { 426, 522, 0x312442 }, { 439, 522, 0x292031 },
          { 451, 522, 0x291c31 }, { 464, 522, 0x212031 },
          { 478, 523, 0x6b3d6b }, { 463, 523, 0x6b3d6b },
          { 449, 523, 0x733d6b }, { 435, 523, 0x6b396b },
        })
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
      -- 1-8的上边
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 1545, 522, 0x191021 }, { 1565, 522, 0x191021 },
          { 1577, 522, 0x191021 }, { 1591, 522, 0x191029 },
          { 1601, 523, 0x6b3d7b }, { 1592, 523, 0x6b397b },
          { 1579, 523, 0x733d84 }, { 1563, 523, 0x6b3973 },
        })
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
      -- 1-2的上边
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 552, 522, 0x211829 }, { 563, 522, 0x211829 },
          { 573, 522, 0x211829 }, { 586, 522, 0x291c31 },
          { 601, 523, 0x6b3973 }, { 590, 523, 0x63356b },
          { 581, 523, 0x6b396b }, { 569, 523, 0x6b396b },
        })
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
      -- 1-4的上边
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 970, 522, 0x211831 }, { 983, 522, 0x191021 },
          { 995, 522, 0x191021 }, { 1008, 522, 0x211421 },
          { 1021, 523, 0x6b3d73 }, { 1009, 523, 0x6b3d73 },
          { 994, 523, 0x6b3973 }, { 979, 523, 0x733973 },
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
          { 479, 965, 0x000000 }, { 493, 965, 0x000000 },
          { 510, 965, 0x000000 }, { 520, 965, 0x000000 },
          { 531, 964, 0x421c42 }, { 521, 964, 0x4a1842 },
          { 509, 964, 0x421842 }, { 501, 964, 0x421842 },
        })
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
      -- 6-2 的下面
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022 }
        local basePoint, posandcolor = transRelativePoint({
          { 711, 965, 0x000000 }, { 725, 965, 0x000000 },
          { 735, 965, 0x000000 }, { 745, 965, 0x000000 },
          { 754, 964, 0x31144a }, { 748, 964, 0x42144a },
          { 741, 964, 0x421442 }, { 733, 964, 0x311442 },
        })
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
      -- 6-4 的下面
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022 }
        local basePoint, posandcolor = transRelativePoint({
          { 880, 939, 0x000000 }, { 896, 939, 0x000000 },
          { 905, 939, 0x000000 }, { 916, 939, 0x000000 },
          { 931, 938, 0x29103a }, { 922, 938, 0x311042 },
          { 910, 938, 0x291042 }, { 900, 938, 0x29103a },
        })
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
    },
    -- 地图左边界
    leftLineList = {
      -- 6-1 的左边
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 436, 920, 0x000000 }, { 437, 920, 0x4a1c4a },
          { 436, 919, 0x000000 }, { 437, 919, 0x4a204a },
          { 435, 921, 0x000000 }, { 436, 921, 0x4a1c4a },
          { 435, 922, 0x000000 }, { 436, 922, 0x4a2052 },
        })
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
      -- 2-1 的左边
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 533, 335, 0x000000 }, { 534, 335, 0x3a245a },
          { 533, 334, 0x000000 }, { 534, 334, 0x42285a },
          { 532, 336, 0x000000 }, { 533, 336, 0x42245a },
          { 532, 337, 0x000000 }, { 533, 337, 0x52245a },
        })
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
      -- 8-1 的左边
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 445, 895, 0x000000 }, { 446, 895, 0x421c4a },
          { 445, 894, 0x000000 }, { 446, 894, 0x4a2052 },
          { 444, 896, 0x000000 }, { 445, 896, 0x421c4a },
          { 444, 897, 0x000000 }, { 445, 897, 0x4a1c52 },
        })
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
      -- 8-1 的左边
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 477, 683, 0x000000 }, { 478, 683, 0x3a204a },
          { 477, 682, 0x000000 }, { 478, 682, 0x422452 },
          { 476, 684, 0x000000 }, { 477, 684, 0x42204a },
          { 476, 685, 0x000000 }, { 477, 685, 0x42204a },
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
          { 1645, 529, 0x000000 }, { 1644, 529, 0x6b397b },
          { 1645, 528, 0x000000 }, { 1644, 528, 0x734184 },
          { 1646, 530, 0x000000 }, { 1645, 530, 0x6b397b },
          { 1646, 531, 0x000000 }, { 1645, 531, 0x6b397b },
        })
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
      -- 2-7 的右边
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 1614, 675, 0x000000 }, { 1613, 675, 0x4a205a },
          { 1614, 674, 0x000000 }, { 1613, 674, 0x42205a },
          { 1615, 676, 0x000000 }, { 1614, 676, 0x4a2463 },
          { 1615, 677, 0x000000 }, { 1614, 677, 0x42205a },
        })
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
      -- 6-7 的右边
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 1645, 826, 0x000000 }, { 1644, 826, 0x5a497b },
          { 1645, 825, 0x000000 }, { 1644, 825, 0x5a497b },
          { 1646, 827, 0x000000 }, { 1645, 827, 0x5a4573 },
          { 1646, 828, 0x000000 }, { 1645, 828, 0x524173 },
        })
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
      -- 5-7 的右边
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 1641, 676, 0x000000 }, { 1640, 676, 0x422452 },
          { 1641, 675, 0x000000 }, { 1640, 675, 0x31204a },
          { 1642, 677, 0x000000 }, { 1641, 677, 0x3a2452 },
          { 1642, 678, 0x000000 }, { 1641, 678, 0x3a2052 },
        })
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
      -- 4-7 的右边
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 1660, 696, 0x000000 }, { 1659, 696, 0x312052 },
          { 1660, 695, 0x000000 }, { 1659, 695, 0x3a245a },
          { 1661, 697, 0x000000 }, { 1660, 697, 0x312052 },
          { 1661, 698, 0x000000 }, { 1660, 698, 0x312452 },
        })
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
      -- 8-7 的右边
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 1694, 848, 0x000400 }, { 1693, 848, 0x733152 },
          { 1694, 847, 0x000000 }, { 1693, 847, 0x6b315a },
          { 1695, 849, 0x000000 }, { 1694, 849, 0x6b3152 },
          { 1695, 850, 0x000000 }, { 1694, 850, 0x6b3963 },
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