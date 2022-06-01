json2env() {
    for kv in $(jq -r 'to_entries|map("\(.key)=\(.value|tostring)")|.[]' "${1:--}"); do
        export $kv
    done
}
