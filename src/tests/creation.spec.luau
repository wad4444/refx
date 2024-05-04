local refx = require(script.Parent.Parent)

return function()
	it("should create an effect", function()
		expect(refx.CreateEffect("_test effect")).to.be.a("table")
	end)

	it("should not allow same names", function()
		expect(function()
			refx.CreateEffect("_test effect")
		end).to.throw("Double registration")
	end)
end
