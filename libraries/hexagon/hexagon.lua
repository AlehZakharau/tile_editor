local mathf = require("libraries.mathf.mathf")

local M = {}

M.size = 51.2 -- size is half of hexagon's width

local h_step = 3 / 2 * M.size
local v_step = math.sqrt(3) * h_step

local vertical = v_step * 0.5
local horizontal = h_step * 0.25

local function cube_round(pos_q, pos_r)
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

function M.find_s_coord(q, r)
  return-q-r
end

function M.flat_hex_to_pixel(q, r)
	local x = M.size * (3/2 * q)
	local y = M.size * (math.sqrt(3)/2 * q  +  math.sqrt(3) * r)
	return vmath.vector3(x, y, 0)
end

function M.pixel_to_flat_hex(point)
	local q = ( 2./3 * point.x) / M.size
	local r = (-1./3 * point.x  +  math.sqrt(3)/3 * point.y) / M.size
	return cube_round(q, r)
end

function M.get_coord_in_radius(q, r, radius)
	local coord = {}
	local id = 0
	for i = -radius, radius do
		for j = math.max(-radius, -i-radius), math.min(radius, -i+radius) do
			id = id + 1
			coord[id] = {q + i, r + j}
		end
	end
	return coord
end

local function coord_subtract(start_q, start_r, end_q, end_r)
  local start_s = M.find_s_coord(start_q, start_r)
  local end_s = M.find_s_coord(end_q, end_r)
  return start_q - end_q, start_r - end_r, start_s - end_s
end

function M.cube_distance(start_q, start_r, end_q, end_r)
  local q, r, s = coord_subtract(start_q, start_r, end_q, end_r)
  return (math.abs(q) + math.abs(r) + math.abs(s)) * .5
end

function M.distance_between_hexagons(start_q, start_r, end_q, end_r)
   return end_q - start_q, end_r - start_r
 end


return M