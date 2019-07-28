#!/bin/bash
## 监控端口连接情况
## 写入HTML文件
## 使用: chmod a+x ./port2html.sh 443 /var/www/html
## 每3分钟刷新一次
## */3 * * * * /root/port2html.sh 443 /var/www/html
## by bmwcto 2019.7.26 23:01

ver=3.6
port=$1
htmlfile=$2/$port.html
txtfile=$2/$port.txt
xtime=`date '+%Y-%m-%d %H:%M:%S'`

## 使用说明
  4 usage () {
  3         name=`basename $0`
  2         echo "$name 版本：$ver by <bmwcto>"
  1         echo
20          echo "用处：记录本机第1个内网网卡的特定端口被访问的IP地址，并存入指定路径，最后过滤提取所有IP到指定文件，方便查阅。"
  1         echo
  2         echo "使用说明如下："
  3         echo
  4         echo "./$name 端口 文件存放路径"
  5         echo
  6         echo "例如："
  7         echo "./$name 443 /var/www/html"
  8         echo
  9 }
 10
 11 ## 未加任何参数时输出使用帮助
 12 shift `expr $OPTIND - 1`
 13
 14 if [ "x$1" = "x" ]; then
 15         usage
 16         exit
 17 fi
 
#### 获取本机内网IP的两种方式
#- `ip a|grep -w 'inet'|grep 'global'|sed 's/.*inet.//g'|sed 's/\/[0-9][0-9].*$//g'`
#- `ip -4 addr|sed -n -e '/brd/p'|sed -n -e 's/\/.*$//p'|awk '{print $2}'`

## 获取本机内网IP后提取第1行的结果的两种方式,适用于有多个内网IP,按需修改
#myip=`ip -4 addr|sed -n -e '/brd/p'|sed -n -e 's/\/.*$//p'|awk '{print $2}'|awk 'NR==1{print}'`
myip=`ip -4 addr|sed -n -e '/brd/p'|sed -n -e 's/\/.*$//p'|awk '{print $2}'|head -n1`

## v1.0
#Pstatus="<pre>`/bin/netstat -ntu | grep :$port | awk '{print $4,$5}'| sort | uniq -c | sort -n`</pre>"

## v2.0
## 过虑出访问指定端口的IP
#Pstatus="<pre>`/bin/netstat -anlp|grep tcp|grep -w $myip:$port|awk '{print $5}'|awk -F: '{print $1}'|sort|uniq -c|awk '{print $2}'|sort -nr`</pre>"
#echo "$Pstatus <hr />version:$ver | at `date '+%Y-%m-%d %H:%M:%S'`" >$htmlfile;

## v3.0
## 过虑出访问指定端口的IP
Pstatus1=`/bin/netstat -anlp|grep tcp|grep -w $myip:$port|awk '{print $5}'|awk -F: '{print $1}'|sort|uniq -c|awk '{print $2}'|sort -nr`

## 带日期和时间以及换行，整体记录到txtfile
echo -e "\n$xtime\n${Pstatus1}">>$txtfile;

## 延时1秒，以防未记录完成
sleep 1s

## 从txtfile内过滤掉相同的IP，grep -o -E "[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}",只找IP，忽略日期
Pstatus2="<pre>`cat $txtfile|grep -o -E "[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}"|sort|uniq -c|awk '{print $2}'|sort -nr`</pre>"

## 最后过滤后的结果写入到htmlfile
echo "$Pstatus2 <hr />version:$ver | at $xtime" >$htmlfile;
