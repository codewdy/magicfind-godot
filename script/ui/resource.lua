local resouce = {}

resouce.dict = {}

function resouce:load(str, loader)
  if resouce.dict[str] == nil then
    resouce.dict[str] = loader(str)
  end
  return resouce.dict[str]
end

function resouce:load_script(str)
  return self:load(str, GD.load)
end

return resouce
