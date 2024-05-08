---
sidebar_position: 6
---

# Luau Types

Refx provides strict types for Luau users. <br/>
The correct way of typing your effect can be seen here:

```lua
local refx = require(path.to.refx)

type myEffectImpl = {
    __index: myEffectImpl,
    DoSomething: (myEffect) -> (), -- methods of your effect
}

type myEffectFields = {
    SomeField: number, -- fields of your effect
}

type myEffect = refx.Effect<myEffectImpl, myEffectFields, number, string> 
-- everything after first two arguments will be put into variadic generic parameter and used
-- as a tuple of arguments you pass to .new()

local myEffect = refx.CreateEffect("myEffect") :: refx.EffectImpl<myEffectImpl, myEffectFields, number, string>

function myEffect:OnStart(num, str)
    print("myEffect just started! 😅")
end

function myEffect:DoSomething()
    print("Do something")
end

return myEffect
```