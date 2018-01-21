local co = require '../lib/co'
local battle = require './battle'

-- 将分散在各个文件的任务集合到一起
local missions = {
  battle,
}

return missions
