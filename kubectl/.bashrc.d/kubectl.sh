# Check
hash kubectl 2> /dev/null || return

# KUBECONFIG
export KUBECONFIG=~/.kube/config.new:~/.kube/config

# Auto completion
. <(kubectl completion bash)

# Alias
if hash kubecolor 2> /dev/null; then
	alias k=kubecolor
else
	alias k=kubectl
fi

complete -F __start_kubectl k
