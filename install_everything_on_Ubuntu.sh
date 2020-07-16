#!/bin/bash
###############################################################################
# Just to obtain sudo rights.

sudo ls

###############################################################################
# Global stuff.

sudo apt-get -y update
sudo apt-get -y upgrade

mkdir -p ~/local/
mkdir -p ~/bin/

###############################################################################
# Git.

./setup_git_stuff.sh

###############################################################################
# Worker.

pushd worker_install/
./install_worker.sh
popd

###############################################################################
# Doing all package downloading and unpacking in tmp dir.

mkdir tmp/
pushd tmp/

###############################################################################
# Julia.

wget https://julialang-s3.julialang.org/bin/linux/x64/0.6/julia-0.6.4-linux-x86_64.tar.gz
wget https://julialang-s3.julialang.org/bin/linux/x64/1.0/julia-1.0.3-linux-x86_64.tar.gz
wget https://julialang-s3.julialang.org/bin/linux/x64/1.0/julia-1.0.5-linux-x86_64.tar.gz

mkdir -p ~/local/julia

tar xfv julia-0.6.4-linux-x86_64.tar.gz -C ~/local/julia
tar xfv julia-1.0.3-linux-x86_64.tar.gz -C ~/local/julia
tar xfv julia-1.0.5-linux-x86_64.tar.gz -C ~/local/julia

pushd ~/local/julia/
mv julia-9d11f62bcb/ julia-0.6.4/
popd

pushd ~/bin/
ln -sf ../local/julia/julia-0.6.4/bin/julia julia064
ln -sf ../local/julia/julia-1.0.3/bin/julia julia103
ln -sf ../local/julia/julia-1.0.5/bin/julia julia105lts
ln -sf julia105lts julia
popd

F=~/.juliarc.jl
mkdir -p $(dirname $F)
if test -f $F
then
	cp $F $F.backup-$(date +%F-%T | sed 's/:/-/g')
fi
cat > $F << EOF
push!(LOAD_PATH, ".")
EOF

F=~/.julia/config/startup.jl
mkdir -p $(dirname $F)
if test -f $F
then
	cp $F $F.backup-$(date +%F-%T | sed 's/:/-/g')
fi
cat > $F << EOF
push!(LOAD_PATH, ".")
EOF

###############################################################################
# Atom.

wget https://atom.io/download/deb -O atom-amd64.deb
sudo dpkg -i atom-amd64.deb

#curl -sL https://packagecloud.io/AtomEditor/atom/gpgkey | sudo apt-key add -
#sudo sh -c 'echo "deb [arch=amd64]
#sudo sh -c 'echo "deb [arch=amd64] https://packagecloud.io/AtomEditor/atom/any/ any main" > /etc/apt/sources.list.d/atom.list'
#sudo apt-get update
#sudo apt-get install atom

# Install settings.
cp -rv .atom/ ~/

# Install packages.
apm install language-julia
apm install language-matlab linter-matlab
apm install graphviz-preview-plus language-dot
apm install latex latexer language-latex latex-autocomplete
apm install language-markdown
apm install language-vhdl language-verilog language-tcl
apm install teletype file-watcher

###############################################################################
# Beyond Compare.

wget https://www.scootersoftware.com/bcompare-4.2.8.23479_amd64.deb
sudo dpkg -i bcompare-4.2.8.23479_amd64.deb

###############################################################################

popd
rm -rf tmp/

echo "End"

###############################################################################
