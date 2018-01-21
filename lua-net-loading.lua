useNlog = true
local socket = require 'socket'
local sz = require 'sz'
local json = sz.json
require 'console'

-- 拦截 lua-require 的加载
do
  package.preload['BaseOperate'] = function(...)
    return setmetatable({}, { __call = function(self) return false end })
  end
end

-- 字符串分割
do
  string.split = string.split or function(str, d)
    if str == '' and d ~= '' then
      return { str }
    elseif str ~= '' and d == '' then
      local lst = {}
      for key = 1, string.len(str) do
        table.insert(lst, string.sub(str, key, 1))
      end
      return lst
    else
      local lst = {}
      local n = string.len(str) --长度
      local start = 1
      while start <= n do
        local i = string.find(str, d, start) -- find 'next' 0
        if i == nil then
          table.insert(lst, string.sub(str, start, n))
          break
        end
        table.insert(lst, string.sub(str, start, i - 1))
        if i == n then
          table.insert(lst, "")
          break
        end
        start = i + 1
      end
      return lst
    end
  end
end

local path = (function()
  local path = {}
  path.separator = string.find(package.path, '/') and '/' or '\\'
  path.basename = function(thePath)
    thePath = string.gsub(thePath, '\\', '/')
    local thePathArray = string.split(thePath, '/')
    local res = table.remove(thePathArray)
    return res
  end
  path.dirname = function(thePath)
    thePath = string.gsub(thePath, '\\', '/')
    local thePathArray = string.split(thePath, '/')
    table.remove(thePathArray)
    return table.concat(thePathArray, path.separator)
  end
  path.extname = function()
  end
  path.join = function(...)
    local pathArray = { ... }
    local resultPathArray = {}
    for key = 1, #pathArray do
      if pathArray[key] ~= '' then
        local thePath = string.gsub(pathArray[key], '\\', '/')
        local thePathArray = string.split(thePath, '/')
        for key2 = 1, #thePathArray do
          local theName = thePathArray[key2]
          if theName == '' and #resultPathArray > 0 then
          elseif theName == '.' and #resultPathArray > 0 then
          elseif theName == '..' and #resultPathArray == 1 and resultPathArray[1] == '' then
            table.remove(resultPathArray)
          elseif theName == '..' and #resultPathArray == 1 and resultPathArray[1] == '.' then
            resultPathArray = { '..' }
          elseif theName == '..' and #resultPathArray > 0 then
            table.remove(resultPathArray)
          else
            table.insert(resultPathArray, theName)
          end
        end
      end
    end
    return table.concat(resultPathArray, path.separator)
  end
  path.relative = function()
  end
  path.resolve = function(...)
    local pathArray = { ... }
    local resultPathArray = {}
    for key = 1, #pathArray do
      if pathArray[key] ~= '' then
        local thePath = string.gsub(string.gsub(pathArray[key], '\\', '/'), '/$', '')
        local thePathArray = string.split(thePath, '/')
        for key2 = 1, #thePathArray do
          local theName = thePathArray[key2]
          if theName == '' and key2 == 1 then
            resultPathArray = { '' }
          elseif theName == '.' and #resultPathArray > 0 then
          elseif theName == '..' and #resultPathArray == 1 and resultPathArray[1] == '' then
            table.remove(resultPathArray)
          elseif theName == '..' and #resultPathArray == 1 and resultPathArray[1] == '.' then
            resultPathArray = { '..' }
          elseif theName == '..' and #resultPathArray > 0 then
            table.remove(resultPathArray)
          else
            table.insert(resultPathArray, theName)
          end
        end
      end
    end
    return table.concat(resultPathArray, path.separator)
  end
  return path
end)()

-- 重新载入这个脚本，以解决触动精灵使用 string 模式载入脚本导致无法获取脚本路径的问题
-- 触动精灵启动脚本以 string 方式载入，使得 debug 库无法获取载入脚本的路径。而使用 require 载入
-- 别的脚本后可以在别的脚本获得它的脚本路径。所以这里重新 require 一次自己以便获得脚本路径。
local projectBasePath
do
  local result = debug.getinfo(1, 'S')
  if string.match(result.short_src, '%[string') then
    local newMain = string.gsub(result.source, '%.lua$', '')
    package.loaded[newMain] = nil
    require(newMain)
    lua_exit()
    os.exit()
    return
  else
    projectBasePath = string.gsub(result.source, '^@', '')
  end
end

-- 弹出面板
local function luaNetLoadingPanel()
  local settingTable = {
    ['style'] = 'default',
    ['width'] = height,
    ['height'] = height,
    ['config'] = 'lua-net-loading.dat',
    ['timer'] = 5,
    ['orient'] = 1,
    ['pagetype'] = 'multi',
    ['title'] = '选项',
    ['cancelname'] = '取消',
    ['okname'] = '开始',
    ['rettype'] = 'table',
    ['pages'] = {
      {
        {
          ['type'] = 'Label',
          ['text'] = '第一次设置建议在竖屏下设置，设置好后再切换到游戏界面',
          ['size'] = 15,
          ['align'] = 'left',
          ['color'] = '0,0,0',
        },
        {
          ['type'] = 'Label',
          ['text'] = '向左滑动查看其他选项',
          ['size'] = 15,
          ['align'] = 'left',
          ['color'] = '0,0,0',
        },
        {
          ['type'] = 'Label',
          ['text'] = '服务器地址前缀',
          ['size'] = 15,
          ['align'] = 'left',
          ['color'] = '0,0,0',
        },
        {
          ['id'] = 'serverUrl',
          ['type'] = 'Edit',
          ['prompt'] = '服务器地址前缀',
          ['text'] = 'http://192.168.1.2:8080/project/',
          ['kbtype'] = 'default',
        },
      },
    }
  }

  local settingTableStr = json.encode(settingTable)
  local ret, settings = showUI(settingTableStr)

  if (ret ~= 1) then
    -- --转换settings结果
    function transStrToTable(str)
      local list = {}
      local strArr = {}
      if (type(str) == 'string') then
        strArr = strSplit(str, ',')
      elseif (type(str) == 'table') then
        strArr = str
      end
      for i, v in ipairs(strArr) do
        list['' .. (i - 1)] = v
      end
      return list
    end

    -- 服务器地址前缀
  end
  return ret, settings
end

local ret, settings = luaNetLoadingPanel()


function download(hostBasePath, projectBasePath, filePath)
  local f = io.open('/storage/emulated/0/TouchSprite/lua/test.html', 'w')
  console.log('/storage/emulated/0/TouchSprite/lua/test.html')
  local c = assert(socket.connect('blog.csdn.net', 80));
  c:send('GET ' .. filePath .. ' HTTP/1.1\r\n\r\n')
  while true do
    local s, status, partial = c:receive(1024);
    f:write(s or partial)
    if status == 'closed' then
      break
    end
  end
  c:close()
  f:close()
end

download(settings.serverUrl, projectBasePath, '/andrew57/article/details/9788903')
