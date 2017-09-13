local home = require 'BaseOperate__home'
local battle = require 'BaseOperate__battle'
local map = require 'BaseOperate__maps__map'
local map1_1 = require 'BaseOperate__maps__map1_1'
local map1_2 = require 'BaseOperate__maps__map1_2'
local map2_4 = require 'BaseOperate__maps__map2_4'
local map3_4 = require 'BaseOperate__maps__map3_4'
local map4_2 = require 'BaseOperate__maps__map4_2'


-- 原子操作列表

local map = {
  home = home, -- 主页
  battle = battle, -- 出征
  map = map, -- 地图基础，一般不用做处理
  map1_1 = map1_1, -- 地图1_1
  map1_2 = map1_2, -- 地图1_2
  map2_4 = map2_4, -- 地图2_4
  map3_4 = map3_4, -- 地图3_4
  map4_2 = map4_2, -- 地图4_2
}


return function()
  return map
end