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
    myFleetList = {
      (function()
        local leftTop = { 185, 155 }
        local rightBottom = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 925, 190, 0x424542 }, { 928, 190, 0xffffff }, { 924, 193, 0x424142 }, { 927, 193, 0xffffff },
          { 924, 197, 0x3a393a }, { 926, 197, 0xffffff }, { 923, 200, 0x313531 }, { 925, 200, 0xffffff },
          { 922, 204, 0x313d31 }, { 924, 204, 0xffffff }, { 921, 202, 0x292d29 }, { 924, 202, 0xfffbff },
        })
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBottom[1], rightBottom[2] }
      end)(),
      -- 空弹变红字
      (function()
        local leftTop = { 185, 155 }
        local rightBottom = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 1410, 360, 0x4a454a }, { 1415, 360, 0xd63519 }, { 1409, 364, 0x3a3d3a }, { 1414, 364, 0xd63d21 },
          { 1409, 367, 0x3a393a }, { 1413, 367, 0xd63521 }, { 1408, 369, 0x313131 }, { 1413, 369, 0xd63521 },
          { 1407, 373, 0x292829 }, { 1411, 373, 0xd63521 },
        })
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBottom[1], rightBottom[2] }
      end)(),
    },
    -- 我放舰队被选中的舰队的绿色的选中箭头的位置
    selectedArrow = imgBase.map.selectedArrow,
    -- 敌方舰队位置(小型舰队)
    enemyList1 = imgBase.map.enemyList1,
    -- 敌方舰队位置(中型舰队)
    enemyList2 = imgBase.map.enemyList2,
    -- 敌方舰队位置(大型舰队)
    enemyList3 = imgBase.map.enemyList3,
    -- 可移动敌人舰队位置
    movableEnemyList = imgBase.map.movableEnemyList,
    -- boss位置
    bossPointList = imgBase.map.bossPointList,
    -- 战斗中的位置
    inBattleList = imgBase.map.inBattleList,
    -- 奖励箱的位置
    rewardBoxList = imgBase.map.rewardBoxList,
  },
}