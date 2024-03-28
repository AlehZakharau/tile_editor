local mathf = require("lib.mathf.mathf")

local M = {}

--- size number: size of hexagons
M.size = 1
--- boolian orintation 
--- true = pointy top hexagons
--- false = flat top hexagons
M.orintation = false

--- @function find third coordinate s
--- @param q number coord
--- @param r number coord
--- that coord required for some calculations
function M.find_s_coord(q, r)
   return-q-r
 end

function M.cube_round(pos_q, pos_r)
	local q = mathf.round(pos_q)
	local r = mathf.round(pos_r)
	local s = M.find_s_coord(q, r)

	local q_diff = math.abs(q - pos_q)
	local r_diff = math.abs(r - pos_r)
	local s_diff = math.abs(s -(-pos_q - pos_r))

	if q_diff > r_diff and q_diff > s_diff then
		q = -r-s
	elseif r_diff > s_diff then
		r = -q-s
	else
		s = -q-r
	end

	return q, r, s
end

return M