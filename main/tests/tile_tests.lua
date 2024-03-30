local console = require("defcon.console")
local hex = require("lib/hexagon/hexagon")

local M = {}

function M.add_tile_commands()
	console.register_command("update_tile_size", "w", 
	function (argm) 
		hex.change_size(argm[1])
		return
	end)
	console.register_command("update_tile_orintation", "w",
	function (argm)
		hex.change_orintation(argm[1])
		return ""
	end)
end

return M