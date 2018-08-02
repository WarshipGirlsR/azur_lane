Object = (function()
  local Object = {}
  local proxyObject = {}

  Object.bind = function(fn, self)
    return function(...)
      return fn(self, ...)
    end
  end

  Object.createClass = function(subClass, superClass)
    local subClass = {}
    subClass.new = function()
    end
    setmetatable(subClass, {
      __index = function(_subClass, key)
      end
    })
    return subClass
  end

  -- 使用代理表+元表阻止Object原始方法被篡改
  return setmetatable({}, {
    __index = Object,
    __newindex = function(_Object, key, value)
      if type(Object[key]) ~= 'nil' then
        error('Cannot call overwrite Object\'s methods', 2)
      end
      proxyObject[key] = value
    end,
    __pairs = function(_Object)
      local mergeTable = {}
      for k, v in next, _Object, nil do
        mergeTable[k] = v
      end
      for k, v in next, Object, nil do
        mergeTable[k] = v
      end
      return next, mergeTable, nil
    end,
  })
end)()

Object.test = 'test2'
for k, v in pairs(Object) do
  print(k, v)
end
