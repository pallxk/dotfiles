if hash aliyun 2> /dev/null; then
  alias ali=aliyun
  complete -C "$(which aliyun)" aliyun
  complete -C "$(which aliyun)" ali
fi
