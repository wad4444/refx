local exports = require(script.exports)
table.freeze(exports)

export type ServerProxy<K, V, T...> = {
	Start: (ServerProxy<K, V, T...>, { Player }) -> ServerProxy<K, V, T...>,
	GetPlayers: (ServerProxy<K, V, T...>) -> { Player },
	Destroy: (ServerProxy<K, V, T...>) -> ServerProxy<K, V, T...>,
} & K & Effect<K, V, T...>

export type ClientProxy<K, V, T...> = {
	Destroy: (ClientProxy<K, V, T...>) -> ClientProxy<K, V, T...>,
} & K & Effect<K, V, T...>

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
	OnConstruct: (Effect<K, V, T...>, T...) -> (),
	OnDestroy: (Effect<K, V, T...>) -> (),
	new: (T...) -> ServerProxy<K, V, T...>,
	locally: (T...) -> ClientProxy<K, V, T...>,
} & K

export type Effect<K, V, T...> = typeof(setmetatable({} :: EffectFields, {} :: EffectImpl<K, V, T...>)) & V

export type FunctionAttributes = {
	Unreliable: boolean,
}

type refX = {
	CreateEffect: (string) -> EffectImpl<unknown, unknown, ...unknown>,
	Configure: ((...any) -> any, FunctionAttributes) -> (),
	Start: () -> (),
	Register: (Instance) -> (),
}

return exports :: refX
