#!/bin/sh

set -e

bash scripts/install-packages.sh
rojo build -o refx.rbxm withDeps.project.json
lune run scripts/omit-tests.luau refx.rbxm