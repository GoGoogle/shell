##/bash/bin
##10秒更新显示-当前时间-温度-启动时间
while : ;do clear;date&uptime&vcgencmd measure_temp; sleep 10; done;
