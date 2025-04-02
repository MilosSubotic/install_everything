#!/bin/bash
###############################################################################

sudo apt -y install git

./setup_git_stuff.sh

#sudo apt -y install libsecret-1-0 libsecret-1-dev
#sudo make --directory=/usr/share/doc/git/contrib/credential/libsecret
#git config --global credential.helper /usr/share/doc/git/contrib/credential/libsecret/git-credential-libsecret
git config --global credential.helper cache

###############################################################################
