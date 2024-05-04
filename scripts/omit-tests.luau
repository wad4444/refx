-- selene: allow(incorrect_standard_library_use)
local process = require("@lune/process")
-- selene: allow(incorrect_standard_library_use)
local fs = require("@lune/fs")
-- selene: allow(incorrect_standard_library_use)
local roblox = require("@lune/roblox")

local args = process.args
local fileName = args[1]
assert(fileName, "Missing filename!")

local modelFile = fs.readFile(fileName)
local instances = roblox.deserializeModel(modelFile)

for _, instance in instances do
	for _, descendant in instance:GetDescendants() do
		if string.find(descendant.Name, ".spec") then
			print(`Omitting {descendant.Name}`)
			descendant:Destroy()
		end
	end
end

local newFile = roblox.serializeModel(instances)
fs.writeFile(fileName, newFile)
