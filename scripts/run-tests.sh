#!/bin/sh

set -e

bash scripts/install-packages.sh
rojo build -o refx-testing.rbxl dev.project.json
lune run scripts/run-tests.luau refx-testing.rbxl
rm -rf refx-testing.rbxl