#-----------------------需要更改部分-----------------------#
# 需要开机自启的软件，true自启
ARIA2=true
LIGHTTPD=true
RESILIO_SYNC=true
SHADOWSOCKS=true
#-----------------------请勿更改部分-----------------------#
# 启动aria2
if "$ARIA2" = true;
then
	sudo aria2c --enable-rpc --rpc-listen-all=true --rpc-allow-origin-all -c -D
	aria2c --conf-path=${HOME_PATH}/application/aria2/aria2.conf --disable-ipv6=true -D
	sudo aria2c --conf-path=${HOME_PATH}/application/aria2/aria2.conf --disable-ipv6=true -D &
	echo "\n"
fi

# 启动lighttpd
if "$LIGHTTPD" = true;
then
	sudo service lighttpd start
fi

# 启动resilio sync
if "$RESILIO_SYNC" = true;
then
	sudo ${HOME_PATH}/application/resilio_sync/rslsync --webui.listen 0.0.0.0:${RESILIO_SYNC_PORT}
fi

# 安装shadowsocks
if "$SHADOWSOCKS" = true;
then
	sudo nohup ssserver -c /etc/shadowsocks/shadowsocks.json start > ${HOME_PATH}/application/shadowsocks/shadowsocks.out 2>&1 &
fi
