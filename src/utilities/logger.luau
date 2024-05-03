local logger = {}
local errorFormat = "// [refX]: %s //"

function logger.assert(exp: boolean, error: string, traceback: boolean | nil)
	local errorString = string.format(errorFormat, `{error} \n {traceback and debug.traceback()}`)
	assert(exp, errorString)
end

function logger.error(errorString: string, traceback: boolean | nil)
	error(string.format(errorFormat, `{errorString} \n {traceback and debug.traceback()}`))
end

table.freeze(logger)

return logger
