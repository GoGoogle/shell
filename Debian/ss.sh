#升级

apt update
apt list --upgradable
apt upgrade

#安装SS
apt install shadowsocks-libev

#安装VIM
apt install vim

#编辑SS配置文件
vim /etc/shadowsocks-libev/config.json

#重启SS服务
systemctl restart shadowsocks-libev

#查看SS服务状态
systemctl status shadowsocks-libev

#安装CURL
apt install curl

#OPENVZ安装BBR
wget --no-check-certificate https://github.com/teddysun/across/raw/master/bbr.sh && chmod +x bbr.sh && ./bbr.sh
curl https://raw.githubusercontent.com/linhua55/lkl_study/master/get-rinetd.sh | bash
cat /etc/rinetd-bbr.conf
exit

#SS配置文件案例
{
    "server":"0.0.0.0",
    "server_port":1080,
    "password":"000000",
    "timeout":60,
    "method":"aes-256-cfb"
}
