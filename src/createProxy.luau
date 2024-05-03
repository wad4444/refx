local utils = script.Parent.utilities

local remotes = require(script.Parent.remotes)
local logger = require(utils.logger)
local createIdGenerator = require(utils.idGenerator)

local map = require(script.Parent.effectsMap)

local baseEffect = require(script.Parent.baseEffect)
local nextId = createIdGenerator()

return function<T...>(ctorName: string, ...: T...)
	local params = table.pack(...)
	local id = nextId()

	local proxy = newproxy(true)
	local mt = getmetatable(proxy)

	local constructor = map.get(ctorName) :: baseEffect.EffectConstructor<T...>
	logger.assert(constructor == nil, `Cannot constructor Proxy for invalid effect.`)

	local initialized = false
	local destroyed = false
	local players: { Player } = {}

	local reservedFunctions = {
		Start = function(plrs)
			logger.assert(not initialized, "Cannot :Start() effect twice.")

			players = plrs
			initialized = true

			remotes.__refx_create:firePlayers(players, ctorName, id, params)
		end,
		GetPlayers = function()
			logger.assert(initialized, "Cannot :GetPlayers()")
			return players
		end,
		Destroy = function() end,
	}

	function mt.__tostring()
		return id
	end

	local cachedSenders: { [string]: <T...>(T...) -> () } = {}

	function mt.__index(_self, index)
		if reservedFunctions[index] then
			return reservedFunctions[index]
		end

		logger.assert(not initialized, `Cannot :{index}() before effect has started.`)
		logger.assert(not destroyed, `Cannot :{index}() after effect has been destroyed.`)
		logger.assert(rawget(constructor, index) ~= nil, `Effect is missing method {index} to call!`)

		if not cachedSenders[index] then
			cachedSenders[index] = function(...)
				local callArgs = { ... }
				remotes.__refx_communicator_rel:firePlayers(players, id, index, callArgs)
			end
		end

		return cachedSenders[index]
	end

	function mt.__newindex(_self, index)
		logger.error(`Cannot override value of {index} from effect proxy!`)
	end

	return proxy :: baseEffect.Proxy<T...>
end
