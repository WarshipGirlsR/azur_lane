init(2)
useNlog = true
require 'console'
require 'TSLib'
mSleep(5000)

length = 10

for i = 1, length do
  local a1, a2 = math.modf(i / 3)
  if a2 == 0 then
    length = length + 1
  end
  console.log(i)
  console.log(length)
end

