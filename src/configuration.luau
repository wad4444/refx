local configuration = {}
local configs = {}

local t = require(script.Parent.modules.t)
local logger = require(script.Parent.utilities.logger)
local map = require(script.Parent.effectsMap)
local baseEffect = require(script.Parent.baseEffect)

local configGuard = t.interface({
	Unreliable = t.optional(t.boolean),
})

function methodGuard(methodToCheck)
	for _, ctor in map.getAll() do
		for name, method in ctor do
			if methodToCheck ~= method then
				continue
			end
			if rawget(baseEffect, name) then
				return false
			end

			return true
		end
	end

	return false
end

local defaultConfig = {
	Unrealiable = false,
}
function configuration.Configure(method, config)
	logger.assert(configGuard(config), "Provided config contains invalid values.")
	logger.assert(methodGuard(method), "Provided method is not a valid effect method")

	configs[method] = config
end

function configuration.Config(config)
	logger.assert(configGuard(config), "Provided config contains invalid values.")
	return function(method)
		logger.assert(methodGuard(method), "Provided method is not a valid effect method")
		configs[method] = config
	end
end

function configuration.GetConfig(method)
	return configs[method] or defaultConfig
end

return configuration
