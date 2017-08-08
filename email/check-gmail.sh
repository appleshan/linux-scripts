#!/usr/bin/env bash
# @see http://mingxinglai.com/cn/2012/12/fetch-mail-in-terminal/

curl -u Email:Password --silent "https://mail.google.com/mail/feed/atom" |
    awk 'BEGIN{flag=0}
/<entry>/{flag=1;}
flag==1{print}
/<\/entry>/{flag=0;print ""
}' |
    awk 'BEGIN{RS=""; FS="\n"}
{
  print  "邮件：" NR;
  print "主题：" $2;
  print "发件人："$9;
  print "发件人邮箱："$10;
  print ""
}' |
    sed 's/<\/.*>//g' | sed 's/<.*>//g'
