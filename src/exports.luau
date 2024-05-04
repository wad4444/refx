local package = script.Parent

local baseEffect = require(package.baseEffect)
local wrapper = require(package.wrapper)
local client = require(package.client)
local configuration = require(package.configuration)

return {
	BaseEffect = baseEffect,
	VisualEffectDecorator = wrapper.VisualEffectDecorator,
	CreateEffect = wrapper.CreateEffect,
	Register = client.Register,
	Start = client.Start,
	Configure = configuration.Configure,
	Config = configuration.Config,
}
