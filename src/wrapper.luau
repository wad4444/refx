local baseEffect = require(script.Parent.baseEffect)
local runService = game:GetService("RunService")

local createProxy = require(script.Parent.createProxy)
local logger = require(script.Parent.utilities.logger)
local wrapper = {}

function wrapper.VisualEffectDecorator<T...>(ctor: baseEffect.EffectConstructor<T...>): baseEffect.EffectConstructor<T...>
	local updated = ctor
	updated.new = function(...: T...)
		logger.assert(runService:IsServer(), `Cannot get effect proxy on server.`)
		return createProxy(tostring(ctor), ...)
	end

	updated.locally = function(...: T...)
		logger.assert(runService:IsClient(), `Cannot cast effect locally on server.`)

		local self = setmetatable({} :: baseEffect.BaseEffectObject, ctor)
		self.constructor(self :: any, ...)
		return self
	end

	return updated
end

function wrapper.CreateEffect<T...>(name: string): baseEffect.EffectConstructor<T...>
	local class = setmetatable({}, {
		__tostring = function()
			return name
		end,
		__index = baseEffect,
	})
	class.__index = class

	return wrapper.VisualEffectDecorator(class :: any)
end

table.freeze(wrapper)

return wrapper
