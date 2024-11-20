if ! which ipinfo &> /dev/null; then
  ipinfo() {
    curl -s "https://ipinfo.io/$1"
  }
fi

diginfo() {
  dig +short "$@" |
    tee >(ipinfo "$(tail -1)")
}
