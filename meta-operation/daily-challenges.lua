local dailyChallenges = {}

-- 点击进入出击
dailyChallenges.clickIntoBattlePage = function()
  RTap({ 1643, 600 }, 100)
end

-- 点击进入每日
dailyChallenges.clickIntoDailyChallengesPage = function()
  RTap({ 1226, 1014 }, 100)
end

-- 检查是否每日页面
dailyChallenges.isDailyChallengesPage = function()
  local __keepScreenState = keepScreenState
  if not __keepScreenState then keepScreen(true) end
  local list = {
    { 6, 4, 0xefeff7 }, { 6, 49, 0xcecece }, { 40, 33, 0xf7d242 }, { 71, 33, 0xffd742 },
    { 134, 51, 0xced2ce }, { 107, 14, 0xf7f3f7 }, { 99, 31, 0xdedfde }, { 138, 11, 0x292d29 },
    { 166, 48, 0x313531 }, { 315, 10, 0x424542 }, { 173, 18, 0x292d29 }, { 192, 26, 0xad9a63 },
    { 210, 31, 0x736531 }, { 235, 32, 0x9c923a }, { 264, 32, 0x211821 }, { 274, 28, 0x211c21 },
    { 250, 28, 0x3a3d3a }, { 240, 20, 0xfff3ce }, { 271, 21, 0xd6c6a4 }, { 273, 54, 0xffdb73 },
    { 352, 10, 0xeff3f7 }, { 869, 12, 0xeff3f7 }, { 833, 50, 0xd6dbde }, { 708, 52, 0xdedfe6 },
    { 733, 31, 0xeff3f7 }, { 564, 27, 0xeff3f7 }, { 90, 531, 0xf7fbf7 }, { 86, 541, 0xf7fbf7 },
    { 1849, 533, 0xfffbf7 }, { 1851, 546, 0xf7fbf7 },
  }
  local result = multiColorS(list)
  if (not __keepScreenState) then keepScreen(false) end
  return result
end

-- 检查每日页面战役次数是否用完
dailyChallenges.isDailyChallengesPageDailyChallengesEmpty = function()
  local __keepScreenState = keepScreenState
  if not __keepScreenState then keepScreen(true) end
  local list = {
    { 1089, 134, 0xffffff }, { 1089, 141, 0xffffff },
    { 1092, 141, 0xffffff }, { 1092, 147, 0xffffff },
    { 1089, 147, 0xffffff }, { 1091, 153, 0xffffff },
    { 1096, 155, 0xffffff }, { 1100, 153, 0xffffff },
    { 1102, 143, 0xffffff }, { 1100, 144, 0xffffff },
  }
  local result = multiColorS(list)
  if (not __keepScreenState) then keepScreen(false) end
  return result
end

-- 检查是否战术研修
dailyChallenges.isTacticalTrainingCard = function()
  local __keepScreenState = keepScreenState
  if not __keepScreenState then keepScreen(true) end
  local list = {
    { 842, 128, 0x215984 }, { 842, 179, 0x29618c },
    { 827, 277, 0x3a81b5 }, { 833, 385, 0x737d94 },
    { 844, 889, 0x1969a4 }, { 914, 885, 0x105d8c },
    { 1095, 848, 0x73d7de }, { 1137, 700, 0x427db5 },
    { 1070, 635, 0x529ece }, { 1131, 879, 0x295584 },
  }
  local result = multiColorS(list)
  if (not __keepScreenState) then keepScreen(false) end
  return result
end

-- 检查是否斩首行动
dailyChallenges.isDecapitationStrikeCard = function()
  local __keepScreenState = keepScreenState
  if not __keepScreenState then keepScreen(true) end
  local list = {
    { 882, 205, 0x949294 }, { 970, 213, 0x84817b },
    { 1129, 235, 0x191010 }, { 861, 542, 0x5a1421 },
    { 918, 682, 0x311421 }, { 1098, 658, 0x7b2031 },
    { 1007, 442, 0x211819 }, { 1080, 447, 0xe6e3de },
    { 894, 785, 0x5a2429 }, { 859, 888, 0x4a2021 },
  }
  local result = multiColorS(list)
  if (not __keepScreenState) then keepScreen(false) end
  return result
end

-- 检查是否商船护送
dailyChallenges.isMerchantShipEscortCard = function()
  local __keepScreenState = keepScreenState
  if not __keepScreenState then keepScreen(true) end
  local list = {
    { 851, 163, 0x212d42 }, { 1070, 186, 0x21354a },
    { 923, 233, 0xd6a6a4 }, { 936, 289, 0xe6e3de },
    { 838, 575, 0x191c29 }, { 865, 685, 0x292d4a },
    { 1056, 675, 0x21314a }, { 1133, 675, 0x294573 },
    { 872, 811, 0x29315a }, { 1104, 379, 0x19283a },
  }
  local result = multiColorS(list)
  if (not __keepScreenState) then keepScreen(false) end
  return result
end

-- 检查是否海域突破
dailyChallenges.isSeaAreaBreakthroughCard = function()
  local __keepScreenState = keepScreenState
  if not __keepScreenState then keepScreen(true) end
  local list = {
    { 842, 215, 0x213531 }, { 851, 555, 0x212d3a },
    { 864, 668, 0x213931 }, { 1099, 707, 0x3a413a },
    { 850, 833, 0x313121 }, { 1019, 194, 0xce9a6b },
    { 1037, 296, 0xdeb68c }, { 1041, 378, 0xb5ae9c },
    { 1057, 537, 0xe6cece }, { 856, 330, 0x103929 },
  }
  local result = multiColorS(list)
  if (not __keepScreenState) then keepScreen(false) end
  return result
end

-- 切换卡片
dailyChallenges.clickChangeCard = function()
  RTap({ 1419, 507 }, 100)
end

-- 进入卡片
dailyChallenges.clickIntoCard = function()
  RTap({ 989, 476 }, 100)
end

-- 检查是否选择关卡页面
dailyChallenges.isSelectChapterPage = function()
  local __keepScreenState = keepScreenState
  if not __keepScreenState then keepScreen(true) end
  local list = {
    { 246, 144, 0xf7c29c }, { 358, 194, 0xefba94 }, { 408, 331, 0xf7d2ad }, { 221, 346, 0xf7dfbd },
    { 17, 344, 0xfff3d6 }, { 212, 575, 0xf7f7f7 }, { 336, 621, 0xf7f7f7 }, { 405, 722, 0xfff3d6 },
    { 328, 989, 0xf7dfc5 }, { 616, 990, 0xffdfc5 }, { 663, 321, 0x29313a }, { 1046, 240, 0x29353a },
    { 663, 533, 0x292d3a }, { 968, 448, 0x313942 }, { 663, 723, 0x3a3d3a }, { 1018, 654, 0x424142 },
  }
  local result = multiColorS(list)
  if (not __keepScreenState) then keepScreen(false) end
  return result
end

-- 检查选择关卡页面挑战次数是否用完
dailyChallenges.isSelectChapterPageChallengeEmpty = function()
  local __keepScreenState = keepScreenState
  if not __keepScreenState then keepScreen(true) end
  local list = {
    { 137, 955, 0x191819 }, { 137, 966, 0x101819 },
    { 137, 977, 0x191819 }, { 137, 980, 0x101419 },
    { 127, 970, 0xa4f34a }, { 132, 970, 0xadf74a },
    { 142, 970, 0xadf74a }, { 147, 970, 0xa4f34a },
    { 141, 951, 0xadf74a }, { 133, 986, 0x9cf34a },
  }
  local result = multiColorS(list)
  if (not __keepScreenState) then keepScreen(false) end
  return result
end

-- 选择关卡
dailyChallenges.selectChapter = function(chapter)
  if chapter == 1 then
    RTap({ 780, 308 }, 100)
  elseif chapter == 2 then
    RTap({ 779, 521 }, 100)
  elseif chapter == 3 then
    RTap({ 768, 722 }, 100)
  elseif chapter == 4 then
    RTap({ 764, 934 }, 100)
  end
end

-- 检查是否选择舰队页面
dailyChallenges.isSelectFleetPage = function()
  local __keepScreenState = keepScreenState
  if not __keepScreenState then keepScreen(true) end
  local list = {
    { 12, 6, 0xefeff7 }, { 8, 45, 0xd6ced6 }, { 38, 33, 0xf7ce3a }, { 90, 8, 0xefebf7 },
    { 122, 57, 0xbdc6bd }, { 318, 15, 0x424542 }, { 168, 15, 0x292d29 }, { 742, 8, 0xeff3f7 },
    { 733, 48, 0xdedbde }, { 216, 66, 0x313d31 }, { 183, 19, 0x313131 }, { 201, 23, 0x101410 },
    { 189, 40, 0xffc631 }, { 222, 25, 0x080808 }, { 235, 25, 0xffeba4 }, { 240, 34, 0x212421 },
    { 247, 36, 0xffce42 }, { 274, 37, 0xffc631 }, { 284, 46, 0xffbe10 }, { 275, 60, 0x3a3d42 },
    { 1271, 186, 0xffffff }, { 1604, 185, 0xefefef }, { 1887, 214, 0xe6ebe6 }, { 1268, 490, 0xfffbff },
    { 1614, 501, 0xe6efe6 }, { 1878, 526, 0xe6e3e6 }, { 1385, 891, 0xd6f3f7 }, { 1396, 974, 0x9cdfde },
    { 1612, 936, 0xffefbd }, { 1774, 985, 0x8ccace },
  }
  local result = multiColorS(list)
  if (not __keepScreenState) then keepScreen(false) end
  return result
end

-- 选择舰队页面获取当前是哪个舰队
dailyChallenges.getFleet = function()
  local __keepScreenState = keepScreenState
  if not __keepScreenState then keepScreen(true) end
  local list1 = {
    { 138, 218, 0x4a4942 }, { 138, 201, 0x424521 }, { 127, 191, 0x424542 }, { 146, 176, 0x424542 },
    { 156, 196, 0x4a4942 }, { 156, 227, 0x3a3d3a }, { 146, 238, 0x424142 }, { 146, 227, 0xefba08 },
    { 145, 196, 0xffdf8c }, { 147, 183, 0xffebbd },
  }
  local list2 = {
    { 147, 192, 0x42393a }, { 137, 201, 0x424542 }, { 137, 216, 0x635d42 }, { 129, 232, 0x424142 },
    { 145, 238, 0x4a493a }, { 165, 232, 0x424142 }, { 152, 224, 0x4a494a }, { 161, 207, 0x424531 },
    { 137, 197, 0xffdf8c }, { 135, 232, 0xf7b600 },
  }
  local list3 = {
    { 148, 193, 0x4a4529 }, { 147, 219, 0x4a493a }, { 139, 205, 0x635142 }, { 130, 199, 0x4a4142 },
    { 130, 213, 0x5a4d31 }, { 164, 233, 0x424142 }, { 156, 177, 0x313531 }, { 146, 205, 0xf7ca5a },
    { 137, 192, 0xffe39c }, { 138, 219, 0xf7be19 },
  }
  local list4 = {
    { 142, 211, 0x524531 }, { 131, 198, 0x4a493a }, { 148, 175, 0x3a3d3a }, { 161, 209, 0x424542 },
    { 161, 230, 0x424142 }, { 152, 236, 0x4a4542 }, { 140, 226, 0x424542 }, { 151, 230, 0xf7ba08 },
    { 149, 182, 0xffebb5 }, { 130, 210, 0xe6ba42 },
  }
  local list5 = {
    { 153, 189, 0x4a494a }, { 139, 175, 0x4a494a }, { 130, 192, 0x635d52 }, { 147, 203, 0x4a494a },
    { 139, 212, 0x4a4d42 }, { 147, 221, 0x4a4942 }, { 148, 231, 0xf7ba08 }, { 137, 217, 0xffc63a },
    { 153, 196, 0xffdb84 }, { 140, 182, 0xffebb5 },
  }
  local list6 = {
    { 148, 188, 0x4a494a }, { 154, 193, 0x424542 }, { 148, 208, 0x4a494a }, { 148, 223, 0x424542 },
    { 147, 236, 0x424542 }, { 129, 207, 0x4a4d4a }, { 159, 193, 0x4a4942 }, { 157, 185, 0xffe7a4 },
    { 135, 200, 0xf7d773 }, { 149, 230, 0xf7ba10 },
  }
  local result
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
  if (not __keepScreenState) then keepScreen(false) end
  return result
end

-- 切换第一个舰队
dailyChallenges.clickChangeFirstFleet = function()
  for key = 1, 10 do
    RTap({ 67, 602 }, 100)
  end
end

-- 切换下一个舰队
dailyChallenges.clickChangeNextFleet = function()
  RTap({ 1158, 596 }, 100)
end

-- 点击出击按钮
dailyChallenges.clickBattleBtn = function()
  RTap({ 1580, 955 }, 100)
end

-- 点击返回按钮
dailyChallenges.clickBackBtn = function()
  RTap({ 54, 29 }, 100)
end

return dailyChallenges
