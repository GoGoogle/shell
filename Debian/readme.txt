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


##配置ZSH主题

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
