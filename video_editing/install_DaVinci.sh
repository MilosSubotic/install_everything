#!/bin/bash

# Download from:
# https://www.blackmagicdesign.com/event/davinciresolvedownload

V=18.6.6

unzip DaVinci_Resolve_${V}_Linux.zip

sudo apt -y install libapr1 libaprutil1 \
    libxcb-composite0 libxcb-cursor0 libxcb-damage0

sudo apt -y install mesa-utils
glxgears
# Need at least OpenGL v4.5
glxinfo | grep "OpenGL version"

./DaVinci_Resolve_${V}_Linux.run --nonroot --directory ~/.local/opt/DaVinci_Resolve/${V}/

sudo mkdir -p " /var/BlackmagicDesign/DaVinci Resolve"