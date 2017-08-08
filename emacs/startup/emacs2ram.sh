#!/usr/bin/env bash

if [[ -z "$1" ]]; then
    cat << EOF
Usage:
  emacs2ram start
  emacs2ram restore
EOF

    exit 1
fi

emacs_backup=Dropbox/emacs/spacemacs-develop.d
emacs_link=.emacs.d
emacs_volatile=/tmp/vfs/.emacs.d-$USER

spacemacs_backup=Dropbox/emacs/my-spacemacs-config.d
spacemacs_link=.spacemacs.d
spacemacs_volatile=/tmp/vfs/.spacemacs.d-$USER

if [[ "$1" == "start" ]]; then

    IFS=
    set -efu

    cd ~/

    # emacs

    if [[ ! -r $emacs_volatile ]]; then
        mkdir -m0700 $emacs_volatile
    fi

    # link -> volatie does not exist
    if [ "$(readlink $emacs_link)" != "$emacs_volatile" ]; then
        # create the link
        ln -s $emacs_volatile $emacs_link
    fi

    if [ -e $emacs_link/.unpacked ]; then
        echo "Sync .emacs.d from memory to backup ..."
        rsync -avq --delete --exclude .unpacked ./$emacs_link/ ./$emacs_backup/
        echo "DONE!"
    else
        echo "Sync .emacs.d from disk to memory ..."
        rsync -avq ./$emacs_backup/ ./$emacs_link/
        touch $emacs_link/.unpacked
        echo "DONE!"
    fi

    # spacemacs
    
    if [[ ! -r $spacemacs_volatile ]]; then
        mkdir -m0700 $spacemacs_volatile
    fi

    if [ "$(readlink $spacemacs_link)" != "$spacemacs_volatile" ]; then
        # create the link
        ln -s $spacemacs_volatile $spacemacs_link
    fi

    if [ -e $spacemacs_link/.unpacked ]; then
        echo "Sync .spacemacs.d from memory to backup ..."
        rsync -avq --delete --exclude .unpacked ./$spacemacs_link/ ./$spacemacs_backup/
        echo "DONE!"
    else
        echo "Sync .spacemacs.d from disk to memory ..."
        rsync -avq ./$spacemacs_backup/ ./$spacemacs_link/
        touch $spacemacs_link/.unpacked
        echo "DONE!"
    fi
else
    echo "Restore ..."

    cd ~/

    rm $emacs_link
    rm -rf $emacs_volatile

    rm $spacemacs_link
    rm -rf $spacemacs_volatile

    echo "DONE!"
fi
