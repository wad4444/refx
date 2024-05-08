#!/bin/sh

set -e

bash scripts/install-packages.sh
rojo sourcemap -o sourcemap.json default.project.json
wally publish