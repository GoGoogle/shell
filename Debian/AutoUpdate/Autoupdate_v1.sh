#!/bin/bash
## 此版本思路已经过时，存档；
## BMWCTO 10:33 2019/7/31

##假设当前版本为1.1
ver=1.1

## 自动更新函数
_update() {
                #获取当前具体日期和时分并格式化成纯数字
                now=`date '+%w%H%M'`
                # echo "少5分钟：`date '+%w%H%M' -d -5min`"
                # echo "当前：$now"
                # echo "多5分钟：`date '+%w%H%M' -d 5min`"

                #设置时间范围为每周2的10点35分-55分之间
                e=31035
                f=31155
                #echo -e "\n\n $e=<$now=<$f \n\n"

                #当前脚本绝对路径和脚本本身名称
                sh_path=`readlink -f "$0"`

                #当前脚本绝对路径
                work_path=$(dirname $(readlink -f $0))
                # echo "$sh_path"
                # echo "$work_path/"

                ## 远程脚本路径
                url=https://github.com/GoGoogle/shell/raw/master/Debian/AutoUpdate/Autoupdate_v1.sh

                ### 从远程URL里面拉取全部内容，并从内容内查找"ver="所在行，提取第1行结果，并去掉"ver="，只保留后面的所有版本字符，保留使用；
                getver=`curl -fsSL "$url"|grep ver=|head -n1|sed s/ver=/""/`
                ### 保存远程文件到本地
                getnew="wget --no-check-certificate -qO $sh_path $url && chmod a+x $sh_path"

#判断当前时间为周2的10点35分到55分之间
if [ "$e" -le "$now" ] && [ "$now" -le  "$f" ]
then
        echo -e "\n\n现在正在设置范围内\n\n";
        if [ "$ver" != "$getver" ]
        then
                ## 先备份当前脚本
                echo -e "版本不同，需要更新\n 正在备份...";
                cp $sh_path $sh_path.bak
		
                ## 拉取更新
		echo -e "备份完成\n 正在拉取更新...";
                ${getnew}
		
		## 更新完成后再执行
		echo -e "完成更新\n 正在执行新版本...";
		bash $sh_path;
        else
                echo "版本一致，不用更新";
                fi
else
echo -e "\n\n当前不在设置的时间范围内，继续下一步运作。\n\n";
fi
}

_update

echo "我是下一步test2"
