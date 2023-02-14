#!/bin/sh

# Create ~/.gitconfig if not exists so that config like user.name & user.email
# can go there.
touch ~/.gitconfig

# Get current git version.
# Output of `git --version` looks like this:
#   git version 2.6.2
current_version=$(git --version | cut -d' ' -f3)

# Include $XDG_CONFIG_HOME/git/config manually if git version lower than 1.7.12
# For git with higher version, this global config is included by default.
target_version="1.7.12"

if [ "$(printf "%s\n%s\n" "$target_version" "$current_version" | sort -V | head -1)" \
     != "$target_version" ]; then
	# current_version is lower than target_version
	git config --global include.path .config/git/config
fi
