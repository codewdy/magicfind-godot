local M = {}

local Object = require("lib.object").Object
local ObjectList = require("lib.list").ObjectList
local Effect = require("framework.effect").Effect

local EffectList = ObjectList(Effect)

M.EffectCollection = Object:extend({
  init = function(self)
    self.effects = EffectList:create()
    self.max_effect = 50
  end,
  clear = function(self)
    self.effects:clear()
  end,
  set_max = function(self, max_effect)
    self.max_effect = max_effect
  end,
  add = function(self, effect)
    if self.effects.size >= self.max_effect then
      effect:release()
    else
      self.effects:push_back(effect)
    end
  end,
})

return M
