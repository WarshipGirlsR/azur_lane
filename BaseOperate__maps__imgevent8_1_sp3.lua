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
      -- 1-6的上边
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 1257, 516, 0x080c19 }, { 1271, 516, 0x080c19 },
          { 1282, 516, 0x101019 }, { 1294, 516, 0x101019 },
          { 1309, 517, 0x424573 }, { 1298, 517, 0x3a4573 },
          { 1287, 517, 0x424d7b }, { 1277, 517, 0x424573 },
        })
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
      -- 1-7的上边
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 1420, 516, 0x101421 }, { 1431, 516, 0x081019 },
          { 1441, 516, 0x081019 }, { 1452, 516, 0x101421 },
          { 1461, 517, 0x3a3d6b }, { 1452, 517, 0x31396b },
          { 1443, 517, 0x3a396b }, { 1432, 517, 0x31396b },
        })
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
      -- 1-8的上边
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 1148, 514, 0x101019 }, { 1159, 514, 0x080c10 },
          { 1168, 514, 0x101019 }, { 1177, 514, 0x080c10 },
          { 1185, 515, 0x424573 }, { 1178, 515, 0x3a4573 },
          { 1169, 515, 0x42497b }, { 1160, 515, 0x3a4573 },
        })
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
    },
    -- 地图下边界
    bottonLineList = {
      -- 7-2 的下面
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022 }
        local basePoint, posandcolor = transRelativePoint({
          { 548, 897, 0x000000 }, { 555, 897, 0x000000 },
          { 562, 897, 0x000000 }, { 569, 897, 0x000000 },
          { 575, 896, 0x29204a }, { 569, 896, 0x29204a },
          { 562, 896, 0x312052 }, { 555, 896, 0x29204a },
        })
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
      -- 7-4 的下面
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022 }
        local basePoint, posandcolor = transRelativePoint({
          { 958, 897, 0x000000 }, { 964, 897, 0x000000 },
          { 969, 897, 0x000000 }, { 974, 897, 0x000000 },
          { 981, 896, 0x29204a }, { 975, 896, 0x29204a },
          { 968, 896, 0x312452 }, { 961, 896, 0x29204a },
        })
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
      -- 7-6 的下面
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022 }
        local basePoint, posandcolor = transRelativePoint({
          { 963, 896, 0x000000 }, { 973, 896, 0x000000 },
          { 982, 896, 0x000000 }, { 990, 896, 0x000000 },
          { 1000, 895, 0x292442 }, { 991, 895, 0x31284a },
          { 983, 895, 0x31284a }, { 978, 895, 0x29284a },
        })
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
    },
    -- 地图左边界
    leftLineList = {
      -- 3-1 的左边
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 343, 639, 0x000000 }, { 344, 639, 0x292d52 },
          { 343, 638, 0x000000 }, { 344, 638, 0x31315a },
          { 342, 640, 0x000000 }, { 343, 640, 0x312d52 },
          { 342, 641, 0x000000 }, { 343, 641, 0x312d52 },
        })
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
      -- 4-1 的左边
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 392, 402, 0x000000 }, { 393, 402, 0x292452 },
          { 392, 401, 0x000000 }, { 393, 401, 0x312852 },
          { 391, 403, 0x000000 }, { 392, 403, 0x29244a },
          { 391, 404, 0x000000 }, { 392, 404, 0x312852 },
        })
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
      -- 5-1 的左边
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 371, 511, 0x000000 }, { 372, 511, 0x291c4a },
          { 371, 510, 0x000000 }, { 372, 510, 0x29204a },
          { 370, 512, 0x000000 }, { 371, 512, 0x29204a },
          { 370, 513, 0x000000 }, { 371, 513, 0x29204a },
        })
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
    },
    -- 地图右边界
    rightLineList = {
      -- 3-10 的右边
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 1615, 247, 0x000000 }, { 1614, 247, 0x525194 },
          { 1615, 246, 0x000000 }, { 1614, 246, 0x5a519c },
          { 1616, 248, 0x000000 }, { 1615, 248, 0x525193 },
          { 1616, 249, 0x000000 }, { 1615, 249, 0x525194 },
        })
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
      -- 4-10 的右边
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 1700, 799, 0x000000 }, { 1699, 799, 0x4a417b },
          { 1700, 798, 0x000000 }, { 1699, 798, 0x4a417b },
          { 1701, 800, 0x000000 }, { 1700, 800, 0x4a417b },
          { 1701, 801, 0x000000 }, { 1700, 801, 0x423d73 },
        })
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
      -- 5-10 的右边
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 1677, 509, 0x000000 }, { 1676, 509, 0x42396b },
          { 1677, 508, 0x000000 }, { 1676, 508, 0x424173 },
          { 1678, 510, 0x000000 }, { 1677, 510, 0x423c6b },
          { 1678, 511, 0x000000 }, { 1677, 511, 0x423c6b },
        })
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
      -- 6-10 的右边
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 1706, 631, 0x000000 }, { 1705, 631, 0x3a3563 },
          { 1706, 630, 0x000000 }, { 1705, 630, 0x3a3163 },
          { 1707, 632, 0x000000 }, { 1706, 632, 0x393862 },
          { 1707, 633, 0x000000 }, { 1706, 633, 0x31315a },
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