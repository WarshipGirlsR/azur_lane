local co = require '../lib/co'
local c = coroutine
local sleepPromise = require '../utils/sleep-promise'


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
    { 13, 11, 0xdedfe6 }, { 10, 54, 0xcecace },
    { 38, 36, 0xefce42 }, { 68, 31, 0xefce3a },
    { 125, 56, 0xc5c2c5 }, { 892, 51, 0xd6dbde },
    { 930, 7, 0xeff3f7 }, { 248, 23, 0xffe7ad },
    { 257, 24, 0x292829 }, { 276, 22, 0x211c21 },
    { 232, 45, 0x313131 }, { 256, 45, 0x313531 },
    { 264, 47, 0xffba00 }, { 273, 47, 0x3a353a },
    { 284, 47, 0xffba00 }, { 293, 45, 0x313131 },
    { 302, 45, 0xffba00 }, { 308, 45, 0x191819 },
    { 321, 43, 0xffbe10 }, { 332, 44, 0x424142 },
    { 426, 42, 0x000000 }, { 438, 42, 0xefefff },
    { 545, 42, 0xdee7f7 }, { 573, 45, 0x000000 },
    { 559, 45, 0xd6d2de }, { 394, 43, 0x3a393a },
  }
  local result = multiColorS(list)
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
  local list = {
    { 170, 1004, 0xc50808 }, { 201, 1008, 0xf7f7f7 },
    { 230, 1021, 0xeff3ef }, { 281, 1034, 0x5a0c08 },
  }
  local list2 = {
    { 72, 973, 0xffffff }, { 152, 991, 0xbd0408 },
    { 164, 1005, 0xbd0408 }, { 261, 1025, 0x631010 },
  }
  local result = multiColorS(list) or multiColorS(list2)
  if not __keepScreenState then keepScreen(false) end
  return result
end

--  是否在困难模式
battle.isHardMode = function()
  local __keepScreenState = keepScreenState
  if not __keepScreenState then keepScreen(true) end
  local list = {
    { 180, 1007, 0x002d6b }, { 207, 1009, 0xf7f7f7 },
    { 244, 1021, 0xf7f3f7 }, { 277, 1033, 0x102042 },
  }
  local list2 = {
    { 109, 985, 0xdedbde }, { 189, 994, 0x001029 },
    { 281, 1004, 0x103984 }, { 284, 1032, 0x21284a },
  }
  local result = multiColorS(list) or multiColorS(list2)
  if not __keepScreenState then keepScreen(false) end
  return result
end

-- 切换困难模式按钮
battle.clickSwitchHardModeBtn = function()
  RTap({ 202, 1010 }, 100)
end

-- 移动到m章节
battle.moveToChapter = function(chapter)
  local chapter = chapter
  local __keepScreenState = keepScreenState
  if not __keepScreenState then keepScreen(true) end

  local chapterArr = strSplit(chapter, "-")
  local m = tonumber(chapterArr[1]) or 1

  if string.sub(chapter, 1, 5) == 'event' then
    m = tonumber(chapterArr[2]) or 1
  end

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
battle.clickChapter = function(chapter)
  local __keepScreenState = keepScreenState
  if not __keepScreenState then keepScreen(true) end

  if (chapter == '1-1') then
    RTap({ 227, 687 }, 100)
  elseif (chapter == '1-2') then
    RTap({ 685, 409 }, 100)
  elseif (chapter == '1-3') then
    RTap({ 984, 789 }, 100)
  elseif (chapter == '1-4') then
    RTap({ 1366, 317 }, 100)
  elseif (chapter == '2-1') then
    RTap({ 1221, 685 }, 100)
  elseif (chapter == '2-2') then
    RTap({ 1121, 277 }, 100)
  elseif (chapter == '2-3') then
    RTap({ 429, 406 }, 100)
  elseif (chapter == '2-4') then
    RTap({ 572, 821 }, 100)
  elseif (chapter == '3-1') then
    RTap({ 603, 320 }, 100)
  elseif (chapter == '3-2') then
    RTap({ 344, 750 }, 100)
  elseif (chapter == '3-3') then
    RTap({ 1364, 279 }, 100)
  elseif (chapter == '3-4') then
    RTap({ 923, 540 }, 100)
  elseif (chapter == '4-1') then
    RTap({ 355, 451 }, 100)
  elseif (chapter == '4-2') then
    RTap({ 628, 701 }, 100)
  elseif (chapter == '4-3') then
    RTap({ 1234, 818 }, 100)
  elseif (chapter == '4-4') then
    RTap({ 1167, 430 }, 100)
  elseif (chapter == '5-1') then
    RTap({ 363, 544 }, 100)
  elseif (chapter == '5-2') then
    RTap({ 1285, 803 }, 100)
  elseif (chapter == '5-3') then
    RTap({ 1104, 549 }, 100)
  elseif (chapter == '5-4') then
    RTap({ 884, 318 }, 100)
  elseif (chapter == '6-1') then
    RTap({ 1373, 746 }, 100)
  elseif (chapter == '6-2') then
    RTap({ 1055, 515 }, 100)
  elseif (chapter == '6-3') then
    RTap({ 632, 317 }, 100)
  elseif (chapter == '6-4') then
    RTap({ 443, 643 }, 100)
  elseif (chapter == '7-1') then
    RTap({ 308, 725 }, 100)
  elseif (chapter == '7-2') then
    RTap({ 688, 270 }, 100)
  elseif (chapter == '7-3') then
    RTap({ 1234, 425 }, 100)
  elseif (chapter == '7-4') then
    RTap({ 1416, 674 }, 100)
  elseif (chapter == '8-1') then
    RTap({ 824, 280 }, 100)
  elseif (chapter == '8-2') then
    RTap({ 411, 535 }, 100)
  elseif (chapter == '8-3') then
    RTap({ 507, 849 }, 100)
  elseif (chapter == '8-4') then
    RTap({ 1168, 686 }, 100)
  elseif (chapter == '9-1') then
    RTap({ 360, 359 }, 100)
  elseif (chapter == '9-2') then
    RTap({ 569, 729 }, 100)
  elseif (chapter == '9-3') then
    RTap({ 1179, 395 }, 100)
  elseif (chapter == '9-4') then
    RTap({ 1375, 768 }, 100)
  elseif (chapter == '10-1') then
    RTap({ 301, 362 }, 100)
  elseif (chapter == '10-2') then
    RTap({ 694, 571 }, 100)
  elseif (chapter == '10-3') then
    RTap({ 971, 806 }, 100)
  elseif (chapter == '10-4') then
    RTap({ 1111, 336 }, 100)
  elseif (chapter == '11-1') then
    RTap({ 453, 348 }, 100)
  elseif (chapter == '11-2') then
    RTap({ 643, 779 }, 100)
  elseif (chapter == '11-3') then
    RTap({ 1077, 255 }, 100)
  elseif (chapter == '11-4') then
    RTap({ 1335, 665 }, 100)
  elseif (chapter == '12-1') then
    RTap({ 296, 362 }, 100)
  elseif (chapter == 'event4-1-sp1') then
    RTap({ 834, 312 }, 100)
  elseif (chapter == 'event4-1-sp2') then
    RTap({ 417, 542 }, 100)
  elseif (chapter == 'event4-1-sp3') then
    RTap({ 1392, 473 }, 100)
  elseif (chapter == 'event5-1-a1') then
    RTap({ 655, 268 }, 100)
  elseif (chapter == 'event5-1-a2') then
    RTap({ 1100, 781 }, 100)
  elseif (chapter == 'event5-1-a3') then
    RTap({ 1340, 381 }, 100)
  elseif (chapter == 'event5-2-b1') then
    RTap({ 532, 778 }, 100)
  elseif (chapter == 'event5-2-b2') then
    RTap({ 1305, 744 }, 100)
  elseif (chapter == 'event5-2-b3') then
    RTap({ 1058, 333 }, 100)
  elseif (chapter == 'event6-1-sp1') then
    RTap({ 404, 414 }, 100)
  elseif (chapter == 'event6-1-sp2') then
    RTap({ 569, 808 }, 100)
  elseif (chapter == 'event6-1-sp3') then
    RTap({ 1240, 592 }, 100)
  elseif (chapter == 'event7-1-a1') then
    RTap({ 498, 341 }, 100)
  elseif (chapter == 'event7-1-a2') then
    RTap({ 748, 834 }, 100)
  elseif (chapter == 'event7-1-a3') then
    RTap({ 1296, 410 }, 100)
  elseif (chapter == 'event7-1-c1') then
    RTap({ 498, 341 }, 100)
  elseif (chapter == 'event7-1-c2') then
    RTap({ 748, 834 }, 100)
  elseif (chapter == 'event7-1-c3') then
    RTap({ 1296, 410 }, 100)
  elseif (chapter == 'event8-1-sp1') then
    RTap({ 1368, 453 }, 100)
  elseif (chapter == 'event8-1-sp2') then
    RTap({ 872, 791 }, 100)
  elseif (chapter == 'event8-1-sp3') then
    RTap({ 587, 375 }, 100)
  elseif (chapter == 'event9-1-sp1') then
    RTap({ 366, 339 }, 100)
  elseif (chapter == 'event9-1-sp2') then
    RTap({ 1206, 282 }, 100)
  elseif (chapter == 'event9-1-sp3') then
    RTap({ 286, 866 }, 100)
  elseif (chapter == 'event9-1-sp4') then
    RTap({ 1070, 744 }, 100)
  elseif (chapter == 'event11-1-a1') then
    RTap({ 653, 265 }, 100)
  elseif (chapter == 'event11-1-a2') then
    RTap({ 1102, 786 }, 100)
  elseif (chapter == 'event11-1-a3') then
    RTap({ 1342, 378 }, 100)
  elseif (chapter == 'event11-2 -b1') then
    RTap({ 537, 775 }, 100)
  elseif (chapter == 'event11-2-b2') then
    RTap({ 1307, 727 }, 100)
  elseif (chapter == 'event11-2-b3') then
    RTap({ 1063, 325 }, 100)
  elseif (chapter == 'event12-1-sp1') then
    RTap({ 1379, 457 }, 100)
  elseif (chapter == 'event12-1-sp2') then
    RTap({ 875, 796 }, 100)
  elseif (chapter == 'event12-1-sp3') then
    RTap({ 582, 370 }, 100)
  elseif (chapter == 'event13-1-sp1') then
    RTap({ 407, 409 }, 100)
  elseif (chapter == 'event13-1-sp2') then
    RTap({ 568, 804 }, 100)
  elseif (chapter == 'event13-1-sp3') then
    RTap({ 1243, 590 }, 100)
  elseif (chapter == 'event15-1-a1') then
    RTap({ 387, 367 }, 100)
  elseif (chapter == 'event15-1-a2') then
    RTap({ 535, 690 }, 100)
  elseif (chapter == 'event15-1-a3') then
    RTap({ 1345, 769 }, 100)
  elseif (chapter == 'event15-1-a4') then
    RTap({ 1190, 421 }, 100)
  elseif (chapter == 'event15-2-b1') then
    RTap({ 517, 655 }, 100)
  elseif (chapter == 'event15-2-b2') then
    RTap({ 1257, 544 }, 100)
  elseif (chapter == 'event16-1-a1') then
    RTap({ 328, 332 }, 100)
  elseif (chapter == 'event16-1-a2') then
    RTap({ 471, 731 }, 100)
  elseif (chapter == 'event16-1-a3') then
    RTap({ 1210, 360 }, 100)
  elseif (chapter == 'event16-1-a4') then
    RTap({ 1333, 757 }, 100)
  elseif (chapter == 'event16-2-b1') then
    RTap({ 453, 353 }, 100)
  elseif (chapter == 'event16-2-b2') then
    RTap({ 1312, 282 }, 100)
  elseif (chapter == 'event16-2-b3') then
    RTap({ 627, 802 }, 100)
  elseif (chapter == 'event16-2-b4') then
    RTap({ 1092, 538 }, 100)
  end
  if not __keepScreenState then keepScreen(false) end
end

-- 检测是第几关
battle.checkChapter = function(chapter)
  local __keepScreenState = keepScreenState
  if (not __keepScreenState) then keepScreen(true) end

  local chapterArr = strSplit(chapter, "-")
  local m = tonumber(chapterArr[1]) or 0

  if string.find(chapter, 'sp') then
    m = 'sp'
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
    sp = {
      { 48, 147, 0xffffff }, { 61, 147, 0xffffff },
      { 55, 149, 0x10283a }, { 62, 154, 0x102031 },
      { 47, 161, 0x082029 }, { 54, 159, 0xffffff },
      { 55, 169, 0x082031 }, { 55, 176, 0xffffff },
      { 62, 168, 0xffffff }, { 64, 177, 0x082029 },
      { 72, 150, 0x102431 }, { 79, 149, 0xffffff },
      { 86, 151, 0x19313a }, { 94, 151, 0xffffff },
      { 88, 164, 0x102431 }, { 80, 174, 0xffffff },
      { 89, 174, 0x082031 }, { 98, 175, 0xffffff },
    },
  }
  local result = nil
  if m == 0 or multiColorS(list[m]) then
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

    { 1533, 299, 0x6b2400 }, { 1544, 300, 0x633910 },
    { 1551, 300, 0x633510 }, { 1564, 302, 0xffd24a },
    { 1533, 316, 0x6b2d08 }, { 1547, 321, 0xffca42 },
    { 1559, 314, 0xffc642 }, { 1580, 304, 0xffb242 },
    { 1570, 307, 0xffc242 }, { 1592, 308, 0x6b3d21 },
    { 1600, 307, 0xffaa29 }, { 1584, 293, 0xffc64a },
    { 1598, 299, 0x633110 }, { 1590, 307, 0x733110 },
    { 1591, 323, 0x632d10 }, { 1580, 321, 0xf7a229 },
    { 1598, 321, 0xde8e29 }, { 1580, 331, 0xf7a229 },
    { 1570, 324, 0xffaa3a }, { 1591, 316, 0x6b2800 },
  }
  local result = multiColorS(list)
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
    { 315, 93, 0xf7e7b5 }, { 327, 90, 0x424142 },
    { 333, 114, 0x635531 }, { 334, 127, 0x423d31 },
    { 334, 133, 0xf7be21 }, { 326, 147, 0xefba19 },
    { 302, 135, 0xefbe29 }, { 315, 125, 0x424542 },
    { 316, 119, 0x5a513a }, { 325, 151, 0x424142 },
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
    { 302, 105, 0x4a493a }, { 321, 105, 0x4a4531 }, { 313, 113, 0x524942 }, { 313, 122, 0x635142 },
    { 320, 126, 0x4a494a }, { 320, 140, 0x4a4542 }, { 302, 134, 0x4a4542 }, { 308, 125, 0x525131 },
    { 322, 154, 0x424542 }, { 339, 133, 0x4a493a }, { 307, 109, 0xffdf9c }, { 316, 107, 0xffe39c },
    { 320, 94, 0xffefbd }, { 335, 108, 0xf7e78c }, { 317, 120, 0xffca5a }, { 333, 133, 0xffbe29 },
    { 322, 149, 0xffba00 }, { 307, 137, 0xffba10 }, { 313, 132, 0xf7be21 }, { 335, 119, 0x4a453a },
  }
  local list4 = {
    { 313, 90, 0x423531 }, { 331, 90, 0x424142 }, { 333, 127, 0x635129 }, { 337, 134, 0x5a4d3a },
    { 333, 145, 0x525142 }, { 324, 151, 0x424531 }, { 315, 141, 0x4a4931 }, { 303, 141, 0x424142 },
    { 314, 126, 0x524121 }, { 299, 129, 0x524d42 }, { 316, 93, 0xefe3ad }, { 327, 111, 0xffdb84 },
    { 334, 134, 0xffbe21 }, { 324, 146, 0xf7ba08 }, { 303, 134, 0xf7be21 }, { 309, 124, 0xf7be42 },
    { 320, 124, 0xffc64a }, { 314, 132, 0xf7c221 }, { 321, 102, 0xf7e79c }, { 313, 108, 0xffdf94 },
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
  local result = multiColorS(list)
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
    { 91, 78, 0x313942 }, { 131, 51, 0x4a5963 },
    { 307, 61, 0x4a5963 }, { 344, 47, 0xbdced6 },
    { 312, 109, 0x313d42 }, { 1818, 40, 0xdedfde },
    { 1835, 66, 0x3a353a }, { 1875, 92, 0xdedfd6 },
    { 1860, 56, 0x292d29 },
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
    { 144, 68, 0xffffff }, { 154, 67, 0xffffff },
    { 154, 76, 0xe6e6e6 }, { 161, 84, 0xffffff },
    { 168, 91, 0xffffff }, { 180, 68, 0xffffff },
    { 180, 86, 0xffffff }, { 195, 78, 0xffffff },
    { 207, 88, 0xffffff }, { 205, 71, 0xffffff },
  }
  local result = multiColorS(list)
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

-- 检测是否获得船面板
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

-- 获得船面板点击继续
battle.getNewShipPanelClickNext = function()
  RTap({ 952, 840 }, 100)
end

-- 检测是否获得经验面板
battle.isGetExpPanel = function()
  local __keepScreenState = keepScreenState
  if not __keepScreenState then keepScreen(true) end
  local list = {
    { 543, 279, 0x6b696b }, { 744, 280, 0x6b696b },
    { 890, 276, 0x6b696b }, { 1247, 275, 0x6b696b },
    { 1374, 275, 0x636563 }, { 1381, 308, 0x63656b },
    { 540, 306, 0x6b696b }, { 555, 269, 0x8c8e94 },
    { 949, 269, 0x948e94 }, { 1324, 269, 0x8c8a8c },
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