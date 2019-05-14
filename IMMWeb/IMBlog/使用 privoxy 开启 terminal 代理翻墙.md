# 使用 privoxy 开启 terminal 代理 翻墙


## 查看 IP

 不需要借助其他工具
 $ ifconfig
 $ ifconfig en0

## 使用 privoxy 配置

通过 brew install privoxy
在使用 privoxy 来修改监听端口号.
配置开关 缩写,即可快速启动

alias proxy='export all_proxy=socks5://127.0.0.1:1080'
alias unproxy='unset all_proxy'

source ~/.zshrc

➜  ~ curl ip.cn
当前 IP：112.64.xxx.xx 来自：上海市 联通

~ curl cip.cc
IP	: 140.206.97.42
地址	: 中国  上海

cr数据二	: 上海市 | 联通

URL	: http://www.cip.cc/140.206.97.42


## ping 原理

参考 : [Mac OSX终端走shadowsocks代理 ](https://github.com/mrdulin/blog/issues/18)
[Mac命令行终端下使用shadowsocks翻墙](http://www.cashqian.net/blog/001486989831982332565298e4942a2bb8f56b08f9d2475000)
 
[ping](https://stackoverflow.com/questions/5274934/use-ping-through-socks-server)

