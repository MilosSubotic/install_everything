#!/bin/bash

git config --global user.name "Milos Subotic"
git config --global user.email "milos.subotic.sm@gmail.com"
# To solve problem with unicode file names.
git config --global core.quotePath false
# To save Personal access tokens.
git config --global credential.helper cache

cat >> ~/.bashrc << 'EOF'
alias gsta='git status'
alias gcm='git commit -m'
alias gcam='git commit -a -m'
alias gad='git add'
alias gdiff='git diff'
function gl() {
	git log -1 --skip=`expr $1 - 1`
}
function glsha() {
	git log -1 --skip=`expr $1 - 1` --format="%H"
}
function gld() {
	git diff `glsha $1` `glsha $2` $3
}
EOF
