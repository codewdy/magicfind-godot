local M = {}

local Object = require("lib.object").Object

M.List = Object:extend({
  init = function(self)
    self.vec = {}
    self.size = 0
  end,

  clear = function(self)
    self:resize(0)
  end,

  add_back = function(self)
    self.size = self.size + 1
    if #self.vec < self.size then
      if self.init_unit ~= nil then
        self.vec[self.size] = self:init_unit()
      end
    end
    return self.vec[self.size]
  end,

  push_back = function(self, v)
    self.size = self.size + 1
    self.vec[self.size] = v
  end,

  resize = function(self, size)
    if self.size < size then
      if self.init_unit ~= nil then
        for i = math.max(self.size, #self.vec) + 1, size do
          self.vec[i] = self:init_unit()
        end
      end
      self.size = size
    elseif self.size > size then
      if self.clear_unit ~= nil then
        for i = size + 1, self.size do
          self.vec[i] = self:clear_unit(self.vec[i])
        end
      end
      self.size = size
    end
  end,
  random_one = function(self)
    return self.vec[math.random(self.size)]
  end
})

function M.ObjectList(cls)
  return M.List:extend({
    init_unit = function(self)
      return cls:create()
    end,
    clear_unit = function(self, unit)
      unit:release()
      return unit
    end
  })
end

function M.MakeList(lst)
  local result = M.List:create()
  for _,v in ipairs(lst) do
    result:push_back(v)
  end
  return result
end

return M
