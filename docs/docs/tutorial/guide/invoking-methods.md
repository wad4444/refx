---
sidebar_position: 5
---

# Invoking Methods

import Tabs from "@theme/Tabs";
import TabItem from "@theme/TabItem";

Now, we can easily define *custom methods* and call them from our *server proxy*.
Here's an example of how to do that:

:::warning
Custom methods are *remote calls* for multiple clients *under the hood*, so they **cannot return values**.
:::

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

return myEffect
```

</TabItem>
<TabItem value="TypeScript" default>

```ts title="myEffect.ts" showLineNumbers
import { BaseEffect, VisualEffectDecorator } from "@rbxts/refx";

@VisualEffectDecorator
export class myEffect extends BaseEffect<[number]> {
    protected readonly DestroyOnEnd = false; // so our effect don't get destroyed instantly.
    protected readonly MaxLifetime = 10;

    public DoSomething(arg: number) { // our custom method
        print(arg);
    }
}
```

</TabItem>
</Tabs>

Let's *create our effect* and c*all our method* from the *server proxy*:

<Tabs groupId="languages">
<TabItem value="Luau">

```lua title="somewhere.lua" showLineNumbers
local myEffect = require(path.to.effect)
local effect = myEffect.new(10):Start(game.Players:GetPlayers())
effect:DoSomething(10)
```

</TabItem>
<TabItem value="TypeScript" default>

```ts title="somewhere.ts" showLineNumbers
import { myEffect } from "./myEffect";
import { Players } from "@rbxts/services";

const effect = new myEffect(10).Start(Players.GetPlayers());
effect.DoSomething(10);
```

</TabItem>
</Tabs>

