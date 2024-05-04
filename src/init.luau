local exports = require(script.exports)
table.freeze(exports)

export type ServerProxy<K> = {
	Start: (ServerProxy<K>?, { Player }) -> ServerProxy<K>,
	GetPlayers: (ServerProxy<K>?) -> { Player },
	Destroy: (ServerProxy<K>?) -> nil,
} & K & any

export type ClientProxy<K> = {
	Destroy: (ClientProxy<K>?) -> nil,
} & K & any

export type FunctionAttributes = {
	Unreliable: boolean,
}

export type EffectFields = {
	IsDestroyed: boolean,
	DestroyOnEnd: boolean,
	DestroyOnLifecycleEnd: boolean,
	MaxLifetime: number,
	DisableLeakWarning: boolean,
	Configuration: { unknown },
}

export type EffectImpl<K, V, T...> = {
	__index: EffectImpl<K, V, T...>,
	OnStart: (Effect<K, V, T...>, T...) -> (),
	OnConstruct: (Effect<K, V, T...>) -> (),
	new: (T...) -> ServerProxy<K>,
	locally: (T...) -> ClientProxy<K>,
} & K

export type Effect<K, V, T...> = typeof(setmetatable({} :: EffectFields, {} :: EffectImpl<K, V, T...>)) & V

type refX = {
	CreateEffect: (string) -> EffectImpl<any, any, ...any>,
	Configure: ((...any) -> any, FunctionAttributes) -> (),
	Start: () -> (),
	Register: (Instance) -> (),
}

return exports :: refX
