#!/bin/bash

sudo -E add-apt-repository -y ppa:freecad-maintainers/freecad-stable
sudo apt update
sudo apt install -y freecad openscad
