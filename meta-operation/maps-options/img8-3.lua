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
          { 1558, 509, 0x192031 }, { 1565, 509, 0x212442 },
          { 1576, 509, 0x212031 }, { 1588, 509, 0x191c31 },
          { 1598, 510, 0x3abee6 }, { 1586, 510, 0x3ac2e6 },
          { 1570, 510, 0x31c2de }, { 1559, 510, 0x31bede },
        })
        return { basePoint[3], posandcolor, 92, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
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
        return { basePoint[3], posandcolor, 92, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
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
        return { basePoint[3], posandcolor, 92, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
      -- 1-1的上边
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 395, 523, 0x3a353a }, { 408, 523, 0x292829 },
          { 417, 523, 0x312d31 }, { 426, 523, 0x292829 },
          { 438, 524, 0x31a2e6 }, { 428, 524, 0x319ee6 },
          { 418, 524, 0x319ee6 }, { 408, 524, 0x319ee6 },
        })
        return { basePoint[3], posandcolor, 92, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
      -- 1-2的上边
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 554, 523, 0x292829 }, { 567, 523, 0x312d31 },
          { 581, 523, 0x312d31 }, { 592, 523, 0x292829 },
          { 601, 524, 0x31aede }, { 588, 524, 0x31aee6 },
          { 577, 524, 0x31b2e6 }, { 566, 524, 0x31b2de },
        })
        return { basePoint[3], posandcolor, 92, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
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