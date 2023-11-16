#!/bin/bash

V1=1
V2=6
V3=7
B=64
A=x86_64
F=julia-$V1.$V2.$V3-linux-$A.tar.gz
wget https://julialang-s3.julialang.org/bin/linux/x86/$V1.$V2/$F

mkdir -p ~/.local/opt/julia/$B

tar xfv $F -C ~/.local/opt/julia/$B

mkdir -p ~/.local/bin/
pushd ~/.local/bin/
ln -sf ../opt/julia/$A/julia-$V1.$V2.$V3/bin/julia julia$B$V1$V2$V3
ln -sf julia$B$V1$V2$V3 julia
popd

F=~/.julia/config/startup.jl
mkdir -p $(dirname $F)
if test -f $F
then
	cp $F $F.backup-$(date +%F-%T | sed 's/:/-/g')
fi
cat > $F << EOF
push!(LOAD_PATH, ".")
EOF


