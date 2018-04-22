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
          { 409, 519, 0x081019 }, { 421, 519, 0x081019 },
          { 434, 519, 0x000c10 }, { 447, 519, 0x100c19 },
          { 458, 520, 0x3a3963 }, { 444, 520, 0x423963 },
          { 433, 520, 0x3a2d63 }, { 424, 520, 0x423963 },
        })
        return { basePoint[3], posandcolor, 93, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
      -- 1-9的上边
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 1466, 530, 0x211831 }, { 1477, 530, 0x081421 },
          { 1485, 530, 0x081421 }, { 1493, 530, 0x081421 },
          { 1503, 531, 0x636db5 }, { 1495, 531, 0x636db5 },
          { 1486, 531, 0x636dad }, { 1476, 531, 0x636dad },
        })
        return { basePoint[3], posandcolor, 93, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
      -- 1-5的上边
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 787, 530, 0x101019 }, { 798, 530, 0x101421 },
          { 807, 530, 0x081019 }, { 813, 530, 0x081019 },
          { 824, 531, 0x31396b }, { 814, 531, 0x3a3963 },
          { 805, 531, 0x3a396b }, { 796, 531, 0x313963 },
        })
        return { basePoint[3], posandcolor, 93, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
      -- 1-3的上边
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 747, 519, 0x101419 }, { 757, 519, 0x081419 },
          { 766, 519, 0x081019 }, { 773, 519, 0x081419 },
          { 784, 520, 0x423963 }, { 776, 520, 0x423963 },
          { 770, 520, 0x3a3963 }, { 762, 520, 0x3a3963 },
        })
        return { basePoint[3], posandcolor, 93, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
      -- 1-8的上边
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 1283, 530, 0x101421 }, { 1292, 530, 0x191829 },
          { 1302, 530, 0x211831 }, { 1311, 530, 0x101429 },
          { 1320, 531, 0x4a598c }, { 1313, 531, 0x525994 },
          { 1305, 531, 0x4a598c }, { 1296, 531, 0x4a5184 },
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
          { 274, 921, 0x000000 }, { 282, 921, 0x000000 },
          { 292, 921, 0x000000 }, { 299, 921, 0x000000 },
          { 310, 920, 0x29204a }, { 305, 920, 0x212042 },
          { 298, 920, 0x29204a }, { 289, 920, 0x29204a },
        })
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
      -- 6-4 的下面
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022 }
        local basePoint, posandcolor = transRelativePoint({
          { 948, 921, 0x000000 }, { 957, 921, 0x000000 },
          { 967, 921, 0x000000 }, { 977, 921, 0x000000 },
          { 987, 920, 0x29204a }, { 980, 920, 0x29244a },
          { 973, 920, 0x29204a }, { 966, 920, 0x31204a },
        })
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
      -- 6-7 的下面
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022 }
        local basePoint, posandcolor = transRelativePoint({
          { 1111, 933, 0x000000 }, { 1122, 933, 0x000000 },
          { 1129, 933, 0x000000 }, { 1137, 933, 0x000000 },
          { 1146, 932, 0x312852 }, { 1138, 932, 0x312852 },
          { 1131, 932, 0x29284a }, { 1122, 932, 0x312852 },
        })
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
      -- 6-5 的下面
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022 }
        local basePoint, posandcolor = transRelativePoint({
          {  645,  933, 0x000000},          {  654,  933, 0x000000},
          {  663,  933, 0x000000},          {  671,  933, 0x000000},
          {  681,  932, 0x31244a},          {  675,  932, 0x292442},
          {  667,  932, 0x292442},          {  659,  932, 0x29244a},
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
          { 378, 555, 0x000000 }, { 379, 555, 0x31285a },
          { 378, 554, 0x000000 }, { 379, 554, 0x31285a },
          { 377, 556, 0x000000 }, { 378, 556, 0x31355a },
          { 377, 557, 0x000000 }, { 378, 557, 0x31285a },
        })
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
      -- 2-1 的左边
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 354, 682, 0x000000 }, { 355, 682, 0x312852 },
          { 354, 681, 0x000000 }, { 355, 681, 0x312852 },
          { 353, 683, 0x000000 }, { 354, 683, 0x292852 },
          { 353, 684, 0x000000 }, { 354, 684, 0x31285a },
        })
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
      -- 6-1 的左边
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 259, 809, 0x000000 }, { 260, 809, 0x29204a },
          { 259, 808, 0x000000 }, { 260, 808, 0x29244a },
          { 258, 810, 0x000000 }, { 259, 810, 0x29204a },
          { 258, 811, 0x000000 }, { 259, 811, 0x29204a },
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
          { 1602, 567, 0x000000 }, { 1601, 567, 0x636db5 },
          { 1602, 566, 0x000000 }, { 1601, 566, 0x636dad },
          { 1603, 568, 0x000000 }, { 1602, 568, 0x636db5 },
          { 1603, 569, 0x000000 }, { 1602, 569, 0x5a69ad },
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
          { 1631, 707, 0x000000 }, { 1630, 707, 0x5a559c },
          { 1631, 706, 0x000000 }, { 1630, 706, 0x6355a4 },
          { 1632, 708, 0x000008 }, { 1631, 708, 0x5a559c },
          { 1632, 709, 0x000000 }, { 1631, 709, 0x5a55a4 },
        })
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
      -- 6-8 的右边
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 1696, 807, 0x000000 }, { 1695, 807, 0x3a3163 },
          { 1696, 806, 0x000000 }, { 1695, 806, 0x3a2d63 },
          { 1697, 808, 0x000000 }, { 1696, 808, 0x423963 },
          { 1697, 809, 0x000000 }, { 1696, 809, 0x312d5a },
        })
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
      -- 5-8 的右边
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 1664, 663, 0x000000 }, { 1663, 663, 0x3a3563 },
          { 1664, 662, 0x000000 }, { 1663, 662, 0x3a3563 },
          { 1665, 664, 0x000000 }, { 1664, 664, 0x423d6b },
          { 1665, 665, 0x000000 }, { 1664, 665, 0x3a3563 },
        })
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
      -- 4-8 的右边
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 1631, 513, 0x000000 }, { 1630, 513, 0x423d73 },
          { 1631, 512, 0x000000 }, { 1630, 512, 0x42417b },
          { 1632, 514, 0x000000 }, { 1631, 514, 0x42417b },
          { 1632, 515, 0x000000 }, { 1631, 515, 0x42417b },
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