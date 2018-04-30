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
      -- 1-7的上边
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 1566, 529, 0x081821 }, { 1578, 529, 0x081821 },
          { 1586, 529, 0x081821 }, { 1599, 529, 0x101c29 },
          { 1610, 530, 0x6b75b5 }, { 1601, 530, 0x6b71ad },
          { 1592, 530, 0x6b75b5 }, { 1582, 530, 0x6b71b5 },
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
      -- 1-5的上边
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 1240, 529, 0x191c29 }, { 1250, 529, 0x101c21 },
          { 1259, 529, 0x192031 }, { 1270, 529, 0x101c21 },
          { 1280, 530, 0x424173 }, { 1268, 530, 0x424173 },
          { 1258, 530, 0x424173 }, { 1245, 530, 0x3a396b },
        })
        return { basePoint[3], posandcolor, 93, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
      -- 1-4的上边
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 1071, 529, 0x21243a }, { 1081, 529, 0x29283a },
          { 1089, 529, 0x21283a }, { 1100, 529, 0x212431 },
          { 1110, 530, 0x42457b }, { 1102, 530, 0x42497b },
          { 1092, 530, 0x42457b }, { 1075, 530, 0x42497b },
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
          { 294, 956, 0x000000 }, { 303, 956, 0x000000 },
          { 317, 956, 0x000000 }, { 329, 956, 0x000000 },
          { 338, 955, 0x211c42 }, { 329, 955, 0x29204a },
          { 319, 955, 0x29204a }, { 310, 955, 0x212042 },
          { 310, 958, 0x000000 }, { 320, 958, 0x000000 },
        })
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
      -- 6-3 的下面
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022 }
        local basePoint, posandcolor = transRelativePoint({
          { 746, 956, 0x000000 }, { 757, 956, 0x000000 },
          { 769, 956, 0x000000 }, { 783, 956, 0x000000 },
          { 790, 955, 0x29204a }, { 778, 955, 0x29204a },
          { 765, 955, 0x29244a }, { 748, 955, 0x29244a },
          { 747, 958, 0x000000 }, { 759, 958, 0x000000 },
        })
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
      -- 6-5 的下面
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022 }
        local basePoint, posandcolor = transRelativePoint({
          { 1164, 956, 0x000000 }, { 1178, 956, 0x000000 },
          { 1192, 956, 0x080408 }, { 1206, 956, 0x000400 },
          { 1218, 955, 0x29244a }, { 1208, 955, 0x191c3a },
          { 1196, 955, 0x191c3a }, { 1183, 955, 0x292442 },
          { 1182, 958, 0x080408 }, { 1197, 958, 0x000000 },
        })
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
    },
    -- 地图左边界
    leftLineList = {
      -- 1-2 的左边
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 413, 687, 0x000000 }, { 414, 687, 0x29244a },
          { 413, 686, 0x000000 }, { 414, 686, 0x312852 },
          { 412, 688, 0x000000 }, { 413, 688, 0x312852 },
          { 412, 689, 0x000000 }, { 413, 689, 0x312852 },
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
          { 1632, 564, 0x000008 }, { 1631, 564, 0x636dad },
          { 1632, 563, 0x000000 }, { 1631, 563, 0x636db5 },
          { 1633, 565, 0x000000 }, { 1632, 565, 0x6369ad },
          { 1633, 566, 0x000000 }, { 1632, 566, 0x636db5 },
        })
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
      -- 2-7 的右边
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 1660, 692, 0x000000 }, { 1659, 692, 0x5a559c },
          { 1660, 691, 0x000000 }, { 1659, 691, 0x6359a4 },
          { 1661, 693, 0x000000 }, { 1660, 693, 0x5a559c },
          { 1661, 694, 0x000000 }, { 1660, 694, 0x6359a4 },
        })
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
      -- 3-7 的右边
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 1671, 412, 0x000000 }, { 1670, 412, 0x4a4584 },
          { 1671, 411, 0x000000 }, { 1670, 411, 0x4a417b },
          { 1672, 413, 0x000000 }, { 1671, 413, 0x4a417b },
          { 1672, 414, 0x000000 }, { 1671, 414, 0x4a417b },
        })
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
      -- 4-7 的右边
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 1701, 536, 0x000000 }, { 1700, 536, 0x42457b },
          { 1701, 535, 0x000000 }, { 1700, 535, 0x3a4173 },
          { 1702, 537, 0x000000 }, { 1701, 537, 0x42417b },
          { 1702, 538, 0x000000 }, { 1701, 538, 0x42417b },
        })
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
      -- 5-7 的右边
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 1733, 668, 0x000000 }, { 1732, 668, 0x423d63 },
          { 1733, 667, 0x000000 }, { 1732, 667, 0x3a355a },
          { 1734, 669, 0x000000 }, { 1733, 669, 0x3a3563 },
          { 1734, 670, 0x000000 }, { 1733, 670, 0x3a3563 },
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