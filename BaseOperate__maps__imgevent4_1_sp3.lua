-- 存储图像信息，用于界面找色、找图。取代图片搜索，因为找色搜索的像素点更少
require 'TableLib'
local imgBase = require 'BaseOperate__maps__img'

local transRelativePoint = imgBase.transRelativePoint

return {
  transRelativePoint = transRelativePoint,
  -- 基本方法
  toPoint = imgBase.toPoint,
  -- 检测点是否在两个点围围成的区域里
  inArea = imgBase.inArea,
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
          { 861, 473, 0x080811 }, { 907, 473, 0x101010 },
          { 942, 473, 0x090808 }, { 965, 473, 0x211421 },
          { 994, 474, 0x524542 }, { 956, 474, 0x524542 },
          { 916, 474, 0x52454a }, { 886, 474, 0x4a454a },
        })
        return { basePoint[3], posandcolor, 95, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
      -- 1-3的上边
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 844, 231, 0x212d29 }, { 883, 231, 0x313531 },
          { 915, 231, 0x313931 }, { 943, 231, 0x313531 },
          { 966, 232, 0x524542 }, { 928, 232, 0x524542 },
          { 891, 232, 0x4a4542 }, { 862, 232, 0x4a454a },
        })
        return { basePoint[3], posandcolor, 95, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
      -- 1-8的上边
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 1703, 473, 0x191919 }, { 1743, 473, 0x191819 },
          { 1776, 473, 0x101419 }, { 1804, 473, 0x111519 },
          { 1825, 474, 0xce9663 }, { 1797, 474, 0xce8a5a },
          { 1756, 474, 0xc57d63 }, { 1718, 474, 0xad715a },
        })
        return { basePoint[3], posandcolor, 95, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
      -- 1-9的上边
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 1498, 446, 0x212029 }, { 1520, 446, 0x212021 },
          { 1550, 446, 0x212029 }, { 1593, 446, 0x191c19 },
          { 1618, 447, 0xd69e5a }, { 1587, 447, 0xd6a25a },
          { 1555, 447, 0xde9e63 }, { 1519, 447, 0xde9e63 },
        })
        return { basePoint[3], posandcolor, 95, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
      -- 1-9的上边
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 1501, 221, 0x293131 }, { 1526, 221, 0x212829 },
          { 1561, 221, 0x313131 }, { 1597, 221, 0x313531 },
          { 1617, 222, 0xd69e5a }, { 1575, 222, 0xd69a5a },
          { 1541, 222, 0xd69a5a }, { 1512, 222, 0xd69a63 },
        })
        return { basePoint[3], posandcolor, 95, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
      -- 1-5的上边
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 1191, 473, 0x212421 }, { 1227, 473, 0x212421 },
          { 1276, 473, 0x212021 }, { 1304, 473, 0x212021 },
          { 1318, 474, 0x635d5a }, { 1284, 474, 0x63595a },
          { 1234, 474, 0x5a514a }, { 1204, 474, 0x524d42 },
        })
        return { basePoint[3], posandcolor, 95, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
    },
    -- 地图下边界
    bottonLineList = {
      -- 8-2 的下面
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022 }
        local basePoint, posandcolor = transRelativePoint({
          { 570, 900, 0x000000 }, { 609, 900, 0x000000 },
          { 649, 900, 0x000000 }, { 682, 900, 0x000000 },
          { 725, 899, 0x423d42 }, { 677, 899, 0x423952 },
          { 640, 899, 0x423152 }, { 595, 899, 0x42395a },
        })
        return { basePoint[3], posandcolor, 95, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
      -- 8-7 的下面
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022 }
        local basePoint, posandcolor = transRelativePoint({
          { 1041, 903, 0x000000 }, { 1096, 903, 0x000000 },
          { 1138, 903, 0x000000 }, { 1175, 903, 0x000000 },
          { 1199, 902, 0x3a354a }, { 1160, 902, 0x3a3142 },
          { 1117, 902, 0x312d42 }, { 1075, 902, 0x312d42 },
        })
        return { basePoint[3], posandcolor, 95, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
    },
    -- 地图左边界
    leftLineList = {
      -- 2-1 的左边
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 479, 371, 0x000000 }, { 480, 371, 0x31393a },
          { 479, 370, 0x000000 }, { 480, 370, 0x3a3d42 },
          { 478, 372, 0x000000 }, { 479, 372, 0x313d3a },
          { 478, 373, 0x000000 }, { 479, 373, 0x3a413a },
        })
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
      -- 4-1 的左边
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 442, 608, 0x000000 }, { 443, 608, 0x3a3d3a },
          { 442, 607, 0x000000 }, { 443, 607, 0x424142 },
          { 441, 609, 0x000000 }, { 442, 609, 0x3a393a },
          { 441, 610, 0x000000 }, { 442, 610, 0x423d42 },
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
          { 1642, 456, 0x000000 }, { 1641, 456, 0xd6a263 },
          { 1642, 455, 0x000000 }, { 1641, 455, 0xd6a263 },
          { 1643, 457, 0x000000 }, { 1642, 457, 0xd69e5a },
          { 1643, 458, 0x000000 }, { 1642, 458, 0xdea263 },
        })
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
      -- 2-9 的右边
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 1653, 255, 0x000000 }, { 1652, 255, 0xce9a5a },
          { 1653, 254, 0x000000 }, { 1652, 254, 0xd69e63 },
          { 1654, 256, 0x000000 }, { 1653, 256, 0xd69e5a },
          { 1654, 257, 0x000000 }, { 1653, 257, 0xd69e63 },
        })
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
      -- 6-9 的右边
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 1622, 464, 0x000000 }, { 1621, 464, 0x4a494a },
          { 1622, 463, 0x000000 }, { 1621, 463, 0x4a494a },
          { 1623, 465, 0x000000 }, { 1622, 465, 0x42454a },
          { 1623, 466, 0x000000 }, { 1622, 466, 0x4a494a },
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