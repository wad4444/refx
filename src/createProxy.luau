local uniqueId = 0
local remotes = require(script.Parent.remotes)
local logger = require(script.Parent.utilities.logger)

local baseEffect = require(script.Parent.baseEffect)

return function(ctorName: string, ...)
	local params = { ... }
	local id = uniqueId
	uniqueId += 1

	local proxy = newproxy(true)
	local mt = getmetatable(proxy)

	local initialized = false
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
	}

	function mt.__tostring()
		return id
	end

	function mt.__index(_self, index)
		if reservedFunctions[index] then
			return reservedFunctions[index]
		end
	end

	return proxy :: baseEffect.Proxy
end
