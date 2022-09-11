local M = {}

function M.import(root, list)
  local result = {}
  for _,name in ipairs(list) do
    result[name] = require(root .. "." .. name)
  end
  return result
end

return M
