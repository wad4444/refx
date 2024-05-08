---
sidebar_position: 6
---

# Configuration

import Tabs from "@theme/Tabs";
import TabItem from "@theme/TabItem";

You can *configure* your *custom methods* by using *built-in* function called `Configure`.
Let's *configure* our *custom method* to use an *unreliable remote event* under the hood,
so we can *safely fire it* a lot of times.

<Tabs groupId="languages">
<TabItem value="Luau">

```lua title="myEffect.lua" showLineNumbers
local refx = require(path.to.refx)
local myEffect = refx.CreateEffect("myEffect")

function myEffect:OnConstruct()
    self.DestroyOnEnd = false -- so our effect don't get destroyed instantly.
    self.MaxLifetime = 10
end

function myEffect:DoSomething(arg) -- our custom method
    print(arg)
end

refx.Configure(myEffect.DoSomething, { -- configuring to use an unreliable remote
    Unreliable = true,
})

return myEffect
```

</TabItem>
<TabItem value="TypeScript" default>

```ts title="myEffect.ts" showLineNumbers
import { BaseEffect, VisualEffectDecorator, Config } from "@rbxts/refx";

@VisualEffectDecorator
export class myEffect extends BaseEffect<[number]> {
    protected readonly DestroyOnEnd = false; // so our effect don't get destroyed instantly.
    protected readonly MaxLifetime = 10;

    @Config({ Unreliable: true }) // configuring to use an unreliable remote
    public DoSomething(arg: number) { // our custom method
        print(arg);
    }
}
```

</TabItem>
</Tabs>