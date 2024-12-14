local package = script.Parent.Parent
local packages = package.Parent

local node_modules = package:FindFirstAncestor("node_modules")
local fallbackDirectory = package:FindFirstChild("dependencies")

function resolveFirstModule(parent)
	local foundModule = parent:FindFirstChildOfClass("ModuleScript")
	if foundModule then
		return foundModule
	end

	for _, child in parent:GetChildren() do
		local found = resolveFirstModule(child)
		if found then
			return found
		end
	end

	error("Couldn't resolve first module child")
end

return function(name)
	local module
	if node_modules then
		module = node_modules["@rbxts"]:FindFirstChild(name)
		module = if module:IsA("Folder") then resolveFirstModule(module) else module
	else
		module = packages:FindFirstChild(name) or (fallbackDirectory and fallbackDirectory:FindFirstChild(name))
	end

	assert(module or module:IsA("ModuleScript"), `Couldn't resolve dependency: {name}`)
	return module
end
