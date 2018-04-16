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
          { 1447, 505, 0x102842 }, { 1460, 505, 0x10243a },
          { 1472, 505, 0x10243a }, { 1483, 505, 0x102842 },
          { 1494, 506, 0x636dad }, { 1482, 506, 0x6369a4 },
          { 1471, 506, 0x5a65a4 }, { 1457, 506, 0x5a619c },
        })
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
      -- 1-4的上边
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 860, 505, 0x102031 }, { 874, 505, 0x102031 },
          { 889, 505, 0x192442 }, { 901, 505, 0x192442 },
          { 913, 506, 0x3a3163 }, { 903, 506, 0x3a3163 },
          { 891, 506, 0x3a3163 }, { 880, 506, 0x3a3d63 },
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
          { 466, 903, 0x000000 }, { 484, 903, 0x000000 },
          { 499, 903, 0x000000 }, { 512, 903, 0x000000 },
          { 525, 902, 0x29244a }, { 512, 902, 0x312452 },
          { 494, 902, 0x312452 }, { 480, 902, 0x312852 },
        })
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
      -- 6-4的下面
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022 }
        local basePoint, posandcolor = transRelativePoint({
          { 716, 894, 0x000000 }, { 736, 894, 0x000000 },
          { 758, 894, 0x000000 }, { 774, 894, 0x000000 },
          { 791, 893, 0x29204a }, { 773, 893, 0x31204a },
          { 754, 893, 0x292042 }, { 734, 893, 0x212042 },
        })
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
      -- 6-5的下面
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022 }
        local basePoint, posandcolor = transRelativePoint({
          { 910, 903, 0x000000 }, { 924, 903, 0x000000 },
          { 935, 903, 0x000000 }, { 946, 903, 0x000000 },
          { 959, 902, 0x31244a }, { 947, 902, 0x31244a },
          { 935, 902, 0x31244a }, { 923, 902, 0x31244a },
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
          { 321, 395, 0x000000 }, { 322, 395, 0x31285a },
          { 321, 394, 0x000000 }, { 322, 394, 0x31355a },
          { 320, 396, 0x000000 }, { 321, 396, 0x31285a },
          { 320, 397, 0x000000 }, { 321, 397, 0x312d5a },
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
          { 1716, 520, 0x000000 }, { 1715, 520, 0x5a559c },
          { 1716, 519, 0x000000 }, { 1715, 519, 0x6355a4 },
          { 1717, 521, 0x000000 }, { 1716, 521, 0x5a559c },
          { 1717, 522, 0x000000 }, { 1716, 522, 0x6359a4 },
        })
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
      -- 3-8 的右边
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 1752, 665, 0x000000 }, { 1751, 665, 0x4a457b },
          { 1752, 664, 0x000000 }, { 1751, 664, 0x4a417b },
          { 1753, 666, 0x000000 }, { 1752, 666, 0x4a4584 },
          { 1753, 667, 0x000000 }, { 1752, 667, 0x42417b },
        })
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
      -- 6-8 的右边
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 1741, 789, 0x000000 }, { 1740, 789, 0x312d5a },
          { 1741, 788, 0x000000 }, { 1740, 788, 0x423963 },
          { 1742, 790, 0x000000 }, { 1741, 790, 0x312d5a },
          { 1742, 791, 0x000000 }, { 1741, 791, 0x3a3163 },
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