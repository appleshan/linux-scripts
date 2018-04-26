#!/bin/bash

install_path="$ZSH_CUSTOM/themes/spaceship-prompt"

[[ ! -d $install_path ]] && {
	git clone https://github.com/denysdovhan/spaceship-prompt.git $install_path
} || {
	cd $install_path
	git pull origin master
}
