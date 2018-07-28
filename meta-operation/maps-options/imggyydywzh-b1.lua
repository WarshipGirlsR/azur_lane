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
    bossPointList = table.merge({}, imgBase.map.bossPointList, {
      (function()
        local leftTop = { 185, 155 }
        local rightBottom = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 1567, 797, 0x3a2429 }, { 1567, 758, 0x292421 },
          { 1537, 749, 0x312d29 }, { 1599, 753, 0x291c21 },
          { 1539, 806, 0xf74d52 }, { 1596, 803, 0xf74d4a },
          { 1550, 810, 0xff4d52 }, { 1585, 811, 0xf74d52 },
          { 1558, 830, 0x6b0c21 }, { 1573, 829, 0x631019 },
        })
        return { basePoint[3], posandcolor, 95, leftTop[1], leftTop[2], rightBottom[1], rightBottom[2] }
      end)()
    }),
    -- 战斗中的位置
    inBattleList = imgBase.map.inBattleList,
    -- 奖励箱的位置
    rewardBoxList = imgBase.map.rewardBoxList,
  },
}