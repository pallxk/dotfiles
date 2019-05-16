[ -f /usr/share/git-core/contrib/completion/git-prompt.sh ] || return

. /usr/share/git-core/contrib/completion/git-prompt.sh

GIT_PS1_SHOWDIRTYSTATE=1
GIT_PS1_SHOWSTASHSTATE=1
GIT_PS1_SHOWUNTRACKEDFILES=1
GIT_PS1_SHOWUPSTREAM=verbose
GIT_PS1_DESCRIBESTYLE=default
GIT_PS1_SHOWCOLORHINTS=1

LF=$'\n'
my_git_prompt='PS1="$(__git_ps1 "$LF[%s]") $PS1"'
if [ -z "$PROMPT_COMMAND" ]; then
	PROMPT_COMMAND=$my_git_prompt
else
	PROMPT_COMMAND="$PROMPT_COMMAND; $my_git_prompt"
fi
unset my_git_prompt
