local baseEffect = require(script.Parent.baseEffect)
local runService = game:GetService("RunService")

local createProxy = require(script.Parent.createProxy)
local wrapper = {}

function wrapper.VisualEffectDecorator<T...>(ctor: baseEffect.EffectConstructor<T...>): baseEffect.EffectConstructor<T...>
	local updated = ctor
	updated.new = function(...: T...)
		if runService:IsServer() then
			return createProxy(tostring(ctor), ...)
		end

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
