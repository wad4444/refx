---
sidebar_position: 7
---

# Manual Destruction

import Tabs from "@theme/Tabs";
import TabItem from "@theme/TabItem";

If you want to *manually destroy* your effects, you can *turn off* automatic destruction on lifetime end by setting `DestroyOnLifecycleEnd` to `false`.
However, if you don't call `Destroy` manually **refx** will warn you about a memory leak:

:::warning
It's not *recommended* to **turn off** `DestroyOnLifecycleEnd`, because you can still manually call `Destroy()` on your proxy without *setting the flag*.
:::

<Tabs groupId="languages">
<TabItem value="Luau">

```lua title="myEffect.lua" showLineNumbers
local refx = require(path.to.refx)
local myEffect = refx.CreateEffect("myEffect")

function myEffect:OnConstruct()
    self.DestroyOnEnd = false
    self.DestroyOnLifecycleEnd = false
end

return myEffect
```

</TabItem>
<TabItem value="TypeScript" default>

```ts title="myEffect.ts" showLineNumbers
import { BaseEffect, VisualEffectDecorator, Config } from "@rbxts/refx";

@VisualEffectDecorator
export class myEffect extends BaseEffect<[number]> {
    protected readonly DestroyOnEnd = false;
    protected readonly DestroyOnLifecycleEnd = false;
}
```

</TabItem>
</Tabs>

<img
  src={require('@site/static/img/warning.png').default}
  alt="Warning"
/>
 
‎ 

:::danger
You can **silence** the *memory leak warning* by setting `DisableLeakWarning` to `true`. This is **not recommended**.
:::