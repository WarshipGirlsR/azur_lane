local eq = require '../lib/event-query'
local co = require '../lib/co'
local c = coroutine

local combineListener = function(target, ...)
  local sources = { ... }
  if (type(target) ~= 'table') then
    target = {}
  end
  for k = 1, #sources do
    local source = sources[k]
    for key = 1, #source do
      local value = source[key]
      table.insert(target, value)
    end
  end
  local targetReverse = table.reverse(target)
  local resultIndex = {}
  local result = {}
  for key = 1, #targetReverse do
    local value = targetReverse[key]
    if (not resultIndex[value[3]]) then
      resultIndex[value[3]] = value
      table.insert(result, value)
    end
  end

  local resultReverse = table.reverse(result)
  return resultReverse
end

local setScreenListeners = function(...)
  local firstArr = select('1', ...)

  if type(firstArr) ~= 'table' then
    return Promise.reject(error('the param 1 of "setScreenListeners" is nil.', 2))
  end

  local theArr = table.merge(...)

  local errorList = {}
  for key = 1, #theArr do
    local value = theArr[key]
    if not value[2] then
      table.insert(errorList, value)
    end
  end
  if #errorList > 0 then
    local errorMsg = ''
    for key = 1, #errorList do
      local value = errorList[key]
      if not value[2] then
        errorMsg = errorMsg .. 'the function of "' .. value[1] .. '" is nil.' .. '\n'
      end
    end
    error(errorMsg, 2)
  end
  local theArrUnique = table.uniqueLast(theArr, 2)
  for key = 1, #theArrUnique do
    local value = theArrUnique[key]
    value.isOnce = true
  end
  return co(c.create(function()
    local newArr = {}
    local ids = {}
    local done = false
    for key = 1, #theArrUnique do
      local listenerEvent = theArrUnique[key]
      if type(listenerEvent[3]) == 'number' and listenerEvent[3] > 0 then
        table.insert(newArr,
          Promise.new(function(resolve)
            local id = eq.setTimeout(resolve, listenerEvent[3])
            table.insert(ids, id)
          end).andThen(function()
            if (not done) then
              return Promise.new(function(resolve)
                local id = eq.setScreenListener(listenerEvent[2], function()
                  resolve(listenerEvent[1])
                end)
                table.insert(ids, id)
              end)
            end
          end))
      else
        table.insert(newArr, co(c.create(function()
          return Promise.new(function(resolve)
            local id = eq.setScreenListener(listenerEvent[2], function()
              resolve(listenerEvent[1])
            end)
            table.insert(ids, id)
          end)
        end)))
      end
    end
    local res = c.yield(Promise.race(newArr))
    done = true
    for key = 1, #ids do
      eq.clearScreenListener(ids[key])
      eq.clearTimeout(ids[key])
    end
    return res
  end))
end

local makeAction = function(action)
  if (type(action) == 'table') then
    return action
  end
  return { type = action }
end

return {
  combineListener = combineListener,
  setScreenListeners = setScreenListeners,
  makeAction = makeAction,
}
