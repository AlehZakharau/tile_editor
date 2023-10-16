local M = {}

local current_directory = ""


function M.set_curent_directory(directory)
   current_directory = directory or "?"
   msg.post("/menu#menu", "update_directory", {directory = current_directory})
end

return M