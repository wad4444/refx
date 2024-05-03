local modules = script.Parent.modules
local remo = require(modules.remo)
local t = require(modules.t)

type Remotes = {
	__refx_create: remo.ServerToClient<string, number, { any }>,
	__refx_destroy: remo.ServerToClient<number>,
	__refx_communicator_rel: remo.ServerToClient<number, string, { any }>,
	__refx_communicator_urel: remo.ServerToClient<number, string, { any }>,
}

return remo.createRemotes({
	__refx_create = remo.remote(t.string, t.number, t.array(t.any)),
	__refx_destroy = remo.remote(t.number),
	__refx_communicator_rel = remo.remote(t.number, t.string, t.array(t.any)),
	__refx_communicator_urel = remo.remote(t.number, t.string, t.array(t.any)).unreliable(),
}) :: Remotes
