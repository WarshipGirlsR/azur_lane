local Set = {}
local ClassSet = {}

local function bind(fn, _this)
  return function(...) return fn(_this, ...) end
end

Set.new = function(tab)
  local newSet = {
    size = 0,
    ['[[Entries]]'] = {},
  }
  setmetatable(newSet, {
    __index = function(theSet, key)
      if key == 'new' then
        return nil
      elseif type(Set[key]) == 'function' then
        return bind(Set[key], theSet)
      end
      return Set[key]
    end
  })

  if type(tab) == 'table' then
  end
  return newSet
end

return Set
