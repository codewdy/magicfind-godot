local M = {}

local Object = require("lib.object").Object
local ObjectList = require("lib.list").ObjectList

M.SkillCooldownUnit = Object:extend({
  init = function(self)
    self.skill_handle = -1
    self.cooldown = 0
  end,
  clear = function(self)
    self.skill_handle = -1
    self.cooldown = 0
  end,
})

M.SkillCooldownList = ObjectList(M.SkillCooldownUnit)

M.SkillCooldown = Object:extend({
  init = function(self)
    self.list = M.SkillCooldownList:create()
  end,
  clear = function(self)
    self.list:clear()
  end,
  cooldown = function(self, idx, skill_handle, cooldown)
    if self.list.size < idx then
      self.list:resize(idx)
    end
    if self.list.vec[idx].skill_handle ~= skill_handle then
      self.list.vec[idx].skill_handle = skill_handle
      self.list.vec[idx].cooldown = 1
    else
      self.list.vec[idx].cooldown = self.list.vec[idx].cooldown + 1
    end
    if self.list.vec[idx].cooldown >= cooldown then
      self.list.vec[idx].cooldown = self.list.vec[idx].cooldown - cooldown
      return true
    else
      return false
    end
  end,
})

return M
