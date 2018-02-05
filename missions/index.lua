local co = require '../lib/co'
local battle = require './battle'
local mapsType1 = require './maps-type1'

-- 将分散在各个文件的任务集合到一起
local missions = {
  battle,
  mapsType1,
}

return missions
