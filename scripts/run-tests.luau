local roblox = require("@lune/roblox")
local fs = require("@lune/fs")
local luau = require("@lune/luau")
local process = require("@lune/process")
local stdio = require("@lune/stdio")
local task = require("@lune/task")

local testPlacePath = process.args[1]

local game = roblox.deserializePlace(fs.readFile(testPlacePath))

local function tick()
	return os.clock()
end

game:GetService("ReplicatedStorage")

roblox.implementMethod("RunService", "IsClient", function()
	return true
end)

roblox.implementProperty("RunService", "Heartbeat", function()
	return {
		Connect = function() end,
	}
end, function() end)

roblox.implementMethod("RunService", "IsServer", function()
	return true
end)

roblox.implementMethod("RunService", "IsStudio", function()
	return true
end)

roblox.implementMethod("RunService", "IsRunning", function()
	return false
end)

roblox.implementMethod("TestService", "Error", function(_self, description: string)
	stdio.ewrite(`{description}\n`)
end)

local robloxRequire

local function runRobloxScript(script)
	local callableFn = luau.load(luau.compile(script.Source), {
		debugName = script:GetFullName(),
		environment = {
			Instance = Instance,
			task = task, 
			game = game,
			script = script,
			require = robloxRequire,
			tick = tick,
			coroutine = coroutine,
		},
	})

	return callableFn()
end

local requireCache = {}

function robloxRequire(moduleScript: ModuleScript)
	local scriptPath = moduleScript:GetFullName()
	local cached = requireCache[scriptPath]
	if cached then
		return table.unpack(cached)
	end

	local result = table.pack(runRobloxScript(moduleScript))
	requireCache[scriptPath] = result
	return table.unpack(result)
end

runRobloxScript(game.ServerScriptService.main)
