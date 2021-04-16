#!/bin/bash

VER=1.8.12
wget https://downloads.arduino.cc/arduino-$VER-linux64.tar.xz
mkdir -p ~/.local/opt/arduino/
tar xfv *.tar.xz -C ~/.local/opt/arduino
rm *.tar.xz
pushd ~/.local/opt/arduino/arduino-$VER/
sudo ./install.sh
popd

function set_preference() {
	SETTING_NAME="$1"
	SET_TO_VALUE="$2"
	F="$HOME/.arduino15/preferences.txt"
	SETTING_NAME="${SETTING_NAME//./\.}"
	SET_TO_VALUE="${SET_TO_VALUE////\\/}"
	if grep -q "$SETTING_NAME=" "$F"
	then 
		sed -i "s/^$SETTING_NAME=.*/$SETTING_NAME=$SET_TO_VALUE/g" "$F"
	else
		echo "$SETTING_NAME=$SET_TO_VALUE" >> "$F"
	fi
}

set_preference editor.tabs.expand false
set_preference editor.tabs.size 4
set_preference programmer arduino:arduinoisp
set_preference serial.port /dev/ttyUSB0
set_preference serial.port.file ttyUSB0
set_preference serial.port.iserial null
set_preference serial.debug_rate 115200
