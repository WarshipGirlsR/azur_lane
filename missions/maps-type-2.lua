local co = require '../lib/co'
local c = coroutine
local stepLabel = require '../utils/step-label'
local makeAction = (require './utils').makeAction
local sleepPromise = require '../utils/sleep-promise'
local moBattle = require '../meta-operation/battle'
local moHome = require '../meta-operation/home'
local moMap = require '../meta-operation/maps-options/index'
local setScreenListeners = (require './utils').setScreenListeners
local store = require '../store'

-- type2 的过程：先让道中队走到 boss 点前，再让道中队走到 boss 队前，最后 boss 队打 boss

-- 设置  store 的默认值
store.mapType2 = store.mapType2 or {
  selectFleedCount = 0,
  isBossFleetInBossArea = false,
  battleNum = 0,
  battleWithConvoyNum = 0,
  checkpositionListForMove = {},
  currentPosition = nil,
  nextStepPoint = nil,
  nextStepFleed = nil,
  moveVectorForAStep = { -1, -1 },
  moveFailTimes = 0,
}

-- maps-type2 的行动流程
local missionStepList = {
  'onWayFleetMoveToWaitBoss',
  'onWayFleetMoveToBossFleet',
  'onWayFleetMoveToClosestEnemy',
  'bossFleetMoveToWaitBoss',
  'bossFleetMoveToBoss',
  'randomMoveAStep',
}

local o = {
  home = moHome,
  battle = moBattle,
  map = moMap,
}

local comparePoints = function(point1, point2)
  if type(point1) ~= 'table' or type(point2) ~= 'table' then
    local info = debug.getinfo(2, 'Sl')
    local lineInfo = ''
    if info.currentline then
      lineInfo = info.source .. ': ' .. info.currentline .. ':\n'
    end
    if type(point1) ~= 'table' then
      lineInfo = lineInfo .. '\n bad argument #1 "point1"(table excepted, got ' .. type(point1) .. ')'
    end
    if type(point2) ~= 'table' then
      lineInfo = lineInfo .. '\n bad argument #2 "point2"(table excepted, got ' .. type(point2) .. ')'
    end
    error(lineInfo)
  end
  return point1[1] == point2[1] and point1[2] == point2[2]
end


local battleListenerList = {
  { '', o.home.isHome, 2000 },
  { 'MAPS_TYPE_2_PAGE_AMBUSHED_PANEL_AVOID_AMBUSHED', o.battle.isAmbushedPanel, 2000 },
  { 'BATTLE_BATTLE_CHAPTER_PAGE_BACK_TO_HOME', o.battle.isBattleChapterPage, 2000 },
  { 'BATTLE_BATTLE_CHAPTER_PAGE_INFO_PANEL_CLICK_INTO', o.battle.isChapterInfoPanel, 2000 },
  { 'BATTLE_BATTLE_CHAPTER_PAGE_SELECT_FLEET_PANEL_SELECT_FLEET', o.battle.isSelectFleetPanel, 2000 },
  { 'BATTLE_BATTLE_CHAPTER_PAGE_HARD_SELECT_FLEET_PANEL_CLICK_INTO', o.battle.isHardSelectFleetPanel, 500 },
  { 'BATTLE_MAP_PAGE', o.battle.isMapPage, 2000 },
  { 'BATTLE_MAP_PAGE_CLOSE_FORMAT_PANEL', o.battle.isFormationPanel, 2000 },
  { 'BATTLE_READY_BATTLE_PAGE_CLICK_BATTLE', o.battle.isReadyBattlePage, 2000 },
  { 'BATTLE_IN_BATTLE_PAGE', o.battle.isInBattlePage, 2000 },
  { 'BATTLE_VICTORY_PAGE', o.battle.isVictoryPanel, 2000 },
  { 'BATTLE_GET_PROPS_PANEL', o.battle.isGetPropsPanel, 2000 },
  { 'BATTLE_GET_NEW_SHIP_PANEL', o.battle.isGetNewShipPanel, 2000 },
  { 'BATTLE_GET_EXP_PANEL', o.battle.isGetExpPanel, 2000 },
}

local mapsType2 = function(action)
  local settings = store.settings;
  local mapProxy = o.map['map' .. settings.battleChapter.name]
  return co(c.create(function()
    if action.type == 'MAPS_TYPE_2_PRE_INIT' then

      -- 这部分流程只会在每次开启新的一局时才调用一次，而不是每次寻路就调用一次

      stepLabel.setStepLabelContent('3-1.开局预备变量')
      store.mapType2.selectFleedCount = 0
      -- boss舰队是否在boss区域
      store.mapType2.battleNum = 0
      store.mapType2.battleWithConvoyNum = 0
      -- 切换船的次数，如果超过4次没切换成功表示舰队沉了。
      store.mapType2.changeFleetNum = 0
      -- 舰队移动的状态。
      store.mapType2.missionStep = 'onWayFleetMoveToWaitBoss'
      store.mapType2.currentPosition = nil
      -- 下一步行动的目标位置
      store.mapType2.nextStepPoint = nil
      -- 下一步行动的路径
      store.mapType2.nextStepPath = nil
      -- 下一步行动的舰队，当前为 nil 'onWay' 或者 'boss'
      store.mapType2.nextStepFleed = nil
      store.mapType2.moveVectorForAStep = { -1, -1 }
      store.mapType2.moveFailTimes = 0

      return makeAction('')

    elseif action.type == 'MAPS_TYPE_2_INIT' then

      -- 每次进入地图页面时就会执行一次

      -- 舰队移动的状态。
      store.mapType2.missionStep = 'onWayFleetMoveToWaitBoss'
      store.mapType2.currentPosition = nil
      -- 下一步行动的目标位置
      store.mapType2.nextStepPoint = nil
      -- 下一步行动的路径
      store.mapType2.nextStepPath = nil
      -- 下一步行动的舰队，当前为 nil 'onWay' 或者 'boss'
      store.mapType2.nextStepFleed = nil
      store.mapType2.moveVectorForAStep = { -1, -1 }
      store.mapType2.moveFailTimes = 0
      return makeAction('MAPS_TYPE_2_START')

    elseif action.type == 'MAPS_TYPE_2_START' then

      local newstateTypes = c.yield(setScreenListeners(battleListenerList, {
        { 'MAPS_TYPE_2_GET_NEXT_STEP', o.battle.isMapPage },
      }))
      return makeAction(newstateTypes)

    elseif action.type == 'MAPS_TYPE_2_GET_NEXT_STEP' then

      stepLabel.setStepLabelContent('3-6.计算下一步往哪走')
      local mapChessboard = store.scanMapType1.mapChessboard
      local inBattleList = mapChessboard.inBattleList

      local _ = (function()
        if table.find(inBattleList, function(ele) return comparePoints(ele, mapChessboard.bossFleet) end) then
          stepLabel.setStepLabelContent('3-8.boss队开始战斗')
          store.mapType2.missionStep = 'bossFleetMoveToBoss'
          store.mapType2.nextStepFleed = 'boss'
          store.mapType2.nextStepPoint = mapChessboard.bossFleet
          return
        end

        if table.find(inBattleList, function(ele) return comparePoints(ele, mapChessboard.onWayFleet) end) then
          store.mapType2.missionStep = 'onWayFleetMoveToClosestEnemy'
          stepLabel.setStepLabelContent('3-7.开始战斗')
          store.mapType2.nextStepFleed = 'onWay'
          store.mapType2.nextStepPoint = mapChessboard.onWayFleet
          return
        end

        if not table.find({ 'randomMoveAStep' }, store.mapType2.missionStep)
          and #mapChessboard.bossPosition > 0 then
          -- 判断boss队到boss中间能否通过
          local bossTo = mapProxy.checkMoveToPointPath(mapChessboard, mapChessboard.bossFleet, mapChessboard.bossPosition[1])
          if bossTo and comparePoints(bossTo, mapChessboard.bossPosition[1]) then
            stepLabel.setStepLabelContent('3-8.boss队移动到boss位置')
            store.mapType2.missionStep = 'bossFleetMoveToBoss'
            store.mapType2.nextStepFleed = 'boss'
            store.mapType2.nextStepPoint, store.mapType2.nextStepPath = mapProxy.checkMoveToPointPath(mapChessboard, mapChessboard.bossFleet, mapChessboard.bossPosition[1])
            return
          end

          if bossTo then
            stepLabel.setStepLabelContent('3-8.道中队清理阻拦的敌人')
            store.mapType2.missionStep = 'onWayFleetMoveToClosestEnemy'
            store.mapType2.nextStepFleed = 'onWay'
            store.mapType2.nextStepPoint, store.mapType2.nextStepPath = mapProxy.checkMoveToPointPath(mapChessboard, mapChessboard.onWayFleet, bossTo)
            return
          end
        end

        -- 道中队清理路线上的敌人，保持boss队到各个boss点都是畅通的。
        -- 此处会计算出所有需要清理的敌人，并选中一个最近的敌人
        if not table.find({
          'onWayFleetMoveToWaitBoss',
          'onWayFleetMoveToBossFleet',
          'onWayFleetMoveToClosestEnemy',
        }, store.mapType2.missionStep) then
          local needClearEnemyList = {}
          for _, waitForBossPositionItem in ipairs(mapChessboard.waitForBossPosition) do
            local bossFleetToWaitBoss = mapProxy.checkMoveToPointPath(mapChessboard, mapChessboard.bossFleet, waitForBossPositionItem)
            local onWayFleetToBossFleet, onWayFleetToBossFleetPath = mapProxy.checkMoveToPointPath(mapChessboard, mapChessboard.onWayFleet, mapChessboard.bossFleet)
            local onWayFleetToWaitBoss, onWayFleetToWaitBossPath = mapProxy.checkMoveToPointPath(mapChessboard, mapChessboard.onWayFleet, waitForBossPositionItem)
            local needClearEnemy
            if not bossFleetToWaitBoss or not comparePoints(bossFleetToWaitBoss, waitForBossPositionItem) then
              if onWayFleetToBossFleet
                and onWayFleetToWaitBoss
                and not comparePoints(onWayFleetToBossFleet, mapChessboard.bossFleet)
                and not comparePoints(onWayFleetToWaitBoss, waitForBossPositionItem) then
                if #onWayFleetToBossFleetPath < #onWayFleetToWaitBossPath then
                  stepLabel.setStepLabelContent('3-8.道中队移动到待命位置')
                  needClearEnemy = needClearEnemy or {}
                  needClearEnemy.missionStep = 'onWayFleetMoveToWaitBoss'
                  needClearEnemy.nextStepFleed = 'onWay'
                  needClearEnemy.nextStepPoint, needClearEnemy.nextStepPath = mapProxy.checkMoveToPointPath(mapChessboard, mapChessboard.onWayFleet, waitForBossPositionItem)
                else
                  stepLabel.setStepLabelContent('3-8.道中移动到boss队旁边')
                  needClearEnemy = needClearEnemy or {}
                  needClearEnemy.missionStep = 'onWayFleetMoveToBossFleet'
                  needClearEnemy.nextStepFleed = 'onWay'
                  needClearEnemy.nextStepPoint, needClearEnemy.nextStepPath = mapProxy.checkMoveToPointPath(mapChessboard, mapChessboard.onWayFleet, mapChessboard.bossFleet)
                end
              elseif not comparePoints(mapChessboard.onWayFleet, waitForBossPositionItem)
                and (onWayFleetToWaitBoss and not comparePoints(onWayFleetToWaitBoss, waitForBossPositionItem)) then
                stepLabel.setStepLabelContent('3-8.道中队移动到待命位置')
                needClearEnemy = needClearEnemy or {}
                needClearEnemy.missionStep = 'onWayFleetMoveToWaitBoss'
                needClearEnemy.nextStepFleed = 'onWay'
                needClearEnemy.nextStepPoint, needClearEnemy.nextStepPath = mapProxy.checkMoveToPointPath(mapChessboard, mapChessboard.onWayFleet, waitForBossPositionItem)
              elseif onWayFleetToBossFleet and not comparePoints(onWayFleetToBossFleet, mapChessboard.bossFleet) then
                stepLabel.setStepLabelContent('3-8.道中移动到boss队旁边')
                needClearEnemy = needClearEnemy or {}
                needClearEnemy.missionStep = 'onWayFleetMoveToBossFleet'
                needClearEnemy.nextStepFleed = 'onWay'
                needClearEnemy.nextStepPoint, needClearEnemy.nextStepPath = mapProxy.checkMoveToPointPath(mapChessboard, mapChessboard.onWayFleet, mapChessboard.bossFleet)
              end
              if needClearEnemy then
                table.insert(needClearEnemyList, needClearEnemy)
              end
            end
          end
          local closestEnemy = math.minTable(needClearEnemyList, function(enemy) return #enemy.nextStepPath end)
          if closestEnemy then
            table.assign(store.mapType2, closestEnemy)
            return
          end
        end

        if store.mapType2.missionStep == 'onWayFleetMoveToClosestEnemy' then
          stepLabel.setStepLabelContent('3-8.道中移动到最近的敌人')
          store.mapType2.nextStepFleed = 'onWay'
          store.mapType2.nextStepPoint, store.mapType2.nextStepPath = mapProxy.findClosestEnemy(mapChessboard, mapChessboard.onWayFleet, mapChessboard.bossFleet)
          return
        end

        if store.mapType2.missionStep == 'bossFleetMoveToBoss' then
          stepLabel.setStepLabelContent('3-8.boss队移动到boss位置')
          store.mapType2.missionStep = 'bossFleetMoveToBoss'
          store.mapType2.nextStepFleed = 'boss'
          store.mapType2.nextStepPoint, store.mapType2.nextStepPath = mapProxy.checkMoveToPointPath(mapChessboard, mapChessboard.bossFleet, mapChessboard.bossPosition[1])
          return
        end

        if store.mapType2.missionStep == 'randomMoveAStep' then
          stepLabel.setStepLabelContent('3-11.随机移动一步')
          store.mapType2.missionStep = 'randomMoveAStep'
          store.mapType2.nextStepFleed = 'onWay'
          store.mapType2.nextStepPoint = mapProxy.getRandomMoveAStep(mapChessboard)
          return
        end

        stepLabel.setStepLabelContent('3-8.道中移动到最近的敌人')
        store.mapType2.missionStep = 'onWayFleetMoveToClosestEnemy'
        store.mapType2.nextStepFleed = 'onWay'
        store.mapType2.nextStepPoint, store.mapType2.nextStepPath = mapProxy.findClosestEnemy(mapChessboard, mapChessboard.onWayFleet, mapChessboard.bossFleet)
        return
      end)()
      -- 如果还是没有移动目标，则可能是我方舰队挡住了敌人，此时需要随意移动一步
      -- 尽可能避开敌人
      if not store.mapType2.nextStepPoint then
        stepLabel.setStepLabelContent('3-11.随机移动一步')
        store.mapType2.nextStepPoint = mapProxy.getRandomMoveAStep(mapChessboard)
      end
      -- 如果还是没有移动目标，只好重新扫描
      if not store.mapType2.nextStepPoint then
        local newstateTypes = c.yield(setScreenListeners(battleListenerList, {
          { 'MAPS_TYPE_2_START', o.battle.isMapPage },
        }))
        return makeAction(newstateTypes)
      end

      local newstateTypes = c.yield(setScreenListeners(battleListenerList, {
        { 'MAPS_TYPE_2_PAGE_CHECK_NEXT_STEP_POSITION', o.battle.isMapPage },
      }))
      return makeAction(newstateTypes)

    elseif action.type == 'MAPS_TYPE_2_PAGE_CHECK_NEXT_STEP_POSITION' then
      -- 如果限制了步长，则需要计算一步移动到哪里
      -- 如果限制步长，并且下一步路线不为0，並且下一步位置不是路线的终点
      local mapChessboard = store.scanMapType1.mapChessboard
      if settings.battleStepLength > 0
        and store.mapType2.nextStepPath
        and #store.mapType2.nextStepPath > 0 then
        local stepNum = 0
        while #store.mapType2.nextStepPath > 0 do
          stepNum = stepNum + 1
          local firstPoint = store.mapType2.nextStepPath[1]
          -- 如果第一步就是另外一队，则跳过本格取下一格。如果第settings.battleStepLength步遇到另外一队，则直接结束循环，取前一格
          if (comparePoints(firstPoint, mapChessboard.bossFleet) or comparePoints(firstPoint, mapChessboard.onWayFleet)) and stepNum == 1 then
            table.remove(store.mapType2.nextStepPath, 1)
          elseif (comparePoints(firstPoint, mapChessboard.bossFleet) or comparePoints(firstPoint, mapChessboard.onWayFleet)) and stepNum == settings.battleStepLength then
            break
          else
            table.remove(store.mapType2.nextStepPath, 1)
            store.mapType2.nextStepPoint = firstPoint
            if stepNum >= settings.battleStepLength then
              break
            end
          end
        end
      end

      -- 查找目标点在哪个界面
      store.mapType2.checkpositionListForMove = mapProxy.getCheckpositionList(settings.battleChapter)
      for _, targetPosition in ipairs(store.mapType2.checkpositionListForMove) do
        local nextRowNum = store.mapType2.nextStepPoint[1]
        local nextColNum = store.mapType2.nextStepPoint[2]
        if targetPosition.pointMap[nextRowNum .. ',' .. nextColNum] then
          store.mapType2.checkpositionListForMove = { targetPosition }
          break;
        end
      end


      local newstateTypes = c.yield(setScreenListeners(battleListenerList, {
        { 'MAPS_TYPE_2_PAGE_SELECT_FLEET', o.battle.isMapPage },
      }))
      return makeAction(newstateTypes)

    elseif action.type == 'MAPS_TYPE_2_PAGE_SELECT_FLEET' then

      if settings.battleFleet[2] then
        stepLabel.setStepLabelContent('3-20.检查舰队')
        if store.mapType2.nextStepFleed == 'boss' then
          if o.battle.getSelectedFleed() ~= settings.battleFleet[1] and store.mapType2.changeFleetNum < 3 then
            store.mapType2.changeFleetNum = store.mapType2.changeFleetNum + 1
            stepLabel.setStepLabelContent('3-21.选择boss舰队')
            o.battle.clickSwitchFleetBtn()
            c.yield(sleepPromise(100))
            o.battle.clickAttackBtn()
            c.yield(sleepPromise(500))
            if o.battle.getSelectedFleed() == settings.battleFleet[1] then
              local myFleetList = store.scanMapType1.mapChessboard.myFleetList
              store.scanMapType1.mapChessboard.myFleetList = { myFleetList[2], myFleetList[1] }
            else
              local newstateTypes = c.yield(setScreenListeners(battleListenerList, {
                { 'MAPS_TYPE_2_PAGE_SELECT_FLEET', o.battle.isMapPage, 1000 },
              }))
              return makeAction(newstateTypes)
            end
          end
        elseif store.mapType2.nextStepFleed == 'onWay'
          or store.mapType2.missionStep == nil then
          if o.battle.getSelectedFleed() ~= settings.battleFleet[2] and store.mapType2.changeFleetNum < 3 then
            store.mapType2.changeFleetNum = store.mapType2.changeFleetNum + 1
            stepLabel.setStepLabelContent('3-22.选择道中舰队')
            o.battle.clickSwitchFleetBtn()
            c.yield(sleepPromise(100))
            o.battle.clickAttackBtn()
            if o.battle.getSelectedFleed() == settings.battleFleet[2] then
              local myFleetList = store.scanMapType1.mapChessboard.myFleetList
              store.scanMapType1.mapChessboard.myFleetList = { myFleetList[2], myFleetList[1] }
            else
              local newstateTypes = c.yield(setScreenListeners(battleListenerList, {
                { 'MAPS_TYPE_2_PAGE_SELECT_FLEET', o.battle.isMapPage, 1000 },
              }))
              return makeAction(newstateTypes)
            end
          end
        end
      end

      store.mapType2.changeFleetNum = 0
      local newstateTypes = c.yield(setScreenListeners(battleListenerList, {
        { 'MAPS_TYPE_2_PAGE_CHECK_FLEET_FORMATION', o.battle.isMapPage },
        { 'MAPS_TYPE_2_PAGE_CHECK_FLEET_FORMATION', o.battle.isFormationPanel },
      }))
      return makeAction(newstateTypes)

    elseif action.type == 'MAPS_TYPE_2_PAGE_CHECK_FLEET_FORMATION' then

      stepLabel.setStepLabelContent('3-11.检查舰队阵型')
      if (store.mapType2.nextStepFleed == 'boss'
        and settings.battleFleetBossFormation
        and o.battle.getFleetFormation() ~= settings.battleFleetBossFormation)
        or (store.mapType2.nextStepFleed == 'onWay'
        and settings.battleFleetOnWayFormation
        and o.battle.getFleetFormation() ~= settings.battleFleetOnWayFormation) then
        local newstateTypes = c.yield(setScreenListeners(battleListenerList, {
          { 'MAPS_TYPE_2_PAGE_SELECT_FLEET_FORMATION', o.battle.isMapPage, 500 },
          { 'MAPS_TYPE_2_PAGE_SELECT_FLEET_FORMATION', o.battle.isFormationPanel, 500 },
        }))
        return makeAction(newstateTypes)
      end
      local newstateTypes = c.yield(setScreenListeners(battleListenerList, {
        { 'MAPS_TYPE_2_MOVE_TO_CHECK_POSITION_FOR_A_STEP', o.battle.isMapPage },
      }))
      return makeAction(newstateTypes)

    elseif action.type == 'MAPS_TYPE_2_PAGE_SELECT_FLEET_FORMATION' then
      if (store.mapType2.nextStepFleed == 'boss'
        and settings.battleFleetBossFormation
        and o.battle.getFleetFormation() ~= settings.battleFleetBossFormation)
        or (store.mapType2.nextStepFleed == 'onWay'
        and settings.battleFleetOnWayFormation
        and o.battle.getFleetFormation() ~= settings.battleFleetOnWayFormation) then

        c.yield(sleepPromise(500))
        if not o.battle.isFormationPanel() then
          stepLabel.setStepLabelContent('3-11.打开舰队阵型面板')
          o.battle.openFormationPanel()
          c.yield(sleepPromise(1000))
        end

        stepLabel.setStepLabelContent('3-11.切换舰队阵型')
        o.battle.changeFormationPanelFormation()

        local newstateTypes = c.yield(setScreenListeners(battleListenerList, {
          { 'MAPS_TYPE_2_PAGE_SELECT_FLEET_FORMATION', o.battle.isMapPage, 500 },
          { 'MAPS_TYPE_2_PAGE_SELECT_FLEET_FORMATION', o.battle.isFormationPanel, 500 },
        }))
        return makeAction(newstateTypes)
      end
      if o.battle.isFormationPanel() then
        stepLabel.setStepLabelContent('3-11.关闭舰队阵型面板')
        o.battle.closeFormationPanel()
        c.yield(sleepPromise(1000))
      end
      local newstateTypes = c.yield(setScreenListeners(battleListenerList, {
        { 'MAPS_TYPE_2_MOVE_TO_CHECK_POSITION_FOR_A_STEP', o.battle.isMapPage, 500 },
        { 'MAPS_TYPE_2_PAGE_SELECT_FLEET_FORMATION', o.battle.isFormationPanel, 200 },
      }))
      return makeAction(newstateTypes)

    elseif action.type == 'MAPS_TYPE_2_MOVE_TO_CHECK_POSITION_FOR_A_STEP' then

      stepLabel.setStepLabelContent('3-11.获取地图位置参数')
      local targetPosition = store.mapType2.checkpositionListForMove[1]
      local currentPosition = mapProxy.getMapPosition(targetPosition)
      console.log(currentPosition)
      stepLabel.setStepLabelContent('3-12.计算移动向量')
      local targetPosition = store.mapType2.checkpositionListForMove[1]
      local newMoveVector, effectiveStep = mapProxy.getMoveVector(currentPosition, targetPosition)
      if effectiveStep and comparePoints(store.mapType2.moveVectorForAStep, newMoveVector) then
        store.mapType2.moveVectorForAStep = newMoveVector
        local newstateTypes = c.yield(setScreenListeners(battleListenerList, {
          { 'MAPS_TYPE_2_MOVE_A_STEP', o.battle.isMapPage, 500 },
        }))
        return makeAction(newstateTypes)
      end
      console.log(newMoveVector)

      local minLength = 20
      if math.abs(newMoveVector[1]) <= minLength and math.abs(newMoveVector[2]) <= minLength then
        store.mapType2.moveVectorForAStep = newMoveVector
        -- 地图位置在误差范围之内
        local newstateTypes = c.yield(setScreenListeners(battleListenerList, {
          { 'MAPS_TYPE_2_MOVE_A_STEP', o.battle.isMapPage, 1000 },
        }))
        return makeAction(newstateTypes)
      end


      stepLabel.setStepLabelContent('3-13.将地图移动到移动位置')
      local isCenter = mapProxy.moveMapToCheckPosition(newMoveVector)
      local newstateTypes = c.yield(setScreenListeners(battleListenerList, {
        { 'MAPS_TYPE_2_MOVE_TO_CHECK_POSITION_FOR_A_STEP', o.battle.isMapPage, 1000 },
      }))
      return makeAction(newstateTypes)

    elseif action.type == 'MAPS_TYPE_2_MOVE_A_STEP' then

      stepLabel.setStepLabelContent('3-14.移动舰队位置')
      local targetPosition = store.mapType2.checkpositionListForMove[1]
      local nextRowNum = store.mapType2.nextStepPoint[1]
      local nextColNum = store.mapType2.nextStepPoint[2]
      console.log(store.mapType2.nextStepPoint)
      if targetPosition.pointMap[nextRowNum .. ',' .. nextColNum] then
        mapProxy.moveToPoint(targetPosition, store.mapType2.nextStepPoint, store.mapType2.moveVectorForAStep)
        o.battle.clickAttackBtn()
      elseif #store.mapType2.checkpositionListForMove > 0 then
        local newstateTypes = c.yield(setScreenListeners(battleListenerList, {
          { 'MAPS_TYPE_2_MOVE_TO_CHECK_POSITION_FOR_A_STEP', o.battle.isMapPage },
        }))
        return makeAction(newstateTypes)
      end


      if settings.battleStepLength > 0
        and store.mapType2.nextStepPath
        and #store.mapType2.nextStepPath > 0
        and not comparePoints(store.mapType2.nextStepPath[#store.mapType2.nextStepPath], store.mapType2.nextStepPoint) then

        local newstateTypes = c.yield(setScreenListeners(battleListenerList, {
          { 'MAPS_TYPE_2_PAGE_CHECK_NEXT_STEP_POSITION', o.battle.isMapPage, settings.battleStepLength * 800 + 200 }
        }))
        return makeAction(newstateTypes)
      end

      if store.mapType2.moveFailTimes < 3 then
        store.mapType2.moveFailTimes = store.mapType2.moveFailTimes + 1
        local newstateTypes = c.yield(setScreenListeners(battleListenerList, {
          { 'MAPS_TYPE_2_MOVE_TO_CHECK_POSITION_FOR_A_STEP', o.battle.isMapPage, 3000 } -- 如果移动后还是在地图页面，可能是遇到空隙。再次点击位置
        }))
        return makeAction(newstateTypes)
      end
      store.mapType2.moveFailTimes = 0

      local newstateTypes = c.yield(setScreenListeners(battleListenerList, {
        { 'SCAN_MAP_TYPE_1_INIT', o.battle.isMapPage, 3000 } -- 重新扫描
      }))
      return makeAction(newstateTypes)

    elseif action.type == 'MAPS_TYPE_2_PAGE_AMBUSHED_PANEL_AVOID_AMBUSHED' then

      stepLabel.setStepLabelContent('3.15.躲避伏击')
      if settings.battleRoundabout then
        o.battle.ambushedPanelClickAvoidBtn()
      else
        o.battle.ambushedPanelClickInterceptBtn()
      end
      local newstateTypes = c.yield(setScreenListeners(battleListenerList, {
        { 'MAPS_TYPE_2_MOVE_TO_CHECK_POSITION_FOR_A_STEP', o.battle.isMapPage, 3000 },
      }))
      return makeAction(newstateTypes)
    end

    return nil
  end))
end

return mapsType2

