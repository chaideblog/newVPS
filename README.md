# newVPS

newVPS是一个自动配置VPS的脚本。

* 可以选择需要安装的软件，然后自动安装aria、lighttpd、shadowsocks、resilio sync等软件
* 可以选择需要开机自启动的软件，开机自启动

## Attention

将newVPS目录放到`/home`目录下，进入`newVPS`目录，更改`setupVPS.sh`的权限：

```
sudo chmod +x setupVPS.sh
```

然后使用`sudo`权限运行：

```
sudo ./setupVPS.sh
```

## Features

* aira：VPS自动下载bt、磁力、网址
* lighttpd：http下载VPS上的资源
* shadowsocks：科学合理上网
* resilio sync：将VPS作为网盘，上传下载文件
* git：管理git仓库
* zip：压缩、解压文件
* ziproxy：省流量代理


