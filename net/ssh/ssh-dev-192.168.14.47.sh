#!/usr/bin/expect
 
spawn ssh appuser@192.168.14.47
expect "password"
send "daan@2015\r"
interact
