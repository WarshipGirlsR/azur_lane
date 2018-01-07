do
  local result = debug.getinfo(1, 'S')
  if string.match(result.short_src, '%[string') then
    local newMain = string.gsub(result.source, '%.lua$', '')
    package.loaded[newMain] = nil
    require(newMain)
    lua_exit()
    return
  end
end


local result = debug.getinfo(1, 'S')
local basePath = string.gsub(string.gsub(result.source, '^@', ''), '%/[^/]*$', '')

os.execute('rm -rf ' .. basePath .. '/**');
