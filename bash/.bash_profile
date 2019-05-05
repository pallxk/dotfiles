# ~/.bash_profile

# User wide environment and startup programs, for login setup
# Functions and aliases go in ~/.bashrc


# Load profile from ".bash_profile.d" and ".bash_profile.d/after"
for profile in ~/.bash_profile.d/{,after}/*.{sh,bash}; do
	test -r "$profile" && . "$profile"
done
unset profile


# Set umask if not set
[ `umask` = 0000 ] && umask 022
