#!/bin/bash

##判断目标IP断开时，执行RestartEdge.sh
##为文件添加执行权限：chmod a+x IfNetDownDo_RestartEdge.sh
##执行格式为：IfNetDownDo_RestartEdge.sh 被检测的IP地址
## 2019-07-08 18:39:26

ip=$1
##被监测的网络IP

while true
do
        pinglog=`ping -c 3 $ip | grep received | awk '{print $1,$4}'`
        ##执行3次，取发送的包数和接收的包数
        send=`echo $pinglog | awk '{print $1}'`
        ##取发送的包数
        received=`echo $pinglog | awk '{print $2}'`
        ##取接收到的包数
        lost=$(($send-$received))
        ##计算丢失的包数
        if [ $lost -eq 3 ] ;
	##如果发送和接收相差为3，证明3次都没通
                then
                        bash /root/restartEdge.sh
						##echo "TSET"
                        ##目标IP不通时，执行RestartEdge.sh
        fi
		break # 退出循环
done
