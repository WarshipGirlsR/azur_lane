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
          { 1539, 478, 0x191c29 }, { 1568, 478, 0x211c31 },
          { 1604, 478, 0x211c31 }, { 1649, 478, 0x191c29 },
          { 1669, 479, 0x6b71ad }, { 1641, 479, 0x6b71b5 },
          { 1602, 479, 0x636dad }, { 1562, 479, 0x6369ad },
        })
        return { basePoint[3], posandcolor, 95, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
      -- 1-4的上边
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 860, 478, 0x191829 }, { 892, 478, 0x191c29 },
          { 937, 478, 0x101421 }, { 972, 478, 0x191c29 },
          { 995, 479, 0x423d6b }, { 963, 479, 0x423963 },
          { 923, 479, 0x423563 }, { 892, 479, 0x31315a },
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
          { 860, 883, 0x000000 }, { 890, 883, 0x000000 },
          { 932, 883, 0x000000 }, { 974, 883, 0x000000 },
          { 1000, 882, 0x31244a }, { 961, 882, 0x29244a },
          { 924, 882, 0x312452 }, { 877, 882, 0x31244a },
        })
        return { basePoint[3], posandcolor, 95, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
      -- 5-8 的下面
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022 }
        local basePoint, posandcolor = transRelativePoint({
          { 1525, 886, 0x000000 }, { 1581, 886, 0x000000 },
          { 1630, 886, 0x000000 }, { 1682, 886, 0x000000 },
          { 1711, 885, 0x3a395a }, { 1664, 885, 0x312d52 },
          { 1623, 885, 0x313152 }, { 1579, 885, 0x31314a },
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