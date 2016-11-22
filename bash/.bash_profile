# ~/.bash_profile

# User wide environment and startup programs, for login setup
# Functions and aliases go in ~/.bashrc

pathmunge () {
    case ":${PATH}:" in
        *:"$1":*)
            ;;
        *)
            if [ "$2" = "after" ] ; then
                PATH=$PATH:$1
            else
                PATH=$1:$PATH
            fi
    esac
}

# Set umask if not set
[ `umask` = 0000 ] && umask 022

# include ruby bin directories in PATH
for dir in ~/.gem/ruby/*/bin; do
	test -d "$dir" && pathmunge "$dir"
done
unset dir

# set PATH so it includes user's private bin if it exists
[[ -d ~/bin ]] && pathmunge ~/bin
[[ -d ~/bin/after ]] && pathmunge ~/bin/after after

# Include Windows PATH if running under WSL
# (This is appended by default from Windows 10 Build 14965 on)
if grep -qsi Microsoft /proc/sys/kernel/osrelease; then
	pathmunge /mnt/c/Windows/System32 after
	pathmunge /mnt/c/Windows after
fi

# include .bashrc if it exists
[[ -f ~/.bashrc ]] && . ~/.bashrc

unset -f pathmunge
