local BaseEffect = setmetatable({}, {
	__tostring = function()
		return "BaseEffect"
	end,
})
BaseEffect.__index = BaseEffect

function BaseEffect.constructor(self, ...)
	self.Configuration = { ... }
	self.DisableLeakWarning = false
	return self
end

function BaseEffect:OnStart() end

table.freeze(BaseEffect)

return BaseEffect
