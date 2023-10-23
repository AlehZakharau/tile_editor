local input_model = require ("lib/mobile_input/input_model")
local camera_model = require "lib/orthographic.camera"

local M = {}
local main_camera = hash("/camera")

function M.calculate_cursor_world_position(screen)
   input_model.cursor_world_position = camera_model.screen_to_world(main_camera, screen)
end

return M
