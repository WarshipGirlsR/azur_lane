useNlog = true
require 'console'
--require('lua-require')();
getColor()
console.log(assert(loadfile('/storage/emulated/0/TouchSprite/lua/test3.lua')))
local file = io.open('/storage/emulated/0/TouchSprite/lua/test3.lua', 'r')
local str = file:read('*a')
console.log(assert(load(str, '@/storage/emulated/0/TouchSprite/lua/test3.lua'))(1, 2, 3))

--console.log(debug.getinfo(1, 'S'))

