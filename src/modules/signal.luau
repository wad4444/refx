local package = script.Parent.Parent
local packages = package.Parent
local fallbackDirectory = package:FindFirstChild("dependencies")

type SignalModule = typeof(require(packages.signal))

local signalModule = packages:FindFirstChild("signal") or (fallbackDirectory and fallbackDirectory:FindFirstChild("signal"))
assert(signalModule, "Couldn't resolve dependency: Signal")

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
