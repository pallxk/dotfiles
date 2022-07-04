# Read as JSON lines
jl() {
  jq -C -s "$@" | less -R --quit-if-one-screen
}
