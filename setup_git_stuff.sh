#!/bin/bash

git config --global user.name "Milos Subotic"
git config --global user.email "milos.subotic.sm@gmail.com"
# To solve problem with unicode file names.
git config --global core.quotePath false

cat >> ~/.bashrc << EOF
alias gsta='git status'
alias gcm='git commit -m'
alias gcam='git commit -a -m'
alias gad='git add'
function gl() {
	git log -1 --skip=`expr $1 - 1`
}
function glsha() {
	git log -1 --skip=`expr $1 - 1` --format="%H"
}
EOF
