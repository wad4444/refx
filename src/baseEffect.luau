local BaseEffect = setmetatable({}, {
	__tostring = function()
		return "BaseEffect"
	end,
})
BaseEffect.__index = BaseEffect

local modules = script.Parent.modules
local signal = require(modules.signal)

function BaseEffect.constructor(self, ...)
	self.Configuration = { ... }
	self.DisableLeakWarning = false
	self.IsDestroyed = false

	self.MaxLifetime = 15
	self.DestroyOnLifecycleEnd = true

	self.DestroyOnEnd = true
	self.Destroyed = signal.new()

	return self
end

function BaseEffect:Start()
	self:OnStart()
	if self.DestroyOnEnd then
		self:Destroy()
	end
end

function BaseEffect:Destroy()
	self.IsDestroyed = true
	self.Destroyed:Fire()
end

function BaseEffect:OnStart() end

table.freeze(BaseEffect)

return BaseEffect
