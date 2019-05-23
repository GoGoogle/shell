##查看/修改Linux时区和时间
一、时区
1. 查看当前时区
date -R

2. 修改设置时区
(1)
tzselect
(2) 仅限于RedHat Linux 和 CentOS
timeconfig
(3) 适用于Debian
dpkg-reconfigure tzdata
3. 复制相应的时区文件，替换系统时区文件；或者创建链接文件
cp /usr/share/zoneinfo/$主时区/$次时区 /etc/localtime

在中国可以使用：
cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime

二、时间
1、查看时间和日期
date
2、设置时间和日期

将系统日期设定成1996年6月10日的命令
date -s 06/22/96

将系统时间设定成下午1点52分0秒的命令
date -s 13:52:00 
3. 将当前时间和日期写入BIOS，避免重启后失效
hwclock -w

##OPENVZ加虚拟内存

#!/bin/bash
# openvzPlusREM
SWAP="${1:-512}"
NEW="$[SWAP*1024]"; TEMP="${NEW//?/ }"; OLD="${TEMP:1}0"
umount /proc/meminfo 2> /dev/null
sed "/^Swap\(Total\|Free\):/s,$OLD,$NEW," /proc/meminfo > /etc/fake_meminfo
mount --bind /etc/fake_meminfo /proc/meminfo
free -m


##设置系统编码
apt update
apt install locale

export LANGUAGE=en_US.UTF-8
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
locale-gen en_US.UTF-8
dpkg-reconfigure locales

echo "LC_ALL=en_US.UTF-8" >> /etc/environment
echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen
echo "LANG=en_US.UTF-8" > /etc/locale.conf
locale-gen en_US.UTF-8

##遇到killed的可能是内存不足了


##配置ZSH
apt install -y zsh git
sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

#复制主题文件
cp /root/.oh-my-zsh/themes/amuse.zsh-theme /root/.oh-my-zsh/themes/0myamuse.zsh-theme

#编辑主题文件
vim /root/.oh-my-zsh/themes/0myamuse.zsh-theme

PROMPT='
%{$fg_bold[blue]%}%n%{$reset_color%}@[%M] %{$fg_bold[green]%}%d%{$reset_color%}/$(git_prompt_info) ⌚ %{$fg_bold[red]%}%D %*%{$reset_color%}
$ '

#编辑zshrc环境，设置主题
vim ~/.zshrc
ZSH_THEME="0myamuse"

#配置程序别名
alias fuck=/usr/bin/proxychains4

#应用主题
source ~/.zshrc

#默认使用ZSH
chsh -s /bin/zsh


#安装socks代理服务器
#https://github.com/GoGoogle/danted
apt install -y dante-server

#分别是开始|停止|重启|刷新配置|查看状态|不懂|添加用户|删除用户|又不懂|查看配置文件|升级
/etc/init.d/sockd {start|stop|restart|reload|status|state|adduser|deluser|tail|conf|update}

#key login SSH
vim key
chmod 700 key
ssh -i key root@ip

##SSH用密钥登录

#生成SSH密钥对
ssh-keygen -t rsa
Generating public/private rsa key pair.
#建议直接回车使用默认路径
Enter file in which to save the key (/root/.ssh/id_rsa): 
#输入密码短语（留空则直接回车）
Enter passphrase (empty for no passphrase): 
#重复密码短语
Enter same passphrase again: 
Your identification has been saved in /root/.ssh/id_rsa.
Your public key has been saved in /root/.ssh/id_rsa.pub.
The key fingerprint is:
aa:8b:61:13:38:ad:b5:49:ca:51:45:b9:77:e1:97:e1 root@localhost.localdomain
The key's randomart image is:

#编辑sshd_config文件
vim /etc/ssh/sshd_config
#禁用密码验证
PasswordAuthentication no
#启用密钥验证
RSAAuthentication yes
PubkeyAuthentication yes
#指定公钥数据库文件
AuthorsizedKeysFile .ssh/authorized_keys


可以在== 后加入用户注释标识方便管理
echo 'ssh-rsa XXXX' >>/root/.ssh/authorized_keys
# 复查
cat /root/.ssh/authorized_keys

#复制公钥到无密码登录的服务器上,22端口改变可以使用下面的命令
#ssh-copy-id -i ~/.ssh/id_rsa.pub "-p 10022 user@server"
ssh-copy-id -i ~/.ssh/id_rsa.pub root@192.168.15.241

systemctl restart sshd

