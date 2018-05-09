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
      -- 1-8 的上边
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 1665, 473, 0x21313a }, { 1677, 473, 0x213542 },
          { 1685, 473, 0x213142 }, { 1693, 473, 0x212d42 },
          { 1697, 474, 0x6b75ad }, { 1687, 474, 0x6b75ad },
          { 1678, 474, 0x6b75b5 }, { 1671, 474, 0x6b6dad },
        })
        return { basePoint[3], posandcolor, 92, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
      -- 1-7 的上边
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 1489, 513, 0x191819 }, { 1499, 513, 0x192029 },
          { 1512, 513, 0x212429 }, { 1522, 513, 0x192429 },
          { 1533, 514, 0x5a699c }, { 1521, 514, 0x5a659c },
          { 1512, 514, 0x6369a4 }, { 1499, 514, 0x5a619c },
        })
        return { basePoint[3], posandcolor, 92, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
      -- 1-6 的上边
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 1218, 513, 0x101819 }, { 1229, 513, 0x191c29 },
          { 1244, 513, 0x191821 }, { 1259, 513, 0x192029 },
          { 1269, 514, 0x3a396b }, { 1257, 514, 0x3a396b },
          { 1240, 514, 0x3a3d6b }, { 1231, 514, 0x3a3d6b },
        })
        return { basePoint[3], posandcolor, 92, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
      -- 1-5 的上边
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 1066, 513, 0x191821 }, { 1078, 513, 0x101821 },
          { 1091, 513, 0x191c29 }, { 1107, 513, 0x191821 },
          { 1117, 514, 0x3a4173 }, { 1103, 514, 0x42457b },
          { 1094, 514, 0x42457b }, { 1083, 514, 0x424573 },
        })
        return { basePoint[3], posandcolor, 92, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
    },
    -- 地图下边界
    bottonLineList = {
      -- 6-3 的下面
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022 }
        local basePoint, posandcolor = transRelativePoint({
          { 1034, 884, 0x000000 }, { 1080, 884, 0x000000 },
          { 1140, 884, 0x000000 }, { 1183, 884, 0x000000 },
          { 1212, 883, 0x29244a }, { 1161, 883, 0x29244a },
          { 1117, 883, 0x29244a }, { 1075, 883, 0x31204a },
        })
        return { basePoint[3], posandcolor, 95, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
      -- 6-8 的下面
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022 }
        local basePoint, posandcolor = transRelativePoint({
          { 1486, 885, 0x000000 }, { 1546, 885, 0x000000 },
          { 1598, 885, 0x000000 }, { 1641, 885, 0x000000 },
          { 1669, 884, 0x3a315a }, { 1627, 884, 0x312d52 },
          { 1584, 884, 0x312d5a }, { 1543, 884, 0x31284a },
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
          { 1788, 746, 0x000000 }, { 1787, 746, 0x52498c },
          { 1788, 745, 0x000000 }, { 1787, 745, 0x52498c },
          { 1789, 747, 0x000000 }, { 1788, 747, 0x524584 },
          { 1789, 748, 0x000000 }, { 1788, 748, 0x5a498c },
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