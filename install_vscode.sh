#!/bin/bash

wget --content-disposition https://go.microsoft.com/fwlink/?LinkID=760868
#TODO Accept yes automatically.
sudo dpkg -i code*.deb
rm code*.deb

cp -r vscode/.config ~/

code --install-extension streetsidesoftware.code-spell-checker
code --install-extension streetsidesoftware.code-spell-checker-serbian
code --install-extension shd101wyy.markdown-preview-enhanced
code --install-extension mhutchie.git-graph