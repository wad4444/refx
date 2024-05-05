local rp = game:GetService("ReplicatedStorage")
local testez = require(rp.DevPackages.testez)
local results = testez.TestBootstrap:run({rp.Packages.refx.tests})

if #results.errors > 0 or results.failureCount > 0 then
	error("Tests failed!")
end 