#!/bin/bash

# 启动aria2
sudo aria2c --enable-rpc --rpc-listen-all=true --rpc-allow-origin-all -c -D
aria2c --conf-path=~/application/aria2/aria2.conf --disable-ipv6=true -D
sudo aria2c --conf-path=~/application/aria2/aria2.conf --disable-ipv6=true -D &
echo "\n"

# 启动lighttpd
sudo service lighttpd start

# 启动resilio sync
sudo ~/application/resilio_sync/.rslsync --webui.listen 0.0.0.0:8888
