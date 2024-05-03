local BaseEffect = setmetatable({}, {
	__tostring = function()
		return "BaseEffect"
	end,
})
BaseEffect.__index = BaseEffect

local logger = require(script.Parent.utilities.logger)

export type Proxy<T...> = {
	__index: EffectConstructor<T...>,
	Start: (proxy: Proxy<T...>, players: { Player }) -> (),
	GetPlayers: (proxy: Proxy<T...>) -> { Player },
}

export type BaseEffectConstructor<T...> = {
	__index: BaseEffectConstructor<T...>,
	OnStart: (BaseEffect<T...>) -> (),
	constructor: (BaseEffect<T...>, T...) -> (),
}

export type BaseEffectObject = {
	Configuration: { unknown },
}

export type BaseEffect<T...> = typeof(setmetatable({} :: BaseEffectObject, {} :: BaseEffectConstructor<T...>))

export type Effect<T...> = typeof(setmetatable({} :: BaseEffectObject, {} :: EffectConstructor<T...>)) | Proxy<T...>
export type EffectConstructor<T...> = BaseEffectConstructor<T...> & { new: (T...) -> Effect<T...> }

function BaseEffect:constructor(...)
	self.Configuration = { ... }
end

function BaseEffect:OnStart() end

local restrictedNames = { "Start", "GetPlayers" }
for _, v in restrictedNames do
	BaseEffect[v] = function()
		logger.error(`Cannot use :{v}() on client.`)
	end
end

table.freeze(BaseEffect)

return BaseEffect
