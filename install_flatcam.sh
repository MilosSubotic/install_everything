#!/bin/bash -e


D=`dirname "${BASH_SOURCE[0]}"`
D="`cd "$D/" 2>&1 > /dev/null && pwd`"

P=$D/freecam_vispy.patch

mkdir -p ~/.local/opt/
pushd ~/.local/opt/
git clone https://bitbucket.org/jpcgt/flatcam
git checkout origin/Beta
bash setup_ubuntu.sh
patch -p1 < $P
popd

# Need shapely 1.7.0, bcs 2.0.1 does not work.
# On Ubuntu 22 will install shapely 1.8.0 which is good
sudo apt -y install python3-shapely
# Or do it with pip:
#pip3 install shapely==1.8.0


mkdir -p ~/.local/bin/
pushd ~/.local/bin/

cat > flatcam << EOF
#!/bin/bash
python3 ~/.local/opt/flatcam/FlatCAM.py
EOF
chmod a+x flatcam
popd