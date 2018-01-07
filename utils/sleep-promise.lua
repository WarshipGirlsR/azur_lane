if type(Promise) ~= 'table' then
  error('SleepPromise need Promise module to work. Please add \'Promise\' and require it.', 2)
end
if type(Promise) ~= 'table' then
  error('SleepPromise need EventQuery module to work. Please add \'EventQuery\' and require it.', 2)
end

local sleepPromise = function(ms)
  return Promise.new(function(resolve)
    EventQuery.setTimeout(resolve, ms)
  end)
end
return sleepPromise
