local home = require 'BaseOperate__home'
local battle = require 'BaseOperate__battle'
local map = require 'BaseOperate__maps__map'


-- 原子操作列表

local map = {
  home = home, -- 主页
  battle = battle, -- 出征
  map = map, -- 地图
}


return function()
  return map
end