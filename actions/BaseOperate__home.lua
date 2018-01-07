local home = {}

-- 检测主页
home.isHome = function()
  local __keepScreenState = keepScreenState
  if not __keepScreenState then keepScreen(true) end
  local list = {
    { 139, 30, 0x101010 }, { 625, 24, 0x212021 },
    { 963, 16, 0x292d3a }, { 1033, 67, 0x3a3d3a },
    { 1058, 31, 0xe6efef }, { 1339, 47, 0xefba42 },
    { 1369, 32, 0xefebef }, { 1652, 39, 0xf74163 },
    { 1675, 65, 0xefefef }, { 1775, 184, 0xa4cede },
    { 1162, 179, 0xa4cade }, { 1276, 189, 0xa4cade },
    { 1201, 582, 0x109eef }, { 1383, 582, 0x199ae6 },
    { 1290, 571, 0xffffff }, { 1498, 585, 0xdeae10 },
    { 1744, 597, 0xe6aa10 }, { 1591, 580, 0xffffff },
    { 112, 990, 0xffffff }, { 190, 974, 0xe6e7e6 },
  }
  local result = multiColorS(list)
  if (not __keepScreenState) then keepScreen(false) end
  return result
end

-- 点击出征
home.clickBattleBtn = function()
  tap(1628, 599, 100)
end

-- 点击活动
home.clickEventBtn = function()
  tap(1018, 249, 100)
end

return home