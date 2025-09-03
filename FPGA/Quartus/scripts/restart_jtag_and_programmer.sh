#!/bin/bash

killall -9 quartus_pgmw
killall -9 jtagd
jtagd --user-start --config $HOME/.jtagd.conf
jtagconfig
quartus_pgmw &

