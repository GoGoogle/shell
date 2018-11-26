#! /bin/sh
## confirm params
# PING 4 次，取平均值res 的整数num，小于50ms的显示ok，否则显示faill。
# 用法：testip.sh ip.txt列表文件（一行一个IPV4）
if [ `echo $* | awk '{print NF}'` -eq 0 ];then
echo "please select a file!"
exit 0
fi
## confirm file path
file=$1
if [ `expr match $file '/'` -eq 0 ];then
file=`pwd`/$file
fi
if [ -e $file -a -f $file ];then
echo "begin~"
else
echo "not exists : $file"
exit 0
fi
## do ping
for line in `cat $file`
do
res=`ping -c 4 $line|grep rtt|awk '{print $4}'|awk -F "/" '{print $2}'`
num=${res%.*}
if [ $num -lt 50 ];then
echo ping \"$line\" \t\t ok $num\m\s
# 默认只显示低于50ms的ok结果，去掉下列两行注释即可得到所有结果
# else
# echo ping \"$line\" \t\t fail $num\m\s
fi
done
