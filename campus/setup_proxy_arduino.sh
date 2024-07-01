#!/bin/bash

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

set_preference proxy.type manual
set_preference proxy.manual.hostname "ftn.proxy"
set_preference proxy.manual.port 8080
set_preference proxy.manual.type HTTP
set_preference network.proxy "http://ftn.proxy:8080/"

arduino-cli config init &
ARDUINO_CLI_PID=$!
sleep 1
pkill -P $ARDUINO_CLI_PID
cat >> $HOME/.arduino15/arduino-cli.yaml << EOF
network:
  proxy: http://ftn.proxy:8080/
EOF