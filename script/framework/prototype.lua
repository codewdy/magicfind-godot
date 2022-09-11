local M = {}

local Object = require("lib.object").Object

M.Prototype = Object:extend({
  init = function(self)
    self.dict = {}
  end,
  set_value = function(self, dict)
    for k,v in pairs(dict) do
      self[k] = v
      self.dict[k] = v
    end
  end
})

return M
