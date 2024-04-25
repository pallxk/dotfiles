[ -f ~/bin/ansible-vault-password-helper ] || return
export ANSIBLE_VAULT_PASSWORD_FILE=~/bin/ansible-vault-password-helper
export ANSIBLE_VAULT_IDENTITY_LIST=prod@~/bin/ansible-vault-password-helper-prod

# https://docs.ansible.com/ansible/latest/reference_appendices/config.html#callbacks-enabled
export ANSIBLE_CALLBACKS_ENABLED=profile_tasks

# https://docs.ansible.com/ansible/latest/reference_appendices/config.html#ansible-pipelining
export ANSIBLE_PIPELINING=True

# https://docs.ansible.com/ansible/latest/reference_appendices/config.html#default-stdout-callback
export ANSIBLE_STDOUT_CALLBACK=yaml

# https://docs.ansible.com/ansible/latest/reference_appendices/config.html#default-strategy
# Setting strategy to free will cause error for pause module:
# ERROR! The 'ansible.builtin.pause' module bypasses the host loop, which is currently not supported in the free strategy and would instead execute for every host in the inventory list.
#export ANSIBLE_STRATEGY=free
