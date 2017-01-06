# Enable tab completion for aws

# Check aws-cli package is installed
command -v aws_completer > /dev/null || return;

complete -C aws_completer aws
