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
      -- 1-6的上边
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 1368, 512, 0x29314a }, { 1387, 512, 0x212842 },
          { 1401, 512, 0x212d42 }, { 1417, 512, 0x212d42 },
          { 1431, 513, 0xc59a6b }, { 1410, 513, 0xbd9a6b },
          { 1395, 513, 0xce9e73 }, { 1376, 513, 0xce9e73 },
        })
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
    },
    -- 地图下边界
    bottonLineList = {
      -- 7-1 的下面
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022 }
        local basePoint, posandcolor = transRelativePoint({
          { 490, 936, 0x000000 }, { 514, 936, 0x000000 },
          { 545, 936, 0x000000 }, { 568, 936, 0x000000 },
          { 576, 935, 0x31315a }, { 555, 935, 0x423963 },
          { 536, 935, 0x313563 }, { 504, 935, 0x3a3563 },
        })
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
      -- 7-8 的下面
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022 }
        local basePoint, posandcolor = transRelativePoint({
          { 1560, 910, 0x000000 }, { 1589, 910, 0x000000 },
          { 1615, 910, 0x000000 }, { 1643, 910, 0x000000 },
          { 1659, 909, 0x734d5a }, { 1640, 909, 0x734d5a },
          { 1609, 909, 0x6b415a }, { 1583, 909, 0x5a4152 },
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
      -- 3-1 的左边
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 287, 876, 0x000000 }, { 288, 876, 0x524d8c },
          { 287, 875, 0x000000 }, { 288, 875, 0x4a4984 },
          { 286, 877, 0x000000 }, { 287, 877, 0x4a4d84 },
          { 286, 878, 0x000000 }, { 287, 878, 0x4a4d84 },
        })
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
      -- 4-1 的左边
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 275, 931, 0x000000 }, { 276, 931, 0x4a4984 },
          { 275, 930, 0x000000 }, { 276, 930, 0x4a4d84 },
          { 274, 932, 0x000000 }, { 275, 932, 0x4a4984 },
          { 274, 933, 0x000000 }, { 275, 933, 0x4a4d84 },
        })
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
      -- 7-1 的左边
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 458, 875, 0x000000 }, { 459, 875, 0x4a4173 },
          { 458, 874, 0x000000 }, { 459, 874, 0x423d73 },
          { 457, 876, 0x000000 }, { 458, 876, 0x4a3d73 },
          { 457, 877, 0x000000 }, { 458, 877, 0x42396b },
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
          { 1606, 380, 0x000000 }, { 1605, 380, 0xbd866b },
          { 1606, 379, 0x000000 }, { 1605, 379, 0xbd8a6b },
          { 1607, 381, 0x000000 }, { 1606, 381, 0xbd7d63 },
          { 1607, 382, 0x000000 }, { 1606, 382, 0xbd866b },
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