local package = script.Parent.Parent
local packages = package.Parent

type Remo = typeof(require(packages.remo))

local getModule = require(package.utilities.getModule)
local module = getModule("remo")

-- i hate this
export type ServerToClient<Args... = ...any> = typeof((function()
	local remo = require(packages.remo)
	return {} :: remo.ServerToClient<Args...>
end)())

return require(module) :: Remo
