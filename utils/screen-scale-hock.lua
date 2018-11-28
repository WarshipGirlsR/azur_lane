local isScreenScale = false
local scaleWidth, scaleHeight = getScreenSize()
local screenWidth, screenHeight = getScreenSize()

setScreenScaleS = setScreenScaleS or function(...)
  isScreenScale = select(1, ...)
  scaleWidth = select(2, ...) or screenWidth
  scaleHeight = select(3, ...) or screenHeight
  return setScreenScale(...)
end

getScreenScaleS = getScreenScaleS or function()
  return isScreenScale, scaleWidth, scaleHeight
end
