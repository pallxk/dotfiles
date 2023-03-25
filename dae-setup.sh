#!/usr/bin/env bash

set -euo pipefail

cd "$(dirname "$0")"

mkdir -p ~/.config/dae/subscriptions

stow dae

# `chmod -R` doesn't work with symlinks
find -L ~/.config/dae -type f -exec chmod 600 {} +
