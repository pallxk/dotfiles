command -v couchbase-cli > /dev/null && return

alias couchbase-cli="docker run --network=host --rm -it couchbaseutils/couchbase-cli:v5.5.0"
