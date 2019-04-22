##安装常用工具
apt update
apt upgrade
apt install -y sudo netools zsh git wget curl screen

wget https://github.com/GoGoogle/shell/raw/master/Debian/.vimrc
wget https://github.com/tomasr/molokai/raw/master/colors/molokai.vim

cp molokai.vim /usr/share/vim/vim80/colors/

sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
cp /root/.oh-my-zsh/themes/amuse.zsh-theme /root/.oh-my-zsh/themes/0myamuse.zsh-theme
vim /root/.oh-my-zsh/themes/0myamuse.zsh-theme

PROMPT='
%{$fg_bold[blue]%}%n%{$reset_color%}@[%M] %{$fg_bold[green]%}%d%{$reset_color%}/$(git_prompt_info) ⌚ %{$fg_bold[red]%}%D %*%{$reset_color%}
$ '

vim ~/.zshrc
ZSH_THEME="0myamuse"

source ~/.zshrc
chsh -s /bin/zsh


##编译安装Python
apt-get install build-essential checkinstall
apt-get install libreadline-gplv2-dev libncursesw5-dev libssl-dev     libsqlite3-dev tk-dev libgdbm-dev libc6-dev libbz2-dev libffi-dev
wget https://www.python.org/ftp/python/3.7.3/Python-3.7.3.tgz
tar xzf Python-3.7.3.tgz
mv Python-3.7.3.tgz /usr/src
cd /usr/src/Python-3.7.3
./configure --prefix=/usr/Python37 --with-ssl
make && make install

apt install python3-pip
ln -s /usr/Python37/bin/pip3 /usr/bin/pip3
pip3 --version
ln -s /usr/Python37/bin/python3.7 /usr/bin/python3

##安装SS
apt install shadowsocks-libev

##ss.json文件
{
        "server": "4.3.2.1",
        "server_port": 9999,
        "method": "aes-256-cfb",
        "password": "1PassWord",
        "local_address": "127.0.0.1",
        "local_port": 1080,
        "fast_open": true,
        "workers": 1
}

ss-local -c /root/ss.json

##编译安装proxychains-ng
#wget http://ftp.barfooze.de/pub/sabotage/tarballs/proxychains-ng-4.14.tar.xz
git clone https://github.com/rofl0r/proxychains-ng
cd proxychains-ng
./configure --prefix=/usr --sysconfdir=/etc
make && make install && make install-config

##测试proxychains-ng
proxychains4 -4sSkL https://www.google.com


##安装privoxy
apt-get -y install privoxy
#全局：echo 'forward-socks5 / 127.0.0.1:1080 .' >>/etc/privoxy/config
systemctl start privoxy.service
systemctl -l status privoxy.service
#分流：
#curl -4sSkLO https://raw.github.com/zfl9/gfwlist2privoxy/master/gfwlist2privoxy
#curl -4sSkLO https://github.com/GoGoogle/gfwlist2privoxy/raw/master/gfwlist2privoxy
bash gfwlist2privoxy '127.0.0.1:1080'
more gfwlist.action|grep telegram
mv -f gfwlist.action /etc/privoxy
echo 'actionsfile gfwlist.action' >>/etc/privoxy/config
systemctl start privoxy.service
systemctl -l status privoxy.service
#本地http相关变量，privoxy默认端口8118
proxy="http://127.0.0.1:8118"
export http_proxy=$proxy
export https_proxy=$proxy
export no_proxy="localhost, 127.0.0.1, ::1"

##安装EFB
pip3 update
pip3 install libwebp
pip3 install libmagic
pip3 install ffmpeg
pip3 install libmagic
pip3 install pillow
pip3 install ehforwarderbot
pip3 install python-telegram-bot
pip3 install efb-telegram-master
pip3 install efb-wechat-slave
find / -name ehforwarderbot
ln -s /usr/Python37/bin/ehforwarderbot /usr/bin/efb
#查版本
pip3 freeze >pip.txt
pip3 freeze | grep efb
pip3 freeze | grep chat
pip3 freeze | grep bot

#运行EFB,可自动生成.ehforwarderbot目录及相关路径
efb
tar xvf efb.tar
#移动原来的配置文件到新的bmw目录
mv root/.ehforwarderbot/profiles/default  root/.ehforwarderbot/profiles/bmw

#以新的配置目录运行EFB
efb --profile bmw

