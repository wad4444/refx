local logger = require(script.Parent.utilities.logger)

type Constructor<T...> = typeof((function()
	local baseEffect = require(script.Parent.baseEffect)
	return ({} :: any) :: baseEffect.EffectConstructor<T...>
end)())

local map: { [string]: Constructor<...unknown> | nil } = {}

local effectsMap = {}

function effectsMap.get(name: string)
	return map[name] :: Constructor<...unknown> | nil
end

function effectsMap.add(effect: Constructor<...unknown>)
	local name = tostring(effect)
	logger.assert(map[name] == nil, `Double registration detected for effect {name}`)
end

table.freeze(effectsMap)

return effectsMap
