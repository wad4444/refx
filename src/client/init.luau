local client = {}

local utils = script.Parent.utilities
local logger = require(utils.logger)
local remotes = require(script.Parent.remotes)
local map = require(script.Parent.effectsMap)

local runService = game:GetService("RunService")

local initialized = false
local modules: { ModuleScript } = {}

function client.Register(directory: Instance)
	logger.assert(runService:IsClient(), `Canoot Register() on server.`)
	logger.assetWarn(not initialized, `Cannot Register() a directory after client has started.`)

	for _, v in directory:GetDescendants() do
		if not v:IsA("ModuleScript") then
			continue
		end
		table.insert(modules, v)
	end
end

function client.Start()
	logger.assert(runService:IsClient(), `Canoot Start() on server.`)
	logger.assetWarn(not initialized, `Cannot Start() a directory after client has started.`)

	for _, v in modules do
		require(v)
	end

	remotes.__refx_create:connect(function(effectName, id, params)
		local constructor = map.get(effectName)
		logger.assert(
			constructor ~= nil,
			`Effect {effectName} wasn't found! Try doing .Register() on its file directory.`
		)
		assert(constructor, "")

		constructor._withId(params, id)
	end)
end

table.freeze(client)

return client
