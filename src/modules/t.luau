local package = script.Parent.Parent
local packages = package.Parent
local fallbackDirectory = package:FindFirstChild("dependencies")

type t = typeof(require(packages.t))

local tModule = packages:FindFirstChild("t") or (fallbackDirectory and fallbackDirectory:FindFirstChild("t"))
assert(tModule, "Couldn't resolve dependency: t")

return require(tModule) :: t
