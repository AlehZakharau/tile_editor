local maps = require("main/code/maps")
local table_utility = require("lib/table_utility/table_utility")

local M = {}

M.save_path = "res/map.json"
M.local_map_path = "/res/map.json"
M.export_path = ""
M.export = false


function M.load_profile()
   local test_json_file = sys.load_resource(M.local_map_path)
   if test_json_file ~= nil then 
	   map = json.decode(test_json_file)
      --M.current_map = map[1]
      --M.draw_map(1)
      -- sent map
   end
end

local function conver_map(map)
   local map_data = {}
   for k, v in pairs(map) do
      if(map_data[k] == nil) then map_data[k] = {} end
      for n, m in pairs(v) do
         if map_data[k][n] == nil then map_data[k][n] = {} end
         for t, s in pairs(m) do
            for c, x in pairs(s) do
               table.insert(map_data[k][n], {x.q, x.r})
            end
         end
      end
   end
   return map_data
end

function M.save_maps() -- add save (profile)
   local map = maps.maps
   local map_data = conver_map(map)
   local map_json = json.encode(map_data)
   local file = io.open(M.save_path, "w")
   if file ~= nil then
      file.write(file, map_json)
      file.close(file)
   end
   if M.export then 
   local file_1 = io.open(M.export_path, "w")
      if file_1 ~= nil then  
         file_1.write(file_1, map_json)
         file_1.close(file_1)
      end
   end
end

return M
