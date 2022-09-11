local M = {}

function M.dump_bool(obj)
  return tostring(obj)
end

function M.dump_number(obj)
  return tostring(obj)
end

function M.dump_string(obj)
  -- TODO: more escape
  return '"' .. (obj:gsub('"', '\\"')) .. '"'
end

function M.dump_table(obj)
  if obj.serialize ~= nil then
    return M.dump(obj:serialize())
  end
  local result = ""
  for k,v in pairs(obj) do
    result = result .. M.dump(k) .. ':' .. M.dump(v) .. ','
  end
  return '{' .. result:sub(1, #result - 1) .. '}'
end

function M.dump(obj)
  if type(obj) == 'boolean' then
    return M.dump_bool(obj)
  end
  if type(obj) == 'number' then
    return M.dump_number(obj)
  end
  if type(obj) == 'string' then
    return M.dump_string(obj)
  end
  if type(obj) == 'table' then
    return M.dump_table(obj)
  end
  if type(obj) == 'function' then
    return '"<function>"'
  end
  error("cannot parse type " .. type(obj))
end

return M
