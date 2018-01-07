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
          { 1533, 462, 0x191d2a }, { 1575, 462, 0x191d32 },
          { 1609, 462, 0x191d2a }, { 1646, 462, 0x212132 },
          { 1660, 463, 0x6371ad }, { 1616, 463, 0x636dad },
          { 1580, 463, 0x636dad }, { 1548, 463, 0x636dad },
        })
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
      -- 1-7的上边
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 1352, 462, 0x191d29 }, { 1400, 462, 0x191c29 },
          { 1431, 462, 0x191d2a }, { 1473, 462, 0x111d21 },
          { 1495, 463, 0x6369ad }, { 1452, 463, 0x525d9c },
          { 1418, 463, 0x4a598c }, { 1376, 463, 0x424d84 },
        })
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
      -- 1-4的上边
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 798, 462, 0x191829 }, { 826, 462, 0x212431 },
          { 866, 462, 0x191c29 }, { 897, 462, 0x192429 },
          { 917, 463, 0x3a3963 }, { 891, 463, 0x423563 },
          { 859, 463, 0x423563 }, { 825, 463, 0x3a3563 },
        })
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
    },
    -- 地图下边界
    bottonLineList = {
      -- 3-3 的下面
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022 }
        local basePoint, posandcolor = transRelativePoint({
          { 561, 889, 0x000000 }, { 601, 889, 0x000000 },
          { 630, 889, 0x000000 }, { 673, 889, 0x000000 },
          { 690, 888, 0x31244a }, { 663, 888, 0x29244a },
          { 633, 888, 0x29244a }, { 604, 888, 0x312452 },
        })
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
      -- 3-8 的下面
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022 }
        local basePoint, posandcolor = transRelativePoint({
          { 1597, 889, 0x000000 }, { 1645, 889, 0x000000 },
          { 1683, 889, 0x000000 }, { 1719, 889, 0x000000 },
          { 1753, 888, 0x3a315a }, { 1718, 888, 0x3a315a },
          { 1676, 888, 0x312d52 }, { 1635, 888, 0x31284a },
        })
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
    },
    -- 地图左边界
    leftLineList = {
      -- 1-1 的左边
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 250, 468, 0x000000 }, { 251, 468, 0x312d5a },
          { 250, 467, 0x000000 }, { 251, 467, 0x42315a },
          { 249, 469, 0x000000 }, { 250, 469, 0x31285a },
          { 249, 470, 0x000000 }, { 250, 470, 0x3a2d63 },
        })
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
    },
    -- 地图右边界
    rightLineList = {
      -- 1-8 的右边
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 1681, 469, 0x000000 }, { 1680, 469, 0x636dad },
          { 1681, 468, 0x000000 }, { 1680, 468, 0x6b71b5 },
          { 1682, 470, 0x000000 }, { 1681, 470, 0x6371ad },
          { 1682, 471, 0x000000 }, { 1681, 471, 0x6371ad },
        })
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
      -- 2-8 的右边
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 1730, 652, 0x000000 }, { 1729, 652, 0x4a417b },
          { 1730, 651, 0x000000 }, { 1729, 651, 0x4a417b },
          { 1731, 653, 0x000000 }, { 1730, 653, 0x423d73 },
          { 1731, 654, 0x000000 }, { 1730, 654, 0x4a417b },
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