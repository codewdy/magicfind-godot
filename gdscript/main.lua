local main = {
  extends = "Node",
}

local loader = require("gdscript.loader")

function main:_enter_tree()
  loader:load()
  require("ui.prefab"):load(loader:path():plus_file("ui/main.json"))
end

return main
