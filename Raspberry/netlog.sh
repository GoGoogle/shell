##/bash/bin
##2019-04-16 14:26:05

##断网时将断网的时间和丢包情况写入日志，并对目标IP进行抓包
##为文件添加执行权限：chmod +x netlog.sh
##执行格式为：netlog.sh 日志目录名称 日志文件名标记 被检测的IP地址
## 2019年 04月 16日 星期二 10:11:53 CST

logpath=$(dirname $(readlink -f $0))/$1
##获取当前工作目录以及第一个传递参数

mkdir $logpath
##新建日志目录

ip=$3
##被监测的网络IP

logfile=$logpath/$2_$ip-$(date +%Y-%m-%d).log
##日志文件

capfile=$logpath/$2_$ip-$(date +%H%M%S).cap
##抓包文件

##startday=$(date +%Y-%m-%d)
##取当天

##while [ "$startday" = "$(date +%Y-%m-%d)" ]
##该程序每天凌晨自动执行，过午夜就退出

while true
do
        pinglog=`ping -c 60 $ip | grep received | awk '{print $1,$4}'`
        ##每60秒执行一次，取发送的包数和接收的包数
        send=`echo $pinglog | awk '{print $1}'`
        ##取发送的包数
        received=`echo $pinglog | awk '{print $2}'`
        ##取接收到的包数
        lost=$(($send-$received))
        ##计算丢失的包数
        if [ $lost -gt 0 ] ;
                then
                        echo `date '+%Y-%m-%d %H:%M:%S'` : send package $send, received package $received, lost package $lost >>$logfile
                        ##将当前时间和发送包数、接收包数和丢失包数写入监控日志文件
                        /usr/sbin/tcpdump -s 0 -c 3 -i wlan0 -vvv host $ip -n -w $catfile & ping -c 40 $ip
                        ##进行抓包并发送PING数据
        fi
done
