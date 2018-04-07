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
          { 470, 538, 0x101442 }, { 480, 538, 0x191431 },
          { 490, 538, 0x101442 }, { 501, 538, 0x081029 },
          { 514, 539, 0x423994 }, { 501, 539, 0x3a398c },
          { 492, 539, 0x3a398c }, { 480, 539, 0x3a398c },
        })
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
      -- 1-2的上边
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 593, 538, 0x191c52 }, { 602, 538, 0x21245a },
          { 608, 538, 0x21355a }, { 617, 538, 0x213152 },
          { 627, 539, 0x423994 }, { 619, 539, 0x3a3584 },
          { 612, 539, 0x3a357b }, { 606, 539, 0x3a3184 },
        })
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
      -- 1-6的上边
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 1184, 538, 0x191431 }, { 1194, 538, 0x212042 },
          { 1204, 538, 0x21284a }, { 1212, 538, 0x21244a },
          { 1222, 539, 0x3a398c }, { 1215, 539, 0x423994 },
          { 1205, 539, 0x42398c }, { 1192, 539, 0x3a3584 },
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
          { 581, 904, 0x000000 }, { 594, 904, 0x000000 },
          { 603, 904, 0x000000 }, { 619, 904, 0x000000 },
          { 635, 903, 0x3a3184 }, { 624, 903, 0x3a317b },
          { 610, 903, 0x3a3184 }, { 591, 903, 0x423584 },
        })
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
      -- 5-2 的下面
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022 }
        local basePoint, posandcolor = transRelativePoint({
          { 793, 904, 0x000000 }, { 800, 904, 0x000000 },
          { 811, 904, 0x000000 }, { 829, 904, 0x000000 },
          { 839, 903, 0x3a317b }, { 829, 903, 0x3a3584 },
          { 814, 903, 0x3a317b }, { 792, 903, 0x3a357b },
        })
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
      -- 5-4 的下面
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022 }
        local basePoint, posandcolor = transRelativePoint({
          { 1348, 904, 0x000000 }, { 1362, 904, 0x000000 },
          { 1379, 904, 0x000000 }, { 1395, 904, 0x000000 },
          { 1409, 903, 0x3a3594 }, { 1392, 903, 0x3a358c },
          { 1377, 903, 0x3a358c }, { 1363, 903, 0x42358c },
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
          { 614, 323, 0x000000 }, { 615, 323, 0x3a3584 },
          { 614, 322, 0x000000 }, { 615, 322, 0x3a3584 },
          { 613, 324, 0x000000 }, { 614, 324, 0x3a3584 },
          { 613, 325, 0x000000 }, { 614, 325, 0x312d7b },
        })
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
      -- 2-1 的左边
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 604, 405, 0x000000 }, { 605, 405, 0x42398c },
          { 604, 404, 0x000000 }, { 605, 404, 0x3a3584 },
          { 603, 406, 0x000000 }, { 604, 406, 0x3a3584 },
          { 603, 407, 0x000000 }, { 604, 407, 0x312d7b },
        })
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
      -- 5-1 的左边
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 549, 859, 0x000000 }, { 550, 859, 0x3a317b },
          { 549, 858, 0x000000 }, { 550, 858, 0x423984 },
          { 548, 860, 0x000000 }, { 549, 860, 0x3a317b },
          { 548, 861, 0x000000 }, { 549, 861, 0x3a317b },
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
          { 1653, 298, 0x000000 }, { 1652, 298, 0x5a51b5 },
          { 1653, 297, 0x000000 }, { 1652, 297, 0x6b59bd },
          { 1654, 299, 0x000000 }, { 1653, 299, 0x4a45ad },
          { 1654, 300, 0x000000 }, { 1653, 300, 0x5249ad },
        })
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
      -- 2-8 的右边
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 1694, 465, 0x000000 }, { 1693, 465, 0x6359bd },
          { 1694, 464, 0x000000 }, { 1693, 464, 0x6359bd },
          { 1695, 466, 0x000000 }, { 1694, 466, 0x5249ac },
          { 1695, 467, 0x000000 }, { 1694, 467, 0x5251b5 },
        })
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
      -- 4-8 的右边
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 1741, 656, 0x000000 }, { 1740, 656, 0x6b5dbd },
          { 1741, 655, 0x000000 }, { 1740, 655, 0x5a51b5 },
          { 1742, 657, 0x000000 }, { 1741, 657, 0x52499c },
          { 1742, 658, 0x000000 }, { 1741, 658, 0x524d9c },
        })
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
      -- 5-8 的右边
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 1780, 814, 0x000000 }, { 1779, 814, 0x634dad },
          { 1780, 813, 0x000000 }, { 1779, 813, 0x5a49a4 },
          { 1781, 815, 0x000000 }, { 1780, 815, 0x4a3d9c },
          { 1781, 816, 0x000000 }, { 1780, 816, 0x5241a4 },
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