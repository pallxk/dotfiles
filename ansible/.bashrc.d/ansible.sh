[ -f ~/bin/ansible-vault-password-helper ] || return
export ANSIBLE_VAULT_PASSWORD_FILE=~/bin/ansible-vault-password-helper

# https://docs.ansible.com/ansible/latest/reference_appendices/config.html#callbacks-enabled
export ANSIBLE_CALLBACKS_ENABLED=profile_tasks

# https://docs.ansible.com/ansible/latest/reference_appendices/config.html#ansible-pipelining
export ANSIBLE_PIPELINING=True

# https://docs.ansible.com/ansible/latest/reference_appendices/config.html#default-stdout-callback
export ANSIBLE_STDOUT_CALLBACK=yaml

# https://docs.ansible.com/ansible/latest/reference_appendices/config.html#default-strategy
export ANSIBLE_STRATEGY=free
