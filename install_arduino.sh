#!/bin/bash

VER=1.8.12
wget https://downloads.arduino.cc/arduino-$VER-linux64.tar.xz
mkdir -p ~/.local/opt/arduino/
tar xfv *.tar.xz -C ~/.local/opt/arduino
rm *.tar.xz
pushd ~/.local/opt/arduino/arduino-$VER/
sudo ./install.sh
popd

F="$HOME/.arduino15/preferences.txt"
sed -i 's/editor.tabs.expand=true/editor.tabs.expand=false/g' "$F"
sed -i 's/editor.tabs.size=2/editor.tabs.size=4/g' "$F"
