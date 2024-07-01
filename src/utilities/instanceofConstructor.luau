return function(constructor, constructor2)
	local currentClass = constructor
	local metatable = getmetatable(currentClass)
	while true do
		if currentClass == constructor2 then
			return true
		end
		if not currentClass or not metatable then
			break
		end
		currentClass = metatable.__index
		metatable = getmetatable(currentClass)
	end
	return false
end
