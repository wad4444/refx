local refx = require(script.Parent.Parent)

return function()
	local testEffect = refx.CreateEffect("_test1")
	function testEffect:OnConstruct()
		self.DestroyOnEnd = false
		self.MaxLifetime = 5
	end

	refx.Start()

	it("should accept arguments", function()
		expect(testEffect.locally(1, 2, 3)).to.be.ok()
	end)

	describe(":Destroy()", function()
		it("should destroy a proxy", function()
			local proxy = testEffect.locally()
			expect(function()
				proxy:Destroy()
			end).to.be.ok()
		end)

		it("cannot destroy twice", function()
			local proxy = testEffect.locally()
			proxy:Destroy()
			expect(function()
				proxy:Destroy()
			end).to.throw()
		end)
	end)

	it("it should call effect methods", function()
		local proxy = testEffect.locally()
		expect(function()
			proxy:testfn()
		end).to.be.ok()
	end)

	it("it block invalid indexations", function()
		local proxy = testEffect.locally()
		expect(function()
			print(proxy.DestroyOnEnd)
		end).to.throw("missing method")
	end)

	it("should block overriding attempts", function()
		local proxy = testEffect.locally()
		expect(function()
			proxy.testfn = 1
		end).to.throw("override")
	end)
end
