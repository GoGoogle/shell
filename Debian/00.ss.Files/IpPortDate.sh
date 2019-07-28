#!/bin/bash
## 检查流量
## 使用: wget --no-check-certificate -qO IpPortDate.sh 'https://github.com/GoGoogle/shell/raw/master/Debian/00.ss.Files/IpPortDate.sh' && chmod a+x IpPortDate.sh
## 每3分钟刷新一次
## */3 * * * * /root/IpPortDate.sh 192.168.0.2 443 /root/test

## 写了一下午也没写完整，下次再写吧，眼睛痛。

lc="by <bmwcto> 19:33 2019/7/28"

ver=1.0

txtfile=.
xtime=`date '+%Y-%m-%d %H:%M:%S'`

## 获取本机内网IP后提取第1行的结果的两种方式,适用于有多个内网IP,按需修改
#myip=`ip -4 addr|sed -n -e '/brd/p'|sed -n -e 's/\/.*$//p'|awk '{print $2}'|awk 'NR==1{print}'`
myip=`ip -4 addr|sed -n -e '/brd/p'|sed -n -e 's/\/.*$//p'|awk '{print $2}'|head -n1`


## 使用说明
usage () {
        name=`basename $0`
        echo "$name 版本：$ver $lc"
        echo
        echo "用处：查指定IP端口流量，需先添加流量统计功能。因统计IP或端口过多，多数情况下需要修改才能使用。"
        echo
        echo -e "添加示例：\n\n端口$port的入网流量：iptables -I INPUT -d $myip -p tcp --dport $port\n端口$port的出网流量：iptables -I OUTPUT -s $myip -p tcp --sport $port\n\nIP$myip所有入网流量：iptables -I INPUT -d $myip\nIP$myip所有出网流量：iptables -I OUTPUT -s $myip"
        echo
        echo "使用说明如下："
        echo
        echo "./$name Ip地址 端口 文件存放路径"
        echo
        echo "例如："
        echo "./$name $myip $port /root/test"
        echo
}


## 未加任何参数时输出使用帮助
shift `expr $OPTIND - 1`

# if [ "x$1" = "x" ]; then
        # usage
        # exit
# fi

_todo() {	
	## 上行数据流量
	up=`iptables -n -v -L -t filter|awk '{print $2,$7,$8,$10,$11}'|grep $myip|head -1|awk '{print $1}'`
	## 下行数据流量
	down=`iptables -n -v -L -t filter|awk '{print $2,$7,$8,$10,$11}'|grep $myip|tail -2|head -1|awk '{print $1}'`

	
	#port=$2
	#txtfile=$3
	
	## 上传下载数据流量
	echo $myip:$2 $xtime Up:${up} Down:${down}>$3/$myip-$2-IpPortDate.txt

	## 显示
	cat $3/$myip-$2-IpPortDate.txt
	}

check_ipaddr() {
    echo $1|grep "^[0-9]\{1,3\}\.\([0-9]\{1,3\}\.\)\{2\}[0-9]\{1,3\}$" > /dev/null;
    if [ $? -ne 0 ]
    then
        echo -e "\nIP地址必须全部为数字\n=============="		
		port=$2
		usage
        return 1
    fi
    ipaddr=$1
    a=`echo $ipaddr|awk -F . '{print $1}'`  #以"."分隔，取出每个列的值
    b=`echo $ipaddr|awk -F . '{print $2}'`
    c=`echo $ipaddr|awk -F . '{print $3}'`
    d=`echo $ipaddr|awk -F . '{print $4}'`
    for num in $a $b $c $d
    do
        if [ $num -gt 255 ] || [ $num -lt 0 ]    #每个数值必须在0-255之间
        then
            echo -e "\n$ipaddr 中，字段 $num 错误\n=============="
			port=$2
			usage
            return 1
        fi
   done
   #echo $ipaddr "地址合法"
   	myip=$1
	_todo
   return 0
}

if [ -n "$1" ]; then
	#echo -e "\n参数错了哦！\n"
    check_ipaddr $1
else
    echo -e "\n没有参数可不行哦！\n=============="
	port=443
	usage
fi



# if [ $# -ne 1 ];then            #判断传参数量 
        # echo "Usage: $0 ipaddress." 
        # exit
# else
# check_ipaddr $1
# fi
