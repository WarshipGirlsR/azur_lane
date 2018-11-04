local co = require '../lib/co'
local battle = require './battle'
--local maidBattle = require './maid-battle'
local dailyChallenges = require './daily-challenges'
local mission = require './mission'
local exercise = require './exercise'
local mapsType1 = require './maps-type-1'
local mapsType2 = require './maps-type-2'
local mapsType3 = require './maps-type-3'
local mapsType4 = require './maps-type-4'
local scanMapsType1 = require './scan-map-type-1'

-- 将分散在各个文件的任务集合到一起
local missions = {
  battle,
  --  maidBattle,
  dailyChallenges,
  exercise,
  mission,
  mapsType1,
  mapsType2,
  mapsType3,
  mapsType4,
  scanMapsType1,
}

return missions
