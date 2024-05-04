local package = script.Parent.Parent
local packages = package.Parent
local fallbackDirectory = package:FindFirstChild("dependencies")

return function(name)
	local module = packages:FindFirstChild(name) or (fallbackDirectory and fallbackDirectory:FindFirstChild(name))
	assert(module, `Couldn't resolve dependency: {name}`)

	return module
end
