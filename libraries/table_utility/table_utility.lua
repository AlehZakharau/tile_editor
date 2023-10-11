local M = {}

function M.remove_element(collection, index)
  collection[index] = collection[#collection]
  table.remove(collection, #collection)
end


return M