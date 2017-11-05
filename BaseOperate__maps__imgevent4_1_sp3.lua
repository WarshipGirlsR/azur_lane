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
          { 1612, 516, 0x211c21 }, { 1628, 516, 0x211c21 },
          { 1647, 516, 0x191419 }, { 1667, 516, 0x191419 },
          { 1680, 517, 0xd69a5a }, { 1660, 517, 0xd69a5a },
          { 1638, 517, 0xd69a63 }, { 1619, 517, 0xd69a63 },
        })
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
      -- 1-9的上边
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 1442, 266, 0x292d31 }, { 1462, 266, 0x292d31 },
          { 1478, 266, 0x292d31 }, { 1492, 266, 0x292d31 },
          { 1504, 267, 0xd69e5a }, { 1483, 267, 0xd69e63 },
          { 1462, 267, 0xd69a5a }, { 1441, 267, 0xd69e63 },
        })
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
      -- 1-8的上边
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 1325, 266, 0x212421 }, { 1341, 266, 0x222521 },
          { 1357, 266, 0x222521 }, { 1374, 266, 0x2a2932 },
          { 1391, 267, 0xd69263 }, { 1368, 267, 0xbd8a5a },
          { 1349, 267, 0xc5865a }, { 1330, 267, 0xbd7d5a },
        })
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
      -- 1-4的上边
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 606, 266, 0x211c21 }, { 622, 266, 0x312d31 },
          { 641, 266, 0x212929 }, { 661, 266, 0x212829 },
          { 679, 267, 0x524542 }, { 659, 267, 0x524542 },
          { 643, 267, 0x5a4542 }, { 623, 267, 0x5a4542 },
        })
        return { basePoint[3], posandcolor, 95, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
      -- 1-3的上边
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 823, 266, 0x292931 }, { 838, 266, 0x313131 },
          { 851, 266, 0x292d31 }, { 872, 266, 0x313131 },
          { 887, 267, 0x524542 }, { 871, 267, 0x4a454a },
          { 851, 267, 0x4a454a }, { 830, 267, 0x424542 },
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
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
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
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
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