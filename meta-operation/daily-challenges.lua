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
    { 733, 31, 0xeff3f7 }, { 564, 27, 0xeff3f7 },
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


return dailyChallenges
