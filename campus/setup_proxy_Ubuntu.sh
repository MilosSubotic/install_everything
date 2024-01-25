#!/bin/bash

# Warm up sudo.
sudo -v

D=`dirname "${BASH_SOURCE[0]}"`
$D/setup_proxy_basic.sh

URL="ftn.proxy"
PORT="8080"

#F=/etc/environment
#echo "no_proxy=\"localhost,127.0.0.1,::1\"" >> $F

gsettings set org.gnome.system.proxy mode manual

function set_proxy() {
	#echo "${1}_proxy=\"$1://$URL:$PORT/\"" >> $F
	sudo dbus-send --system --print-reply --dest=com.ubuntu.SystemService --type=method_call / com.ubuntu.SystemService.set_proxy string:"$1" string:"$1://$URL:$PORT"
	gsettings set org.gnome.system.proxy.$1 host "$URL"
	gsettings set org.gnome.system.proxy.$1 port "$PORT"
}

set_proxy http
set_proxy https
set_proxy ftp
set_proxy socks
