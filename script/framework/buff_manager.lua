local M = {}

local Object = require("lib.object").Object
local List = require("lib.list").List

M.BuffManager = Object:extend({
  init = function(self)
    self.buff = {}
    self.activated_buff = List:create()
  end,
  clear = function(self)
    for i = 1,self.activated_buff.size do
      self.activated_buff.vec[i]:clear()
    end
    self.activated_buff:clear()
  end,
  update_status = function(self, status)
    for i = 1,self.activated_buff.size do
      self.activated_buff.vec[i]:update_status(status)
    end
  end,
  apply = function(self, cls, level, duration)
    local handle = cls.prototype.handle
    if self.buff[handle] == nil then
      self.buff[handle] = cls:create()
    end
    local buff = self.buff[handle]
    if not buff.activated then
      self.activated_buff:push_back(buff)
    end
    buff:apply(level, duration)
  end,
})

return M
