local home = {}

-- 检测主页
home.isHome = function()
  local __keepScreenState = keepScreenState
  if not __keepScreenState then keepScreen(true) end
  local list = {
    { 1015, 33, 0x3a353a }, { 1038, 62, 0x423d42 }, { 1325, 32, 0xfff363 }, { 1350, 53, 0xf7ca5a },
    { 1639, 35, 0xff4573 }, { 1660, 60, 0xef416b }, { 1188, 173, 0xffffff }, { 1203, 584, 0x109eef },
    { 1388, 583, 0x198ece }, { 1479, 589, 0xe6aa10 }, { 46, 949, 0xffffff }, { 190, 984, 0xdedbde },
    { 299, 1004, 0x5a6d8c }, { 557, 1008, 0x3a393a }, { 784, 1007, 0x313131 }, { 1030, 1007, 0x313531 },
    { 1277, 1004, 0x424142 }, { 1523, 1006, 0xbd1010 }, { 1768, 1004, 0x424142 }, { 1776, 603, 0xde9a08 },
  }
  local result = multiColorS(list)
  if (not __keepScreenState) then keepScreen(false) end
  return result
end

return home