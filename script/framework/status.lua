local M = {}

local Object = require("lib.object").Object
local List = require("lib.list").List

M.Status = Object:extend({
  init = function(self)
    self.on_update = List:create()
    self.on_hit = List:create()
    self.on_struct = List:create()
    self.on_kill = List:create()
    self.on_death = List:create()
  end,
  clear = function(self)
    self.on_update:clear()
    self.on_hit:clear()
    self.on_struct:clear()
    self.on_kill:clear()
    self.on_death:clear()
  end,
  append = function(self, handler)
    if handler.on_update ~= nil then
      self.on_update:push_back(handler)
    end
    if handler.on_hit ~= nil then
      self.on_hit:push_back(handler)
    end
    if handler.on_struct ~= nil then
      self.on_struct:push_back(handler)
    end
    if handler.on_kill ~= nil then
      self.on_kill:push_back(handler)
    end
    if handler.on_death ~= nil then
      self.on_death:push_back(handler)
    end
    if handler.on_update_status ~= nil then
      handler:on_update_status(self)
    end
  end,
})

return M
