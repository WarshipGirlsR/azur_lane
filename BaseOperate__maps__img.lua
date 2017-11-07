-- 存储图像信息，用于界面找色、找图。取代图片搜索，因为找色搜索的像素点更少

require 'TableLib'

local function transRelativePoint(tab, base)
  if not base then
    base = tab[1]
    table.remove(tab, 1)
  end
  local newTab = {}
  for key, value in ipairs(tab) do
    newTab[key] = table.assign(value, { value[1] - base[1], value[2] - base[2] })
  end

  local tmp = {}
  for _, value in ipairs(newTab) do
    value[3] = string.format('0x%06X', value[3])
    table.insert(tmp, table.concat(value, '|'))
  end

  return base, table.concat(tmp, ',')
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
  -- 过滤被右下角按钮挡住的部分的点，因为右下角按钮也是黑色的容易与边界识别混淆
  filterNoUsePoint = function(list)
    local newList = {}
    for key = 1, #list do
      local point = list[key]
      if point[1] < 940 or point[2] < 910 then
        table.insert(newList, point)
      end
    end
    return newList
  end,
  -- 图片数据
  -- 地图扫描
  map = {
    -- 地图上边界
    topLineList = {},
    -- 地图下边界
    bottonLine = {},
    -- 地图左边界
    leftLineList = {},
    -- 地图右边界
    rightLineList = {},
    -- 我方舰队位置列表
    myFleetList = {
      --  采集位置event4-1-sp3关8-1位
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 564, 486, 0xce7573 }, { 558, 496, 0xde864a },
          { 553, 497, 0xffebc5 }, { 548, 511, 0xde8a42 },
          { 542, 514, 0xffffde }, { 535, 525, 0xde8a42 },
          { 529, 528, 0xffffde }, { 510, 537, 0x9c4d4a },
          { 588, 516, 0x292429 }, { 590, 534, 0x191819 },
        })
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
      --  采集位置event4-1-sp3关1-4位
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 1044, 395, 0xbd6d6b }, { 1039, 402, 0xd67d3a },
          { 1033, 402, 0xffffde }, { 1030, 412, 0xde8a4a },
          { 1025, 411, 0xffffde }, { 1020, 419, 0xd68642 },
          { 1015, 421, 0xffffde }, { 1002, 428, 0xa44d52 },
          { 1059, 409, 0x293529 }, { 1059, 420, 0x191819 },
        })
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
      --  采集位置event4-1-sp3关4-4位
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 1001, 305, 0xce7173 }, { 994, 312, 0xce7d42 },
          { 989, 314, 0xffffde }, { 983, 322, 0xd68142 },
          { 979, 327, 0xffffde }, { 974, 334, 0xde8642 },
          { 970, 337, 0xffffd6 }, { 955, 346, 0xa44d4a },
          { 1018, 326, 0x292829 }, { 1018, 342, 0x211c21 },
        })
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
      --  采集位置event6-1-sp3关7-6位
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 979, 613, 0xa4454a }, { 983, 604, 0xde9652 },
          { 995, 594, 0xde924a }, { 1005, 577, 0xe69652 },
          { 1019, 568, 0xe69a4a }, { 1019, 552, 0xd67d7b },
          { 1039, 603, 0x211821 }, { 960, 569, 0x948a94 },
          { 997, 553, 0xffffde }, { 975, 583, 0xfffbd6 },
        })
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
    },
    -- 我放舰队被选中的舰队的绿色的选中箭头的位置
    selectedArrow = {
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 454, 303, 0x3aff84 }, { 474, 303, 0x7bffad },
          { 452, 288, 0x005d21 }, { 472, 289, 0x00be4a },
        })
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 904, 627, 0x19ff6b }, { 928, 627, 0x7cff9d },
          { 907, 577, 0x3aff84 }, { 926, 574, 0x83ffb5 },
        })
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
    },
    -- 敌方舰队位置，右上角的难度标志
    enemyList1 = {
      -- 小型 左上框
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 846, 573, 0xd6ba10 }, { 851, 573, 0xdeba10 },
          { 859, 573, 0xdeba10 }, { 868, 573, 0xdeba10 },
          { 840, 578, 0xdebe10 }, { 840, 588, 0xdebe19 },
        })
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
      -- 小型 右下框
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 855, 616, 0xdeba10 }, { 862, 616, 0xdebe10 },
          { 867, 616, 0xdeba10 }, { 876, 616, 0xdebe19 },
          { 884, 610, 0xd6ba10 }, { 884, 602, 0xdebe10 },
        })
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
    },
    enemyList2 = {
      -- 中型 左上框
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 1272, 432, 0xeeaa10 }, { 1280, 432, 0xefa600 },
          { 1286, 432, 0xefa600 }, { 1293, 432, 0xe6a200 },
          { 1299, 432, 0xe6a200 }, { 1266, 438, 0xe6a208 },
          { 1266, 445, 0xdea200 },
        })
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
      -- 中型 右下框
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 1281, 477, 0xe6a600 }, { 1287, 477, 0xe6a600 },
          { 1293, 477, 0xe6a600 }, { 1298, 477, 0xdea200 },
          { 1311, 472, 0xefaa10 }, { 1311, 466, 0xdeaa00 },
        })
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
    },
    enemyList3 = {
      -- 大型 左上框
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 1394, 475, 0xbd3500 }, { 1400, 475, 0xbd3500 },
          { 1407, 475, 0xbd3900 }, { 1411, 475, 0xbd3900 },
          { 1388, 480, 0xbd3908 }, { 1388, 487, 0xbd3500 },
        })
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
      -- 大型 右下框
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 1400, 517, 0xbd3500 }, { 1409, 517, 0xbd3900 },
          { 1413, 517, 0xbd3900 }, { 1420, 517, 0xb53100 },
          { 1429, 509, 0xbd3900 }, { 1429, 502, 0xbd3500 },
        })
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
    },
    -- boss位置
    bossPointList = {
      -- 我方舰队和boss重叠 3-3 的 4-1
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022, }
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
        return { basePoint[3], posandcolor, 85, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
      -- 我方舰队不和boss重叠 1-1 的 1-7
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022, }
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
        return { basePoint[3], posandcolor, 85, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
    },
    -- 战斗中的点
    inBattleList = {
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 538, 757, 0xf77d6b }, { 515, 735, 0xf78173 },
          { 471, 727, 0xfff7f7 }, { 519, 727, 0xfff7f7 },
          { 558, 727, 0xf7f7f7 }, { 592, 727, 0xf7f7ef },
          { 581, 751, 0xfffbf7 }, { 581, 762, 0xfffbff },
        })
        return { basePoint[3], posandcolor, 85, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
    },
    -- 奖励点
    rewardBoxList = {
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 1125, 860, 0x94fff7 }, { 1126, 847, 0x292d29 },
          { 1125, 839, 0x292829 }, { 1125, 827, 0x94fff7 },
          { 1125, 812, 0x292829 }, { 1128, 781, 0x84ffef },
        })
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 573, 304, 0x94fff7 }, { 573, 296, 0x292d29 },
          { 573, 289, 0x292829 }, { 573, 277, 0x9cfff7 },
          { 576, 242, 0x83fff7 },
        })
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
    },
  },
}

return imgs
