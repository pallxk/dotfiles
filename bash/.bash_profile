# ~/.bash_profile

# User wide environment and startup programs, for login setup
# Functions and aliases go in ~/.bashrc


# Load profile from .bash_profile.d
if test -d ~/.bash_profile.d/; then
	for profile in ~/.bash_profile.d/*.{sh,bash}; do
		test -r "$profile" && . "$profile"
	done
	unset profile
fi
# Load profile from .bash_profile.d/after
if test -d ~/.bash_profile.d/after/; then
	for profile in ~/.bash_profile.d/after/*.{sh,bash}; do
		test -r "$profile" && . "$profile"
	done
	unset profile
fi


# Set umask if not set
[ `umask` = 0000 ] && umask 022
