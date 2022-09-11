local M = {}

local Singleton = require("lib.singleton").Singleton
local Enum = require("lib.enum").Enum
local List = require("lib.list").List
local Unit = require("framework.unit").Unit
local UnitGroup = require("framework.unit").UnitGroup

M.MonsterPack = Singleton({
  Type = Enum({
    "Normal",
    "Boss"
  }),
  init = function(self)
    self.packs = {}
    for id, name in ipairs(self.Type.enums) do
      self.packs[id] = List:create()
    end
  end,
  register_pack_by_creator = function(self, type, creator)
    self.packs[self.Type[type]]:push_back(creator)
  end,
  create_pack = function(self, type, units)
    self.packs[type]:random_one()(units)
  end,
  register_pack = function(self, type, monsters)
    local creator = function(units)
      for monster_name,size in pairs(monsters) do
        local monster = Unit.Type[monster_name]
        for i=1,size do
          local unit = monster:create()
          unit.group = UnitGroup.Enemy
          units:add_unit(unit)
        end
      end
    end
    self:register_pack_by_creator(type, creator)
  end
})

return M
