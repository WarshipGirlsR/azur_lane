local co = require '../lib/co'
local test = require './test'
--local home = require './home'
--local battle = require './battle'
--local map = require './map'

-- 将分散在各个文件的任务集合到一起
local missions = {
  test,
  --  home,
  --  battle,
  --  map,
}

return missions
