# Check
hash kubectl 2> /dev/null || return

# Auto completion
. <(kubectl completion bash)

# Alias
alias k=kubectl
complete -F __start_kubectl k
