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
      -- 1-8的上边
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 1702, 495, 0x081019 }, { 1713, 495, 0x081419 },
          { 1724, 495, 0x081019 }, { 1733, 495, 0x081419 },
          { 1740, 496, 0x6b71b5 }, { 1728, 496, 0x6b71b5 },
          { 1718, 496, 0x636db5 }, { 1705, 496, 0x636dad },
        })
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
      -- 1-4的上边
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 846, 495, 0x081419 }, { 854, 495, 0x081419 },
          { 862, 495, 0x081419 }, { 870, 495, 0x081419 },
          { 879, 496, 0x312d5a }, { 867, 496, 0x31315a },
          { 858, 496, 0x3a3563 }, { 848, 496, 0x423563 },
        })
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
      -- 1-1的上边
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 332, 495, 0x000c10 }, { 342, 495, 0x000c10 },
          { 351, 495, 0x101019 }, { 362, 495, 0x000c11 },
          { 372, 496, 0x423563 }, { 361, 496, 0x3a2d5a },
          { 352, 496, 0x423563 }, { 343, 496, 0x312d5a },
        })
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
    },
    -- 地图下边界
    bottonLineList = {
      -- 5-1 的下面
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022 }
        local basePoint, posandcolor = transRelativePoint({
          { 425, 902, 0x000000 }, { 436, 902, 0x000000 },
          { 444, 902, 0x000000 }, { 449, 902, 0x000000 },
          { 457, 901, 0x29204a }, { 443, 901, 0x212042 },
          { 430, 901, 0x212042 }, { 423, 901, 0x29204a },
        })
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
      -- 5-4 的下面
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022 }
        local basePoint, posandcolor = transRelativePoint({
          { 1037, 902, 0x000000 }, { 1047, 902, 0x000000 },
          { 1053, 902, 0x000000 }, { 1064, 902, 0x000000 },
          { 1076, 901, 0x29204a }, { 1064, 901, 0x29204a },
          { 1058, 901, 0x292042 }, { 1048, 901, 0x292042 },
        })
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
      -- 5-9 的下面
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022 }
        local basePoint, posandcolor = transRelativePoint({
          { 1453, 902, 0x000000 }, { 1464, 902, 0x000000 },
          { 1470, 902, 0x000000 }, { 1479, 902, 0x000000 },
          { 1491, 901, 0x312d52 }, { 1482, 901, 0x292d4a },
          { 1474, 901, 0x292d4a }, { 1467, 901, 0x312c52 },
        })
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
    },
    -- 地图左边界
    leftLineList = {
      -- 5-1 的左边
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 379, 813, 0x000000 }, { 380, 813, 0x29204a },
          { 379, 812, 0x000000 }, { 380, 812, 0x29204a },
          { 378, 814, 0x000000 }, { 379, 814, 0x29204a },
          { 378, 815, 0x000000 }, { 379, 815, 0x29204a },
        })
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
      -- 1-1 的左边
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 295, 530, 0x000000 }, { 296, 530, 0x31315a },
          { 295, 529, 0x000000 }, { 296, 529, 0x31285a },
          { 294, 531, 0x000000 }, { 295, 531, 0x312d5a },
          { 294, 532, 0x000000 }, { 295, 532, 0x31285a },
        })
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
    },
    -- 地图右边界
    rightLineList = {
      -- 5-9 的右边
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 1597, 807, 0x000000 }, { 1596, 807, 0x312d5a },
          { 1597, 806, 0x000000 }, { 1596, 806, 0x3a3563 },
          { 1598, 808, 0x000000 }, { 1597, 808, 0x3a2d63 },
          { 1598, 809, 0x000000 }, { 1597, 809, 0x3a3163 },
        })
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
      -- 3-9 的右边
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 1902, 761, 0x000000 }, { 1901, 761, 0x4a417b },
          { 1902, 760, 0x000000 }, { 1901, 760, 0x4a417b },
          { 1903, 762, 0x000000 }, { 1902, 762, 0x4a4184 },
          { 1903, 763, 0x000000 }, { 1902, 763, 0x4a3d7b },
        })
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
      -- 1-9 的右边
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 1836, 531, 0x000000 }, { 1835, 531, 0x6369b5 },
          { 1836, 530, 0x000000 }, { 1835, 530, 0x6369b5 },
          { 1837, 532, 0x000000 }, { 1836, 532, 0x6b69b5 },
          { 1837, 533, 0x000000 }, { 1836, 533, 0x6365ad },
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