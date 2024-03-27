local M = {}

M.size = 10

function M.flat_hex_to_pixel(q, r)
	local x = M.size * (3/2 * q)
	local y = M.size * (math.sqrt(3)/2 * q  +  math.sqrt(3) * r)
	return vmath.vector3(x, y, 0)
end

return M