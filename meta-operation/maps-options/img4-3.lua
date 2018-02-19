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
      -- 1-7的上边
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 1484, 594, 0x212431 }, { 1490, 594, 0x292431 },
          { 1500, 594, 0x212431 }, { 1512, 594, 0x212429 },
          { 1522, 595, 0xce9a5a }, { 1511, 595, 0xce9e6b },
          { 1501, 595, 0xce9e63 }, { 1490, 595, 0xc59e63 },
        })
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
      -- 1-5的上边
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 1142, 594, 0x292431 }, { 1148, 594, 0x212431 },
          { 1155, 594, 0x212029 }, { 1160, 594, 0x212431 },
          { 1169, 595, 0xb58173 }, { 1161, 595, 0xb58173 },
          { 1152, 595, 0xb57d73 }, { 1143, 595, 0xb58173 },
        })
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
      -- 1-3的上边
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 767, 594, 0x292431 }, { 778, 594, 0x31283a },
          { 786, 594, 0x31283a }, { 795, 594, 0x292831 },
          { 804, 595, 0x9c6d7b }, { 795, 595, 0xa4697b },
          { 786, 595, 0xa4697b }, { 776, 595, 0x9c657b },
        })
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
    },
    -- 地图下边界
    bottonLineList = {
      -- 4-7的下边
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022 }
        local basePoint, posandcolor = transRelativePoint({
          {
            { 1591, 888, 0x000000 }, { 1598, 888, 0x000000 },
            { 1606, 888, 0x000000 }, { 1614, 888, 0x000000 },
            { 1622, 887, 0x73495a }, { 1613, 887, 0x6b455a },
            { 1606, 887, 0x623c52 }, { 1599, 887, 0x63415a },
          }
        })
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
    },
    -- 地图左边界
    leftLineList = {
      -- 2-1的左边
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 368, 791, 0x000000 }, { 369, 791, 0x524d8c },
          { 368, 790, 0x000000 }, { 369, 790, 0x524d84 },
          { 367, 792, 0x000000 }, { 368, 792, 0x524d8c },
          { 367, 793, 0x000000 }, { 368, 793, 0x524984 },
        })
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
    },
    -- 地图右边界
    rightLineList = {
      -- 1-7的右边
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 1639, 609, 0x000000 }, { 1638, 609, 0xbd9663 },
          { 1639, 608, 0x000000 }, { 1638, 608, 0xce9663 },
          { 1640, 610, 0x000000 }, { 1639, 610, 0xce9663 },
          { 1640, 611, 0x000000 }, { 1639, 611, 0xce966b },
        })
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
      -- 2-7的右边
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 1672, 761, 0x010100 }, { 1671, 761, 0xb58e73 },
          { 1672, 760, 0x000000 }, { 1671, 760, 0xb58e73 },
          { 1673, 762, 0x000000 }, { 1672, 762, 0xb58e73 },
          { 1673, 763, 0x000000 }, { 1672, 763, 0xb58a6b },
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