local originRequire = require
local _ENV = _ENV

local options = {
  basePath = '',
  osExit = os.exit,
  extensions = { '', '.lua', '/index.lua' },
}

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
        if type(pathArray[key]) ~= 'string' then
          error('bad argument #' .. key .. ' to \'path.join\' (string expected, got ' .. type(pathArray[key]) .. ')', 2)
        end
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

local requireFactory
requireFactory = function(dirPath)
  return function(loadpath)
    if type(loadpath) ~= 'string' then
      error('bad argument #1 to \'require\' (string expected, got ' .. type(loadpath) .. ')', 2)
    end

    if string.match(loadpath, '^%.%/') or string.match(loadpath, '^%.%.%/') or string.match(loadpath, '^%/') then
      local requirePath
      local absolutePath

      -- 遍历扩展名列表并尝试在 package.loaded 里寻找已加载的模块
      for key = 1, #options.extensions do
        local rp = path.resolve(dirPath, loadpath .. options.extensions[key])
        if package.loaded[rp] then
          requirePath = rp
          absolutePath = path.join(options.basePath, rp)
          break
        end
      end
      -- 如果 package.loaded 中没有需要的模块
      if not requirePath or not package.loaded[requirePath] then
        -- 遍历扩展名列表并尝试在 package.preload 里寻找已加载的模块
        for key = 1, #options.extensions do
          local rp = path.resolve(dirPath, loadpath .. options.extensions[key])
          if package.preload[rp] then
            requirePath = rp
            absolutePath = path.join(options.basePath, rp)
            break
          end
        end
        -- 如果 package.preload 中没有需要的模块
        if not requirePath or not package.preload[requirePath] then
          local requireSource
          local file
          local errArr = {}
          -- 遍历扩展名列表并尝试从文件中寻找模块
          for key = 1, #options.extensions do
            local rp = path.resolve(dirPath, loadpath .. options.extensions[key])
            local ap = path.join(options.basePath, rp)
            local res, err = pcall(function()
              local theFile = assert(io.open(ap, 'r'))
              file = theFile
              requireSource = file:read('*a')
            end)
            if not res then
              table.insert(errArr, err)
            end
            -- 成功读取文件，返回项目路径和系统路径
            if requireSource then
              requirePath = rp
              absolutePath = ap
              break
            end
          end
          -- 如果都没找到能执行的文件，则抛出错误
          if not requireSource then
            error(table.concat(errArr, '\r\n'), 2)
          end
          if file then
            file.close()
          end
          requireSource = 'local require, modePath = ...; ' .. requireSource
          package.preload[requirePath] = assert(load(requireSource, '@' .. absolutePath, 'bt', _ENV))
        end
        package.loaded[requirePath] = package.preload[requirePath](requireFactory(path.dirname(requirePath)), requirePath) or true
        -- 载入完成以后删除 package.preloaded 里的内容
        package.preload[requirePath] = nil
      end
      return package.loaded[requirePath]
    else
      local requireRes
      local res, err = pcall(function()
        requireRes = originRequire(loadpath)
      end)
      if not res then
        error(err, 2)
      end
      return requireRes
    end
  end
end

return function(optionParam)
  options.osExit = optionParam.osExit or options.osExit
  options.basePath = optionParam.basePath or options.basePath

  local result = debug.getinfo(2, 'S')
  if string.match(result.short_src, '%[string') then
    local newMain = string.gsub(result.source, '%.lua$', '')
    package.loaded[newMain] = nil
    originRequire(newMain)
    options.osExit()
    return
  end

  if not _require then
    _require = originRequire
    local filePath = string.gsub(result.source, '^@', '')

    options.basePath = optionParam.basePath or path.dirname(filePath)
    options.extensions = optionParam.extensions or options.extensions

    require = requireFactory('/')
  end

  return {
    basePath = options.basePath,
  }
end