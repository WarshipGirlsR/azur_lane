local co = require '../lib/co'
local c = coroutine
local sleepPromise = require '../utils/sleep-promise'
local imgTools = require '../utils/img-tools'


local battle = {}


-- 点击出征
battle.clickBattleBtn = function()
  RTap({ 1628, 599 }, 100)
end

-- 点击活动
battle.clickEventBtn = function()
  RTap({ 1018, 249 }, 100)
end

--  是否在出击选择章节界面
battle.isBattleChapterPage = function()
  local __keepScreenState = keepScreenState
  if not __keepScreenState then keepScreen(true) end
  local list = {
    { 11, 10, 0xe6e7ef }, { 87, 10, 0xe6e3ef }, { 251, 21, 0xffefbd }, { 259, 27, 0x3a393a },
    { 256, 44, 0x423d42 }, { 246, 46, 0xffbe08 }, { 288, 23, 0xffe7ad }, { 291, 23, 0xffebad },
    { 324, 20, 0xfff3ce }, { 333, 42, 0x3a4142 }, { 473, 5, 0xeff3f7 }, { 681, 6, 0xeff3f7 },
    { 911, 10, 0xeff3f7 }, { 933, 6, 0xeff3f7 }, { 886, 53, 0xd6dbde }, { 68, 52, 0xd6ced6 },
    { 278, 25, 0x31393a }, { 315, 26, 0x101010 }, { 331, 26, 0x080c08 }, { 324, 28, 0xffdf84 },
  }
  local result = multiColorS(list, 85)
  if not __keepScreenState then keepScreen(false) end
  return result
end

-- 点击回港
battle.clickBackToHomeBtn = function()
  RTap({ 98, 1016 }, 100)
end

--  是否在普通模式
battle.isNormalMode = function()
  local __keepScreenState = keepScreenState
  if not __keepScreenState then keepScreen(true) end

  local position = { { 12, 898 }, { 876, 1067 }, }
  local basePoint, posandcolor = imgTools.transRelativePoint({
    { 53, 960, 0xffffff }, { 126, 942, 0xfff7f7 }, { 168, 985, 0xad5d63 }, { 286, 984, 0xb56163 },
    { 291, 1010, 0xbd0c10 }, { 171, 1009, 0xc50c10 }, { 151, 1043, 0x631010 }, { 289, 1046, 0x84454a },
    { 97, 1040, 0xf7f7f7 }, { 119, 999, 0xff5908 }, { 56, 1006, 0xff1019 }, { 78, 994, 0xffffff },
    { 175, 1020, 0x631010 }, { 200, 1016, 0xf7efef }, { 205, 1016, 0xf7f7f7 }, { 264, 1014, 0xce0c19 },
    { 295, 994, 0x420408 }, { 198, 993, 0x420000 }, { 228, 1019, 0xeff3ef }, { 263, 1037, 0x631010 },
  })

  local result = imgTools.toPoint(findMultiColorInRegionFuzzyExt(basePoint[3], posandcolor, 95, position[1][1], position[1][2], position[2][1], position[2][2]))
  console.log(result)
  if not __keepScreenState then keepScreen(false) end
  return #result > 0
end

--  是否在困难模式
battle.isHardMode = function()
  local __keepScreenState = keepScreenState
  if not __keepScreenState then keepScreen(true) end

  local position = { { 12, 898 }, { 876, 1067 }, }
  local basePoint, posandcolor = imgTools.transRelativePoint({
    { 56, 969, 0xd6d7d6 }, { 87, 972, 0xd6dbd6 }, { 120, 997, 0xd6d7d6 }, { 171, 988, 0x5a6d8c },
    { 203, 989, 0x4a5973 }, { 264, 993, 0x31414a }, { 286, 1012, 0x102852 }, { 287, 1034, 0x102042 },
    { 216, 1042, 0x102442 }, { 154, 1043, 0x081c3a }, { 202, 1017, 0xeff3ef }, { 236, 1014, 0xf7f7f7 },
    { 254, 1023, 0xf7f3f7 }, { 264, 1020, 0x102442 }, { 281, 1012, 0x08357b }, { 180, 1019, 0x08203a },
    { 92, 1044, 0x212429 }, { 92, 1013, 0x212829 }, { 119, 1008, 0xd6dbde }, { 147, 1006, 0xdee3de },
  })

  local result = imgTools.toPoint(findMultiColorInRegionFuzzyExt(basePoint[3], posandcolor, 95, position[1][1], position[1][2], position[2][1], position[2][2]))
  console.log(result)
  if not __keepScreenState then keepScreen(false) end
  return #result > 0
end

-- 切换困难模式按钮
battle.clickSwitchHardModeBtn = function()
  RTap({ 202, 1010 }, 100)
end

-- 移动到m章节
battle.moveToChapter = function(chapterObj)
  local chapter = chapter
  local __keepScreenState = keepScreenState
  if not __keepScreenState then keepScreen(true) end

  local m = chapterObj.chapter or 1

  local leftButton = {
    { 108, 500, 0xefefef }, { 66, 537, 0xd6d7d6 },
    { 99, 528, 0xdedfde }, { 99, 549, 0xbdbebd },
    { 93, 565, 0xc5c6c5 },
  }
  local leftButton2 = {
    { 97, 531, 0xb5b2b5 }, { 64, 538, 0xb5b2b5 },
    { 95, 510, 0xbdbebd }, { 112, 518, 0xb5b2b5 },
    { 102, 572, 0xadaaad }, { 101, 555, 0x9c9e9c },
  }
  -- 先移到第一章
  for i = 1, 14 do
    RTap({ 90, 540 }, 100)
    mSleep(80)
    keepScreen(true)
    if not multiColorS(leftButton) and not multiColorS(leftButton2) then
      break
    end
  end
  -- 再移到第m章
  for i = 2, m do
    RTap({ 1826, 540 }, 100)
    mSleep(200)
  end
  mSleep(200)
  if not __keepScreenState then keepScreen(false) end
  return true
end

-- 点击m章节
battle.clickChapter = function(chapterObj)
  local __keepScreenState = keepScreenState
  if not __keepScreenState then keepScreen(true) end

  if chapterObj.name == '1-1' then
    RTap({ 227, 687 }, 100)
  elseif chapterObj.name == '1-2' then
    RTap({ 685, 409 }, 100)
  elseif chapterObj.name == '1-3' then
    RTap({ 984, 789 }, 100)
  elseif chapterObj.name == '1-4' then
    RTap({ 1366, 317 }, 100)
  elseif chapterObj.name == '2-1' then
    RTap({ 1221, 685 }, 100)
  elseif chapterObj.name == '2-2' then
    RTap({ 1121, 277 }, 100)
  elseif chapterObj.name == '2-3' then
    RTap({ 429, 406 }, 100)
  elseif chapterObj.name == '2-4' then
    RTap({ 572, 821 }, 100)
  elseif chapterObj.name == '3-1' then
    RTap({ 603, 320 }, 100)
  elseif chapterObj.name == '3-2' then
    RTap({ 344, 750 }, 100)
  elseif chapterObj.name == '3-3' then
    RTap({ 1364, 279 }, 100)
  elseif chapterObj.name == '3-4' then
    RTap({ 923, 540 }, 100)
  elseif chapterObj.name == '3-sos' then
    RTap({ 1118, 794 }, 100)
  elseif chapterObj.name == '4-1' then
    RTap({ 355, 451 }, 100)
  elseif chapterObj.name == '4-2' then
    RTap({ 628, 701 }, 100)
  elseif chapterObj.name == '4-3' then
    RTap({ 1234, 818 }, 100)
  elseif chapterObj.name == '4-4' then
    RTap({ 1167, 430 }, 100)
  elseif chapterObj.name == '4-sos' then
    RTap({ 720, 266 }, 100)
  elseif chapterObj.name == '5-1' then
    RTap({ 363, 544 }, 100)
  elseif chapterObj.name == '5-2' then
    RTap({ 1285, 803 }, 100)
  elseif chapterObj.name == '5-3' then
    RTap({ 1104, 549 }, 100)
  elseif chapterObj.name == '5-4' then
    RTap({ 884, 318 }, 100)
  elseif chapterObj.name == '5-sos' then
    RTap({ 614, 825 }, 100)
  elseif chapterObj.name == '6-1' then
    RTap({ 1373, 746 }, 100)
  elseif chapterObj.name == '6-2' then
    RTap({ 1055, 515 }, 100)
  elseif chapterObj.name == '6-3' then
    RTap({ 632, 317 }, 100)
  elseif chapterObj.name == '6-4' then
    RTap({ 443, 643 }, 100)
  elseif chapterObj.name == '6-sos' then
    RTap({ 1340, 247 }, 100)
  elseif chapterObj.name == '7-1' then
    RTap({ 308, 725 }, 100)
  elseif chapterObj.name == '7-2' then
    RTap({ 688, 270 }, 100)
  elseif chapterObj.name == '7-3' then
    RTap({ 1234, 425 }, 100)
  elseif chapterObj.name == '7-4' then
    RTap({ 1416, 674 }, 100)
  elseif chapterObj.name == '7-sos' then
    RTap({ 454, 506 }, 100)
  elseif chapterObj.name == '8-1' then
    RTap({ 824, 280 }, 100)
  elseif chapterObj.name == '8-2' then
    RTap({ 411, 535 }, 100)
  elseif chapterObj.name == '8-3' then
    RTap({ 507, 849 }, 100)
  elseif chapterObj.name == '8-4' then
    RTap({ 1168, 686 }, 100)
  elseif chapterObj.name == '8-sos' then
    RTap({ 1301, 442 }, 100)
  elseif chapterObj.name == '9-1' then
    RTap({ 360, 359 }, 100)
  elseif chapterObj.name == '9-2' then
    RTap({ 569, 729 }, 100)
  elseif chapterObj.name == '9-3' then
    RTap({ 1179, 395 }, 100)
  elseif chapterObj.name == '9-4' then
    RTap({ 1375, 768 }, 100)
  elseif chapterObj.name == '9-sos' then
    RTap({ 881, 589 }, 100)
  elseif chapterObj.name == '10-1' then
    RTap({ 301, 362 }, 100)
  elseif chapterObj.name == '10-2' then
    RTap({ 694, 571 }, 100)
  elseif chapterObj.name == '10-3' then
    RTap({ 971, 806 }, 100)
  elseif chapterObj.name == '10-4' then
    RTap({ 1111, 336 }, 100)
  elseif chapterObj.name == '10-sos' then
    RTap({ 1336, 647 }, 100)
  elseif chapterObj.name == '11-1' then
    RTap({ 453, 348 }, 100)
  elseif chapterObj.name == '11-2' then
    RTap({ 643, 779 }, 100)
  elseif chapterObj.name == '11-3' then
    RTap({ 1077, 255 }, 100)
  elseif chapterObj.name == '11-4' then
    RTap({ 1335, 665 }, 100)
  elseif chapterObj.name == '12-1' then
    RTap({ 296, 362 }, 100)
  elseif chapterObj.name == '12-2' then
    RTap({ 570, 727 }, 100)
  elseif chapterObj.name == '12-3' then
    RTap({ 1183, 396 }, 100)
  elseif chapterObj.name == '12-4' then
    RTap({ 1377, 774 }, 100)
  end
  if not __keepScreenState then keepScreen(false) end
end

-- 检测是第几关
battle.checkChapter = function(chapterObj)
  local __keepScreenState = keepScreenState
  if not __keepScreenState then keepScreen(true) end
  local cha = chapterObj.chapter
  if chapterObj.type == 'event' then
    cha = 'event'
  end
  local list = {
    [1] = {
      { 73, 146, 0xf7df6b }, { 74, 159, 0xe6aa29 },
      { 74, 166, 0xffbe31 }, { 67, 151, 0x292419 },
      { 68, 143, 0x101810 }, { 79, 159, 0x212021 },
      { 80, 171, 0x193131 }, { 68, 171, 0x101c19 },
    },
    [2] = {
      { 67, 149, 0xe6be52 }, { 71, 148, 0x211808 },
      { 71, 142, 0xc5ba5a }, { 74, 156, 0xe6a631 },
      { 74, 163, 0x191808 }, { 78, 168, 0xffc629 },
      { 65, 168, 0xf7c229 }, { 62, 167, 0x212008 },
      { 80, 168, 0x292421 }, { 71, 171, 0x101010 },
    },
    [3] = {
      { 67, 149, 0xe6c263 }, { 72, 147, 0x212000 },
      { 78, 147, 0xe6ca63 }, { 72, 143, 0xefdb73 },
      { 71, 154, 0xd6aa42 }, { 72, 165, 0x291800 },
      { 72, 169, 0xf7c629 }, { 63, 164, 0x4a4521 },
      { 79, 164, 0xcea229 }, { 75, 171, 0x312d19 },
    },
    [4] = {
      { 74, 143, 0xefdf73 }, { 71, 158, 0x4a3519 },
      { 65, 163, 0xd6aa31 }, { 81, 162, 0xce9e31 },
      { 77, 169, 0xefc629 }, { 78, 152, 0xefbe52 },
      { 71, 166, 0x4a3d10 }, { 66, 164, 0xbd9229 },
      { 83, 163, 0x191410 },
    },
    [5] = {
      { 71, 147, 0x524921 }, { 65, 143, 0xf7e77b },
      { 78, 144, 0xf7e373 }, { 71, 140, 0x191c19 },
      { 72, 165, 0x191408 }, { 72, 154, 0x5a4119 },
      { 67, 161, 0xdeaa31 }, { 66, 154, 0xdeaa4a },
      { 72, 169, 0xe6c242 }, { 72, 171, 0x5a4900 },
    },
    [6] = {
      { 72, 142, 0xdebe63 }, { 77, 148, 0xe6c263 },
      { 72, 147, 0x291400 }, { 65, 155, 0xe6aa31 },
      { 72, 165, 0x191408 }, { 72, 156, 0x422021 },
      { 72, 170, 0xbd9629 }, { 72, 169, 0xf7c231 },
      { 79, 170, 0x211c10 }, { 79, 161, 0xe6aa29 },
    },
    [7] = {
      { 66, 144, 0xdece73 }, { 78, 144, 0xffdb7b },
      { 71, 169, 0xf7c229 }, { 70, 148, 0x313119 },
      { 66, 168, 0x101410 }, { 77, 168, 0x101419 },
      { 71, 171, 0x101010 }, { 71, 141, 0x423d29 },
      { 79, 141, 0x292819 },
    },
    [8] = {
      { 72, 142, 0xd6be6b }, { 72, 169, 0xefce29 },
      { 72, 165, 0x210c00 }, { 72, 158, 0x4a3510 },
      { 72, 151, 0x312400 }, { 72, 147, 0x100400 },
      { 64, 153, 0x3a3108 }, { 80, 154, 0x191410 },
      { 79, 160, 0xdeb229 }, { 65, 163, 0xe6ba29 },
    },
    [9] = {
      { 72, 142, 0xd6c27b }, { 72, 147, 0x101000 },
      { 72, 154, 0x191800 }, { 72, 165, 0x100c00 },
      { 65, 164, 0xe6b629 }, { 63, 164, 0x312d10 },
      { 66, 161, 0x292010 }, { 79, 157, 0xe6aa29 },
      { 79, 169, 0x3a3110 }, { 72, 169, 0xefc629 },
    },
    [10] = {
      { 54, 148, 0xefc663 }, { 55, 150, 0x5a4121 },
      { 65, 160, 0x5a4119 }, { 72, 155, 0x3a3919 },
      { 72, 154, 0x423d21 }, { 81, 147, 0x100c00 },
      { 81, 156, 0x190800 }, { 85, 168, 0xf7be29 },
      { 88, 159, 0xe6a621 }, { 70, 167, 0x081821 },
    },
    [11] = {
      { 57, 147, 0xe6c663 }, { 67, 159, 0xce9229 },
      { 64, 169, 0xe6c229 }, { 58, 151, 0x212010 },
      { 76, 151, 0x212010 }, { 73, 159, 0x19313a },
      { 77, 168, 0x101410 }, { 84, 169, 0xe6c229 },
      { 86, 156, 0x5a4d21 }, { 83, 143, 0xf7e77b },
    },
    [12] = {
      { 54, 148, 0xefc663 }, { 62, 143, 0xf7e373 },
      { 61, 169, 0xefc229 }, { 72, 168, 0x5a5529 },
      { 79, 167, 0xf7c629 }, { 80, 147, 0x311c10 },
      { 75, 154, 0x192429 }, { 84, 155, 0xdea229 },
      { 83, 164, 0x292408 }, { 87, 168, 0xf7c229 },
    },
  }
  local result = nil
  if not list[cha] or multiColorS(list[cha]) then
    result = true
  end
  if (not __keepScreenState) then keepScreen(false) end
  return result
end

--  是否在章节信息面板
battle.isChapterInfoPanel = function()
  local __keepScreenState = keepScreenState
  if not __keepScreenState then keepScreen(true) end
  local list = {
    { 476, 271, 0xe6efe6 }, { 833, 280, 0xefefef },
    { 1404, 282, 0xeff3f7 }, { 1561, 283, 0xadaaad },
    { 1522, 755, 0xffae10 }, { 1273, 691, 0xffdb52 },
    { 1271, 747, 0xffa619 }, { 1391, 713, 0xffffff },
    { 854, 339, 0x4a4d4a },
    { 896, 342, 0xdedfde }, { 1376, 349, 0xdedbde },
    { 1319, 708, 0xffffff }, { 1322, 720, 0xffca3a },
    { 1342, 729, 0xf7b219 }, { 1355, 718, 0xffffff },
    { 1383, 717, 0xffffff }, { 1397, 713, 0xbd9629 },
  }
  local result = multiColorS(list)
  if not __keepScreenState then keepScreen(false) end
  return result
end

-- 前往选择舰队面板
battle.clickGotoSelectFleedPanelBtn = function()
  RTap({ 1388, 720 }, 100)
end

--  是否在选择舰队面板
battle.isSelectFleetPanel = function()
  local __keepScreenState = keepScreenState
  if not __keepScreenState then keepScreen(true) end
  local list = {
    { 143, 112, 0xeff3f7 }, { 732, 114, 0xeff3f7 }, { 1319, 115, 0xeff3f7 }, { 1666, 115, 0xa4aaa4 },
    { 1771, 116, 0x9caa9c }, { 1478, 907, 0xf7db4a }, { 1557, 900, 0xffdf52 }, { 1672, 907, 0xf7db4a },
    { 1699, 949, 0xffaa19 }, { 1493, 964, 0xf7ae19 }, { 1507, 931, 0xffffff }, { 1547, 931, 0xffffff },
    { 1579, 931, 0xffffff }, { 1625, 933, 0xffffff }, { 1662, 937, 0xffffff }, { 1662, 924, 0xffffff },
    { 1603, 904, 0xf7db4a }, { 1574, 716, 0xffd752 }, { 1686, 717, 0xdedfde }, { 1691, 488, 0xdedfde },
    { 1567, 280, 0xffd752 }, { 1567, 355, 0xffa229 }, { 1691, 291, 0xdee3e6 }, { 1689, 348, 0x84868c },
    { 1574, 303, 0x733110 }, { 1549, 479, 0xffdb5a }, { 1657, 545, 0xd6d2d6 }, { 1714, 485, 0xd6dfde },
    { 1550, 509, 0x5a2d00 }, { 1677, 507, 0x313d3a },
  }
  local list2 = {
    { 157, 125, 0x292429 }, { 744, 119, 0xeff3f7 }, { 1480, 121, 0xeff3f7 },
    { 1767, 120, 0x9caa9c }, { 1701, 955, 0xf7a210 }, { 1468, 954, 0xffaa19 }, { 1472, 888, 0xe6c252 },
    { 1620, 905, 0xf7db4a }, { 1608, 927, 0xffffff }, { 1534, 285, 0xffdb52 }, { 1577, 309, 0x7b3510 },
    { 1604, 328, 0xffa229 }, { 1654, 285, 0xdee3e6 }, { 1690, 306, 0xdedfe6 }, { 1724, 320, 0x848684 },
    { 1553, 485, 0xffdb5a }, { 1587, 505, 0x733110 }, { 1686, 491, 0xdedfde }, { 1684, 513, 0x313542 },
  }
  local result = multiColorS(list) or multiColorS(list2)
  if not __keepScreenState then keepScreen(false) end
  return result
end

--  是否在困难选择舰队面板
battle.isHardSelectFleetPanel = function()
  local __keepScreenState = keepScreenState
  if not __keepScreenState then keepScreen(true) end
  local list = {
    { 155, 123, 0x292429 }, { 833, 127, 0xeff3f7 },
    { 1604, 118, 0xeff3f7 }, { 1671, 120, 0x9caa9c },
    { 1753, 121, 0xadaaad }, { 1699, 132, 0xf7db42 },
    { 1720, 157, 0xf7ce42 }, { 1727, 143, 0xadaaad },
    { 1708, 161, 0xadaaad }, { 1709, 145, 0xffd742 },
    { 170, 150, 0xffc642 }, { 187, 154, 0xa47d10 },
    { 212, 154, 0xe6b631 }, { 215, 154, 0x080c08 },
    { 278, 144, 0x3a413a }, { 257, 168, 0x292d29 },
    { 251, 163, 0xffba00 }, { 318, 148, 0xc5a63a },
    { 295, 139, 0x292429 }, { 329, 179, 0x3a3d3a },

    { 1531, 308, 0xf7db52 }, { 1536, 302, 0x633910 },
    { 1550, 305, 0xe6be52 }, { 1560, 305, 0xffd24a },
    { 1559, 314, 0xffc252 }, { 1555, 318, 0x633110 },
    { 1541, 322, 0xffc652 }, { 1541, 314, 0xf7c652 },
    { 1536, 325, 0x633100 }, { 1554, 327, 0x632400 },
    { 1572, 300, 0x732808 }, { 1595, 300, 0x633100 },
    { 1577, 316, 0xf7a63a }, { 1574, 326, 0x733508 },
    { 1596, 320, 0x6b3d21 }, { 1588, 324, 0xffa631 },
    { 1585, 316, 0xf7a231 }, { 1604, 303, 0xf7a629 },
    { 1583, 303, 0xffae3a }, { 1584, 329, 0xffaa21 },
  }
  local result = multiColorS(list)
  if not __keepScreenState then keepScreen(false) end
  return result
end

-- 困难进入战斗
battle.clickHardGotoSelectFleedPanelBtn = function()
  RTap({ 1588, 934 }, 100)
end

-- 取消第二个舰队
battle.clickSelectFleetPanelCancel2Fleet = function(fleet)
  local __keepScreenState = keepScreenState
  if __keepScreenState then keepScreen(true) end
  RTap({ 1690, 522 }, 100)
  if not __keepScreenState then keepScreen(false) end
  return
end

-- 选择第一个舰队
battle.clickSelectFleetPanelSelect1Fleet = function(fleet)
  return co(c.create(function()
    local __keepScreenState = keepScreenState
    if __keepScreenState then keepScreen(true) end
    RTap({ 1565, 314 }, 100)
    c.yield(sleepPromise(500))
    if fleet == 1 then
      RTap({ 1622, 414 }, 100)
    elseif fleet == 2 then
      RTap({ 1629, 487 }, 100)
    elseif fleet == 3 then
      RTap({ 1625, 562 }, 100)
    elseif fleet == 4 then
      RTap({ 1625, 634 }, 100)
    elseif fleet == 5 then
      RTap({ 1622, 712 }, 100)
    elseif fleet == 6 then
      RTap({ 1620, 788 }, 100)
    end
    if not __keepScreenState then keepScreen(false) end
    return
  end))
end

-- 选择第二个舰队
battle.clickSelectFleetPanelSelect2Fleet = function(fleet)
  return co(c.create(function()
    local __keepScreenState = keepScreenState
    if __keepScreenState then keepScreen(true) end
    RTap({ 1568, 518 }, 100)
    c.yield(sleepPromise(500))
    if fleet == 1 then
      RTap({ 1621, 615 }, 100)
    elseif fleet == 2 then
      RTap({ 1619, 688 }, 100)
    elseif fleet == 3 then
      RTap({ 1627, 763 }, 100)
    elseif fleet == 4 then
      RTap({ 1623, 836 }, 100)
    elseif fleet == 5 then
      RTap({ 1620, 911 }, 100)
    elseif fleet == 6 then
      RTap({ 1627, 988 }, 100)
    end
    if not __keepScreenState then keepScreen(false) end
    return
  end))
end

-- 点击舰队
battle.clickFleet = function(clickFleetList)
  if type(clickFleetList) ~= 'table' then
    clickFleetList = { clickFleetList }
  end
  for _, fleet in ipairs(clickFleetList) do
    if fleet == 1 then
      RTap({ 479, 842 }, 100)
    elseif fleet == 2 then
      RTap({ 689, 844 }, 100)
    elseif fleet == 3 then
      RTap({ 901, 843 }, 100)
    elseif fleet == 4 then
      RTap({ 1119, 845 }, 100)
    end
    mSleep(50)
  end
end


-- 前往地图
battle.clickGotoMapBtn = function()
  RTap({ 1588, 934 }, 100)
end

--  是否在地图页面
battle.isMapPage = function()
  local __keepScreenState = keepScreenState
  if not __keepScreenState then keepScreen(true) end
  local list = {
    { 16, 19, 0xdee3de }, { 824, 17, 0xeff3f7 },
    { 1021, 35, 0x3a3d3a }, { 1332, 33, 0xffef5a },
    { 1647, 35, 0xff4573 }, { 1074, 1021, 0xeff3ef },
    { 1404, 998, 0xf7f7f7 }, { 1692, 1003, 0xf7fbf7 },
    { 895, 993, 0xdedfde }, { 938, 1020, 0xbdbabd },
    { 420, 47, 0x000000 }, { 447, 47, 0x000000 },
    { 459, 44, 0xefefff }, { 516, 50, 0xefebff },
    { 556, 44, 0xf7f3ff },
  }
  local result = multiColorS(list)
  if not __keepScreenState then keepScreen(false) end
  return result
end

-- 检测是第几队
battle.scanMapCheckFleetNum = function()
  local __keepScreenState = keepScreenState
  keepScreen(true)
  local list1 = {
    { 301, 101, 0x424542 }, { 321, 94, 0xf7efbd },
    { 329, 111, 0x424142 }, { 318, 123, 0xf7c642 },
    { 311, 139, 0x424142 }, { 319, 152, 0x424142 },
    { 329, 137, 0x424131 }, { 324, 148, 0xffba00 },
    { 312, 109, 0xf7e39c },
  }
  local list2 = {
    { 305, 112, 0xefdf9c }, { 319, 105, 0x42453a },
    { 320, 95, 0xf7ebb5 }, { 324, 107, 0xf7df94 },
    { 334, 112, 0xffdf7b }, { 316, 126, 0xf7c24a },
    { 322, 136, 0xdeae21 }, { 301, 146, 0x424142 },
    { 324, 138, 0x424142 }, { 337, 144, 0x424142 },
  }
  local list3 = {
    { 302, 110, 0x524531 }, { 320, 106, 0x424542 },
    { 326, 108, 0xffe39c }, { 312, 118, 0x4a4d4a },
    { 316, 120, 0xffd763 }, { 308, 126, 0x424542 },
    { 306, 130, 0xefc242 }, { 320, 150, 0xffb600 },
    { 320, 140, 0x424542 }, { 338, 139, 0x424142 },
  }
  local list4 = {
    { 315, 90, 0x424142 }, { 332, 90, 0x424142 },
    { 334, 126, 0x4a4942 }, { 334, 141, 0x4a4121 },
    { 338, 134, 0x4a4942 }, { 315, 140, 0x424142 },
    { 315, 127, 0x424542 }, { 316, 116, 0x6b5d4a },
    { 299, 139, 0x4a4542 }, { 306, 107, 0x3a3d3a },
    { 314, 94, 0xfff7c5 }, { 329, 94, 0xf7e7b5 },
    { 302, 137, 0xe6be21 }, { 323, 148, 0xde9a08 },
    { 335, 134, 0xefb219 }, { 329, 113, 0xffdb73 },
  }
  local result = 1
  if multiColorS(list1) then
    result = 1
  elseif multiColorS(list2) then
    result = 2
  elseif multiColorS(list3) then
    result = 3
  elseif multiColorS(list4) then
    result = 4
  end
  if not __keepScreenState then keepScreen(false) end
  return result
end

-- 是否选中指定舰队
battle.getSelectedFleed = function()
  local __keepScreenState = keepScreenState
  if not __keepScreenState then keepScreen(true) end
  local result
  local list1 = {
    { 301, 105, 0x424542 }, { 325, 90, 0x424142 }, { 318, 152, 0x424142 }, { 311, 134, 0x42453a },
    { 329, 129, 0x4a4542 }, { 320, 146, 0xf7b210 }, { 318, 132, 0xf7c221 }, { 324, 111, 0xffe38c },
    { 307, 107, 0xffdf9c }, { 325, 95, 0xffe3ad },
  }
  local list2 = {
    { 302, 109, 0x4a4942 }, { 313, 115, 0x424542 }, { 319, 105, 0x423531 }, { 337, 147, 0x424142 },
    { 301, 146, 0x424142 }, { 318, 153, 0x424142 }, { 313, 124, 0x42413a }, { 317, 117, 0x4a4542 },
    { 331, 148, 0xf7ba08 }, { 309, 145, 0xf7ba08 }, { 324, 139, 0x424142 }, { 328, 139, 0x313531 },
    { 329, 129, 0x4a393a }, { 323, 129, 0xf7c231 }, { 323, 115, 0xffdb7b }, { 323, 96, 0xffebb5 },
    { 310, 110, 0xffe394 }, { 325, 114, 0xf7db7b },
  }
  local list3 = {
    { 305, 95, 0x4a493a }, { 336, 97, 0x4a4931 }, { 335, 118, 0x52493a }, { 339, 135, 0x524d42 },
    { 332, 151, 0x424531 }, { 312, 153, 0x3a3529 }, { 303, 140, 0x525142 }, { 313, 126, 0x424142 },
    { 312, 115, 0x424542 }, { 301, 110, 0x424142 }, { 307, 109, 0xffdf9c }, { 318, 120, 0xffce5a },
    { 312, 132, 0xf7c229 }, { 327, 134, 0xf7be19 }, { 333, 124, 0xffc652 }, { 333, 111, 0xffdf8c },
    { 320, 108, 0x4a4542 }, { 320, 136, 0x4a4142 }, { 320, 148, 0xf7be08 }, { 310, 140, 0xf7be10 },
  }
  local list4 = {
    { 308, 100, 0x524d42 }, { 320, 90, 0x424142 }, { 328, 94, 0xffebb5 }, { 315, 125, 0x5a4931 },
    { 303, 136, 0xf7ba19 }, { 314, 140, 0x424542 }, { 325, 146, 0xf7ba00 }, { 329, 151, 0x424531 },
    { 334, 133, 0xffba10 }, { 337, 136, 0x524d42 }, { 315, 141, 0x4a4931 }, { 322, 146, 0xffba08 },
    { 322, 126, 0xf7c642 }, { 303, 129, 0xf7c23a }, { 316, 118, 0x63553a }, { 326, 110, 0xffdf8c },
    { 324, 98, 0xffebb5 }, { 316, 105, 0xf7e39c }, { 309, 117, 0xf7d76b }, { 334, 125, 0x424531 },
  }
  local list5 = {
    { 205, 149, 0x6392a4 }, { 210, 124, 0xfffbf7 },
    { 220, 119, 0xe6f3e6 }, { 228, 122, 0xfffbf7 },
    { 235, 131, 0xfffbf7 }, { 247, 125, 0xf7fbf7 },
    { 266, 122, 0xfffbf7 }, { 290, 120, 0xfffbf7 },
  }
  local list6 = {
    { 205, 149, 0x6392a4 }, { 210, 124, 0xfffbf7 },
    { 220, 119, 0xe6f3e6 }, { 228, 122, 0xfffbf7 },
    { 235, 131, 0xfffbf7 }, { 247, 125, 0xf7fbf7 },
    { 266, 122, 0xfffbf7 }, { 290, 120, 0xfffbf7 },
  }
  if multiColorS(list1) then
    result = 1
  elseif multiColorS(list2) then
    result = 2
  elseif multiColorS(list3) then
    result = 3
  elseif multiColorS(list4) then
    result = 4
  elseif multiColorS(list5) then
    result = 5
  elseif multiColorS(list6) then
    result = 6
  end
  if not __keepScreenState then keepScreen(false) end
  return result
end

-- 地图点击切换舰队按钮
battle.clickSwitchFleetBtn = function()
  RTap({ 1426, 1003 }, 100)
end

-- 地图点击迎击
battle.clickAttackBtn = function()
  RTap({ 1740, 1005 }, 100)
end

battle.getFleetFormation = function()
  local __keepScreenState = keepScreenState
  if not __keepScreenState then keepScreen(true) end
  local result
  local listSingleFile = {
    { 451, 175, 0x08ebbd }, { 451, 188, 0x08e7b5 },
    { 452, 202, 0x08ebbd }, { 452, 216, 0x08ebbd },
    { 452, 231, 0x00e7b5 }, { 452, 244, 0x08ebbd },
  }
  local listSingleFile2 = {
    { 346, 174, 0x08ebbd }, { 347, 188, 0x08e7b5 },
    { 347, 202, 0x08e7b5 }, { 348, 216, 0x08ebbd },
    { 347, 230, 0x08e7b5 }, { 348, 244, 0x08ebbd },
  }
  local listDoubleFile = {
    { 439, 180, 0x08e7b5 }, { 466, 180, 0x08ebbd },
    { 437, 205, 0x08ebbd }, { 468, 203, 0x00e7b5 },
    { 436, 230, 0x08ebbd }, { 470, 230, 0x08ebbd },
  }
  local listDoubleFile2 = {
    { 334, 180, 0x08ebbd }, { 361, 179, 0x08ebbd },
    { 332, 204, 0x08ebbd }, { 363, 203, 0x08ebbd },
    { 332, 229, 0x00e7b5 }, { 365, 230, 0x00e7bd },
  }
  local listWheeledFile = {
    { 452, 178, 0x08ebbd }, { 452, 196, 0x08ebbd },
    { 452, 215, 0x00e7b5 }, { 452, 236, 0x08ebbd },
    { 425, 205, 0x08ebbd }, { 478, 205, 0x00e7b5 },
  }
  local listWheeledFile2 = {
    { 347, 177, 0x08ebbd }, { 347, 195, 0x08ebbd },
    { 347, 214, 0x08e7b5 }, { 347, 235, 0x08ebbd },
    { 320, 206, 0x08ebbd }, { 373, 205, 0x08ebbd },
  }
  if multiColorS(listSingleFile) or multiColorS(listSingleFile2) then
    result = 'single file'
  elseif multiColorS(listDoubleFile) or multiColorS(listDoubleFile2) then
    result = 'double file'
  elseif multiColorS(listWheeledFile) or multiColorS(listWheeledFile2) then
    result = 'wheeled file'
  end

  if not __keepScreenState then keepScreen(false) end
  return result
end

-- 检测阵型面板是否打开
battle.isFormationPanel = function()
  local __keepScreenState = keepScreenState
  if not __keepScreenState then keepScreen(true) end
  local list = {
    { 1591, 527, 0xffe742 }, { 1591, 577, 0xffef31 },
    { 1593, 553, 0xffef3a }, { 1615, 552, 0xffe73a },
    { 1605, 542, 0xffe73a }, { 1605, 563, 0xffeb3a },
    { 1596, 563, 0xffe731 }, { 1597, 550, 0xffe73a },
  }
  local result = multiColorS(list)
  if not __keepScreenState then keepScreen(false) end
  return result
end

-- 打开阵型面板
battle.openFormationPanel = function()
  RTap({ 1883, 551 }, 100)
end

-- 改变阵型
battle.changeFormationPanelFormation = function()
  RTap({ 1712, 549 }, 100)
end

-- 关闭阵型面板
battle.closeFormationPanel = function()
  RTap({ 1603, 553 }, 100)
end

-- 检测敌方伏击面板
battle.isAmbushedPanel = function()
  local __keepScreenState = keepScreenState
  if not __keepScreenState then keepScreen(true) end
  local list = {
    { 369, 678, 0x527119 }, { 399, 671, 0x527521 },
    { 428, 680, 0xfffbf7 }, { 803, 562, 0xf7ca3a },
    { 955, 565, 0xffffff }, { 1055, 597, 0xffa619 },
    { 1237, 540, 0xe6e7e6 }, { 1349, 568, 0xffffff },
    { 1485, 593, 0xc5bebd }, { 1200, 685, 0x5a595a },
  }
  local result = multiColorS(list)
  if not __keepScreenState then keepScreen(false) end
  return result
end

-- 迎击伏击
battle.ambushedPanelClickInterceptBtn = function()
  RTap({ 922, 571 }, 100)
end

-- 躲避伏击
battle.ambushedPanelClickAvoidBtn = function()
  RTap({ 1351, 564 }, 100)
end

-- 检测信息弹窗
battle.isInfomationModal = function()
  local __keepScreenState = keepScreenState
  if not __keepScreenState then keepScreen(true) end
  local list = {
    { 463, 250, 0xeff3f7 }, { 938, 261, 0xe6f3f7 },
    { 1447, 255, 0xadaaad }, { 1391, 282, 0xf7ce42 },
    { 845, 709, 0xffdf52 }, { 947, 707, 0xffdb52 },
    { 1093, 708, 0x943d00 }, { 960, 778, 0xffba21 },
    { 840, 775, 0xf7b219 }, { 1088, 776, 0xffb221 },
    { 920, 726, 0xffffff }, { 954, 746, 0xffffff },
    { 984, 746, 0xffffff }, { 998, 774, 0xffb221 },
  }
  local result = multiColorS(list)
  if not __keepScreenState then keepScreen(false) end
  return result
end

-- 关闭信息弹窗
battle.infomationModalClickClose = function()
  RTap({ 1391, 281 }, 100)
end

-- 移动到敌人
battle.moveToEnemy = function(point)
  RTap({ point[1], point[2] }, 100)
end

-- 检测准备战斗面板
battle.isReadyBattlePage = function()
  local __keepScreenState = keepScreenState
  if not __keepScreenState then keepScreen(true) end
  local list = {
    { 16, 10, 0xe6ebef }, { 762, 13, 0xe6f3f7 },
    { 1272, 190, 0xfffbff }, { 1897, 197, 0xf7f3f7 },
    { 1888, 499, 0xe6efe6 }, { 1266, 488, 0xfffbff },
    { 1394, 893, 0xd6f3f7 }, { 1761, 899, 0xd6f3f7 },
    { 1772, 1001, 0x8ccace }, { 1397, 985, 0x9cdbe6 },
    { 156, 15, 0x292829 }, { 320, 11, 0x3a4142 },
    { 188, 29, 0xf7db84 }, { 227, 39, 0xffca31 },
    { 286, 49, 0xffba00 }, { 243, 51, 0xf7b219 },
    { 254, 26, 0x100c10 }, { 200, 39, 0x080808 },
    { 235, 48, 0x080c08 }, { 292, 22, 0x42454a },
  }
  local result = multiColorS(list, 85)
  if not __keepScreenState then keepScreen(false) end
  return result
end

-- 准备战斗面板点击出击
battle.readyBattlePageClickBattle = function()
  RTap({ 1592, 952 }, 100)
end

-- 检测是否在战斗中
battle.isInBattlePage = function()
  local __keepScreenState = keepScreenState
  if not __keepScreenState then keepScreen(true) end
  local list = {
    { 1815, 38, 0xdedfde }, { 1838, 39, 0xdedbd6 }, { 1870, 43, 0xdedbd6 }, { 1878, 97, 0xdedfde },
    { 1861, 70, 0x313531 }, { 1833, 72, 0x3a393a }, { 1832, 88, 0x423d42 }, { 1831, 101, 0xe6dfde },
    { 1845, 80, 0xdedbde }, { 1845, 52, 0xdedbde }, { 1869, 480, 0x636163 }, { 1882, 475, 0x525552 },
    { 1896, 468, 0x4a4d52 }, { 1906, 611, 0x3a3d42 }, { 1871, 591, 0x636163 }, { 1858, 544, 0xefebef },
    { 1872, 540, 0xdedfde }, { 1883, 541, 0xd6d2d6 }, { 1886, 532, 0x52555a }, { 1884, 550, 0x52555a },
  }
  local result = multiColorS(list)
  if not __keepScreenState then keepScreen(false) end
  return result
end

-- 检测是否自动战斗
battle.isNotAutoBattle = function()
  local __keepScreenState = keepScreenState
  if not __keepScreenState then keepScreen(true) end
  local list = {
    { 145, 67, 0xffffff }, { 160, 75, 0xd6dbd6 },
    { 168, 84, 0xffffff }, { 143, 91, 0xffffff },
    { 181, 67, 0xffffff }, { 195, 77, 0xffffff },
    { 207, 88, 0xffffff }, { 220, 77, 0xf7fbf7 },
    { 235, 71, 0xffffff }, { 236, 86, 0xffffff },
    { 180, 80, 0xffffff }, { 188, 77, 0xf7f7f7 },
    { 188, 83, 0xeff3ef }, { 188, 88, 0xffffff },
    { 207, 88, 0xffffff }, { 205, 71, 0xffffff },
  }
  local result = multiColorS(list, 85)
  if not __keepScreenState then keepScreen(false) end
  return result
end

-- 检测是否自动战斗确认面板
battle.isAutoBattleConfirmPanel = function()
  local __keepScreenState = keepScreenState
  if not __keepScreenState then keepScreen(true) end
  local list = {
    { 477, 232, 0x292829 }, { 1437, 227, 0xadaaad },
    { 688, 329, 0xf7f7f7 }, { 785, 343, 0xe6e7e6 },
    { 904, 346, 0xfffbff }, { 998, 337, 0xdeebde },
    { 1127, 344, 0xeff3ef }, { 1206, 333, 0xeff3ef },
    { 862, 754, 0xffdb4a }, { 928, 775, 0xffffff },
  }
  local result = multiColorS(list)
  if not __keepScreenState then keepScreen(false) end
  return result
end

-- 自动战斗确认面板点击知道了
battle.autoBattleConfirmPanelClickOk = function()
  RTap({ 949, 779 }, 100)
end

-- 战斗页面点击自动战斗
battle.inBattlePageClickAutoBattle = function()
  RTap({ 208, 75 }, 100)
end

-- 点击潜艇出击按钮
battle.inBattleClickSSAttack = function()
  RTap({ 1006, 912 }, 100)
end

-- 检测是否胜利界面
battle.isVictoryPanel = function()
  local __keepScreenState = keepScreenState
  if not __keepScreenState then keepScreen(true) end
  -- 大获全胜
  local list = {
    { 557, 442, 0xf7d24a }, { 614, 492, 0xfffb5a },
    { 674, 555, 0xe67d31 }, { 853, 543, 0xef8a3a },
    { 1076, 484, 0xffff5a }, { 1211, 539, 0xef9242 },
    { 1350, 476, 0xffff5a }, { 523, 474, 0xffef9c },
    { 699, 441, 0x5a1c10 }, { 961, 439, 0x632410 },
    { 1132, 455, 0x632819 }, { 1299, 456, 0x5a2410 },
    { 1386, 481, 0x521c10 },
    { 257, 696, 0x423d42 }, { 563, 696, 0x423d42 },
    { 976, 699, 0x3a3d3a }, { 1398, 698, 0x424142 },
    { 1658, 698, 0x424142 },
    { 932, 474, 0x8c8183 }, { 1187, 492, 0x8c8a84 },
  }
  -- 战术碾压
  local list2 = {
    { 611, 440, 0xf7d74a }, { 666, 500, 0xfff35a },
    { 855, 479, 0xffff5a }, { 1110, 432, 0xffce52 },
    { 1218, 529, 0xefa63a }, { 1395, 482, 0xfffb5a },
    { 568, 468, 0x632419 }, { 902, 441, 0x5a2010 },
    { 987, 448, 0x632010 }, { 1234, 442, 0x6b2819 },
    { 537, 429, 0xfff394 }, { 1253, 565, 0x6b2410 },
    { 1295, 426, 0x632010 }, { 1080, 495, 0x632819 },

    { 294, 702, 0x424142 }, { 523, 697, 0x424142 },
    { 967, 698, 0x423d42 }, { 1424, 697, 0x3a3d3a },
  }
  -- 完成任务
  local list3 = {
    { 556, 437, 0x6bc6de }, { 615, 438, 0x6bcede },
    { 676, 472, 0xb5f3ff }, { 855, 472, 0xb5f3ff },
    { 1092, 546, 0x31b2c5 }, { 1163, 508, 0x94e3ef },
    { 1384, 430, 0x6bc6de }, { 647, 477, 0x10595a },
    { 845, 488, 0x104552 }, { 1052, 459, 0x10555a },

    { 309, 698, 0x424142 }, { 711, 701, 0x424142 },
    { 1189, 698, 0x424142 }, { 1584, 701, 0x423d3a },
  }
  -- 旗舰大破
  local list4 = {
    { 563, 438, 0xe6a273 }, { 844, 495, 0xde965a },
    { 1046, 479, 0xe6be9c }, { 1212, 461, 0xefc2a4 },
    { 1370, 471, 0xe6aa7b }, { 536, 454, 0x521810 },
    { 522, 467, 0xffebd6 }, { 863, 487, 0x5a1c10 },
    { 1088, 447, 0x632819 }, { 1386, 457, 0x521c08 },
    { 249, 698, 0x423d42 }, { 527, 696, 0x424142 },
    { 907, 697, 0x424142 }, { 1389, 697, 0x424142 },
    { 1636, 698, 0x424142 },
  }
  -- d 全军覆没
  local list5 = {
    { 550, 445, 0xde9e63 }, { 899, 476, 0xe6a273 },
    { 1088, 466, 0xefc6ad }, { 1219, 489, 0xdea673 },
    { 1420, 497, 0xe69e63 }, { 543, 422, 0x521808 },
    { 855, 458, 0x5a1c08 }, { 1012, 455, 0x632819 },
    { 1276, 463, 0x5a2410 }, { 1368, 480, 0x5a2010 },

    { 279, 726, 0x423d42 }, { 525, 700, 0x423d42 },
    { 955, 698, 0x423d42 }, { 1366, 698, 0x424142 },
    { 1687, 734, 0x424142 },
  }
  -- c 作战超时
  local list6 = {
    { 553, 441, 0xe69e6b }, { 584, 440, 0xefba94 },
    { 676, 439, 0xdeaa7b }, { 685, 534, 0xdea273 },
    { 565, 549, 0xefaa7b }, { 852, 441, 0xe69663 },
    { 844, 499, 0xde965a }, { 937, 484, 0xe6a67b },
    { 1087, 473, 0xefc6a4 }, { 1186, 522, 0xefceb5 },
    { 941, 533, 0xefaa7b }, { 997, 530, 0xdeb68c },
    { 1090, 519, 0xefc2a4 }, { 1159, 542, 0xefc6ad },
    { 1270, 507, 0xe6be9c }, { 1347, 504, 0xdeae84 },
    { 1387, 487, 0xefa67b }, { 1416, 441, 0xe69e6b },
    { 1423, 505, 0xe69e6b }, { 1391, 549, 0xe6a673 },

    { 383, 714, 0xef5d63 }, { 755, 711, 0xef6163 },
    { 1241, 713, 0xef6163 }, { 1327, 463, 0x632010 },
  }
  local result = false
  if multiColorS(list) or multiColorS(list2)
    or multiColorS(list3) or multiColorS(list4)
    or multiColorS(list5) or multiColorS(list6) then
    result = true
  end
  if not __keepScreenState then keepScreen(false) end
  return result
end

-- 胜利面板点击继续
battle.victoryPanelClickNext = function()
  RTap({ 952, 840 }, 100)
end

-- 检测是否获得道具面板
battle.isGetPropsPanel = function()
  local __keepScreenState = keepScreenState
  if not __keepScreenState then keepScreen(true) end
  local list = {
    { 763, 212, 0xf7ae63 }, { 854, 168, 0xffffff },
    { 958, 174, 0x845131 }, { 1054, 167, 0xf7f384 },
    { 764, 242, 0xffaa42 }, { 861, 232, 0x7b2408 },
    { 944, 240, 0xffffff }, { 1006, 268, 0xffdf3a },
    { 1098, 277, 0xf7b629 }, { 969, 809, 0xffffff },
  }
  local result = multiColorS(list)
  if not __keepScreenState then keepScreen(false) end
  return result
end

-- 获得道具面板点击继续
battle.getPropsPanelClickNext = function()
  RTap({ 952, 840 }, 100)
end

-- 检测是否获得新船面板
battle.isGetNewShipPanel = function()
  local __keepScreenState = keepScreenState
  if not __keepScreenState then keepScreen(true) end
  local list = {
    { 64, 504, 0xefefff }, { 108, 539, 0x7b7d8c },
    { 86, 658, 0xe6c2c5 }, { 91, 787, 0xe6d7ce },
    { 83, 906, 0x3acee6 }, { 88, 948, 0xcecece },
    { 1496, 852, 0xefefef }, { 1572, 909, 0xc5c2bd },
    { 1543, 938, 0xeff3ef },
  }
  local result = multiColorS(list)
  if not __keepScreenState then keepScreen(false) end
  return result
end

-- 获得新船面板点击继续
battle.getNewShipPanelClickNext = function()
  RTap({ 952, 840 }, 100)
end

-- 检测是否锁定新船面板
battle.isLockNewShipPanel = function()
  local __keepScreenState = keepScreenState
  if not __keepScreenState then keepScreen(true) end
  local list = {
    { 477, 265, 0x292829 }, { 1442, 262, 0xadaaad },
    { 746, 256, 0xeff3f7 }, { 1275, 259, 0xeff3f7 },
    { 1247, 307, 0xdedfde }, { 747, 300, 0x000000 },
    { 643, 716, 0xdee7de }, { 1100, 723, 0xf7ce42 },
    { 1299, 724, 0xf7ce42 }, { 822, 726, 0xe6e3e6 },
    { 813, 495, 0xfffff7 }, { 855, 501, 0xfffff7 },
    { 897, 506, 0x9cf34a }, { 939, 505, 0xadf74a },
    { 953, 529, 0xadf74a }, { 986, 513, 0xfffff7 },
    { 1025, 511, 0xf7f7ef }, { 1065, 516, 0xfffff7 },
  }
  local result = multiColorS(list)
  if not __keepScreenState then keepScreen(false) end
  return result
end

-- 锁定新船面板点击继续
battle.lockNewShipPanelClickNext = function()
  RTap({ 1186, 742 }, 100)
end

-- 检测是否获得经验面板
battle.isGetExpPanel = function()
  local __keepScreenState = keepScreenState
  if not __keepScreenState then keepScreen(true) end
  local list = {
    { 554, 287, 0x68686b }, { 590, 290, 0x69686e }, { 647, 287, 0x6b686b }, { 691, 287, 0x6b696b },
    { 750, 286, 0x68686e }, { 821, 285, 0x6a696b }, { 892, 288, 0x6b676f }, { 969, 286, 0x6b696b },
    { 1026, 286, 0x67676f }, { 1088, 286, 0x686868 }, { 542, 291, 0x6b696b }, { 632, 287, 0x6b6963 },
    { 693, 285, 0x73696b }, { 858, 289, 0x6b6963 }, { 821, 286, 0x6b696b }, { 954, 286, 0x73696b },
    { 997, 287, 0x6b696b }, { 1041, 287, 0x6b696b }, { 909, 285, 0x73696b }, { 754, 285, 0x6b6963 },
  }
  local result = multiColorS(list)
  if not __keepScreenState then keepScreen(false) end
  return result
end

-- 获得经验面板点击继续
battle.getExpPanelClickNext = function()
  RTap({ 1671, 914 }, 100)
end

-- 点击返回主页
battle.battlePageClickBackToHome = function()
  RTap({ 46, 37 }, 100)
end

-- 检测是否紧急委托面板
battle.isUrgentEntrustmentPanel = function()
  local __keepScreenState = keepScreenState
  if not __keepScreenState then keepScreen(true) end
  local list = {
    { 482, 289, 0x212821 }, { 493, 288, 0xffce3a },
    { 534, 293, 0x080808 }, { 567, 292, 0xf7c23a },
    { 752, 302, 0x000000 }, { 1047, 301, 0xdedfde },
    { 835, 737, 0xffca3a }, { 919, 740, 0xffffff },
    { 977, 745, 0xefb231 }, { 1002, 736, 0xfff7f7 },
  }
  local result = multiColorS(list)
  if not __keepScreenState then keepScreen(false) end
  return result
end

-- 紧急委托面板点击继续
battle.urgentEntrustmentPanelClickOk = function()
  RTap({ 957, 739 }, 100)
end

return battle