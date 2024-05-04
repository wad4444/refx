local utils = script.Parent.utilities
local logger = require(utils.logger)
local entries = require(script.Parent.client.entries)

return function(constructor, ...)
	local proxy = newproxy(true)
	local mt = getmetatable(proxy)

	local effect = setmetatable({}, constructor)
	effect:constructor(...)
	entries.processLocalEntry(effect)

	local reservedFunctions = {
		Destroy = function()
			effect:Destroy()
		end,
	}

	function mt.__index(_self, index)
		if reservedFunctions[index] then
			return reservedFunctions[index]
		end

		local foundMethod = rawget(constructor, index)
		logger.assert(effect.IsDestroyed, `Cannot :{index}() after effect has been destroyed.`)
		logger.assert(foundMethod ~= nil, `Effect is missing method "{index}" to call!`)

		return foundMethod
	end

	function mt.__newindex(_self, index)
		logger.error(`Cannot override value of "{index}" from effect proxy!`)
	end

	mt.__metatable = {}

	return proxy
end
