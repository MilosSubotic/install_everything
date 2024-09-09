#!/bin/bash

#TODO Need to test. this.
echo "\n\n\n\n\n\n\n\n" | sudo apt -y install texlive-full texmaker

sudo apt -y install hunspell-en-us hunspell-sr
# Texmaker -> Options -> Configure Texmaker -> Editor -> Spelling dictionary
# Select some *.dic file from: /usr/share/hunspell/

code --install-extension James-Yu.latex-workshop

