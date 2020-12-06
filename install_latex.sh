#!/bin/bash

sudo apt -y install texlive-full texmaker

sudo apt -y install hunspell-en-us hunspell-sr
# Texmaker -> Options -> Configure Texmaker -> Editor -> Spelling dictionary
# Select some *.dic file from: /usr/share/hunspell/

apm install latex language-latex
