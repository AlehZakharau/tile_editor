input_model = require("lib/mobile_input/input_model")

local M = {}

--- Subscribe for double touch event
--- @param callback function - callback function
function M.double_touch_subscribe(callback)
   table.insert(input_model.double_touch, callback)
end

--- Subscribe for touch event
--- @param callback function - callback function
function M.touch_subscribe(callback)
   table.insert(input_model.touch, callback)
end

--- Subscribe for hold event
--- @param callback function - callback function
function M.hold_subscribe(callback)
   table.insert(input_model.hold, callback)
end

--- Get touch status pressed or released main button
--- @return bool pressed status
function M.get_touch_status()
   return input_model.touch_status
end

function M.get_cursor_position()
   return input_model.cursor_position
end

function M.get_cursor_world_position()
   return input_model.cursor_world_position
end


return M