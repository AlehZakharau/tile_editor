local M = {}

M.cursor_position = vmath.vector3()
M.pressed_cursor_position = vmath.vector3()
M.released_cursor_position = vmath.vector3()
M.cursor_world_position = vmath.vector3() -- dependce on orthgraphic camera package

M.touch = {}
M.hold = {}
M.double_touch = {}
M.touch_status = false

function M.double_touch.press()
   for k, v in ipairs(M.double_touch) do v() end
end

function M.touch.press()
   M.touch_status = true
   for k, v in ipairs(M.touch) do v() end
end

function M.hold.press()
   for k, v in ipairs(M.hold) do v() end
end

function M.touch.release()
   M.touch_status = false
end

return M