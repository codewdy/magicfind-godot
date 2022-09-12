local prefab = {}

prefab.processor = {
  type = function(obj, v)
    -- Just Ignore
  end,
  script = function(obj, v)
    -- Just Ignore
  end,
  name = function(obj, v)
    obj:set_name(v)
  end,
  anchor = function(obj, v)
    obj:set_anchor(GD.MARGIN_LEFT, v["left"], true)
    obj:set_anchor(GD.MARGIN_RIGHT, v["right"], true)
    obj:set_anchor(GD.MARGIN_TOP, v["top"], true)
    obj:set_anchor(GD.MARGIN_BOTTOM, v["bottom"], true)
  end,
  margin = function(obj, v)
    obj:set_margin(GD.MARGIN_LEFT, v["left"])
    obj:set_margin(GD.MARGIN_RIGHT, v["right"])
    obj:set_margin(GD.MARGIN_TOP, v["top"])
    obj:set_margin(GD.MARGIN_BOTTOM, v["bottom"])
  end,
}

function prefab:create_obj(json)
  local result = _G[json["type"]:to_ascii()]:new()
  for k,v in pairs(json) do
    self.processor[k:to_ascii()](result, v)
  end
  return result
end

function prefab:load(filename)
  local file = io.open(filename:to_utf8(), "r")
  local jsonstr = file:read("a")
  file:close()
  local result = JSON:parse(jsonstr):get_result()
  return self:create_obj(result)
end

return prefab
