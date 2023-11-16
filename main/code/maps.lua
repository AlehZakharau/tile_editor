local table_utility = require("lib/table_utility/table_utility")
local hex = require("lib/hexagon/hexagon")
local messanger = require("lib/messanger/messanger")
local hash_table = require("main/hash_table")

local M = {}

M.maps = { ["defalt"] = { ["level_1"] = {} } }
M.current_profile = "defalt"

local function add_defalt_profile()
   M.maps["defalt"] = { ["level_1"] = {} } 
   M.current_profile = "defalt"
end

function M.init()
   add_defalt_profile()
end

function M.add_profile(profile_name)
   M.maps[profile_name] = { ["level_1"] = {} }
   M.current_profile = profile_name
end

function M.remove_profile(profile_name)
   if M.maps[profile_name] ~= nil then
      M.maps[profile_name] = nil
   end
   if M.current_profile == profile_name then
      local profiles = M.get_profiles()
      if #profiles == 0 then
         add_defalt_profile()
      else
         M.current_profile = profiles[1]
      end
   end
end

function M.get_profiles()
   return M.maps
end

function M.get_maps(profile_name)
   return M.maps[profile_name]
end

function M.add_map(map_name)
   M.maps[M.current_profile][map_name] = {}
end

function M.remove_map(map_name)
   if M.maps[M.current_profile][map_name] ~= nil then
      M.maps[M.current_profile][map_name] = nil
   end
end

function M.print_maps()
   print("Current profile: " .. M.current_profile)
   pprint(M.maps)
end

return M