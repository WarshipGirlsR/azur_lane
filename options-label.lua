local json = require './lib/json'
local mapsList = require './meta-operation/maps-options/index'

local canAutoMaps = table.map(table.keys(mapsList), function(item) return string.gsub(item, '^map', '') end)

local width, height = getScreenSize()
-- 设置
return function()
  local settingTable = {
    ['style'] = 'default',
    ['width'] = height,
    ['height'] = height,
    ['config'] = 'save_azur_lane.dat',
    ['timer'] = 5,
    ['orient'] = 1,
    ['pagetype'] = 'multi',
    ['title'] = '选项',
    ['cancelname'] = '取消',
    ['okname'] = '开始',
    ['rettype'] = 'table',
    ['pages'] = {
      {
        {
          ['type'] = 'Label',
          ['text'] = '第一次设置建议在竖屏下设置，设置好后再切换到游戏界面',
          ['size'] = 15,
          ['align'] = 'left',
          ['color'] = '0,0,0',
        },
        {
          ['type'] = 'Label',
          ['text'] = '向左滑动查看其他选项',
          ['size'] = 15,
          ['align'] = 'left',
          ['color'] = '0,0,0',
        },
        {
          ['type'] = 'Label',
          ['text'] = '出击',
          ['size'] = 15,
          ['align'] = 'left',
          ['color'] = '0,0,0',
        },
        {
          ['id'] = 'battleEnable',
          ['type'] = 'RadioGroup',
          ['list'] = '开启,关闭',
          ['select'] = '0',
        },
        {
          ['type'] = 'Label',
          ['text'] = '演习',
          ['size'] = 15,
          ['align'] = 'left',
          ['color'] = '0,0,0',
        },
        {
          ['id'] = 'exerciseEnable',
          ['type'] = 'RadioGroup',
          ['list'] = '开启,关闭',
          ['select'] = '0',
        },
        --        {
        --          ['type'] = 'Label',
        --          ['text'] = '女仆活动',
        --          ['size'] = 15,
        --          ['align'] = 'left',
        --          ['color'] = '0,0,0',
        --        },
        --        {
        --          ['id'] = 'maidBattleEnable',
        --          ['type'] = 'RadioGroup',
        --          ['list'] = '开启,关闭',
        --          ['select'] = '0',
        --        },
        --        {
        --          ['type'] = 'Label',
        --          ['text'] = '每日挑战',
        --          ['size'] = 15,
        --          ['align'] = 'left',
        --          ['color'] = '0,0,0',
        --        },
        --        {
        --          ['id'] = 'dailyChallengesEnable',
        --          ['type'] = 'RadioGroup',
        --          ['list'] = '开启,关闭',
        --          ['select'] = '0',
        --        },
        {
          ['type'] = 'Label',
          ['text'] = '任务',
          ['size'] = 15,
          ['align'] = 'left',
          ['color'] = '0,0,0',
        },
        {
          ['id'] = 'missionEnable',
          ['type'] = 'RadioGroup',
          ['list'] = '开启,关闭',
          ['select'] = '0',
        },
        {
          ['type'] = 'Label',
          ['text'] = '每一轮的间隔时间(秒)',
          ['size'] = 15,
          ['align'] = 'left',
          ['color'] = '0,0,0',
        },
        {
          ['id'] = 'missionsInterval',
          ['type'] = 'Edit',
          ['prompt'] = '最短间隔时间(秒)',
          ['text'] = '1',
          ['kbtype'] = 'number',
        },
        {
          ['type'] = 'Label',
          ['text'] = '多长时间画面不变则重启游戏(秒)最少60秒',
          ['size'] = 15,
          ['align'] = 'left',
          ['color'] = '0,0,0',
        },
        {
          ['id'] = 'restartInterval',
          ['type'] = 'Edit',
          ['prompt'] = '多长时间画面不变则重启游戏(秒)最少60秒',
          ['text'] = '120',
          ['kbtype'] = 'number',
        },
        {
          ['type'] = 'Label',
          ['text'] = ' \n \n \n \n \n \n \n \n \n \n',
          ['size'] = 50,
          ['align'] = 'left',
          ['color'] = '0,0,0',
        },
      },
      {
        {
          ['type'] = 'Label',
          ['text'] = '出击设置',
          ['size'] = 15,
          ['align'] = 'left',
          ['color'] = '0,0,0',
        },
        {
          ['type'] = 'Label',
          ['text'] = '章节(0章节表示不自动进入地图)',
          ['size'] = 15,
          ['align'] = 'left',
          ['color'] = '0,0,0',
        },
        {
          ['id'] = 'battleChapter',
          ['type'] = 'RadioGroup',
          ['list'] = '手动,1-1,1-2,1-3,1-4,2-1,2-2,2-3,2-4,3-1,3-2,3-3,3-4,3-sos,4-1,4-2,4-3,4-4,4-sos,'
            .. '5-1,5-2,5-3,5-4,5-sos,6-1,6-2,6-3,6-4,6-sos,7-1,7-2,7-3,7-4,7-sos,8-1,8-2,8-3,8-4,8-sos,'
            .. '9-1,9-2,9-3,9-4,9-sos,10-1,10-2,10-3,10-4,10-sos,11-1,11-2,11-3,11-4,12-1,12-2,12-3,12-4,'
            --            .. '光与影的鸢尾之华-a1/c1,光与影的鸢尾之华-a2/c2,光与影的鸢尾之华-a3/c3,'
            --            .. '光与影的鸢尾之华-b1/d1,光与影的鸢尾之华-b2/d2,光与影的鸢尾之华-b3/d3',
            .. '坠落之翼-a1/c1,坠落之翼-a2/c2,坠落之翼-a3/c3,'
            .. '坠落之翼-b1/d1,坠落之翼-b2/d2,坠落之翼-b3/d3',
          ['select'] = '0',
        },
        {
          ['type'] = 'Label',
          ['text'] = '难度',
          ['size'] = 15,
          ['align'] = 'left',
          ['color'] = '0,0,0',
        },
        {
          ['id'] = 'battleMode',
          ['type'] = 'RadioGroup',
          ['list'] = '普通,困难',
          ['select'] = '0',
        },
        {
          ['type'] = 'Label',
          ['text'] = '自动(可以自动的关卡看最底下)',
          ['size'] = 15,
          ['align'] = 'left',
          ['color'] = '0,0,0',
        },
        {
          ['id'] = 'battleAssistantMode',
          ['type'] = 'RadioGroup',
          ['list'] = '手动过地图,自动过地图',
          ['select'] = '1',
        },
        {
          ['type'] = 'Label',
          ['text'] = '因为5队6队显示有bug，暂时禁止选用',
          ['size'] = 15,
          ['align'] = 'left',
          ['color'] = '0,0,0',
        },
        {
          ['type'] = 'Label',
          ['text'] = '道中舰队',
          ['size'] = 15,
          ['align'] = 'left',
          ['color'] = '0,0,0',
        },
        {
          ['id'] = 'battleFleetOnWay',
          ['type'] = 'RadioGroup',
          ['list'] = '1队,2队,3队,4队,无',
          ['select'] = '0',
        },
        {
          ['type'] = 'Label',
          ['text'] = 'boss舰队',
          ['size'] = 15,
          ['align'] = 'left',
          ['color'] = '0,0,0',
        },
        {
          ['id'] = 'battleFleetBoss',
          ['type'] = 'RadioGroup',
          ['list'] = '1队,2队,3队,4队',
          ['select'] = '1',
        },
        {
          ['type'] = 'Label',
          ['text'] = '道中舰队阵型',
          ['size'] = 15,
          ['align'] = 'left',
          ['color'] = '0,0,0',
        },
        {
          ['id'] = 'battleFleetOnWayFormation',
          ['type'] = 'RadioGroup',
          ['list'] = '不设置,单纵,复纵,轮型',
          ['select'] = '0',
        },
        {
          ['type'] = 'Label',
          ['text'] = 'boss舰队阵型',
          ['size'] = 15,
          ['align'] = 'left',
          ['color'] = '0,0,0',
        },
        {
          ['id'] = 'battleFleetBossFormation',
          ['type'] = 'RadioGroup',
          ['list'] = '不设置,单纵,复纵,轮型',
          ['select'] = '0',
        },
        {
          ['type'] = 'Label',
          ['text'] = '回避',
          ['size'] = 15,
          ['align'] = 'left',
          ['color'] = '0,0,0',
        },
        {
          ['id'] = 'battleRoundabout',
          ['type'] = 'RadioGroup',
          ['list'] = '是,否',
          ['select'] = '0',
        },
        {
          ['type'] = 'Label',
          ['text'] = '行动方式',
          ['size'] = 15,
          ['align'] = 'left',
          ['color'] = '0,0,0',
        },
        {
          ['id'] = 'mapsType',
          ['type'] = 'RadioGroup',
          ['list'] = '打boss,打全图,无限伏击',
          ['select'] = '0',
        },
        {
          ['type'] = 'Label',
          ['text'] = '不能出征则震动提示',
          ['size'] = 15,
          ['align'] = 'left',
          ['color'] = '0,0,0',
        },
        {
          ['id'] = 'battleAlertWhenNoHp',
          ['type'] = 'RadioGroup',
          ['list'] = '是,否',
          ['select'] = '0',
        },
        {
          ['type'] = 'Label',
          ['text'] = '手动过图时震动提示',
          ['size'] = 15,
          ['align'] = 'left',
          ['color'] = '0,0,0',
        },
        {
          ['id'] = 'battleAlertWhenManual',
          ['type'] = 'RadioGroup',
          ['list'] = '是,否',
          ['select'] = '0',
        },
        {
          ['type'] = 'Label',
          ['text'] = '限制移动步长',
          ['size'] = 15,
          ['align'] = 'left',
          ['color'] = '0,0,0',
        },
        {
          ['id'] = 'battleStepLength',
          ['type'] = 'RadioGroup',
          ['list'] = '不限制,1,2,3,4,5,6,7,8',
          ['select'] = '0',
        },
        {
          ['type'] = 'Label',
          ['text'] = '捞到新船就停止(方便截图)',
          ['size'] = 15,
          ['align'] = 'left',
          ['color'] = '0,0,0',
        },
        {
          ['id'] = 'battleStopWhenGetNewShip',
          ['type'] = 'RadioGroup',
          ['list'] = '是,否',
          ['select'] = '0',
        },
        {
          ['type'] = 'Label',
          ['text'] = '可以自动过的关卡',
          ['size'] = 15,
          ['align'] = 'left',
          ['color'] = '0,0,0',
        },
        {
          ['type'] = 'Label',
          ['text'] = (function()
            local group = {}
            local keyList = {}
            for _, value in ipairs(canAutoMaps) do
              local tmpArr = string.split(value, '-')
              local key = tonumber(tmpArr[1]) or tmpArr[1]
              if key then
                if not group[key] then
                  group[key] = {}
                  table.insert(keyList, key)
                end
              end
              table.insert(group[key], value)
            end
            keyList = table.sortNumAndStr(keyList)
            local groupList = {}
            for _, key in ipairs(keyList) do
              local item = table.sortNumAndStr(group[key])
              local itemStr = table.concat(item, ',   ')
              table.insert(groupList, itemStr)
            end
            local result = table.concat(groupList, '\n')
            return result
          end)(),
          ['align'] = 'left',
          ['color'] = '0,0,0',
        },
        {
          ['type'] = 'Label',
          ['text'] = ' \n \n \n \n \n \n \n \n \n \n',
          ['size'] = 50,
          ['align'] = 'left',
          ['color'] = '0,0,0',
        },
      },
      {
        {
          ['type'] = 'Label',
          ['text'] = '演习',
          ['size'] = 15,
          ['align'] = 'left',
          ['color'] = '0,0,0',
        },
        {
          ['type'] = 'Label',
          ['text'] = '选择敌人',
          ['size'] = 15,
          ['align'] = 'left',
          ['color'] = '0,0,0',
        },
        {
          ['id'] = 'exerciseSelectEnemy',
          ['type'] = 'RadioGroup',
          ['list'] = '手动,1,2,3,4',
          ['select'] = '1',
        },
        {
          ['type'] = 'Label',
          ['text'] = '手动选择敌人时是否震动提醒',
          ['size'] = 15,
          ['align'] = 'left',
          ['color'] = '0,0,0',
        },
        {
          ['id'] = 'exerciseAlertWhenManualSelectEnemy',
          ['type'] = 'RadioGroup',
          ['list'] = '是,否',
          ['select'] = '0',
        },
        {
          ['type'] = 'Label',
          ['text'] = '血量低于百分之几则退出重新打',
          ['size'] = 15,
          ['align'] = 'left',
          ['color'] = '0,0,0',
        },
        {
          ['id'] = 'exerciseLowerHPRestart',
          ['type'] = 'RadioGroup',
          ['list'] = '95%,90%,85%,80%,75%,70%,65%,60%,50%,40%,30%,20%,10%',
          ['select'] = '11',
        },
        {
          ['type'] = 'Label',
          ['text'] = '间隔多长时间检查一次演习',
          ['size'] = 15,
          ['align'] = 'left',
          ['color'] = '0,0,0',
        },
        {
          ['id'] = 'exerciseInterval',
          ['type'] = 'Edit',
          ['prompt'] = '最短间隔时间(秒)',
          ['text'] = '900',
          ['kbtype'] = 'number',
        },
      },
      {
        {
          ['type'] = 'Label',
          ['text'] = '女仆活动',
          ['size'] = 15,
          ['align'] = 'left',
          ['color'] = '0,0,0',
        },
        {
          ['type'] = 'Label',
          ['text'] = '关卡',
          ['size'] = 15,
          ['align'] = 'left',
          ['color'] = '0,0,0',
        },
        {
          ['id'] = 'maidBattleChapter',
          ['type'] = 'RadioGroup',
          ['list'] = '简单,普通,困难',
          ['select'] = '2',
        },
      },
      {
        {
          ['type'] = 'Label',
          ['text'] = '每日挑战',
          ['size'] = 15,
          ['align'] = 'left',
          ['color'] = '0,0,0',
        },
        {
          ['type'] = 'Label',
          ['text'] = '战术研修关卡',
          ['size'] = 15,
          ['align'] = 'left',
          ['color'] = '0,0,0',
        },
        {
          ['id'] = 'tacticalTrainingChapter',
          ['type'] = 'RadioGroup',
          ['list'] = '1.战术研修(航空),2.战术研修(炮击),3.战术研修(雷击),',
          ['select'] = '0',
        },
        {
          ['type'] = 'Label',
          ['text'] = '战术研修舰队',
          ['size'] = 15,
          ['align'] = 'left',
          ['color'] = '0,0,0',
        },
        {
          ['id'] = 'tacticalTrainingFleet',
          ['type'] = 'RadioGroup',
          ['list'] = '1队,2队,3队,4队,5队,6队',
          ['select'] = '0',
        },
        {
          ['type'] = 'Label',
          ['text'] = '斩首行动关卡',
          ['size'] = 15,
          ['align'] = 'left',
          ['color'] = '0,0,0',
        },
        {
          ['id'] = 'decapitationStrikeChapter',
          ['type'] = 'RadioGroup',
          ['list'] = '1.,2.,3.,4.',
          ['select'] = '0',
        },
        {
          ['type'] = 'Label',
          ['text'] = '斩首行动舰队',
          ['size'] = 15,
          ['align'] = 'left',
          ['color'] = '0,0,0',
        },
        {
          ['id'] = 'decapitationStrikeFleet',
          ['type'] = 'RadioGroup',
          ['list'] = '1队,2队,3队,4队,5队,6队',
          ['select'] = '0',
        },
        {
          ['type'] = 'Label',
          ['text'] = '商船护送关卡',
          ['size'] = 15,
          ['align'] = 'left',
          ['color'] = '0,0,0',
        },
        {
          ['id'] = 'merchantShipEscortChapter',
          ['type'] = 'RadioGroup',
          ['list'] = '1.,2.,3.,4.',
          ['select'] = '0',
        },
        {
          ['type'] = 'Label',
          ['text'] = '商船护送舰队',
          ['size'] = 15,
          ['align'] = 'left',
          ['color'] = '0,0,0',
        },
        {
          ['id'] = 'merchantShipEscortFleet',
          ['type'] = 'RadioGroup',
          ['list'] = '1队,2队,3队,4队,5队,6队',
          ['select'] = '0',
        },
        {
          ['type'] = 'Label',
          ['text'] = '海域突进关卡',
          ['size'] = 15,
          ['align'] = 'left',
          ['color'] = '0,0,0',
        },
        {
          ['id'] = 'seaAreaBreakthroughChapter',
          ['type'] = 'RadioGroup',
          ['list'] = '1.,2.,3.,4.',
          ['select'] = '0',
        },
        {
          ['type'] = 'Label',
          ['text'] = '海域突进舰队',
          ['size'] = 15,
          ['align'] = 'left',
          ['color'] = '0,0,0',
        },
        {
          ['id'] = 'seaAreaBreakthroughFleet',
          ['type'] = 'RadioGroup',
          ['list'] = '1队,2队,3队,4队,5队,6队',
          ['select'] = '0',
        },
      },
    }
  }

  local settingTableStr = json.encode(settingTable);
  local ret, settings = showUI(settingTableStr);
  settings = table.assign({}, settings)
  console.log(settings)
  -- --转换settings结果
  function transStrToTable(str)
    local list = {}
    local strArr = {}
    if (type(str) == 'string') then
      strArr = strSplit(str, ',')
    elseif (type(str) == 'table') then
      strArr = str
    end
    for i, v in ipairs(strArr) do
      list['' .. (i - 1)] = v
    end
    return list
  end

  if settings then
    -- 出征
    settings.battleEnable = (function(battleEnable)
      local list = transStrToTable({ true, false, })
      return list[battleEnable] or false
    end)(settings.battleEnable)
    -- 演习
    settings.exerciseEnable = (function(exerciseEnable)
      local list = transStrToTable({ true, false, })
      return list[exerciseEnable] or false
    end)(settings.exerciseEnable)
    --    -- 女仆活动
    --    settings.maidBattleEnable = (function(maidBattleEnable)
    --      local list = transStrToTable({ true, false, })
    --      return list[maidBattleEnable] or false
    --    end)(settings.maidBattleEnable)
    -- 每日挑战
    settings.dailyChallengesEnable = (function(dailyChallengesEnable)
      local list = transStrToTable({ true, false, })
      return list[dailyChallengesEnable] or false
    end)(settings.dailyChallengesEnable)
    -- 任务
    settings.missionEnable = (function(missionEnable)
      local list = transStrToTable({ true, false, })
      return list[missionEnable] or false
    end)(settings.missionEnable)
    -- 总循环间隔时间
    settings.missionsInterval = tonumber(settings.missionsInterval) or 0
    -- 多长时间界面不变则重启，最少60秒
    settings.restartInterval = tonumber(settings.restartInterval) or 120
    settings.restartInterval = math.max(settings.restartInterval, 60)

    -- 选择关卡
    settings.battleChapter = (function(battleChapter)
      local list = transStrToTable({
        { name = '0', chapter = 0, section = '0' },
        { name = '1-1', chapter = 1, section = '1' }, { name = '1-2', chapter = 1, section = '2' },
        { name = '1-3', chapter = 1, section = '3' }, { name = '1-4', chapter = 1, section = '4' },
        { name = '2-1', chapter = 2, section = '1' }, { name = '2-2', chapter = 2, section = '2' },
        { name = '2-3', chapter = 2, section = '3' }, { name = '2-4', chapter = 2, section = '4' },
        { name = '3-1', chapter = 3, section = '1' }, { name = '3-2', chapter = 3, section = '2' },
        { name = '3-3', chapter = 3, section = '3' }, { name = '3-4', chapter = 3, section = '4' },
        { name = '3-sos', chapter = 3, section = 'sos' },
        { name = '4-1', chapter = 4, section = '1' }, { name = '4-2', chapter = 4, section = '2' },
        { name = '4-3', chapter = 4, section = '3' }, { name = '4-4', chapter = 4, section = '4' },
        { name = '4-sos', chapter = 4, section = 'sos' },
        { name = '5-1', chapter = 5, section = '1' }, { name = '5-2', chapter = 5, section = '2' },
        { name = '5-3', chapter = 5, section = '3' }, { name = '5-4', chapter = 5, section = '4' },
        { name = '5-sos', chapter = 5, section = 'sos' },
        { name = '6-1', chapter = 6, section = '1' }, { name = '6-2', chapter = 6, section = '2' },
        { name = '6-3', chapter = 6, section = '3' }, { name = '6-4', chapter = 6, section = '4' },
        { name = '6-sos', chapter = 6, section = 'sos' },
        { name = '7-1', chapter = 7, section = '1' }, { name = '7-2', chapter = 7, section = '2' },
        { name = '7-3', chapter = 7, section = '3' }, { name = '7-4', chapter = 7, section = '4' },
        { name = '7-sos', chapter = 7, section = 'sos' },
        { name = '8-1', chapter = 8, section = '1' }, { name = '8-2', chapter = 8, section = '2' },
        { name = '8-3', chapter = 8, section = '3' }, { name = '8-4', chapter = 8, section = '4' },
        { name = '8-sos', chapter = 8, section = 'sos' },
        { name = '9-1', chapter = 9, section = '1' }, { name = '9-2', chapter = 9, section = '2' },
        { name = '9-3', chapter = 9, section = '3' }, { name = '9-4', chapter = 9, section = '4' },
        { name = '9-sos', chapter = 9, section = 'sos' },
        { name = '10-1', chapter = 10, section = '1' }, { name = '10-2', chapter = 10, section = '2' },
        { name = '10-3', chapter = 10, section = '3' }, { name = '10-4', chapter = 10, section = '4' },
        { name = '10-sos', chapter = 10, section = 'sos' },
        { name = '11-1', chapter = 11, section = '1' }, { name = '11-2', chapter = 11, section = '2' },
        { name = '11-3', chapter = 11, section = '3' }, { name = '11-4', chapter = 11, section = '4' },
        { name = '12-1', chapter = 12, section = '1' }, { name = '12-2', chapter = 12, section = '2' },
        { name = '12-3', chapter = 12, section = '3' }, { name = '12-4', chapter = 12, section = '4' },
        --        { name = 'gyydywzh-a1', chapter = 1, section = 'a1', type = 'event' },
        --        { name = 'gyydywzh-a2', chapter = 1, section = 'a2', type = 'event' },
        --        { name = 'gyydywzh-a3', chapter = 1, section = 'a3', type = 'event' },
        --        { name = 'gyydywzh-b1', chapter = 2, section = 'b1', type = 'event' },
        --        { name = 'gyydywzh-b2', chapter = 2, section = 'b2', type = 'event' },
        --        { name = 'gyydywzh-b3', chapter = 2, section = 'b3', type = 'event' },
        { name = 'zlzy-a1', chapter = 1, section = 'a1', type = 'event' },
        { name = 'zlzy-a2', chapter = 1, section = 'a2', type = 'event' },
        { name = 'zlzy-a3', chapter = 1, section = 'a3', type = 'event' },
        { name = 'zlzy-b1', chapter = 2, section = 'b1', type = 'event' },
        { name = 'zlzy-b2', chapter = 2, section = 'b2', type = 'event' },
        { name = 'zlzy-b3', chapter = 2, section = 'b3', type = 'event' },
      })
      return list[battleChapter] or '0'
    end)(settings.battleChapter)
    -- 选择模式
    settings.battleMode = (function(battleMode)
      local list = transStrToTable({
        'normal', 'hard',
      })
      return list[battleMode] or 'normal'
    end)(settings.battleMode)
    -- 选择辅助模式
    settings.battleAssistantMode = (function(battleAssistantMode)
      local list = transStrToTable({ 'manual', 'auto' })
      return list[battleAssistantMode] or 'manual'
    end)(settings.battleAssistantMode)
    -- 选择道中舰队
    settings.battleFleetOnWay = (function(battleFleetOnWay)
      local list = transStrToTable({ 1, 2, 3, 4, 0, })
      local result = list[battleFleetOnWay] or 0
      if settings.battleFleetBoss == result then
        result = 0
      end
      return result
    end)(settings.battleFleetOnWay)
    -- 选择Boss舰队
    settings.battleFleetBoss = (function(battleFleetBoss)
      local list = transStrToTable({ 1, 2, 3, 4, 5, 6 })
      return list[battleFleetBoss] or 1
    end)(settings.battleFleetBoss)
    -- 选择道中舰队阵型
    settings.battleFleetOnWayFormation = (function(battleFleetOnWayFormation)
      local list = transStrToTable({ false, 'single file', 'double file', 'wheeled file' })
      return list[battleFleetOnWayFormation] or false
    end)(settings.battleFleetOnWayFormation)
    -- 选择Boss舰队阵型
    settings.battleFleetBossFormation = (function(battleFleetBossFormation)
      local list = transStrToTable({ false, 'single file', 'double file', 'wheeled file' })
      return list[battleFleetBossFormation] or false
    end)(settings.battleFleetBossFormation)
    -- 合并两个舰队选项
    settings.battleFleet = { settings.battleFleetBoss }
    if settings.battleFleetOnWay > 0 then
      settings.battleFleet = { settings.battleFleetBoss, settings.battleFleetOnWay }
    end
    -- 迂回战术
    settings.battleRoundabout = (function(battleRoundabout)
      local list = transStrToTable({ true, false, })
      return list[battleRoundabout] or false
    end)(settings.battleRoundabout)
    -- 行动方式
    settings.mapsType = (function(mapsType)
      local list = transStrToTable({
        'maps-type-2',
        'maps-type-3',
        'maps-type-4',
      })
      return list[mapsType] or 'maps-type-2'
    end)(settings.mapsType)
    -- 当无法出征时是否跳过出征
    settings.battleAlertWhenNoHp = (function(battleAlertWhenNoHp)
      local list = transStrToTable({ true, false, })
      return list[battleAlertWhenNoHp] or false
    end)(settings.battleAlertWhenNoHp)
    -- 手动过图时震动提示
    settings.battleAlertWhenManual = (function(battleAlertWhenManual)
      local list = transStrToTable({ true, false, })
      return list[battleAlertWhenManual] or false
    end)(settings.battleAlertWhenManual)
    -- 捞到新船就停止
    settings.battleStopWhenGetNewShip = (function(battleStopWhenGetNewShip)
      local list = transStrToTable({ true, false, })
      return list[battleStopWhenGetNewShip] or false
    end)(settings.battleStopWhenGetNewShip)
    -- 限制步长
    settings.battleStepLength = (function(battleStepLength)
      local list = transStrToTable({ 0, 1, 2, 3, 4, 5, 6, 7, 8 })
      return list[battleStepLength] or 0
    end)(settings.battleStepLength)
    -- 演习
    -- 是否自动选择敌人，选择第几个敌人
    settings.exerciseSelectEnemy = (function(exerciseSelectEnemy)
      local list = transStrToTable({ 'manual', 1, 2, 3, 4 })
      return list[exerciseSelectEnemy] or 'manual'
    end)(settings.exerciseSelectEnemy)
    -- 手动选择敌人时是否震动提醒
    settings.exerciseAlertWhenManualSelectEnemy = (function(exerciseAlertWhenManualSelectEnemy)
      local list = transStrToTable({ true, false })
      return list[exerciseAlertWhenManualSelectEnemy] or true
    end)(settings.exerciseAlertWhenManualSelectEnemy)
    -- 血量低于某值则退出重新开始
    settings.exerciseLowerHPRestart = (function(exerciseLowerHPRestart)
      local list = transStrToTable({ 0.95, 0.9, 0.85, 0.8, 0.75, 0.7, 0.65, 0.6, 0.5, 0.4, 0.3, 0.2, 0.1 })
      return list[exerciseLowerHPRestart] or 0.5
    end)(settings.exerciseLowerHPRestart)
    -- 检查演习间隔时间
    settings.exerciseInterval = tonumber(settings.exerciseInterval) or 0
    -- 女仆活动
    -- 女仆活动关卡
    settings.maidBattleChapter = (function(maidBattleChapter)
      local list = transStrToTable({ 1, 2, 3 })
      return list[maidBattleChapter] or 1
    end)(settings.maidBattleChapter)
    -- 每日挑战
    -- 战术研修关卡
    settings.tacticalTrainingChapter = (function(tacticalTrainingChapter)
      local list = transStrToTable({ 1, 2, 3 })
      return list[tacticalTrainingChapter] or 1
    end)(settings.tacticalTrainingChapter)
    -- 战术研修舰队
    settings.tacticalTrainingFleet = (function(tacticalTrainingFleet)
      local list = transStrToTable({ 1, 2, 3, 4, 5, 6 })
      return list[tacticalTrainingFleet] or 1
    end)(settings.tacticalTrainingFleet)
    -- 斩首行动关卡
    settings.decapitationStrikeChapter = (function(decapitationStrikeChapter)
      local list = transStrToTable({ 1, 2, 3, 4 })
      return list[decapitationStrikeChapter] or 1
    end)(settings.decapitationStrikeChapter)
    -- 斩首行动舰队
    settings.decapitationStrikeFleet = (function(decapitationStrikeFleet)
      local list = transStrToTable({ 1, 2, 3, 4, 5, 6 })
      return list[decapitationStrikeFleet] or 1
    end)(settings.decapitationStrikeFleet)
    -- 商船护送关卡
    settings.merchantShipEscortChapter = (function(merchantShipEscortChapter)
      local list = transStrToTable({ 1, 2, 3, 4 })
      return list[merchantShipEscortChapter] or 1
    end)(settings.merchantShipEscortChapter)
    -- 商船护送舰队
    settings.merchantShipEscortFleet = (function(merchantShipEscortFleet)
      local list = transStrToTable({ 1, 2, 3, 4, 5, 6 })
      return list[merchantShipEscortFleet] or 1
    end)(settings.merchantShipEscortFleet)
    -- 海域突进关卡
    settings.seaAreaBreakthroughChapter = (function(seaAreaBreakthroughChapter)
      local list = transStrToTable({ 1, 2, 3, 4 })
      return list[seaAreaBreakthroughChapter] or 1
    end)(settings.seaAreaBreakthroughChapter)
    -- 海域突进舰队
    settings.seaAreaBreakthroughFleet = (function(seaAreaBreakthroughFleet)
      local list = transStrToTable({ 1, 2, 3, 4, 5, 6 })
      return list[seaAreaBreakthroughFleet] or 1
    end)(settings.seaAreaBreakthroughFleet)
  end

  return ret, settings
end



