---
sidebar_position: 1
---

# Create effect

import Tabs from "@theme/Tabs";
import TabItem from "@theme/TabItem";

Let's *create* our *first effect* by using a function called `CreateEffect`, exported by *the refx module*.

<Tabs groupId="languages">
<TabItem value="Luau">

```lua title="myEffect.lua" showLineNumbers
local refx = require(path.to.refx)
local myEffect = refx.CreateEffect("myEffect")

function myEffect:OnStart()
    print("myEffect just started! 😅")
end

return myEffect
```

</TabItem>
<TabItem value="TypeScript" default>

:::note
[Just like WCS](https://wad4444.github.io/WCS/docs/tutorial/extras/differences) TypeScript implementation of myEffect is done via classes.
:::

```ts title="myEffect.ts" showLineNumbers
import { BaseEffect, VisualEffectDecorator } from "@rbxts/refx";

@VisualEffectDecorator
export class myEffect extends BaseEffect {
    public override OnStart() {
        print("myEffect just started! 😅");
    }
}
```

</TabItem>
</Tabs>

As you can see, we're *overriding* one of the built-in *special methods* provided by refx - `OnStart`. <br/>
This method fires whenever your effect starts. You can view list of all special methods in the api. (hyperlink here idiot)

## Constructor Arguments

You can also accept arguments in `OnStart()` and pass them to `.new()` or `.locally()`, when you [start your effect](./start-effect.md) later on:

<Tabs groupId="languages">
<TabItem value="Luau">

```lua title="myEffect.lua" showLineNumbers {4}
local refx = require(path.to.refx)
local myEffect = refx.CreateEffect("myEffect")

function myEffect:OnStart(someArg)
    print("myEffect just started! 😅", someArg)
end

return myEffect
```

</TabItem>
<TabItem value="TypeScript" default>

```ts title="myEffect.ts" showLineNumbers {5}
import { BaseEffect, VisualEffectDecorator } from "@rbxts/refx";

@VisualEffectDecorator
export class myEffect extends BaseEffect<[number]> {
    public override OnStart(someArg: number) {
        print("myEffect just started! 😅", someArg);
    }
}
```

</TabItem>
</Tabs>

<Tabs groupId="languages">
<TabItem value="Luau">

```lua title="somewhere.lua" showLineNumbers {2}
local myEffect = require(path.to.effect)
local effect = myEffect.new(10)
```

</TabItem>
<TabItem value="TypeScript" default>

```ts title="somewhere.ts" showLineNumbers {2}
import { myEffect } from "./myEffect";
const effect = new myEffect(10);
```

</TabItem>
</Tabs>