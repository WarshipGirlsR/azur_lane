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
      -- 1-9的上边
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 1526, 523, 0x000808 }, { 1535, 523, 0x080c19 },
          { 1543, 523, 0x080c19 }, { 1552, 523, 0x000808 },
          { 1561, 524, 0x636db5 }, { 1556, 524, 0x6b71b5 },
          { 1550, 524, 0x636db5 }, { 1544, 524, 0x6b71b5 },
        })
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
      -- 1-8的上边
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 1399, 523, 0x080c19 }, { 1408, 523, 0x000808 },
          { 1416, 523, 0x000808 }, { 1423, 523, 0x080c19 },
          { 1434, 524, 0x5a65a4 }, { 1425, 524, 0x5a619c },
          { 1418, 524, 0x5a619c }, { 1408, 524, 0x5a619c },
        })
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
      -- 1-4的上边
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 743, 523, 0x080c19 }, { 750, 523, 0x000808 },
          { 757, 523, 0x080c10 }, { 765, 523, 0x080c10 },
          { 775, 524, 0x312d5a }, { 769, 524, 0x3a2d63 },
          { 764, 524, 0x423563 }, { 757, 524, 0x313163 },
        })
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
    },
    -- 地图下边界
    bottonLineList = {
      -- 7-2 的下面
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022 }
        local basePoint, posandcolor = transRelativePoint({
          { 584, 896, 0x000000 }, { 591, 896, 0x000000 },
          { 598, 896, 0x000000 }, { 605, 896, 0x000000 },
          { 612, 895, 0x29204a }, { 607, 895, 0x31204a },
          { 599, 895, 0x312052 }, { 592, 895, 0x29204a },
        })
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
      -- 7-4 的下面
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022 }
        local basePoint, posandcolor = transRelativePoint({
          { 993, 896, 0x000000 }, { 1002, 896, 0x000000 },
          { 1010, 896, 0x000000 }, { 1019, 896, 0x000000 },
          { 1027, 895, 0x29244a }, { 1020, 895, 0x292042 },
          { 1012, 895, 0x292042 }, { 1004, 895, 0x292442 },
        })
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
      -- 7-6 的下面
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022 }
        local basePoint, posandcolor = transRelativePoint({
          { 963, 896, 0x000000 }, { 973, 896, 0x000000 },
          { 982, 896, 0x000000 }, { 990, 896, 0x000000 },
          { 1000, 895, 0x292442 }, { 991, 895, 0x31284a },
          { 983, 895, 0x31284a }, { 978, 895, 0x29284a },
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
          { 539, 404, 0x000000 }, { 540, 404, 0x42315a },
          { 539, 403, 0x000000 }, { 540, 403, 0x312d5a },
          { 538, 405, 0x000000 }, { 539, 405, 0x312d5a },
          { 538, 406, 0x000000 }, { 539, 406, 0x312d5a },
        })
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
      -- 3-1 的左边
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 493, 724, 0x000000 }, { 494, 724, 0x31285a },
          { 493, 723, 0x000000 }, { 494, 723, 0x312852 },
          { 492, 725, 0x000000 }, { 493, 725, 0x31285a },
          { 492, 726, 0x000000 }, { 493, 726, 0x312852 },
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
          { 1627, 426, 0x000000 }, { 1626, 426, 0x6b6db5 },
          { 1627, 425, 0x000000 }, { 1626, 425, 0x636dad },
          { 1628, 427, 0x000000 }, { 1627, 427, 0x636db5 },
          { 1628, 428, 0x000000 }, { 1627, 428, 0x636dad },
        })
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
      -- 2-9 的右边
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 1655, 549, 0x000000 }, { 1654, 549, 0x5a55a4 },
          { 1655, 548, 0x000000 }, { 1654, 548, 0x6359a4 },
          { 1656, 550, 0x000000 }, { 1655, 550, 0x5a59a4 },
          { 1656, 551, 0x000000 }, { 1655, 551, 0x6359a4 },
        })
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
      -- 3-9 的右边
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 1686, 686, 0x000000 }, { 1685, 686, 0x52498c },
          { 1686, 685, 0x000000 }, { 1685, 685, 0x524d8c },
          { 1687, 687, 0x000000 }, { 1686, 687, 0x52498c },
          { 1687, 688, 0x000000 }, { 1686, 688, 0x5a4d94 },
        })
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
      -- 5-9 的右边
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 1626, 520, 0x000000 }, { 1625, 520, 0x42396b },
          { 1626, 519, 0x000000 }, { 1625, 519, 0x423d6b },
          { 1627, 521, 0x000000 }, { 1626, 521, 0x3a396b },
          { 1627, 522, 0x000000 }, { 1626, 522, 0x4a4173 },
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