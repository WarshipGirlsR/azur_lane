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
          { 1509, 501, 0x312829 }, { 1517, 501, 0x312829 },
          { 1525, 501, 0x322929 }, { 1533, 501, 0x322929 },
          { 1539, 502, 0xce9a6b }, { 1533, 502, 0xce9a63 },
          { 1526, 502, 0xce9e63 }, { 1520, 502, 0xce9e63 },
        })
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
      -- 1-7的上边
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 1336, 501, 0x292421 }, { 1347, 501, 0x312429 },
          { 1354, 501, 0x292421 }, { 1361, 501, 0x312429 },
          { 1371, 502, 0xce9a6b }, { 1363, 502, 0xce9a73 },
          { 1354, 502, 0xce9e73 }, { 1347, 502, 0xce9e73 },
        })
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
    },
    -- 地图下边界
    bottonLineList = {
      -- 6-8的下边
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022 }
        local basePoint, posandcolor = transRelativePoint({
          { 1656, 894, 0x000000 }, { 1664, 894, 0x000000 },
          { 1674, 894, 0x000000 }, { 1683, 894, 0x000000 },
          { 1691, 893, 0x734d5a }, { 1682, 893, 0x73495a },
          { 1673, 893, 0x734962 }, { 1663, 893, 0x734d63 },
        })
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
      -- 6-5的下边
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022 }
        local basePoint, posandcolor = transRelativePoint({
          { 912, 894, 0x000000 }, { 919, 894, 0x000000 },
          { 926, 894, 0x000000 }, { 932, 894, 0x000000 },
          { 938, 893, 0x29203a }, { 927, 893, 0x312442 },
          { 917, 893, 0x312442 }, { 907, 893, 0x312442 },
        })
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
      -- 6-1的下边
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022 }
        local basePoint, posandcolor = transRelativePoint({
          { 512, 893, 0x000000 }, { 520, 893, 0x000000 },
          { 530, 893, 0x000000 }, { 538, 893, 0x000000 },
          { 545, 892, 0x3a356b }, { 537, 892, 0x3a356b },
          { 528, 892, 0x3a396b }, { 521, 892, 0x3a396b },
        })
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
    },
    -- 地图左边界
    leftLineList = {
      -- 4-1的左边
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 534, 511, 0x000000 }, { 535, 511, 0x524584 },
          { 534, 510, 0x000000 }, { 535, 510, 0x524584 },
          { 533, 512, 0x000000 }, { 534, 512, 0x5a4584 },
          { 533, 513, 0x000000 }, { 534, 513, 0x524584 },
        })
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
      -- 6-1的左边
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 486, 854, 0x000000 }, { 487, 854, 0x423973 },
          { 486, 853, 0x000000 }, { 487, 853, 0x424173 },
          { 485, 855, 0x000000 }, { 486, 855, 0x42396b },
          { 485, 856, 0x000000 }, { 486, 856, 0x423d73 },
        })
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
    },
    -- 地图右边界
    rightLineList = {
      -- 1-8的右边
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 1648, 529, 0x000000 }, { 1647, 529, 0xce9663 },
          { 1648, 528, 0x000000 }, { 1647, 528, 0xc59663 },
          { 1649, 530, 0x000000 }, { 1648, 530, 0xce9663 },
          { 1649, 531, 0x000000 }, { 1648, 531, 0xbd9663 },
        })
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
      -- 2-8的右边
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 1675, 649, 0x000000 }, { 1674, 649, 0xbd8a63 },
          { 1675, 648, 0x000000 }, { 1674, 648, 0xc58a6b },
          { 1676, 650, 0x000000 }, { 1675, 650, 0xbd8a6b },
          { 1676, 651, 0x000000 }, { 1675, 651, 0xbd8a6b },
        })
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
      -- 6-8的右边
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 1731, 788, 0x000000 }, { 1730, 788, 0x84556b },
          { 1731, 787, 0x000000 }, { 1730, 787, 0x845563 },
          { 1732, 789, 0x000000 }, { 1731, 789, 0x845563 },
          { 1732, 790, 0x000400 }, { 1731, 790, 0x845563 },
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