local table_utility = require("lib/table_utility/table_utility")
local hex = require("lib/hexagon/hexagon")
local messanger = require("lib/messanger/messanger")
local hash_table = require("main/hash_table")

local M = {}

M.maps = { ["defalt"] = { ["level_1"] = {} } }
M.current_profile = "defalt"
M.current_map = "level_1"
M.tile_count = 0

----------------------------------------
-- -- -- -- DEFALT -- -- -- --
----------------------------------------

local function add_defalt_level()
   M.maps[M.current_profile] =  { ["level_1"] = { } }
   M.current_map = "level_1"
   M.tile_count = 0
   messanger.push_notification(hash_table.map_updated, {name = "level_1"})
end

local function add_defalt_profile()
   M.maps["defalt"] = { ["level_1"] = {} } 
   M.current_profile = "defalt"
   M.current_map = "level_1"
   M.tile_count = 0
   messanger.push_notification(hash_table.map_updated, {name = "level_1"})
   messanger.push_notification(hash_table.profile_updated, {name = "defalt"})
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
   M.tile_count = 0
   messanger.push_notification(hash_table.profile_updated, {name = profile_name})
   messanger.push_notification(hash_table.map_updated, {name = "level_1"})
end

function M.remove_profile(profile_name)
   if M.maps[profile_name] ~= nil then
      M.maps[profile_name] = nil
   end
   if M.current_profile == profile_name then
      local profiles_amount = M.get_profiles_amount()
      if profiles_amount == 0 then
         add_defalt_profile()
      else
         M.open_profile(M.get_any_profile())
      end
   end
   messanger.push_notification(hash_table.profile_updated, {name = M.current_profile})
end

function M.rename_profile(profile_name, new_name)
   if M.current_profile == profile_name then
      M.current_profile = new_name
   end
   M.maps[new_name] = M.maps[profile_name]
   M.remove_profile(profile_name)
   messanger.push_notification(hash_table.profile_updated, {name = profile_name})
end

function M.open_profile(profile_name)
   M.current_profile = profile_name
   messanger.push_notification(hash_table.profile_updated, {name = profile_name})
   map = M.get_first_map(profile_name)
   M.open_map(map)
end

function M.get_profiles()
   return M.maps
end

function M.get_any_profile()
   for k, v in pairs(M.maps) do
      return k
   end
end

function M.get_profiles_amount()
   local profile_amount = 0
   for k, v in pairs(M.maps) do
      profile_amount = profile_amount + 1
   end
   return profile_amount
end

function M.has_profile(new_profile_name)
   if M.maps[new_profile_name] ~= nil then return true else return false end
end

function M.clear_all()
   M.maps = {}
   add_defalt_profile()
end

----------------------------------------
-- -- -- --'MAPS'-- -- -- --
----------------------------------------

function M.get_maps(profile_name)
   return M.maps[profile_name]
end

function M.get_current_map()
   return M.maps[M.current_profile][M.current_map]
end

function M.get_maps_amount()
   local maps_amount = 0
   for k, v in pairs(M.maps[M.current_profile]) do
      maps_amount = maps_amount + 1
   end
   return maps_amount
end

function M.get_first_map(profile_name)
   for k, v in pairs(M.maps[profile_name]) do
      return k
   end
end

function M.add_map(map_name)
   M.maps[M.current_profile][map_name] = {}
   M.current_map = map_name
   M.tile_count = 0
   messanger.push_notification(hash_table.map_updated, {name = map_name})
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
      end
   end
   messanger.push_notification(hash_table.map_updated, {name = M.current_map})
end

function M.rename_map(map_name, new_name)
   if M.current_map == map_name then
      M.current_map = new_name
   end
   M.maps[M.current_profile][new_name] = M.maps[M.current_profile][map_name]
   M.remove_map(map_name)
   messanger.push_notification(hash_table.map_updated, {name = map_name})
end

function M.open_map(map_name)
   M.current_map = map_name
   M.tile_count = 0
   messanger.push_notification(hash_table.map_updated, {name = map_name})
end

----------------------------------------
-- -- -- --'TILES'-- -- -- --
----------------------------------------

function M.add_tile(q, r, ignore)
   if M.maps[M.current_profile][M.current_map][q] == nil then
      M.maps[M.current_profile][M.current_map][q] = {} 
   end
   M.maps[M.current_profile][M.current_map][q][r] = {q = q, r = r}
   M.tile_count = M.tile_count + 1
   if ignore then print("add with notification") 
   else
      messanger.push_notification(hash_table.tile_added, {q = q, r = r})
   end
end

function M.add_tile_data(q, r, tile_hash, position)
   if M.has_tile(q, r) then
      M.maps[M.current_profile][M.current_map][q][r].tile_hash = tile_hash
      M.maps[M.current_profile][M.current_map][q][r].position = position
   end
end

function M.remove_tile(q, r)
   if M.has_tile(q, r) then
      local tile_hash = M.maps[M.current_profile][M.current_map][q][r].tile_hash
      M.maps[M.current_profile][M.current_map][q][r] = nil
      if(table_utility.table_length(M.maps[M.current_profile][M.current_map][q]) == 0) then
         M.maps[M.current_profile][M.current_map][q] = nil
      end
      M.tile_count = M.tile_count - 1
      messanger.push_notification(hash_table.tile_removed, {q = q, r = r, tile_hash = tile_hash})
   end
end

function M.has_tile(q, r)
   if M.maps[M.current_profile][M.current_map][q] ~= nil then
      if M.maps[M.current_profile][M.current_map][q][r] ~= nil then 
         return true 
      end
   end
   return false
end

function M.print_maps()
   print("Current profile: " .. M.current_profile .. "::: Current map:" .. M.current_map)
   print("Tile_count: " .. M.tile_count)
   pprint(M.maps)
end

return M