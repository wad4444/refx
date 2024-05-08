---
sidebar_position: 1
---

# Introduction

**Refx** is a *simple* and *lightweight* library for *Replicating Visual Effects* in your roblox games.
The *core* principle of refx is to not instantiate anything on server side.

**Library** achieves this by providing a *proxy table* as an interface to work with on *server side*, 
that internally sends *remote requests* to client under the hood.
**Refx** also comes with built-in *lifetime checker*, that makes sure all effects get *destroyed properly* and
warns you about *memory leaks* you made.

:::warning
**Refx** is still in `beta`. Expect **bugs** and *breaking* changes.
:::