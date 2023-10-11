local M = {}

function M.clamp(value, min_value, max_value)
    if value >= max_value then value = max_value
    elseif value <= min_value then value = min_value end
    return value
end


function M.round(n, multi)
	multi = multi or 1
	return math.floor((n + multi * 0.5)/ multi) * multi
end


function M.get_sign(value)
	if value > 0 then
		return 1
	elseif value < 0 then
		return -1
	else
		return 0
	end
end

return M