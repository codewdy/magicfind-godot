local M = {}

local Object = require("lib.object").Object
local List = require("lib.list").List
local ObjectList = require("lib.list").ObjectList
local Unit = require("framework.unit").Unit
local UnitList = ObjectList(Unit)

M.UnitCollection = Object:extend({
  init = function(self)
    self.units = {
      List:create(),
      List:create()
    }
    self.own_units = UnitList:create()
  end,
  clear = function(self)
    self.own_units:clear()
    for _,units in ipairs(self.units) do
      units:clear()
    end
  end,
  update = function(self)
    for _,units in ipairs(self.units) do
      for i = 1,units.size do
        if i > units.size then
          break
        end
        if units.vec[i].death then
          units.vec[i] = units.vec[units.size]
          units.size = units.size - 1
        end
      end
    end
  end,
  add_unit = function(self, unit)
    self.units[unit.group]:push_back(unit)
    self.own_units:push_back(unit)
  end,
  add_unit_not_owned = function(self, unit)
    self.units[unit.group]:push_back(unit)
  end
})

return M
