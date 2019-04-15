#当线路不称定时，记录其每次断网的时间
#摘自https://www.goxxk.com/?p=916

#sudo chmod 755 /usr/sbin/tcpdump
##让普通用户也能使用tcpdump

##/bash/bin
logfile=/home/pi/netlog
##断网时将断网的时间和丢包情况写入日志路径

##startday=2019-03-04
##取当前天

monitor_ip=114.114.114.114
##被监测的网络IP

##while [ "$startday" = "$(date +%Y-%m-%d)" ]
##该程序每天凌晨自动执行，过午夜就退出
while true
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
			echo `date '+%Y-%m-%d %H:%M:%S'` : send package $send, received package $received, lost package $lost >>$logfile/$monitor_ip_$(date +%Y-%m-%d).log
			##将当前时间和发送包数、接收包数和丢失包数写入监控日志文件
			/usr/sbin/tcpdump -s 0 -c 3 -i wlan0 -vvv host $monitor_ip -n -w $logfile/$monitor_ip_$(date +%H%M%S).cap & ping -c 1000 $monitor_ip
      			##从wlan0接口进行抓包，最大长度为0(自适应)，抓到3个icmp包就起来成cap文件
	fi
done

