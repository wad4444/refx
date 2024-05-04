local logger = require(script.Parent.utilities.logger)

local map = {}
local effectsMap = {}

function effectsMap.get(name)
	return map[name]
end

function effectsMap.add(effect)
	local name = tostring(effect)
	logger.assert(map[name] == nil, `Double registration detected for effect {name}`)
end

table.freeze(effectsMap)

return effectsMap
