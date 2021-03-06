#!/bin/bash
## 定时查询域名IP
## 同步到ACL列表
## 每周六5点30分刷新一次
## 30 5 * * 6 /root/DomainsIpListAcl.sh /root testacl google.com
## 依赖于nslookup; apt install dnsutils;
## by bmwcto 17:34 2019/10/29

txtfile=$1/$2.txt
aclfile=$1/$2.acl

xtime=`date '+%Y-%m-%d %H:%M:%S'`

## 获取域名的第一个IP
DomainIp=`nslookup $3 8.8.8.8 | grep -v "8.8.8.8" | grep "Address" |awk '{print $2}'|head -n1`

## 写入IP到.txt
## 若DomainIp为空时不写记录，不为空时再写记录，以减小记录文件的体积大小

if [[ "$DomainIp" =~ ^[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3} ]];
then
        ## 带日期和时间以及换行，整体记录到txtfile
        echo -e "\n$xtime\n${DomainIp}">>$txtfile;
else
        exit
fi

## 从txtfile内过滤掉相同的IP，grep -o -E "[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}",只找IP，忽略日期
DomIpList="`cat $txtfile|grep -o -E "[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}"|sort|uniq -c|awk '{print $2}'|sort -nr`"

## 保留列表，删除$3及之后的所有行
#cp /root/acl443.acl $aclfile
sed -i '{/'$3'/,$d;}' $aclfile

## 最后过滤后的结果写入到aclfile
echo -e "#$3\n$DomIpList\n#$xtime" >>$aclfile;
