#!/bin/bash

sudo apt install nvidia-driver-550

gsettings set org.freedesktop.ibus.panel.emoji hotkey "[]"

# ch340 bug
sudo rm -f /usr/lib/udev/rules.d/*brltty*.rules
sudo udevadm control --reload-rules
sudo systemctl stop brltty-udev.service
sudo systemctl mask brltty-udev.service
sudo systemctl stop brltty.service
sudo systemctl disable brltty.service
