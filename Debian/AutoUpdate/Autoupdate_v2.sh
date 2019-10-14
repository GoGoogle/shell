#!/bin/bash
## 自动更新脚本2.0；
## 把文件版本单独写入到.ver文件，减少检测负荷；
## 本应该把每个文件的版本号都写入到.ver文件中，然后根据需求检测更新，目前暂时还没有这个必要，所以先做单文件的。

## BMWCTO 19:52 2019/10/14


## 自动更新函数
_update() {
        #获取当前具体日期和时分并格式化成纯数字
        now=`date '+%w%H%M'`
        # echo "少5分钟：`date '+%w%H%M' -d -5min`"
        # echo "当前：$now"
        # echo "多5分钟：`date '+%w%H%M' -d 5min`"

        #设置时间范围为每周1的19点00分到22点00分之间
        e=11900
        f=12200
        #echo -e "\n\n $e=<$now=<$f \n\n"

        #当前脚本绝对路径和脚本本身名称
        #sh_path=`readlink -f "$0"`
        sh_path=`readlink -f "$0"`

        ## 获取文件名
        filename=$(basename -- "$sh_path")

        ## 格式化，并取当前文件后缀，在本脚本中无用，留用；
        extension="${filename##*.}"

        ## 格式化，并取当前文件名，不带后缀，配置给版本文件使用；
        filename="${filename%.*}"

        #当前脚本绝对路径，配置给版本文件使用
        work_path=$(dirname $(readlink -f $0))
        # echo "$sh_path"
        # echo "$work_path/"

        ## 读取本地文件版本
        #ver=`cat "$work_path/$filename.ver"|grep ver=|head -n1|sed s/ver=/""/`
        ver=`cat "$work_path/$filename.ver"|head -n1`

        ## 远程脚本及版本文件路径
        ShellUrl=https://github.com/GoGoogle/shell/raw/master/Debian/AutoUpdate/Autoupdate_v2.sh
        VerUrl=https://github.com/GoGoogle/shell/raw/master/Debian/AutoUpdate/Autoupdate_v2.ver

        ## 从远程VerUrl里面读取第1行内容
        getver=`curl -fsSL "$VerUrl"|head -n1`
        ### 保存远程文件到本地
        getnewShell="wget --no-check-certificate -qO $sh_path $ShellUrl && chmod a+x $sh_path"
        getnewVer="wget --no-check-certificate -qO $work_path/$filename.ver $VerUrl"

#判断当前时间为每周1的19点00分到22点00分之间
if [ "$e" -le "$now" ] && [ "$now" -le  "$f" ]
then
        echo -e "\n\n现在正在设置范围内\n\n";
        if [ "$ver" != "$getver" ]
        then
                ## 先备份当前脚本
                echo -e "但版本不同，需要更新\n 正在备份...";
                cp $sh_path $sh_path-$now.bak
                cp $filename.ver $filename.ver-$now.bak

                ## 拉取更新
                echo -e "备份完成\n 正在拉取更新...";
                ${getnewShell}
                ${getnewVer}

                ## 更新完成后再执行
                echo -e "完成更新\n 正在执行新版本...";
                bash $sh_path;
        else
                echo "但版本一致，不用更新";
                fi
else
echo -e "\n\n当前不在设置的时间范围内，继续下一步运作。\n\n";
fi
}

_update

echo "我是下一步test2"
