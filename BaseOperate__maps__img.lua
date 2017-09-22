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

return {
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
    topLineList = {
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 651, 407, 0x21354a }, { 683, 409, 0x193542 },
          { 737, 407, 0x193542 }, { 799, 409, 0x213542 },
          { 847, 407, 0x213542 }, { 906, 409, 0x193142 },
        })
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
    },
    -- 地图下边界
    bottonLine = {
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022 }
        local basePoint, posandcolor = transRelativePoint({
          { 420, 540, 0x000000 }, { 431, 543, 0x000000 },
          { 457, 540, 0x000000 }, { 492, 543, 0x000000 },
          { 544, 540, 0x000000 }, { 575, 543, 0x000000 },
          { 621, 540, 0x000000 }, { 677, 543, 0x000000 },
          { 719, 540, 0x000000 }, { 789, 543, 0x000000 },
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
          { 285, 362, 0x000000 }, { 286, 362, 0x31b6de },
          { 285, 363, 0x000000 }, { 286, 363, 0x31b2d6 },
          { 284, 364, 0x000000 }, { 285, 364, 0x31b2de },
          { 284, 365, 0x000000 }, { 285, 365, 0x31b6de },
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
          { 1800, 297, 0x299ade }, { 1801, 297, 0x000000 },
          { 1800, 298, 0x299ee6 }, { 1801, 298, 0x000000 },
          { 1801, 299, 0x299ae6 }, { 1802, 299, 0x000000 },
          { 1801, 300, 0x299ae6 }, { 1802, 300, 0x000408 },
        })
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
    },
    -- 我方舰队位置列表
    myFleetList = {
      --  采集位置1-2关1-1位
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 874, 353, 0xde8a42 }, { 863, 363, 0xe6924a },
          { 841, 379, 0xd68a42 }, { 877, 342, 0xc5716b },
          { 898, 369, 0x212021 },
        })
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
      --  采集位置1-2关3-1位
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 869, 629, 0xde8e52 }, { 856, 637, 0xe69252 },
          { 819, 642, 0xd68e3a }, { 871, 617, 0xce7173 },
          { 891, 648, 0x191819 },
        })
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
      --  采集位置4-2关1-5位
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 1389, 284, 0xd6797b }, { 1388, 296, 0xde8642 },
          { 1380, 305, 0xe6924a }, { 1369, 314, 0xde8e4a },
          { 1407, 315, 0x211c21 },
        })
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
      --  采集位置4-2关6-5位
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 1328, 440, 0xe69252 }, { 1315, 452, 0xde8a42 },
          { 1301, 463, 0xd69242 }, { 1327, 424, 0xce7573 },
          { 1350, 461, 0x191819 },
        })
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
      --  采集位置3-4关3-8位
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 1644, 394, 0xde9a4a }, { 1651, 379, 0xde8a4a },
          { 1659, 364, 0xd68142 }, { 1660, 349, 0xce7973 },
          { 1684, 385, 0x191c19 },
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
    },
    -- 敌方舰队位置，右上角的难度标志
    enemyList = {
      -- 小型
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 1445, 668, 0xe6b200 }, { 1459, 668, 0xe6b600 },
          { 1474, 668, 0xe6b600 }, { 1439, 675, 0xcebe29 },
          { 1439, 687, 0xd6c221 }, { 1439, 703, 0xd6c221 },
        })
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
      -- 中型
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 1027, 392, 0xd69600 }, { 1041, 392, 0xdeaa00 },
          { 1057, 392, 0xdeaa00 }, { 1023, 397, 0xdeae08 },
          { 1023, 410, 0xe6a200 }, { 1023, 427, 0xe6b208 },
        })
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
      -- 大型
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 803, 707, 0x9c4121 }, { 816, 707, 0x9c3d10 },
          { 832, 707, 0x844121 }, { 798, 713, 0xb53500 },
          { 798, 729, 0x844121 }, { 798, 744, 0xb53908 },
        })
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
      -- 大型 3-4 的1-4 截取
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 854, 522, 0xa44119 }, { 866, 522, 0xa43d10 },
          { 879, 522, 0x844121 }, { 849, 529, 0xa44110 },
          { 849, 542, 0x844121 }, { 849, 554, 0xb53500 },
        })
        return { basePoint[3], posandcolor, 90, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
    },
    -- boss位置
    bossPointList = {
      -- 我方舰队和boss重叠
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 1278, 426, 0x3a3131 }, { 1277, 412, 0x292021 },
          { 1252, 424, 0x3a353a }, { 1304, 427, 0x292421 },
          { 1257, 440, 0xe66963 }, { 1265, 458, 0xffffff },
          { 1302, 461, 0xf7efee }, { 1321, 461, 0xf7ebe6 },
        })
        return { basePoint[3], posandcolor, 85, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
      -- 我方舰队不和boss重叠
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 1278, 426, 0x3a3131 }, { 1277, 412, 0x292021 },
          { 1252, 424, 0x3a353a }, { 1304, 427, 0x292421 },
          { 1257, 440, 0xe66963 }, { 1265, 458, 0xffffff },
          { 1302, 461, 0xf7efee }, { 1321, 461, 0xf7ebe6 },
        })
        return { basePoint[3], posandcolor, 85, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
      -- 我方舰队不和boss重叠 1-2关1-5位置
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 1276, 432, 0x4a2429 }, { 1250, 426, 0x3a353a },
          { 1301, 424, 0x292429 }, { 1257, 455, 0xf74d52 },
          { 1300, 453, 0xf74d4a }, { 1275, 471, 0x313131 },
        })
        return { basePoint[3], posandcolor, 85, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
      -- 我方舰队和boss重叠 3-4关3-8位置
      (function()
        local leftTop = { 185, 155 }
        local rightBotton = { 1899, 1022, }
        local basePoint, posandcolor = transRelativePoint({
          { 1582, 554, 0x3a3131 }, { 1557, 554, 0x313531 },
          { 1578, 542, 0x3a353a }, { 1606, 552, 0x312831 },
          { 1560, 569, 0xde695a }, { 1598, 569, 0xde695a },
          { 1580, 571, 0xde695a },
        })
        return { basePoint[3], posandcolor, 85, leftTop[1], leftTop[2], rightBotton[1], rightBotton[2] }
      end)(),
    },
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
  },
}