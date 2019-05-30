# Possible locations of git-prompt.sh
GIT_PROMPT_SH_PATH=(
	/usr/share/git/git-prompt.sh
	/usr/share/git/completion/git-prompt.sh
	/usr/share/git-core/contrib/completion/git-prompt.sh
)
for GIT_PROMPT_SH in "${GIT_PROMPT_SH_PATH[@]}"; do
	[ -f "$GIT_PROMPT_SH" ] && git_prompt_sh=$GIT_PROMPT_SH
done

[ "$git_prompt_sh" ] || return

. "$git_prompt_sh"

GIT_PS1_SHOWDIRTYSTATE=1
GIT_PS1_SHOWSTASHSTATE=1
GIT_PS1_SHOWUNTRACKEDFILES=1
GIT_PS1_SHOWUPSTREAM=verbose
GIT_PS1_DESCRIBESTYLE=default
GIT_PS1_SHOWCOLORHINTS=1

LF=$'\n'
my_git_prompt='PS1="$(__git_ps1 "\e[36m$LF[%s]\e[0m") $PS1"'
if [ -z "$PROMPT_COMMAND" ]; then
	PROMPT_COMMAND=$my_git_prompt
else
	PROMPT_COMMAND="$PROMPT_COMMAND; $my_git_prompt"
fi
unset my_git_prompt
