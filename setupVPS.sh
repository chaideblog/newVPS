#!/bin/sh
# 初始化
sudo mkdir -p ~/application

# 安装aria2
sudo mkdir -p ~/application/aria2
sudo mkdir -p ~/download
sudo apt-get install aria2 -y
cp ~/newVPS/aria2/aria2.conf ~/application/aria2/
sudo aria2c --enable-rpc --rpc-listen-all=true --rpc-allow-origin-all -c -D
aria2c --conf-path=~/application/aria2/aria2.conf --disable-ipv6=true -D
sudo aria2c --conf-path=~/application/aria2/aria2.conf --disable-ipv6=true -D &
echo "\n"

# 安装lighttpd
sudo apt-get install lighttpd -y
sudo cp ~/newVPS/lighttpd/lighttpd.conf /etc/lighttpd/
sudo service lighttpd restart

# 安装htop
sudo apt install htop

# 安装screenfetch
sudo apt install screenfetch -y

# 安装Resilio Sync
sudo mkdir -p ~/application/resilio_sync
sudo cp ~/newVPS/resilio_sync/resilio-sync_x64.tar ~/application/resilio_sync
cd ~/application/resilio_sync
sudo tar xvf resilio-sync_x64.tar
sudo ~/application/resilio_sync/.rslsync --webui.listen 0.0.0.0:8888
