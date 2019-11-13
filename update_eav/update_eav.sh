#!/bin/sh
#从老毛子那里获取ESET病毒库的更新包
#by 2018-4-13
#老子这么懒，当然要做成自动任务了，周一、四、六更新即可crontab -e
#01 00 * * 1,4,6 /bin/bash /home/bmwcto/soft/list/update_eav.sh
#如果能连上 8.8.8.8 的 53 端口，则结果为真，输出 OK，如果连接不上，也就是最开始的语句结果为假，echo "OK" 就被“短路”了，最后输出了 FAIL。
#nc -z 8.8.8.8 53 && echo "OK" || echo "FAIL"

#在脚本执行过程中，如果有错误，就退出脚本，不再继续下去。如果一条语句执行完，返回值不是 0，就是错误。
set -o errexit

#如果脚本中有一行命令是由一个或多个管道连起来的多个命令，如果其中有一条或者多条命令出现错误（返回非 0 值），这一整行命令返回的结果就是最后那条返回失败结果的命令的返回值。
set -o pipefail

#获取当前日期和时间并格式化为 2018-04-13-09-54-16
get_now_str_time=`date "+%Y-%m-%d-%H-%M-%S"`

#设置常用路径变量
p_eavH="/home/bmwcto/soft/list"

#设置远程更新包URL
update_url="http://soft.ivanovo.ac.ru/updates/eset/offline_update_eav.zip"

#备份上次更新包到指定路径
mv $p_eavH/offline_update_eav.zip $p_eavH/eav_bak/eav_$get_now_str_time.zip

#开始获取更新包
#aria2c http://soft.ivanovo.ac.ru/updates/eset/offline_update_eav.zip --dir=$p_eavH --out=offline_update_eav.zip
#wget -P $p_eavH -O offline_update_eav.zip http://soft.ivanovo.ac.ru/updates/eset/offline_update_eav.zip
wget -O $p_eavH/offline_update_eav.zip -c $update_url

#等待10分钟下载时间后执行删除上次的更新文件
sleep 10m;rm -rf $p_eavH/offline/*.*

#等待10秒钟后执行解压新的更新包
sleep 10s;unzip $p_eavH/offline_update_eav.zip -d $p_eavH/offline/

# 删除30天之前的备份文件
find $p_eavH/eav_bak/* -mtime +30 -exec rm {} \;
