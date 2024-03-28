generic = require("lib.hexagon.hexagon_generic")

M.size = 10

function M.flat_hex_to_pixel(q, r)
	local x = generic.size * (math.sqrt(3)/2 * q  +  math.sqrt(3) * r)
	local y = generic.size * (3/2 * q)
	return vmath.vector3(x, y, 0)
end

function M.pixel_to_flat_hex(point)
	local q = (-1./3 * point.x  +  math.sqrt(3)/3 * point.y) / generic.size
	local r = ( 2./3 * point.x) / generic.size
	return generic.cube_round(q, r)
end

return M