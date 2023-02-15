# https://jdhao.github.io/2021/01/05/nvim_copy_from_remote_via_osc52/
osc52() {
  content=$1

  printf "\e]52;c;$(printf "%s" "$content" | base64)\a"
}
