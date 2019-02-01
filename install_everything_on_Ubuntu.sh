#!/bin/bash
###############################################################################

mkdir tmp/
pushd tmp/

sudo ls

###############################################################################
# Global stuff.

sudo apt-get update
sudo apt-get upgrade

mkdir -p ~/local/
mkdir -p ~/bin/

###############################################################################
# Git.

git config --global user.name "Milos Subotic"
git config --global user.email "milos.subotic.sm@gmail.com"


###############################################################################
# Julia.

wget https://julialang-s3.julialang.org/bin/linux/x64/0.6/julia-0.6.4-linux-x86_64.tar.gz
wget https://julialang-s3.julialang.org/bin/linux/x64/1.0/julia-1.0.3-linux-x86_64.tar.gz

mkdir -p ~/local/julia

tar xfv julia-0.6.4-linux-x86_64.tar.gz -C ~/local/julia
tar xfv julia-1.0.3-linux-x86_64.tar.gz -C ~/local/julia

pushd ~/local/julia/
mv julia-9d11f62bcb/ julia-0.6.4/
popd

pushd ~/bin/
ln -s ../local/julia/julia-0.6.4/bin/julia julia064
ln -s ../local/julia/julia-1.0.3/bin/julia julia103
ln -s julia103 julia
popd

F=~/.juliarc.jl
mkdir -p $(dirname $F)
cp $F $F.backup-$(date +%F-%T | sed 's/:/-/g')
cat > $F << EOF
push!(LOAD_PATH, ".")

#if VERSION >= v"0.7"
#    using Pkg
#end
#for pkg in ["Revise"]
#    if !haskey(Pkg.installed(), pkg)
#        Pkg.add(pkg)
#    end
#end
#
#using Revise
EOF

F=~/.julia/config/startup.jl
mkdir -p $(dirname $F)
cp $F $F.backup-$(date +%F-%T | sed 's/:/-/g')
cat > $F << EOF
push!(LOAD_PATH, ".")

using Pkg
for pkg in ["Revise"]
    if !haskey(Pkg.installed(), pkg)
        Pkg.add(pkg)
    end
end

using Revise
EOF

###############################################################################
# Worker.

git clone https://github.com/MilosSubotic/worker_install
pushd worker_install/
./install_worker.sh
popd

###############################################################################
# Atom.

wget https://atom.io/download/deb -O atom-amd64.deb
sudo dpkg -i atom-amd64.deb

#curl -sL https://packagecloud.io/AtomEditor/atom/gpgkey | sudo apt-key add -
#sudo sh -c 'echo "deb [arch=amd64]
#sudo sh -c 'echo "deb [arch=amd64] https://packagecloud.io/AtomEditor/atom/any/ any main" > /etc/apt/sources.list.d/atom.list'
#sudo apt-get update
#sudo apt-get install atom

###############################################################################
# Beyond Compare.

wget https://www.scootersoftware.com/bcompare-4.2.8.23479_amd64.deb
sudo dpkg -i bcompare-4.2.8.23479_amd64.deb

###############################################################################

popd
rm -rf tmp/

echo "End"

###############################################################################
