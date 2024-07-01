local utils = script.Parent.utilities

local remotes = require(script.Parent.remotes)
local logger = require(utils.logger)
local createIdGenerator = require(utils.idGenerator)
local configuration = require(script.Parent.configuration)

local map = require(script.Parent.effectsMap)
local nextId = createIdGenerator()

local t = require(script.Parent.modules.t)

return function(ctorName, ...)
	local params = { ... }
	params[0] = "__REFX_HOLD"

	local id = nextId()

	local proxy = newproxy(true)
	local mt = getmetatable(proxy)

	local constructor = map.get(ctorName)
	logger.assert(constructor ~= nil, `Cannot constructor Proxy for invalid effect.`)

	local initialized = false
	local destroyed = false
	local players: { Player } = {}

	local function omitSelf(...)
		local args = { ... }
		return table.unpack(args, args[1] == proxy and 2 or 1)
	end

	local reservedFunctions = {
		Start = function(...)
			local plrs = omitSelf(...)
			logger.assert(t.array(t.instance("Player"))(plrs), "Provide a valid array of players to :Start().")
			logger.assert(not initialized, "Cannot :Start() effect twice.")

			players = plrs
			initialized = true

			remotes.__refx_create:firePlayers(players, ctorName, id, params)
			return proxy
		end,
		GetPlayers = function()
			logger.assert(initialized, "Cannot :GetPlayers() before effect has initialized.")
			return players
		end,
		Destroy = function()
			logger.assert(not destroyed, "Cannot :Destroy() an effect proxy twice.")

			destroyed = true
			remotes.__refx_destroy:firePlayers(players, id)
			return proxy
		end,
	}

	local cachedSenders = {}
	function mt.__index(_self, index)
		if reservedFunctions[index] then
			return reservedFunctions[index]
		end

		local foundMethod = constructor[index]
		logger.assert(initialized, `Cannot :{index}() before effect has started.`)
		logger.assert(not destroyed, `Cannot :{index}() after effect has been destroyed.`)
		logger.assert(foundMethod ~= nil, `Effect is missing method "{index}" to call!`)

		if not cachedSenders[index] then
			cachedSenders[index] = function(...)
				local callArgs = { omitSelf(...) }
				callArgs[0] = "__REFX_HOLD" -- If we assign index 0 then Roblox will treat this table as a map and arguments that come after 0 don't disappear.

				local config = configuration.GetConfig(foundMethod)
				if config.Unreliable == true then
					remotes.__refx_communicator_urel:firePlayers(players, id, index, callArgs)
					return
				end
				remotes.__refx_communicator_rel:firePlayers(players, id, index, callArgs)
			end
		end

		return cachedSenders[index]
	end

	function mt.__newindex(_self, index)
		logger.error(`Cannot override value of "{index}" from effect proxy!`)
	end

	function mt.__tostring()
		return ctorName
	end

	mt.__metatable = {}

	return proxy
end
