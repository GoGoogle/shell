#当线路不称定时，记录其每次断网的时间
#摘自https://www.goxxk.com/?p=916

logfile=/home/allvpay/netlog/$(date +%Y-%m-%d).log 
##断网时将断网的时间和丢包情况写入日志

startday=$(date +%Y-%m-%d)
##取当前天

monitor_ip=114.114.114.114
##被监测的网络IP

while [ "$startday" = "$(date +%Y-%m-%d)" ]
##该程序每天凌晨自动执行，过午夜就退出
#while true
##该程序一直循环
do
  pinglog=`ping -c 60 $monitor_ip | grep received | awk '{print $1,$4}'`
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
  fi
done
