alias dr='docker run --rm -it -v "$PWD":/mnt:ro'
alias drsh='docker run --rm -it -v "$PWD":/mnt:ro --entrypoint sh'
alias drbash='docker run --rm -it -v "$PWD":/mnt:ro --entrypoint bash'

dsh() {
    docker exec -it "$@" sh
}

dbash() {
    docker exec -it "$@" bash
}
