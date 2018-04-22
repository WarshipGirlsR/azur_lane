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
          { 1534, 505, 0x10283a }, { 1547, 505, 0x192d42 },
          { 1558, 505, 0x10283a }, { 1573, 505, 0x192d42 },
          { 1586, 506, 0x6b71b5 }, { 1572, 506, 0x636db5 },
          { 1562, 506, 0x636db5 }, { 1548, 506, 0x6371b5 },
        })
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
      -- 1-7的上边
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 1473, 551, 0x101c31 }, { 1484, 551, 0x081c29 },
          { 1493, 551, 0x102031 }, { 1505, 551, 0x102031 },
          { 1516, 552, 0x636dad }, { 1504, 552, 0x6369a4 },
          { 1490, 552, 0x5a65a4 }, { 1479, 552, 0x5a619c },
        })
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
      -- 1-5的上边
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 1061, 551, 0x081821 }, { 1075, 551, 0x101821 },
          { 1088, 551, 0x081419 }, { 1100, 551, 0x081419 },
          { 1116, 552, 0x424173 }, { 1106, 552, 0x42417b },
          { 1089, 552, 0x42457b }, { 1076, 552, 0x42457b },
        })
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
      -- 1-3的上边
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 684, 551, 0x102431 }, { 702, 551, 0x192831 },
          { 718, 551, 0x102431 }, { 728, 551, 0x102831 },
          { 739, 552, 0x3a3163 }, { 730, 552, 0x3a3963 },
          { 717, 552, 0x3a3163 }, { 699, 552, 0x3a3163 },
        })
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
      -- 1-2的上边
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 550, 551, 0x213131 }, { 562, 551, 0x193131 },
          { 574, 551, 0x193131 }, { 586, 551, 0x192831 },
          { 598, 552, 0x3a3963 }, { 587, 552, 0x3a3163 },
          { 573, 552, 0x3a3163 }, { 562, 552, 0x3a3963 },
        })
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
    },
    -- 地图下边界
    bottonLineList = {
      -- 6-3 的下面
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022 }
        local basePoint, posandcolor = transRelativePoint({
          { 476, 879, 0x000000 }, { 492, 879, 0x000000 },
          { 511, 879, 0x000000 }, { 532, 879, 0x000000 },
          { 553, 878, 0x29204a }, { 532, 878, 0x312452 },
          { 517, 878, 0x31244a }, { 504, 878, 0x312452 },
          { 503, 882, 0x000000 }, { 529, 882, 0x000000 },
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
          { 320, 582, 0x000400 }, { 321, 582, 0x31285a },
          { 320, 581, 0x000000 }, { 321, 581, 0x31285a },
          { 319, 583, 0x000000 }, { 320, 583, 0x31285a },
          { 319, 584, 0x000000 }, { 320, 584, 0x31355a },
        })
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
      -- 1-3 的左边
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 258, 855, 0x000000 }, { 259, 855, 0x312852 },
          { 258, 854, 0x000000 }, { 259, 854, 0x312852 },
          { 257, 856, 0x000000 }, { 258, 856, 0x312852 },
          { 257, 857, 0x000000 }, { 258, 857, 0x29244a },
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
          { 1686, 399, 0x000000 }, { 1685, 399, 0x636db5 },
          { 1686, 398, 0x000000 }, { 1685, 398, 0x636dad },
          { 1687, 400, 0x000000 }, { 1686, 400, 0x636db5 },
          { 1687, 401, 0x000000 }, { 1686, 401, 0x5a6dad },
        })
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
      -- 2-8 的右边
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 1733, 706, 0x000000 }, { 1732, 706, 0x6359a4 },
          { 1733, 705, 0x000000 }, { 1732, 705, 0x5a559c },
          { 1734, 707, 0x000000 }, { 1733, 707, 0x5a55a4 },
          { 1734, 708, 0x000000 }, { 1733, 708, 0x5a559c },
        })
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
      -- 3-8 的右边
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 1769, 843, 0x000000 }, { 1768, 843, 0x42417b },
          { 1769, 842, 0x000000 }, { 1768, 842, 0x4a457b },
          { 1770, 844, 0x000000 }, { 1769, 844, 0x4a417b },
          { 1770, 845, 0x000000 }, { 1769, 845, 0x4a417b },
        })
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
      -- 4-8 的右边
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 1675, 694, 0x000000 }, { 1674, 694, 0x42416b },
          { 1675, 693, 0x000000 }, { 1674, 693, 0x3a3563 },
          { 1676, 695, 0x000000 }, { 1675, 695, 0x423563 },
          { 1676, 696, 0x000000 }, { 1675, 696, 0x3a3563 },
        })
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
      -- 5-8 的右边
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 1702, 623, 0x000000 }, { 1701, 623, 0x3a3563 },
          { 1702, 622, 0x000000 }, { 1701, 622, 0x3a3563 },
          { 1703, 624, 0x000000 }, { 1702, 624, 0x423d63 },
          { 1703, 625, 0x000000 }, { 1702, 625, 0x3a3163 },
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