local package = script.Parent.Parent
local packages = package.Parent

type SignalModule = typeof(require(packages.signal))

local getModule = require(package.utilities.getModule)
local signalModule = getModule("signal")

-- i hate this
export type Connection = typeof((function()
	local module = require(packages.signal)
	return {} :: module.Connection
end)())

export type Signal<T...> = typeof((function()
	local module = require(packages.signal)
	return {} :: module.Signal<T...>
end)())

return require(signalModule) :: SignalModule
