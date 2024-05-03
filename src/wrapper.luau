local baseEffect = require(script.Parent.baseEffect)
local runService = game:GetService("RunService")

local createProxy = require(script.Parent.createProxy)
local logger = require(script.Parent.utilities.logger)
local entries = require(script.Parent.client.entries)
local wrapper = {}

function wrapper.VisualEffectDecorator(ctor)
	local updated = ctor

	updated.new = function(...)
		logger.assert(runService:IsServer(), `Cannot get effect proxy on server.`)
		return createProxy(tostring(ctor), ...)
	end

	updated.locally = function(...)
		logger.assert(runService:IsClient(), `Cannot cast effect locally on server.`)
	end

	updated._locallyWithId = function(args, id) end

	return updated
end

function wrapper.CreateEffect<T...>(name)
	local class = setmetatable({}, {
		__tostring = function()
			return name
		end,
		__index = baseEffect,
	})
	class.__index = class

	return wrapper.VisualEffectDecorator(class)
end

table.freeze(wrapper)

return wrapper
