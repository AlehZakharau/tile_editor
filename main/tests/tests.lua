local console = require("defcon.console")
local maps = require("main/code/maps")
local data_io = require("main/code/data_io")

local M = {}

function M.add_main_commands()
   console.register_command("show_map", "Show Map", 
   function () 
      maps.print_maps()
      return "map showed"
   end)
   console.register_command("add_profile", "Add profile", 
   function (argm)
      maps.add_profile(argm[1])
      return "Profile added"
   end)
   console.register_command("remove_profile", "Remove profile", 
   function (argm)
      maps.remove_profile(argm[1])
      return "Profile removed"
   end)
   console.register_command("add_map", "Add map", 
   function (argm)
      maps.add_map(argm[1])
      return "Map added"
   end)
   console.register_command("remove_map", "Remove map", 
   function (argm)
      maps.remove_map(argm[1])
      return "Map removed"
   end)
   console.register_command("rename_map", "Rename map", 
   function (argm)
      maps.rename_map(argm[1], argm[2])
      return "Map renamed"
   end)
   console.register_command("rename_profile", "Rename profile", 
   function (argm)
      maps.rename_profile(argm[1], argm[2])
      return "Profile renamed"
   end)
   console.register_command("open_profile", "Open profile", 
   function (argm)
      maps.open_profile(argm[1])
      return "Profile opened"
   end)
   console.register_command("open_map", "Open map", 
   function (argm)
      maps.open_map(argm[1])
      return "Map opened"
   end)
   console.register_command("add_tile", "Add tile", 
   function (argm)
      maps.add_tile(tonumber(argm[1]), tonumber(argm[2]))
      return "Tile added"
   end)
   console.register_command("remove_tile", "Remove tile", 
   function (argm)
      maps.remove_tile(tonumber(argm[1]), tonumber(argm[2]))
      return "Tile removed"
   end)
   console.register_command("save", "Save", 
   function (argm)
      data_io.save_maps()
      return "Saved"
   end)
   console.register_command("load", "Load", 
   function (argm)
      data_io.load_maps()
      return "Loaded"
   end)
end

return M