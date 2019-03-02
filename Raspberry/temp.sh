
##10秒更新显示-当前时间-温度-启动时间
##/bash/bin

while : ;do clear;echo `date '+%Y-%m-%d %H:%M:%S'`&uptime&vcgencmd measure_temp; sleep 10; done;
