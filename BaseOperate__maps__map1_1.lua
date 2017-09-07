local ImgInfo = require 'BaseOperate__ImgInfo'

local map1_1 = {}


--  是否在出击界面
map1_1.isBattlePage = function()
  local __keepScreenState = keepScreenState
  if not __keepScreenState then keepScreen(true) end
  local list = {
    { 8, 10, 0xe6e7ef }, { 201, 21, 0xffefc5 },
    { 307, 12, 0x424542 }, { 1024, 38, 0x313131 },
    { 1333, 40, 0xffef63 }, { 1645, 37, 0xff4573 },
    { 21, 144, 0xf7f7f7 }, { 31, 162, 0xf7fbf7 },
    { 114, 151, 0xf7f7f7 },
    { 182, 20, 0xfff3c5 }, { 178, 35, 0xffc642 },
    { 210, 28, 0x3a393a }, { 219, 32, 0xffd25a },
    { 255, 30, 0xffdb73 }, { 244, 42, 0x3a393a },
    { 267, 42, 0x3a393a }, { 273, 51, 0xf7c652 },
    { 259, 17, 0xfff7de }, { 266, 25, 0x101010 },
  }
  local result = multiColor(list)
  if not __keepScreenState then keepScreen(false) end
  return result
end

-- 点击回港
map1_1.clickBackToHomeBtn = function()
  tap(98, 1016, 100)
end

return map1_1