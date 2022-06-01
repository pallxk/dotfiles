yaml2env() {
    for kv in $(yq -r 'to_entries|map("\(.key)=\(.value|tostring)")|.[]' "${1:--}"); do
        export $kv
    done
}
