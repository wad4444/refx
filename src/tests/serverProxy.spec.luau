local refx = require(script.Parent.Parent)

return function()
	local testEffect = refx.CreateEffect("_test")
	function testEffect:testfn() end

	it("should accept arguments", function()
		expect(testEffect.new(1, 2, 3)).to.be.ok()
	end)

	describe(":Start()", function()
		it("should not accept invalid arguments", function()
			local proxy = testEffect.new(1, 2, 3)
			expect(function()
				proxy:Start(1 :: any)
			end).to.throw()

			expect(function()
				proxy:Start(nil :: any)
			end).to.throw()
		end)
	end)

	describe(":Destroy()", function()
		it("should destroy a proxy", function()
			local proxy = testEffect.new()
			expect(function()
				proxy:Destroy()
			end).to.be.ok()
		end)

		it("cannot destroy twice", function()
			local proxy = testEffect.new()
			proxy:Destroy()
			expect(function()
				proxy:Destroy()
			end).to.throw("twice")
		end)
	end)

	it("it should call effect methods", function()
		local proxy = testEffect.new():Start({})
		expect(function()
			proxy:testfn()
		end).to.be.ok()
	end)

	it("it block invalid indexations", function()
		local proxy = testEffect.new():Start({})
		expect(function()
			print(proxy.DestroyOnEnd)
		end).to.throw("missing method")
	end)

	it("should block overriding attempts", function()
		local proxy = testEffect.new():Start({})
		expect(function()
			proxy.testfn = 1
		end).to.throw("override")
	end)
end
