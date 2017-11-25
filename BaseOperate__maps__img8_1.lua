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
          { 1558, 509, 0x192031 }, { 1565, 509, 0x212442 },
          { 1576, 509, 0x212031 }, { 1588, 509, 0x191c31 },
          { 1598, 510, 0x3abee6 }, { 1586, 510, 0x3ac2e6 },
          { 1570, 510, 0x31c2de }, { 1559, 510, 0x31bede },
        })
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
      -- 1-7的上边
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 1390, 509, 0x192031 }, { 1405, 509, 0x212442 },
          { 1421, 509, 0x212442 }, { 1435, 509, 0x212431 },
          { 1448, 510, 0x3acade }, { 1428, 510, 0x3acade },
          { 1413, 510, 0x3ac6d6 }, { 1396, 510, 0x42dbe6 },
        })
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
      -- 1-4的上边
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 898, 509, 0x101c31 }, { 918, 509, 0x191c31 },
          { 935, 509, 0x19203a }, { 950, 509, 0x191c31 },
          { 959, 510, 0x31b6de }, { 938, 510, 0x3ab6e6 },
          { 924, 510, 0x31b2de }, { 909, 510, 0x31b2de },
        })
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
    },
    -- 地图下边界
    bottonLineList = {
      -- 3-1 的下面
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022 }
        local basePoint, posandcolor = transRelativePoint({
          { 506, 881, 0x000000 }, { 516, 881, 0x000000 },
          { 525, 881, 0x000000 }, { 538, 881, 0x000000 },
          { 548, 880, 0x2181c5 }, { 537, 880, 0x217dc5 },
          { 527, 880, 0x217dbd }, { 517, 880, 0x2181c5 },
        })
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
      -- 3-4 的下面
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022 }
        local basePoint, posandcolor = transRelativePoint({
          { 1327, 881, 0x000000 }, { 1341, 881, 0x000000 },
          { 1350, 881, 0x000000 }, { 1361, 881, 0x000000 },
          { 1371, 880, 0x10519c }, { 1358, 880, 0x1055a4 },
          { 1348, 880, 0x1055ad }, { 1338, 880, 0x1955ad },
        })
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
      -- 3-5 的下面
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022 }
        local basePoint, posandcolor = transRelativePoint({
          { 976, 896, 0x000001 }, { 991, 896, 0x000001 },
          { 1001, 896, 0x000000 }, { 1012, 896, 0x000001 },
          { 1027, 895, 0x1051a4 }, { 1014, 895, 0x1049a4 },
          { 1002, 895, 0x1049a4 }, { 987, 895, 0x1051a4 },
          { 979, 895, 0x1051a4 },
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
          { 529, 531, 0x000000 }, { 530, 531, 0x31a6d6 },
          { 529, 530, 0x000000 }, { 530, 530, 0x31aee6 },
          { 528, 532, 0x080408 }, { 529, 532, 0x31aede },
          { 528, 533, 0x000000 }, { 529, 533, 0x31aede },
        })
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
      -- 2-1 的左边
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 512, 652, 0x080509 }, { 513, 652, 0x29aace },
          { 512, 651, 0x000101 }, { 513, 651, 0x29aad6 },
          { 511, 653, 0x000000 }, { 512, 653, 0x29aace },
          { 511, 654, 0x000000 }, { 512, 654, 0x29aed6 },
        })
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
      -- 3-1 的左边
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 494, 779, 0x000000 }, { 495, 779, 0x2992ce },
          { 494, 778, 0x000000 }, { 495, 778, 0x2192c5 },
          { 493, 780, 0x000000 }, { 494, 780, 0x3192ce },
          { 493, 781, 0x000000 }, { 494, 781, 0x298ec5 },
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
          { 1676, 594, 0x000000 }, { 1675, 594, 0x29b9dd },
          { 1676, 593, 0x000000 }, { 1675, 593, 0x29b9e5 },
          { 1677, 595, 0x000000 }, { 1676, 595, 0x29b5dd },
          { 1677, 596, 0x000000 }, { 1676, 596, 0x31bae6 },
        })
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
      -- 2-9 的右边
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 1690, 655, 0x000000 }, { 1689, 655, 0x31b2de },
          { 1690, 654, 0x000000 }, { 1689, 654, 0x29aed6 },
          { 1691, 656, 0x000000 }, { 1690, 656, 0x31b1dd },
          { 1691, 657, 0x000000 }, { 1690, 657, 0x29aede },
        })
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
      -- 3-9 的右边
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 1730, 829, 0x000000 }, { 1729, 829, 0x4275c5 },
          { 1730, 828, 0x000000 }, { 1729, 828, 0x4275c5 },
          { 1731, 830, 0x000000 }, { 1730, 830, 0x4a79ce },
          { 1731, 831, 0x000000 }, { 1730, 831, 0x4275c5 },
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