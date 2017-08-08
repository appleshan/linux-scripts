#!/bin/bash

# 一般主机商在发布产品的时候一定会告知是openvz还是kvm还是xen或者是vmare，
# 如果你确实没注意，又不确定是什么类型的虚拟化技术的话，那就可以通过下面这个命令
# 来检测。

# wget -N --no-check-certificate https://raw.githubusercontent.com/91yun/code/master/vm_check.sh && bash vm_check.sh

# 代码运行结束就会在最后一行显示虚拟化技术：kvm还是openv或者是xen一目了然。

PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin
export PATH
yum install -y gcc gcc-c++ gdb
wget http://people.redhat.com/~rjones/virt-what/files/virt-what-1.12.tar.gz
tar zxvf virt-what-1.12.tar.gz
cd virt-what-1.12/
./configure
make && make install
virt-what
