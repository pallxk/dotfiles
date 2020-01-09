# Enable tab completion for az

# Arch Linux AUR package "azure-cli"
[ -f /opt/azure-cli/az.completion ] && . /opt/azure-cli/az.completion && return

# azure-cli official install script default location
[ -f ~/lib/azure-cli/az.completion ] && . ~/lib/azure-cli/az.completion && return
