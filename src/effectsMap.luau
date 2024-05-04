local logger = require(script.Parent.utilities.logger)

local map = {}
local effectsMap = {}

function effectsMap.get(name)
	return map[name]
end

function effectsMap.add(effect)
	local name = tostring(effect)
	logger.assert(
		map[name] == nil,
		`Double registration detected for effect {name}. Consider choosing a different name.`
	)

	map[name] = effect
end

function effectsMap.getAll()
	local list = {}
	for _, v in map do
		table.insert(list, v)
	end

	return list
end

table.freeze(effectsMap)

return effectsMap
