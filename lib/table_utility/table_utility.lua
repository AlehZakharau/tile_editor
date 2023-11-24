local M = {}

function M.remove_element(collection, index)
  collection[index] = collection[#collection]
  table.remove(collection, #collection)
end

function M.table_length(table)
   local count = 0
   for k, v in pairs(table) do count = count + 1 end
   return count
 end


return M