local __init = init

-- 0=竖屏，1=右旋（home键在右边），2=左旋（home键在左边），3=倒立
__init(0)
local w, h = getScreenSize()
local m = math.max(w, h)
local sideLength = math.min(w, h)
local orient = 0;
local nextUpdateTime = 0

local multiColorS = function(array, s)
  s = s or 90
  local theS = math.floor(0xff * (100 - s) * 0.01)

  local __keepScreenState = keepScreenState
  if not __keepScreenState then keepScreen(true) end

  local result = true
  for var = 1, #array do
    local lr, lg, lb = getColorRGB(array[var][1], array[var][2])
    local r = math.floor(array[var][3] / 0x10000)
    local g = math.floor(array[var][3] % 0x10000 / 0x100)
    local b = math.floor(array[var][3] % 0x100)
    if math.abs(lr - r) > theS or math.abs(lg - g) > theS or math.abs(lb - b) > theS then
      result = false
      break
    end
  end

  if not __keepScreenState then keepScreen(false) end
  return result
end

-- 计算方向辅助界面，一像素宽度的白色边界，一像素宽的黑色边界，用于检测方向

fwShowWnd("orientwid1", 0, 0, 2, m, 0)
function myShowView()
  fwShowTextView("orientwid1", "text1", "", "center", "000000", "FEFEFE", 15, 0, 0, 0, 1, m, 1)
  fwShowTextView("orientwid1", "text2", "", "center", "000000", "010101", 15, 0, 1, 0, 2, m, 1)
  mSleep(60)
end

function myHideView()
  fwCloseView("orientwid1", "text1")
  fwCloseView("orientwid1", "text2")
end


-- 计算当前方向
function calOrient(_orient)
  local result = _orient
  -- 寻找白色边界
  __init(_orient)

  local checkOrder = { 0, 1, 2 }
  if (_orient == 0) then
    checkOrder = { 1, 2 }
  elseif (_orient == 1) then
    checkOrder = { 0, 2 }
  elseif (_orient == 2) then
    checkOrder = { 0, 1 }
  end

  local checkPointList = {
    { 0, math.floor(0.333 * sideLength), 0xfefefe },
    { 0, math.floor(0.5 * sideLength), 0xfefefe },
    { 0, math.floor(0.667 * sideLength), 0xfefefe },
    { 0, math.floor(0.833 * sideLength), 0xfefefe },
    { 1, math.floor(0.333 * sideLength), 0x010101 },
    { 1, math.floor(0.5 * sideLength), 0x010101 },
    { 1, math.floor(0.667 * sideLength), 0x010101 },
    { 1, math.floor(0.833 * sideLength), 0x010101 },
  }

  myShowView()
  if (multiColorS(checkPointList, 99)) then
    -- 如果方向没变则不旋转
  else
    -- 如果方向变了则旋转
    for k, v in ipairs(checkOrder) do
      __init(v)
      if (multiColorS(checkPointList, 99)) then
        return v
      end
    end
    __init(_orient)
  end
  myHideView()
  return _orient
end

local _orient = calOrient(orient)
orient = _orient

-- 获取当前方向
getDeviceOrient = function()
  local newOrient = orient
  if (os.time() > nextUpdateTime) then
    local _keepScreenState = keepScreenState
    keepScreen(true)
    newOrient = calOrient(orient)
    nextUpdateTime = os.time() + 1
    keepScreen(false)
  end
  return newOrient
end


-- 设置当前方向，当然只能设置init的方向
setDeviceOrient = function(n)
  orient = n
  __init(n)
  nextUpdateTime = os.time() + 1
end
init = setDeviceOrient
