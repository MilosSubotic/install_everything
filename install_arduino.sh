#!/bin/bash


wget https://downloads.arduino.cc/arduino-1.8.10-linux64.tar.xz
mkdir ~/local/arduino
tar xfv arduino-1.8.10-linux64.tar.xz -C ~/local/arduino
rm arduino-1.8.10-linux64.tar.xz
pushd ~/local/arduino/arduino-1.8.10/
sudo ./install.sh
popd
