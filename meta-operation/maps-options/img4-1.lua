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
      -- 1-4的上边
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 1025, 490, 0x313129 }, { 1082, 490, 0x292431 },
          { 1120, 490, 0x212031 }, { 1144, 490, 0x212031 },
          { 1138, 491, 0xbd8a73 }, { 1099, 491, 0xb58173 },
          { 1063, 491, 0xb58173 }, { 1029, 491, 0xb58673 },
        })
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
      -- 1-5的上边
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 1176, 490, 0x212431 }, { 1209, 490, 0x212029 },
          { 1251, 490, 0x212031 }, { 1299, 490, 0x212031 },
          { 1317, 491, 0xce9e6b }, { 1290, 491, 0xc59a6b },
          { 1245, 491, 0xce9a73 }, { 1201, 491, 0xc59673 },
        })
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
      -- 1-6的上边
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 1309, 488, 0x312829 }, { 1319, 488, 0x292829 },
          { 1328, 488, 0x422831 }, { 1337, 488, 0x312831 },
          { 1347, 489, 0xce9e63 }, { 1338, 489, 0xc59e5a },
          { 1329, 489, 0xce9e6b }, { 1320, 489, 0xc59a6b },
        })
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
    },
    -- 地图下边界
    bottonLineList = {
      -- 6-6的下边
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022 }
        local basePoint, posandcolor = transRelativePoint({
          { 1584, 889, 0x000000 }, { 1597, 889, 0x000000 },
          { 1608, 889, 0x000000 }, { 1617, 889, 0x000000 },
          { 1628, 888, 0x63415a }, { 1617, 888, 0x634152 },
          { 1606, 888, 0x63415a }, { 1598, 888, 0x63415a },
        })
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
    },
    -- 地图左边界
    leftLineList = {
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 483, 288, 0x000001 }, { 484, 288, 0x5a518c },
          { 483, 287, 0x000000 }, { 484, 287, 0x524d84 },
          { 482, 289, 0x000000 }, { 483, 289, 0x525184 },
          { 482, 290, 0x000000 }, { 483, 290, 0x525184 },
        })
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
    },
    -- 地图右边界
    rightLineList = {
      -- 1-6的右边
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 1477, 546, 0x000000 }, { 1476, 546, 0xce8e63 },
          { 1477, 545, 0x000000 }, { 1476, 545, 0xc58a63 },
          { 1478, 547, 0x000000 }, { 1477, 547, 0xce8e63 },
          { 1478, 548, 0x000000 }, { 1477, 548, 0xce8e63 },
        })
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
      -- 3-6的右边
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 1519, 796, 0x000000 }, { 1518, 796, 0xb5816b },
          { 1519, 795, 0x000000 }, { 1518, 795, 0xad7963 },
          { 1520, 797, 0x000000 }, { 1519, 797, 0xb58163 },
          { 1520, 798, 0x000400 }, { 1519, 798, 0xb57d63 },
        })
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
      -- 5-6的右边
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 1662, 609, 0x000000 }, { 1661, 609, 0x9c6163 },
          { 1662, 608, 0x000000 }, { 1661, 608, 0x9c6163 },
          { 1663, 610, 0x000000 }, { 1662, 610, 0xa4616b },
          { 1663, 611, 0x000000 }, { 1662, 611, 0x9c5d63 },
        })
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
      -- 6-6的右边
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 1696, 760, 0x000000 }, { 1695, 760, 0x8c5963 },
          { 1696, 759, 0x000000 }, { 1695, 759, 0x8c5963 },
          { 1697, 761, 0x000000 }, { 1696, 761, 0x845563 },
          { 1697, 762, 0x000000 }, { 1696, 762, 0x8c5963 },
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