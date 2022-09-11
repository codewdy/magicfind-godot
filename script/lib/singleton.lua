local M = {}

local Object = require("lib.object").Object

function M.Singleton(fields)
  return Object:extend(fields):create()
end

return M
