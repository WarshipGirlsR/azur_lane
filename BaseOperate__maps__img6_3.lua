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
          { 1529, 483, 0x212431 }, { 1575, 483, 0x212431 },
          { 1622, 483, 0x192029 }, { 1660, 483, 0x212d3a },
          { 1676, 484, 0x6b75b5 }, { 1649, 484, 0x6b71b5 },
          { 1606, 484, 0x6b71b5 }, { 1569, 484, 0x636db5 },
        })
        return { basePoint[3], posandcolor, 95, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
      -- 1-4的上边
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 523, 483, 0x212031 }, { 560, 483, 0x102029 },
          { 589, 483, 0x192031 }, { 629, 483, 0x192031 },
          { 648, 484, 0x3a3163 }, { 615, 484, 0x3a3163 },
          { 586, 484, 0x3a3163 }, { 542, 484, 0x3a3163 },
        })
        return { basePoint[3], posandcolor, 95, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
    },
    -- 地图下边界
    bottonLineList = {
      -- 5-3 的下面
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022 }
        local basePoint, posandcolor = transRelativePoint({
          { 561, 889, 0x000000 }, { 601, 889, 0x000000 },
          { 630, 889, 0x000000 }, { 673, 889, 0x000000 },
          { 690, 888, 0x31244a }, { 663, 888, 0x29244a },
          { 633, 888, 0x29244a }, { 604, 888, 0x312452 },
        })
        return { basePoint[3], posandcolor, 95, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
      -- 5-8 的下面
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022 }
        local basePoint, posandcolor = transRelativePoint({
          { 1597, 889, 0x000000 }, { 1645, 889, 0x000000 },
          { 1683, 889, 0x000000 }, { 1719, 889, 0x000000 },
          { 1753, 888, 0x3a315a }, { 1718, 888, 0x3a315a },
          { 1676, 888, 0x312d52 }, { 1635, 888, 0x31284a },
        })
        return { basePoint[3], posandcolor, 95, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
    },
    -- 地图左边界
    leftLineList = {
      -- 1-1 的左边
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 326, 509, 0x000000 }, { 327, 509, 0x31315a },
          { 326, 508, 0x000000 }, { 327, 508, 0x31285a },
          { 325, 510, 0x000000 }, { 326, 510, 0x312d5a },
          { 325, 511, 0x000000 }, { 326, 511, 0x31285a },
        })
        return { basePoint[3], posandcolor, 95, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
      -- 4-1 的左边
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 482, 532, 0x000000 }, { 483, 532, 0x29244a },
          { 482, 531, 0x000000 }, { 483, 531, 0x29244a },
          { 481, 533, 0x000000 }, { 482, 533, 0x29204a },
          { 481, 534, 0x000000 }, { 482, 534, 0x312452 },
        })
        return { basePoint[3], posandcolor, 95, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
      -- 6-1 的左边
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 435, 832, 0x000000 }, { 436, 832, 0x29204a },
          { 435, 831, 0x000000 }, { 436, 831, 0x211c42 },
          { 434, 833, 0x000000 }, { 435, 833, 0x212042 },
          { 434, 834, 0x000000 }, { 435, 834, 0x212042 },
        })
        return { basePoint[3], posandcolor, 95, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
    },
    -- 地图右边界
    rightLineList = {
      -- 1-8 的右边
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 1695, 524, 0x000000 }, { 1694, 524, 0x6369b5 },
          { 1695, 523, 0x000000 }, { 1694, 523, 0x6365ad },
          { 1696, 525, 0x000000 }, { 1695, 525, 0x6365ad },
          { 1696, 526, 0x000000 }, { 1695, 526, 0x6365ad },
        })
        return { basePoint[3], posandcolor, 95, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
      -- 3-8 的右边
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 1546, 320, 0x000000 }, { 1545, 320, 0x4a417b },
          { 1546, 319, 0x000000 }, { 1545, 319, 0x4a417b },
          { 1547, 321, 0x000000 }, { 1546, 321, 0x423d7b },
          { 1547, 322, 0x000000 }, { 1546, 322, 0x4a4184 },
        })
        return { basePoint[3], posandcolor, 95, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
      -- 6-8 的右边
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 1663, 729, 0x000000 }, { 1662, 729, 0x31355a },
          { 1663, 728, 0x000000 }, { 1662, 728, 0x3a3563 },
          { 1664, 730, 0x000000 }, { 1663, 730, 0x3a355a },
          { 1664, 731, 0x000000 }, { 1663, 731, 0x423963 },
        })
        return { basePoint[3], posandcolor, 95, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
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