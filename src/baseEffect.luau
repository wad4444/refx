local BaseEffect = setmetatable({}, {
	__tostring = function()
		return "BaseEffect"
	end,
})
BaseEffect.__index = BaseEffect

export type Proxy = {
	Start: (proxy: Proxy, players: { Player }) -> (),
	GetPlayers: (proxy: Proxy) -> { Player },
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

export type Effect<T...> = typeof(setmetatable({} :: BaseEffectObject, {} :: EffectConstructor<T...>)) & Proxy
export type EffectConstructor<T...> = BaseEffectConstructor<T...> & { new: (T...) -> Effect<T...> }

function BaseEffect:constructor(...): BaseEffect<...unknown>
	self.Configuration = { ... }
	return self :: never
end

function BaseEffect:OnStart() end

return BaseEffect
