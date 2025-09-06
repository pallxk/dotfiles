ali-instance-cli() {
  if which ali-instance-cli >/dev/null; then
    command ali-instance-cli "$@"
  else
    if [ "$(uname -s)" = Darwin ]; then
      url="https://aliyun-client-assist.oss-accelerate.aliyuncs.com/session-manager/mac/ali-instance-cli"
    elif [ "$(uname -m)" = arm64 ]; then
      url="https://aliyun-client-assist.oss-cn-beijing.aliyuncs.com/session-manager/linux_arm/ali-instance-cli"
    else
      url="https://aliyun-client-assist.oss-accelerate.aliyuncs.com/session-manager/linux/ali-instance-cli"
    fi

    mkdir -p ~/bin
    curl -sS -o ~/bin/ali-instance-cli "$url"
    chmod +x ~/bin/ali-instance-cli
    ali-instance-cli "$@"
  fi
}
