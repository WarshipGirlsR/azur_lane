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
      -- 1-4 上方
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 1064, 470, 0x4a494a }, { 1105, 470, 0x21313a },
          { 1153, 470, 0x192d42 }, { 1193, 470, 0x193142 },
          { 1210, 471, 0x31bede }, { 1162, 471, 0x29bade },
          { 1106, 471, 0x31b2de }, { 1076, 471, 0x29b6de },
        })
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
      -- 1-5 上方
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 1246, 470, 0x29394a }, { 1280, 470, 0x213952 },
          { 1327, 470, 0x21394a }, { 1358, 470, 0x29394a },
          { 1386, 471, 0x3abede }, { 1344, 471, 0x31c2d6 },
          { 1307, 471, 0x42d7de }, { 1268, 471, 0x31bed6 },
        })
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
    },
    -- 地图下边界
    bottonLineList = {
      -- 3-4 下方
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022 }
        local basePoint, posandcolor = transRelativePoint({
          { 1066, 887, 0x000000 }, { 1119, 887, 0x000000 },
          { 1159, 887, 0x000000 }, { 1200, 887, 0x000000 },
          { 1229, 886, 0x1055ad }, { 1171, 886, 0x104da4 },
          { 1134, 886, 0x1051ad }, { 1099, 886, 0x104da4 },
        })
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
    },
    -- 地图左边界
    leftLineList = {
      -- 3-1 左方
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022 }
        local basePoint, posandcolor = transRelativePoint({
          { 465, 824, 0x000000 }, { 466, 824, 0x2992c5 },
          { 465, 823, 0x000000 }, { 466, 823, 0x218ac5 },
          { 464, 825, 0x000000 }, { 465, 825, 0x218ec5 },
          { 464, 826, 0x000000 }, { 465, 826, 0x218ec5 },
        })
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
    },
    -- 地图右边界
    rightLineList = {
      -- 1-5 右方
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022 }
        local basePoint, posandcolor = transRelativePoint({
          { 1580, 501, 0x000000 }, { 1579, 501, 0x29a2de },
          { 1580, 500, 0x000000 }, { 1579, 500, 0x29a2de },
          { 1581, 502, 0x000000 }, { 1580, 502, 0x31a6de },
          { 1581, 503, 0x000000 }, { 1580, 503, 0x29a2de },
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
  },
}