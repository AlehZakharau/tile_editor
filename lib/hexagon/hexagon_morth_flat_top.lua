generic = require("lib/hexagon/hexagon_generic.lua")

local M = {}

function M.flat_hex_to_pixel(q, r)
	local x = generic.size * (3/2 * q)
	local y = generic.size * (math.sqrt(3)/2 * q  +  math.sqrt(3) * r)
	return vmath.vector3(x, y, 0)
end

function M.pixel_to_flat_hex(point)
	local q = ( 2./3 * point.x) / generic.size
	local r = (-1./3 * point.x  +  math.sqrt(3)/3 * point.y) / generic.size
	return generic.cube_round(q, r)
end

return M