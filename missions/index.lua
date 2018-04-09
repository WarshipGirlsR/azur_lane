local co = require '../lib/co'
local battle = require './battle'
local mapsType1 = require './maps-type1'
local mapsType2 = require './maps-type2'

-- 将分散在各个文件的任务集合到一起
local missions = {
  battle,
  mapsType1,
  mapsType2,
}

return missions
