alias d=docker
alias dr='docker run --rm --init -it -v "$PWD":/mnt:ro'
alias drw='docker run --rm --init -it -v "$PWD":/mnt'

dx() {
    docker exec -it "$@"
}

sdx() {
    command ssh -t "$1" docker exec -it "${@:2}"
}

dsh() {
    local now=$SECONDS
    if ! docker exec -it "$@" bash; then
        if [ $((SECONDS - now)) -le 2 ]; then
            docker exec -it "$@" sh
        fi
    fi
}

sdsh() {
    local now=$SECONDS
    if ! command ssh -t "$1" docker exec -it "${@:2}" bash; then
        if [ $((SECONDS - now)) -le 2 ]; then
            command ssh -t "$1" docker exec -it "${@:2}" sh
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

sdl() {
    less_arg=
    for arg in "$@"; do
        if [ "$arg" = "-f" ] || [ "$arg" = "--follow" ]; then
            less_arg=+F
        fi
    done
    command ssh -t "$1" docker logs "${@:2}" |& less -R $less_arg
}

dgrep() {
    docker ps | grep "$@"
}

sdgrep() {
    command ssh "$1" docker ps | grep "${@:2}"
}

dagrep() {
    docker ps -a | grep "$@"
}

sdagrep() {
    command ssh "$1" docker ps -a | grep "${@:2}"
}

dkill() {
    id=$(docker ps -a | grep "$@" | tee /dev/stderr | cut -d\  -f1)
    docker kill $id
}

sdkill() {
    id=$(command ssh "$1" docker ps -a | grep "${@:2}" | tee /dev/stderr | cut -d\  -f1)
    command ssh "$1" docker kill $id
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
