useNlog = true
require 'console'
local sz = require("sz") --使用 sz 库前必须插入这一句
local json = sz.json --使用 JSON 模块前必须插入这一句
--- -require('lua-require')();
-- getColor()
-- console.log(assert(loadfile('/storage/emulated/0/TouchSprite/lua/test3.lua')))
-- local file = io.open('/storage/emulated/0/TouchSprite/lua/test3.lua', 'r')
-- local str = file:read('*a')
-- console.log(assert(load(str, '@/storage/emulated/0/TouchSprite/lua/test3.lua'))(1, 2, 3))

--console.log(debug.getinfo(1, 'S'))

console.log(json.decode("function test() test = \"test\" end "))
