local table_utility = require("lib/table_utility/table_utility")
local hex = require("lib/hexagon/hexagon")
local messanger = require("lib/messanger/messanger")
local hash_table = require("main/hash_table")

local M = {}

M.maps = { ["defalt"] = { ["level_1"] = {} } }
M.current_profile = "defalt"
M.current_map = "level_1"

----------------------------------------
-- -- -- -- DEFALT -- -- -- --
----------------------------------------

local function add_defalt_level()
   M.maps[M.current_profile] =  { ["level_1"] = { } }
   M.current_map = "level_1"
   messanger.push_notification(hash_table.map_updated)
end

local function add_defalt_profile()
   M.maps["defalt"] = { ["level_1"] = {} } 
   M.current_profile = "defalt"
   M.current_map = "level_1"
   messanger.push_notification(hash_table.map_updated)
   messanger.push_notification(hash_table.profile_updated)
end

----------------------------------------
-- -- -- -- PROFILE -- -- -- --
----------------------------------------

function M.init()
   add_defalt_profile()
end

function M.add_profile(profile_name)
   M.maps[profile_name] = { ["level_1"] = {} }
   M.current_profile = profile_name
   M.current_map = "level_1"
   messanger.push_notification(hash_table.profile_updated)
   messanger.push_notification(hash_table.map_updated)
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
         M.open_profile(profiles[1])
      end
   end
end

function M.rename_profile(profile_name, new_name)
   if M.current_profile == profile_name then
      M.current_profile = new_name
   end
   M.maps[new_name] = M.maps[profile_name]
   M.remove_profile(profile_name)
   messanger.push_notification(hash_table.profile_updated)
end

function M.open_profile(profile_name)
   M.current_profile = profile_name
   messanger.push_notification(hash_table.profile_updated)
   map = M.get_first_map(profile_name)
   M.open_map(map)
end

function M.get_profiles()
   return M.maps
end

----------------------------------------
-- -- -- --'MAPS'-- -- -- --
----------------------------------------

function M.get_maps(profile_name)
   return M.maps[profile_name]
end

function M.get_first_map(profile_name)
   for k, v in pairs(M.maps[profile_name]) do
      return k
   end
end

function M.add_map(map_name)
   M.maps[M.current_profile][map_name] = {map_name = map_name}
   M.current_map = map_name
   messanger.push_notification(hash_table.map_updated)
end

function M.remove_map(map_name)
   if M.maps[M.current_profile][map_name] ~= nil then
      M.maps[M.current_profile][map_name] = nil
   end
   if M.current_map == map_name then
      local maps = M.get_maps(M.current_profile)
      if #maps == 0 then 
         add_defalt_level()
      else
         M.current_map = maps[1]
         messanger.push_notification(hash_table.map_updated)
      end
   end
end

function M.rename_map(map_name, new_name)
   if M.current_map == map_name then
      M.current_map = new_name
   end
   M.maps[M.current_profile][new_name] = M.maps[M.current_profile][map_name]
   M.remove_map(map_name)
   messanger.push_notification(hash_table.map_updated)
end

function M.open_map(map_name)
   M.current_map = map_name
   messanger.push_notification(hash_table.map_updated)
end

function M.print_maps()
   print("Current profile: " .. M.current_profile .. "::: Current map:" .. M.current_map)
   pprint(M.maps)
end

return M