#!/bin/bash
## 检测当前为维护日期时，转换其它连接
## by bmwcto 2019-07-13 10:50
## 

##版本设置
ver="v0.1"

##设置各项参数

EdgePath=/usr/sbin/edge
SsPath=/usr/bin/ss-local

SsConfigPath1=/root/ssname1.json
SsLogPath1=/root/ssname1.log
SsConfigPath2=/root/ssname2.json
SsLogPath2=/root/ssname2.log

TmpCronConfPath=/root/TmpCronConfPath.conf

KillName1=edge110
KillName2=ssname
EdgeName=$Killname1
ConnectIp=10.0.0.2
ConnectName=$KillName1
ConnectPass=password
SupernodeAddr=1.1.1.1:4321
ConnectMac=fa:16:3e:66:55:77

## 需要在任务内查找并添加或删除注释的字符
NoteTxt=crontest

usage () {
        name=`basename $0`
        echo "$name $ver 使用格式说明 <bmwcto>"
        echo
        echo "./$name 维护日期"
        echo
        echo "日期格式：20190713"
        echo
        echo "例如："
        echo "./$name 20190713"
        echo
}

## 未加任何参数时输出使用帮助
shift `expr $OPTIND - 1`

if [ "x$1" = "x" ]; then
	usage
	exit
fi

_KillEdgeCtoAndss() {
	## 杀死edgeCto
	kill -9 $(ps  aux --sort=start_time | grep $KillName1 | awk '{print $2}')
	sleep 2

	## 杀死所有ssUSorJP
	kill -9 $(ps aux --sort=start_time | grep $KillName2 | awk '{print $2}')
	sleep 2
	}

## 连接edgeCto
_ConnectEdgeCto() {
	$EdgePath -d $EdgeName -a $ConnectIp -c $ConnectName -k $ConnectPass -l $SupernodeAddr -m $ConnectMac -r
	sleep 2
}

## 连接ssUSorJP1
_ConnectSS1() {
	nohup $SsPath -c $SsConfigPath1 </dev/null &>>$SsLogPath1 &
	}
	
## 连接ssUSorJP1
_ConnectSS2() {
	nohup SsPath -c $SsConfigPath2 </dev/null &>>$SsLogPath2 &
	}

_AddNote() {
## 把crontab配置写入临时文件$TmpCronConfPath，再从里面找出$NoteTxt字样的行，加上注释，再写入临时文件$TmpCronConfPath，再写入现有任务，最后删除临时文件$TmpCronConfPath
	crontab -l > $TmpCronConfPath && sed -i "s/^[^#].*$NoteTxt/#&/" $TmpCronConfPath && crontab $TmpCronConfPath && rm -f $TmpCronConfPath
	}
  
_DelNote() {
## 把crontab配置写入临时文件$TmpCronConfPath，再从里面找出$NoteTxt字样的行，去掉注释，再写入临时文件$TmpCronConfPath，再写入现有任务，最后删除临时文件$TmpCronConfPath
	crontab -l > $TmpCronConfPath && sed -i "/#.*$NoteTxt/,+0{s/^#//}" $TmpCronConfPath && crontab $TmpCronConfPath && rm -f $TmpCronConfPath
	}
	
Fixday=$1
## 维护日格式：20190713

Today=$(date +%Y%m%d)
## 取当天，以作对比

if test $[Today] -eq $[Fixday]
## if [ $Today -eq $Fixday ]
	then
	_KillEdgeCtoAndss
	_ConnectSS1
	_AddNote
else
	_KillEdgeCtoAndss
	_ConnectEdgeCto
	_ConnectSS2
	_DelNote
fi
