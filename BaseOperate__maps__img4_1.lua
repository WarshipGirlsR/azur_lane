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
      -- 1-4的上边
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 1025, 490, 0x313129 }, { 1082, 490, 0x292431 },
          { 1120, 490, 0x212031 }, { 1144, 490, 0x212031 },
          { 1138, 491, 0xbd8a73 }, { 1099, 491, 0xb58173 },
          { 1063, 491, 0xb58173 }, { 1029, 491, 0xb58673 },
        })
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
      -- 1-5的上边
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 1176, 490, 0x212431 }, { 1209, 490, 0x212029 },
          { 1251, 490, 0x212031 }, { 1299, 490, 0x212031 },
          { 1317, 491, 0xce9e6b }, { 1290, 491, 0xc59a6b },
          { 1245, 491, 0xce9a73 }, { 1201, 491, 0xc59673 },
        })
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
      -- 1-6的上边
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 1344, 490, 0x312d31 }, { 1379, 490, 0x292831 },
          { 1418, 490, 0x31283a }, { 1465, 490, 0x313131 },
          { 1486, 491, 0xc59663 }, { 1438, 491, 0xce9a63 },
          { 1399, 491, 0xce9e63 }, { 1357, 491, 0xce9e6b },
        })
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
    },
    -- 地图下边界
    bottonLineList = {
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022 }
        local basePoint, posandcolor = transRelativePoint({
          { 449, 899, 0x000000 }, { 466, 899, 0x000000 },
          { 494, 899, 0x000000 }, { 527, 899, 0x000000 },
          { 547, 898, 0x312d52 }, { 518, 898, 0x3a2d5a },
          { 479, 898, 0x3a315a }, { 453, 898, 0x3a3563 },
        })
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
    },
    -- 地图左边界
    leftLineList = {
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 483, 288, 0x000001 }, { 484, 288, 0x5a518c },
          { 483, 287, 0x000000 }, { 484, 287, 0x524d84 },
          { 482, 289, 0x000000 }, { 483, 289, 0x525184 },
          { 482, 290, 0x000000 }, { 483, 290, 0x525184 },
        })
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
    },
    -- 地图右边界
    rightLineList = {
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 1586, 348, 0x010000 }, { 1585, 348, 0xb5816b },
          { 1586, 347, 0x000000 }, { 1585, 347, 0xb5866b },
          { 1587, 349, 0x000000 }, { 1586, 349, 0xad7d63 },
          { 1587, 350, 0x000000 }, { 1586, 350, 0xb5816b },
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