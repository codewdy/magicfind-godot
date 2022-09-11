local M = {}

local Object = require("lib.object").Object
local ObjectList = require("lib.list").ObjectList

M.Task = Object:extend({
  run = function(self)
  end,
  abort = function(self)
  end
})

local TaskList = ObjectList(M.Task)

M.TaskRunner = Object:extend({
  init = function(self)
    self.current = 0
    self.tasks = {}
  end,
  clear = function(self)
    self.current = 0
    self:abort()
  end,
  schedule = function(self, task, delay)
    local step = self.current + delay
    if self.tasks[step] == nil then
      self.tasks[step] = TaskList:create()
    end
    self.tasks[step].push_back(task)
  end,
  update = function(self)
    local task = self.tasks[self.current]
    self.tasks[self.current] = nil
    if task ~= nil then
      for i=1,task.size do
        task.vec[i]:run()
      end
      task:recycle()
    end
  end,
  forward = function(self)
    self.current = self.current + 1
  end,
  abort = function(self)
    for _,task in pairs(self.tasks) do
      for i=1,task.size do
        task.vec[i]:abort()
      end
      task:recycle()
    end
    self.tasks = {}
  end,
})

return M
