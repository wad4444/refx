local logger = require(script.Parent.utilities.logger)

type BaseEffect<T...> = typeof((function()
	local baseEffect = require(script.Parent.baseEffect)
	return ({} :: any) :: baseEffect.BaseEffect<T...>
end)())

local map: { [string]: BaseEffect<...any> | nil } = {}

local effectsMap = {}

function effectsMap.get(name: string)
	return map[name]
end

function effectsMap.add(effect: BaseEffect<...any>)
	local name = tostring(effect)
	logger.assert(map[name] == nil, `Double registration detected for effect {name}`)
end

table.freeze(effectsMap)

return effectsMap
