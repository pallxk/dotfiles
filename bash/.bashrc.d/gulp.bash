#!/usr/bin/env bash

# Early return if gulp not installed
command -v gulp > /dev/null || return

# Enable tasks auto-completion
eval "$(gulp --completion=bash)"
