local M = {}

local Object = require("lib.object").Object
local Prototype = require("framework.prototype").Prototype

local build_function = {
  [0] = function(cls)
    local result = cls:create()
    return result
  end,
  [1] = function(cls, v1)
    local result = cls:create()
    result.vec[1] = v1
    return result
  end,
  [2] = function(cls, v1, v2)
    local result = cls:create()
    result.vec[1] = v1
    result.vec[2] = v2
    return result
  end,
  [3] = function(cls, v1, v2, v3)
    local result = cls:create()
    result.vec[1] = v1
    result.vec[2] = v2
    result.vec[3] = v3
    return result
  end,
  [4] = function(cls, v1, v2, v3, v4)
    local result = cls:create()
    result.vec[1] = v1
    result.vec[2] = v2
    result.vec[3] = v3
    result.vec[4] = v4
    return result
  end,
  [5] = function(cls, v1, v2, v3, v4, v5)
    local result = cls:create()
    result.vec[1] = v1
    result.vec[2] = v2
    result.vec[3] = v3
    result.vec[4] = v4
    result.vec[5] = v5
    return result
  end,
  [6] = function(cls, v1, v2, v3, v4, v5, v6)
    local result = cls:create()
    result.vec[1] = v1
    result.vec[2] = v2
    result.vec[3] = v3
    result.vec[4] = v4
    result.vec[5] = v5
    result.vec[6] = v6
    return result
  end,
}

M.Effect = Object:extend({
  init = function(self)
    self.size = self.prototype.size
    self.vec = {}
  end,
}, {
  Type = {},
  extend = function(cls, fields)
    local prototype = Prototype:create()
    prototype:set_value(fields)
    fields.prototype = prototype
    local result = Object.extend(cls, fields, { prototype = prototype })
    result.build = build_function[fields.size]
    return result
  end
})

return M
