[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

# https://stackoverflow.com/questions/76922732/error-installing-ruby-with-rvm-rvm-make-j8
rvm-preinstall() {
  export CONFIGURE_ARGS=""
  for ext in openssl readline libyaml zlib; do
    CONFIGURE_ARGS="${CONFIGURE_ARGS} --with-$ext-dir=$(brew --prefix $ext)"
  done
}
