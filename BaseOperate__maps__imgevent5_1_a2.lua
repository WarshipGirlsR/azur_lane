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
      -- 1-3的上边
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 680, 530, 0x192031 }, { 692, 530, 0x212842 },
          { 712, 530, 0x211c21 }, { 731, 530, 0x523931 },
          { 739, 531, 0xa4657b }, { 720, 531, 0x9c6173 },
          { 700, 531, 0x9c657b }, { 680, 531, 0x9c617b },
        })
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
      -- 1-3的上边
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 989, 709, 0x313131 }, { 1017, 709, 0x312831 },
          { 1041, 709, 0x313142 }, { 1057, 709, 0x292431 },
          { 1065, 710, 0xa4697b }, { 1038, 710, 0xa46984 },
          { 1014, 710, 0xa4657b }, { 992, 710, 0xa4657b },
        })
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
      -- 1-2的上边
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 594, 530, 0x52413a }, { 609, 530, 0x292029 },
          { 623, 530, 0x3a2d29 }, { 640, 530, 0x5a3d31 },
          { 650, 531, 0xa46984 }, { 630, 531, 0x945d73 },
          { 613, 531, 0x9c657b }, { 591, 531, 0xa4697b },
        })
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
      -- 1-2的上边
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 838, 709, 0x4a3529 }, { 859, 709, 0x423931 },
          { 873, 709, 0x423131 }, { 889, 709, 0x424142 },
          { 902, 710, 0xa46984 }, { 876, 710, 0xa46984 },
          { 859, 710, 0x9c697b }, { 840, 710, 0xa46984 },
        })
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
      -- 1-1的上边
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 357, 530, 0x21283a }, { 377, 530, 0x21283a },
          { 398, 530, 0x292842 }, { 418, 530, 0x292842 },
          { 434, 531, 0x8c597b }, { 419, 531, 0x7b4d73 },
          { 401, 531, 0x734d73 }, { 374, 531, 0x634973 },
        })
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
      -- 1-7的上边
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 1469, 545, 0x292431 }, { 1491, 545, 0x312831 },
          { 1513, 545, 0x423542 }, { 1539, 545, 0x524142 },
          { 1550, 546, 0xce9e73 }, { 1522, 546, 0xce9e73 },
          { 1499, 546, 0xce9a6b }, { 1476, 546, 0xce9e73 },
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
          { 527, 915, 0x000000 }, { 547, 915, 0x000000 },
          { 572, 915, 0x000000 }, { 592, 915, 0x000000 },
          { 603, 914, 0x312d5a }, { 586, 914, 0x3a355a },
          { 567, 914, 0x3a315a }, { 551, 914, 0x3a315a },
        })
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
      -- 5-8 的下面
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022 }
        local basePoint, posandcolor = transRelativePoint({
          { 1432, 906, 0x000000 }, { 1456, 906, 0x000000 },
          { 1478, 906, 0x000000 }, { 1501, 906, 0x000000 },
          { 1514, 905, 0x734d5a }, { 1495, 905, 0x734d5a },
          { 1470, 905, 0x5a3d52 }, { 1444, 905, 0x5a3952 },
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
          { 536, 305, 0x000000 }, { 537, 305, 0x63518c },
          { 536, 304, 0x000000 }, { 537, 304, 0x635184 },
          { 535, 306, 0x000000 }, { 536, 306, 0x5a518c },
          { 535, 307, 0x000000 }, { 536, 307, 0x524d7b },
        })
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
      -- 2-1 的左边
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 294, 703, 0x000000 }, { 295, 703, 0x524d84 },
          { 294, 702, 0x000000 }, { 295, 702, 0x524d84 },
          { 293, 704, 0x000000 }, { 294, 704, 0x524d84 },
          { 293, 705, 0x000000 }, { 294, 705, 0x4a4d7b },
        })
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
      -- 4-1 的左边
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 480, 641, 0x000000 }, { 481, 641, 0x4a4083 },
          { 480, 640, 0x000000 }, { 481, 640, 0x4a407b },
          { 479, 642, 0x000000 }, { 480, 642, 0x4a4584 },
          { 479, 643, 0x000000 }, { 480, 643, 0x42417b },
        })
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
    },
    -- 地图右边界
    rightLineList = {
      -- 3-8 的右边
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 1514, 468, 0x000000 }, { 1513, 468, 0xbd8a6b },
          { 1514, 467, 0x000000 }, { 1513, 467, 0xbd866b },
          { 1515, 469, 0x000000 }, { 1514, 469, 0xbd8a6b },
          { 1515, 470, 0x000000 }, { 1514, 470, 0xc58a6b },
        })
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
      -- 5-8 的右边
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 1577, 776, 0x000000 }, { 1576, 776, 0x945d6b },
          { 1577, 775, 0x000000 }, { 1576, 775, 0x8c5963 },
          { 1578, 777, 0x000000 }, { 1577, 777, 0x945d6b },
          { 1578, 778, 0x000000 }, { 1577, 778, 0x945d6b },
        })
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
    },
    -- 我方舰队位置
    myFleetList = imgBase.map.myFleetList,
    -- 我放舰队被选中的舰队的绿色的选中箭头的位置
    selectedArrow = imgBase.map.selectedArrow,
    -- 敌方舰队位置
    enemyList = imgBase.map.enemyList,
    -- boss位置
    bossPointList = imgBase.map.bossPointList,
    -- 战斗中的位置
    inBattleList = imgBase.map.inBattleList,
  },
}