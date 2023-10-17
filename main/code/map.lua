local table_utility = require("libraries/table_utility/table_utility")

local M = {}

--- [index] = {q, r}
M.current_map = {}

--- [q] = {[r] = map[i]}
M.current_coord_map = {}

--- [profiles] = map 
local maps = {}

--- level { [n] { q, r } }
local map = {}
   
function M.save_current_map(level) -- level
   local index = 0
   map[level] = {}
   for i = 1, #M.current_map, 1 do
      table.insert(map[level], M.current_map[i])
   end
end

function M.clear_current_map()
   M.current_map = {}
   M.current_coord_map = {}
end

function M.load_map(level)
   return map[level]
end

function M.get_levels_amount()
   return #map or 1
end

function M.save_profile() --(profile)
   local map_json = json.encode(map)
   local file = io.open("map.json", "w")
   if file ~= nil then
      file.write(file, map_json)
      file.close(file)
   end
end

function M.add_tile(q, r, tile_hash)
   if M.current_coord_map[q] == nil then M.current_coord_map[q] = {} end
   table.insert(M.current_map, {q, r})
   M.current_coord_map[q][r] = {tile_hash, #M.current_map}
end

function M.get_tile_hash(q, r)
   return M.current_coord_map[q][r][1]
end

function M.remove_tile(q, r)
   local tile_id = M.current_coord_map[q][r][2]
   table_utility.remove_element(M.current_map, tile_id)
   M.current_coord_map[q][r] = 0
end

function M.has_tile(q, r)
   if M.current_coord_map[q] ~= nil then
      if M.current_coord_map[q][r] ~= nil and M.current_coord_map[q][r] ~= 0 then return true end
   end
   return false
end


return M