local utils = script.Parent.utilities
local logger = require(utils.logger)
local entries = require(script.Parent.client.entries)
local client = require(script.Parent.client)

return function(constructor, ...)
	logger.assert(client.IsInitialized(), `Cannot create an effect locally before client starts.`)

	local proxy = newproxy(true)
	local mt = getmetatable(proxy)

	local effect = setmetatable({}, constructor)
	effect:constructor(...)
	entries.processLocalEntry(effect)

	local reservedFunctions = {
		Destroy = function()
			logger.assert(not effect.IsDestroyed, "Cannot :Destroy() an effect proxy twice.")

			effect:Destroy()
			return proxy
		end,
	}

	function mt.__index(_self, index)
		if reservedFunctions[index] then
			return reservedFunctions[index]
		end

		local foundMethod = constructor[index]
		logger.assert(foundMethod ~= nil, `Effect is missing method "{index}" to call!`)
		logger.assert(effect.IsDestroyed, `Cannot :{index}() after effect has been destroyed.`)

		return foundMethod
	end

	function mt.__newindex(_self, index)
		logger.error(`Cannot override value of "{index}" from effect proxy!`)
	end

	mt.__metatable = {}

	return proxy
end
