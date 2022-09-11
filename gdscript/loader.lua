local loader = {
  extends = "Node",
}

function loader:path()
  if OS:has_feature("editor") then
    return ProjectSettings:globalize_path("res://build")
  else
    return OS:get_executable_path():get_base_dir()
  end
end

function loader:load()
  package.path = package.path .. ";" .. self:path():plus_file("/script/?.lua")
end

return loader
