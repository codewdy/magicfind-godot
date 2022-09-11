local M = {}

local Object = require("lib.object").Object
local Singleton = require("lib.singleton").Singleton
local MonsterPack = require("framework.monster_pack").MonsterPack
local UnitGroup = require("framework.unit").UnitGroup

M.BattleRunner = Singleton({
  start = function(self, ctx)
    ctx.level = ctx.player:current_level()
    ctx.units:add_unit_not_owned(ctx.player)
    if ctx.level % 5 == 0 then
      MonsterPack:create_pack(MonsterPack.Type.Boss, ctx.units)
    else
      MonsterPack:create_pack(MonsterPack.Type.Normal, ctx.units)
    end
  end,
  abort = function(self, ctx)
    ctx.task_runner:clear()
    ctx.units:clear()
  end,
  update = function(self, ctx)
    ctx.units:update()
    for _,units in ipairs(ctx.units.units) do
      for i = 1,units.size do
        units.vec[i]:pre_update()
      end
    end
    for _,units in ipairs(ctx.units.units) do
      for i = 1,units.size do
        units.vec[i]:update()
      end
    end
    ctx.task_runner:update()
    for _,units in ipairs(ctx.units.units) do
      for i = 1,units.size do
        units.vec[i]:post_update()
      end
    end
    ctx.task_runner:forward()
  end,
  level_clear = function(self, ctx)
    local monsters = ctx.units.units[UnitGroup.Enemy]
    for i = 1,monsters.size do
      if not monsters.vec[i].death then
        return false
      end
    end
    return true
  end,
  level_fail = function(self, ctx)
    return ctx.player.death
  end,
})

return M
