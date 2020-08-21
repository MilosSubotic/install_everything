#!/bin/bash

sudo apt install -y texlive-full texmaker

sudo apt install -y hunspell-en-us hunspell-sr # hunspell-sh
# Texmaker -> Options -> Configure Texmaker -> Editor -> Spelling dictionary
# Select some *.dic file from: /usr/share/hunspell/

apm install latex language-latex
#apm install  latex-autocomplete
