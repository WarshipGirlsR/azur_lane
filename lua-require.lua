if type(lua_exit) == 'function' and not lua_exit_added then
  lua_exit_added = true
  local exit = os.exit
  os.exit = function(...)
    lua_exit(...)
    exit(...)
  end
end

return function()
  local result = debug.getinfo(2, 'S')
  if string.match(result.short_src, '%[string') then
    local newMain = string.gsub(result.source, '%.lua$', '')
    package.preload[newMain] = nil
    package.loaded[newMain] = nil
    require(newMain)
    console.log(package.preload[newMain])
    console.log(os);
    os.exit()
    return
  end
  return function(loadpath)
  end
end