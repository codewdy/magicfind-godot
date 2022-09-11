local main = {
  extends = "Node",
}

loader = require("gdscript.loader")

function main:_enter_tree()
  loader:load()
  require("ui.loader"):load(loader:path():plus_file("ui/main.json"))
end

return main
