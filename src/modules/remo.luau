local package = script.Parent.Parent
local packages = package.Parent
local fallbackDirectory = package:FindFirstChild("dependencies")

type Remo = typeof(require(packages.remo))

local remoModule = packages:FindFirstChild("remo") or (fallbackDirectory and fallbackDirectory:FindFirstChild("remo"))
assert(remoModule, "Couldn't resolve dependency: Remo")

-- i hate this
export type ServerToClient<Args... = ...any> = typeof((function()
	local remo = require(packages.remo)
	return {} :: remo.ServerToClient<Args...>
end)())

return require(remoModule) :: Remo
