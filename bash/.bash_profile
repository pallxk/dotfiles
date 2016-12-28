# ~/.bash_profile

# User wide environment and startup programs, for login setup
# Functions and aliases go in ~/.bashrc

# SYNOPSIS:
#   pathmunge [path_variable] path [after]
# EXAMPLES:
#   pathmunge ~/bin
#   pathmunge ~/bin/after after
#   pathmunge MANPATH ~/man
#   pathmunge INFOPATH ~/info after
pathmunge () {
    # The path variable (which is ended with PATH, case-sensitive) to be munged
    # (defaults to PATH)
    local pathvar
    if [[ $1 = *PATH ]]; then
        pathvar="$1"
        shift
    else
        pathvar=PATH
    fi

    # Munge the path variable
    case ":${!pathvar}:" in
        *:"$1":*)
            ;;
        *)
            if [ "$2" = "after" ] ; then
                # `eval` is required here, otherwise the assignment as a whole
                # is seen as a command.
                eval ${pathvar}='${!pathvar}:$1'
            else
                eval ${pathvar}='$1:${!pathvar}'
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

# Add RVM to PATH for scripting
[[ -d ~/.rvm/bin ]] && pathmunge ~/.rvm/bin after

# set PATH so it includes user's private bin if it exists
[[ -d ~/bin ]] && pathmunge ~/bin
[[ -d ~/bin/after ]] && pathmunge ~/bin/after after

# include .bashrc if it exists
[[ -f ~/.bashrc ]] && . ~/.bashrc

unset -f pathmunge
