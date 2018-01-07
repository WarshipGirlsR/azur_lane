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
          { 1614, 451, 0x192431 }, { 1621, 451, 0x21283a },
          { 1632, 451, 0x192431 }, { 1643, 451, 0x212842 },
          { 1655, 452, 0x6b71ad }, { 1642, 452, 0x6b71b5 },
          { 1630, 452, 0x6b71b5 }, { 1620, 452, 0x6b71b5 },
        })
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
      -- 1-7的上边
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 1448, 451, 0x192431 }, { 1459, 451, 0x21283a },
          { 1473, 451, 0x21283a }, { 1487, 451, 0x21283a },
          { 1501, 452, 0x5a65a4 }, { 1485, 452, 0x5a619c },
          { 1473, 452, 0x5a619c }, { 1463, 452, 0x52619c },
        })
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
    },
    -- 地图下边界
    bottonLineList = {
      -- 6-2 的下面
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022 }
        local basePoint, posandcolor = transRelativePoint({
          { 666, 869, 0x000000 }, { 680, 869, 0x000000 },
          { 695, 869, 0x000000 }, { 707, 869, 0x000000 },
          { 719, 868, 0x29204a }, { 707, 868, 0x29204a },
          { 696, 868, 0x312452 }, { 675, 868, 0x29204a },
        })
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
      -- 6-6 的下面
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022 }
        local basePoint, posandcolor = transRelativePoint({
          { 1072, 880, 0x000000 }, { 1082, 880, 0x000000 },
          { 1092, 880, 0x000000 }, { 1110, 880, 0x000000 },
          { 1120, 879, 0x29244a }, { 1106, 879, 0x29244a },
          { 1096, 879, 0x292442 }, { 1088, 879, 0x292442 },
        })
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
    },
    -- 地图左边界
    leftLineList = {
      -- 5-5 的左边
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 472, 774, 0x000000 }, { 473, 774, 0x29204a },
          { 472, 773, 0x000000 }, { 473, 773, 0x292052 },
          { 471, 775, 0x000000 }, { 472, 775, 0x211c42 },
          { 471, 776, 0x000000 }, { 472, 776, 0x29204a },
        })
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
      -- 5-3 的左边
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 513, 497, 0x000000 }, { 514, 497, 0x292452 },
          { 513, 496, 0x000000 }, { 514, 496, 0x312852 },
          { 512, 498, 0x000000 }, { 513, 498, 0x292852 },
          { 512, 499, 0x000000 }, { 513, 499, 0x292852 },
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
          { 1600, 405, 0x000001 }, { 1599, 405, 0x6365ad },
          { 1600, 404, 0x000000 }, { 1599, 404, 0x6365ad },
          { 1601, 406, 0x000000 }, { 1600, 406, 0x6369b5 },
          { 1601, 407, 0x000000 }, { 1600, 407, 0x5a65ad },
        })
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
      -- 2-8 的右边
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 1621, 501, 0x000000 }, { 1620, 501, 0x5a559c },
          { 1621, 500, 0x000000 }, { 1620, 500, 0x6355a4 },
          { 1622, 502, 0x000000 }, { 1621, 502, 0x5a559c },
          { 1622, 503, 0x000000 }, { 1621, 503, 0x5a55a4 },
        })
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
      -- 3-8 的右边
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 1652, 643, 0x000000 }, { 1651, 643, 0x4a417b },
          { 1652, 642, 0x000000 }, { 1651, 642, 0x4a417b },
          { 1653, 644, 0x000000 }, { 1652, 644, 0x4a4184 },
          { 1653, 645, 0x000000 }, { 1652, 645, 0x4a3d7b },
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