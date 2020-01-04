#!/bin/sh
# Making new file and seting premisions rw-r--r--.
touch "$*"
chmod 644 "$*"

