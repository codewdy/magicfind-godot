local main = {
  extends = "Node",
}

loader = require("gdscript.loader")

function main:_enter_tree()
  loader:load()
end

return main
