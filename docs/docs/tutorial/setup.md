---
sidebar_position: 2
---

# Setup

import Tabs from "@theme/Tabs";
import TabItem from "@theme/TabItem";

All you need to do for **refx** to work is to *register the folder* where you will be *storing effects* on *client* using
an exported function `Register()` and call `Start()` right after.

:::note
You can register multiple folders.
:::

<Tabs groupId="languages">
<TabItem value="Luau">

```lua title="client.lua" showLineNumbers
local refx = require(path.to.refx)
refx.Register(game.ReplicatedStorage.effects)
refx.Start()
```

</TabItem>
<TabItem value="TypeScript" default>

```ts title="client.ts" showLineNumbers
import { Register, Start } from "@rbxts/refx";
Register(game.ReplicatedStorage.effects)
Start()
```

</TabItem>
</Tabs>