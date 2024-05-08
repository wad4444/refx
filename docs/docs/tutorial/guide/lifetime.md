---
sidebar_position: 3
---

# Lifetime

import Tabs from "@theme/Tabs";
import TabItem from "@theme/TabItem";

Sometimes, you want your effect to *live longer* than execution time of `OnStart()`.
You can achieve this by *explicitly specifying* to not *destroy your effect on end*.
However, it's *very easy* to create *unsafe* code this way.

**Refx** solves this by introducing **Lifetimes**. `MaxLifetime` is the *maximum* amount of seconds that *your effect can exist* for.
If `DestroyOnEnd` is set to `false` your effect will automatically be destroyed when reaches its `MaxLifetime`.

:::note
`OnConstruct()` fires when effect is constructed, before `OnStart()`.
:::

<Tabs groupId="languages">
<TabItem value="Luau">

```lua title="myEffect.lua" showLineNumbers
local refx = require(path.to.refx)
local myEffect = refx.CreateEffect("myEffect")

function myEffect:OnConstruct()
    self.DestroyOnEnd = false
    self.MaxLifetime = 10 -- default value is 15
end

return myEffect
```

</TabItem>
<TabItem value="TypeScript" default>

```ts title="myEffect.ts" showLineNumbers
import { BaseEffect, VisualEffectDecorator } from "@rbxts/refx";

@VisualEffectDecorator
export class myEffect extends BaseEffect {
    protected readonly MaxLifetime = 10; // default value is 15
    protected readonly DestroyOnEnd = false;
}
```

</TabItem>
</Tabs>

:::note
If `OnStart()` executes longer than `MaxLifetime` thread will be cancelled and effect will be destroyed.
:::