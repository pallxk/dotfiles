# Enable tab completion for kubectl

# Check bash-completion package is installed
[ -f /etc/profile.d/bash_completion.sh ] || return

# Check kubectl package is installed
command -v kubectl > /dev/null || return

. <(kubectl completion bash)
