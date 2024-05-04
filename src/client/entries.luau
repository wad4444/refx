local entriesMap = {}
local entries = {}

local utils = script.Parent.Parent.utilities

local createGenerator = require(utils.idGenerator)
local logger = require(utils.logger)

local nextId = createGenerator(-1)
local RunService = game:GetService("RunService")

local checkerConnection

function entries.processReplicatedEntry(effect, id)
	entriesMap[id] = {
		Effect = effect,
		StartTimestamp = tick(),
	}

	effect.Destroyed:Connect(function()
		entriesMap[id] = nil
	end)
	effect:_start()
end

function entries.processLocalEntry(effect)
	local id = nextId()
	entriesMap[id] = {
		Effect = effect,
		StartTimestamp = tick(),
	}

	effect.Destroyed:Connect(function()
		entriesMap[id] = nil
	end)
	effect:_start()
end

function entries.checkCycle()
	if not next(entriesMap) then
		return
	end

	for _, entry in entriesMap do
		local effect = entry.Effect
		local isOverMaxLifetime = (tick() - entry.StartTimestamp) > effect.MaxLifetime

		local effectName = tostring(getmetatable(effect))
		if isOverMaxLifetime and effect.DestroyOnLifecycleEnd then
			effect:Destroy()
			continue
		end

		if isOverMaxLifetime and RunService:IsStudio() and not effect.DisableLeakWarning then
			if entry.LastWarningTimestamp and ((tick() - entry.LastWarningTimestamp) < 10) then
				continue
			end

			local overtime = tick() - entry.StartTimestamp - effect.MaxLifetime
			logger.warn(
				`A possible memory leak detected: \nEffect "{effectName}" is living {overtime}s over max lifetime and isn't destroyed.`
			)
			entry.LastWarningTimestamp = tick()
		end
	end
end

function entries.getEffect(id)
	local entry = entriesMap[id]
	if entry then
		return entry.Effect
	end

	return nil
end

function entries.startChecker()
	if checkerConnection then
		return
	end
	checkerConnection = RunService.Heartbeat:Connect(entries.checkCycle)
end

function entries.stopChecker()
	if not checkerConnection then
		return
	end
	checkerConnection:Disconnect()
	checkerConnection = nil
end

return entries
