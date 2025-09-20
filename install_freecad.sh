#!/bin/bash

#sudo -E add-apt-repository -y ppa:freecad-maintainers/freecad-stable
#sudo apt update
#sudo apt install -y freecad openscad1

V=1.0.2

wget https://github.com/FreeCAD/FreeCAD/releases/download/${V}/FreeCAD_${V}-conda-Linux-x86_64-py311.AppImage

mkdir -p ~/.local/opt/FreeCAD
chmod a+x FreeCAD_${V}-*.AppImage
mv FreeCAD_${V}*.AppImage ~/.local/opt/FreeCAD/
ln -sf ~/.local/opt/FreeCAD/FreeCAD_${V}*.AppImage ~/.local/bin/freecad
