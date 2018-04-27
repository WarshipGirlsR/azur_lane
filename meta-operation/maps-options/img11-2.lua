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
          { 1514, 542, 0x212042 }, { 1522, 542, 0x212042 },
          { 1533, 542, 0x191c29 }, { 1549, 542, 0x191c29 },
          { 1560, 543, 0x6371ad }, { 1550, 543, 0x6371ad },
          { 1540, 543, 0x6371ad }, { 1531, 543, 0x6b71b5 },
        })
        return { basePoint[3], posandcolor, 93, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
      -- 1-1的上边
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 261, 542, 0x081019 }, { 269, 542, 0x081019 },
          { 282, 542, 0x211421 }, { 290, 542, 0x211421 },
          { 298, 543, 0x312d5a }, { 288, 543, 0x312d5a },
          { 279, 543, 0x3a2d63 }, { 268, 543, 0x312d5a },
        })
        return { basePoint[3], posandcolor, 93, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
      -- 1-7的上边
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 1379, 542, 0x29313a }, { 1387, 542, 0x21313a },
          { 1393, 542, 0x212d31 }, { 1400, 542, 0x313d42 },
          { 1408, 543, 0x5a699c }, { 1398, 543, 0x5a65a4 },
          { 1388, 543, 0x5a659c }, { 1380, 543, 0x5a619c },
        })
        return { basePoint[3], posandcolor, 93, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
      -- 1-7的上边
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 1072, 519, 0x000c10 }, { 1082, 519, 0x000c10 },
          { 1091, 519, 0x101019 }, { 1098, 519, 0x000c10 },
          { 1107, 520, 0x3a4173 }, { 1100, 520, 0x424573 },
          { 1091, 520, 0x3a416b }, { 1082, 520, 0x3a416b },
        })
        return { basePoint[3], posandcolor, 93, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
      -- 1-2的上边
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 422, 542, 0x101421 }, { 436, 542, 0x101421 },
          { 449, 542, 0x081019 }, { 458, 542, 0x211421 },
          { 467, 543, 0x3a3163 }, { 458, 543, 0x312d5a },
          { 448, 543, 0x3a315a }, { 439, 543, 0x3a3163 },
        })
        return { basePoint[3], posandcolor, 93, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
      -- 1-5的上边
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 1276, 527, 0x101421 }, { 1288, 527, 0x101421 },
          { 1301, 527, 0x101429 }, { 1311, 527, 0x191829 },
          { 1322, 528, 0x42457b }, { 1312, 528, 0x42457b },
          { 1303, 528, 0x42497b }, { 1293, 528, 0x424573 },
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
          { 359, 966, 0x000000 }, { 370, 966, 0x000000 },
          { 384, 966, 0x000000 }, { 397, 966, 0x000000 },
          { 407, 968, 0x000000 }, { 398, 968, 0x000000 },
          { 391, 968, 0x000000 }, { 396, 965, 0x212042 },
          { 386, 965, 0x212042 }, { 380, 965, 0x212042 },
        })
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
      -- 6-1 的下面
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022 }
        local basePoint, posandcolor = transRelativePoint({
          { 451, 995, 0x000000 }, { 465, 995, 0x000000 },
          { 478, 995, 0x000000 }, { 492, 995, 0x000000 },
          { 503, 994, 0x29204a }, { 490, 994, 0x29204a },
          { 477, 994, 0x212042 }, { 468, 994, 0x29204a },
          { 477, 997, 0x000000 }, { 458, 997, 0x000000 },
        })
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
      -- 6-2 的下面
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022 }
        local basePoint, posandcolor = transRelativePoint({
          { 697, 995, 0x000000 }, { 709, 995, 0x000000 },
          { 720, 995, 0x000000 }, { 732, 995, 0x000000 },
          { 741, 994, 0x29204a }, { 733, 994, 0x29204a },
          { 722, 994, 0x312452 }, { 713, 994, 0x29204a },
          { 714, 997, 0x000000 }, { 697, 997, 0x000000 },
        })
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
      -- 6-4 的下面
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022 }
        local basePoint, posandcolor = transRelativePoint({
          { 478, 953, 0x000000 }, { 491, 953, 0x000000 },
          { 504, 953, 0x000000 }, { 517, 953, 0x000000 },
          { 530, 952, 0x31244a }, { 520, 952, 0x31244a },
          { 510, 952, 0x31244a }, { 498, 952, 0x31204a },
          { 520, 955, 0x000000 }, { 502, 955, 0x000000 },
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
          { 574, 556, 0x000000 }, { 575, 556, 0x31285a },
          { 574, 555, 0x000000 }, { 575, 555, 0x312d5a },
          { 573, 557, 0x000000 }, { 574, 557, 0x292852 },
          { 573, 558, 0x000000 }, { 574, 558, 0x31355a },
        })
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
      -- 2-1 的左边
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 558, 684, 0x000000 }, { 559, 684, 0x312852 },
          { 558, 683, 0x000000 }, { 559, 683, 0x312852 },
          { 557, 685, 0x000000 }, { 558, 685, 0x29244a },
          { 557, 686, 0x000000 }, { 558, 686, 0x312852 },
        })
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
      -- 6-1 的左边
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 429, 907, 0x000000 }, { 430, 907, 0x211c42 },
          { 429, 906, 0x000000 }, { 430, 906, 0x29204a },
          { 428, 908, 0x000000 }, { 429, 908, 0x29204a },
          { 428, 909, 0x000000 }, { 429, 909, 0x29204a },
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
          { 1588, 566, 0x000000 }, { 1587, 566, 0x636db5 },
          { 1588, 565, 0x000000 }, { 1587, 565, 0x636db5 },
          { 1589, 567, 0x000000 }, { 1588, 567, 0x636dad },
          { 1589, 568, 0x000000 }, { 1588, 568, 0x6b6db5 },
        })
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
      -- 2-8 的右边
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 1615, 699, 0x000000 }, { 1614, 699, 0x5a559c },
          { 1615, 698, 0x000000 }, { 1614, 698, 0x6359a4 },
          { 1616, 700, 0x000000 }, { 1615, 700, 0x5a559c },
          { 1616, 701, 0x000000 }, { 1615, 701, 0x5a55a4 },
        })
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
      -- 4-8 的右边
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 1477, 535, 0x000000 }, { 1476, 535, 0x424173 },
          { 1477, 534, 0x000000 }, { 1476, 534, 0x42457b },
          { 1478, 536, 0x000000 }, { 1477, 536, 0x42417b },
          { 1478, 537, 0x000000 }, { 1477, 537, 0x42417b },
        })
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
      -- 6-8 的右边
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 1527, 831, 0x000000 }, { 1526, 831, 0x312d5a },
          { 1527, 830, 0x000000 }, { 1526, 830, 0x423963 },
          { 1528, 832, 0x000000 }, { 1527, 832, 0x312d5a },
          { 1528, 833, 0x000000 }, { 1527, 833, 0x3a3163 },
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