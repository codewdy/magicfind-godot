local M = {}

local Object = require("lib.object").Object

M.Skill = Object:extend({
  cast = function(self, arg)
    error("Abstract")
  end
})

return M
