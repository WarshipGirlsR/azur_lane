-- 存储图像信息，用于界面找色、找图。取代图片搜索，因为找色搜索的像素点更少
local function transRelativePoint(tab, base)
  if not base then
    base = tab[1]
    table.remove(tab, 1)
  end
  local newTab = {}
  for key = 1, #tab do
    local value = tab[key]
    newTab[key] = string.format('%d|%d|0x%06X', value[1] - base[1], value[2] - base[2], value[3])
  end
  return base, table.concat(newTab, ',')
end

local imgs = {
  transRelativePoint = transRelativePoint,
  -- 基本方法
  toPoint = function(tab)
    -- 由于这里的tab可能很长，所以使用一些特殊方法防止内存耗尽
    local newTab = {}
    local tabLength = #tab
    for key = 1, tabLength do
      newTab[key] = { tab[key].x, tab[key].y }
      tab[key] = nil
    end
    return newTab
  end,
  -- 过滤被右下角按钮和左上角按钮挡住的部分的点，因为右下角按钮也是黑色的容易与边界识别混淆
  filterNoUsePoint = function(list)
    local newList = {}
    for key = 1, #list do
      local point = list[key]
      if (point[1] < 940 or point[2] < 910)
        and (point[1] > 651 or point[2] > 261) then
        table.insert(newList, point)
      end
    end
    return newList
  end,
  -- 图片数据
  -- 地图扫描
  map = {
    -- 我方舰队位置列表
    myFleetList = {
      (function()
        local leftTop = { 185, 155 }
        local rightBottom = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 925, 190, 0x424542 }, { 928, 190, 0xffffff }, { 924, 193, 0x424142 }, { 927, 193, 0xffffff },
          { 924, 197, 0x3a393a }, { 926, 197, 0xffffff }, { 923, 200, 0x313531 }, { 925, 200, 0xffffff },
          { 922, 204, 0x313d31 }, { 924, 204, 0xffffff }, { 921, 202, 0x292d29 }, { 924, 202, 0xfffbff },
        })
        return { basePoint[3], posandcolor, 88, leftTop[1], leftTop[2], rightBottom[1], rightBottom[2] }
      end)(),
      -- 空弹变红字
      (function()
        local leftTop = { 185, 155 }
        local rightBottom = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 1567, 190, 0x424542 }, { 1569, 190, 0xd63519 }, { 1566, 194, 0x424142 }, { 1568, 194, 0xce4121 },
          { 1565, 196, 0x3a3d3a }, { 1568, 196, 0xd63d21 }, { 1565, 198, 0x313931 }, { 1567, 198, 0xd63519 },
          { 1564, 201, 0x293129 }, { 1566, 201, 0xc53519 }, { 1564, 201, 0x293129 }, { 1566, 202, 0xd63d21 },
        })
        return { basePoint[3], posandcolor, 88, leftTop[1], leftTop[2], rightBottom[1], rightBottom[2] }
      end)(),
    },
    -- 我放舰队被选中的舰队的绿色的选中箭头的位置
    selectedArrow = {
      (function()
        local leftTop = { 185, 155 }
        local rightBottom = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 454, 303, 0x3aff84 }, { 474, 303, 0x7bffad },
          { 452, 288, 0x005d21 }, { 472, 289, 0x00be4a },
        })
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBottom[1], rightBottom[2] }
      end)(),
      (function()
        local leftTop = { 185, 155 }
        local rightBottom = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 904, 627, 0x19ff6b }, { 928, 627, 0x7cff9d },
          { 907, 577, 0x3aff84 }, { 926, 574, 0x83ffb5 },
        })
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBottom[1], rightBottom[2] }
      end)(),
    },
    -- 敌方舰队位置，右上角的难度标志
    enemyList1 = {
      -- 小型 上框
      (function()
        local leftTop = { 185, 155 }
        local rightBottom = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 709, 447, 0xe6b600 }, { 714, 447, 0xe6b200 },
          { 716, 447, 0xdeb200 }, { 719, 447, 0xe6b200 },
          { 722, 447, 0xe6b600 }, { 725, 447, 0xe6ba08 },
          { 727, 447, 0xe6ba08 }, { 730, 447, 0xe6b600 },
          { 732, 447, 0xdeb200 }, { 735, 447, 0xe6b600 },
        })
        return { basePoint[3], posandcolor, 95, leftTop[1], leftTop[2], rightBottom[1], rightBottom[2] }
      end)(),
      -- 小型 上框 蓝色地图
      (function()
        local leftTop = { 185, 155 }
        local rightBottom = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 1181, 245, 0xdeba10 }, { 1185, 245, 0xdeba10 },
          { 1188, 245, 0xdeba10 }, { 1192, 245, 0xceba10 },
          { 1194, 245, 0xbdba10 }, { 1197, 245, 0xceba10 },
          { 1200, 245, 0xdeba10 }, { 1203, 245, 0xdeba10 },
          { 1206, 245, 0xd6ba10 }, { 1209, 245, 0xdeba10 },
        })
        return { basePoint[3], posandcolor, 95, leftTop[1], leftTop[2], rightBottom[1], rightBottom[2] }
      end)(),
      -- 小型 左框
      (function()
        local leftTop = { 185, 155 }
        local rightBottom = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 701, 453, 0xceaa10 }, { 701, 455, 0xd6b610 },
          { 701, 457, 0xdeba10 }, { 701, 461, 0xdeba10 },
          { 701, 464, 0xdeba10 }, { 701, 466, 0xdeba10 },
          { 701, 469, 0xdeba10 }, { 701, 472, 0xdeba10 },
          { 701, 475, 0xdeba10 }, { 701, 479, 0xdeba10 },
        })
        return { basePoint[3], posandcolor, 95, leftTop[1], leftTop[2], rightBottom[1], rightBottom[2] }
      end)(),
      -- 小型 左框 蓝色地图
      (function()
        local leftTop = { 185, 155 }
        local rightBottom = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 1177, 251, 0xcebe19 }, { 1177, 255, 0xcebe19 },
          { 1177, 258, 0xceba19 }, { 1177, 261, 0xcebe19 },
          { 1177, 264, 0xceba19 }, { 1177, 267, 0xcebe19 },
          { 1177, 270, 0xceba19 }, { 1177, 273, 0xcebe19 },
          { 1177, 275, 0xcebe21 }, { 1177, 278, 0xceba29 },
        })
        return { basePoint[3], posandcolor, 95, leftTop[1], leftTop[2], rightBottom[1], rightBottom[2] }
      end)(),
    },
    enemyList2 = {
      -- 中型 上框
      (function()
        local leftTop = { 185, 155 }
        local rightBottom = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 906, 319, 0xdeaa00 }, { 910, 319, 0xdeaa00 },
          { 914, 319, 0xe6a200 }, { 918, 319, 0xe6a200 },
          { 921, 319, 0xe6a600 }, { 924, 319, 0xdea200 },
          { 928, 319, 0xdea200 }, { 931, 319, 0xe6a600 },
          { 934, 319, 0xdeaa00 }, { 937, 319, 0xdeaa00 },
        })
        return { basePoint[3], posandcolor, 92, leftTop[1], leftTop[2], rightBottom[1], rightBottom[2] }
      end)(),
      -- 中型 左框
      (function()
        local leftTop = { 185, 155 }
        local rightBottom = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 900, 325, 0xdeaa00 }, { 900, 328, 0xdeaa00 },
          { 900, 330, 0xdeaa00 }, { 900, 334, 0xdeaa00 },
          { 900, 336, 0xdeaa00 }, { 900, 339, 0xd6aa00 },
          { 900, 342, 0xdeaa00 }, { 900, 345, 0xdeaa00 },
          { 900, 348, 0xdeaa00 }, { 900, 351, 0xd6aa00 },
        })
        return { basePoint[3], posandcolor, 92, leftTop[1], leftTop[2], rightBottom[1], rightBottom[2] }
      end)(),
    },
    enemyList3 = {
      -- 大型 左上框
      (function()
        local leftTop = { 185, 155 }
        local rightBottom = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 1394, 475, 0xbd3500 }, { 1400, 475, 0xbd3500 },
          { 1407, 475, 0xbd3900 }, { 1411, 475, 0xbd3900 },
          { 1388, 480, 0xbd3908 }, { 1388, 487, 0xbd3500 },
        })
        return { basePoint[3], posandcolor, 95, leftTop[1], leftTop[2], rightBottom[1], rightBottom[2] }
      end)(),
      -- 大型 右下框
      (function()
        local leftTop = { 185, 155 }
        local rightBottom = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 1400, 517, 0xbd3500 }, { 1409, 517, 0xbd3900 },
          { 1413, 517, 0xbd3900 }, { 1420, 517, 0xb53100 },
          { 1429, 509, 0xbd3900 }, { 1429, 502, 0xbd3500 },
        })
        return { basePoint[3], posandcolor, 95, leftTop[1], leftTop[2], rightBottom[1], rightBottom[2] }
      end)(),
      -- 大型 下框
      (function()
        local leftTop = { 185, 155 }
        local rightBottom = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 1346, 797, 0xbd3500 }, { 1357, 797, 0xbd3500 },
          { 1366, 797, 0xbd3500 }, { 1345, 790, 0xbd3500 },
          { 1377, 792, 0xbd3500 }, { 1366, 790, 0xbd3d00 },
        })
        return { basePoint[3], posandcolor, 95, leftTop[1], leftTop[2], rightBottom[1], rightBottom[2] }
      end)(),
    },
    -- boss位置
    bossPointList = {
      -- 我方舰队和boss重叠 3-3 的 4-1
      (function()
        local leftTop = { 185, 155 }
        local rightBottom = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 702, 600, 0x313131 }, { 685, 600, 0x31353a },
          { 677, 600, 0x31353a }, { 669, 600, 0x313131 },
          { 714, 600, 0x312831 }, { 721, 600, 0x312429 },
          { 722, 600, 0x312829 }, { 726, 595, 0x211819 },
          { 714, 595, 0x292829 }, { 703, 594, 0x312d31 },
          { 683, 596, 0x313531 }, { 674, 595, 0x313131 },
          { 701, 590, 0x312d31 }, { 697, 609, 0xfff7f7 },
          { 678, 616, 0xe66d63 }, { 689, 616, 0xe66963 },
          { 705, 618, 0xde695a },
        })
        return { basePoint[3], posandcolor, 85, leftTop[1], leftTop[2], rightBottom[1], rightBottom[2] }
      end)(),
      -- 我方舰队不和boss重叠 9-4 的 6-9
      (function()
        local leftTop = { 185, 155 }
        local rightBottom = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 1615, 803, 0x3a2d31 }, { 1593, 795, 0xf75152 },
          { 1645, 797, 0xff5152 }, { 1616, 752, 0x313931 },
          { 1584, 745, 0x313531 }, { 1648, 742, 0x312831 },
        })
        return { basePoint[3], posandcolor, 85, leftTop[1], leftTop[2], rightBottom[1], rightBottom[2] }
      end)(),
      -- 我方舰队不和boss重叠 1-1 的 1-7
      (function()
        local leftTop = { 185, 155 }
        local rightBottom = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 1462, 426, 0x313131 }, { 1451, 426, 0x31313a },
          { 1439, 426, 0x31353a }, { 1472, 426, 0x312d31 },
          { 1488, 426, 0x312429 }, { 1483, 423, 0x312831 },
          { 1471, 423, 0x313131 }, { 1459, 423, 0x423542 },
          { 1446, 423, 0x313131 }, { 1464, 417, 0x312d31 },
          { 1435, 452, 0xf74d52 }, { 1445, 459, 0xff4d52 },
          { 1482, 459, 0xf74d4a }, { 1492, 452, 0xff4d52 },
          { 1464, 468, 0x3a2d31 },
        })
        return { basePoint[3], posandcolor, 82, leftTop[1], leftTop[2], rightBottom[1], rightBottom[2] }
      end)()
    },
    -- 战斗中的点
    inBattleList = {
      (function()
        local leftTop = { 185, 155 }
        local rightBottom = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 538, 757, 0xf77d6b }, { 515, 735, 0xf78173 },
          { 471, 727, 0xfff7f7 }, { 519, 727, 0xfff7f7 },
          { 558, 727, 0xf7f7f7 }, { 592, 727, 0xf7f7ef },
          { 581, 751, 0xfffbf7 }, { 581, 762, 0xfffbff },
        })
        return { basePoint[3], posandcolor, 85, leftTop[1], leftTop[2], rightBottom[1], rightBottom[2] }
      end)(),
    },
    -- 奖励点
    rewardBoxList = {
      (function()
        local leftTop = { 185, 155 }
        local rightBottom = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 1125, 860, 0x94fff7 }, { 1126, 847, 0x292d29 },
          { 1125, 839, 0x292829 }, { 1125, 827, 0x94fff7 },
          { 1125, 812, 0x292829 }, { 1128, 781, 0x84ffef },
        })
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBottom[1], rightBottom[2] }
      end)(),
      (function()
        local leftTop = { 185, 155 }
        local rightBottom = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 573, 304, 0x94fff7 }, { 573, 296, 0x292d29 },
          { 573, 289, 0x292829 }, { 573, 277, 0x9cfff7 },
          { 576, 242, 0x83fff7 },
        })
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBottom[1], rightBottom[2] }
      end)(),
      (function()
        local leftTop = { 185, 155 }
        local rightBottom = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 518, 592, 0x9cfff7 }, { 479, 592, 0xdeebde },
          { 554, 592, 0xefebef }, { 556, 616, 0xefebef },
          { 518, 618, 0x94fff7 }, { 481, 625, 0xefebef },
        })
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBottom[1], rightBottom[2] }
      end)(),
    },
  },
}

return imgs
