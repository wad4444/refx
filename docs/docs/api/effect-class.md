---
sidebar_position: 2
---

# Effect Class

import TOCInline from "@theme/TOCInline";

<TOCInline toc={toc} />

## Fields

### `Configuration`: `table` **@readonly**
A table of arguments passed to `.new()` or `.locally()`.

### `IsDestroyed`: `boolean` **@readonly**

### `DestroyOnEnd`: `boolean`
Determines if skill should get automatically destroyed when `OnStart()` finishes executing.

### `MaxLifetime`: `number`
A maximum amount of seconds your effect can exist. [-> Read here.](../tutorial/guide/lifetime.md)

### `DestroyOnLifecycleEnd`: `boolean`
Determines if skill should get automatically destroyed when reaches its `MaxLifetime`.

### `DisableLeakWarning`: `boolean`
If true, disables [a memory leak warning](../tutorial/guide/manual-destruction.md) from lifetime checker.

## Constructors

### `new(...) -> ServerProxy`
Used on server. Creates an [effect proxy](./server-proxy.md) and broadcasts every called method to clients.

### `new(...) -> ClientProxy`
Used on client. Creates your effect locally and returns a [client proxy](./client-proxy.md).

## Methods

### `OnStart()` **@override**
Invokes when your effect starts.

### `OnConstruct()` **@override**
Invokes when your effect gets constructed, before `OnStart()`.

### `OnDestroy()` **@override**
Invokes when your effect gets destroyed.