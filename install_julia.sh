#!/bin/bash

V1=1
V2=10
V3=4
A=x86_64
F=julia-$V1.$V2.$V3-linux-$A.tar.gz
if [ "$A" == "x86_64" ]
then
	A2="x64"
else
	A2="x86"
fi
wget https://julialang-s3.julialang.org/bin/linux/$A2/$V1.$V2/$F

mkdir -p ~/.local/opt/julia/$A

tar xfv $F -C ~/.local/opt/julia/$A

mkdir -p ~/.local/bin/
pushd ~/.local/bin/
J=julia-${A}-$V1.$V2.$V3
ln -sf ../opt/julia/$A/julia-$V1.$V2.$V3/bin/julia $J
ln -sf $J julia
popd

rm -rf $F

F=~/.julia/config/startup.jl
mkdir -p $(dirname $F)
if test -f $F
then
	cp $F $F.backup-$(date +%F-%T | sed 's/:/-/g')
fi
cat > $F << EOF
push!(LOAD_PATH, ".")
ENV["JULIA_EDITOR"] = "code"
EOF


