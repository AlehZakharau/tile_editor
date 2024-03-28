local console = require("defcon.console")

local M = {}

tiles = nil

function M.add_view_tests(tiles_map)
   tiles = tiles_map 
   console.register_command("show_tiles", "Show Tiles", 
   function () 
      pprint(tiles)
      return "tiles showed"
   end)
end

return M