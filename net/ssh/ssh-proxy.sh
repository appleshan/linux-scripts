#!/bin/bash

# @see https://wdicc.com/best-way-to-fuck-gfw/

#     翻墙有不少方法，比如通过找公共的 vpn，用 tor，找一些 phpproxy 网站等。我这推荐一个比较好的方法，通过 fuckgfw 提供的
# ssh proxy，速度比 tor 快的不是一点半点。
#     我用的 linux，写了一个 expect 脚本来起代理服务，如下。里面的 USER 和 PWD 换成你申请到的用户名和密码。我把这个脚本命名
# 叫 p, 放到了 ~/bin 下面，当然我的 ~/bin 是在 path 里面的，这样，执行一个 p 命令代理就自动起来了。用完的时候可以
# 按 Ctrl-c 退出。

expect -c '
spawn ssh -D 7070 -N USER@SERVER
expect {
	password { 
		send "PWD\r";
	}
}

interact {
	\001 exit;
}'
