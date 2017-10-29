require 'TableLib'
local a = { { 1, 2 }, { 3, 4 } }
local b = { 3, 4 }
nLog(table.findIndex(a, function(v) return b[1] == v[1] and b[2] == v[2] end))