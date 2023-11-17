local M = {}

M.menu = "/menu#menu"
M.map_view = "/main#map_view"

----------------------------------------
-- -- -- --'EVENTS'-- -- -- --
----------------------------------------
M.tile_spawned = hash("tile_spawned")
M.map_updated = hash("map_updated")
M.profile_updated = hash("profile_updated")
M.tile_added = hash("tile_added")
M.tile_removed = hash("tile_removed")

return M