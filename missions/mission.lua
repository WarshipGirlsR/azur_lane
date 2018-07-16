local co = require '../lib/co'
local c = coroutine
local stepLabel = require '../utils/step-label'
local makeAction = (require './utils').makeAction
local sleepPromise = require '../utils/sleep-promise'
local moMission = require '../meta-operation/mission'
local moHome = require '../meta-operation/home'
local moMap = require '../meta-operation/maps-options/index'
local setScreenListeners = (require './utils').setScreenListeners
local store = require '../store'
local vibratorPromise = require '../utils/vibrator-promise'

store.battle = store.battle or {}

local o = {
  home = moHome,
  mission = moMission,
  map = moMap,
}

local mission = function(action)
  local settings = store.settings;
  local mapProxy = o.map['map' .. settings.battleChapter]

  return co(c.create(function()

    if action.type == 'MISSION_INIT' then

      stepLabel.setStepLabelContent('3.1.等待桌面')
      local newstateTypes = c.yield(setScreenListeners({
        { 'MISSION_START', o.home.isHome, 2000 },
      }))
      return makeAction(newstateTypes)

    elseif action.type == 'MISSION_START' then

      stepLabel.setStepLabelContent('3.3.检查是否有任务')
      if o.mission.checkHasMission() then
        o.mission.clickIntoMissionPage()
        local newstateTypes = c.yield(setScreenListeners({
          { 'MISSION_MITTION_PAGE', o.mission.isMissionPage },
        }))
        return makeAction(newstateTypes)
      end
      return makeAction('')

    elseif action.type == 'MISSION_MITTION_PAGE' then

      stepLabel.setStepLabelContent('3.4.点击所有任务')
      o.mission.clickAllMissionTag()
      c.yield(sleepPromise(800))

      stepLabel.setStepLabelContent('3.5.查找完成的任务')
      local res = o.mission.findMission()
      if res and #res > 0 then
        stepLabel.setStepLabelContent('3.6.点击任务')
        console.log(res[1])
        o.mission.clickMissionBtn(res[1])
        local newstateTypes = c.yield(setScreenListeners({
          { 'MISSION_MITTION_PAGE', o.mission.isMissionPage, 2000 },
          { 'MISSION_GET_PROPS_PANEL', o.mission.isGetPropsPanel },
        }))
        return makeAction(newstateTypes)
      end

      stepLabel.setStepLabelContent('3.7.没有任务，返回')
      local newstateTypes = c.yield(setScreenListeners({
        { 'MISSION_MITTION_PAGE_BACK', o.mission.isMissionPage },
      }))
      return makeAction(newstateTypes)

    elseif action.type == 'MISSION_GET_PROPS_PANEL' then

      stepLabel.setStepLabelContent('3.8.获得道具面板,点击继续')
      o.mission.clickGetPropsPanelNext()
      local newstateTypes = c.yield(setScreenListeners({
        { 'MISSION_MITTION_PAGE', o.mission.isMissionPage, 2000 },
        { 'MISSION_GET_NEW_SHIP_PAGE', o.mission.isGetShipPage },
        { 'MISSION_GET_PROPS_PANEL', o.mission.isGetPropsPanel },
      }))
      return makeAction(newstateTypes)

    elseif action.type == 'MISSION_GET_NEW_SHIP_PAGE' then

      stepLabel.setStepLabelContent('3.9.获得新船,点击继续')
      o.mission.clickGetNewShipNext()
      local newstateTypes = c.yield(setScreenListeners({
        { 'MISSION_MITTION_PAGE', o.mission.isMissionPage, 2000 },
        { 'MISSION_GET_NEW_SHIP_PAGE', o.mission.isGetShipPage, 2000 },
        { 'MISSION_GET_PROPS_PANEL', o.mission.isGetPropsPanel },
      }))
      return makeAction(newstateTypes)

    elseif action.type == 'MISSION_MITTION_PAGE_BACK' then

      stepLabel.setStepLabelContent('3.8.返回桌面')
      o.mission.getPropsPanelBack()
      return makeAction('')
    end

    return nil
  end))
end

return mission
