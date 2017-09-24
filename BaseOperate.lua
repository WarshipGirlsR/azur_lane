local home = require 'BaseOperate__home'
local battle = require 'BaseOperate__battle'
local map = require 'BaseOperate__maps__map'
local map1_1 = require 'BaseOperate__maps__map1_1'
local map1_2 = require 'BaseOperate__maps__map1_2'
local map1_3 = require 'BaseOperate__maps__map1_3'
local map1_4 = require 'BaseOperate__maps__map1_4'
local map2_1 = require 'BaseOperate__maps__map2_1'
local map2_2 = require 'BaseOperate__maps__map2_2'
local map2_3 = require 'BaseOperate__maps__map2_3'
local map2_4 = require 'BaseOperate__maps__map2_4'
local map3_1 = require 'BaseOperate__maps__map3_1'
local map3_2 = require 'BaseOperate__maps__map3_2'
local map3_3 = require 'BaseOperate__maps__map3_3'
local map3_4 = require 'BaseOperate__maps__map3_4'
local map4_2 = require 'BaseOperate__maps__map4_2'
local map5_1 = require 'BaseOperate__maps__map5_1'
local map5_2 = require 'BaseOperate__maps__map5_2'
local map5_3 = require 'BaseOperate__maps__map5_3'
local map5_4 = require 'BaseOperate__maps__map5_4'
local map6_1 = require 'BaseOperate__maps__map6_1'
local map6_2 = require 'BaseOperate__maps__map6_2'
local map6_3 = require 'BaseOperate__maps__map6_3'
local map7_1 = require 'BaseOperate__maps__map7_1'
local mapevent4_1_sp1 = require 'BaseOperate__maps__mapevent4_1_sp1'
local mapevent4_1_sp2 = require 'BaseOperate__maps__mapevent4_1_sp2'
local mapevent4_1_sp3 = require 'BaseOperate__maps__mapevent4_1_sp3'


-- 原子操作列表

local map = {
  home = home, -- 主页
  battle = battle, -- 出征
  map = map, -- 地图基础，一般不用做处理
  map1_1 = map1_1, -- 地图1_1
  map1_2 = map1_2, -- 地图1_2
  map1_3 = map1_3, -- 地图1_3
  map1_4 = map1_4, -- 地图1_4
  map2_1 = map2_1, -- 地图2_1
  map2_2 = map2_2, -- 地图2_2
  map2_3 = map2_3, -- 地图2_3
  map2_4 = map2_4, -- 地图2_4
  map3_1 = map3_1, -- 地图3_1
  map3_2 = map3_2, -- 地图3_2
  map3_3 = map3_3, -- 地图3_3
  map3_4 = map3_4, -- 地图3_4
  map4_2 = map4_2, -- 地图4_2
  map5_1 = map5_1, -- 地图5_1
  map5_2 = map5_2, -- 地图5_2
  map5_3 = map5_3, -- 地图5_3
  map5_4 = map5_4, -- 地图5_4
  map6_1 = map6_1, -- 地图6_1
  map6_2 = map6_2, -- 地图6_2
  map6_3 = map6_3, -- 地图6_3
  map7_1 = map7_1, -- 地图7_1
  mapevent4_1_sp1 = mapevent4_1_sp1, -- 活动sp1
  mapevent4_1_sp2 = mapevent4_1_sp2, -- 活动sp2
  mapevent4_1_sp3 = mapevent4_1_sp3, -- 活动sp3
}


return function()
  return map
end