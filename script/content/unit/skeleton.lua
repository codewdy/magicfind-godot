local M = {}

local Unit = require("framework.unit").Unit

M.Skeleton = Unit:extend({
  name = "Skeleton",
  icon = "Skeleton",
  size = 1,
  maxHp = 100,
})

return M
