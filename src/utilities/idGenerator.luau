return function()
	local id = 0
	return function()
		id += 1
		return id
	end
end
