#!/bin/bash

set -e

readonly version="26.0.91" # "25.3" # "25.2" # "25.1"
#version_postfix="-rc2" # ".90"
#patch_version=25.2-rc1-mac-6.2

source_url=ftp://alpha.gnu.org/gnu/emacs/pretest
#source_url=https://mirrors.tuna.tsinghua.edu.cn/gnu/emacs

echo "=================================================="
echo "Build latest version of Emacs, version management with stow"
echo "OS: Manjaro Linux 17.1.7"
echo "version: $version"
read -p "Press enter to continue"

install_prefix=/opt/stow/emacs-"$version"
if [ -d $install_prefix ]; then
    echo "target directory $install_prefix exists, exit."
    exit
fi
mkdir -p $install_prefix

# install dependencies
# pacman -S autoconf automake stow webkitgtk


# download source package
echo "=================================================="
echo "= Download source package :"
read -p "Press enter to continue"

source_prefix=/usr/local/src/emacs-"$version"

cd /usr/local/src
if [[ ! -d emacs-"$version" ]]; then
    echo "download emacs-$version:"
    wget $source_url/emacs-"$version".tar.xz
    tar xvf emacs-"$version".tar.xz
    read -p "Press enter to continue"
else
    echo "source directory $source_prefix exists, skip download source package."
fi

# build and install
echo "=================================================="
echo "= Build :"
read -p "Press enter to continue"

cd emacs-"$version"
mkdir -vp $install_prefix/{bin/,libexec/,share/,var/}

./autogen.sh
./configure \
    --prefix=$install_prefix \
    --bindir=$install_prefix/bin \
    --libexecdir=$install_prefix/libexec \
    --localstatedir=$install_prefix/var \
    --datarootdir=$install_prefix/share \
	--with-imagemagick \
	--with-modules
	# --with-xwidgets

read -p "Press enter to continue"

make -j4
read -p "Press enter to continue"

echo "=================================================="
echo "= Install :"
read -p "Press enter to continue"

make install
# strip $install_prefix/bin/emacs-"$version"


echo "=================================================="
echo "= Version management with stow :"
read -p "Press enter to continue"

echo "stow emacs..."
cd /opt/stow/emacs-"$version"
stow -d /opt/stow/emacs-"$version" -t /usr/local/bin bin

cd /usr/local/src
rm -rf emacs-"$version"

echo "=================================================="
echo "= Done! Find your Emacs at $installprefix."
echo "=================================================="
