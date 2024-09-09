#!/bin/bash

wget --content-disposition https://go.microsoft.com/fwlink/?LinkID=760868
sudo dpkg -i code*.deb
rm code*.deb

cp -r vsc/.config ~/

