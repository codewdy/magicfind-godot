local M = {}

Skill = require("framework.skill").Skill

M.DebugSkill = Skill:extend({
  cast = function(self, arg)
    print("DEBUG CASTING")
  end
}):create()

return M
