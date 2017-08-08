#!/usr/bin/env bash
##########################################################################
# install emacs 25 automatically.
##########################################################################

wget -v http://ftp.gnu.org/gnu/emacs/emacs-25.1.tar.xz

# unzip
xz -d emacs-25.1.tar.xz
tar -xvf emacs-25.1.tar

cd emacs-25.1/

# install depends
sudo aptitude install -y build-essential
sudo aptitude install \
libgtk-3-dev \
libxpm-dev libjpeg-dev libgif-dev libtiff-dev \
libtinfo-dev libncurses-dev

# configure: error: xwidgets requested but WebKitGTK+ not found
sudo aptitude install libwebkitgtk-dev
sudo aptitude install libwebkitgtk-3.0-dev

./autogen.sh
# ./configure --help
./configure CFLAGS=-no-pie --prefix=/opt/emacs-25.1 --with-x-toolkit=gtk3 --with-modules #--with-xwidgets
make -j 4
sudo make install

# open emacs
# M-x xwidget-webkit-browse-url
