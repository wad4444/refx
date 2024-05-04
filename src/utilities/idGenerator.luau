return function(increment: number?)
	increment = increment or 1

	local id = 0
	return function()
		id += increment
		return id
	end
end
