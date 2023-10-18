local M = {}

local cursor_sprite = "/cursor#sprite"
M.free_cursor_mode = true

function M.turn_off_free_mode()
   M.free_cursor_mode = false
   sprite.play_flipbook(cursor_sprite, hash("empty"))
   defos.set_cursor_visible(true)
end

function M.turn_on_free_mode()
   M.free_cursor_mode = true
   sprite.play_flipbook(cursor_sprite, hash("tile_selection"))
   defos.set_cursor_visible(false)
end

return M