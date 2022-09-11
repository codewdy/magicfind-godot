local M = {}

local Object = require("lib.object").Object
local UnitCollection = require("framework.unit_collection").UnitCollection
local TaskRunner = require("framework.task_runner").TaskRunner
local Player = require("framework.player").Player
local GameState = require("framework.game_runner").GameState
local EffectCollection = require("framework.effect_collection").EffectCollection

M.Context = {
  state = GameState.Prepare,
  change_to_state = nil,
  player = nil,

  -- Prepare
  load_player = function(ctx, filename)
    local player = Player:create()
    player:load(ctx, filename)
    return player
  end,

  -- PathFinding
  path_finding_countdown = 0,

  -- Battle
  level = 1,
  units = UnitCollection:create(),
  task_runner = TaskRunner:create(),
  effects = EffectCollection:create(),
}

return M
