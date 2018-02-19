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
          { 700, 516, 0x314254 }, { 712, 516, 0x313e4c },
          { 728, 516, 0x394654 }, { 742, 516, 0x314654 },
          { 744, 517, 0x299ede }, { 728, 517, 0x299ede },
          { 712, 517, 0x299ede }, { 698, 517, 0x299ed6 },
        })
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
      -- 1-2的上边
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 875, 516, 0x213344 }, { 884, 516, 0x313b4c },
          { 897, 516, 0x213744 }, { 913, 516, 0x213344 },
          { 921, 517, 0x31aede }, { 911, 517, 0x31aede },
          { 897, 517, 0x31aede }, { 880, 517, 0x29b2d6 },
        })
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
      -- 1-3的上边
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 1042, 516, 0x4a454a }, { 1049, 516, 0x4a4542 },
          { 1058, 516, 0x4a4542 }, { 1067, 516, 0x31393a },
          { 1078, 517, 0x29a6de }, { 1067, 517, 0x31a6e6 },
          { 1058, 517, 0x29a6de }, { 1049, 517, 0x31a2de },
        })
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
      -- 1-4的上边
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 1193, 516, 0x213931 }, { 1202, 516, 0x294131 },
          { 1213, 516, 0x294131 }, { 1225, 516, 0x294131 },
          { 1231, 517, 0x31b6de }, { 1220, 517, 0x29b2d6 },
          { 1205, 517, 0x31b2de }, { 1196, 517, 0x31b2de },
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
          { 806, 885, 0x000000 }, { 849, 885, 0x000000 },
          { 891, 885, 0x000000 }, { 930, 885, 0x000000 },
          { 957, 884, 0x1965b5 }, { 916, 884, 0x1969bd },
          { 880, 884, 0x1969b5 }, { 841, 884, 0x1969b5 },
        })
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
      -- 6-6 的下面
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022 }
        local basePoint, posandcolor = transRelativePoint({
          { 1008, 886, 0x000000 }, { 1069, 886, 0x000000 },
          { 1115, 886, 0x000000 }, { 1151, 886, 0x000000 },
          { 1175, 885, 0x1959ad }, { 1140, 885, 0x1055ad },
          { 1102, 885, 0x1055ad }, { 1065, 885, 0x2155ad },
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
          { 653, 555, 0x000000 }, { 654, 555, 0x29a2de },
          { 653, 554, 0x000000 }, { 654, 554, 0x31a6de },
          { 652, 556, 0x000000 }, { 653, 556, 0x31a2de },
          { 652, 557, 0x000000 }, { 653, 557, 0x31a2de },
        })
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
      -- 6-1 的左边
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 611, 246, 0x010203 }, { 612, 246, 0x3197d2 },
          { 611, 245, 0x000000 }, { 612, 245, 0x3193c2 },
          { 610, 247, 0x000000 }, { 611, 247, 0x319ad6 },
          { 610, 248, 0x000000 }, { 611, 248, 0x3197d3 },
        })
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
    },
    -- 地图右边界
    rightLineList = {
      -- 5-8 的右边
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 1702, 545, 0x010203 }, { 1701, 545, 0x4275c5 },
          { 1702, 544, 0x000000 }, { 1701, 544, 0x3a75c5 },
          { 1703, 546, 0x000000 }, { 1702, 546, 0x3a79ce },
          { 1703, 547, 0x010203 }, { 1702, 547, 0x3a75c5 },
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