alias d=docker
alias dr='docker run --rm --init -it -v "$PWD":/mnt:ro'
alias drw='docker run --rm --init -it -v "$PWD":/mnt'

dx() {
    docker exec -it "$@"
}

dsh() {
    local now=$SECONDS
    if ! docker exec -it "$@" bash; then
        if [ $((SECONDS - now)) -le 2 ]; then
            docker exec -it "$@" sh
        fi
    fi
}

drsh() {
    local now=$SECONDS
    if ! docker run --rm -it -v "$PWD":/mnt:ro --entrypoint bash "$@"; then
        if [ $((SECONDS - now)) -le 2 ]; then
            docker run --rm -it -v "$PWD":/mnt:ro --entrypoint sh "$@"
        fi
    fi
}

drwsh() {
    local now=$SECONDS
    if ! docker run --rm -it -v "$PWD":/mnt --entrypoint bash "$@"; then
        if [ $((SECONDS - now)) -le 2 ]; then
            docker run --rm -it -v "$PWD":/mnt --entrypoint sh "$@"
        fi
    fi
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
