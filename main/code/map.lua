local table_utility = require("libraries/table_utility/table_utility")
local hex = require("libraries/hexagon/hexagon")

local M = {}

--- [index] = {q, r}
M.current_map = {}

--- [q] = {[r] = {tile_hash, map[i]}}
M.current_coord_map = {}

M.current_level = 1

--- [profiles] = map 
local maps = {}

--- level { [n] { q, r } }
local map = {}

local factory_tile = "/factory_tile#tile"

local function draw_tile_sprite(spawn_position)
   return factory.create(factory_tile, spawn_position)
end

local function remove_tile_sprite(tile_hash)
   go.delete(tile_hash)
end

----------------------------------------
-- -- -- --'MAPS'-- -- -- --
----------------------------------------
local function clear_current_map()
   for k, v in pairs(M.current_coord_map) do
      for n, m in pairs(v) do 
         if m ~= 0 then 
            remove_tile_sprite(m[1])
         end
      end
   end
   M.current_map = {}
   M.current_coord_map = {}
end  

local function load_map(level)
   return map[level] or {}
end

function M.save_current_map(level) -- level
   local index = 0
   map[level] = {}
   for i = 1, #M.current_map, 1 do
      table.insert(map[level], M.current_map[i])
   end
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



----------------------------------------
-- -- -- --'TILE'-- -- -- --
----------------------------------------

function M.add_tile(q, r)
   if M.current_coord_map[q] == nil then M.current_coord_map[q] = {} end
   local tile_hash = draw_tile_sprite(hex.flat_hex_to_pixel(q, r))
   table.insert(M.current_map, {q, r})
   M.current_coord_map[q][r] = {tile_hash, #M.current_map}
end

local function get_tile_hash(q, r)
   return M.current_coord_map[q][r][1]
end

function M.remove_tile(q, r)
   local tile_hash = get_tile_hash(q, r)
   remove_tile_sprite(tile_hash)
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

----------------------------------------
-- -- -- --'DRAW MAP'-- -- -- --
----------------------------------------

function M.draw_map(level)
   M.save_current_map(M.current_level)
   M.current_level = level
   clear_current_map()
   timer.delay(0.2, false, function ()
      print(map)
      local new_map = load_map(level)
      for i = 1, #new_map do 
         local q, r = new_map[i][1], new_map[i][2]
         M.add_tile(q, r)
      end   
   end)
end


return M