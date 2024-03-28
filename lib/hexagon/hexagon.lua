local mathf = require("lib.mathf.mathf")
local top_pointy = require("lib.hexagon.hexagon_morth_pointy_top")
local top_flat = require("lib.hexagon.hexagon_morth_flat_top")
local generic = require("lib.hexagon.hexagon_generic")

local M = {}

-- coordinate q,r,s is equvalent of the x,y,z.

local morph = top_pointy

----------------------------------------
-- -- -- --'HEXAGON GRID PARAMETERS'-- -- -- --
----------------------------------------
local function switch_orintation(value)
   if generic.orintation then
      morph = top_pointy
   else
      morph = top_flat
   end
end

---@function init hexagon library
---@param size number size of the hexagon
---@param value bool orintation of the hexagon
--- true = pointy top hexagons
--- false = flat top hexagons
function M.init(size, value)
   generic.size = size
   generic.orintation = value
   switch_orintation(value)
end

function M.change_size(size)
   generic.size = size
end

function M.change_orintation(value)
   generic.orintation = value
   switch_orintation(value)
end

----------------------------------------
-- -- -- --'MORPH'-- -- -- --
----------------------------------------


function M.flat_hex_to_pixel(q, r)
   return morph.flat_hex_to_pixel(q, r)
end

function M.pixel_to_flat_hex(point)
   return morph.pixel_to_flat_hex(point)
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
  local start_s = generic.find_s_coord(start_q, start_r)
  local end_s = generic.find_s_coord(end_q, end_r)
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