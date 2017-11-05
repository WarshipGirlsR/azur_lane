local sz = require 'sz'
local json = sz.json
local stepLabel = require 'StepLabel'

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
          ['text'] = '每一轮的间隔时间(秒)',
          ['size'] = 15,
          ['align'] = 'left',
          ['color'] = '0,0,0',
        },
        {
          ['id'] = 'missionsInterval',
          ['type'] = 'Edit',
          ['prompt'] = '最短间隔时间(秒)',
          ['text'] = '15',
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
          ['list'] = '手动,1-1,1-2,1-3,1-4,2-1,2-2,2-3,2-4,3-1,3-2,3-3,3-4,4-1,4-2,4-3,4-4,'
            .. '5-1,5-2,5-3,5-4,6-1,6-2,6-3,6-4,7-1,7-2,7-3,7-4,8-1,8-2,8-3,8-4,9-1,9-2,9-3,9-4,',
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
          ['select'] = '0',
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
          ['list'] = '无,1队,2队,3队,4队',
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
          ['text'] = '阵型',
          ['size'] = 15,
          ['align'] = 'left',
          ['color'] = '0,0,0',
        },
        {
          ['id'] = 'battleFormation',
          ['type'] = 'RadioGroup',
          ['list'] = '单纵,复纵,轮型,梯形,单横',
          ['select'] = '1',
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
          ['text'] = ' 1-1, 1-2, 1-3, 1-4, \n2-1, 2-2, 2-3, 2-4, \n3-1, 3-2, 3-3, 3-4, \n4-1, 4-2, \n5-1, 5-2, 5-3, 5-4, \n6-1, 6-2, 6-3, 6-4, \n7-1, 7-2, \n',
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
    }
  }

  local settingTableStr = json.encode(settingTable);
  closeStepLabel()
  local ret, settings = showUI(settingTableStr);
  if (ret ~= 1) then
    stepLabel.setStepLabelContent('取消运行')
    mSleep(100000)
    lua_exit()
  end
  stepLabel.setStepLabelContent('正在载入...')
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

  -- 出征
  settings.battleEnable = (function(battleEnable)
    local list = transStrToTable({ true, false, })
    return list[battleEnable] or false
  end)(settings.battleEnable)
  -- 总循环间隔时间
  settings.missionsInterval = tonumber(settings.missionsInterval) or 0
  -- 多长时间界面不变则重启，最少60秒
  settings.restartInterval = tonumber(settings.restartInterval) or 120
  settings.restartInterval = math.max(settings.restartInterval, 60)

  -- 选择关卡
  settings.battleChapter = (function(battleChapter)
    local list = transStrToTable({
      '0',
      '1-1', '1-2', '1-3', '1-4',
      '2-1', '2-2', '2-3', '2-4',
      '3-1', '3-2', '3-3', '3-4',
      '4-1', '4-2', '4-3', '4-4',
      '5-1', '5-2', '5-3', '5-4',
      '6-1', '6-2', '6-3', '6-4',
      '7-1', '7-2', '7-3', '7-4',
      '8-1', '8-2', '8-3', '8-4',
      '9-1', '9-2', '9-3', '9-4',
      --      'event4-1-sp1', 'event4-1-sp2', 'event4-1-sp3',
      --      'event5-1-a1', 'event5-1-a2', 'event5-1-a3',
      --      'event5-2-b1', 'event5-2-b2', 'event5-2-b3',
      --      'event6-1-sp1', 'event6-1-sp2', 'event6-1-sp3',
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
    local list = transStrToTable({
      'manual', 'auto',
    })
    return list[battleAssistantMode] or 'manual'
  end)(settings.battleAssistantMode)
  -- 选择Boss舰队
  settings.battleFleet = {}
  settings.battleFleetBoss = (function(battleFleetBoss)
    local list = transStrToTable({ 1, 2, 3, 4 })
    return list[battleFleetBoss] or 1
  end)(settings.battleFleetBoss)
  settings.battleFleet = { settings.battleFleetBoss }
  -- 选择道中舰队
  settings.battleFleetOnWay = (function(battleFleetOnWay)
    local list = transStrToTable({ 0, 1, 2, 3, 4 })
    local result = list[battleFleetOnWay] or 0
    if settings.battleFleetBoss == result then
      result = 0
    end
    return result
  end)(settings.battleFleetOnWay)
  if settings.battleFleetOnWay > 0 then
    settings.battleFleet = { settings.battleFleetBoss, settings.battleFleetOnWay }
  end
  -- 迂回战术
  settings.battleRoundabout = (function(battleRoundabout)
    local list = transStrToTable({ true, false, })
    return list[battleRoundabout] or false
  end)(settings.battleRoundabout)
  -- 当无法出征时是否跳过出征
  settings.battleAlertWhenNoHp = (function(battleAlertWhenNoHp)
    local list = transStrToTable({ true, false, })
    return list[battleAlertWhenNoHp] or false
  end)(settings.battleAlertWhenNoHp)
  -- 阵型
  settings.battleFormation = (function(battleFormation)
    local list = transStrToTable({ 1, 2, 3, 4, 5 })
    return list[battleFormation] or 2
  end)(settings.battleFormation)

  return ret, settings
end