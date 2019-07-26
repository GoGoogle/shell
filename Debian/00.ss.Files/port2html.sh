#!/bin/bash
## 监控端口连接情况
## 写入HTML文件
## 使用: chmod a+x ./port2html.sh 443 /var/www/html
## 每3分钟刷新一次
## */3 * * * * /root/port2html.sh 443 /var/www/html
## by bmwcto 2019.7.26 23:01

port=$1
htmlfile=$2/$port.html
Pstatus="<pre>`/bin/netstat -ntu | grep :$port | awk '{print $4,$5}'| sort | uniq -c | sort -n`</pre>"
echo "$Pstatus <hr />at `date '+%Y-%m-%d %H:%M:%S'`" >$htmlfile;
