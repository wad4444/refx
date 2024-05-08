---
sidebar_position: 3
---

# Start Effect

import Tabs from "@theme/Tabs";
import TabItem from "@theme/TabItem";

You can *start* your effect on *server* by requiring the module and calling `.new()` on your effect class. 
After that, you will need to use a *special method* of *server proxy* called `:Start()` to specify
what *players* you're *starting* effect for:

<Tabs groupId="languages">
<TabItem value="Luau">

```lua title="somewhere.lua" showLineNumbers
local myEffect = require(path.to.effect)
local effect = myEffect.new(10):Start(game.Players:GetPlayers()) -- start your effect for all players
```

</TabItem>
<TabItem value="TypeScript" default>

```ts title="somewhere.ts" showLineNumbers
import { myEffect } from "./myEffect";
import { Players } from "@rbxts/services";

const effect = new myEffect(10).Start(Players.GetPlayers()); // start your effect for all players
```

</TabItem>
</Tabs>

After you called `:Start()` effect will start and `:OnStart()` will be called for provided players.
After `:OnStart()` is finished executing effect will be destroyed automatically.
However, there are some important rules that can change this behavior and you need to know about.
They're described [in the next page.](./lifetime)