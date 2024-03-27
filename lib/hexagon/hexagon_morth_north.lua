local M = {}

M.size = 10

function M.flat_hex_to_pixel(q, r)
	local x = M.size * (math.sqrt(3)/2 * q  +  math.sqrt(3) * r)
	local y = M.size * (3/2 * q)
	return vmath.vector3(x, y, 0)
end

return M