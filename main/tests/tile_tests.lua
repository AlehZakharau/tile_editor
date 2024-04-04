local console = require("defcon.console")
local hex = require("lib/hexagon/hexagon")

local M = {}

local string_to_bool={ ["true"]=true, ["false"]=false }
function M.add_tile_commands()
	console.register_command("update_tile_size", "w", 
	function (argm) 
		hex.change_size(tonumber(argm[1]))
		return
	end)
	console.register_command("update_tile_orintation", "w",
	function (argm)
      local value = string_to_bool[argm[1]]
		hex.change_orintation(value)
		return ""
	end)
end

return M