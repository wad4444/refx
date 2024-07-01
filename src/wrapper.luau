local baseEffect = require(script.Parent.baseEffect)
local runService = game:GetService("RunService")

local createProxy = require(script.Parent.serverProxy)
local createClientProxy = require(script.Parent.clientProxy)

local logger = require(script.Parent.utilities.logger)
local instanceofConstructor = require(script.Parent.utilities.instanceofConstructor)
local entries = require(script.Parent.client.entries)
local effectsMap = require(script.Parent.effectsMap)
local wrapper = {}

function wrapper.VisualEffectDecorator(ctor)
	ctor.new = function(...)
		logger.assert(runService:IsServer(), `Cannot get effect proxy on client.`)
		return createProxy(tostring(ctor), ...)
	end

	ctor.locally = function(...)
		logger.assert(runService:IsClient(), `Cannot cast effect locally on server.`)
		return createClientProxy(ctor, ...)
	end

	ctor._withId = function(args, id)
		logger.assert(runService:IsClient(), `Cannot cast effect locally on server.`)
		local self = setmetatable({}, ctor)
		self:constructor(table.unpack(args))

		entries.processReplicatedEntry(self, id)
		return self
	end

	effectsMap.add(ctor)

	return ctor
end

function wrapper.CreateEffect<T...>(name, extendsFrom)
	if typeof(name) ~= "string" then
		logger.error("Not provided a valid name for CreateEffect")
	end

	if extendsFrom and not instanceofConstructor(extendsFrom, baseEffect) then
		logger.error(`{extendsFrom} is not a valid base effect!`)
	end
	
	local super = extendsFrom or baseEffect
	local class = setmetatable({}, {
		__tostring = function()
			return name
		end,
		__index = super,
	})
	class.__index = class

	return wrapper.VisualEffectDecorator(class) or class
end

table.freeze(wrapper)

return wrapper
