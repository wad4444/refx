local BaseEffect = setmetatable({}, {
	__tostring = function()
		return "BaseEffect"
	end,
})
BaseEffect.__index = BaseEffect

export type Proxy<T...> = typeof(setmetatable(
	{} :: {
		Start: (proxy: Proxy<T...>, players: { Player }) -> (),
		GetPlayers: (proxy: Proxy<T...>) -> { Player },
	},
	{} :: { __index: EffectConstructor<T...> }
))

export type BaseEffectConstructor<T...> = {
	__index: BaseEffectConstructor<T...>,
	OnStart: (BaseEffect<T...>) -> (),
	constructor: (BaseEffect<T...>, T...) -> BaseEffect<T...>,
}

export type BaseEffectObject = {
	Configuration: { unknown },
	MaxLifetime: number?,
	DisableLeakWarning: boolean,
}

export type BaseEffect<T...> = typeof(setmetatable({} :: BaseEffectObject, {} :: BaseEffectConstructor<T...>))

export type Effect<T...> = typeof(setmetatable({} :: BaseEffectObject, {} :: EffectConstructor<T...>))
export type EffectConstructor<T...> = typeof(setmetatable(
	{} :: { __index: EffectConstructor<T...>, new: (T...) -> Proxy<T...>, locally: (T...) -> Effect<T...> },
	{} :: { __index: BaseEffectConstructor<T...> }
))

function BaseEffect.constructor(self: BaseEffect<...any>, ...)
	self.Configuration = { ... }
	self.DisableLeakWarning = false
	return self
end

function BaseEffect:OnStart() end

table.freeze(BaseEffect)

return (BaseEffect :: any) :: BaseEffectConstructor<...any>
