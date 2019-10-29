#!/bin/bash
## 定时查询本机外网IP
## 同步到ACL列表
## 每周六4点刷新一次
## 0 4 * * 6 /root/myipacl.sh /root testacl

txtfile=$1/$2.txt
aclfile=$1/$2.acl

xtime=`date '+%Y-%m-%d %H:%M:%S'`

## 获取本机外网IP
myip=`curl ip.sb`

## 写入IP到.txt
## 若myip为空时不写记录，不为空时再写记录，以减小记录文件的体积大小

if [[ "$myip" =~ ^[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3} ]];
then
        ## 带日期和时间以及换行，整体记录到txtfile
        echo -e "\n$xtime\n${myip}">>$txtfile;
else
        exit
fi

## 从txtfile内过滤掉相同的IP，grep -o -E "[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}",只找IP，忽略日期
ipacl="`cat $txtfile|grep -o -E "[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}"|sort|uniq -c|awk '{print $2}'|sort -nr`"

## 最后过滤后的结果写入到htmlfile
echo -e "$ipacl\n#$xtime" >$aclfile;
