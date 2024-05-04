local client = {}

local utils = script.Parent.utilities
local logger = require(utils.logger)
local remotes = require(script.Parent.remotes)
local map = require(script.Parent.effectsMap)
local entries = require(script.entries)

local runService = game:GetService("RunService")

local initialized = false
local modules: { ModuleScript } = {}

function client.Register(directory: Instance)
	logger.assert(runService:IsClient(), `Canoot Register() on server.`)
	logger.assertWarn(not initialized, `Cannot Register() a directory after client has started.`)

	for _, v in directory:GetDescendants() do
		if not v:IsA("ModuleScript") then
			continue
		end
		table.insert(modules, v)
	end
end

function client.Start()
	logger.assert(runService:IsClient(), `Canoot Start() on server.`)
	logger.assert(not initialized, `Cannot Start() a directory after client has started.`)

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

		if params[0] then
			params[0] = nil
		end

		constructor._withId(params, id)
	end)

	remotes.__refx_destroy:connect(function(id)
		local effect = entries.getEffect(id)
		if effect then
			effect:Destroy()
		end
	end)

	local function processRequest(id, method, args)
		if args[0] then
			args[0] = nil
		end

		local effect = entries.getEffect(id)
		if not effect then
			logger.warn(
				`:{method}() isn't available. Effect you're trying to access is already destroyed! \n Tip: consider configuring DestroyOnEnd or MaxLifetime!`
			)
			return
		end

		if not effect[method] then
			logger.error(`Method :{method}() is invalid.`)
			return
		end

		effect[method](effect, table.unpack(args))
	end

	remotes.__refx_communicator_rel:connect(processRequest)
	remotes.__refx_communicator_urel:connect(processRequest)

	entries.startChecker()
	initialized = true
end

function client.IsInitialized()
	return initialized
end

table.freeze(client)

return client
