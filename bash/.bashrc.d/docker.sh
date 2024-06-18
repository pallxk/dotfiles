alias d=docker
alias dr='docker run --rm --init -it -v "$PWD":/mnt:ro'
alias drsh='docker run --rm -it -v "$PWD":/mnt:ro --entrypoint sh'
alias drbash='docker run --rm -it -v "$PWD":/mnt:ro --entrypoint bash'

dx() {
    docker exec -it "$@"
}

dsh() {
    docker exec -it "$@" sh
}

dbash() {
    docker exec -it "$@" bash
}

dgrep() {
    docker ps | grep "$@"
}

dagrep() {
    docker ps -a | grep "$@"
}

dkill() {
    id=$(docker ps -a | grep "$@" | cut -d\  -f1)
    docker kill $id
}
