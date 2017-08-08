#!/usr/bin/env bash
##########################################################################
# install emacs config automatically.
# by Apple Shan (apple.shan@gmail.com)
##########################################################################

# clone syl20bnr/spacemacs repo
git clone https://github.com/syl20bnr/spacemacs.git ~/Dropbox/projects/spacemacs-master.d
rm ~/.emacs.d && ln -s ~/Dropbox/projects/spacemacs-master.d ~/.emacs.d

# clone appleshan/spacemacs repo
git clone -b develop https://github.com/syl20bnr/spacemacs.git ~/Dropbox/projects/spacemacs-develop.d
rm ~/.emacs.d && ln -s ~/Dropbox/projects/spacemacs-develop.d ~/.emacs.d

# clone appleshan/my-spacemacs-config repo
git clone https://github.com/appleshan/my-spacemacs-config.git ~/Dropbox/projects/my-spacemacs-config.d
rm ~/.spacemacs.d && ln -s ~/Dropbox/projects/my-spacemacs-config.d ~/.spacemacs.d

