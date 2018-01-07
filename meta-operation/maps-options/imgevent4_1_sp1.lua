-- 存储图像信息，用于界面找色、找图。取代图片搜索，因为找色搜索的像素点更少
require 'TableLib'
local imgBase = require 'BaseOperate__maps__img'

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
          { 1539, 478, 0x101010 }, { 1557, 478, 0x212021 },
          { 1585, 478, 0x212829 }, { 1609, 478, 0x212429 },
          { 1620, 479, 0xd69a5a }, { 1596, 479, 0xd69a63 },
          { 1576, 479, 0xd69663 }, { 1558, 479, 0xce965a },
        })
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
      -- 1-7的上边
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 1384, 478, 0x313131 }, { 1407, 478, 0x313531 },
          { 1423, 478, 0x313131 }, { 1444, 478, 0x313131 },
          { 1457, 479, 0xad7552 }, { 1430, 479, 0x9c6952 },
          { 1405, 479, 0x8c6552 }, { 1384, 479, 0x84614a },
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
          { 451, 899, 0x000000 }, { 468, 899, 0x000000 },
          { 485, 899, 0x000000 }, { 509, 899, 0x000000 },
          { 521, 898, 0x42394a }, { 500, 898, 0x4a355a },
          { 479, 898, 0x423552 }, { 455, 898, 0x4a356b },
        })
        return { basePoint[3], posandcolor, 95, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
      -- 5-4 的下面
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022 }
        local basePoint, posandcolor = transRelativePoint({
          { 1109, 899, 0x000000 }, { 1132, 899, 0x000000 },
          { 1156, 899, 0x000000 }, { 1174, 899, 0x000000 },
          { 1185, 898, 0x313142 }, { 1162, 898, 0x313542 },
          { 1137, 898, 0x313142 }, { 1116, 898, 0x313142 },
        })
        return { basePoint[3], posandcolor, 95, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
      -- 7-6 的下面
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022 }
        local basePoint, posandcolor = transRelativePoint({
          { 1002, 903, 0x000000 }, { 1032, 903, 0x000000 },
          { 1063, 903, 0x000000 }, { 1092, 903, 0x000000 },
          { 1111, 902, 0x312d42 }, { 1090, 902, 0x3a354a },
          { 1069, 902, 0x313542 }, { 1042, 902, 0x3a3142 },
        })
        return { basePoint[3], posandcolor, 95, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
      -- 7-8 的下面
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022 }
        local basePoint, posandcolor = transRelativePoint({
          { 1440, 903, 0x000000 }, { 1458, 903, 0x000000 },
          { 1476, 903, 0x000000 }, { 1509, 903, 0x000000 },
          { 1527, 902, 0x634552 }, { 1501, 902, 0x524152 },
          { 1479, 902, 0x524152 }, { 1458, 902, 0x524552 },
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
          { 293, 508, 0x000000 }, { 294, 508, 0x424142 },
          { 293, 507, 0x000000 }, { 294, 507, 0x3a3d42 },
          { 292, 509, 0x000000 }, { 293, 509, 0x424142 },
          { 292, 510, 0x000000 }, { 293, 510, 0x3a3d42 },
        })
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
      -- 4-1 的左边
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 458, 654, 0x000000 }, { 459, 654, 0x3a3531 },
          { 458, 653, 0x000000 }, { 459, 653, 0x3a3931 },
          { 457, 655, 0x000000 }, { 458, 655, 0x3a3531 },
          { 457, 656, 0x000000 }, { 458, 656, 0x423531 },
        })
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
      -- 5-1 的左边
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 439, 774, 0x000000 }, { 440, 774, 0x423531 },
          { 439, 773, 0x000000 }, { 440, 773, 0x3a3131 },
          { 438, 775, 0x000000 }, { 439, 775, 0x423931 },
          { 438, 776, 0x000000 }, { 439, 776, 0x3a3131 },
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
          { 1512, 231, 0x010100 }, { 1511, 231, 0xd69e63 },
          { 1512, 230, 0x000000 }, { 1511, 230, 0xd69e5a },
          { 1513, 232, 0x000000 }, { 1512, 232, 0xd69e63 },
          { 1513, 233, 0x000000 }, { 1512, 233, 0xd69a5a },
        })
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
      -- 2-8 的右边
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 1541, 376, 0x000000 }, { 1540, 376, 0xb5795a },
          { 1541, 375, 0x000000 }, { 1540, 375, 0xad7552 },
          { 1542, 377, 0x000000 }, { 1541, 377, 0xb5755a },
          { 1542, 378, 0x000000 }, { 1541, 378, 0xad755a },
        })
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
      -- 4-8 的右边
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 1562, 480, 0x000000 }, { 1561, 480, 0x73594a },
          { 1562, 479, 0x000000 }, { 1561, 479, 0x735952 },
          { 1563, 481, 0x000000 }, { 1562, 481, 0x73594a },
          { 1563, 482, 0x000000 }, { 1562, 482, 0x7b5d52 },
        })
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
      -- 5-8 的右边
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 1619, 764, 0x000000 }, { 1618, 764, 0x4a4142 },
          { 1619, 763, 0x000000 }, { 1618, 763, 0x423d3a },
          { 1620, 765, 0x000000 }, { 1619, 765, 0x424142 },
          { 1620, 766, 0x000000 }, { 1619, 766, 0x423d3a },
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