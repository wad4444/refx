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

	self:OnConstruct(...)
	return self
end

function BaseEffect:OnConstruct() end

function BaseEffect:_start()
	if self._started then
		logger.error(`Cannot :Start() effect {self} twice!`)
	end
	self._started = true

	self._executionThread = task.spawn(function()
		self:OnStart(table.unpack(self.Configuration))
		if self.DestroyOnEnd then
			self:Destroy()
		end
	end)
end

function BaseEffect:OnDestroy() end

function BaseEffect:Destroy()
	if self.IsDestroyed then
		return
	end

	if self._executionThread and coroutine.status(self._executionThread) ~= "dead" then
		logger.warn(`:OnStart() was still executing, but effect is destroyed. Thread was cancelled.`)
		task.cancel(self._executionThread)
	end

	self.IsDestroyed = true
	self.Destroyed:Fire()

	self:OnDestroy()
end

function BaseEffect:OnStart() end

table.freeze(BaseEffect)

return BaseEffect
