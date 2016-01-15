# Make passed in arguments or stdin the title of current term
title () {
	if [ $# -gt 0 ]; then
		# Make passed in arguments the title
		echo -ne "\e]0;$@\a"
	else
		# Make stdin the title
		while read; do
			echo -ne "\e]0;$REPLY\a"
		done
	fi
}
