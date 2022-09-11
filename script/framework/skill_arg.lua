local M = {}

local Object = require("lib.object").Object
local Enum = require("lib.enum").Enum

M.SkillTrigger = Enum({
  "None",
  "Cooldown",
})

M.SkillArg = Object:extend({
  init = function(self)
    self.trigger = M.SkillTrigger.None
    self.factor = 1.0
  end,
  clear = function(self)
    self:set_trigger(M.SkillTrigger.None)
  end,
  set_trigger = function(self, type)
    self.trigger = type
    self.on_update = nil
    if self.trigger == M.SkillTrigger.Cooldown then
      self.on_update = self.maybe_on_update
    end
  end,
  update_status = function(self, status)
    status:append(self)
  end,
  maybe_on_update = function(self, unit)
    if unit.skill_cooldown:cooldown(self.idx, self.skill.handle, 1.0 / self.factor) then
      self.skill:cast(self)
    end
  end,
})

M.CooldownSkill = function(skill, cooldown)
  local result = M.SkillArg:create()
  result.skill = skill
  result.factor = 1.0 / cooldown
  result:set_trigger(M.SkillTrigger.Cooldown)
  return result
end

return M
