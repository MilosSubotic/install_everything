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
function gl() {
	git log -1 --skip=`expr $1 - 1`
}
function glsha() {
	git log -1 --skip=`expr $1 - 1` --format="%H"
}
function gld() {
	git diff `glsha $1` `glsha $2` $3
}
function gdiff() {
	if (( $# == 0 ))
	then
		git diff
	else
		if (( $1 == 0 ))
		then
			SHA1="--"
		else
			SHA1=`glsha $1`
		fi
		
		if (( $# == 1 ))
		then
			git diff $SHA1
		else
			if (( $2 == 0 ))
			then
				SHA2="--"
			else
				SHA2=`glsha $2`
			fi
			
			if (( $# == 2 ))
			then
				git diff $SHA1 $SHA2
			else
				git diff $SHA1 $SHA2 "$3"
			fi
		fi
	fi
}
EOF
