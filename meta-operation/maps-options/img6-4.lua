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
          { 1552, 151, 0x212829 }, { 1568, 151, 0x101419 },
          { 1577, 151, 0x212429 }, { 1592, 151, 0x101819 },
          { 1598, 152, 0x6b75b5 }, { 1586, 152, 0x6b75ad },
          { 1565, 152, 0x6b6dad }, { 1546, 152, 0x6b71b5 },
        })
        return { basePoint[3], posandcolor, 92, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
      -- 1-8的上边
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 1254, 730, 0x211421 }, { 1271, 730, 0x100c19 },
          { 1286, 730, 0x211421 }, { 1303, 730, 0x101019 },
          { 1317, 731, 0x6b71ad }, { 1294, 731, 0x636da4 },
          { 1276, 731, 0x63699c }, { 1256, 731, 0x63699c },
        })
        return { basePoint[3], posandcolor, 92, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
      -- 1-7的上边
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 1421, 490, 0x191c21 }, { 1438, 490, 0x191c29 },
          { 1456, 490, 0x211c29 }, { 1471, 490, 0x191c29 },
          { 1485, 491, 0x525d94 }, { 1459, 491, 0x52558c },
          { 1437, 491, 0x4a5184 }, { 1413, 491, 0x4a5184 },
        })
        return { basePoint[3], posandcolor, 92, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
      -- 1-4的上边
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 954, 490, 0x191421 }, { 968, 490, 0x191421 },
          { 981, 490, 0x101419 }, { 998, 490, 0x191821 },
          { 1008, 491, 0x313563 }, { 995, 491, 0x423963 },
          { 979, 491, 0x423563 }, { 960, 491, 0x31315a },
        })
        return { basePoint[3], posandcolor, 92, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
    },
    -- 地图下边界
    bottonLineList = {
      -- 6-1 的下面
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022 }
        local basePoint, posandcolor = transRelativePoint({
          { 558, 925, 0x000000 }, { 581, 925, 0x000000 },
          { 601, 925, 0x000000 }, { 619, 925, 0x000000 },
          { 635, 924, 0x29204a }, { 613, 924, 0x212042 },
          { 592, 924, 0x29204a }, { 571, 924, 0x212042 },
        })
        return { basePoint[3], posandcolor, 95, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
      -- 6-3 的下面
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022 }
        local basePoint, posandcolor = transRelativePoint({
          { 982, 925, 0x000000 }, { 997, 925, 0x000000 },
          { 1015, 925, 0x000000 }, { 1035, 925, 0x000000 },
          { 1055, 924, 0x31244a }, { 1035, 924, 0x31244a },
          { 1013, 924, 0x31244a }, { 987, 924, 0x312452 },
        })
        return { basePoint[3], posandcolor, 95, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
      -- 6-5 的下面
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022 }
        local basePoint, posandcolor = transRelativePoint({
          { 992, 931, 0x000000 }, { 1015, 931, 0x000000 },
          { 1029, 931, 0x000000 }, { 1044, 931, 0x000000 },
          { 1058, 930, 0x312852 }, { 1040, 930, 0x312452 },
          { 1017, 930, 0x31244a }, { 996, 930, 0x312452 },
        })
        return { basePoint[3], posandcolor, 95, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
    },
    -- 地图左边界
    leftLineList = {
      -- 1-1 的左边
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 404, 514, 0x000000 }, { 405, 514, 0x31285a },
          { 404, 513, 0x000000 }, { 405, 513, 0x31315a },
          { 403, 515, 0x000000 }, { 404, 515, 0x292852 },
          { 403, 516, 0x000000 }, { 404, 516, 0x312d5a },
        })
        return { basePoint[3], posandcolor, 95, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
      -- 1-3 的左边
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 359, 760, 0x000000 }, { 360, 760, 0x312d5a },
          { 359, 759, 0x000000 }, { 360, 759, 0x292d52 },
          { 358, 761, 0x000000 }, { 359, 761, 0x313152 },
          { 358, 762, 0x000000 }, { 359, 762, 0x312d52 },
        })
        return { basePoint[3], posandcolor, 95, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
    },
    -- 地图右边界
    rightLineList = {
      -- 1-8 的右边
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 1609, 158, 0x000000 }, { 1608, 158, 0x6b71b5 },
          { 1609, 157, 0x000000 }, { 1608, 157, 0x6369ad },
          { 1610, 159, 0x000000 }, { 1609, 159, 0x6b71b5 },
          { 1610, 160, 0x080408 }, { 1609, 160, 0x6b71b5 },
        })
        return { basePoint[3], posandcolor, 95, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
      -- 1-8 的右边
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 1358, 736, 0x000000 }, { 1357, 736, 0x6b71ad },
          { 1358, 735, 0x000000 }, { 1357, 735, 0x6b71ad },
          { 1359, 737, 0x000000 }, { 1358, 737, 0x636d9c },
          { 1359, 738, 0x000000 }, { 1358, 738, 0x6b71b5 },
        })
        return { basePoint[3], posandcolor, 95, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
      -- 3-8 的右边
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 1682, 460, 0x000000 }, { 1681, 460, 0x4a417b },
          { 1682, 459, 0x000000 }, { 1681, 459, 0x4a417b },
          { 1683, 461, 0x000000 }, { 1682, 461, 0x423d7b },
          { 1683, 462, 0x000000 }, { 1682, 462, 0x4a417b },
        })
        return { basePoint[3], posandcolor, 95, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
      -- 4-8 的右边
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 1702, 542, 0x000000 }, { 1701, 542, 0x423d73 },
          { 1702, 541, 0x000000 }, { 1701, 541, 0x42417b },
          { 1703, 543, 0x000000 }, { 1702, 543, 0x423d73 },
          { 1703, 544, 0x000000 }, { 1702, 544, 0x4a4173 },
        })
        return { basePoint[3], posandcolor, 95, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
      -- 6-8 的右边
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 1761, 786, 0x000000 }, { 1760, 786, 0x3a3563 },
          { 1761, 785, 0x000000 }, { 1760, 785, 0x3a355a },
          { 1762, 787, 0x000000 }, { 1761, 787, 0x3a355a },
          { 1762, 788, 0x000000 }, { 1761, 788, 0x3a315a },
        })
        return { basePoint[3], posandcolor, 95, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
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