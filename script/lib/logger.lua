local M = {}

M.DEBUG = 1
M.INFO = 2
M.WARN = 3
M.ERROR = 4
M.TOKEN_END = 5

M.TOKEN = {
  "DEBUG",
  "INFO ",
  "WARN ",
  "ERROR"
}

M.level = M.TOKEN_END

function M.init_logger(filename, level)
  M.level = level
  M.file = io.open(filename, "w")
  if M.file then
		M.file:setvbuf("line")
    M.file:write("=======================new logger==================\n")
  else
    M.level = M.TOKEN_END
    error("open logger file error.")
  end
end

function M.log(level, value)
  if level >= M.level then
    M.file:write(tostring(value))
    M.file:write("\n")
  end
end

function M.debug(value)
  M.log(M.DEBUG, value)
end

function M.info(value)
  M.log(M.INFO, value)
end

function M.warn(value)
  M.log(M.WARN, value)
end

function M.error(value)
  M.log(M.ERROR, value)
end

return M
