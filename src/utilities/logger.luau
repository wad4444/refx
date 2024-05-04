local logger = {}
local errorFormat = "[refX]: %s"

function logger.assert(exp: boolean, error: string, traceback: boolean | nil)
	local errorString = string.format(errorFormat, `{error} \n {traceback and debug.traceback()}`)
	assert(exp, errorString)
end

function logger.error(errorString: string, traceback: boolean | nil)
	error(string.format(errorFormat, `{errorString} \n {traceback and debug.traceback()}`))
end

function logger.warn(warnString: string)
	warn(string.format(errorFormat, `{warnString} \n`))
end

function logger.assertWarn(exp: boolean, warnString: string)
	local toWarn = string.format(errorFormat, `{warnString} \n`)
	if not exp then
		warn(toWarn)
	end
end

table.freeze(logger)

return logger
