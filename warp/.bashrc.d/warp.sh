type -a warp-cli >& /dev/null || return

. <(warp-cli generate-completions bash 2>/dev/null)
