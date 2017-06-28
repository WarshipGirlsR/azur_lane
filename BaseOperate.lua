local home = require 'BaseOperate__home'
local battle = require 'BaseOperate__battle'


-- 原子操作列表

local map = {
  home = home, -- 主页
  battle = battle, -- 出征
}


return function()
  return map
end