local prefab = {}

function prefab:load(filename)
  local file = io.open(filename:to_utf8(), "r")
  local jsonstr = file:read()
  print(jsonstr)
  print(JSON:parse(jsonstr))
  file:close()
end

return prefab
