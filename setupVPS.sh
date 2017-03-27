#!/bin/sh
#-----------------------需要更改部分-----------------------#
# 安装的用户目录
BOOT_START=true		# 开机是否自启
HOME_DIR="/home/ubuntu"
MY_IP="192.168.30.110"

# 需要配置的密码
SHADOWSOCKS_PASSWD="123456"

# 需要安装的软件，true安装
ARIA2=true
LIGHTTPD=true
HTOP=true
SCREENFETCH=true
RESILIO_SYNC=true
SHADOWSOCKS=true
GIT=true
ZIP=true
ZIPROXY=false
#-----------------------请勿更改部分-----------------------#
# 初始化
sudo apt update
sudo apt-get update
sudo mkdir -p ${HOME_DIR}/application

# 安装aria2
if "$ARIA2" = true;
then
	sudo mkdir -p ${HOME_DIR}/application/aria2
	sudo mkdir -p ${HOME_DIR}/download
	sudo apt-get install aria2 -y
	cp ${HOME_DIR}/newVPS/aria2/aria2.conf ${HOME_DIR}/application/aria2/
	sudo aria2c --enable-rpc --rpc-listen-all=true --rpc-allow-origin-all -c -D
	aria2c --conf-path=${HOME_DIR}/application/aria2/aria2.conf --disable-ipv6=true -D
	sudo aria2c --conf-path=${HOME_DIR}/application/aria2/aria2.conf --disable-ipv6=true -D &
	echo "\n"
fi

# 安装lighttpd
if "$LIGHTTPD" = true;
then
	sudo apt-get install lighttpd -y
	sudo cp ${HOME_DIR}/newVPS/lighttpd/lighttpd.conf /etc/lighttpd/
	sudo service lighttpd restart
fi

# 安装htop
if "$HTOP" = true;
then
	sudo apt install htop
fi

# 安装screenfetch
if "$SCREENFETCH" = true;
then
	sudo apt install screenfetch -y
fi

# 安装Resilio Sync
if "$RESILIO_SYNC" = true;
then
	sudo mkdir -p ${HOME_DIR}/application/resilio_sync
	sudo cp ${HOME_DIR}/newVPS/resilio_sync/resilio-sync_x64.tar ${HOME_DIR}/application/resilio_sync
	cd ${HOME_DIR}/application/resilio_sync
	sudo tar xvf resilio-sync_x64.tar
	sudo ${HOME_DIR}/application/resilio_sync/rslsync --webui.listen 0.0.0.0:8888
fi

# 安装shadowsocks
if "$SHADOWSOCKS" = true;
then
	sudo apt install shadowsocks -y
	sudo echo "{" >> /etc/shadowsocks/shadowsocks.json
	sudo echo "\"server\":\"${MY_IP}\"," >> /etc/shadowsocks/shadowsocks.json
	sudo echo "\"server_port\":8388," >> /etc/shadowsocks/shadowsocks.json
	sudo echo "\"local_address\":\"127.0.0.1\"," >> /etc/shadowsocks/shadowsocks.json
	sudo echo "\"local_port\":1080," >> /etc/shadowsocks/shadowsocks.json
	sudo echo "\"password\":\"${SHADOWSOCKS_PASSWD}\"," >> /etc/shadowsocks/shadowsocks.json
	sudo echo "\"timeout\":300," >> /etc/shadowsocks/shadowsocks.json
	sudo echo "\"method\":\"aes-256-cfb\"," >> /etc/shadowsocks/shadowsocks.json
	sudo echo "\"fast_open\":false," >> /etc/shadowsocks/shadowsocks.json
	sudo echo "}" >> /etc/shadowsocks/shadowsocks.json

	sudo mkdir -p ${HOME_DIR}/application/shadowsocks
	sudo nohup ssserver -c /etc/shadowsocks/shadowsocks.json start > ${HOME_DIR}/application/shadowsocks/shadowsocks.out 2>&1 &
fi

# 安装git
if "$GIT" = true;
then
	sudo apt install git -y
fi

# 安装zip
if "$ZIP" = true;
then
	sudo apt install zip -y
fi

# 安装Ziproxy
if "$ZIPROXY" = true;
then
	sudo apt-get install ziproxy -y
fi

# 配置开启自启
if "$BOOT_START" = true;
then
	sudo mkdir -p ${HOME_DIR}/application/init
	sudo cp ${HOME_DIR}/newVPS/init/init.sh ${HOME_DIR}/application/init
	sudo chmod +x ${HOME_DIR}/application/init/init.sh
	sudo sed -i "s/exit 0/\n/g" /etc/rc.local
	sudo echo "${HOME_DIR}/application/init/init.sh" >> /etc/rc.local
	sudo echo "exit 0" >> /etc/rc.local
fi
