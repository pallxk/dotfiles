[ -f ~/bin/ansible-vault-password-helper ] || return
export ANSIBLE_VAULT_PASSWORD_FILE=~/bin/ansible-vault-password-helper

# https://docs.ansible.com/ansible/latest/reference_appendices/config.html#default-stdout-callback
export ANSIBLE_STDOUT_CALLBACK=yaml

# https://docs.ansible.com/ansible/latest/reference_appendices/config.html#default-strategy
export ANSIBLE_STRATEGY=free
