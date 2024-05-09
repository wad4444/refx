---
sidebar_position: 4
---

# Client Proxy

import TOCInline from "@theme/TOCInline";

<TOCInline toc={toc} />

:::note
Any method of `Effect` called on `ClientProxy` will be called for corresponding effect instance.
:::

## `Destroy()` **@chainable**
Destroys the proxy and effect.

**`Returns:`**
* self: `ClientProxy`