local package = script.Parent.Parent
local packages = package.Parent

type t = typeof(require(packages.t))

local getModule = require(package.utilities.getModule)
local module = getModule("t")

return require(module) :: t
