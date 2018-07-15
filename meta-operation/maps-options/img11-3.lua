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
      -- 1-2的上边
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 747, 515, 0x3a3163 }, { 758, 515, 0x312d5a },
          { 766, 515, 0x312d5a }, { 777, 515, 0x3a3163 },
          { 790, 515, 0x312d5a }, { 799, 515, 0x3a3163 },
        })
        return { basePoint[3], posandcolor, 100, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
      -- 1-3的上边
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 908, 515, 0x31315a }, { 926, 515, 0x312d5a },
          { 939, 515, 0x3a3163 }, { 952, 515, 0x312d5a },
          { 973, 515, 0x3a3163 },
        })
        return { basePoint[3], posandcolor, 100, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
      -- 1-5的上边
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 1275, 515, 0x3a396b }, { 1289, 515, 0x3a396b },
          { 1305, 515, 0x424173 }, { 1322, 515, 0x3a3d73 },
          { 1337, 515, 0x424573 },
        })
        return { basePoint[3], posandcolor, 100, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
      -- 1-9的上边
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 1482, 542, 0x6b71b5 }, { 1489, 542, 0x6b6d9c },
          { 1501, 542, 0x636d9c }, { 1510, 542, 0x6b75b5 },
          { 1518, 542, 0x6b75b5 },
        })
        return { basePoint[3], posandcolor, 100, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
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