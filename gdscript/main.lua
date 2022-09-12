local main = {
  extends = "Node",
}

local loader = require("gdscript.loader")

function main:_enter_tree()
  loader:load()
  local p = require("ui.prefab"):load(loader:path():plus_file("prefab/main.json"))
  self:add_child(p)
end

return main
