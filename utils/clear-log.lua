-- 删除大于7天并且大于50条的log，避免日志过大
local lfs = require '../lib/lfs'
local logPath = userPath() .. '/log'
local theTime = os.time()

os.execute('find "' .. logPath .. '" -mtime +7 -type f -name azur_lane_*.log -exec rm -f {} \\;')
