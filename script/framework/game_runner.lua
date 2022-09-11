local M = {}

local Object = require("lib.object").Object
local Singleton = require("lib.singleton").Singleton
local Enum = require("lib.enum").Enum
local BattleRunner = require("framework.battle_runner").BattleRunner

M.GameState = Enum({
  "Prepare",
  "PathFinding",
  "Battle",
  "Death"
})

M.GameRunner = Singleton({
  update = function(self, ctx)
    ctx.effects:clear()
    local state = M.GameState.Prepare
    if (ctx.change_to_state ~= nil) then
      state = ctx.change_to_state
      ctx.change_to_state = nil
    else
      state = self.processor[ctx.state].run(ctx)
    end
    if state ~= ctx.state then
      self.processor[ctx.state].stop(ctx)
      ctx.state = state
      self.processor[ctx.state].start(ctx)
    end
  end,

  change_state = function(self, ctx, state)
    ctx.change_to_state = state
  end,

  processor = {
    [M.GameState.Prepare] = {
      start = function(ctx) end,
      stop = function(ctx) end,
      run = function(ctx)
        if ctx.player ~= nil then
          ctx.player:recycle()
        end
        ctx.player = ctx:load_player(ctx.player_filename)
        return M.GameState.PathFinding
      end
    },
    [M.GameState.PathFinding] = {
      start = function(ctx)
        ctx.path_finding_countdown = ctx.player:path_finding_time()
      end,
      stop = function(ctx) end,
      run = function(ctx)
        ctx.path_finding_countdown = ctx.path_finding_countdown - 1
        if ctx.path_finding_countdown <= 0 then
          return M.GameState.Battle
        else
          return M.GameState.PathFinding
        end
      end
    },
    [M.GameState.Battle] = {
      start = function(ctx)
        BattleRunner:start(ctx)
      end,
      stop = function(ctx)
        BattleRunner:abort(ctx)
      end,
      run = function(ctx)
        BattleRunner:update(ctx)
        if BattleRunner:level_fail(ctx) then
          return M.GameState.Death
        elseif BattleRunner:level_clear(ctx) then
          return M.GameState.PathFinding
        else
          return M.GameState.Battle
        end
      end
    },
    [M.GameState.Death] = {
      start = function(ctx) end,
      stop = function(ctx) end,
      run = function(ctx)
        return M.GameState.PathFinding
      end
    },
  },
})

return M
