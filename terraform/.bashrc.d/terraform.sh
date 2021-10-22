if [ -f /usr/bin/terraform ]; then
	complete -C /usr/bin/terraform terraform
	complete -C /usr/bin/terraform tf
fi
