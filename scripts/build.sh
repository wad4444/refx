#!/bin/sh

set -e

bash scripts/install-packages.sh
rojo build -o refx.rbxm simple.project.json