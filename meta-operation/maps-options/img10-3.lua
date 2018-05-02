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
          { 694, 507, 0x212431 }, { 712, 507, 0x192031 },
          { 725, 507, 0x21243a }, { 744, 507, 0x192031 },
          { 762, 508, 0x3a3963 }, { 748, 508, 0x423963 },
          { 730, 508, 0x3a3963 }, { 713, 508, 0x3a2d63 },
        })
        return { basePoint[3], posandcolor, 93, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
      -- 1-9的上边
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 1570, 505, 0x101821 }, { 1580, 505, 0x101429 },
          { 1592, 505, 0x081421 }, { 1604, 505, 0x191c29 },
          { 1606, 506, 0x6b75b5 }, { 1596, 506, 0x6b75b5 },
          { 1585, 506, 0x6b6d9c }, { 1572, 506, 0x6b71b5 },
        })
        return { basePoint[3], posandcolor, 93, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
      -- 1-7的上边
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 1126, 505, 0x101829 }, { 1137, 505, 0x191831 },
          { 1148, 505, 0x191829 }, { 1158, 505, 0x101829 },
          { 1165, 506, 0x3a4173 }, { 1150, 506, 0x424173 },
          { 1137, 506, 0x3a3d6b }, { 1122, 506, 0x424173 },
        })
        return { basePoint[3], posandcolor, 93, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
      -- 1-5的上边
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 816, 505, 0x191829 }, { 835, 505, 0x191831 },
          { 845, 505, 0x191831 }, { 857, 505, 0x191831 },
          { 869, 506, 0x3a3d73 }, { 860, 506, 0x42417b },
          { 843, 506, 0x3a3d6b }, { 824, 506, 0x3a416b },
        })
        return { basePoint[3], posandcolor, 93, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
      -- 1-3的上边
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 879, 507, 0x191831 }, { 893, 507, 0x191831 },
          { 904, 507, 0x101429 }, { 920, 507, 0x101429 },
          { 933, 508, 0x3a3163 }, { 927, 508, 0x3a315a },
          { 911, 508, 0x3a3163 }, { 894, 508, 0x3a3963 },
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
          { 493, 909, 0x000000 }, { 511, 909, 0x000000 },
          { 522, 909, 0x000000 }, { 532, 909, 0x000000 },
          { 545, 908, 0x29204a }, { 535, 908, 0x212042 },
          { 520, 908, 0x29204a }, { 508, 908, 0x29204a },
          { 507, 911, 0x000000 }, { 525, 911, 0x000000 },
        })
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
      -- 6-2 的下面
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022 }
        local basePoint, posandcolor = transRelativePoint({
          { 728, 909, 0x000000 }, { 741, 909, 0x000000 },
          { 757, 909, 0x000000 }, { 778, 909, 0x000000 },
          { 789, 908, 0x29204a }, { 779, 908, 0x29204a },
          { 763, 908, 0x29204a }, { 749, 908, 0x29204a },
          { 746, 911, 0x000000 }, { 769, 911, 0x000000 },
        })
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
      -- 6-4 的下面
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022 }
        local basePoint, posandcolor = transRelativePoint({
          { 272, 912, 0x000000 }, { 291, 912, 0x000000 },
          { 313, 912, 0x000000 }, { 335, 912, 0x000000 },
          { 352, 911, 0x212442 }, { 335, 911, 0x29244a },
          { 315, 911, 0x29244a }, { 298, 911, 0x29204a },
          { 298, 914, 0x000000 }, { 325, 914, 0x000000 },
        })
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
      -- 6-7 的下面
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022 }
        local basePoint, posandcolor = transRelativePoint({
          { 976, 912, 0x000000 }, { 992, 912, 0x000000 },
          { 1009, 912, 0x000000 }, { 1031, 912, 0x000000 },
          { 1048, 911, 0x29244a }, { 1030, 911, 0x29284a },
          { 1013, 911, 0x29284a }, { 1000, 911, 0x29284a },
          { 1000, 914, 0x000000 }, { 1026, 914, 0x000000 },
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
          { 472, 657, 0x000000 }, { 473, 657, 0x312852 },
          { 472, 656, 0x000000 }, { 473, 656, 0x292852 },
          { 471, 658, 0x000000 }, { 472, 658, 0x312852 },
          { 471, 659, 0x000000 }, { 472, 659, 0x292852 },
        })
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
      -- 3-1 的左边
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 522, 532, 0x000000 }, { 523, 532, 0x312d52 },
          { 522, 531, 0x000000 }, { 523, 531, 0x312d5a },
          { 521, 533, 0x000000 }, { 522, 533, 0x292d52 },
          { 521, 534, 0x000000 }, { 522, 534, 0x31355a },
        })
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
      -- 4-1 的左边
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 502, 672, 0x000000 }, { 503, 672, 0x292452 },
          { 502, 671, 0x000000 }, { 503, 671, 0x312852 },
          { 501, 673, 0x000000 }, { 502, 673, 0x29244a },
          { 501, 674, 0x000000 }, { 502, 674, 0x312852 },
        })
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
      -- 7-1 的左边
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 457, 834, 0x000000 }, { 458, 834, 0x29204a },
          { 457, 833, 0x000000 }, { 458, 833, 0x211c42 },
          { 456, 835, 0x000000 }, { 457, 835, 0x29204a },
          { 456, 836, 0x000000 }, { 457, 836, 0x29204a },
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
          { 1615, 546, 0x000000 }, { 1614, 546, 0x636db5 },
          { 1615, 545, 0x000000 }, { 1614, 545, 0x5a69ad },
          { 1616, 547, 0x000000 }, { 1615, 547, 0x636db5 },
          { 1616, 548, 0x000000 }, { 1615, 548, 0x6369ad },
        })
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
      -- 2-9 的右边
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 1639, 658, 0x000000 }, { 1638, 658, 0x635dad },
          { 1639, 657, 0x000000 }, { 1638, 657, 0x5a599c },
          { 1640, 659, 0x000000 }, { 1639, 659, 0x6359a4 },
          { 1640, 660, 0x000000 }, { 1639, 660, 0x5a599c },
        })
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
      -- 4-9 的右边
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 1569, 646, 0x000000 }, { 1568, 646, 0x4a417b },
          { 1569, 645, 0x000000 }, { 1568, 645, 0x4a3d7b },
          { 1570, 647, 0x000000 }, { 1569, 647, 0x4a417b },
          { 1570, 648, 0x000000 }, { 1569, 648, 0x4a417b },
        })
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
      -- 6-9 的右边
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 1611, 814, 0x000000 }, { 1610, 814, 0x423963 },
          { 1611, 813, 0x000000 }, { 1610, 813, 0x312d5a },
          { 1612, 815, 0x000000 }, { 1611, 815, 0x3a3163 },
          { 1612, 816, 0x000000 }, { 1611, 816, 0x31315a },
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