#!/bin/bash

URL="proxy.uns.ac.rs"
PORT="8080"

F=/etc/environment

echo "http_proxy=\"http://$URL:$PORT/\"" >> $F
echo "https_proxy=\"https://$URL:$PORT/\"" >> $F
echo "ftp_proxy=\"ftp://$URL:$PORT/\"" >> $F
echo "socks_proxy=\"socks://$URL:$PORT/\"" >> $F
echo "no_proxy=\"localhost,127.0.0.1,::1\"" >> $F

