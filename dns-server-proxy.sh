#!/usr/bin/env bash

alias sudo="echo lisp007tw | sudo -S"

# dnscrypt-proxy
# 将端口从默认的53改为18053（或其他端口），为的是给 dnsmasq 让路。
# 加上--daemonize选项则将作为守护进程在后台运行。

# 208.67.220.220:443
sudo /opt/net/dnscrypt-proxy/sbin/dnscrypt-proxy \
     --local-address=127.0.0.1:18053 \
     --edns-payload-size=4096 \
     --user=dnscrypt \
     --resolver-address=208.67.220.220 \
     --provider-name=2.dnscrypt-cert.opendns.com \
     --provider-key=B735:1140:206F:225D:3E2B:D822:D7FD:691E:A1C3:3CC8:D666:8D0C:BE04:BFAB:CA43:FB79 \
     --daemonize

# 23.226.227.93:443
# sudo /opt/net/dnscrypt-proxy/sbin/dnscrypt-proxy \
#      --local-address=127.0.0.1:18053 \
#      --edns-payload-size=4096 \
#      --user=dnscrypt \
#      --resolver-address=23.226.227.93:443 \
#      --provider-name=2.dnscrypt-cert.okturtles.com \
#      --provider-key=1D85:3953:E34F:AFD0:05F9:4C6F:D1CC:E635:D411:9904:0D48:D19A:5D35:0B6A:7C81:73CB \
#      --daemonize

# dnsmasq
sudo /usr/local/sbin/dnsmasq
