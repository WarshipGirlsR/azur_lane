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
          { 1528, 364, 0x21283a }, { 1548, 364, 0x21283a },
          { 1560, 364, 0x21283a }, { 1576, 364, 0x29283a },
          { 1588, 365, 0x6371ad }, { 1575, 365, 0x6b71ad },
          { 1560, 365, 0x6371ad }, { 1544, 365, 0x6371ad },
        })
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
      -- 1-7的上边
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 1358, 364, 0x21283a }, { 1376, 364, 0x21283a },
          { 1386, 364, 0x21283a }, { 1400, 364, 0x21243a },
          { 1412, 365, 0x5a69a4 }, { 1394, 365, 0x52659c },
          { 1378, 365, 0x5a619c }, { 1361, 365, 0x525d9c },
        })
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
      -- 1-4的上边
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 767, 364, 0x192829 }, { 784, 364, 0x212d3a },
          { 804, 364, 0x29353a }, { 824, 364, 0x29353a },
          { 835, 365, 0x3a3563 }, { 815, 365, 0x3a3563 },
          { 798, 365, 0x31315a }, { 783, 365, 0x3a3563 },
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
          { 487, 888, 0x000000 }, { 501, 888, 0x000000 },
          { 514, 888, 0x000000 }, { 528, 888, 0x000000 },
          { 542, 887, 0x211c42 }, { 528, 887, 0x212042 },
          { 513, 887, 0x212042 }, { 495, 887, 0x29204a },
        })
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
      -- 5-3 的下面
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022 }
        local basePoint, posandcolor = transRelativePoint({
          { 893, 888, 0x000000 }, { 917, 888, 0x000000 },
          { 937, 888, 0x000000 }, { 957, 888, 0x000000 },
          { 974, 887, 0x29244a }, { 956, 887, 0x29204a },
          { 934, 887, 0x31244a }, { 913, 887, 0x312852 },
        })
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
      -- 5-5 的下面
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022 }
        local basePoint, posandcolor = transRelativePoint({
          { 1317, 888, 0x000000 }, { 1333, 888, 0x000000 },
          { 1346, 888, 0x000000 }, { 1359, 888, 0x000000 },
          { 1372, 887, 0x29244a }, { 1353, 887, 0x31244a },
          { 1335, 887, 0x312452 }, { 1312, 887, 0x29244a },
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