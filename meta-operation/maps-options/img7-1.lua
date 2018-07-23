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
    bossPointList = table.merge(--
    -- 我方舰队不和boss重叠 3-8
      {
        (function()
          local leftTop = { 185, 155 }
          local rightBottom = { 1899, 1022, }
          local basePoint, posandcolor = transRelativePoint({
            { 1624, 752, 0x423d42 }, { 1648, 751, 0x312d31 },
            { 1675, 755, 0x292429 }, { 1626, 784, 0xff4d52 },
            { 1675, 785, 0xff4d52 }, { 1649, 798, 0x312831 },
            { 1650, 812, 0x7b0410 }, { 1621, 727, 0x211010 },
            { 1677, 730, 0x211819 },
          })
          return { basePoint[3], posandcolor, 82, leftTop[1], leftTop[2], rightBottom[1], rightBottom[2] }
        end)(),
      },
      imgBase.map.bossPointList),
    -- 战斗中的位置
    inBattleList = imgBase.map.inBattleList,
    -- 奖励箱的位置
    rewardBoxList = imgBase.map.rewardBoxList,
  },
}