# https://gist.github.com/egmontkob/eb114294efbcd5adb1944c9f3cb5feda
osc8() {
  link=${1:-https://www.google.com/}
  title=${2:-Click to open link}

  printf '\e]8;;'"$link"'\e\\'"$title"'\e]8;;\e\\\n'
}
