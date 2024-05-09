---
sidebar_position: 3
---

# Server Proxy

import TOCInline from "@theme/TOCInline";

<TOCInline toc={toc} />

:::note
Any method of `Effect` called on `ServerProxy` will be broadcasted to clients and called for corresponding effect instance.
:::

## `Start(players)` **@chainable**
Starts the effect for the provided players.

**`Parameters:`**
* Players: `{Player}`

**`Returns:`**
* self: `ServerProxy`

## `GetPlayers()`
Retrieves the array of players provided to `Start()`. Throws if used before `Start()`.

**`Returns:`**
* Players: `{Player}`

## `Destroy()` **@chainable**
Destroys the proxy and effect.

**`Returns:`**
* self: `ServerProxy`