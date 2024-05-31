---
sidebar_position: 1
---

# Refx

import TOCInline from "@theme/TOCInline";

<TOCInline toc={toc} />

## `CreateEffect(name)`
Creates your effect class and returns it.

**`Parameters:`**
* Name: `string`

**`Returns:`**
* EffectConstructor: `EffectImpl<unknown, unknown, ...unknown>`

## `Configure(method, config)`
Applies chosen attributes to your class method.

**`Parameters:`**
* Method: `function` - a method of your skill class.
* Config: `FunctionAttributes`

## `Register(directory)` **@client**
Requires all module scripts in a directory when client starts. Can only be called before client has started.

**`Parameters:`**
* Directory: `Instance`

## `Start()` **@client**
Starts the client and requires all registered module scripts.