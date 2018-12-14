#!/bin/bash
###############################################################################

mkdir tmp/
pushd tmp/


###############################################################################
# Global stuff.

mkdir ~/local/
mkdir ~/bin/


###############################################################################
# Git.

git config --global user.name "Milos Subotic"
git config --global user.email "milos.subotic.sm@gmail.com"


###############################################################################
# Installing julia.

wget https://julialang-s3.julialang.org/bin/linux/x64/0.6/julia-0.6.4-linux-x86_64.tar.gz
wget https://julialang-s3.julialang.org/bin/linux/x64/1.0/julia-1.0.2-linux-x86_64.tar.gz

mkdir ~/local/julia

tar xfv julia-0.6.4-linux-x86_64.tar.gz -C ~/local/julia
tar xfv julia-1.0.2-linux-x86_64.tar.gz -C ~/local/julia

pushd ~/local/julia/
mv julia-9d11f62bcb/ julia-0.6.4/
popd

pushd ~/bin/
ln -s ../local/julia/julia-0.6.4/bin/julia julia064
ln -s ../local/julia/julia-1.0.2/bin/julia julia102
ln -s julia102 julia
popd

###############################################################################

popd
rm -rf tmp/

echo "End"

###############################################################################

