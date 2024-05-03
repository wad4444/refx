local baseEffect = require(script.Parent.baseEffect)
local runService = game:GetService("RunService")

local createProxy = require(script.Parent.createProxy)

return function<T...>(ctor: baseEffect.BaseEffectConstructor<T...>)
	local updated = ctor :: baseEffect.EffectConstructor<T...>
	updated.new = function(...: T...)
		if runService:IsServer() then
			return createProxy(tostring(ctor), ...)
		end

		local self = setmetatable({}, ctor) :: baseEffect.BaseEffect<T...>
		self:constructor(...)

		return self :: baseEffect.Effect<T...>
	end
end
