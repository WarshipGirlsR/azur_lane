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
      -- 1-3的上边
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 947, 464, 0x19283a }, { 957, 464, 0x192442 },
          { 971, 464, 0x19243a }, { 983, 464, 0x19243a },
          { 1002, 465, 0x9c657b }, { 990, 465, 0x9c697b },
          { 976, 465, 0x9c657b }, { 962, 465, 0x9c6573 },
        })
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
      -- 1-2的上边
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 796, 464, 0x5a4142 }, { 808, 464, 0x211c21 },
          { 820, 464, 0x212842 }, { 830, 464, 0x212842 },
          { 841, 465, 0xa46984 }, { 832, 465, 0x9c697b },
          { 822, 465, 0x9c617b }, { 809, 465, 0x9c657b },
        })
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
      -- 1-1的上边
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 576, 464, 0x5a4131 }, { 585, 464, 0x523929 },
          { 595, 464, 0x523929 }, { 608, 464, 0x5a4131 },
          { 616, 465, 0x6b4973 }, { 606, 465, 0x5a496b },
          { 597, 465, 0x634d7b }, { 588, 465, 0x63497b },
        })
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
      -- 1-7的上边
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 1266, 481, 0x191c19 }, { 1274, 481, 0x212421 },
          { 1284, 481, 0x3a3129 }, { 1292, 481, 0x312d29 },
          { 1302, 482, 0xce9e73 }, { 1291, 482, 0xcea273 },
          { 1281, 482, 0xbd9a73 }, { 1268, 482, 0xce9e73 },
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
          { 474, 903, 0x000000 }, { 481, 903, 0x000000 },
          { 494, 903, 0x000000 }, { 505, 903, 0x000000 },
          { 514, 902, 0x423d6b }, { 505, 902, 0x3a356b },
          { 495, 902, 0x3a396b }, { 483, 902, 0x3a396b },
        })
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
      -- 5-4 的下面
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022 }
        local basePoint, posandcolor = transRelativePoint({
          { 1138, 903, 0x000000 }, { 1148, 903, 0x000000 },
          { 1159, 903, 0x000000 }, { 1171, 903, 0x000000 },
          { 1185, 902, 0x31284a }, { 1176, 902, 0x31284a },
          { 1163, 902, 0x31284a }, { 1152, 902, 0x3a2852 },
        })
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
      -- 5-8 的下面
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022 }
        local basePoint, posandcolor = transRelativePoint({
          { 1576, 900, 0x000000 }, { 1588, 900, 0x000000 },
          { 1600, 900, 0x000000 }, { 1613, 900, 0x000000 },
          { 1625, 899, 0x6b415a }, { 1612, 899, 0x5a3d52 },
          { 1599, 899, 0x633d52 }, { 1586, 899, 0x5a3952 },
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
          { 562, 520, 0x000400 }, { 563, 520, 0x5a4d7b },
          { 562, 519, 0x000000 }, { 563, 519, 0x634d84 },
          { 561, 521, 0x000000 }, { 562, 521, 0x5a4d73 },
          { 561, 522, 0x000000 }, { 562, 522, 0x634d8c },
        })
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
      -- 2-1 的左边
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 546, 631, 0x000000 }, { 547, 631, 0x5a4d84 },
          { 546, 630, 0x000000 }, { 547, 630, 0x524d84 },
          { 545, 632, 0x000000 }, { 546, 632, 0x524d84 },
          { 545, 633, 0x000000 }, { 546, 633, 0x4a4d7b },
        })
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
      -- 3-1 的左边
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 524, 784, 0x000000 }, { 525, 784, 0x4a4984 },
          { 524, 783, 0x000000 }, { 525, 783, 0x4a4984 },
          { 523, 785, 0x000000 }, { 524, 785, 0x4a497b },
          { 523, 786, 0x000000 }, { 524, 786, 0x524984 },
        })
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
      -- 5-1 的左边
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 457, 851, 0x000000 }, { 458, 851, 0x42396b },
          { 457, 850, 0x000000 }, { 458, 850, 0x424173 },
          { 456, 852, 0x000000 }, { 457, 852, 0x423d6b },
          { 456, 853, 0x000000 }, { 457, 853, 0x423d6b },
        })
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
    },
    -- 地图右边界
    rightLineList = {
      -- 3-8 的右边
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 1636, 460, 0x100810 }, { 1635, 460, 0xbd866b },
          { 1636, 459, 0x000000 }, { 1635, 459, 0xbd866b },
          { 1637, 461, 0x000000 }, { 1636, 461, 0xb5816b },
          { 1637, 462, 0x000000 }, { 1636, 462, 0xbd8a6b },
        })
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
      -- 4-8 的右边
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 1673, 608, 0x000000 }, { 1672, 608, 0xad6d63 },
          { 1673, 607, 0x000000 }, { 1672, 607, 0x9c6d5a },
          { 1674, 609, 0x000000 }, { 1673, 609, 0xad6d63 },
          { 1674, 610, 0x000000 }, { 1673, 610, 0x9c6d63 },
        })
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
      -- 5-8 的右边
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 1717, 783, 0x000000 }, { 1716, 783, 0x8c5963 },
          { 1717, 782, 0x000000 }, { 1716, 782, 0x94596b },
          { 1718, 784, 0x000000 }, { 1717, 784, 0x8c5963 },
          { 1718, 785, 0x000000 }, { 1717, 785, 0x8c596b },
        })
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
      -- 2-8 的右边
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 1627, 424, 0x000000 }, { 1626, 424, 0xb5816b },
          { 1627, 423, 0x000000 }, { 1626, 423, 0xb57d6b },
          { 1628, 425, 0x000000 }, { 1627, 425, 0xb5816b },
          { 1628, 426, 0x000000 }, { 1627, 426, 0xb57d6b },
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