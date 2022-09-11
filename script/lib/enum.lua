local M = {}

function M.Enum(enums)
  local result = {}
  for id, key in ipairs(enums) do
    result[key] = id
  end
  result.enums = enums
  return result
end

return M
