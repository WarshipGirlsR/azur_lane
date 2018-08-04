------------------------------------------
javascript api


------------------------------------------
local Object = {}

Object.bind = function(fn, self)
  return function(...)
    return fn(self, ...)
  end
end

Object.createClass = function(prototype, superClass)
  if type(prototype) ~= 'table' then
    error('Object.createClass param #1 prototype except \'table\', got \'' .. type(prototype) .. '\'')
  end
  if type(prototype.constructor) ~= 'function' then
    error('Object.createClass param #1 prototype, prototype.constructor except \'function\', got \'' .. type(prototype) .. '\'')
  end

  local subClass = {
    __prototype = {},
  }
  for key, value in pairs(prototype) do
    if key == 'constructor' then
    else
      subClass.__prototype[key] = value
    end
  end

  if type(superClass) == 'table' then
    setmetatable(subClass, {
      __index = superClass,
    })
    if type(rawget(superClass, '__prototype') == 'table') then
      setmetatable(rawget(subClass, '__prototype'), {
        __index = rawget(superClass, '__prototype')
      })
    end
  end

  subClass.new = function(...)
    local newObj = {}
    setmetatable(newObj, {
      __index = function(_newObj, key)
        if type(subClass.__prototype[key]) == 'function' then
          return Object.bind(subClass.__prototype[key], newObj)
        end
        return subClass.__prototype[key]
      end
    })

    local res = { prototype.constructor(newObj, ...) }
    if #res > 0 then
      return table.unpack(res)
    end
    return newObj
  end

  return subClass
end

-- 使用代理表复制一份Object，保证Object内部在运行时不会使用替换过的方法。
local proxyTable = {}
for k, v in pairs(Object) do
  proxyTable[k] = v
end
return proxyTable
