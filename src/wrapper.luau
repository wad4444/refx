local baseEffect = require(script.Parent.baseEffect)
local runService = game:GetService("RunService")

local createProxy = require(script.Parent.createProxy)
local logger = require(script.Parent.utilities.logger)
local entries = require(script.Parent.client.entries)
local effectsMap = require(script.Parent.effectsMap)
local wrapper = {}

function wrapper.VisualEffectDecorator(ctor)
	ctor.new = function(...)
		logger.assert(runService:IsServer(), `Cannot get effect proxy on server.`)
		return createProxy(tostring(ctor), ...)
	end

	ctor.locally = function(...)
		logger.assert(runService:IsClient(), `Cannot cast effect locally on server.`)
		local self = setmetatable({}, ctor)
		self:constructor(...)

		entries.processLocalEntry(self)
	end

	ctor._withId = function(args, id)
		logger.assert(runService:IsClient(), `Cannot cast effect locally on server.`)
		local self = setmetatable({}, ctor)
		self:constructor(args)

		entries.processReplicatedEntry(self, id)
	end

	effectsMap.add(ctor)

	return ctor
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