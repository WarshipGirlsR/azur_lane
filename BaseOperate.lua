local home = require 'BaseOperate__home'
local battle = require 'BaseOperate__battle'
local map = require 'BaseOperate__maps__map'
local map1_1 = require 'BaseOperate__maps__map1_1'
local map1_2 = require 'BaseOperate__maps__map1_2'
local map3_4 = require 'BaseOperate__maps__map3_4'


-- 原子操作列表

local map = {
  home = home, -- 主页
  battle = battle, -- 出征
  map = map, -- 地图基础，一般不用做处理
  map1_1 = map1_1, -- 地图1_1
  map1_2 = map1_2, -- 地图1_1
  map3_4 = map3_4, -- 地图1_1
}


return function()
  return map
end