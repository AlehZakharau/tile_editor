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

function M.save_profile() --(profile)
   local map_json = json.encode(map)
   local file = io.open("map.json", "w")
   if file ~= nil then
      file.write(file, map_json)
      file.close(file)
   end
end


return M