#### 升级

```
apt update
apt list --upgradable
apt upgrade
```

#### 安装SS

`apt install shadowsocks-libev`

#### 安装VIM

`apt install vim`

#### 编辑SS配置文件

`vim /etc/shadowsocks-libev/config.json`

#### 重启SS服务

`systemctl restart shadowsocks-libev`

#### 查看SS服务状态

`systemctl status shadowsocks-libev`

#### 安装CURL

`apt install curl`

#### KMS安装BBR

`wget --no-check-certificate https://github.com/teddysun/across/raw/master/bbr.sh && chmod +x bbr.sh && ./bbr.sh`

#### OPENVZ安装BBR

```
curl https://raw.githubusercontent.com/linhua55/lkl_study/master/get-rinetd.sh | bash
cat /etc/rinetd-bbr.conf
```

#### BBR相关（OPENVZ）

```
4. Generate /etc/systemd/system/rinetd-bbr.service
4. Enable rinetd-bbr Service
Created symlink /etc/systemd/system/multi-user.target.wants/rinetd-bbr.service → /etc/systemd/system/rinetd-bbr.service.
5. Start rinetd-bbr Service
rinetd-bbr started.
443 speed up completed.
vi /etc/rinetd-bbr.conf as needed.
killall -9 rinetd-bbr for restart.
```

####  SS配置文件案例

```
{
    "server":"0.0.0.0",
    "server_port":1080,
    "password":"000000",
    "timeout":60,
    "method":"aes-256-cfb"
}
```


#### ss-server白名单模式

`nohup /usr/bin/ss-server -c /root/ss.json --acl /root/ss.acl </dev/null &>>/home/roott/ss-local.log &`

```
vim /root/ss.acl
[reject_all]

[white_list]
127.0.0.0/8
::1/128

#北京移动
233.233.0.0/16
```

#### 编译安装最新版

安装依赖：
`apt install --no-install-recommends gettext build-essential autoconf libtool libpcre3-dev asciidoc xmlto libev-dev libc-ares-dev automake`

```apt install --no-install-recommends autoconf automake \
    debhelper pkg-config asciidoc xmlto libpcre3-dev apg pwgen rng-tools \
    libev-dev libc-ares-dev dh-autoreconf libsodium-dev libmbedtls-dev
```

拉取最新：
```
git clone https://github.com/shadowsocks/shadowsocks-libev.git
cd shadowsocks-libev
git submodule update --init --recursive
```

编译：
`./autogen.sh && ./configure && make`

安装：
`make install`
