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

dl() {
    less_arg=
    for arg in "$@"; do
        if [ "$arg" = "-f" ] || [ "$arg" = "--follow" ]; then
            less_arg=+F
        fi
    done
    docker logs "$@" |& less -R $less_arg
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

sdcp() {
    target=${!#}
    host=${target%%:*}
    container_path=${target#*:}

    for f in "${@:1:$#-1}"; do
        echo "$f -> $host:$container_path"
        command ssh "$host" "docker cp - $container_path" <"$f"
    done
}
