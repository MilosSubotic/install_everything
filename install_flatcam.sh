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


mkdir -p ~/.local/bin/
pushd ~/.local/bin/

cat > flatcam << EOF
#!/bin/bash
python3 ~/.local/opt/flatcam/FlatCAM.py
EOF
chmod a+x flatcam
popd