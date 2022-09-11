--[[
-- implement at buff base
-- apply(self, level, duartion)
-- update(self, unit)
--
-- implement at buff
-- update_with_level(self, unit, level)
-- prototype
--]]

local M = {}

local Object = require("lib.object").Object
local Prototype = require("framework.prototype").Prototype

M.Buff = Object:extend({
  init = function(self)
    self.activated = false
  end,
  clear = function(self)
    self.activated = false
  end,
  update_status = function(self, status)
    if self:update_level() then
      status:append(self)
    end
  end,
}, {
  extend = function(cls, fields)
    local prototype = Prototype:create()
    prototype:set_value(fields)
    fields.prototype = prototype
    local result = Object.extend(cls, fields, { prototype = prototype })
    return result
  end
})

M.SimpleBuff = Object:extend({
  init = function(self)
    M.Buff.init(self)
  end,
  clear = function(self)
    M.Buff.clear(self)
  end,
  apply = function(self, level, duration)
  end,
  update_level = function(self)
  end,
})

M.StackBuff = Object:extend({
  init = function(self)
    M.Buff.init(self)
  end,
  clear = function(self)
    M.Buff.clear(self)
  end,
  apply = function(self, level, duration)
  end,
  update_level = function(self)
  end,
})

M.NonstackBuff = Object:extend({
  init = function(self)
    M.Buff.init(self)
  end,
  clear = function(self)
    M.Buff.clear(self)
  end,
  apply = function(self, level, duration)
  end,
  update_level = function(self)
  end,
})

return M
