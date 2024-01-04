#!/bin/bash

sudo apt -y install texlive-full texmaker

sudo apt -y install hunspell-en-us hunspell-sr
# Texmaker -> Options -> Configure Texmaker -> Editor -> Spelling dictionary
# Select some *.dic file from: /usr/share/hunspell/

code --install-extension James-Yu.latex-workshop

#apm install latex language-latex
#patch -d$HOME/.atom/packages/latex/lib/openers/ -p1 < latex_evince.patch
