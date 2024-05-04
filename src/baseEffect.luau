local BaseEffect = setmetatable({}, {
	__tostring = function()
		return "BaseEffect"
	end,
})
BaseEffect.__index = BaseEffect

local modules = script.Parent.modules
local signal = require(modules.signal)
local logger = require(script.Parent.utilities.logger)

function BaseEffect.constructor(self, ...)
	self.Configuration = { ... }
	self.DisableLeakWarning = false
	self.IsDestroyed = false

	self.MaxLifetime = 15
	self.DestroyOnLifecycleEnd = true

	self.DestroyOnEnd = true
	self.Destroyed = signal.new()

	self:OnConstruct()
	return self
end

function BaseEffect:OnConstruct() end

function BaseEffect:_start()
	if self._started then
		logger.error(`Cannot :Start() effect {self} twice!`)
	end
	self._started = true

	self:OnStart()
	if self.DestroyOnEnd then
		self:Destroy()
	end
end

function BaseEffect:Destroy()
	if self.IsDestroyed then
		return
	end

	self.IsDestroyed = true
	self.Destroyed:Fire()
end

function BaseEffect:OnStart() end

table.freeze(BaseEffect)

return BaseEffect
