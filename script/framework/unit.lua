local M = {}

local Object = require("lib.object").Object
local List = require("lib.list").List
local Enum = require("lib.enum").Enum
local Prototype = require("framework.prototype").Prototype
local BuffManager = require("framework.buff_manager").BuffManager
local Status = require("framework.status").Status
local SkillCooldown = require("framework.skill_cooldown").SkillCooldown

M.UnitGroup = Enum({
  "Player",
  "Enemy"
})

M.Unit = Object:extend({
  init = function(self)
    self.pos_x = 0.0
    self.pos_y = 0.0
    self.group = M.UnitGroup.Player
    self.death = false
    self.hp = 1
    self.maxHp = 1
    self.buff_manager = BuffManager:create()
    self.status = Status:create()
    self.skill_cooldown = SkillCooldown:create()
  end,
  clear = function(self)
    self.death = false
    self.buff_manager:clear()
    self.skill_cooldown:clear()
  end,
  pre_update = function(self)
    self.status:clear()
    for i=1,self.prototype.talents.size do
      self.prototype.talents.vec[i]:update_status(self.status)
    end
    self.buff_manager:update_status(self.status)
    for i=1,self.prototype.skills.size do
      self.prototype.skills.vec[i].idx = i
      self.prototype.skills.vec[i]:update_status(self.status)
    end
    for i=1,self.prototype.talents.size do
      self.prototype.talents.vec[i]:post_update_status(self.status)
    end
  end,
  update = function(self)
    for i=1,self.status.on_update.size do
      self.status.on_update.vec[i]:on_update(self)
    end
  end,
  post_update = function(self)
    if self.hp < 0 then
      self.death = true
    end
  end
}, {
  Type = {},
  default_prototype = {
    talents = List:create(),
    skills = List:create(),
  },
  extend = function(cls, fields)
    local prototype = Prototype:create()
    prototype:set_value(cls.default_prototype)
    prototype:set_value(fields)
    fields.prototype = prototype
    local result = Object.extend(cls, fields, { prototype = prototype })
    M.Unit.Type[fields.name] = result
    return result
  end
})

return M
