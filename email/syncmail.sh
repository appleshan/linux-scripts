#!/bin/bash

# crontab -e
# */10 * * * * /usr/local/bin/syncmail.sh
# 每隔10分钟,系统会同步一次我的邮箱

PID=$(pgrep offlineimap)
[[ -n "$PID" ]] && kill $PID
offlineimap -o -u quiet -c ~/.mutt/.offlineimaprc &>/dev/null &
exit 0
