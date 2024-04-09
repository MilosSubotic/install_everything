#!/bin/bash

#https://dgpu-docs.intel.com/installation-guides/ubuntu/ubuntu-jammy-arc.html

sudo apt -y install gpg-agent wget
wget -qO - https://repositories.intel.com/graphics/intel-graphics.key | \
    sudo gpg --dearmor --output /usr/share/keyrings/intel-graphics.gpg
echo 'deb [arch=amd64,i386 signed-by=/usr/share/keyrings/intel-graphics.gpg] https://repositories.intel.com/graphics/ubuntu jammy arc' | \
    sudo tee  /etc/apt/sources.list.d/intel.gpu.jammy.list

sudo apt-get update

sudo apt-get install  -y --install-suggests  linux-image-5.19.0-50-generic
sudo sed -i "s/GRUB_DEFAULT=.*/GRUB_DEFAULT=\"1> $(echo $(($(awk -F\' '/menuentry / {print $2}' /boot/grub/grub.cfg \
| grep -no '5.19.0-50' | sed 's/:/\n/g' | head -n 1)-2)))\"/" /etc/default/grub

sudo update-grub

sudo reboot
uname -r

sudo apt-get -y install \
    gawk \
    dkms \
    linux-headers-$(uname -r) \
    libc6-dev

sudo apt -y install intel-platform-vsec-dkms
sudo apt -y install intel-platform-cse-dkms
sudo apt -y install intel-i915-dkms
sudo apt -y install intel-fw-gpu

sudo apt -y install gawk libc6-dev udev\
  intel-opencl-icd intel-level-zero-gpu level-zero \
  intel-media-va-driver-non-free libmfx1 libmfxgen1 libvpl2 \
  libegl-mesa0 libegl1-mesa libegl1-mesa-dev libgbm1 libgl1-mesa-dev libgl1-mesa-dri \
  libglapi-mesa libgles2-mesa-dev libglx-mesa0 libigdgmm12 libxatracker2 mesa-va-drivers \
  mesa-vdpau-drivers mesa-vulkan-drivers va-driver-all vainfo




